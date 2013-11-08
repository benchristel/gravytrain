module Gravytrain
  module Goodness
    def self.included(base)
      base.extend ClassMethods
    end
    
    def method_missing(meth, *args, &block)
      meth = meth.to_s
      if meth[-1] == ?_
        Gravytrain::Train.new(self, meth, *args)
      else
        super
      end
    end
    
    module ClassMethods
      
    end
  end
  
  class Train
    def initialize(receiver, meth, *args)
      @receiver = receiver
      @meth = [meth.to_s]
      @args = args
    end
    
    def method_missing(meth, *args, &block)
      meth = meth.to_s
      @meth << meth unless meth[0] == ?_
      @args += args
      if meth[-1] == ?_
        self
      else
        constructed_method = @meth.join('_').squeeze('_').gsub(/^_|_$/, '')
        @receiver.send constructed_method, *@args, &block
      end
    end
  end
end
