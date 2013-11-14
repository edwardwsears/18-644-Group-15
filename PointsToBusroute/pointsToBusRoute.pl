#!/usr/bin/perl
use warnings;

use Routes;

#random route 1: should be 945
my @route1;
@route1 = (          [45999.75,151276.75],
                    [45999.75,151276.75],
                    [45942.375,151868.1719],
                    [45420.5,152478.4844],
                    [44898.625,153360.6094],
                    [44409.625,154187],
                    [44093.625,154720.3594],
                    [43516,155697.375],
                    [43101.625,156171.0313],
                    [43586.25,156703.6875],
                    [44612.25,157831.7656],
                    [44767.625,158635.0313],
                    [44791.25,160137.6875],
                    [46705.375,163223.0625],
                    [46705.375,163223.0625],
                    [46960.375,165332.3438],
                    [46980.125,166272.1406],
                    [47469.75,169016.7813],
                    [48180.125,170314.6094],
                    [48266.75,170472.7344],
                    [49912.375,171925.8594],
                    [50488.75,172135.5],
                    [50511.375,172734.8594],
                    [50572,174513.7188],
                    [50034,175172.7344],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50032.125,175172.7656],
                    [50031.375,175173.875],
                    [50318.25,175404.4063],
                    [50318.25,175404.4063],
                    [50568.75,174396.6719],
                    [50558.5,174056.8438],
                    [50432.25,171990.6563],
                    [48327.125,170584.6719],
                    [47559.625,169181.0469],
                    [46998.625,167186.0469]);

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
    for (my $bus_number=0;$bus_number<($#Routes::bus_route+1);$bus_number++){
        #initialize
        $average_closest_distance[$bus_number][0]=0;
        $average_closest_distance[$bus_number][1]=0;

        #initialize closest stop to 1st stop
        my @difference;
        $difference[0]=abs($Routes::bus_route[$bus_number][1][0]-$route1[1][0]);
        $difference[1]=abs($Routes::bus_route[$bus_number][1][1]-$route1[1][1]);
        $difference_added = $difference[0]+$difference[1];

        for (my $i=1;$i<$#route1+1; $i++){
            for (my $bus_stop_points=1;$bus_stop_points < ($#{$Routes::bus_route[$bus_number]}+1);$bus_stop_points++){

                $temp_diff[0] = abs($Routes::bus_route[$bus_number][$bus_stop_points][0]-$route1[$i][0]);
                $temp_diff[1] = abs($Routes::bus_route[$bus_number][$bus_stop_points][1]-$route1[$i][1]);
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
for ($i = 0;$i<$#Routes::bus_route+1;$i++){

    print $Routes::bus_route[$i][0][0].":\n";
    print "Lattitude difference: ".$average_closest_distance[$i][0]."\n";
    print "Longitude difference: ".$average_closest_distance[$i][1]."\n";
    $lowest_added_temp = $average_closest_distance[$i][0] + $average_closest_distance[$i][1];
    if ($lowest_added_temp<$lowest_added) {
        $lowest_index = $i;
        $lowest_added = $lowest_added_temp;
    }

}

print "Route is ".$Routes::bus_route[$lowest_index][0][0]."\n";
