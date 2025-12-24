{{/*
Expand the name of the chart.
*/}}
{{- define "onenet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "onenet.fullname" -}}
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
{{- define "onenet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "onenet.common.labels" -}}
helm.sh/chart: {{ include "onenet.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Common management labels
*/}}
{{- define "onenet.management.labels" -}}
helm.sh/chart: {{ include "onenet.chart" . }}
{{ include "onenet.management.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common signal labels
*/}}
{{- define "onenet.signal.labels" -}}
helm.sh/chart: {{ include "onenet.chart" . }}
{{ include "onenet.signal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common relay labels
*/}}
{{- define "onenet.relay.labels" -}}
helm.sh/chart: {{ include "onenet.chart" . }}
{{ include "onenet.relay.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common dashboard labels
*/}}
{{- define "onenet.dashboard.labels" -}}
helm.sh/chart: {{ include "onenet.chart" . }}
{{ include "onenet.dashboard.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Management selector labels
*/}}
{{- define "onenet.management.selectorLabels" -}}
app.kubernetes.io/name: {{ include "onenet.name" . }}-management
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Signal selector labels
*/}}
{{- define "onenet.signal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "onenet.name" . }}-signal
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Relay selector labels
*/}}
{{- define "onenet.relay.selectorLabels" -}}
app.kubernetes.io/name: {{ include "onenet.name" . }}-relay
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Dashboard selector labels
*/}}
{{- define "onenet.dashboard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "onenet.name" . }}-dashboard
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the management service account to use
*/}}
{{- define "onenet.management.serviceAccountName" -}}
{{- if .Values.management.serviceAccount.create }}
{{- default (printf "%s-management" (include "onenet.fullname" .)) .Values.management.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.management.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the signal service account to use
*/}}
{{- define "onenet.signal.serviceAccountName" -}}
{{- if .Values.signal.serviceAccount.create }}
{{- default (printf "%s-signal" (include "onenet.fullname" .)) .Values.signal.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.signal.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the relay service account to use
*/}}
{{- define "onenet.relay.serviceAccountName" -}}
{{- if .Values.relay.serviceAccount.create }}
{{- default (printf "%s-relay" (include "onenet.fullname" .)) .Values.relay.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.relay.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the dashboard service account to use
*/}}
{{- define "onenet.dashboard.serviceAccountName" -}}
{{- if .Values.dashboard.serviceAccount.create }}
{{- default (printf "%s-dashboard" (include "onenet.fullname" .)) .Values.dashboard.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.dashboard.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "onenet.namespace" -}}
{{- default .Release.Namespace .Values.global.namespace -}}
{{- end -}}

