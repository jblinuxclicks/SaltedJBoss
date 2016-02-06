{% for clustername, clusterprops in salt['pillar.get']('clusters', {}).iteritems() %}

{{ clusterprops['jbosshome'] }}/bin/start-{{ clustername }}.sh:
  file.managed:
    - source: salt://files/scripts/start-nodes.sh.jinja
    - template: jinja
    - user: jboss
    - group: jboss
    - mode: 755
    - defaults:
        entityname: {{ clustername }}

{{ clusterprops['jbosshome'] }}/bin/stop-{{ clustername }}.sh:
  file.managed:
    - source: salt://files/scripts/stop-nodes.sh.jinja
    - template: jinja
    - user: jboss
    - group: jboss
    - mode: 755
    - defaults:
        entityname: {{ clustername }}

/srv/salt/orchestration/start-{{ clustername }}.sls:
  file.managed:
    - source: salt://files/scripts/start-nodes.sls.jinja
    - template: jinja
    - mode: 755
    - defaults:
        entityname: {{ clustername }}
        miniontarget: {{ salt['pillar.get']('miniontarget') }}
        entitysls: clusternodes

/srv/salt/orchestration/stop-{{ clustername }}.sls:
  file.managed:
    - source: salt://files/scripts/stop-nodes.sls.jinja
    - template: jinja
    - mode: 755
    - defaults:
        entityname: {{ clustername }}
        miniontarget: {{ salt['pillar.get']('miniontarget') }}
        entitysls: clusternodes

{% endfor %}