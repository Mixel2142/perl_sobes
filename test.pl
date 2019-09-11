#!/usr/bin/perl

use Email::Valid;

# Проверили кол-во аргументов, которое введено а смд
if (@ARGV != 1) {
die "Please, input one argumet: $!\n";
}

open my $file, "< $ARGV[0]" or die "Couldn't open $ARGV[0] for reading: $!\n";
close $file;

while(<>) {
	chomp;
    if (Email::Valid->address($_)) {
		my @str_domen = split /@/;
		$domen_table{$str_domen[1]}++; 
        print "$_ \t is Valid \n";
    }
	else   {
		$domen_table{"Invalid"}++;
		print "$_ \t is not Valid \n";
	}
}


print "\n\n";

my @keys = sort { $domen_table{$a}  <=> $domen_table{$b} }
keys(%domen_table);
my @vals = @domen_table{@keys};

@vals = reverse(@vals);
@keys = reverse(@keys);

foreach ( @keys ) {
	if (!/Invalid/) {
		print "$_ : $vals[$counter] \n";
	}
	$counter++;
}

print "INVALID : $domen_table{Invalid} \n ";


