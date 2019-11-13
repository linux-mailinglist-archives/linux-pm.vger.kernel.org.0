Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F50FBC74
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 00:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKMXVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 18:21:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56030 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfKMXVn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 18:21:43 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DC611A0A85;
        Thu, 14 Nov 2019 00:21:41 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 203581A0117;
        Thu, 14 Nov 2019 00:21:41 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A3E6D205D5;
        Thu, 14 Nov 2019 00:21:40 +0100 (CET)
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
Subject: [PATCH 5/5] PM / devfreq: Don't take lock in devfreq_add_device
Date:   Thu, 14 Nov 2019 01:21:35 +0200
Message-Id: <683876312e5657ad5405f826d5ab8f09d521883d.1573686315.git.leonard.crestez@nxp.com>
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

A device usually doesn't need to lock itself during initialization
because it is not yet reachable from other threads.

This simplifies the code and helps avoid recursive lock warnings.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2a035374ae74..e1ce57902391 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -684,11 +684,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		err = -ENOMEM;
 		goto err_out;
 	}
 
 	mutex_init(&devfreq->lock);
-	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
 	device_initialize(&devfreq->dev);
 	INIT_LIST_HEAD(&devfreq->node);
@@ -698,28 +697,24 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
 			goto err_dev;
-		mutex_lock(&devfreq->lock);
 	}
 
 	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->scaling_min_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
 	devfreq->min_freq = devfreq->scaling_min_freq;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->scaling_max_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
@@ -730,21 +725,19 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
 	if (!devfreq->trans_table) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_dev;
 	}
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
 			sizeof(unsigned long),
 			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_dev;
 	}
 
 	devfreq->last_stat_updated = jiffies;
@@ -752,16 +745,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_add(&devfreq->dev);
-	if (err) {
-		mutex_unlock(&devfreq->lock);
+	if (err)
 		goto err_dev;
-	}
-
-	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
-- 
2.17.1

