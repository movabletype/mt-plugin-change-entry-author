package ChangeEntryAuthor::SelectableAuthors;
use strict;
use warnings;

use MT::Author;
use MT::Permission;

sub load_iter {
    my $class   = shift;
    my ($args)  = @_;
    my $blog_id = $args->{blog_id};
    my $type    = $args->{type};

    MT::Author->load_iter(
        undef,
        {   sort => 'name',
            join => MT::Permission->join_on(
                'author_id',
                {   (   $type eq 'page'
                        ? ( permissions => "%\'manage_pages\'%" )
                        : ( permissions => "%\'create_post\'%" )
                    ),
                    blog_id => $blog_id,
                },
                { 'like' => { 'permissions' => 1 }, unique => 1 },
            ),
        }
    );
}

1;

