module ApplicationHelper
  # turns
  # "http://prelive.partner.viator.com/en/5436/tours/Las-Vegas/Las-Vegas-Night-Strip-Helicopter-Tour/d684-3422_N02" 
  # into
  # "http://partner.viator.com/en/5436/tours/Las-Vegas/Las-Vegas-Night-Strip-Helicopter-Tour/d684-3422_N02"
  def viator_activity_url(url)
    url.sub("//prelive.", "//")
  end
end
