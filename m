Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70D82E4C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfHFJDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 05:03:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56270 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFJDk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 05:03:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83A731A05C7;
        Tue,  6 Aug 2019 11:03:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FEF51A05B4;
        Tue,  6 Aug 2019 11:03:37 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F0E66205DD;
        Tue,  6 Aug 2019 11:03:36 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Add dev_pm_qos support
Date:   Tue,  6 Aug 2019 12:03:31 +0300
Message-Id: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_qos notifies to devfreq core in order to support frequency
limits via dev_pm_qos_add_request and related APIs

Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:
this is consistent with current dev_pm_qos usage for cpufreq and allows
frequencies above 2Ghz.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 77 ++++++++++++++++++++++++++++++++++-----
 include/linux/devfreq.h   |  3 ++
 2 files changed, 71 insertions(+), 9 deletions(-)

This was inspired by recent changes adding dev_pm_qos limits for
cpufreq: https://lkml.org/lkml/2019/7/4/118

The pm_qos code make deep assumptions that requests need to be
expressed as "s32" through it's use of "plist". Handling freq as a kHz
values seems the easiest solution for this, perhaps it should be
documented in dev_pm_qos itself?

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784c08e4f931..de9e825ae1f4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -22,10 +22,11 @@
 #include <linux/platform_device.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
 #include <linux/of.h>
+#include <linux/pm_qos.h>
 #include "governor.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
@@ -96,10 +97,26 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 		dev_pm_opp_put(opp);
 
 	return max_freq;
 }
 
+static unsigned long get_effective_min_freq(struct devfreq *devfreq)
+{
+	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
+		1000 * (unsigned long)dev_pm_qos_read_value(
+				devfreq->dev.parent,
+				DEV_PM_QOS_MIN_FREQUENCY));
+}
+
+static unsigned long get_effective_max_freq(struct devfreq *devfreq)
+{
+	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
+		1000 * (unsigned long)dev_pm_qos_read_value(
+				devfreq->dev.parent,
+				DEV_PM_QOS_MAX_FREQUENCY));
+}
+
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
  * @freq:	the target frequency
  */
@@ -356,12 +373,12 @@ int update_devfreq(struct devfreq *devfreq)
 	 *
 	 * List from the highest priority
 	 * max_freq
 	 * min_freq
 	 */
-	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
-	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
+	max_freq = get_effective_max_freq(devfreq);
+	min_freq = get_effective_min_freq(devfreq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
 		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
 	}
@@ -570,10 +587,31 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	mutex_unlock(&devfreq->lock);
 
 	return ret;
 }
 
+static int devfreq_qos_notifier_call(struct devfreq *devfreq)
+{
+	int ret;
+
+	mutex_lock(&devfreq->lock);
+	ret = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+
+	return ret;
+}
+
+static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
+{
+	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_min));
+}
+
+static int devfreq_qos_max_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
+{
+	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_max));
+}
+
 /**
  * devfreq_dev_release() - Callback for struct device to release the device.
  * @dev:	the devfreq device
  *
  * Remove devfreq from the list and release its resources.
@@ -636,21 +674,46 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
+	/*
+	 * notifier from pm_qos
+	 *
+	 * initialized outside of devfreq->lock to avoid circular warning
+	 * between devfreq->lock and dev_pm_qos_mtx
+	 */
+	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
+	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
+
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (err) {
+		dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);
+		panic("fail\n");
+		goto err_dev;
+	}
+
+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (err) {
+		dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);
+		panic("fail\n");
+		goto err_dev;
+	}
+
+	mutex_lock(&devfreq->lock);
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
 			goto err_dev;
@@ -1311,13 +1374,11 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct devfreq *df = to_devfreq(dev);
-
-	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
+	return sprintf(buf, "%lu\n", get_effective_min_freq(to_devfreq(dev)));
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1356,13 +1417,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(min_freq);
 
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct devfreq *df = to_devfreq(dev);
-
-	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
+	return sprintf(buf, "%lu\n", get_effective_max_freq(to_devfreq(dev)));
 }
 static DEVICE_ATTR_RW(max_freq);
 
 static ssize_t available_frequencies_show(struct device *d,
 					  struct device_attribute *attr,
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..939cb025d2aa 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -176,10 +176,13 @@ struct devfreq {
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

