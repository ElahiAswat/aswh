catfile() {
    local file="$1"
    local term="$2"

    if [ -z "$file" ] || [ -z "$term" ]; then
        echo "Usage: catfile <file> <search-term>"
        return 1
    fi

    local matches lines choice

    # Get matches with line numbers
    matches=$(grep -n "$term" "$file")

    if [ -z "$matches" ]; then
        echo "No match found for '$term' in $file"
        return 1
    fi

    # Count matches
    lines=$(echo "$matches" | wc -l | tr -d ' ')

    if [ "$lines" -eq 1 ]; then
        # Only one match → open directly
        local lineno
        lineno=$(echo "$matches" | cut -d: -f1)
        nano +"$lineno" "$file"
        return
    fi

    # Multiple matches → show options
    echo "Multiple matches found:"

    local i=1
    while IFS=: read -r line_no line_text; do
        echo "$i. $line_text \033[34m#line $line_no\033[0m"
        i=$((i+1))
    done <<EOF
$matches
EOF

    echo
    echo -n "Enter choice number to open: "
    read choice

    if ! echo "$choice" | grep -qE '^[0-9]+$'; then
        echo "Invalid choice"
        return 1
    fi

    local selected_lineno
    selected_lineno=$(echo "$matches" | sed -n "${choice}p" | cut -d: -f1)

    if [ -n "$selected_lineno" ]; then
        nano +"$selected_lineno" "$file"
    else
        echo "Invalid choice"
        return 1
    fi
}

lstoday() {
  local recursive=false

  # check for -r flag
  if [[ "$1" == "-r" ]]; then
    recursive=true
    shift
  fi

  local target="${1:-.}"

  if $recursive; then
    # recursive (normal find behavior)
    find "$target" -newermt "$(date +%Y-%m-%d)"
  else
    # non-recursive (current directory only)
    find "$target" -maxdepth 1 -newermt "$(date +%Y-%m-%d)"
  fi
}

cdir() { mkdir -p -- "$1" && cd -- "$1"; }
