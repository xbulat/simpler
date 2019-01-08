module Simpler
  class Router
    class Route
      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @path_regexp = path_regexp(path)
      end

      def match?(env)
        @request = Rack::Request.new(env)
        request_method = @request.request_method.downcase.to_sym
        @request_path = @request.path_info
        @method == request_method && path_match?(@request_path)
      end

      def route_params
        params(@request_path) if path_with_params? || {}
      end

      private

      def params(request_path)
        request_path.match(params_regexp).named_captures.transform_keys(&:to_sym)
      end

      def path_match?(request_path)
        request_path.match(@path_regexp)
      end

      def path_regexp(path)
        Regexp.new(path.gsub(/\:\w+/, '\w+') + '$')
      end

      def path_with_params?
        @path.match(/\:\w+/)
      end

      def params_regexp
        Regexp.new(@path.gsub(/\:\w+/) {|e| "(?<#{e.delete(':')}>\\w+)"})
      end
    end
  end
end
