
FROM bitnami/kubectl:latest

ADD delete_ns.sh /delete_ns.sh

ENTRYPOINT ["bash", "/delete_ns.sh"]

