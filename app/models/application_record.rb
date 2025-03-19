# ApplicationRecord serves as the base class for all models in the application.
# It inherits from ActiveRecord::Base, providing access to all ActiveRecord features 
# such as querying, validations, and associations.
# This class is marked as an abstract class, meaning it is not directly instantiated
# but inherited by other models to share common functionality.

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class # Marks this class as an abstract class.
end
