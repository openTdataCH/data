# data

Check [.github/workflows](./.github/workflows)

## run locally

```
$ bash cli-common-setup-python.sh

$ bash cli-fetch-occupancy-forecast.sh
$ bash cli-common-fetch-dataset.sh line-v2 actual-date-line
$ bash cli-common-fetch-dataset.sh go-realtime
$ bash cli-common-fetch-dataset.sh business-organisation-v2 full-business-organisation

$ bash cli-common-create-site.sh occupancy-forecast-json-dataset
$ bash cli-common-create-site.sh line-v2
$ bash cli-common-create-site.sh go-realtime
$ bash cli-common-create-site.sh business-organisation-v2
```
