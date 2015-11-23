require "open-uri"

module EcwidApi
  class Coupon < Entity
    self.url_root = "discount_coupons"

    ecwid_reader  :name, :code, :discountType, :status, :discount, :launchDate,
                  :expirationDate, :totalLimit, :usesLimit, :repeatCustomerOnly,
                  :creationDate, :orderCount, :catalogLimit

    ecwid_writer :name, :code, :discountType, :status, :discount, :launchDate,
                  :expirationDate, :totalLimit, :usesLimit, :repeatCustomerOnly,
                  :creationDate, :orderCount, :catalogLimit
  end
end