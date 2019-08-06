Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA28F8305D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfHFLMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 07:12:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54204 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732732AbfHFLMg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B8CAA1A00CD;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1FB31A00B7;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FA05205DD;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: [RFC 3/4] opp: Add dev_pm_parse_required_opp_as_qos
Date:   Tue,  6 Aug 2019 14:12:27 +0300
Message-Id: <0a7339f8b35d58c2272ce9fb7c025a5628afd921.1565089196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "required-opps" property can be placed on any device and point to
any OPP table according to bindings doc but this is not fully
implemented. In practice it can only point from the opp table of a
device to the opp table of a power domain.

Add support for parsing "required-opps" as a DEV_PM_QOS_MIN_FREQUENCY
request.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/opp/of.c       | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  9 ++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1813f5ad5fa2..a086bb120fec 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -16,10 +16,11 @@
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/energy_model.h>
+#include <linux/pm_qos.h>
 
 #include "opp.h"
 
 /*
  * Returns opp descriptor node for a device node, caller must
@@ -1119,5 +1120,69 @@ void dev_pm_opp_of_register_em(struct cpumask *cpus)
 		return;
 
 	em_register_perf_domain(cpus, nr_opp, &em_cb);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
+
+int dev_pm_parse_required_opp_as_qos(struct device_node *node,
+				     struct dev_pm_qos_request *req)
+{
+	struct device_node *opp_node;
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	struct device *req_dev;
+	unsigned long req_val;
+	int ret;
+
+	mutex_lock(&opp_table_lock);
+
+	opp_node = of_parse_required_opp(node, 0);
+	if (!opp_node) {
+		ret = -ENOENT;
+		goto unlock_opp_tables;
+	}
+
+	opp_table = _find_table_of_opp_np(opp_node);
+	if (IS_ERR(opp_table)) {
+		ret = -EPROBE_DEFER;
+		goto put_opp_node;
+	}
+
+	opp = _find_opp_of_np(opp_table, opp_node);
+	if (!opp) {
+		ret = -ENOENT;
+		goto put_opp_table;
+	}
+
+	req_dev = dev_pm_opp_table_get_device(opp_table);
+	if (IS_ERR(req_dev)) {
+		pr_err("%pOF: failed to fetch device for table %pOF\n",
+				node, opp_table->np);
+		ret = PTR_ERR(req_dev);
+		goto put_opp;
+	}
+
+	req_val = dev_pm_opp_get_freq(opp);
+	if (req_val > S32_MAX) {
+		ret = -ERANGE;
+		goto put_opp;
+	}
+
+	mutex_unlock(&opp_table_lock);
+
+	ret = dev_pm_qos_add_request(req_dev, req,
+			DEV_PM_QOS_MIN_FREQUENCY, req_val);
+	if (ret < 0)
+		pr_err("%pOF: failed to add dev_pm_qos request: %d\n", node, ret);
+	ret = 0;
+
+put_opp:
+	dev_pm_opp_put(opp);
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
+put_opp_node:
+	of_node_put(opp_node);
+unlock_opp_tables:
+	mutex_unlock(&opp_table_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_parse_required_opp_as_qos);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a4db3f42d787..949c35e8f5ae 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -17,10 +17,11 @@
 struct clk;
 struct regulator;
 struct dev_pm_opp;
 struct device;
 struct opp_table;
+struct dev_pm_qos_request;
 
 enum dev_pm_opp_event {
 	OPP_EVENT_ADD, OPP_EVENT_REMOVE, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE,
 };
 
@@ -352,10 +353,12 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
+int dev_pm_parse_required_opp_as_qos(struct device_node *node,
+				     struct dev_pm_qos_request *req);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
 	return -ENOTSUPP;
 }
@@ -399,8 +402,14 @@ static inline void dev_pm_opp_of_register_em(struct cpumask *cpus)
 
 static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	return -ENOTSUPP;
 }
+
+int dev_pm_parse_required_opp_as_qos(struct device_node *node,
+				     struct dev_pm_qos_request *req)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.17.1

