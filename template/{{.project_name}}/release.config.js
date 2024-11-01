module.exports = {
    branches: [{ name: 'main' }],
    plugins: [
      '@semantic-release/commit-analyzer',
      '@semantic-release/release-notes-generator',
      [
        '@semantic-release/changelog',
        {
          changelogFile: 'CHANGES.md',
        },
      ],
      '@semantic-release/git',
      // '@semantic-release/github',
    ],
  };
