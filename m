Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F59B222
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395227AbfHWOhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 10:37:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48470 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391113AbfHWOhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 10:37:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EAE4200749;
        Fri, 23 Aug 2019 16:37:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FE3120073F;
        Fri, 23 Aug 2019 16:37:05 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BA86205D9;
        Fri, 23 Aug 2019 16:37:04 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        kernel@pengutronix.de, linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv4 2/7] interconnect: Add of_icc_add_proxy
Date:   Fri, 23 Aug 2019 17:36:55 +0300
Message-Id: <022a38c6c1d461b6e0b0337a1364888cfa7aa8cc.1566570260.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On many SOCs there is no single node that describes the "interconnect",
instead are multiple pieces of bus fabric which already support scaling.

Add support for mapping multiple device nodes to the same icc_provider
(likely a platform-level singleton). This is implemented at the
devicetree parsing level: just add more device nodes which map to the
same icc_provider instead.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/interconnect/core.c           | 88 ++++++++++++++++++++++++---
 include/linux/interconnect-provider.h |  7 +++
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7b971228df38..01109e335baf 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -17,12 +17,19 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
 
+struct of_icc_proxy {
+	struct device_node *of_node;
+	struct icc_provider *provider;
+	struct list_head list_node;
+};
+
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
+static LIST_HEAD(icc_proxy_list);
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
 /**
  * struct icc_req - constraints that are attached to each node
@@ -267,10 +274,61 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
 
 	return icc_data->nodes[idx];
 }
 EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
 
+struct icc_provider *__of_icc_get_provider(struct device_node *np)
+{
+	struct of_icc_proxy *proxy;
+
+	lockdep_assert_held(&icc_lock);
+	list_for_each_entry(proxy, &icc_proxy_list, list_node)
+		if (proxy->of_node == np)
+			return proxy->provider;
+
+	return NULL;
+}
+
+static int __of_icc_add_proxy(struct device_node *np,
+			      struct icc_provider *provider)
+{
+	struct of_icc_proxy *proxy;
+
+	lockdep_assert_held(&icc_lock);
+	proxy = kmalloc(sizeof(*proxy), GFP_KERNEL);
+	if (!proxy)
+		return -ENOMEM;
+	proxy->of_node = np;
+	proxy->provider = provider;
+	list_add_tail(&proxy->list_node, &icc_proxy_list);
+
+	return 0;
+}
+
+/**
+ * of_icc_add_proxy() - Add another device_node for a provider
+ * @np: OF node to alias from
+ * @provider: Interconnect provider to map to
+ *
+ * Make another device_node map to the same provider.
+ *
+ * This lasts until icc_provider_del.
+ */
+int of_icc_add_proxy(struct device_node *np, struct icc_provider *provider)
+{
+	int ret;
+
+	mutex_lock(&icc_lock);
+
+	ret = __of_icc_add_proxy(np, provider);
+
+	mutex_unlock(&icc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_icc_add_proxy);
+
 /**
  * of_icc_get_from_provider() - Look-up interconnect node
  * @spec: OF phandle args to use for look-up
  *
  * Looks for interconnect provider under the node specified by @spec and if
@@ -279,23 +337,22 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
 static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
-	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
+	struct icc_node *node;
 
 	if (!spec || spec->args_count != 1)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-	list_for_each_entry(provider, &icc_providers, provider_list) {
-		if (provider->dev->of_node == spec->np)
-			node = provider->xlate(spec, provider->data);
-		if (!IS_ERR(node))
-			break;
-	}
+	provider = __of_icc_get_provider(spec->np);
+	if (provider)
+		node = provider->xlate(spec, provider->data);
+	else
+		node = ERR_PTR(-EPROBE_DEFER);
 	mutex_unlock(&icc_lock);
 
 	return node;
 }
 
@@ -744,17 +801,26 @@ EXPORT_SYMBOL_GPL(icc_node_del);
  *
  * Return: 0 on success, or an error code otherwise
  */
 int icc_provider_add(struct icc_provider *provider)
 {
+	int ret;
+
 	if (WARN_ON(!provider->set))
 		return -EINVAL;
 	if (WARN_ON(!provider->xlate))
 		return -EINVAL;
 
 	mutex_lock(&icc_lock);
 
+	if (provider->dev) {
+		ret = __of_icc_add_proxy(provider->dev->of_node, provider);
+		if (ret) {
+			mutex_unlock(&icc_lock);
+			return ret;
+		}
+	}
 	INIT_LIST_HEAD(&provider->nodes);
 	list_add_tail(&provider->provider_list, &icc_providers);
 
 	mutex_unlock(&icc_lock);
 
@@ -770,10 +836,12 @@ EXPORT_SYMBOL_GPL(icc_provider_add);
  *
  * Return: 0 on success, or an error code otherwise
  */
 int icc_provider_del(struct icc_provider *provider)
 {
+	struct of_icc_proxy *proxy, *tmp;
+
 	mutex_lock(&icc_lock);
 	if (provider->users) {
 		pr_warn("interconnect provider still has %d users\n",
 			provider->users);
 		mutex_unlock(&icc_lock);
@@ -785,10 +853,16 @@ int icc_provider_del(struct icc_provider *provider)
 		mutex_unlock(&icc_lock);
 		return -EBUSY;
 	}
 
 	list_del(&provider->provider_list);
+	list_for_each_entry_safe(proxy, tmp, &icc_proxy_list, list_node)
+		if (proxy->provider == provider) {
+			list_del(&proxy->list_node);
+			of_node_put(proxy->of_node);
+			kfree(proxy);
+		}
 	mutex_unlock(&icc_lock);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index b16f9effa555..e6773ecac164 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -98,10 +98,11 @@ int icc_link_create(struct icc_node *node, const int dst_id);
 int icc_link_destroy(struct icc_node *src, struct icc_node *dst);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+int of_icc_add_proxy(struct device_node *np, struct icc_provider *provider);
 
 #else
 
 static inline struct icc_node *icc_node_create(int id)
 {
@@ -138,8 +139,14 @@ static inline int icc_provider_add(struct icc_provider *provider)
 static inline int icc_provider_del(struct icc_provider *provider)
 {
 	return -ENOTSUPP;
 }
 
+static inline int of_icc_add_proxy(struct device_node *np,
+				   struct icc_provider *provider)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
-- 
2.17.1

