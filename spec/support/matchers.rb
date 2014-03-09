RSpec::Matchers.define :include_hashes do |expected_hashes|
  match do |actual_hashes|
    begin
      def transform(array)
        array.flatten.map(&:to_s).uniq.
          reject { |value| value == '<number>' }.
          reject { |value| value == '<string>' }.
          sort.compact
      end

      actual_keys = transform(actual_hashes.map(&:keys))
      actual_values = transform(actual_hashes.map(&:values))

      expected_keys = transform(expected_hashes.map(&:keys))
      expected_values = transform(expected_hashes.map(&:values))

      expected_keys.each do |expected_key|
        expect(actual_keys).to RSpec::Matchers::BuiltIn::Include.new expected_key
      end

      expected_values.each do |expected_value|
        expect(actual_values).to RSpec::Matchers::BuiltIn::Include.new expected_value
      end
    rescue Exception => e
      raise e.message
    end
  end
end
