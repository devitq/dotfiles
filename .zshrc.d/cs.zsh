# Common clipboard detection
_get_clip_cmd() {
  if command -v pbcopy >/dev/null 2>&1; then
    echo "pbcopy"
  elif command -v xclip >/dev/null 2>&1; then
    echo "xclip -selection clipboard"
  elif command -v clip >/dev/null 2>&1; then
    echo "clip"
  else
    echo "Error: No clipboard command found" >&2
    return 1
  fi
}

cs() {
  local output clip_cmd
  clip_cmd=$(_get_clip_cmd) || return 1

  if [ $# -eq 0 ]; then
    output=$(cat && printf X)
    output=${output%X}
  else
    output=$("$@")
  fi

  printf '%s' "$output"
  printf '%s' "$output" | eval "$clip_cmd"
}

cse() {
  local output clip_cmd
  clip_cmd=$(_get_clip_cmd) || return 1

  if [ $# -eq 0 ]; then
    output=$(cat && printf X)
    output=${output%X}
  else
    output=$("$@" 2>&1)
  fi

  printf '%s' "$output"
  printf '%s' "$output" | eval "$clip_cmd"
}

