#!/usr/bin/perl
use warnings;
# store bus stop coordinates
# [0][0] = bus name
# [x][0] = lattitude
# [x][1] = longitude
my @bus_route;
$bus_route[0][0][0] = "28x";
$bus_route[0][1][0] = 1000;
$bus_route[0][1][1] = 1000;
$bus_route[0][2][0] = 2000;
$bus_route[0][2][1] = 2000;
$bus_route[0][3][0] = 3000;
$bus_route[0][3][1] = 3000;
$bus_route[0][4][0] = 4000;
$bus_route[0][4][1] = 4000;
$bus_route[0][5][0] = 5000;
$bus_route[0][5][1] = 5000;
$bus_route[1][0][0] = "61c";
$bus_route[1][1][0] = 1000;
$bus_route[1][1][1] = 1000;
$bus_route[1][2][0] = 1000;
$bus_route[1][2][1] = 2000;
$bus_route[1][3][0] = 1000;
$bus_route[1][3][1] = 3000;
$bus_route[1][4][0] = 1000;
$bus_route[1][4][1] = 4000;
$bus_route[1][5][0] = 1000;
$bus_route[1][5][1] = 5000;
$bus_route[2][0][0] = "71a";
$bus_route[2][1][0] = 1000;
$bus_route[2][1][1] = 1000;
$bus_route[2][2][0] = 2000;
$bus_route[2][2][1] = 1000;
$bus_route[2][3][0] = 3000;
$bus_route[2][3][1] = 1000;
$bus_route[2][4][0] = 4000;
$bus_route[2][4][1] = 1000;
$bus_route[2][5][0] = 5000;
$bus_route[2][5][1] = 1000;

#random route 1
my @route1;
$route1[0][0] = 1000;
$route1[0][1] = 1000;
$route1[1][0] = 1000;
$route1[1][1] = 2050;
$route1[2][0] = 1000;
$route1[2][1] = 3100;

#random route 2
my @route2;
$route2[0][0] = 1000;
$route2[0][1] = 1000;
$route2[1][0] = 2050;
$route2[1][1] = 2000;
$route2[2][0] = 3100;
$route2[2][1] = 3000;

# find closest point of each bus route
# find total difference btw bus and route

    #iterate through each possibe bus
    for (my $bus_number=0;$bus_number<($#bus_route+1);$bus_number++){
        #initialize
        $average_closest_distance[$bus_number][0]=0;
        $average_closest_distance[$bus_number][1]=0;

        #initialize closest stop to 1st stop
        my @difference;
        $difference[0]=abs($bus_route[$bus_number][1][0]-$route1[1][0]);
        $difference[1]=abs($bus_route[$bus_number][1][1]-$route1[1][1]);
        $difference_added = $difference[0]+$difference[1];

        for (my $i=1;$i<$#route1+1; $i++){
            for (my $bus_stop_points=1;$bus_stop_points < ($#{$bus_route[$bus_number]}+1);$bus_stop_points++){

                $temp_diff[0] = abs($bus_route[$bus_number][$bus_stop_points][0]-$route1[$i][0]);
                $temp_diff[1] = abs($bus_route[$bus_number][$bus_stop_points][1]-$route1[$i][1]);
                $temp_diff_added = $temp_diff[0] + $temp_diff[1];
                if ($difference_added>$temp_diff_added) {
                    $difference[0] = $temp_diff[0];
                    $difference[1] = $temp_diff[1];
                    $difference_added=$temp_diff_added;
                }
            }

            # add difference of the closest stop
            $average_closest_distance[$bus_number][0]+=$difference[0];
            $average_closest_distance[$bus_number][1]+=$difference[1];
        }
    }

# bus route with the lowest difference in points is the route
$lowest_added = $average_closest_distance[0][0] + $average_closest_distance[0][1];
my $lowest_index=0;
my $lowest_added_temp;
for ($i = 0;$i<$#bus_route+1;$i++){

    print $bus_route[$i][0][0].":\n";
    print "Lattitude difference: ".$average_closest_distance[$i][0]."\n";
    print "Longitude difference: ".$average_closest_distance[$i][1]."\n";
    $lowest_added_temp = $average_closest_distance[$i][0] + $average_closest_distance[$i][1];
    if ($lowest_added_temp<$lowest_added) {
        $lowest_index = $i;
        $lowest_added = $lowest_added_temp;
    }

}

print "Route is ".$bus_route[$lowest_index][0][0]."\n";
