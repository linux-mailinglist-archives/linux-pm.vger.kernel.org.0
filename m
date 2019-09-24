Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1343EBC576
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438530AbfIXKLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 06:11:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59406 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438540AbfIXKLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 06:11:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 943A91A03BB;
        Tue, 24 Sep 2019 12:11:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 863611A0815;
        Tue, 24 Sep 2019 12:11:37 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D5F3C205E6;
        Tue, 24 Sep 2019 12:11:36 +0200 (CEST)
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
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
Date:   Tue, 24 Sep 2019 13:11:30 +0300
Message-Id: <3eb8a1d1e7d738f7599d54348d6b474196581693.1569319738.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569319738.git.leonard.crestez@nxp.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1569319738.git.leonard.crestez@nxp.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
 include/linux/devfreq.h   |  9 ++++----
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 784f3e40536a..8bb7efd821ab 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
 	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
 					     DEV_PM_QOS_MIN_FREQUENCY);
 	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
 	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
 
-	/* constraints from sysfs */
-	*min_freq = max(*min_freq, devfreq->min_freq);
-	*max_freq = min(*max_freq, devfreq->max_freq);
-
 	/* constraints from OPP interface */
 	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
 	/* scaling_max_freq can be zero on error */
 	if (devfreq->scaling_max_freq)
 		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
@@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
 			DEV_PM_QOS_MIN_FREQUENCY);
 
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
+	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
 	kfree(devfreq->time_in_state);
 	kfree(devfreq->trans_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->scaling_min_freq) {
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->min_freq = devfreq->scaling_min_freq;
 
 	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->scaling_max_freq) {
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->max_freq = devfreq->scaling_max_freq;
+
+	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (err < 0)
+		goto err_dev;
+	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
+				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
+	if (err < 0)
+		goto err_dev;
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
 	devfreq->trans_table = kzalloc(
@@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 err_dev:
 	/*
 	 * Cleanup path for errors that happen before registration.
 	 * Otherwise we rely on devfreq_dev_release.
 	 */
+	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
+		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
+	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
+		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
 	kfree(devfreq->time_in_state);
 	kfree(devfreq->trans_table);
 	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
@@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-	df->min_freq = value;
-	update_devfreq(df);
-	mutex_unlock(&df->lock);
+	/* round down to kHz for PM QoS */
+	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
+					value / HZ_PER_KHZ);
+	if (ret < 0)
+		return ret;
 
 	return count;
 }
 
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
@@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
-	mutex_lock(&df->lock);
-
-	/* Interpret zero as "don't care" */
-	if (!value)
-		value = ULONG_MAX;
+	/* round up to kHz for PM QoS and interpret zero as "don't care" */
+	if (value)
+		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
+	else
+		value = S32_MAX;
 
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
index dac0dffeabb4..7849fe4c666d 100644
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
+ * @user_min_freq_req:	PM QoS min frequency request from user (via sysfs)
+ * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)
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

