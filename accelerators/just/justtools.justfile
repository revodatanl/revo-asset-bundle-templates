# This imports GIT bash from user specific location for Windows.
import? "justfile.local"

# Print shell and bash availability.
[group('just tooling')]
[parallel]
@diag_just:
  -echo "osfam                = {{ os_family() }}"
  -echo "cpus                 = {{ num_cpus() }}"
  -echo "SHELL                = $SHELL"
  -echo "0                    = $0"
  -echo "bash location        = $(command -v bash)"
  -echo "which bash location  = $(which bash)"
#

# Print a message with a colored box around it.
[group('just tooling')]
@_banner msg:
  msg='{{msg}}'; \
  pad=3; \
  minw=72; \
  len=${#msg}; \
  w=$(( len + pad*2 )); \
  if [ "$w" -lt "$minw" ]; then w="$minw"; fi; \
  left=$(( (w - len) / 2 )); \
  right=$(( w - len - left )); \
  lsp=$(printf '%*s' "$left" ''); \
  rsp=$(printf '%*s' "$right" ''); \
  inner="${lsp}${msg}${rsp}"; \
  colors="196 202 208 214 220 226 190 154 118 82 46 47 48 49 51 39 27 21 57 93 129 165"; \
  rainbow_bar() { \
    for n in $(seq 1 "$1"); do \
      set -- $colors; \
      idx=$(( (n - 1) % $# + 1 )); \
      eval "c=\${$idx}"; \
      printf "\033[38;5;%sm═" "$c"; \
    done; \
    printf "\033[93m"; \
  }; \
  printf "\n\033[91m╔"; rainbow_bar "$w"; printf "╗\033[0m\n"; \
  printf "\033[91m║\033[0m\033[1m%s\033[0m\033[93m║\033[0m\n" "$inner"; \
  printf "\033[91m╚"; rainbow_bar "$w"; printf "╝\033[0m\n\n"
#

# This is just magic
[group('just tooling')]
@magic:
  echo ""
  echo ""
  just _banner "This"
  echo ""
  sleep 0.3
  just _banner "Is"
  echo ""
  sleep 0.3
  just _banner "Just"
  echo ""
  sleep 0.3
  just _banner "Magic!"
#

# List all recipe groups and their recipes (just commands)
[group('just tooling')]
@list:
  printf "\033[33m\n";
  just --groups --unsorted; \
  printf "\033[0m\n"; \
  just --list --unsorted --alias-style right
#

# Parallel random digit test
[parallel]
[group('just tooling')]
@_random_digit:
  sleep $((RANDOM % 4))
  printf "\033[%sm%d\033[0m" "$((31 + RANDOM % 7))" "$((RANDOM % 10))"
#

# Parallel random digit test
[parallel]
[group('just tooling')]
@parallel_random_digit_test count='500':
  set -euo pipefail
  max=$(( {{num_cpus()}} )); \
  (( max < 1 )) && max=1; \
  running=0; \
  for i in {1..{{count}}}; do \
    just _random_digit & \
    running=$((running+1)); \
    if (( running >= max )); then \
      wait -n; \
      running=$((running-1)); \
    fi; \
  done; \
  wait;
alias randy := parallel_random_digit_test

# Check formatting of the justfile
[group('just tooling')]
jformat: 
  -just --fmt --check --unstable