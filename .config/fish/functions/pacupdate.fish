function pacupdate
  command yay -Sy &> /dev/null
  set full (command yay -Qu)
  set n_lines (command echo $full | awk '/->/{x++}END{print x}' RS=" ")
  command echo "$n_lines"
end
