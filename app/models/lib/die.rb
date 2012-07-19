class Die
  attr_reader :value
  attr_reader :index
  
  def initialize(index, value)
    @index = index
    @value = value
  end
end