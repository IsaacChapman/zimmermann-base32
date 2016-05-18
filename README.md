# Zimmerman Base32

_Fork of @paulstefanort's Ruby ZBase32 implementation._

zbase32 is a Base32 spec with an is an easy-to-remember and unambiguous alphabet.

## Usage

```ruby
encoder   = ZBase32.new
my_string = "I like cakes."
encoded32 = encoder.encode(my_string) # "jneaswppfdegsoppf5hhn"
encoder.decode(encoded32)             # "I like cakes."
```

## Contributing

TODO

## Developement

TODO
