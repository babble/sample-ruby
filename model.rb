
class MyModel 

  attr_accessor :counter
  attr_accessor :name

  def initialize( name=nil )
    @name = name
    @counter = 1;
  end
  
  def inc
    @counter += 1
  end

  def self.find( name )
    temp = Struct.new( :name )
    t = temp.new( name );
    return $db.ms.findOne( t );
  end

end

$db.ms.setConstructor( MyModel );
