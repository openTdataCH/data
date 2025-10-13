# data

Check [.github/workflows](./.github/workflows)

## run locally

```
$ bash cli-common-setup-python.sh

$ bash cli-fetch-occupancy-forecast.sh
$ bash cli-common-fetch-dataset.sh slnid-line-actual-date actual-date-line
$ bash cli-common-fetch-dataset.sh go-realtime
$ bash cli-common-fetch-dataset.sh business-organisations full_business_organisation_versions

$ bash cli-common-create-site.sh slnid-line-actual-date
$ bash cli-common-create-site.sh go-realtime
$ bash cli-common-create-site.sh business-organisations
$ bash cli-common-create-site.sh occupancy-forecast-json-dataset
```
