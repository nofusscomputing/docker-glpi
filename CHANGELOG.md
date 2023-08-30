## 0.1.0 (2023-08-30)

### Bug Fixes

- **dockerfile**: [68851755](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/688517556a748c2ac74d657d573b4ee79a1e48d3) - ensure CA certs available prior to apt install [ [!4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/4) ]
- **dockerfile**: [5884c49f](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/5884c49f8aacfc25e5b79e1fe1edb745891b9c85) - silently fail if file doesn't exist on delete [ [!4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/4) [#3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/3) ]

### Code Refactor

- **docker**: [1973f5e0](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/1973f5e00358be11e2c82ea0fdfb0f32430fa0b6) - dockerfile move php version to arg [ [!4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/4) [#3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/3) ]

### Features

- **php**: [6278fbb3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/6278fbb3dce77dc01dedcb4cefa91b428eaa9135) - upgrade php to 8.1 [ [!4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/4) [#3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/3) ]

## 0.1.0rc1 (2023-08-30)

### Bug Fixes

- **docker**: [83fbaae1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/83fbaae1d61bcd9ac73f46373694204c5e7751c8) - added files as volume [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) ]

### Documentaton / Guides

- [711549ba](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/711549ba4c9709c39022d8e87e401f5184637091) - add docker-compose example [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) [#2](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/2) ]
- [39e47638](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/39e476386a4a88fa6fa175f14085eb0cc3e8e4e4) - add cron [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) [#2](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/2) ]
- [23886773](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/23886773af9976a06be6296cc4a89986df0cd787) - added initial docs [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) [#2](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/2) ]

### Features

- **inventory**: [04999a8b](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/04999a8b57837d3f30a7df40323b82b4ebb0387b) - Authenticated access [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) [#4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/4) ]
- **inventory**: [83b4e98a](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/83b4e98a189d50f5b69d25e8a02f0dee70f012e9) - Enable inventory endpoint with env variable [ [!3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/3) [#4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/4) ]
- **inventory**: [3439d1e3](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/3439d1e36184e83e01829db5c0ee97984b350a5a) - block access to inventory endpoints [ [#4](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/issues/4) ]

## 0.1.0rc0 (2023-07-16)

### Bug Fixes

- **build**: [3a81ee1d](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/3a81ee1dfed8d96908ab827d8a24f7923be351a3) - remove another testing directive [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]
- **build**: [ab8043fc](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/ab8043fc9353dd3955f9ae2a0fbd00aa6812fbbf) - remove testing directive [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]

### Code Refactor

- **ci**: [a541598e](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/a541598e482b24ef0fdfd04d96de87de5b6afed2) - migrated CI to current form [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]
- [5d1d0f7f](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/5d1d0f7feb4b4923651c603a04f49c7c66ff7315) - update dockerfile to current version of glpi [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]

### Documentaton / Guides

- **readme**: [ed84cb72](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/ed84cb72a0465a61992e5aeec2208c0c429d63b9) - fixed github links [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]

### Features

- **docker**: [22bb3285](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/22bb328581f7f6b5c4bcdf07f28878863b1e3dba) - added health check to image [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]
- **glpi**: [53ee0482](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/53ee0482fe9f3e30b3cf51e5b604a6f8e494d490) - added GLPI CLI cron to run every minute [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]
- **cron**: [e2005740](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/commit/e20057409955634790de23b9d1bb7b4abf70f105) - add cron to container [ [!1](https://gitlab.com/nofusscomputing/projects/docker-glpi/-/merge_requests/1) ]

## 0.0.1 (2023-07-14)
