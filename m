Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7F9D0DE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 15:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfHZNon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 09:44:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55646 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731954AbfHZNon (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E684200251;
        Mon, 26 Aug 2019 15:44:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EAF820000C;
        Mon, 26 Aug 2019 15:44:40 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B809620605;
        Mon, 26 Aug 2019 15:44:39 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] PM / devfreq: Move opp notifier registration to core
Date:   Mon, 26 Aug 2019 16:44:33 +0300
Message-Id: <d5bb9bf47ea9ac8882525ff18e817da35304f2a7.1566826075.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566826075.git.leonard.crestez@nxp.com>
References: <cover.1566826075.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566826075.git.leonard.crestez@nxp.com>
References: <cover.1566826075.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An opp notifier can be registered by devfreq in order to respond to OPPs
being enabled or disabled at runtime (for example by thermal). This is
currently handled explicitly by drivers.

Move notifier handling to devfreq_add_device because this shouldn't be
hardware-specific.

Handling this inside the core also takes less code.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c    | 84 +++---------------------------------
 drivers/devfreq/exynos-bus.c |  7 ---
 drivers/devfreq/rk3399_dmc.c |  6 ---
 include/linux/devfreq.h      |  8 ----
 4 files changed, 6 insertions(+), 99 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f85c6628249f..c7123d8b6a33 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -667,20 +667,22 @@ static void devfreq_dev_release(struct device *dev)
 		return;
 	}
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
+	dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
 			DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
 			DEV_PM_QOS_MIN_FREQUENCY);
 
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	dev_pm_qos_remove_request(&devfreq->max_freq_req);
 	dev_pm_qos_remove_request(&devfreq->min_freq_req);
+	dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
 
 /**
@@ -729,11 +731,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->profile = profile;
 	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
-	devfreq->nb.notifier_call = devfreq_notifier_call;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		err = set_freq_table(devfreq);
 		if (err < 0)
 			goto err_dev;
@@ -816,10 +817,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
 	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
 				      DEV_PM_QOS_MAX_FREQUENCY);
 	if (err)
 		goto err_devfreq;
+	devfreq->nb.notifier_call = devfreq_notifier_call;
+	err = dev_pm_opp_register_notifier(dev, &devfreq->nb);
+	if (err)
+		goto err_devfreq;
 
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
@@ -1619,87 +1624,10 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 
 	return opp;
 }
 EXPORT_SYMBOL(devfreq_recommended_opp);
 
-/**
- * devfreq_register_opp_notifier() - Helper function to get devfreq notified
- *				     for any changes in the OPP availability
- *				     changes
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
-{
-	return dev_pm_opp_register_notifier(dev, &devfreq->nb);
-}
-EXPORT_SYMBOL(devfreq_register_opp_notifier);
-
-/**
- * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
- *				       notified for any changes in the OPP
- *				       availability changes anymore.
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- *
- * At exit() callback of devfreq_dev_profile, this must be included if
- * devfreq_recommended_opp is used.
- */
-int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
-{
-	return dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
-}
-EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
-
-static void devm_devfreq_opp_release(struct device *dev, void *res)
-{
-	devfreq_unregister_opp_notifier(dev, *(struct devfreq **)res);
-}
-
-/**
- * devm_devfreq_register_opp_notifier() - Resource-managed
- *					  devfreq_register_opp_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-int devm_devfreq_register_opp_notifier(struct device *dev,
-				       struct devfreq *devfreq)
-{
-	struct devfreq **ptr;
-	int ret;
-
-	ptr = devres_alloc(devm_devfreq_opp_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	ret = devfreq_register_opp_notifier(dev, devfreq);
-	if (ret) {
-		devres_free(ptr);
-		return ret;
-	}
-
-	*ptr = devfreq;
-	devres_add(dev, ptr);
-
-	return 0;
-}
-EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
-
-/**
- * devm_devfreq_unregister_opp_notifier() - Resource-managed
- *					    devfreq_unregister_opp_notifier()
- * @dev:	The devfreq user device. (parent of devfreq)
- * @devfreq:	The devfreq object.
- */
-void devm_devfreq_unregister_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq)
-{
-	WARN_ON(devres_release(dev, devm_devfreq_opp_release,
-			       devm_devfreq_dev_match, devfreq));
-}
-EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
-
 /**
  * devfreq_register_notifier() - Register a driver with devfreq
  * @devfreq:	The devfreq object.
  * @nb:		The notifier block to register.
  * @list:	DEVFREQ_TRANSITION_NOTIFIER.
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index d9f377912c10..2d9a4781f401 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -440,17 +440,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to add devfreq device\n");
 		ret = PTR_ERR(bus->devfreq);
 		goto err;
 	}
 
-	/* Register opp_notifier to catch the change of OPP  */
-	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
-	if (ret < 0) {
-		dev_err(dev, "failed to register opp notifier\n");
-		goto err;
-	}
-
 	/*
 	 * Enable devfreq-event to get raw data which is used to determine
 	 * current bus load.
 	 */
 	ret = exynos_bus_enable_edev(bus);
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2e65d7279d79..f660d2031e8a 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -454,12 +454,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	if (IS_ERR(data->devfreq)) {
 		ret = PTR_ERR(data->devfreq);
 		goto err_free_opp;
 	}
 
-	devm_devfreq_register_opp_notifier(dev, data->devfreq);
-
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
 	return 0;
 
@@ -470,14 +468,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 static int rk3399_dmcfreq_remove(struct platform_device *pdev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
 
-	/*
-	 * Before remove the opp table we need to unregister the opp notifier.
-	 */
-	devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
 	dev_pm_opp_of_remove_table(dmcfreq->dev);
 
 	return 0;
 }
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 4b5cc80abbe3..bf6ebfbc1e8a 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -220,18 +220,10 @@ extern void devfreq_resume(void);
 extern int update_devfreq(struct devfreq *devfreq);
 
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
-extern int devfreq_register_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq);
-extern int devfreq_unregister_opp_notifier(struct device *dev,
-					   struct devfreq *devfreq);
-extern int devm_devfreq_register_opp_notifier(struct device *dev,
-					      struct devfreq *devfreq);
-extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
-						struct devfreq *devfreq);
 extern int devfreq_register_notifier(struct devfreq *devfreq,
 					struct notifier_block *nb,
 					unsigned int list);
 extern int devfreq_unregister_notifier(struct devfreq *devfreq,
 					struct notifier_block *nb,
-- 
2.17.1

