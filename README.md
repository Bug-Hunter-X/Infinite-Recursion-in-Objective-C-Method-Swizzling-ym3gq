# Objective-C Method Swizzling Pitfall: Infinite Recursion

This repository demonstrates a potential issue when performing method swizzling in Objective-C.  Improper ordering of swizzling operations can lead to infinite recursion, resulting in application crashes.  The example highlights the problem and provides a solution to avoid this common pitfall.

## Problem

Method swizzling, while powerful, requires careful consideration of the order in which methods are exchanged.  If method A is swizzled with method B, and then method B is subsequently swizzled with method A, without proper checks, an infinite loop can occur.

## Solution

The solution involves carefully managing the swizzling process.  We can use a flag to ensure that each method is only swizzled once, preventing the circular dependency and infinite recursion.