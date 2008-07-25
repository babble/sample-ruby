
require( "model" );

puts( "name: <b>#{ request.name }</b><br>" );

m = MyModel.find( request.name );
if ( m )
  m.inc
else
  m = MyModel.new( request.name );
end
db.ms.save( m );

puts( "name: <b>#{ m.name }</b><br>" );
puts( "count: <b>#{ m.counter }</b><br>" );

