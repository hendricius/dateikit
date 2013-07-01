module ApplicationHelper
  def whitespace(item)
    " #{item}"
  end

  def with_x(number)
    "#{number}x"
  end

  def notices?
    flash[:notice] || flash[:alert] || flash[:error]
  end

end
