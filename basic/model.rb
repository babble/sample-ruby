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
    t = Struct.new(:name).new(name)
    # This also works:
    # t = {:name => name}
    return $db.ms.findOne(t)
  end

end

$db.ms.setConstructor(MyModel)
