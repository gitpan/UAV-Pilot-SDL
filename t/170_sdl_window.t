use Test::More tests => 9;
use SDL;
use UAV::Pilot::SDL::Window::Mock;
use UAV::Pilot::SDL::WindowEventHandler;


package MockWindowEventHandler;
use Moose;

with 'UAV::Pilot::SDL::WindowEventHandler';


sub draw {}


package main;

my $window = UAV::Pilot::SDL::Window::Mock->new;
isa_ok( $window => 'UAV::Pilot::SDL::Window' );
cmp_ok( $window->width,  '==', 0, "No width set on base window" );
cmp_ok( $window->height, '==', 0, "No height set on base window" );


my $child1 = MockWindowEventHandler->new({
    width  => 1,
    height => 1,
});
$child1->add_to_window( $window );
cmp_ok( $window->width,  '==', 1, "Width set for first child" );
cmp_ok( $window->height, '==', 1, "Height set for first child" );

my $child2 = MockWindowEventHandler->new({
    width  => 2,
    height => 2,
});
$child2->add_to_window( $window, $window->TOP );
cmp_ok( $window->width,  '==', 2, "Width set for second child on top" );
cmp_ok( $window->height, '==', 3, "Height set for second child child on top" );

my $child3 = MockWindowEventHandler->new({
    width  => 3,
    height => 3,
});
$child3->add_to_window( $window, $window->BOTTOM );
cmp_ok( $window->width,  '==', 3, "Width set for third child on top" );
cmp_ok( $window->height, '==', 6, "Height set for third child on top" );
