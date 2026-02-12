[group('vscode')]
[script]
install-extensions:
	EXT_FILE=".vscode/extensions.json";
	if ! command -v code >/dev/null 2>&1; then
		echo "VS Code CLI 'code' is not available in PATH." >&2;
		echo "Install it from VS Code Command Palette: Shell Command: Install 'code' command in PATH" >&2;
		exit 1;
	fi;
	exts=();
	tmp_file="${TMPDIR:-/tmp}/vscode-exts.$$";
	sed -n '/"recommendations"[[:space:]]*:[[:space:]]*\[/,/\]/p' "$EXT_FILE" \
		| grep -oE '"[A-Za-z0-9][A-Za-z0-9._-]*\.[A-Za-z0-9][A-Za-z0-9._-]*"' \
		| tr -d '"' \
		| awk '!seen[$0]++' > "$tmp_file";
	while IFS= read -r ext; do
		exts+=("$ext");
	done < "$tmp_file";
	rm -f "$tmp_file";
	echo "Installing ${#exts[@]} recommended VS Code extensions from $EXT_FILE";
	extargs=();
	for ext in "${exts[@]}"; do
		extargs+=(--install-extension "$ext");
	done;
	code "${extargs[@]}" --force;
	echo "✅  Finished installing all extensions.";
