# Zimmerman Base32

[![Build
Status](https://travis-ci.org/jamesdphillips/mailgat.svg)](https://travis-ci.org/jamesdphillips/zimmermann-base32)
[![Coverage
Status](https://coveralls.io/repos/jamesdphillips/mailgat/badge.png?branch=master)](https://coveralls.io/r/jamesdphillips/zimmermann-base32?branch=master)

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
