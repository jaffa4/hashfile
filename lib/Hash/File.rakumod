use v6;
unit class Hash::File;


sub run_command(@cmd)
{
    my $run = run @cmd, :err, :out,:enc<latin1>;
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

sub run_command_linux(@cmd)
{
    my $run = run @cmd, :err, :out;
    #print(@cmd ~ "\n");

    #print("EXIT_CODE:\t" ~ $run.exitcode  ~ "\n") if $run.exitcode != 0;
    my @l = $run.out.slurp.lines;


    #$o~="\n" if ($o!~~/\n$/);
    #print("STDOUT:\t"    ~ $o ) if $o ne "\n";
    my $e = $run.err.slurp;
    my $line =  @l[0];
    if $line~~/.+')='\s+(.+)$$/ {
       return $0;
    }
    else {
        die "could not get hash result";
    }
    #$e~="\n" if ($e!~~/\n$/);
    #print("STDERR:\t"    ~ $e ) if $e ne "\n";

}


my @hashes=<MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512>;
#  CertUtil -hashfile $filename MD5
method get-hash($filename, $hash) {
    #say @hashes.gist;
    die "file does not exist" if $filename.IO !~~ :e;

    if $*VM.osname~~/mswin/
    {
        die "invlid hash value, it should be one of " ~ (join " ", @hashes) if any(@hashes) ne $hash;
        my $result = run_command(('CertUtil', '-hashfile', $filename,$hash));
        return chomp $result;
    }  # openssl dgst -md5 install.perlbrew.pl
    elsif $*VM.osname~~/linux/ {
        die "invlid hash value, it should be one of " ~ (join " ", @hashes) if any(@hashes) ne $hash;
        my $result = run_command_linux(('openssl', 'dgst', '-'~$hash.lc, $filename));


    }
    else {
        die "only Windows and Linux are supported at the moment";
    }
}


