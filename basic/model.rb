class MyModel

  attr_accessor :counter, :name

  def initialize(name=nil)
    @name = name
    @counter = 1
  end

  def inc
    @counter += 1
  end

  def self.find(name)
    return $db.things.findOne({:name => name})
  end

end

$db.things.setConstructor(MyModel)
