# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- image labels:
  - `org.opencontainers.image.revision` (git commit hash via build arg)
  - `org.opencontainers.image.source` (repo url)
  - `org.opencontainers.image.title`

### Fixed
- ansible-playbook:
  - rename data volume to avoid collision with container name
  - drop capabilities
  - block gaining new privileges

## [1.0.0] - 2020-09-27
### Added
- create mount point at `/var/lib/tor`
  to be able to make container's root filesystem read-only

### Changed
- moved tor's data directory from `/home/onion/.tor` to `/var/lib/tor`
- run `tor` as user `tor` instead of `onion`
- ansible-playbook: read-only root filesystem

## [0.1.1] - 2020-09-27
### Fixed
- pin versions of tor & obfs4proxy
- reduce number of image layers
- ansible-playbook: fixed invalid keyword

## [0.1.0] - 2019-08-30
### Added
- Tor bridge running obfs4 obfuscation proxy in Alpine

[Unreleased]: https://github.com/fphammerle/docker-tor-obfs4-bridge/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/fphammerle/docker-tor-obfs4-bridge/compare/v0.1.1...v1.0.0
[0.1.1]: https://github.com/fphammerle/docker-tor-obfs4-bridge/compare/0.1.0...v0.1.1
[0.1.0]: https://github.com/fphammerle/docker-tor-obfs4-bridge/releases/tag/0.1.0
