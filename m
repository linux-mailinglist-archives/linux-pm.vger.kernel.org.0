Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17920BBD9A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbfIWVKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:10:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34936 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388859AbfIWVKn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 17:10:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B6A920035A;
        Mon, 23 Sep 2019 23:10:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C74D200223;
        Mon, 23 Sep 2019 23:10:40 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C28AD20613;
        Mon, 23 Sep 2019 23:10:39 +0200 (CEST)
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
Subject: [PATCH v7 5/6] PM / devfreq: Add PM QoS support
Date:   Tue, 24 Sep 2019 00:10:33 +0300
Message-Id: <e9868310f9543b4f4a6c7bbe5d4d015da9a0e71d.1569272883.git.leonard.crestez@nxp.com>
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

Register notifiers with the PM QoS framework in order to respond to
requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.

No notifiers are added by this patch but PM QoS constraints can be
imposed externally (for example from other devices).

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 76 +++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  5 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7f152a582e78..9887408f23bb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -22,17 +22,20 @@
 #include <linux/platform_device.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
 #include <linux/of.h>
+#include <linux/pm_qos.h>
 #include "governor.h"
 
 #define HZ_PER_KHZ 1000
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
+#define HZ_PER_KHZ	1000
+
 static struct class *devfreq_class;
 
 /*
  * devfreq core provides delayed work based load monitoring helper
  * functions. Governors can use these or can implement their own
@@ -123,10 +126,16 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
 	} else {
 		*min_freq = freq_table[devfreq->profile->max_state - 1];
 		*max_freq = freq_table[0];
 	}
 
+	/* constraints from PM QoS */
+	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
+				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
+	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
+				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));
+
 	/* constraints from sysfs */
 	*min_freq = max(*min_freq, devfreq->min_freq);
 	*max_freq = min(*max_freq, devfreq->max_freq);
 
 	/* constraints from OPP interface */
@@ -605,10 +614,53 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	mutex_unlock(&devfreq->lock);
 
 	return ret;
 }
 
+/**
+ * devfreq_qos_notifier_call() - Common handler for QoS constraints.
+ * @devfreq:    the devfreq instance.
+ */
+static int devfreq_qos_notifier_call(struct devfreq *devfreq)
+{
+	int err;
+
+	mutex_lock(&devfreq->lock);
+	err = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (err)
+		dev_err(&devfreq->dev, "dvfs for QoS constraints"
+				" failed with (%d) error\n", err);
+
+	/* QoS is best effort - let all notifiers run on error */
+	return NOTIFY_OK;
+}
+
+/**
+ * devfreq_qos_min_notifier_call() - Callback for QoS min_freq changes.
+ * @nb:		Should be devfreq->nb_min
+ */
+static int devfreq_qos_min_notifier_call(struct notifier_block *nb,
+					 unsigned long val, void *ptr)
+{
+	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_min);
+
+	return devfreq_qos_notifier_call(devfreq);
+}
+
+/**
+ * devfreq_qos_max_notifier_call() - Callback for QoS max_freq changes.
+ * @nb:		Should be devfreq->nb_max
+ */
+static int devfreq_qos_max_notifier_call(struct notifier_block *nb,
+					 unsigned long val, void *ptr)
+{
+	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_max);
+
+	return devfreq_qos_notifier_call(devfreq);
+}
+
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
  *
  * Remove devfreq from the list and release its resources.
@@ -619,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
 
 	mutex_lock(&devfreq_list_lock);
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
+	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
+			DEV_PM_QOS_MAX_FREQUENCY);
+	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
+			DEV_PM_QOS_MIN_FREQUENCY);
+
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	kfree(devfreq->time_in_state);
 	kfree(devfreq->trans_table);
@@ -732,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err) {
 		put_device(&devfreq->dev);
 		goto err_out;
 	}
 
+	/*
+	 * Register notifiers for updates to min/max_freq after device is
+	 * initialized (and we can handle notifications) but before the
+	 * governor is started (which should do an initial enforcement of
+	 * constraints).
+	 */
+	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (err)
+		goto err_devfreq;
+
+	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (err)
+		goto err_devfreq;
+
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
@@ -759,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	return devfreq;
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
+err_devfreq:
 	devfreq_remove_device(devfreq);
 	return ERR_PTR(err);
 
 err_dev:
 	/*
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..8b92ccbd1962 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -134,10 +134,12 @@ struct devfreq_dev_profile {
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
  * @last_stat_updated:	The last time stat updated
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
+ * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
+ * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
  *
  * This structure stores the devfreq information for a give device.
  *
  * Note that when a governor accesses entries in struct devfreq in its
  * functions except for the context of callbacks defined in struct
@@ -176,10 +178,13 @@ struct devfreq {
 	unsigned int *trans_table;
 	unsigned long *time_in_state;
 	unsigned long last_stat_updated;
 
 	struct srcu_notifier_head transition_notifier_list;
+
+	struct notifier_block nb_min;
+	struct notifier_block nb_max;
 };
 
 struct devfreq_freqs {
 	unsigned long old;
 	unsigned long new;
-- 
2.17.1

