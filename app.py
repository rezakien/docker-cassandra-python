import logging

log = logging.getLogger()
log.setLevel('DEBUG')
handler = logging.StreamHandler()
handler.setFormatter(logging.Formatter("%(asctime)s [%(levelname)s] %(name)s: %(message)s"))
log.addHandler(handler)

from cassandra import ConsistencyLevel
from cassandra.cluster import Cluster
from cassandra.query import SimpleStatement

KEYSPACE = "topic_modeling"
session = None


def dropKeyspace(keyspace_name):
    session.execute("DROP KEYSPACE " + keyspace_name)


def initCluster():
    cluster = Cluster()
    session = cluster.connect(KEYSPACE)
    session.set_keyspace(KEYSPACE)

    future = session.execute_async("SELECT * FROM discipline")
    log.info("id\tname\tcontent")
    log.info("---\t----\t----")

    try:
        rows = future.result()
    except Exception:
        log.exception("Error reading rows:")
        return

    for row in rows:
        log.info('\t'.join(row))


if __name__ == '__main__':
    initCluster()
