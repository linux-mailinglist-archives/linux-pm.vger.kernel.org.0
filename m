Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC41CF4F5
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgELMyG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729918AbgELMyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:54:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68AC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so16710167wmc.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNWwiClN9J9T7evLiY37kMNqf5NsweYzE/X+kyO+ICQ=;
        b=fb/gdTCqpL1JsDWySrHQAsWmzKLsAmNC8kb7AUayoG9sarsZqWcSb5Pk09D8XzqA1p
         IsxIzN3yujlsyaa+bNQmWFgFEuK9nOlaGXdECh5olK7XGlpiF7w6Hte+AJqqoo886rLL
         SEJn+f+0iQ2+LMgEo0qBmkb6aRQeJlSZFhGbAJp/JpMWK9LDqKKFDpq4CXSLD/kH6L/0
         54ttqL/usJ56e8NsQjvtWa83yj1ADUg7pBeh2pvJi54MnE+ZtXZYjfdpZr0g41T2rABJ
         6bzL+aP7tif3kP/EuNvDn09bSMtBYqwmW7ypia9NENet47814t4002slg077x9+65BoH
         +iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNWwiClN9J9T7evLiY37kMNqf5NsweYzE/X+kyO+ICQ=;
        b=IkpUAikPF1x8iQPWNNySjPUpA7cuIWKJNBATcAbrDv2Zy9bu1nd+bK5W3MBIQa96Tv
         0EmYjsYzrzZRvUt++Ya5I3Jq2no4ZbLtvd0KaqJYSDlh10Y84g9Bpbvsre5dAsj2MW5g
         Rbyt54bJoMYDvhy2Ae4eh5CkBGXA5/ndk3+oQ0SZQzTeEtBrMV2a0OQtuqtxD/7RZNmR
         hX23m/p7G3FxoeLoQT89stNqAaToswU0FjVy1HUjWfIXBSbf+XKEQR18nzElvyz/IHzG
         4vqiY5CbiYO+N9/dm3MJSgznHvJMgOOc7jfmEedjwZ861i4MmXLmI7SkksDvh/u8CNWr
         Hcrw==
X-Gm-Message-State: AGi0Pub5X+Tqn2vt/24ma0+73M1o0Rt31ZsIvd6qgyT9KluUljCAL6JM
        GLVIY0kNKxoQVmW/aREo4bLvZQ==
X-Google-Smtp-Source: APiQypKfiJNyaLR5mbA1viBAxBp1qaLv2saXkd4v32ycysK7Z5vjIfcAtFC7yiv/VWvW/sNNC78iFw==
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr29620199wml.182.1589288040687;
        Tue, 12 May 2020 05:54:00 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:00 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 04/10] OPP: Add support for parsing interconnect bandwidth
Date:   Tue, 12 May 2020 15:53:21 +0300
Message-Id: <20200512125327.1868-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP bindings now support bandwidth values, so add support to parse it
from device tree and store it into the new dev_pm_opp_icc_bw struct, which
is part of the dev_pm_opp.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* Drop bandwidth requests and free memory in _opp_table_kref_release.
* Take into account the supply_count in struct size calculations.
* Free the temporary arrays for peak and average bandwidth.
* Fix the check for opp-level.
* Use dev_warn insted of dev_dbg.
* Rename _of_find_icc_paths to _of_find_icc_paths.
* Rename the variable count to supply_count.

 drivers/opp/Kconfig    |   1 +
 drivers/opp/core.c     |  27 +++++++--
 drivers/opp/of.c       | 121 ++++++++++++++++++++++++++++++++++++++++-
 drivers/opp/opp.h      |   9 +++
 include/linux/pm_opp.h |  12 ++++
 5 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
index 35dfc7e80f92..230d2b84436c 100644
--- a/drivers/opp/Kconfig
+++ b/drivers/opp/Kconfig
@@ -2,6 +2,7 @@
 config PM_OPP
 	bool
 	select SRCU
+	depends on INTERCONNECT || !INTERCONNECT
 	---help---
 	  SOCs have a standard set of tuples consisting of frequency and
 	  voltage pairs that the device will support per voltage domain. This
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ce7e4103ec09..a3dd0bc9b9f6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -999,6 +999,12 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 				ret);
 	}
 
+	/* Find interconnect path(s) for the device */
+	ret = _of_find_icc_paths(opp_table, dev);
+	if (ret)
+		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
+			 __func__, ret);
+
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
@@ -1057,6 +1063,7 @@ static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev, *temp;
+	int i;
 
 	_of_clear_opp_table(opp_table);
 
@@ -1064,6 +1071,12 @@ static void _opp_table_kref_release(struct kref *kref)
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
 
+	if (opp_table->paths) {
+		for (i = 0; i < opp_table->path_count; i++)
+			icc_put(opp_table->paths[i]);
+		kfree(opp_table->paths);
+	}
+
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
@@ -1243,19 +1256,22 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
-	int count, supply_size;
+	int supply_count, supply_size, icc_size;
 
 	/* Allocate space for at least one supply */
-	count = table->regulator_count > 0 ? table->regulator_count : 1;
-	supply_size = sizeof(*opp->supplies) * count;
+	supply_count = table->regulator_count > 0 ? table->regulator_count : 1;
+	supply_size = sizeof(*opp->supplies) * supply_count;
+	icc_size = sizeof(*opp->bandwidth) * table->path_count;
 
 	/* allocate new OPP node and supplies structures */
-	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
+	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
+
 	if (!opp)
 		return NULL;
 
 	/* Put the supplies at the end of the OPP structure as an empty array */
 	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
+	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
 	INIT_LIST_HEAD(&opp->node);
 
 	return opp;
@@ -1290,6 +1306,9 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
 {
 	if (opp1->rate != opp2->rate)
 		return opp1->rate < opp2->rate ? -1 : 1;
+	if (opp1->bandwidth && opp2->bandwidth &&
+	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
+		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
 	if (opp1->level != opp2->level)
 		return opp1->level < opp2->level ? -1 : 1;
 	return 0;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 5179f034751a..d139ad8c8f4f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -332,6 +332,58 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	return ret;
 }
 
+int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev)
+{
+	struct device_node *np;
+	int ret, i, count, num_paths;
+
+	np = of_node_get(dev->of_node);
+	if (!np)
+		return 0;
+
+	count = of_count_phandle_with_args(np, "interconnects",
+					   "#interconnect-cells");
+	of_node_put(np);
+	if (count < 0)
+		return 0;
+
+	/* two phandles when #interconnect-cells = <1> */
+	if (count % 2) {
+		dev_err(dev, "%s: Invalid interconnects values\n", __func__);
+		return -EINVAL;
+	}
+
+	num_paths = count / 2;
+	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
+				   GFP_KERNEL);
+	if (!opp_table->paths)
+		return -ENOMEM;
+
+	for (i = 0; i < num_paths; i++) {
+		opp_table->paths[i] = of_icc_get_by_index(dev, i);
+		if (IS_ERR(opp_table->paths[i])) {
+			ret = PTR_ERR(opp_table->paths[i]);
+			if (ret != -EPROBE_DEFER) {
+				dev_err(dev, "%s: Unable to get path%d: %d\n",
+					__func__, i, ret);
+			}
+			goto err;
+		}
+	}
+	opp_table->path_count = num_paths;
+
+	return 0;
+
+err:
+	while (i--)
+		icc_put(opp_table->paths[i]);
+
+	kfree(opp_table->paths);
+	opp_table->paths = NULL;
+
+	return ret;
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -524,8 +576,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
 			 bool *rate_not_available)
 {
+	struct property *peak, *avg;
+	u32 *peak_bw, *avg_bw;
 	u64 rate;
-	int ret;
+	int ret, i, count;
+	bool found = false;
 
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (!ret) {
@@ -535,10 +590,72 @@ static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np,
 		 * bit guaranteed in clk API.
 		 */
 		new_opp->rate = (unsigned long)rate;
+		found = true;
 	}
 	*rate_not_available = !!ret;
 
-	of_property_read_u32(np, "opp-level", &new_opp->level);
+	peak = of_find_property(np, "opp-peak-kBps", NULL);
+	if (peak) {
+		/*
+		 * Bandwidth consists of peak and average (optional) values:
+		 * opp-peak-kBps = <path1_value path2_value>;
+		 * opp-avg-kBps = <path1_value path2_value>;
+		 */
+		count = peak->length / sizeof(u32);
+		peak_bw = kmalloc_array(count, sizeof(*peak_bw), GFP_KERNEL);
+		if (!peak_bw)
+			return -ENOMEM;
+
+		ret = of_property_read_u32_array(np, "opp-peak-kBps", peak_bw,
+						 count);
+		if (ret) {
+			pr_err("%s: Error parsing opp-peak-kBps: %d\n",
+			       __func__, ret);
+			goto free_peak_bw;
+		}
+
+		for (i = 0; i < count; i++)
+			new_opp->bandwidth[i].peak = kBps_to_icc(peak_bw[i]);
+
+		found = true;
+		kfree(peak_bw);
+	}
+
+	avg = of_find_property(np, "opp-avg-kBps", NULL);
+	if (peak && avg) {
+		count = avg->length / sizeof(u32);
+		avg_bw = kmalloc_array(count, sizeof(*avg_bw), GFP_KERNEL);
+		if (!avg_bw) {
+			ret = -ENOMEM;
+			goto free_peak_bw;
+		}
+
+		ret = of_property_read_u32_array(np, "opp-avg-kBps", avg_bw,
+						 count);
+		if (ret) {
+			pr_err("%s: Error parsing opp-avg-kBps: %d\n",
+			       __func__, ret);
+			goto free_avg_bw;
+		}
+
+		for (i = 0; i < count; i++)
+			new_opp->bandwidth[i].avg = kBps_to_icc(avg_bw[i]);
+
+		kfree(avg_bw);
+	}
+
+	if (!of_property_read_u32(np, "opp-level", &new_opp->level))
+		found = true;
+
+	if (found)
+		return 0;
+
+	return ret;
+
+free_avg_bw:
+	kfree(avg_bw);
+free_peak_bw:
+	kfree(peak_bw);
 
 	return ret;
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index bcadb1e328a4..17d45119d9bc 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -12,6 +12,7 @@
 #define __DRIVER_OPP_H__
 
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -59,6 +60,7 @@ extern struct list_head opp_tables;
  * @rate:	Frequency in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
+ * @bandwidth:	Interconnect bandwidth values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
  * @required_opps: List of OPPs that are required by this OPP.
@@ -81,6 +83,7 @@ struct dev_pm_opp {
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
+	struct dev_pm_opp_icc_bw *bandwidth;
 
 	unsigned long clock_latency_ns;
 
@@ -146,6 +149,8 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
  * property).
+ * @paths: Interconnect path handles
+ * @path_count: Number of interconnect paths
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
@@ -189,6 +194,8 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
+	struct icc_path **paths;
+	unsigned int path_count;
 	bool genpd_performance_state;
 	bool is_genpd;
 
@@ -224,12 +231,14 @@ void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
+int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
+static inline int _of_find_icc_paths(struct opp_table *opp_table, struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 747861816f4f..cfceb0290401 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -41,6 +41,18 @@ struct dev_pm_opp_supply {
 	unsigned long u_amp;
 };
 
+/**
+ * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
+ * @avg:	Average bandwidth corresponding to this OPP (in icc units)
+ * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
+ *
+ * This structure stores the bandwidth values for a single interconnect path.
+ */
+struct dev_pm_opp_icc_bw {
+	u32 avg;
+	u32 peak;
+};
+
 /**
  * struct dev_pm_opp_info - OPP freq/voltage/current values
  * @rate:	Target clk rate in hz
