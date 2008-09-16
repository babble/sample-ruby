
# install some libraries

#FIXME: use require instead of calling the files
$core["content"].forms;
#$core["db"].modelBase;

#$local["models"].utils();
#$local["models"].course();
#$local["models"].student();

$core["core"].routes;

# FIXME: remove this when constructors work
require "hacks"

# setup routing
# FIXME: use the constructor
$routes = $newRoutes.call();
  
$routes["student"] = "/student.rb";
$routes.add( "students" , "/student.rb" , { :extra => { :action => "list" } } );
$routes.add( "courses" , "course" , { :extra => { :action => "list" } } );
