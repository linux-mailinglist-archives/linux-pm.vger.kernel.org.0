Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9789423DFA9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHFRvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgHFQcV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73BC02B8C1
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so9393759wmk.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89sbNvX6ByvD6Ay+Fn+uPrui3FWgVd/+bGNAilB1it4=;
        b=S/MUgXPZ1MTFSxm+FwPoBEU/CYFWgc/8fcYf49DWdR6W1gQIwyfPvAuhl6Fgv9J6ND
         posY1yvn36+il648dX2/VxyEg09FDwnfx6/9UHQKjO0jCdNDNUqu3p3GkoYq3se8xpFy
         b15ZJfMal66TM0CLaeWSvYg4NVr0F1s5wP1r9ONlub/h7N1QDnezZhHVCK7L8nrjo7Gf
         4o8nP2aZuclOXZWvfwJKSL3G9PidRZJqMCrmaYdeP57X3OMTRtwxcom17JcaNdgMKdlU
         3e2CUgnr0B4wSSAG0RzbYJTz3MWY+4qxKt9NGdl14XGvwOsRnDgacL8aIR1RurCy/oB2
         RK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89sbNvX6ByvD6Ay+Fn+uPrui3FWgVd/+bGNAilB1it4=;
        b=LpSBELxZIuRMvVvPmk0sbUrqj8YjExRnOYsI1sLpCk6F6LctdPJSAHYp+W+ahwEqCr
         PLQzKLgctEbMnm6t15NOZgqtOyM2aXLaBt++ZIxlhmnNemJ3fxLwdLm/lXPiCHRdKLyL
         H9EkXyqSRnnbhtHiMxZvdpQHEHaJO8J14dDoUIZN+lx+SDAWBVB7IDcRfiHoC52I7q9+
         /nqrh1+OdvfbNefA6M4az4v5ZHH5IYadLiah5KISZahkmY8rmg0vPr8nZHsrOF5urgip
         GzX6E5mpHvT097SOBpJMNN1GMvfNLMNzLqsDVQ2GHuSKaSzQpiMQNKOBCFkc/Fh1pJ+V
         FSag==
X-Gm-Message-State: AOAM532u3j2f8fsC2sj5LjUDUuxPBIsG1MiBPF6ycgEoqG4lV8cOm/7S
        6H9h6ud3Vre2aZTcWC0hZEoj0fs5yrE=
X-Google-Smtp-Source: ABdhPJyFB2+t9EpOQ+hBTBA02b5nhQZjVGhO6jfWF3l3/z9sJn0Tqh5RyYZ4NidGmcJuCuQt40OBPg==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr9183839wmi.10.1596731490536;
        Thu, 06 Aug 2020 09:31:30 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:29 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] interconnect: Introduce xlate_extended() callback
Date:   Thu,  6 Aug 2020 19:31:20 +0300
Message-Id: <20200806163126.22667-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently there is the xlate() callback, which is used by providers for
mapping the nodes from phandle arguments. That's fine for simple mappings,
but the phandle arguments could contain an additional data, such as tag
information. Let's create another callback xlate_extended() for the cases
where providers want also populate the path tag data.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 73 ++++++++++++++++++---------
 include/linux/interconnect-provider.h | 17 ++++++-
 2 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index befd111049c0..6ccf55818e68 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -336,12 +336,13 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Looks for interconnect provider under the node specified by @spec and if
  * found, uses xlate function of the provider to map phandle args to node.
  *
- * Returns a valid pointer to struct icc_node on success or ERR_PTR()
+ * Returns a valid pointer to struct icc_node_data on success or ERR_PTR()
  * on failure.
  */
-struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
+	struct icc_node_data *data = NULL;
 	struct icc_provider *provider;
 
 	if (!spec)
@@ -349,14 +350,33 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	mutex_lock(&icc_lock);
 	list_for_each_entry(provider, &icc_providers, provider_list) {
-		if (provider->dev->of_node == spec->np)
-			node = provider->xlate(spec, provider->data);
-		if (!IS_ERR(node))
-			break;
+		if (provider->dev->of_node == spec->np) {
+			if (provider->xlate_extended) {
+				data = provider->xlate_extended(spec, provider->data);
+				if (!IS_ERR(data)) {
+					node = data->node;
+					break;
+				}
+			} else {
+				node = provider->xlate(spec, provider->data);
+				if (!IS_ERR(node))
+					break;
+			}
+		}
 	}
 	mutex_unlock(&icc_lock);
 
-	return node;
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	if (!data) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return ERR_PTR(-ENOMEM);
+		data->node = node;
+	}
+
+	return data;
 }
 EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
@@ -403,7 +423,7 @@ EXPORT_SYMBOL_GPL(devm_of_icc_get);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 {
 	struct icc_path *path;
-	struct icc_node *src_node, *dst_node;
+	struct icc_node_data *src_data, *dst_data;
 	struct device_node *np;
 	struct of_phandle_args src_args, dst_args;
 	int ret;
@@ -441,39 +461,46 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 
 	of_node_put(dst_args.np);
 
-	src_node = of_icc_get_from_provider(&src_args);
+	src_data = of_icc_get_from_provider(&src_args);
 
-	if (IS_ERR(src_node)) {
-		if (PTR_ERR(src_node) != -EPROBE_DEFER)
+	if (IS_ERR(src_data)) {
+		if (PTR_ERR(src_data) != -EPROBE_DEFER)
 			dev_err(dev, "error finding src node: %ld\n",
-				PTR_ERR(src_node));
-		return ERR_CAST(src_node);
+				PTR_ERR(src_data));
+		return ERR_CAST(src_data);
 	}
 
-	dst_node = of_icc_get_from_provider(&dst_args);
+	dst_data = of_icc_get_from_provider(&dst_args);
 
-	if (IS_ERR(dst_node)) {
-		if (PTR_ERR(dst_node) != -EPROBE_DEFER)
+	if (IS_ERR(dst_data)) {
+		if (PTR_ERR(dst_data) != -EPROBE_DEFER)
 			dev_err(dev, "error finding dst node: %ld\n",
-				PTR_ERR(dst_node));
-		return ERR_CAST(dst_node);
+				PTR_ERR(dst_data));
+		kfree(src_data);
+		return ERR_CAST(dst_data);
 	}
 
 	mutex_lock(&icc_lock);
-	path = path_find(dev, src_node, dst_node);
+	path = path_find(dev, src_data->node, dst_data->node);
 	mutex_unlock(&icc_lock);
 	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
-		return path;
+		goto free_icc_data;
 	}
 
+	if (src_data->tag && src_data->tag == dst_data->tag)
+		icc_set_tag(path, src_data->tag);
+
 	path->name = kasprintf(GFP_KERNEL, "%s-%s",
-			       src_node->name, dst_node->name);
+			       src_data->node->name, dst_data->node->name);
 	if (!path->name) {
 		kfree(path);
-		return ERR_PTR(-ENOMEM);
+		path = ERR_PTR(-ENOMEM);
 	}
 
+free_icc_data:
+	kfree(src_data);
+	kfree(dst_data);
 	return path;
 }
 EXPORT_SYMBOL_GPL(of_icc_get_by_index);
@@ -975,7 +1002,7 @@ int icc_provider_add(struct icc_provider *provider)
 {
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
-	if (WARN_ON(!provider->xlate))
+	if (WARN_ON(!provider->xlate && !provider->xlate_extended))
 		return -EINVAL;
 
 	mutex_lock(&icc_lock);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4735518de515..4d535fddd5d3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -14,6 +14,17 @@
 struct icc_node;
 struct of_phandle_args;
 
+/**
+ * struct icc_node_data - icc node data
+ *
+ * @node: icc node
+ * @tag: tag
+ */
+struct icc_node_data {
+	struct icc_node *node;
+	u32 tag;
+};
+
 /**
  * struct icc_onecell_data - driver data for onecell interconnect providers
  *
@@ -39,6 +50,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @pre_aggregate: pointer to device specific function that is called
  *		   before the aggregation begins (optional)
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
+ * @xlate_extended: vendor-specific callback for mapping node data from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
  * @inter_set: whether inter-provider pairs will be configured with @set
@@ -52,6 +64,7 @@ struct icc_provider {
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
+	struct icc_node_data* (*xlate_extended)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
 	bool			inter_set;
@@ -105,7 +118,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
-struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
+struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -157,7 +170,7 @@ static inline int icc_provider_del(struct icc_provider *provider)
 	return -ENOTSUPP;
 }
 
-static inline struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
