# MRI vs jRuby in Concurrent Processing
A test program to compare concurrent processing in MRI and jRuby

jRuby
-----

JRuby is a version of Ruby implemented on top of the Java Virtual Machine (JVM). An example of a compelling JRuby use case are CPU-intensive problems we usually solve with threads in MRI (C Ruby). When switched to JRuby and used Java’s java.util.concurrent.Executors, we are able to get significant performance improvement. 

JRuby removes the GIL that CRuby has, allowing us to execute truly concurrent code. In JRuby, Ruby threads map to Java threads, which then usually map to OS level threads, so performance is usually guaranteed to be higher.

A test program for Benchmarking cRuby and jRuby performance
-----------------------------------------------------------

This program takes the Unix system’s words list (`/usr/share/dict/words`) and loads it into an array. It also loads a list of 10000 words of Lorem Ipsum into another array. After that it breaks the word list into batches, passes each batch into a thread, and then sees how many words from Lorem Ipsum are actual dictionary words.

Run the program with differnt batch sizes (200, 2000 etc - less the batch size, more the number of Threads started) and see the time taken printed by the program. You can observe that jRUby is faster than cRuby as the Global Interpreter Lock(GIL) of the C Ruby prevents multiple threads from running truely concurrently.

How to run the program
----------------------

1. Switch to C Ruby.

```
  rbenv local 2.5.1
```

2. Execute the program

```
ruby test_file.rb 2000 (batch-size)
```

3. Switch to jRuby

```
  rbenv local jruby-9.2.0.0
```

4. Execute the program

```
ruby test_file.rb 2000 (batch-size)
```

Output on my MacBook Air
------------------------

