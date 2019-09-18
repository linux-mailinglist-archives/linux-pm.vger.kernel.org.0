Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912A5B58E6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 02:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfIRASf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 20:18:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43090 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfIRASf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 20:18:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B60F2200724;
        Wed, 18 Sep 2019 02:18:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DA6D20071D;
        Wed, 18 Sep 2019 02:18:32 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 13DBB20601;
        Wed, 18 Sep 2019 02:18:32 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/8] PM / devfreq: Don't take lock in devfreq_add_device
Date:   Wed, 18 Sep 2019 03:18:23 +0300
Message-Id: <2fe8d1000bed5de70b08ed77fc8360d159ae4434.1568764439.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568764439.git.leonard.crestez@nxp.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1568764439.git.leonard.crestez@nxp.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A device usually doesn't need to lock itself during initialization
because it is not yet reachable from other threads.

This simplifies the code and helps avoid recursive lock warnings.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 57a217fc92de..860cbbab476c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -634,11 +634,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		err = -ENOMEM;
 		goto err_out;
 	}
 
 	mutex_init(&devfreq->lock);
-	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
@@ -647,28 +646,24 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
 
@@ -679,20 +674,18 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
 	if (!devfreq->trans_table) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_dev;
 	}
 
 	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
 					 sizeof(unsigned long),
 					 GFP_KERNEL);
 	if (!devfreq->time_in_state) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_dev;
 	}
 
 	devfreq->last_stat_updated = jiffies;
@@ -701,17 +694,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
-		mutex_unlock(&devfreq->lock);
 		put_device(&devfreq->dev);
 		goto err_out;
 	}
 
-	mutex_unlock(&devfreq->lock);
-
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
-- 
2.17.1

