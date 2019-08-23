Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD979B220
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395217AbfHWOhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 10:37:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38306 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391043AbfHWOhG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 10:37:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CD751A06D9;
        Fri, 23 Aug 2019 16:37:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E986B1A06D1;
        Fri, 23 Aug 2019 16:37:03 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D8C45205D9;
        Fri, 23 Aug 2019 16:37:02 +0200 (CEST)
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
Subject: [RFCv4 1/7] PM / devfreq: Add devfreq_get_devfreq_by_node
Date:   Fri, 23 Aug 2019 17:36:54 +0300
Message-Id: <71a13730eee8744d8468aee8fa355958706035dd.1566570260.git.leonard.crestez@nxp.com>
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

Split off part of devfreq_get_devfreq_by_phandle into a separate
function. This allows callers to fetch devfreq instances by enumerating
devicetree instead of explicit phandles.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 42 +++++++++++++++++++++++++++++----------
 include/linux/devfreq.h   |  1 +
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 687deadd08ed..57352a757d79 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -907,10 +907,33 @@ struct devfreq *devm_devfreq_add_device(struct device *dev,
 	return devfreq;
 }
 EXPORT_SYMBOL(devm_devfreq_add_device);
 
 #ifdef CONFIG_OF
+/*
+ * devfreq_get_devfreq_by_node - Get the devfreq device from devicetree
+ * @np - pointer to device_node
+ *
+ * return the instance of devfreq device
+ */
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	struct devfreq *devfreq;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (devfreq->dev.parent
+			&& devfreq->dev.parent->of_node == node) {
+			mutex_unlock(&devfreq_list_lock);
+			return devfreq;
+		}
+	}
+	mutex_unlock(&devfreq_list_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
 /*
  * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
  * @dev - instance to the given device
  * @index - index into list of devfreq
  *
@@ -929,25 +952,22 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 
 	node = of_parse_phandle(dev->of_node, "devfreq", index);
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	mutex_lock(&devfreq_list_lock);
-	list_for_each_entry(devfreq, &devfreq_list, node) {
-		if (devfreq->dev.parent
-			&& devfreq->dev.parent->of_node == node) {
-			mutex_unlock(&devfreq_list_lock);
-			of_node_put(node);
-			return devfreq;
-		}
-	}
-	mutex_unlock(&devfreq_list_lock);
+	devfreq = devfreq_get_devfreq_by_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return devfreq;
 }
+
 #else
+struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 {
 	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_OF */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d2c5bb7add0a..4b5cc80abbe3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -242,10 +242,11 @@ extern int devm_devfreq_register_notifier(struct device *dev,
 				unsigned int list);
 extern void devm_devfreq_unregister_notifier(struct device *dev,
 				struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
+extern struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
 extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 						int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
-- 
2.17.1

