package MojoliciousTest::Foo::Bar;
use Mojolicious::Controller -base;

sub index {1}

sub test { shift->stash(message => 'works') }

1;
