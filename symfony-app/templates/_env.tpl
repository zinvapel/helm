{{- define "env.value" }}
    {{- if .value }}
        {{- range .value }}
- name: {{ .name }}
  value: {{ .value | quote }}
        {{- end }}
    {{- end }}
{{- end }}

{{- define "env.valueFrom" }}
    {{- if .valueFrom }}
        {{- range .valueFrom }}
- name: {{ .name }}
  valueFrom:
      {{ .from }}:
          key: {{ .key }}
          name: {{ .fromName }}
        {{- end }}
    {{- end }}
{{- end }}
