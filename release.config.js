export const branches = ['main'];
export const plugins = [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    [
        '@semantic-release/changelog',
        {
            changelogFile: false,
        },
    ],
    [
        '@semantic-release/exec',
        {
            prepareCmd: 'echo ${nextRelease.version} > VERSION',
        },
    ],
    '@semantic-release/git',
    '@semantic-release/github',
];
