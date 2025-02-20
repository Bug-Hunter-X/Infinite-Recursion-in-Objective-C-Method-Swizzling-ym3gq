A safer approach involves using a flag to track whether the methods have already been swizzled:

```objectivec
static BOOL methodsSwizzled = NO;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ 
        if (!methodsSwizzled) { 
            Class class = [MyClass class];
            Method originalMethodA = class_getInstanceMethod(class, @selector(methodA));
            Method swizzledMethodA = class_getInstanceMethod(class, @selector(mySwizzledMethodA));
            method_exchangeImplementations(originalMethodA, swizzledMethodA);

            Method originalMethodB = class_getInstanceMethod(class, @selector(methodB));
            Method swizzledMethodB = class_getInstanceMethod(class, @selector(mySwizzledMethodB));
            method_exchangeImplementations(originalMethodB, swizzledMethodB);
            methodsSwizzled = YES;
        } 
    });
}
```

This ensures that the swizzling only happens once, preventing the infinite recursion.  The `dispatch_once` ensures thread safety.

Using `dispatch_once` is crucial for ensuring that the swizzling only happens once, even in multi-threaded environments.  This prevents potential race conditions and inconsistent behavior.