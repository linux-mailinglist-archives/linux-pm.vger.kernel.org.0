Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA83AFBC70
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMXVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 18:21:41 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55980 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfKMXVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 18:21:41 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 968A81A0A90;
        Thu, 14 Nov 2019 00:21:39 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 88E851A0A8B;
        Thu, 14 Nov 2019 00:21:39 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 19E2D205D5;
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
Subject: [PATCH 2/5] PM / devfreq: Split device_register usage
Date:   Thu, 14 Nov 2019 01:21:32 +0200
Message-Id: <85ccf6afe5db556c610ce2b47ccc38132b6671f6.1573686315.git.leonard.crestez@nxp.com>
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

Splitting device_register into device_initialize and device_add allows
devm-based allocations to be performed before device_add.

It also simplifies error paths in devfreq_add_device: just call
put_device instead of duplicating parts of devfreq_dev_release.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 27af1b95fd23..b89a82382536 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -689,10 +689,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_init(&devfreq->lock);
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
+	device_initialize(&devfreq->dev);
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
 	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
@@ -726,15 +727,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
-	err = device_register(&devfreq->dev);
+	err = device_add(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		put_device(&devfreq->dev);
-		goto err_out;
+		goto err_dev;
 	}
 
 	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
@@ -789,13 +789,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
 err_devfreq:
 	devfreq_remove_device(devfreq);
-	devfreq = NULL;
+	return ERR_PTR(err);
 err_dev:
-	kfree(devfreq);
+	put_device(&devfreq->dev);
 err_out:
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(devfreq_add_device);
 
-- 
2.17.1

