Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D05140718
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAQJ6c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39459 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAQJ6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so6912172wmj.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IimwIZWWa1VVuWQv/hNX0pZ26OrvQk2Ht7ELq9Rp8kU=;
        b=sPtoIYGgKgbKnmSo9AtWDGiCuHSmO5L294/W3C2j92HNEh7QAMJFnM+oJTjnRVUzvj
         Q9mOgBpiVZWbraG3mi94QLdB6b55VI475xn1NkvGGeQFtii1vviWdNHoOfQt85KAnC9K
         CCvTjSwDR3pFtrPQxtQGLAefeCqxZi3+B4A2kRaCTF7WFRtPEYdOtcmbhIVH9qaQbISO
         1QjvuU1RTOlHo4Fpj0RfZ/875g39n9fC9WEuhSYWsqcEeAfpYK370w9CJEAbMNzx2mLD
         PbcuUkkN7KkOQv+dIKNJY9Sp0sfBP0dKjPSyqwTYsY12T/EYe1eFjULCfyXqQ8531/BI
         nKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IimwIZWWa1VVuWQv/hNX0pZ26OrvQk2Ht7ELq9Rp8kU=;
        b=CExBQpYkNZxs+Xso1dKntat03DkSJeOjbr9kaYc0+aRiAD9C+m+qj3gFZkaSCElZAp
         e5cj3ueBHtLW7XVI3JxOcZucxI/8JiJgdfEQt1V+iFLDkr4wzHlkwgw1KmzVegp51/pO
         nGHMjzUUShqW4MTkJecwk76pycdZMKp8B06Qeu154MzNLf1rHlZshsz4SMbR7lbH4Met
         nW2TAqpwSJUW3OWoWAZb60hdPqEVXM9zfrfmAObMXKA7oJa0nU9G93Kq8Fi7VxxYJ5ql
         UZw60aIMovpiwIY0RyauIYIvBMIL8iaBWJg0dyoQ0qsjct/vUejslFdAjOkZcwSFOU46
         xkQA==
X-Gm-Message-State: APjAAAUjN4tiiwbsuozfvmlqrewE3/cf+CtwA9/MGVna8B2za9humljC
        mytPNL2bfXQzUA0jNPnSfZiRaA==
X-Google-Smtp-Source: APXvYqyJqeYqOx1EGqfxZtobmXX5KKSqDMm15dAMTEW8mxEziDijPrt5c6EvACASyGYl51sdTJc7GA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr3620817wme.67.1579255109154;
        Fri, 17 Jan 2020 01:58:29 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:28 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 08/12] interconnect: Add interconnect_graph file to debugfs
Date:   Fri, 17 Jan 2020 11:58:12 +0200
Message-Id: <20200117095816.23575-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

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
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/driver-api/interconnect.rst | 22 ++++++++
 drivers/interconnect/core.c               | 66 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index cdeb5825f314..5ed4f57a6bac 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -91,3 +91,25 @@ Interconnect consumers are the clients which use the interconnect APIs to
 get paths between endpoints and set their bandwidth/latency/QoS requirements
 for these interconnect paths.  These interfaces are not currently
 documented.
+
+Interconnect debugfs interfaces
+-------------------------------
+
+Like several other subsystems interconnect will create some files for debugging
+and introspection. Files in debugfs are not considered ABI so application
+software shouldn't rely on format details change between kernel versions.
+
+``/sys/kernel/debug/interconnect/interconnect_summary``:
+
+Show all interconnect nodes in the system with their aggregated bandwidth
+request. Indented under each node show bandwidth requests from each device.
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
index 03625406c69f..63c164264b73 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -71,6 +71,70 @@ static int icc_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(icc_summary);
 
+static void icc_graph_show_link(struct seq_file *s, int level,
+				struct icc_node *n, struct icc_node *m)
+{
+	seq_printf(s, "%s\"%d:%s\" -> \"%d:%s\"\n",
+		   level == 2 ? "\t\t" : "\t",
+		   n->id, n->name, m->id, m->name);
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
@@ -827,6 +891,8 @@ static int __init icc_init(void)
 	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
 	debugfs_create_file("interconnect_summary", 0444,
 			    icc_debugfs_dir, NULL, &icc_summary_fops);
+	debugfs_create_file("interconnect_graph", 0444,
+			    icc_debugfs_dir, NULL, &icc_graph_fops);
 	return 0;
 }
 
