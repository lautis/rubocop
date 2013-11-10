# encoding: utf-8

module Rubocop
  module Cop
    module Style
      # This cop checks if the length a method exceeds some maximum value.
      # Comment lines can optionally be ignored.
      # The maximum allowed length is configurable.
      class MethodLength < Cop
        include CheckMethods

        MSG = 'Method has too many lines. [%d/%d]'

        def max_length
          cop_config['Max']
        end

        def count_comments?
          cop_config['CountComments']
        end

        private

        def check(node, *_)
          method_length = Util.source_length(node.loc.expression.source,
                                             count_comments?)

          if method_length > max_length
            message = sprintf(MSG, method_length, max_length)
            convention(node, :keyword, message)
          end
        end
      end
    end
  end
end
