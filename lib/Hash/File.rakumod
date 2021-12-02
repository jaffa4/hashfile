use v6;
unit class Hash::File;


sub run_command(@cmd)
{
    my $run = run @cmd, :err, :out;
    #print(@cmd ~ "\n");

    #print("EXIT_CODE:\t" ~ $run.exitcode  ~ "\n") if $run.exitcode != 0;
    my @l = $run.out.slurp.lines;


    #$o~="\n" if ($o!~~/\n$/);
    #print("STDOUT:\t"    ~ $o ) if $o ne "\n";
    my $e = $run.err.slurp;
    return @l[1];
    #$e~="\n" if ($e!~~/\n$/);
    #print("STDERR:\t"    ~ $e ) if $e ne "\n";

}


my @hashes=<MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512>;
#  CertUtil -hashfile $filename MD5
method get-hash($filename, $hash) {
    #say @hashes.gist;
    if $*VM.osname~~/mswin/
    {
        die "invlid hash value, it should be one of " ~ (join " ", @hashes) if any(@hashes) ne $hash;
        my $result = run_command(('CertUtil', '-hashfile', $filename));
        return chomp $result;
    }
    else {
        die "only Windows is supported at the moment";
    }
}


