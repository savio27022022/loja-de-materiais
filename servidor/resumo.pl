#!/usr/bin/perl
use strict;
use warnings;

print "\n";
print "Resumo - MySQL Server\n";

my $cmd_mysql_version = "mysql --version";
my $mysql_version = `$cmd_mysql_version`;

chomp($mysql_version);

print "Versão: $mysql_version\n";

my $cmd_status = "systemctl is-active mysql";
my $status = `$cmd_status`;

chomp($status);

if ($status eq "active") {
    print "O servidor está ativo.\n";
}
elsif ($status eq "inactive") {
    print "O servidor está inativo.\n";
}
else {
    print "Erro ao verificar status do servidor.\n";
}