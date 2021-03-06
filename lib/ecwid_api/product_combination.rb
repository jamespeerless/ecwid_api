module EcwidApi
  class ProductCombination < Entity
    attr_reader :product

    self.url_root = -> { "products/#{product.id}/combinations" }

    ecwid_reader :id, :combinationNumber, :options, :sku, :smallThumbnailUrl,
                 :thumbnailUrl, :imageUrl, :originalImageUrl, :quantity,
                 :unlimited, :price, :wholesalePrices, :weight, :warningLimit

    ecwid_writer :options, :sku, :quantity, :unlimited, :price,
                 :wholesalePrices, :weight, :warningLimit, :inventoryDelta

    def initialize(data, opts={})
      super(data, opts)
      @product = opts[:product]
    end

    # Public: Uploads a primary image for a ProductCombination
    #
    # filename - a String that is either a local file name or URL
    #
    # Raises ResponseError if the API returns an error
    #
    # Returns a Faraday::Response object
    def upload_image!(filename)
      client.post("#{url}/image") do |req|
        req.body = open(filename).read
      end.tap do |response|
        raise_on_failure(response)
      end
    end
  end
end