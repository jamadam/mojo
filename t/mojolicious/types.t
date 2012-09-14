use Mojo::Base -strict;

use Test::More tests => 52;

use Mojolicious::Types;

# Basic functionality
my $t = Mojolicious::Types->new;
is $t->type('json'), 'application/json', 'right type';
is $t->type('foo'), undef, 'no type';
$t->type(foo => 'foo/bar');
is $t->type('foo'), 'foo/bar', 'right type';

# Detect common MIME types
is_deeply $t->detect('text/cache-manifest'),  ['appcache'], 'right formats';
is_deeply $t->detect('application/atom+xml'), ['atom'],     'right formats';
is_deeply $t->detect('application/octet-stream'), ['bin'], 'right formats';
is_deeply $t->detect('text/css'),                 ['css'], 'right formats';
is_deeply $t->detect('image/gif'),                ['gif'], 'right formats';
is_deeply $t->detect('application/x-gzip'),       ['gz'],  'right formats';
is_deeply $t->detect('text/html'), ['htm', 'html'], 'right formats';
is_deeply $t->detect('image/x-icon'), ['ico'], 'right formats';
is_deeply $t->detect('image/jpeg'), ['jpeg', 'jpg'], 'right formats';
is_deeply $t->detect('application/javascript'), ['js'],   'right formats';
is_deeply $t->detect('application/json'),       ['json'], 'right formats';
is_deeply $t->detect('audio/mpeg'),             ['mp3'],  'right formats';
is_deeply $t->detect('video/mp4'),              ['mp4'],  'right formats';
is_deeply $t->detect('audio/ogg'),              ['ogg'],  'right formats';
is_deeply $t->detect('video/ogg'),              ['ogv'],  'right formats';
is_deeply $t->detect('application/pdf'),        ['pdf'],  'right formats';
is_deeply $t->detect('image/png'),              ['png'],  'right formats';
is_deeply $t->detect('application/rss+xml'),    ['rss'],  'right formats';
is_deeply $t->detect('image/svg+xml'),          ['svg'],  'right formats';
is_deeply $t->detect('text/plain'),             ['txt'],  'right formats';
is_deeply $t->detect('video/webm'),             ['webm'], 'right formats';
is_deeply $t->detect('application/font-woff'),  ['woff'], 'right formats';
is_deeply $t->detect('application/xml'),        ['xml'],  'right formats';
is_deeply $t->detect('text/xml'),               ['xml'],  'right formats';
is_deeply $t->detect('application/zip'),        ['zip'],  'right format';

# Detect special cases
is_deeply $t->detect('Application/Xml'), ['xml'], 'right formats';
is_deeply $t->detect('Text/Xml'),        ['xml'], 'right formats';
is_deeply $t->detect('APPLICATION/XML'), ['xml'], 'right formats';
is_deeply $t->detect('TEXT/XML'),        ['xml'], 'right formats';
is_deeply $t->detect('text/html;q=0.9'), ['htm', 'html'], 'right formats';
is_deeply $t->detect('TEXT/HTML;Q=0.9'), ['htm', 'html'], 'right formats';
is_deeply $t->detect('text/html,*/*'),             [], 'no formats';
is_deeply $t->detect('text/html;q=0.9,*/*'),       [], 'no formats';
is_deeply $t->detect('text/html,*/*;q=0.9'),       [], 'no formats';
is_deeply $t->detect('text/html;q=0.8,*/*;q=0.9'), [], 'no formats';
is_deeply $t->detect('TEXT/HTML;Q=0.8,*/*;Q=0.9'), [], 'no formats';

# Alternatives
$t->type(json => ['application/json', 'text/x-json']);
is $t->types->{json}[0], 'application/json', 'right type';
is $t->types->{json}[1], 'text/x-json',      'right type';
ok !$t->types->{json}[2], 'no type';
is $t->types->{htm}, 'text/html', 'right type';
is $t->types->{html}, 'text/html;charset=UTF-8', 'right type';
is_deeply $t->detect('application/json'),  ['json'], 'right formats';
is_deeply $t->detect('text/x-json'),       ['json'], 'right formats';
is_deeply $t->detect('TEXT/X-JSON;q=0.1'), ['json'], 'right formats';
is_deeply $t->detect('APPLICATION/JsoN'),  ['json'], 'right formats';
is_deeply $t->detect('text/html'), ['htm', 'html'], 'right formats';
is $t->type('json'), 'application/json',        'right type';
is $t->type('htm'),  'text/html',               'right type';
is $t->type('html'), 'text/html;charset=UTF-8', 'right type';
