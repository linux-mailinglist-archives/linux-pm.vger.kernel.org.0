Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93771219ECB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGILHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 07:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgGILHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 07:07:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98473C061A0B
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 04:07:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so6015895wmc.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATfnw728aYA7yiuUsLy6/P7+SZIW7XuVCwpr30Cblyc=;
        b=HBmfbmcoS3oSP0tUmNy33ILiAMRLDlbvxZLL28SOIIGZF/C+kBzEUCLS7qyeA4kKG3
         vEOih1VqibdSZq1YFAnmosKbwgKEHNCdrcv+m6fNf+sHhEw1uS8VPs4HKWvYgYWwfMqI
         VLqFLLBxuc68NQxsdqxWnD7IX4+4vans68uUZlfQLx8pPjLCzhz2z7ypHzylu2jDCiNG
         YPDEVoZtr9vTrm7aI+EgsZYl0eXCJI5xYGoQYqZDb4Bw2GX8FItgb2YrNZ0OmT6xBErK
         0WNs1DPvuhcgxPGPZvqfcUTD5bAoQe1Y8Z+SuxiHUVsvi5tncEnvbI5Qm8gs2600meGB
         ECMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATfnw728aYA7yiuUsLy6/P7+SZIW7XuVCwpr30Cblyc=;
        b=jA25V6qNGhYFWG6r7seAIhhDVxoc1SMt2BYQqntRG0ZH4OFuVm6LZiNBftnsVUnVSi
         MDLXBI30MsdH5c2eRRq3oI9faK0PUXagZrNdhPNyNIeB84+YDUEpMttbUu3QQ6PrWjok
         sZDYNBmBTlgywL6lHPc9UxdcXdwK2VX7F5Wc16H4qkxbIJnWtK9oD08/WhaJNBKfY4Ah
         zW4ZcgIr3EdVKi16VF095wdRHayyY6lTFijw/SQzdX1LYdh7xMeLh/0qpFiKRtycNA6B
         mOVHwz6uoAJ4XX6xcbtPokma4CAfgmZzw0fRue97kdCdcaKWyK5XMTUFTxG8CLrNKAoJ
         BLoQ==
X-Gm-Message-State: AOAM532vA8dY8g4o3xzpfhBsRtU4fmx7B6SOOAEEwthhDgHKMmzehS7H
        D/8JIyx68TQWzBaEr9pCH2cR38M772E=
X-Google-Smtp-Source: ABdhPJy638SANQ1lHws0vfG/w0IRWANsMDY7dasDL0vdZGK91DujiB9ZfLBEesPo3yzxE7p1FQd9og==
X-Received: by 2002:a1c:9650:: with SMTP id y77mr13540564wmd.101.1594292830479;
        Thu, 09 Jul 2020 04:07:10 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:09 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] interconnect: Add sync state support
Date:   Thu,  9 Jul 2020 14:07:02 +0300
Message-Id: <20200709110705.30359-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709110705.30359-1-georgi.djakov@linaro.org>
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
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
 drivers/interconnect/core.c           | 56 +++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  3 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e5f998744501..e53adfee1ee3 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -26,6 +26,8 @@
 
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
+static int providers_count;
+static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
@@ -255,6 +257,10 @@ static int aggregate_requests(struct icc_node *node)
 			continue;
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
+
+		/* during boot use the initial bandwidth as a floor value */
+		if (!synced_state)
+			node->peak_bw = max(node->peak_bw, node->init_bw);
 	}
 
 	return 0;
@@ -919,6 +925,12 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
 
+	/* get the bandwidth value and sync it with the hardware */
+	if (node->init_bw && provider->set) {
+		node->peak_bw = node->init_bw;
+		provider->set(node, node);
+	}
+
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1014,8 +1026,52 @@ int icc_provider_del(struct icc_provider *provider)
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
+	list_for_each_entry(p, &icc_providers, provider_list) {
+		dev_dbg(p->dev, "interconnect provider is in synced state\n");
+		list_for_each_entry(n, &p->nodes, node_list) {
+			aggregate_requests(n);
+			p->set(n, n);
+		}
+	}
+	mutex_unlock(&icc_lock);
+	synced_state = true;
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
index 0c494534b4d3..153fb7616f96 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -71,6 +71,7 @@ struct icc_provider {
  * @req_list: a list of QoS constraint requests associated with this node
  * @avg_bw: aggregated value of average bandwidth requests from all consumers
  * @peak_bw: aggregated value of peak bandwidth requests from all consumers
+ * @init_bw: the bandwidth value that is read from the hardware during init
  * @data: pointer to private data
  */
 struct icc_node {
@@ -87,6 +88,7 @@ struct icc_node {
 	struct hlist_head	req_list;
 	u32			avg_bw;
 	u32			peak_bw;
+	u32			init_bw;
 	void			*data;
 };
 
@@ -103,6 +105,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+void icc_sync_state(struct device *dev);
 
 #else
 
