{{/*
Expand the name of the chart.
*/}}
{{- define "users-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "users-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "users-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "users-app.labels" -}}
helm.sh/chart: {{ include "users-app.chart" . }}
{{ include "users-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "users-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "users-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "users-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "users-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Формирует имя сервиса PostgreSQL, используя Release.Name и postgresql.nameOverride
*/}}
{{- define "users-app.dbhost" -}}
{{- $releaseName := .Release.Name -}}
{{- $nameOverride := .Values.postgresql.nameOverride -}}
{{- if $nameOverride -}}
{{- printf "%s-%s" $releaseName $nameOverride -}}
{{- else -}}
{{- printf "%s-%s" $releaseName "postgresql" -}} {{/* Значение по умолчанию, если nameOverride не задан */}}
{{- end -}}
{{- end }}

{{/*
Формирует имя configMap используя Release.Name и константу
*/}}
{{- define "users-app.configMapName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "config" -}}
{{- end }}

{{/*
Формирует имя ingress используя Release.Name и константу
*/}}
{{- define "users-app.ingressName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "ingress" -}}
{{- end }}

{{/*
Формирует имя service используя Release.Name и константу
*/}}
{{- define "users-app.serviceName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "service" -}}
{{- end }}

{{/*
Формирует имя app используя Release.Name и константу
*/}}
{{- define "users-app.appName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "app" -}}
{{- end }}

{{/*
Формирует имя serviceMonitor используя Release.Name и константу
*/}}
{{- define "users-app.serviceMonitorName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "service-monitor" -}}
{{- end }}
