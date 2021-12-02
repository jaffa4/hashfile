##Usage
```
my $h = Hash::File.new;<br>
my $hash =  $h.get-hash: $?FILE,"MD5";
say $hash;
```
E.g. ba65f12a64ad7979d1add21807f6830a1edbfbdc

It uses a Windows utility to calculate hashes.<br>
Supported hashes:MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512.
So it works on Windows only.

