require 'active_record'

module ActiveRecord
  module Locking
    module Pessimistic
      module ConvenienceMethods

        # Finds a records with the given ID, applies the block, then calls save. Returns the record.
        #
        # All options are passed to #save, except for:
        #   <tt>lock:</tt> - pass an SQL locking clause to append the end of the SELECT statement, defaults to "FOR UPDATE"
        #
        # Example:
        #
        #   Post.find_and_save_atomically(1, validate: false, lock: "FOR SHARE") {|post| post.title = "new title" s}
        #
        def find_and_save_atomically(id, opts = {}, &block)
          _find_and_apply_atomically(:save, id, opts, &block)
        end

        # Same as find_and_save_atomically, just calls #save! on the model
        def find_and_save_atomically!(id, opts = {}, &block)
          _find_and_apply_atomically(:save!, id, opts, &block)
        end

        # Find and update attributes, but atomically
        def find_and_update_atomically(id, attrs, opts = {})
          find_and_save_atomically(id, opts) {|r| r.assign_attributes attrs }
        end

        private

          def _find_and_apply_atomically(method, id, opts = {}, &block)
            kind = opts.delete(:lock) || true
            transaction do
              record = lock(kind).find(id)
              block.call(record)
              record.send(method, opts)
              record
            end
          end

      end
    end
  end
end

ActiveRecord::Base.extend ActiveRecord::Locking::Pessimistic::ConvenienceMethods
