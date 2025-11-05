{{/*
Return the name of the chart.
*/}}
{{- define "frontend-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Return the full name (used for resource names).
*/}}
{{- define "frontend-chart.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

