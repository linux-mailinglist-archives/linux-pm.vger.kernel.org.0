Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25448FBC72
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 00:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMXVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 18:21:42 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58166 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKMXVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 18:21:41 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2399D2001EB;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15F8D200139;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98314205D5;
        Thu, 14 Nov 2019 00:21:39 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH 3/5] PM / devfreq: Move more initialization before registration
Date:   Thu, 14 Nov 2019 01:21:33 +0200
Message-Id: <e4d49c5951b0050b61f0917b4f4f7ed42f7aecf8.1573686315.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573686315.git.leonard.crestez@nxp.com>
References: <cover.1573686315.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1573686315.git.leonard.crestez@nxp.com>
References: <cover.1573686315.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In general it is a better to initialize an object before making it
accessible externally (through device_add). This simplifies the code and
makes it possible to avoid locking the partially initialized object.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b89a82382536..b38e98853fda 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -725,43 +725,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
-	dev_set_name(&devfreq->dev, "devfreq%d",
-				atomic_inc_return(&devfreq_no));
-	err = device_add(&devfreq->dev);
-	if (err) {
-		mutex_unlock(&devfreq->lock);
-		goto err_dev;
-	}
-
 	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
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
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
 			sizeof(unsigned long),
 			GFP_KERNEL);
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
+	err = device_add(&devfreq->dev);
+	if (err) {
+		mutex_unlock(&devfreq->lock);
+		goto err_dev;
+	}
+
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
@@ -787,11 +787,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	return devfreq;
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-err_devfreq:
 	devfreq_remove_device(devfreq);
 	return ERR_PTR(err);
 err_dev:
 	put_device(&devfreq->dev);
 err_out:
-- 
2.17.1

