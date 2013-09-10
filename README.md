Snowsafe
========

**Current Status: Pre-Alpha, Under Development**

This is a library for securely managing passwords and other sensitive information.

The goal is for this to become the foundational layer for a 1Password replacement.

About the cryptography
----------------------

This library is founded on the following cryptographic design goals:

* Use widely-accepted strong encryption algorithms. OpenSSL AES-256
* Encrypted files should be easily recoverable or modifiable with openssl console commands and a text editor
* Structured data must be editable by both machines and humans
* Keep 100% of all entries encrypted (unlike 1Password)
* Support for file attachments
* Alternative implementations should be easy to build
* Command-line interface for encryption and decryption
* User-specific extensions to the database be allowed everywhere
* Support for arbitrarily-nested safes

When I feel the design is settling, I'll explain in detail how the encryption
works so that everyone can understand the value of this utility.

License
-------

The MIT License (MIT)

Copyright (c) 2013 Jay Phillips

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
