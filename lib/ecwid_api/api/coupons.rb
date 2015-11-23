require_relative "../paged_ecwid_response"

module EcwidApi
  module Api
    class Coupons < Base
      # Public: Get all of the Coupon objects for the Ecwid store
      #
      # Returns an Array of Coupon objects
      def all(params = {})
        PagedEcwidResponse.new(client, "discount_coupons", params) do |coupon_hash|
          Coupon.new(coupon_hash, client: client)
        end
      end

      # Public: Finds a single coupon by coupon ID
      #
      # id - an Ecwid coupon ID
      #
      # Returns a Coupon object, or nil if one can't be found
      def find(id)
        response = client.get("discount_coupons/#{id}")
        if response.success?
          Coupon.new(response.body, client: client)
        end
      end

      # Public: Creates a new Coupon
      #
      # params - a Hash
      #
      # Raises an Error if there is a problem
      #
      # Returns a Coupon object
      def create(params)
        response = client.post("discount_coupons", params)
        raise_on_failure(response) {|response| find(response.body["id"]) }
      end

      # Public: Updates an existing Coupon
      #
      # id - the Ecwid coupon ID
      # params - a Hash
      #
      # Raises an Error if there is a problem
      #
      # Returns a Coupon object
      def update(id, params)
        response = client.put("discount_coupons/#{id}", params)
        raise_on_failure(response) { find(id) }
      end
    end
  end
end