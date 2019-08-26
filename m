Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E312E9D0D7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfHZNok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 09:44:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53490 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731805AbfHZNoj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DE031A01EA;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25B811A01E3;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FA0220605;
        Mon, 26 Aug 2019 15:44:36 +0200 (CEST)
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
Subject: [PATCH v4 1/6] PM / devfreq: Don't take lock in devfreq_add_device
Date:   Mon, 26 Aug 2019 16:44:28 +0300
Message-Id: <26a030f735922b0b9ec821491981baa3f46fa3a8.1566826075.git.leonard.crestez@nxp.com>
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

A device usually doesn't need to lock itself during initialization
because it is not yet reachable from other threads.

This simplifies the code and helps avoid recursive lock warnings.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index afbe2a8f7529..15270293bea9 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -636,11 +636,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		err = -ENOMEM;
 		goto err_out;
 	}
 
 	mutex_init(&devfreq->lock);
-	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
 	devfreq->profile = profile;
 	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
@@ -648,28 +647,24 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
 
@@ -678,42 +673,37 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
-		mutex_unlock(&devfreq->lock);
 		put_device(&devfreq->dev);
 		goto err_out;
 	}
 
 	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
 	if (!devfreq->trans_table) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
 			sizeof(unsigned long),
 			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
-		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
-	mutex_unlock(&devfreq->lock);
-
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
-- 
2.17.1

