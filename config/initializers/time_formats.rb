Time::DATE_FORMATS[:local] = Proc.new { |time| time.stamp("3:21 pm") }
Time::DATE_FORMATS[:europian] = Proc.new { |time| time.stamp("14:21") }
