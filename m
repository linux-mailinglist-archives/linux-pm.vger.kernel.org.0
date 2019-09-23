Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900A2BBD97
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIWVKk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:10:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34878 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388859AbfIWVKk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 17:10:40 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 34FF2200360;
        Mon, 23 Sep 2019 23:10:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26F8B200223;
        Mon, 23 Sep 2019 23:10:38 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D65820613;
        Mon, 23 Sep 2019 23:10:37 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 2/6] PM / devfreq: Move more initialization before registration
Date:   Tue, 24 Sep 2019 00:10:30 +0300
Message-Id: <bf55208ff3ef868dcee46b52e91f717a6add5606.1569272883.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569272883.git.leonard.crestez@nxp.com>
References: <cover.1569272883.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1569272883.git.leonard.crestez@nxp.com>
References: <cover.1569272883.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In general it is a better to initialize an object before making it
accessible externally (through device_register).

This makes it possible to avoid relying on locking a partially
initialized object.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f5bea7350f72..8bbcd4efa09f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -588,10 +588,12 @@ static void devfreq_dev_release(struct device *dev)
 	mutex_unlock(&devfreq_list_lock);
 
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	kfree(devfreq->time_in_state);
+	kfree(devfreq->trans_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
 
 /**
@@ -671,44 +673,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
-	dev_set_name(&devfreq->dev, "devfreq%d",
-				atomic_inc_return(&devfreq_no));
-	err = device_register(&devfreq->dev);
-	if (err) {
-		mutex_unlock(&devfreq->lock);
-		put_device(&devfreq->dev);
-		goto err_out;
-	}
-
-	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+	devfreq->trans_table = kzalloc(
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
 	if (!devfreq->trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
-		goto err_devfreq;
+		goto err_dev;
 	}
 
-	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-			devfreq->profile->max_state,
-			sizeof(unsigned long),
-			GFP_KERNEL);
+	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
+					 sizeof(unsigned long),
+					 GFP_KERNEL);
 	if (!devfreq->time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
-		goto err_devfreq;
+		goto err_dev;
 	}
 
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
+	dev_set_name(&devfreq->dev, "devfreq%d",
+				atomic_inc_return(&devfreq_no));
+	err = device_register(&devfreq->dev);
+	if (err) {
+		mutex_unlock(&devfreq->lock);
+		put_device(&devfreq->dev);
+		goto err_out;
+	}
+
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
@@ -734,14 +735,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	return devfreq;
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-err_devfreq:
 	devfreq_remove_device(devfreq);
-	devfreq = NULL;
+	return ERR_PTR(err);
+
 err_dev:
+	/*
+	 * Cleanup path for errors that happen before registration.
+	 * Otherwise we rely on devfreq_dev_release.
+	 */
+	kfree(devfreq->time_in_state);
+	kfree(devfreq->trans_table);
 	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(devfreq_add_device);
-- 
2.17.1

