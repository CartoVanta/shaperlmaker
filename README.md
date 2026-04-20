# shaperlmaker
Helper tool for building and installing Perl projects on your personal account

## Dependencies
This tool is written in Perl, and as such requires Perl 5 to run.

## Installation
This command, to work, requires that
the `PATH` environment variable is configured
to include `~/local/bin` within your home directory
and that the `PERL5LIB` environment variable
is configured to include `~/local/lib/perl5`
(`~` being shorthand for whatever your home
directory is).
If those conditions are not met, modify your
shell startup files so that they are, log out, and
log back in.

If you have already a previous version of this tool
installed and merely wish to use this tool to
install its own upgrade, then you can
(from anywhere in the distribution)
enter the command:
```
shaperlmaker install
```
However, if you don't have it on your system and
wish to use this tool to install itself for the
first time, then you need to go to the top
directory of this distribution and enter
the command:
```
perl shaperlmaker.pl install
```
