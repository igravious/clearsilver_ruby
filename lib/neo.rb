require 'hdf'

module Clearsilver

  class Hdf < Neo::Hdf
    
    def initialize
      super
      @level=0
      @cpos=""
      @position=[]
    end

    attr_reader :position, :cpos

    def push name
      @position.push(@cpos)
      @cpos+=name+"."

      if block_given?
	yield
	@cpos=@position.pop
      end
    end

    def pop
      @cpos=@position.pop
    end

    def put name, value
      value = value.to_s unless value.is_a?(String)
      self.set_value(@cpos+(name.to_s),value)
    end

    def get name
      self.get_value(@cpos+name)
    end

  end
  
end

module Neo

  class Cs
    alias_method :orig_use, :use
    def use(obj=nil)
      case obj
      when Neo::Hdf
        orig_use obj
      else
        raise TypeError("Expecting an object of class Neo::Hdf, not of class #{obj.class}")
      end
    end

    def new(obj=nil)
      if obj
        Neo::Cs.create_with obj
      else
        Neo::Cs.create
      end
    end
  end
  
end
