#!/usr/bin/perl -w
#
#  Test that the POD we include in our scripts is valid, via the external
# podcheck command.
#
# Steve
# --
# $Id: pod-check.t,v 1.5 2006-06-13 13:26:01 steve Exp $
#

use strict;
use Test::More qw( no_plan );

foreach my $file ( glob( "bin/*-*" ) )
{
    ok( -e $file, "$file" );
    ok( -x $file, " File is executable: $file" );
    ok( ! -d $file, " File is not a directory: $file" );

    if ( ( -x $file ) && ( ! -d $file ) )
    {
        #
        #  Execute the command giving STDERR to STDOUT where we
        # can capture it.
        #
        my $cmd           = "podchecker $file";
        my $output = `$cmd 2>&1`;
        chomp( $output );

        is( $output, "$file pod syntax OK.", " File has correct POD syntax: $file" );
    }
}

