Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5910290A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfKSQNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:13:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41698 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbfKSQNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Nov 2019 11:13:05 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 34D361A0456;
        Tue, 19 Nov 2019 17:13:03 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 268341A0406;
        Tue, 19 Nov 2019 17:13:03 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 349AC203BF;
        Tue, 19 Nov 2019 17:13:02 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 2/2] PM / devfreq: Use PM QoS for sysfs min/max_freq
Date:   Tue, 19 Nov 2019 18:12:14 +0200
Message-Id: <1f567d6478b1782f7f4afc27cb6d3f896d77ac9f.1574179738.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574179738.git.leonard.crestez@nxp.com>
References: <cover.1574179738.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574179738.git.leonard.crestez@nxp.com>
References: <cover.1574179738.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch the handling of min_freq and max_freq from sysfs to use the
dev_pm_qos_request interface.

Since PM QoS handles frequencies as kHz this change reduces the
precision of min_freq and max_freq. This shouldn't introduce problems
because frequencies which are not an integer number of kHz are likely
not an integer number of Hz either.

Try to ensure compatibility by rounding min values down and rounding
max values up.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 76 ++++++++++++++++++++++++++++++---------
 include/linux/devfreq.h   |  9 ++---
 2 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 34bbaac6ea7e..518dd2745d06 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -139,14 +139,10 @@ static void get_freq_range(struct devfreq *devfreq,
 	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
 	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
 		*max_freq = min(*max_freq,
 				(unsigned long)HZ_PER_KHZ * qos_max_freq);
 
-	/* Apply constraints from sysfs */
-	*min_freq = max(*min_freq, devfreq->min_freq);
-	*max_freq = min(*max_freq, devfreq->max_freq);
-
 	/* Apply constraints from OPP interface */
 	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
 	*max_freq = min(*max_freq, devfreq->scaling_max_freq);
 
 	if (*min_freq > *max_freq)
@@ -708,10 +704,23 @@ static void devfreq_dev_release(struct device *dev)
 					 DEV_PM_QOS_MIN_FREQUENCY);
 	if (err && err != -ENOENT)
 		dev_warn(dev->parent,
 			"Failed to remove min_freq notifier: %d\n", err);
 
+	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req)) {
+		err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
+		if (err)
+			dev_warn(dev->parent,
+				"Failed to remove max_freq request: %d\n", err);
+	}
+	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req)) {
+		err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
+		if (err)
+			dev_warn(dev->parent,
+				"Failed to remove min_freq request: %d\n", err);
+	}
+
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
@@ -780,19 +789,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
@@ -829,10 +836,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
 
+	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (err < 0)
+		goto err_devfreq;
+	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (err < 0)
+		goto err_devfreq;
+
 	devfreq->nb_min.notifier_call = qos_min_notifier_call;
 	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
 				      DEV_PM_QOS_MIN_FREQUENCY);
 	if (err)
 		goto err_devfreq;
@@ -1414,18 +1431,26 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
 	int ret;
 
+	/*
+	 * Protect against theoretical sysfs writes between
+	 * device_add and dev_pm_qos_add_request
+	 */
+	if (!dev_pm_qos_request_active(&df->user_min_freq_req))
+		return -EINVAL;
+
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-	df->min_freq = value;
-	update_devfreq(df);
-	mutex_unlock(&df->lock);
+	/* Round down to kHz for PM QoS */
+	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
+					value / HZ_PER_KHZ);
+	if (ret < 0)
+		return ret;
 
 	return count;
 }
 
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
@@ -1446,22 +1471,39 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
 	int ret;
 
+	/*
+	 * Protect against theoretical sysfs writes between
+	 * device_add and dev_pm_qos_add_request
+	 */
+	if (!dev_pm_qos_request_active(&df->user_max_freq_req))
+		return -EINVAL;
+
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-
-	if (!value)
-		value = ULONG_MAX;
+	/*
+	 * PM QoS frequencies are in kHz so we need to convert. Convert by
+	 * rounding upwards so that the acceptable interval never shrinks.
+	 *
+	 * For example if the user writes "666666666" to sysfs this value will
+	 * be converted to 666667 kHz and back to 666667000 Hz before an OPP
+	 * lookup, this ensures that an OPP of 666666666Hz is still accepted.
+	 *
+	 * A value of zero means "no limit".
+	 */
+	if (value)
+		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
+	else
+		value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 
-	df->max_freq = value;
-	update_devfreq(df);
-	mutex_unlock(&df->lock);
+	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
+	if (ret < 0)
+		return ret;
 
 	return count;
 }
 static DEVICE_ATTR_RW(min_freq);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 8b92ccbd1962..fb376b5b7281 100644
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
+ * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
+ * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
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
+	struct dev_pm_qos_request user_min_freq_req;
+	struct dev_pm_qos_request user_max_freq_req;
 	unsigned long scaling_min_freq;
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
 	unsigned long suspend_freq;
-- 
2.17.1

