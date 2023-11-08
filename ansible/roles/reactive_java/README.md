# Reactive Java Ansible Role - Custom

## About Java Flags `Xms` and `Xmx`

- `Xmx` flag specifies the **maximum memory** allocation pool for a Java Virtual Machine (JVM).
- `Xms` flag specifies the **initial memory** allocation pool for a Java Virtual Machine (JVM).

This means that your JVM will be *started* with `Xms` amount of memory and will be able to use a *maximum* of `Xmx` amount of memory.

For example, starting a JVM like below flags will start it with 256 MB of memory and will allow the process to use up to 2048 MB of memory:

```
java -Xms256m -Xmx2048m
```

The memory flag can also be specified in different sizes, such as kilobytes, megabytes, and so on. Examples:

```
-Xmx1024k
-Xmx512m
-Xmx8g
```

The `Xms` flag has no default value, and `Xmx` typically has a default value of 256 MB. A common use for these flags is when you encounter a `java.lang.OutOfMemoryError`.

When using these settings, keep in mind that these settings are for the JVM's heap, and that the JVM *can and will use more memory* than just the size allocated to the heap.

---