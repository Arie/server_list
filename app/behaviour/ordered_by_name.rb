module OrderedByName

  def self.included(mod)
    mod.class_eval do
      def self.ordered
        order("#{table_name}.name")
      end
    end
  end

end
