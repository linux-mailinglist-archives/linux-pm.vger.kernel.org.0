Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D92296CE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgGVLBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgGVLBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2020 07:01:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFDC0619DF
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2020 04:01:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so1445903wrw.12
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2020 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb4TDwngKstdYsXu7RUzjZ9eyxkXyxQaDZSnxs4t1+Y=;
        b=N60bJeq90gF41M58w7DHRMQvF6qMoRnkCpkk5WCEHbDJW0aHQ6I4402GfkkTroitnv
         DxGEB6UcyEovmUTMewJhlshvkGdmcaqwzbcqdfA9nxgw8Spu298DxnjSikpWRXypTvC8
         dQSOOG0oVp3kRk+4vQZBFRagUdUm0V8zL5nCuMACDngI5NldIASAtY9m3s+pDNjYVNEZ
         Ga8vzcgGqEaScwPGpp2H60wF2eh+4Q9q9UsO3QEH84g81YpAwV7+Ti9bty7qsYWIdfSA
         uYRKddOBJ/AArr/opFW0AMFu8JnJf8jQZLjQoYGrQLEdLYE7a2pVrXYOpPbKi3sQdRLd
         RSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb4TDwngKstdYsXu7RUzjZ9eyxkXyxQaDZSnxs4t1+Y=;
        b=rmgaS3Pt8Wx1rtQNpkVmXxjAeyHlOxE68ijPPdWaiuIDR2bMY8ewz4O3da/zDJY3vu
         cfwJnXO97kn+hMdCpHsN6D++ujRDVYXdWCIgaFL6xUHtDurEesl8LurBWp0EgUNvinzM
         kql8188abYbQ8X+K6RkshtsY5yp9CZf69xJgqHe08VHMl29RY62I0D1uRCqHNy7EamXb
         b7CAZwaaDoibj3VVmL+QaybKhuk/layhtelLnMIMpO3daDFjp98w61UM0eNr5S0TBsGY
         pB9EzoRBC6yN8u8ShtGK+nQAlSMxEAsVGaFeYfKdaxm4hHLHFEtOzyFFGylWsOZNzzcX
         H5Jg==
X-Gm-Message-State: AOAM531NdetsTyO3TfYXeGlr0x6mcFQWNfng1eYa0avZN5Zanbo1XzR2
        j6Lq4tlptpm7KAv7PMGYGv5/+JXEBso=
X-Google-Smtp-Source: ABdhPJyVFEACUDVgyJ7BwW37Wm8jOezlYQOmluktE5flWxq8GlmeRLwB1J95+gBWQAjMSub6hpTORA==
X-Received: by 2002:adf:cd8b:: with SMTP id q11mr22330993wrj.98.1595415701114;
        Wed, 22 Jul 2020 04:01:41 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y6sm41256164wrr.74.2020.07.22.04.01.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 04:01:40 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] interconnect: Add sync state support
Date:   Wed, 22 Jul 2020 14:01:38 +0300
Message-Id: <20200722110139.24778-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722110139.24778-1-georgi.djakov@linaro.org>
References: <20200722110139.24778-1-georgi.djakov@linaro.org>
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
 drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  5 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e5f998744501..0c4e38d9f1fa 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -26,6 +26,8 @@
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
+static int providers_count;
+static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
@@ -255,6 +257,12 @@ static int aggregate_requests(struct icc_node *node)
 			continue;
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+
+		/* during boot use the initial bandwidth as a floor value */
+		if (!synced_state) {
+			node->avg_bw = max(node->avg_bw, node->init_avg);
+			node->peak_bw = max(node->peak_bw, node->init_peak);
+		}
 	}
 
 	return 0;
@@ -919,6 +927,13 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
 
+	/* get the initial bandwidth values and sync them with hardware */
+	if ((node->init_avg || node->init_peak) && provider->set) {
+		node->avg_bw = node->init_avg;
+		node->peak_bw = node->init_peak;
+		provider->set(node, node);
+	}
+
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1014,8 +1029,54 @@ int icc_provider_del(struct icc_provider *provider)
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
index 0c494534b4d3..aa85b96296c4 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -71,6 +71,8 @@ struct icc_provider {
  * @req_list: a list of QoS constraint requests associated with this node
  * @avg_bw: aggregated value of average bandwidth requests from all consumers
  * @peak_bw: aggregated value of peak bandwidth requests from all consumers
+ * @init_avg: average bandwidth value that is read from the hardware during init
+ * @init_peak: peak bandwidth value that is read from the hardware during init
  * @data: pointer to private data
  */
 struct icc_node {
@@ -87,6 +89,8 @@ struct icc_node {
 	struct hlist_head	req_list;
 	u32			avg_bw;
 	u32			peak_bw;
+	u32			init_avg;
+	u32			init_peak;
 	void			*data;
 };
 
@@ -103,6 +107,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+void icc_sync_state(struct device *dev);
 
 #else
 
