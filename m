Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA7100ED0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfKRWeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 17:34:11 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48876 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfKRWeL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Nov 2019 17:34:11 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E58D11A0427;
        Mon, 18 Nov 2019 23:34:05 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7D651A03E7;
        Mon, 18 Nov 2019 23:34:05 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 705D220396;
        Mon, 18 Nov 2019 23:34:05 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] interconnect: Add interconnect_graph file to debugfs
Date:   Tue, 19 Nov 2019 00:34:01 +0200
Message-Id: <6798d1469dd31609e76d13f5ac6249f7af48456a.1574116163.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect graphs can be difficult to understand and the current
"interconnect_summary" file doesn't even display links in any way.

Add a new "interconnect_graph" file to debugfs in the graphviz "dot"
format which describes interconnect providers, nodes and links.

The file is human-readable and can be visualized by piping through
graphviz. Example:

ssh $TARGET cat /sys/kernel/debug/interconnect/interconnect_graph \
	| dot -Tsvg > interconnect_graph.svg

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/driver-api/interconnect.rst | 23 ++++++++
 drivers/interconnect/core.c               | 66 +++++++++++++++++++++++
 2 files changed, 89 insertions(+)

Example output as a github gist:
https://gist.github.com/cdleonard/2f74a7efe74587e3d4b57cf7983b46a8

The qcs404 driver was hacked to probe on imx, the links to "0" seem to
from incorrect trailing 0s on DEFINE_QNODE. Possibly fallout from
switching to ARRAY_SIZE(__VA_ARGS__)?

This makes it easier to understand the interconnect graph than just
staring at registration code.

Changes since RFC v1:
* Document under driver-api/interconnect.rst
* Collect reviews
Link to v1: https://patchwork.kernel.org/patch/11242921/

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index cdeb5825f314..77a85aad8d2f 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -89,5 +89,28 @@ Interconnect consumers
 
 Interconnect consumers are the clients which use the interconnect APIs to
 get paths between endpoints and set their bandwidth/latency/QoS requirements
 for these interconnect paths.  These interfaces are not currently
 documented.
+
+Interconnect debugfs interfaces
+-------------------------------
+
+Like several other subsystems interconnect will create some files for debugging
+and introspection. Files in debugfs are not considered ABI so application
+software shouldn't rely on format details
+change between kernel versions.
+
+``/sys/kernel/debug/interconnect/interconnect_summary``:
+
+Show all interconnect nodes in the system with their aggregated bandwith
+request. Indented under each node show bandwith requests from each device.
+
+``/sys/kernel/debug/interconnect/interconnect_graph``:
+
+Show the interconnect graph in the graphviz dot format. It shows all
+interconnect nodes and links in the system and groups together nodes from the
+same provider as subgraphs. The format is human-readable and can also be piped
+through dot to generate diagrams in many graphical formats::
+
+        $ cat /sys/kernel/debug/interconnect/interconnect_graph | \
+                dot -Tsvg > interconnect_graph.svg
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index c498796adc07..07e91288c7f4 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -92,10 +92,74 @@ static int icc_summary_show(struct seq_file *s, void *data)
 
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(icc_summary);
 
+static void icc_graph_show_link(struct seq_file *s, int level,
+				struct icc_node *n, struct icc_node *m)
+{
+	seq_printf(s, "%s\"%d:%s\" -> \"%d:%s\"\n",
+			level == 2 ? "\t\t" : "\t",
+			n->id, n->name, m->id, m->name);
+}
+
+static void icc_graph_show_node(struct seq_file *s, struct icc_node *n)
+{
+	seq_printf(s, "\t\t\"%d:%s\" [label=\"%d:%s",
+		   n->id, n->name, n->id, n->name);
+	seq_printf(s, "\n\t\t\t|avg_bw=%ukBps", n->avg_bw);
+	seq_printf(s, "\n\t\t\t|peak_bw=%ukBps", n->peak_bw);
+	seq_puts(s, "\"]\n");
+}
+
+static int icc_graph_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+	struct icc_node *n;
+	int cluster_index = 0;
+	int i;
+
+	seq_puts(s, "digraph {\n\trankdir = LR\n\tnode [shape = record]\n");
+	mutex_lock(&icc_lock);
+
+	/* draw providers as cluster subgraphs */
+	cluster_index = 0;
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		seq_printf(s, "\tsubgraph cluster_%d {\n", ++cluster_index);
+		if (provider->dev)
+			seq_printf(s, "\t\tlabel = \"%s\"\n",
+				   dev_name(provider->dev));
+
+		/* draw nodes */
+		list_for_each_entry(n, &provider->nodes, node_list)
+			icc_graph_show_node(s, n);
+
+		/* draw internal links */
+		list_for_each_entry(n, &provider->nodes, node_list)
+			for (i = 0; i < n->num_links; ++i)
+				if (n->provider == n->links[i]->provider)
+					icc_graph_show_link(s, 2, n,
+							    n->links[i]);
+
+		seq_puts(s, "\t}\n");
+	}
+
+	/* draw external links */
+	list_for_each_entry(provider, &icc_providers, provider_list)
+		list_for_each_entry(n, &provider->nodes, node_list)
+			for (i = 0; i < n->num_links; ++i)
+				if (n->provider != n->links[i]->provider)
+					icc_graph_show_link(s, 1, n,
+							    n->links[i]);
+
+	mutex_unlock(&icc_lock);
+	seq_puts(s, "}");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(icc_graph);
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
 }
 
@@ -800,10 +864,12 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
 static int __init icc_init(void)
 {
 	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
 	debugfs_create_file("interconnect_summary", 0444,
 			    icc_debugfs_dir, NULL, &icc_summary_fops);
+	debugfs_create_file("interconnect_graph", 0444,
+			    icc_debugfs_dir, NULL, &icc_graph_fops);
 	return 0;
 }
 
 static void __exit icc_exit(void)
 {
-- 
2.17.1

