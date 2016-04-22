# DHLocalizedString

This is an idea on how to implement NSLocalizedString string localization in Swift.



# Usage

Given the `Localizable.strings` file:

```
   "%1$@ loves %2$@" = "%2$@ ♥️ %1$@";
```


## Simplyfied usage (postfix notation)

```
   let personA = "Alice"
   let personB = "Bob"

   let localized = "\(personA) loves \(personB)."|~
```

results in:

```
   localized = "Bob ♥️ Alice"
```


## Extended usage (infix notation)

There are four alternatives for the infix notation:

### Empty infix

```
   let localized = "\(personA) loves \(personB)." |~ ()
```

… searches for the key "%1$@ loves %2$@" in `Localizable.strings` of `mainBundle()`.

### Specific table infix (use given table name in `mainBundle()`)

```
   let localized = "\(personA) loves \(personB)." |~ ("Flowerpower")
```

… searches for the key "%1$@ loves %2$@" in `Flowerpower.strings` of `mainBundle()`.

### Specific bundle infix (use `Localizable.strings` from given bundle)

```
   let bundle = NSBundle(identifier: "com.example.bundle")
   let localized = "\(personA) loves \(personB)." |~ (bundle)
```
… searches for the key "%1$@ loves %2$@" in `Localizable.strings` of the bundle with identifier `com.example.bundle`.

### Fully specified infix (use given table name in given bundle)

```
   let bundle = NSBundle(identifier: "com.example.bundle")
   let localized = "\(personA) loves \(personB)." |~ ("Flowerpower", bundle)
```
… searches for the key "%1$@ loves %2$@" in `Flowerpower.strings` of the bundle with identifier `com.example.bundle`.


## Functional usage

### Default call

```
let localized = DHLocalizedString("\(personA) loves \(personB).")
```

… searches for the key "%1$@ loves %2$@" in `Localizable.strings` of `mainBundle()`.

### Specific table call (use given table name in `mainBundle()`)

```
let localized = DHLocalizedString("\(personA) loves \(personB).", tableName: "Flowerpower")
```

… searches for the key "%1$@ loves %2$@" in `Flowerpower.strings` of `mainBundle()`.

### Specific bundle call (use `Localizable.strings` from given bundle)

```
let bundle = NSBundle(identifier: "com.example.bundle")
let localized = DHLocalizedString("\(personA) loves \(personB).", bundle: bundle)
```
… searches for the key "%1$@ loves %2$@" in `Localizable.strings` of the bundle with identifier `com.example.bundle`.

### Fully specified call (use given table name in given bundle)

```
let bundle = NSBundle(identifier: "com.example.bundle")
let localized = DHLocalizedString("\(personA) loves \(personB).", tableName: "Flowerpower", bundle: bundle)
```
… searches for the key "%1$@ loves %2$@" in `Flowerpower.strings` of the bundle with identifier `com.example.bundle`.



# Notes

The operator `|~` looks a bit like a flag.

In your `Localizable.strings` file, replace all interpolations with `%n$@` (including positional number!), regardless of the type of the interpolation. Do not use `%@` as part of the key. You may use positional parameters in the translated string, as shown above.

See [LICENSE](./LICENSE) for license information.
