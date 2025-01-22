{{- if $.Values.configMap -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $.Values.name }}-datadir-config
data:
{{ tpl ($.Values.configMap.datadirConfig | toYaml) $ | indent 4 }}
{{/*
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $.Values.name }}-startup-wrp
data:
  run-services-wrp.sh: |
    #!/bin/bash
    HOSTNAME=$(cat /etc/hostname)

    initfile=${TEAMCITY_DATA_PATH}/system/dataDirectoryInitialized
    if [ "$HOSTNAME" == "{{ $.Values.name }}-0" ]; then
      if [ ! -f $initfile ]; then
        echo $initfile not found
        echo Assume initial setup
        index=0
        while [ -d ${TEAMCITY_DATA_PATH}/config.back.$index ]; do
          index=$((index + 1))
        done
        echo Hide mounted files
        mv -v ${TEAMCITY_DATA_PATH}/config ${TEAMCITY_DATA_PATH}/config.back.$index
      fi
    fi

    set -x
    case "$HOSTNAME" in
{{- range $index, $value := $.Values.teamcity.nodes }}
    "{{ $.Values.name }}-{{ $index }}")
      export ROOT_URL=http://{{ $.Values.name }}-{{ $index }}.{{ $.Values.name }}-headless.{{ $.Values.namespace}}:8111
      export NODE_ID={{ $.Values.name }}-{{ $index }}
      {{- with $value.env }}
      {{- range $e, $value := . }}
      export {{ $e }}="{{ tpl ($value) $ }}"
      {{- end }}
      {{- end }}
      export TEAMCITY_SERVER_OPTS="-Dteamcity.server.nodeId=${NODE_ID} -Dteamcity.server.rootURL=${ROOT_URL} $TEAMCITY_SERVER_OPTS"
      {{- if $value.responsibilities }}
      echo Override server responsibilities
      export TEAMCITY_SERVER_OPTS="-Dteamcity.server.responsibilities={{ join "," $value.responsibilities }} $TEAMCITY_SERVER_OPTS"
      {{- end }}
      exec /run-services.sh
    ;;
{{- end }}
    esac
*/}}
{{- end }}