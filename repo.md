##repo

##example usage
```shell
[I] ➜ repo s g
/home/jcaffey/bin/repo:99: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
dirty - /home/jcaffey/repos/cheat-sheets
clean - /home/jcaffey/dotfiles
clean - /home/jcaffey/repos/snippets
dirty - /home/jcaffey/repos/todo

~
[I] ➜ repo push g
/home/jcaffey/bin/repo:99: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
Enter passphrase for key '/home/jcaffey/.ssh/id_rsa':
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 772 bytes | 772.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 1 local object.
To github.com:jcaffey/cheat-sheets.git
   f21a248..ac3016a  master -> master
Enter passphrase for key '/home/jcaffey/.ssh/id_rsa':
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (9/9), 1.25 KiB | 638.00 KiB/s, done.
Total 9 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:jcaffey/todo.git
   37e6f68..ed6fff6  master -> master
cheat-sheets pushed to origin
todo pushed to origin

~ took 14s
[I] ➜ repo s g
/home/jcaffey/bin/repo:99: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
clean - /home/jcaffey/repos/cheat-sheets
clean - /home/jcaffey/dotfiles
clean - /home/jcaffey/repos/snippets
clean - /home/jcaffey/repos/todo
```
