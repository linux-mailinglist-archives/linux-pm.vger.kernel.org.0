Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E702D113F04
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLEKFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:05:25 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36580 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfLEKFY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 05:05:24 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C6C51A04CC;
        Thu,  5 Dec 2019 11:05:22 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EDEF1A04A8;
        Thu,  5 Dec 2019 11:05:22 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CBEF2047A;
        Thu,  5 Dec 2019 11:05:21 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] PM / devfreq: Add PM QoS support
Date:   Thu,  5 Dec 2019 12:05:06 +0200
Message-Id: <eaef2de34fed598a1b6ffecc9010e281c6f36318.1575540224.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575540224.git.leonard.crestez@nxp.com>
References: <cover.1575540224.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1575540224.git.leonard.crestez@nxp.com>
References: <cover.1575540224.git.leonard.crestez@nxp.com>
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
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 77 +++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  5 +++
 2 files changed, 82 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bdeb4189c978..e8b943fc4259 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -22,15 +22,18 @@
 #include <linux/platform_device.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
 #include <linux/of.h>
+#include <linux/pm_qos.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
+#define HZ_PER_KHZ	1000
+
 static struct class *devfreq_class;
 
 /*
  * devfreq core provides delayed work based load monitoring helper
  * functions. Governors can use these or can implement their own
@@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 static void get_freq_range(struct devfreq *devfreq,
 			   unsigned long *min_freq,
 			   unsigned long *max_freq)
 {
 	unsigned long *freq_table = devfreq->profile->freq_table;
+	s32 qos_min_freq, qos_max_freq;
 
 	lockdep_assert_held(&devfreq->lock);
 
 	/*
 	 * Initialize minimum/maximum frequency from freq table.
@@ -125,10 +129,20 @@ static void get_freq_range(struct devfreq *devfreq,
 	} else {
 		*min_freq = freq_table[devfreq->profile->max_state - 1];
 		*max_freq = freq_table[0];
 	}
 
+	/* Apply constraints from PM QoS */
+	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
+					     DEV_PM_QOS_MIN_FREQUENCY);
+	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
+					     DEV_PM_QOS_MAX_FREQUENCY);
+	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
+	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
+		*max_freq = min(*max_freq,
+				(unsigned long)HZ_PER_KHZ * qos_max_freq);
+
 	/* Apply constraints from sysfs */
 	*min_freq = max(*min_freq, devfreq->min_freq);
 	*max_freq = min(*max_freq, devfreq->max_freq);
 
 	/* Apply constraints from OPP interface */
@@ -624,24 +638,75 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 			err);
 
 	return NOTIFY_OK;
 }
 
+/**
+ * qos_notifier_call() - Common handler for QoS constraints.
+ * @devfreq:    the devfreq instance.
+ */
+static int qos_notifier_call(struct devfreq *devfreq)
+{
+	int err;
+
+	mutex_lock(&devfreq->lock);
+	err = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (err)
+		dev_err(devfreq->dev.parent,
+			"failed to update frequency from PM QoS (%d)\n",
+			err);
+
+	return NOTIFY_OK;
+}
+
+/**
+ * qos_min_notifier_call() - Callback for QoS min_freq changes.
+ * @nb:		Should be devfreq->nb_min
+ */
+static int qos_min_notifier_call(struct notifier_block *nb,
+					 unsigned long val, void *ptr)
+{
+	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
+}
+
+/**
+ * qos_max_notifier_call() - Callback for QoS max_freq changes.
+ * @nb:		Should be devfreq->nb_max
+ */
+static int qos_max_notifier_call(struct notifier_block *nb,
+					 unsigned long val, void *ptr)
+{
+	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
+}
+
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
  *
  * Remove devfreq from the list and release its resources.
  */
 static void devfreq_dev_release(struct device *dev)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
+	int err;
 
 	mutex_lock(&devfreq_list_lock);
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
+	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
+					 DEV_PM_QOS_MAX_FREQUENCY);
+	if (err && err != -ENOENT)
+		dev_warn(dev->parent,
+			"Failed to remove max_freq notifier: %d\n", err);
+	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
+					 DEV_PM_QOS_MIN_FREQUENCY);
+	if (err && err != -ENOENT)
+		dev_warn(dev->parent,
+			"Failed to remove min_freq notifier: %d\n", err);
+
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
@@ -760,10 +825,22 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
 
+	devfreq->nb_min.notifier_call = qos_min_notifier_call;
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (err)
+		goto err_devfreq;
+
+	devfreq->nb_max.notifier_call = qos_max_notifier_call;
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (err)
+		goto err_devfreq;
+
 	mutex_lock(&devfreq_list_lock);
 
 	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
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

