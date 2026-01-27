{{/*
Expand the name of the chart.
*/}}
{{- define "client-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "client-api.fullname" -}}
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
{{- define "client-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "client-api.labels" -}}
helm.sh/chart: {{ include "client-api.chart" . }}
{{ include "client-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "client-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "client-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "client-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "client-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Формирует имя configMap используя Release.Name и константу
*/}}
{{- define "client-api.configMapName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "config" -}}
{{- end }}

{{/*
Формирует имя ingress используя Release.Name и константу
*/}}
{{- define "client-api.ingressName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "ingress" -}}
{{- end }}

{{/*
Формирует имя service используя Release.Name и константу
*/}}
{{- define "client-api.serviceName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "service" -}}
{{- end }}

{{/*
Формирует имя app используя Release.Name и константу
*/}}
{{- define "client-api.appName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "app" -}}
{{- end }}

{{/*
Формирует имя serviceMonitor используя Release.Name и константу
*/}}
{{- define "client-api.serviceMonitorName" -}}
{{- $releaseName := .Release.Name -}}
{{- printf "%s-%s" $releaseName "service-monitor" -}}
{{- end }}

{{/*
Формирует путь к файлу с открытым ключом подписания JWT
*/}}
{{- define "client-api.jwtPublicPath" -}}
{{- $mountPath := .Values.jwt.mountPath -}}
{{- $public := .Values.jwt.public -}}
{{- printf "%s/%s" $mountPath $public -}}
{{- end }}
