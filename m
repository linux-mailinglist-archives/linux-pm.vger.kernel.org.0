Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B151251DB8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHYRCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHYRCA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 13:02:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC5C061756
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u18so3227904wmc.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyRtSWuQR0TVsamcXwukp7YtW2KdPtI3nsPFQ7UHMtU=;
        b=G3LeOxFZLii1TV1aoy6uKJ4LU+clSq+ZnmS9vfnD/iEMU4KRK85NVSnaxFVCyKd+iO
         Npefhtqv/BqIBxjYAB4uGO0ITnPYn2Q6qWRx+CC27MKYmy18TsmQCgPIQQSNM0GFCB5F
         yrgQEklSeQFwif0Yc6xdx7cCNrUVAl23HBU1Jg3A4+kr+bv/YIKZAXKuImXguZ42LVfo
         n9trXsbD2jpnsDq13OILS4DMV4eXyptO6K5XW/CRjc6qyZRF+eD3RJUlmwjcb9OlwG7u
         EERJ/LlaIaqDBo5Va+tBTtYPnz9POq2ju5CqxafG9pf6QZKDjdi/AMw1Zr4rL0NZ5wev
         TQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyRtSWuQR0TVsamcXwukp7YtW2KdPtI3nsPFQ7UHMtU=;
        b=UQ8qUArUzrr6FRTEYF/vRgI/2hs+5OZpdR/BwBkUgrOudNIMD4X2BvpFZD3q3W9Cem
         xoAPxZ0/Ucff57CJnSSIp3oXtSPazR3yEzoKkl6BNQkX4XSzt759OLUSASA+LhkF/1IN
         jATjQRvyaraBWHu/l+0FiDvh/csUb/VAH/A/gvZMGvv5gAWXI1OvwXWXvZ22jQ3IIPLi
         yOhfM7aK4vLkhm8MMtKW/WXdxwME3LNFHihrGIZnXV1pQu5pl2cJUhqlA/S3ueFZxvFK
         PJqVetGvIWep1KGwoX1jNyAbphS+dr+8dZGd61nDBMqKoUZ0GusrkbT5kK+uXWQR/dw7
         gJIQ==
X-Gm-Message-State: AOAM532GjDmhoy/cqWxyJY8Kcl7CHLEn+1DvQOkU5LVZXYu3y1FfD8MI
        N641R5ajo/lyE3NA5DeIdsXpfK7OPGN5qg==
X-Google-Smtp-Source: ABdhPJxu8NHoSGJYmN5JDKfkeW/SAm77p+8CKeCIfeLKZt+d3hh0waqHjNBA7GFqJ37eUtnBTMToUA==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr2803674wmb.57.1598374916472;
        Tue, 25 Aug 2020 10:01:56 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:55 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] interconnect: Add sync state support
Date:   Tue, 25 Aug 2020 20:01:51 +0300
Message-Id: <20200825170152.6434-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bootloaders often do some initial configuration of the interconnects
in the system and we want to keep this configuration until all consumers
have probed and expressed their bandwidth needs. This is because we don't
want to change the configuration by starting to disable unused paths until
every user had a chance to request the amount of bandwidth it needs.

To accomplish this we will implement an interconnect specific sync_state
callback which will synchronize (aggregate and set) the current bandwidth
settings when all consumers have been probed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 67 +++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  5 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index befd111049c0..eef389e8e26f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -26,6 +26,8 @@
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
+static int providers_count;
+static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
@@ -261,6 +263,12 @@ static int aggregate_requests(struct icc_node *node)
 		}
 		p->aggregate(node, r->tag, avg_bw, peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+
+		/* during boot use the initial bandwidth as a floor value */
+		if (!synced_state) {
+			node->avg_bw = max(node->avg_bw, node->init_avg);
+			node->peak_bw = max(node->peak_bw, node->init_peak);
+		}
 	}
 
 	return 0;
@@ -925,6 +933,19 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
 
+	/* get the initial bandwidth values and sync them with hardware */
+	if (provider->get_bw) {
+		provider->get_bw(node, &node->init_avg, &node->init_peak);
+	} else {
+		node->init_avg = INT_MAX;
+		node->init_peak = INT_MAX;
+	}
+	node->avg_bw = node->init_avg;
+	node->peak_bw = node->init_peak;
+	provider->set(node, node);
+	node->avg_bw = 0;
+	node->peak_bw = 0;
+
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1020,8 +1041,54 @@ int icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static int of_count_icc_providers(struct device_node *np)
+{
+	struct device_node *child;
+	int count = 0;
+
+	for_each_available_child_of_node(np, child) {
+		if (of_property_read_bool(child, "#interconnect-cells"))
+			count++;
+		count += of_count_icc_providers(child);
+	}
+	of_node_put(np);
+
+	return count;
+}
+
+void icc_sync_state(struct device *dev)
+{
+	struct icc_provider *p;
+	struct icc_node *n;
+	static int count;
+
+	count++;
+
+	if (count < providers_count)
+		return;
+
+	mutex_lock(&icc_lock);
+	synced_state = true;
+	list_for_each_entry(p, &icc_providers, provider_list) {
+		dev_dbg(p->dev, "interconnect provider is in synced state\n");
+		list_for_each_entry(n, &p->nodes, node_list) {
+			if (n->init_avg || n->init_peak) {
+				aggregate_requests(n);
+				p->set(n, n);
+			}
+		}
+	}
+	mutex_unlock(&icc_lock);
+}
+EXPORT_SYMBOL_GPL(icc_sync_state);
+
 static int __init icc_init(void)
 {
+	struct device_node *root = of_find_node_by_path("/");
+
+	providers_count = of_count_icc_providers(root);
+	of_node_put(root);
+
 	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
 	debugfs_create_file("interconnect_summary", 0444,
 			    icc_debugfs_dir, NULL, &icc_summary_fops);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 520f70fe5a31..f713308b8a8f 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -75,6 +75,8 @@ struct icc_provider {
  * @req_list: a list of QoS constraint requests associated with this node
  * @avg_bw: aggregated value of average bandwidth requests from all consumers
  * @peak_bw: aggregated value of peak bandwidth requests from all consumers
+ * @init_avg: average bandwidth value that is read from the hardware during init
+ * @init_peak: peak bandwidth value that is read from the hardware during init
  * @data: pointer to private data
  */
 struct icc_node {
@@ -91,6 +93,8 @@ struct icc_node {
 	struct hlist_head	req_list;
 	u32			avg_bw;
 	u32			peak_bw;
+	u32			init_avg;
+	u32			init_peak;
 	void			*data;
 };
 
@@ -108,6 +112,7 @@ int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
 struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
+void icc_sync_state(struct device *dev);
 
 #else
 
