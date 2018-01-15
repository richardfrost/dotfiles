
def expansion(str)
  brace_content
end
expand("{sd,se}-prod-vertica1")
expand("{sd,se}-prod-{postgres,vertica}{1..5}")


def expand(string, expansions = [])
  state = :starting
  start_str = ""
  end_str = ""
  alternations = []
  open_count = 0

  puts state

  string.each_char do |c|
    case state
    when :starting
      if c == '{'
        open_count += 1
        alternations << ""
        state = :matching
      else
        start_str += c
      end
    when :matching
      if c == '{'
        open_count += 1
      elsif c == '}'
        open_count -= 1
        if open_count == 0
          state = :ending
        end
      elsif c == ','
        alternations << ""
      else
        alternations[alternations.length-1] += c
      end
    when :ending
      end_str += c
    end
  end

  raise "invalid matching" unless open_count == 0

  alternations.each do |alt|
    expand(start_str + alt + end_str, expansions)
  end

  expansions.sort
end
# expand("{sd,se}-prod-vertica1")
# expand("{sd,se}-prod-{postgres,vertica}{1..5}")
