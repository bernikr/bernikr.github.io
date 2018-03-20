---
---

eChar ='e'

@e_toElement = (span, num) ->
  transform = ["",
               "rotate(90deg)",
               "rotate(180deg)",
               "rotate(-90deg)",
               "scaleX(-1)",
               "scaleX(-1) rotate(90deg)",
               "scaleX(-1) rotate(180deg)",
               "scaleX(-1) rotate(-90deg)"]
  span.innerHTML = ("<span class=\"e\" style=\"transform: #{transform[digit]};\">#{eChar}</span>" for digit in num).join('')

@to_base8 = (base10) -> base10.toString(8)
