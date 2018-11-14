
module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) :
    DEFAULT_META["meta_title"]
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) :
    DEFAULT_META["meta_description"]
  end

  def meta_product_name
    content_for?(:meta_product_name) ? content_for(:meta_product_name) :
    DEFAULT_META["meta_product_name"]
  end
end
