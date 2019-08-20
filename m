Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09A19643D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfHTPYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:24:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52000 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfHTPYG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:24:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C96CC1A01A8;
        Tue, 20 Aug 2019 17:24:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB9321A0111;
        Tue, 20 Aug 2019 17:24:04 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A68720604;
        Tue, 20 Aug 2019 17:24:04 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs min/max_freq
Date:   Tue, 20 Aug 2019 18:24:01 +0300
Message-Id: <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566314535.git.leonard.crestez@nxp.com>
References: <cover.1566314535.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566314535.git.leonard.crestez@nxp.com>
References: <cover.1566314535.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that devfreq supports dev_pm_qos requests we can use them to handle
the min/max_freq values set by userspace in sysfs, similar to cpufreq.

Since dev_pm_qos handles frequencies as kHz this change reduces the
precision of min_freq and max_freq. This shouldn't introduce problems
because frequencies which are not an integer number of kHz are likely
not an integer number of Hz either.

Try to ensure compatibilitity by rounding min values down and rounding
max values up.

Simplify the {min,max}_freq_store code by setting "null" values of 0 and
MAX_S32 respectively instead of clamping to what freq tables are
actually supported. Values are already automatically clamped on
readback.

Also simplify by droping the limitation that userspace min_freq must be
lower than userspace max_freq, it is already documented that max_freq
takes precedence.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 79 ++++++++++++++++-----------------------
 include/linux/devfreq.h   |  9 +++--
 2 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 58deffa52a37..687deadd08ed 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -101,21 +101,21 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 
 static unsigned long get_effective_min_freq(struct devfreq *devfreq)
 {
 	lockdep_assert_held(&devfreq->lock);
 
-	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
+	return max(devfreq->scaling_min_freq,
 		1000 * (unsigned long)dev_pm_qos_read_value(
 				devfreq->dev.parent,
 				DEV_PM_QOS_MIN_FREQUENCY));
 }
 
 static unsigned long get_effective_max_freq(struct devfreq *devfreq)
 {
 	lockdep_assert_held(&devfreq->lock);
 
-	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
+	return min(devfreq->scaling_max_freq,
 		1000 * (unsigned long)dev_pm_qos_read_value(
 				devfreq->dev.parent,
 				DEV_PM_QOS_MAX_FREQUENCY));
 }
 
@@ -644,10 +644,12 @@ static void devfreq_dev_release(struct device *dev)
 
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
 			DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
 			DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(&devfreq->max_freq_req);
+	dev_pm_qos_remove_request(&devfreq->min_freq_req);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
 
 /**
@@ -698,10 +700,19 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
+	err = dev_pm_qos_add_request(dev, &devfreq->min_freq_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (err < 0)
+		goto err_dev;
+	err = dev_pm_qos_add_request(dev, &devfreq->max_freq_req,
+				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
+	if (err < 0)
+		goto err_dev;
+
 	/*
 	 * notifier from pm_qos
 	 *
 	 * initialized outside of devfreq->lock to avoid circular warning
 	 * between devfreq->lock and dev_pm_qos_mtx
@@ -732,19 +743,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (!devfreq->scaling_min_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->min_freq = devfreq->scaling_min_freq;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->scaling_max_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
@@ -816,10 +825,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 err_dev:
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	if (dev_pm_qos_request_active(&devfreq->max_freq_req))
+		dev_pm_qos_remove_request(&devfreq->max_freq_req);
+	if (dev_pm_qos_request_active(&devfreq->min_freq_req))
+		dev_pm_qos_remove_request(&devfreq->min_freq_req);
 	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(devfreq_add_device);
@@ -1358,33 +1371,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-
-	if (value) {
-		if (value > df->max_freq) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	} else {
-		unsigned long *freq_table = df->profile->freq_table;
+	if (value)
+		value = value / 1000;
+	else
+		value = 0;
 
-		/* Get minimum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
-			value = freq_table[0];
-		else
-			value = freq_table[df->profile->max_state - 1];
-	}
+	ret = dev_pm_qos_update_request(&df->min_freq_req, value);
+	if (ret < 0)
+		return ret;
 
-	df->min_freq = value;
-	update_devfreq(df);
-	ret = count;
-unlock:
-	mutex_unlock(&df->lock);
-	return ret;
+	return count;
 }
 
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1407,33 +1407,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-
-	if (value) {
-		if (value < df->min_freq) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	} else {
-		unsigned long *freq_table = df->profile->freq_table;
+	if (value)
+		value = DIV_ROUND_UP(value, 1000);
+	else
+		value = S32_MAX;
 
-		/* Get maximum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
-			value = freq_table[df->profile->max_state - 1];
-		else
-			value = freq_table[0];
-	}
+	ret = dev_pm_qos_update_request(&df->max_freq_req, value);
+	if (ret < 0)
+		return ret;
 
-	df->max_freq = value;
-	update_devfreq(df);
-	ret = count;
-unlock:
-	mutex_unlock(&df->lock);
-	return ret;
+	return count;
 }
 static DEVICE_ATTR_RW(min_freq);
 
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 8b92ccbd1962..d2c5bb7add0a 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -11,10 +11,11 @@
 #define __LINUX_DEVFREQ_H__
 
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 
 #define DEVFREQ_NAME_LEN 16
 
 /* DEVFREQ governor name */
 #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
@@ -121,12 +122,12 @@ struct devfreq_dev_profile {
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
  * @previous_freq:	previously configured frequency value.
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
- * @min_freq:	Limit minimum frequency requested by user (0: none)
- * @max_freq:	Limit maximum frequency requested by user (0: none)
+ * @min_freq_req:	Limit minimum frequency requested by user (0: none)
+ * @max_freq_req:	Limit maximum frequency requested by user (0: none)
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
@@ -161,12 +162,12 @@ struct devfreq {
 	unsigned long previous_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
 
-	unsigned long min_freq;
-	unsigned long max_freq;
+	struct dev_pm_qos_request min_freq_req;
+	struct dev_pm_qos_request max_freq_req;
 	unsigned long scaling_min_freq;
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
 	unsigned long suspend_freq;
-- 
2.17.1

