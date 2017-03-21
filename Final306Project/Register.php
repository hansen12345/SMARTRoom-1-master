//Alex Hansen 2017-2-12


<?php
    $host = "smartroom.czjl1dned5qh.us-west-2.rds.amazonaws.com";
    $db = "SMARTRoom";
    $user = "front5";
    $pass = "fronttoback";
    
    $connection = mysql_connect($host, $user, $pass);
    
    if(!$connection)
    {
        die("Database server connection failed.");
    }
    else
    mysql_select_db('SMARTRoom');
    $sql = "UPDATE Component SET component_status = 'OFF' WHERE component_id = 6";
    
        
        if ($connection == TRUE) {
           
            mysql_query($sql);
            
            echo "added";
        } else {
            echo "Error: " . $sql . "<br>" . $connection->error;
        }
    mysql_close($connection);
?>
