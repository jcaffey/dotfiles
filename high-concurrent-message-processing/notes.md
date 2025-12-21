- ACID compliance

- MATT WANTS MULTIPLE QUEUES - this will directly effect how we build the replacement scaling system

- What did WhatsApp use for a queue? Kafka probably?

- Lets get stats information from postgres to understand our bottlenecks there - what tables are heavy read / heavy write?

- Get stats on read replicas because i think theyre mostly just costing us money as i dont see any use of the connection strings unless they are in lambda somewhere.

- What are our biggest tables? How will they grow and can we move that data to nosql or clickhouse or something? This could save us from sharding

- ask AI how to scale based on the data and what tools would work better for our use case

- how does aurora fail overs work?

- how do i make a backup?

- how do i restore a backup?

- consider FreeBSD for handling high concurrency - very cool!
    Recommendation: Stick with Linux, Optimize There
    Linux is perfectly capable for your workload—BEAM's lightweight processes already hide I/O latency beautifully (thousands of concurrent jobs waiting on DB/API without blocking).
    Focus on:

    Using Broadway for SQS (as discussed).
    Connection pooling (DBConnection for Ecto, Finch/Hackney pools for HTTP).
    Horizontal scaling (multiple Linux nodes).
    Tuning Linux sysctls if needed (e.g., net.core.somaxconn, fs.file-max).

    If you're curious, benchmark your exact workload on both (e.g., via AWS FreeBSD vs Ubuntu instances), but the effort likely isn't worth it for marginal (if any) gains in your I/O-bound scenario.
    Linux will get you to high throughput faster and with less friction! If your app evolves to extreme pure-networking (e.g., proxy/CDN), revisit FreeBSD then.

- update ai response with additional information on bottleneck ... waiting on the database.

- we need to know what information is being used by each part of the system. For instance, if a lambda only needs a small subset of data (ideally it doesnt touch the db) what can we do to improve performance? Can that data be replicated to a nosql database, cache, or something else where we can get it faster?


Product Questions:
1. If a message is being sent through our API, but the system goes down, does it matter? When the system comes back online, should the in-flight messages be retried?
2. If we attempt to send through a provider and it fails, do we retry and backoff over some time period before giving up?
3. How many messages do we want to be able to concurrently send at our peak load 5 years from now? 50k? 100k? 1M+? 1B+?
4. 


- [ ] what information are we querying from the database and can we remove a call completely
- [ ] how can we get the information from the queue as fast as possible - we need to weigh this against features like supporting retries, etc...
otherwise we just usea a cache and if the cache dies the data is gone.
- [ ] our lambas are doing a lot of sitting around waiting on HTTP requests to external systems we can't control
- [ ] lambdas have a concurrency limit, but even just a single core can have thousands of lightweight threads






Cody (01:36:06):
I think there's a I personally have an ulterior motive for ground, which is that I I think I'd mentioned it in the in the doc in the write up, but uh we have some like background workers that will not scale beyond a certain point. that are written in Python. Uh when I so and when I joined, uh a lot of the a lot more percentage wise of the Lambdas were written in Java uh because the thought by previously was we should catch bugs at compile time and we should try not to crash. And I came in and as as much as possible dictated the opposite, we should be able to crash any of these at any time and Josh has heard me talk about uh Joe Armstrong too much, but this is sort of influenced by this is how how that early ecosystem works for a lot of telecon companies starting to use this this method. But my mine wasn't so much around reliability, although we've gotten some of that that we really haven't deserved in a sense. Yeah. Um the my real motive was I want to be able to ship to production and not even have to care if the builds broken because it's not going to cause an outage. So that is uh I will say it's tough to get our current team comfortable with the idea of this part of the code should be able to crash at any time and we shouldn't worry so much about crashing.

Taylor (01:37:33):



Cody (01:39:03):

And I think at the time when um like the the two areas where this has been most impactful. We still kind of this is still just by default. Uh it's still the way things are done is on the messaging and the callback side. callback just being like messaging web books essentially that we get. Um because these are all asynchronous and you know, the messages are in a queue and as like not the text messages, but the requests to do things. Right, right, right. are in a queue somewhere. Yeah. And as long as we haven't and we're using Postc so we have, you know, it's acid compliant. As long as we haven't committed anything and we haven't done any third party services that it doesn't really matter. Um like we're not we're not going to lose that integrity, right?


- OUR MOST CRITICAL BOTTLENECK AND SCALING ISSUE

Okay. Yeah, exactly. Yeah. Um I think that's, you know, and that that served its purpose there. I think the the sort of innovation so to speak and I'm not even using it in a positive sense, but it's just the the way it is is that that is not like idiomatic Python. You know, we have a lot of Python that is more or less like as optimized as we possibly can in some areas. Um and it's non-idiomatic and this is just not the way you do things in that ecosystem, but we have. Um but anyway, I would like to, I personally would like as soon as possible to move these highest volume, highest volume in terms of usage, uh like there's essentially pipelines, right? There's essentially different like pipelines that have different branches within them. Yeah. moving those to being built on grounds specifically on the factory, you know, on the on the async side of that and running on professional servers. And I have a cost effectiveness motivation for that, but also I want to be able to spin up a larger cluster and have more workers when we need to and scale. We can't do that with. And but beyond a certain point.

Taylor (01:41:10):
Tell me about that because I don't I I haven't used lambda in earnest, um, and I was surprised to read that like that there's a hard limit because my vision is like that's the reason you use Lambda is for horizontal scalability, right? Like 10X, fine, 10X your lambda calls. Like what's the problem, right? So let's let's talk about those limits a little bit.

Cody (01:41:36):
So the only there are various limits you can you can just have raised, right? You can have raise the limit on your account. The one that can't be raised is a specific lambda, um the number of concurrent invocations running at any or, you know, concurrent processes running at any one time for a specific land in a specific region. Um Really? Yeah, so the max limit is 1250. Yeah. And we have one in particular which is webhooks. We we forward webhooks, which is not really shown in the diagram too well, but it's it is something we do and it's we will ingest these So you send one text message, you get two callback webhooks back. We have our customers who have register an arbitrary number of webhook URLs and so we're sending So you know, one to So it's yeah.

Taylor (01:42:24):
Yeah.

Cody (01:42:24):
Exactly.

Taylor (01:42:25):
Yeah. So we need to be able to have a bunch of a bunch of like threads sitting idle essentially while we're waiting for those requests to complete. And this is also why Lamb is not a great fit for it because I prefer to just

Josh (01:42:37):
Oh, because those connections are kept open while you're sending the webhook. Is that what you mean?

Cody (01:42:41):
Yeah, yeah, until we get a success or you know, respond or we time out. Right. We only attempt attempt once. Okay. Which is you know.

Josh (01:42:50):
So that doesn't go into another queue, but like, yeah, so if somebody's webhook receiver is slow and takes 10 seconds, like y'all are waiting 10 seconds for that to complete.

Cody (01:43:00):
Yeah. Right, exactly. And so the way that we've ended up scaling that is essentially chopping up the webhook forwarding part into, you know, this smallest component parts we we can and so there's for example a Lambda that all all it does is send HTTP requests, you know, as many as possible per process and etcetera, right? So that kind of that's the sort of optimization I'm talking about where it's like the whole part is probably slower to do, but the individual parts are faster. And so because the because of the limitations of Lambda, that turns out to be the, you know, that turns out to be the most optimized way to do it. Um we saw this in practice. This isn't doesn't been an issue recently because of that change, but in practice, um we did see, you know, this queue was was backing up and getting these in a fairly timely manner is important for some use cases. Yeah. And so we just can't really allow that. and also if we get to the point where it's backing up and then it's just continuing to back up and that's just a that's a catastrophic problem, right? Like you can't keep up with that queue.

Josh (01:44:07):
Yeah.

Cody (01:44:08):
So this is like the this is that thing. I can sleep at night, but you know, if you told me we were going to 10x tomorrow or you know, we closed someone huge, then I would be thinking, okay, is this actually going to scale or is this going to cause a huge problem for us?

Taylor (01:44:20):
Yeah.

Josh (01:44:20):
But if yeah, like so you yeah, you have this IO throughput problem and I in my naive thought, Lambda is really good at like, well, let's just throw more servers at the let's just throw more function calls at the problem. I didn't realize that there was a 1250 hard limit on that stuff and like that's just not that many. And especially if you're talking about something like sending webhooks, I mean if you were on some sort of any other async framework, you could, I mean, a single CPU could could be waiting on 100,000 of those, a million of those, no problem waiting to come back, right? Um, that's interesting. But but if I, if I think about, and again, I have never, I've never built a like this distributed of a system before. Um, but if my primitive was a function call on a lambda and that's the primitive you you keep having to throw it everything, then like, yeah, a single webhook call is another instance of that primitive, a single like every individual thing, it it does change, it kind of changes the economics of scaling a little bit.

Cody (01:45:41):
Yeah, I I think actually, uh, Lambda scales pretty poorly for our use case for this because there's like there's minimums, you know, for Yeah. um so we end up having to do things like uh for example, we're sending those web hooks, we're putting that at as little RAM as possible, which is 128 megs, which is fine. Sure. We can fit maybe 32, I think 32 threads in one of those at a time that are open. But the trouble is because of it's just a particularity of lambda, in reality you only get half of VCPU, so like half of a half of a hyper thread to actually do that and you're paying, you know, whatever you're paying. Wow. And so if you to get more this is this is not really CPU bound, it's IO bound obviously, but it still matters. Totally. Um so that's yeah, I just said for these very high scale things, uh it also becomes you know, it's we're constrained there. I guess is is my biggest problem. And these are areas where we don't want to be constrained.

Taylor (01:46:47):
Yeah. What let's imagine just for the sake of argument, this will kind of help me understand where your head's at. Um, you know, like your pie in the sky beautiful architecture. Let's say that the only problem that we were trying to solve was I want to be able to send 10 million webhooks at scale, right? Um, that's that's literally it. It's just the webhook problem to constrain it. So we're going to replace it. We're not going to use lambda, right? And we need to be able to send, send these webhooks and know if they succeeded and we'll have, we'll have a timeout. Let's say we give everybody 10 seconds or 30 seconds I guess just to make our problem a little bit harder to respond. and we'll keep the other constraint that like we're not we're not going to retry. It's a one and done. But the scale is 1,000 times greater than it is today, right? So land is an arm starter. What um, so you need to build a service that's pulling those web hooks off the queue and firing them off as fast as possible without our cost being 1,000 times either, right? So like what what would y'all what would what would y'all reach for to build that?

Josh (01:48:02):
Well, that's that's why we were thinking reserved instances.


And what is what's currently putting these uh webhook jobs? Are these webhook jobs they're being put on SQS and then SQS is being handled by Lambda today, right? And so what's currently putting those jobs on SQS? Is it another Python script?

Cody (01:51:34):
Yes. So the way it looks is uh we're we're receiving web or, you know, weapon calls from CAS. We have a just like a a really simple lambda that's taking that dump get an SQS queue. Yep. We we need to do a lot more than send webhooks with that information. So the there's a part of that that's actually handling those payloads and then doing something with them. One of the first things we do is push to another queue, which is sort of pushing it down the line. Yep. Um and then that process is going to do some other things like actually update the status in our database and all that. Yeah. Um and there, you know, the the the lambda that is handling these API calls is not throttled, but the one that is uh actually touching our database and pushing things downstream is throttled. Mhm. So that's kind of the thought there.

Taylor (01:52:27):
So then you've got you've got this receiver uh because you got the C pass making an API call to y'all. That gets handled by a lambda. That lambda takes it and puts like, hey, I just got a webhook. That puts it on the queue. Then something else is immediately listening to that queue. Is um and at least one of the listeners is putting something onto the database to be like, hey, we got noticed that this succeeded or something.

Cody (01:52:53):
Yeah.

Taylor (01:52:54):
And then and then there's and then is that same thing putting it is there is it getting put on another queue that's like and now it's time to tell it's time to tell our customer it's time to make those webhook calls.

Cody (01:53:07):
Yeah.

Taylor (01:53:07):
Okay.

Cody (01:53:08):
Yeah.

Taylor (01:53:09):
And so does it put a is it putting, let's say you have 10 webhook calls to make. Is it putting 10 things onto the queue or is it putting one thing and then something else goes and looks up and like, does that have to talk to the database and be like, what what what what hooks do we need to call?

Cody (01:53:24):
So it's it's pushing the actual payload object you get from the seapass onto the queue and then our webhook. I think it's called the web forwarder in our in our sack. It is then um it's either reading from the database or in the like ideal case it's reading from Reddis because we've cached this that has actually the database to get the actual URLs we're sending to. Okay for a particular So we we have to take, you know, the data we get from from the the CPAS and we have to turn that into, yeah, here's the actual organization belongs to and etcetera, etcetera.

Taylor (01:53:55):
Yeah, so you're doing this lookup like here's the org that belongs to, here's the URLs.

Cody (01:54:00):
Right, exactly. And so I would say I mean, I haven't looked at the elastic cache metrics recently, but we would like this to be, you know, as close to as close to zero cash misses as possible since it's so high volume. And it's pretty close to that. I believe that. in practice. Cool. It's also been a source of cash validation bugs in the past. that's just is, you know, that's the nature of it. But because we're also distributed, our our code base is distributed, that also becomes tough to to test and so.

Taylor (01:54:31):
Tell me more about that real quick.

Cody (01:54:33):
Well, we have uh we have the ability to register web book URLs. So actually the web basically there are a number of different event types that we send web hooks for. Yeah. I think there's five that we that we send. Um and we can you can apply those on the basis of a single we we call them accounts in our system. It's a phone number you would be sending from or an organization, which is one of our customer representations. Yep. And you can apply them on either level, but we actually cash at the level of for a single phone number for this event type. here are the web URLs involved. and so that's what the that's what our web Porter is going and looking up. And we will um we'll cash that, I believe we're caching at the first time we send a message to that um the first time we send a webhook, you know, event to one of those URLs, we'll cash that value for that particular set of circumstances. Mhm. But then you just can go in and add or delete your web.

Taylor (01:55:33):
So you need to invalidate the cash. Yeah.

Cody (01:55:35):
Right, exactly. Um, and we just, we we had uh, we actually not that long ago solved a an issue in this where we were invalidating the cash in a in a co routine in go and we were committing the transaction in the main thread and uh, some sort of I don't I think it was was it only under load or was it always I can't remember. was it only under load or under some circumstances what there was there was not we were invalidating but then the next messages were going out and it was setting the cache again. It was just pulling the the stale values. Yeah transaction haven't been committed.

Taylor (01:56:13):
Got it.

Cody (01:56:13):
So that's a that's an example of where this um That's helpful. Yeah. I think rate limits are another one where we have had similar types of problems in the past where they're not set, you know, they're set up front but they can change, you know, that kind of thing. Okay. Um, cool. So going back to our scenario, you you've gotten the webhook, you've written to the database. Um, and it's uh, is it a lambda that's writing to the database that says, hey, we got this webhook and it's a lambda is it the same lambda or another lambda, I guess that's like, and now it's time to send webhooks. Is that right? out to our customers.

Cody (01:57:21):
It's a different. Well, I think it's the so we're we're going to dump every payload we get onto the webhook queue and so we have a downstream like lambda that's actually going to decide do we need to do anything with this.

Taylor (01:57:32):
Got it. Okay.

Cody (01:57:33):
Um so it's the same the lambda that's actually, you know, writing to the database is only pushing to that queue. It doesn't know what you're going to do anything with.

Taylor (01:57:43):
Right, okay, cool. So then you've got another one then that's like, hey, if anything's in this queue, it's been written in the database, it's time to tell our customers about it, right? And then it looks at it and now it's going to do whatever lookups it needs to do, ideally as cached as possible that's like, do I need to tell anybody about this? Do we care, right? Right. And it might be told, yep, you got to tell 10 URLs about this, right? Okay. So then those 10 URLs are all 10 of those going to be handled by by that process or is it going to, is it going to fan out again to like 10 more things on a queue somewhere?

Cody (01:58:17):
No, it's it's faning out again. So then we're figuring out what we know, the actual we we do the transformation there to whatever Like this is the payload, this is the URL.

Taylor (01:58:26):
Yep.

Cody (01:58:27):
Exactly. Yeah. and then we we push that a message onto an SQS queue and then we have another process that's pulling a batch of those Yeah. and you know, sending those concurrently.

Taylor (01:58:37):
And then that other that other process that's pulling those concurrently, that's that's a lambda because

Cody (01:58:43):
Yes.

Taylor (01:58:43):
Right. And then but you and it sounds like, oh, so there is some concurrency on that lambda.

Cody (01:58:49):
Yeah, yeah. So we're Oh cool. Okay. Um I mean it's it's a it's a single um single process. We just have a a thread pool of I I think it I want to say it's 32 threads, but it might be smaller. We might have that might not have been right. But yeah, we're pulling in however many number of messages from the queue at once. Yeah. and then

Taylor (01:59:07):
And is each thread able to handle one outgoing HTTP request or multiple?

Cody (01:59:12):
Uh, just one.

Taylor (01:59:14):
Yeah. Okay, got it. I see. So you've okay. Yeah, so it's not an async process. It's a like it's a it's a multi-threaded process. Each thread makes the call and then waits, right? Right. And then, um, so let's so that process is able to like essentially, let's say pull them in batches of 32 off, as soon as one of those threads is done, does it go back to the queue or is that is is Lambda again, betraying my ignorance of Lambda like once that lambda pulled its batch of 32, is that lambda kind of going to sleep until it gets woken up again by something else being on the queue?

Cody (01:59:57):
Uh, yes, that function's not going to continue running.
<!-- ===== FILE BOUNDARY: transcription_part_3.md ===== -->
Taylor (02:00:00):
sleep until all of those.

Cody (02:00:02):
All of those are done. Yeah, that's part of why we have so many because we have that this spike in latency there from the from our customer servers and so it becomes more efficient that way.

Taylor (02:00:12):
Yeah.

Cody (02:00:13):
Um But yeah, and then we'll have a number of you know, that's one lambda but we'll have have many concurrent invitations of that actually sitting at once.

Taylor (02:00:22):
Yeah.

Cody (02:00:23):
uh, I don't know in practice how many this, probably a few hundred.

Taylor (02:00:26):
Right, that makes sense. So just to make sure like, um if we have if we have our queue here and we've got this one particular item that has like 10 outgoing. Or that's a no, there's a pay there's a payload. Each of the separate URLs is its own payload? Is that right?

Cody (02:00:45):
Uh, no, each each like uh, each payload that we receive from the CPAS becomes one of these one of these events on the queue.

Taylor (02:00:53):
Right. But then eventually once it gets turned to like, I've looked it up, I know that I am going to need to send 10 10 outgoing.

Cody (02:01:00):
Yeah.

Taylor (02:01:01):
So that's that's a single item on this queue that says that there here's 10 URLs or is it 10 separate items on the It's 10 separate items.

Cody (02:01:08):
Okay, got it.

Taylor (02:01:09):
Okay, cool. So then, so I've got this queue and this is like each of these is a single outgoing webhook, right?

Cody (02:01:17):
Right.

Taylor (02:01:18):
Okay. And so then I've got this, these lambdas here and it is going to wake up and it's going to grab as many it's going to be like, oh there's something on the queue. I'm allowed to grab up to 32, right?

Cody (02:01:38):
Yeah.

Taylor (02:01:39):
And so it's going to grab 32 of these at once, right?

Cody (02:01:47):
Right.

Taylor (02:01:48):
Okay. And then, and this like it can be a beast of a machine, but then it's going to sit there and it's going to say, okay, I've got 32 threads that I have access to. So each of these um each of these threads is going to go out and make a call, make an HTTP call to the customer, right?

Cody (02:02:17):
Yeah.

Taylor (02:02:19):
And then it's just going to wait, right? And so and then like it waits until all of these have timed out or are done, right?

Cody (02:02:29):
Yeah.

Taylor (02:02:30):
So they could have every one of these could respond immediately, but and this could be and this is of course going to stand across multiple customers, right? Because you're not going to come in blocks of 32. So if you had one problem problematic customer that always took 30 seconds to respond, then if if he ever gets in the in this mix, then this lambda is going to be essentially sleep for 30 seconds, right?

Cody (02:02:59):
Yeah.

Taylor (02:03:00):
Okay. And so then you need as many of these servers as you can afford to like as they allow you to spin up. Um but most of their time kind of by definition then is waiting, right?

Cody (02:03:17):
Yeah, for sure.

Taylor (02:03:18):
They're not, they're not memory constrained, they're not CPU bound. They're not even, I guess they're IO bound in the sense that they're waiting on an HTTP request. Um.

Cody (02:03:27):
Yeah, but they're just idle probably.

Taylor (02:03:28):
Yeah. But that's I guess well that's the part where the where that part of the pipeline breaks down. Is it um I don't know what the semantics of like of of lambdas with SQS are. Is a lambda allowed to go back to the queue and be like, hey, I've got some I'm, you know, I like I've got I've got some headroom. Can I have anything else from the queue or does it need to is it like an item on the queue begets a lambda call? Does that make sense?

Cody (02:04:01):
Uh it's on the way that we have it, we have it, we have it trigger set up. So it's only for a particular invocation of the lambda so like a particular like virtual process running. It is only going to pick up one of these items once that function is finished, but it will do so um only when there's something on the queue. Now, it will I think in pra I think in reality what is happening is that it's polling the queue and it's waiting some amount of time because one thing that will happen is you'll have I don't remember the term they use for it, but essentially we pulled and there was nothing on the queue, right? You'll see this in in our metrics that this will happen when there's a lot of invocations standing up and we've we've went through the whole queue.

Taylor (02:04:45):
Yeah.

Cody (02:04:45):
So I think in practice it's just polling that queue um once it's finished with, you know, the function.

Taylor (02:04:54):
Like the same lambda is?

Cody (02:04:56):
Right, the same lambda.

Taylor (02:04:57):
So yeah, well like the same I guess the same yeah, the same instance, right? But it would it would probably it sounds like it's probably going to wait until like for some sort of, did I complete my work threshold and then it's going to come back, right? It's not but if you were to write a loop on, you know, like let's say this lambda got woken up and I were to change the job of this guy and it's its job was to basically wake up and start fetching things from the queue as fast as it could. Are you allowed to do that with a lambda? Like I don't know, I don't know how much is fed to you as a with a lambda versus like pushed to you versus how much you're allowed to like pull yourself. Like can you write code that's like, I know my, I know my SQS is this. Is there anything else there because I have head room now?

Cody (02:05:51):
We could do that.

Josh (02:05:52):
Oh Martin. Yeah.

Cody (02:05:54):
Yeah, we could do that. We would have to, so right now we're sort of getting this triggering out of the box with our cloud formation setup, the way we have it configured. In this in this case, I think we would have to actually, you know, go and write the polling logic ourself that we could do.

Taylor (02:06:08):
Yeah, yeah, I just so it's but it's not it's not the common way of doing it, right?

Cody (02:06:13):
Right.

Taylor (02:06:14):
Okay, cool. So yeah, and you're limited then to 1250 of these, right? So, um, which really isn't very many because 1250 * 32, you know, if you had a particularly problematic customer that who only one and every 32 of their web hooks took 30 seconds, they would bring you down, right? Um, because all of your lambdas would essentially just be waiting for that one URL to finish before they could do their next batch, right?

Cody (02:06:47):
Yeah.

====================================================================================================
====================================================================================================

Taylor (02:06:47):
So, um yeah, so this is a good example of of where this particular part is falling down. If we only wanted to solve this one problem um for you to sleep better at night, then we're back to the like, well yeah, let's just spin up a server, right? And so now let's say we spun up a server. Um and that server could um could make literally as many as a sync HTTP calls as it could possibly handle, right? I mean that you'd be running into like probably server connection limits that would be measured in the like tens or hundreds of thousands, but not, you wouldn't be running in any other limits, right?

====================================================================================================
====================================================================================================

Cody (02:07:30):
Yeah.

Taylor (02:07:31):
Um and then with the with the semantics of SQS, like when you take something off of the queue, you do like let's say you took 10,000 things off the queue and then crashed. Um those things aren't gone forever until you tell SQS like, hey, I handled this. I don't know what the semantics are.


Taylor (02:07:31):
Um and then with the with the semantics of SQS, like when you take something off of the queue, you do like let's say you took 10,000 things off the queue and then crashed. Um those things aren't gone forever until you tell SQS like, hey, I handled this. I don't know what the semantics are.

Cody (02:07:50):
There's a visibility time. So um if if the lambda function crashes then those get pushed back onto the queue.

Taylor (02:07:58):
Okay, cool. So there's retry semantics and all that. Okay, sweet. All right. Um yeah, I mean this is this is an example like if you would happen to have a monolith and your primitive was not lambdas to take stuff off of a queue, um it makes sense given that your primitive is a lambda and they make it really easy to be like call a lambda when there's something on the queue. It makes sense that you would end up with this particular thing. Um If you had if you happen to have a monolith and that monolith was uh we didn't have a monolith. If you just had a a processor whose job was to watch certain ones of these cues, and it was just a worker process, then you could probably handle all of your webhooks with like, I mean almost nothing, right? I would think. Am I over simplifying?

Cody (02:08:51):
No, I think so.

Taylor (02:08:52):
I I think I think you could. I think like I mean I'm just thinking in terms of um you know, like the default, the default barebones uh you know, benchmark that every web server handling incoming requests and responses, like the default one that like, you know, when Node came out and they were like, we're going to brag because on a single thread we can handle this many requests per second, right? It's just take the request in, put the put the hello world back on the queue and you know, and send it out over HTTP and they handle, you know, like 10,000, 100,000 like per second, no problem. And this is essentially that, right? But um so yeah, like you're not, you're generally not CPU constrained. Um so yeah, my guess and I don't know what you end up paying I don't know how lambdas are priced. I mean it's like it's memory per second essentially, right?

Cody (02:09:59):
definitely save money by getting rid of that.

Taylor (02:10:02):
Um and then it kind of makes me wonder and you could still have redundancy and you could, you know, you could have five of those worker processes and each one would like have five 512 megs of RAM and would cost you 50 bucks a month or whatever and like, you know, and it would all day every day and you're like, hey, we got 10 times the web books and you're like, okay, you know, like not more servers. If you if if one of your primitives that you'all were reaching for was something like that where it's like, here's a box whose job is to handle that queue rather than here's a function whose job is to handle that queue, then my guess is you would start to put more more things in that box. That would be my guess. Like that that's you would you would have a you'd be like, oh cool, well we did we we we'll start with the web hook service or we'll start with whatever we think is not scaling. We'll make it start to handle that queue. Hey, here's another queue where where we find our lambdas waiting a lot. Let's put that in, you know, in that same box or in a you know, maybe it's a different box. I don't know. And then my guess is that you would see my guess is that you would you would start to be able to um wrap your head around it a little bit easier and not have it be quite so distributed and not end up like you would you would end up not caring as much about latency, right? You would end up not caring so much about cuz it's a shame that you're paying money to wait on somebody's HTTP request, right? Like that's that's sad, you know?

Cody (02:11:46):
Right. That's how I feel about it.

Taylor (02:11:47):
Yeah. Um yeah, um and especially when it's not like you'all are trying to like and that computer is just yeah, that lamb is going to twittle its thumbs, right?

Cody (02:11:59):
Yeah, yeah. And that's part of why, you know, we do, you know, we keep them as thin as possible, right? Cuz it's just we're paying for idle time.

Taylor (02:12:07):
Right. Right. Um and if you're if you're talking to your own systems, you can control the latency, but if you're talking with somebody else, that's where it. So maybe it makes sense to find, you know, I don't know if you have other systems, you think that are spending most of their time waiting on something whether it's in your control or not? Or do you think that most of these are like most of their invocation time, do you think is like spent doing work? If I'm just thinking about all your lambdas for a second.

Cody (02:12:38):
This this is this has got to be the the most idle one we have I think. The uh we have they're called senders in our codebase but their land is the job is to send, you know, messages to the to the CPAS messaging APIs. And they are they're not they're not a single uh like single purpose like this, you know, that we don't really follow um there's no single responsibility principle when it comes to that because they're doing some other things like just before we're sending making sure that the the person didn't opt out at the last second, things like that.

Taylor (02:13:12):
Yeah.

Cody (02:13:13):
Um but there's been a

Taylor (02:13:14):
Like it came on the queue, then they opted out and now we're about to fire it off.

Cody (02:13:18):
Right, exactly. So we're doing things to minimize that as much as possible. Yeah. Um but there's, you know, they're probably spending again we're if we see 100 millisecond latency for each one of those calls and I don't know everything else is 100 milliseconds that's over half the time.

Taylor (02:13:33):
Yeah. Yeah.

Cody (02:13:35):
That's that's possible. I actually don't know what the real numbers are.

Taylor (02:13:38):
Yeah. I mean if you were in even if you were still in Python but your everything was just written with async IO, then and I don't know how rust I don't know what the primitives are in rust as far as like, you know, how much of it is async versus how much of it is threaded, like in terms of what you would implement this in. Let's say it was implemented just in Python to keep it because it's already implemented in Python, right?

Cody (02:14:03):
Yeah.

Taylor (02:14:04):
Um Yeah, like if it was in even if it was just an async IO then you're just it it doesn't care anymore about threads, it just cares about the async Q, right?

Cody (02:14:18):
So we are doing that now for our senders in Python. I think they're just a event loops. Yeah. The some of the senders, this is where Java comes in, some of the senders are written in Java and uh I'll be the first to say that I'm by no means great at writing Java. Um I'm sure there's, you know, there's people out there but they're not on our team. So that's the that's part of the challenge with it. You haven't I don't think you might be good at writing Java.

Taylor (02:14:40):
I haven't ever been good at writing Java.

Cody (02:14:41):
I haven't written Java. Yeah, I don't want to.

Taylor (02:14:43):
So you you say some of the senders, so is that based on which CPAS you're talking to? What what what determines whether it's written in Java or not?

==============================================================================
==============================================================================

Cody (02:14:52):
So nothing written today, nothing new today is written in Java. Um I joined like when I joined the company it was right after we're on bandwidth at the time, we're moving to Tel next another provider. Yeah. Um the the work on Telx was nearing completion when I, well, the work on the Telx messaging side of this sender was near completion when I joined. After that, I don't think we wrote anything new in Java on the messaging side because I really took over ownership of messaging and um the motivation originally like I said was the compiled language, all that. I would never choose that. So um, we just abandoned it from there. Sure. Uh but you know, also haven't just gone back and stripped out the service cuz it's in the hottest of the hot paths and it it works, you know. So it's just had it's basically been in more or less the same state for the last four years, three well not that long, three years, but that's um specifically for you know, the oldest provider or the providers who have been integrated with the longest. Um so we are, we're integrated with five providers, two of them bandwidth and Telx, the code for them in Java. Our Twilio connection is in Python and then all the other new ones are in Python.

==============================================================================
==============================================================================

Taylor (02:16:12):
Okay.
