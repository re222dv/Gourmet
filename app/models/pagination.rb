class Pagination
  attr_accessor :items

  def initialize(items, offset, limit, url)
    @offset = offset
    @limit = limit
    @total = items.count
    @url = url if offset + limit < @total
    @items = items.offset(offset).limit(limit)
  end

  def as_json(options = {})
    puts options.inspect
    {
        offset: @offset,
        limit: @limit,
        total: @total,
        next: @url,
        items: @items.as_json,
    }
  end
end
