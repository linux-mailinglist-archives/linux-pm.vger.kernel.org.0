Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE359D0DF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 15:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfHZNon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 09:44:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53530 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbfHZNok (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75D4A1A01E3;
        Mon, 26 Aug 2019 15:44:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 676D51A0191;
        Mon, 26 Aug 2019 15:44:38 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CE6F120605;
        Mon, 26 Aug 2019 15:44:37 +0200 (CEST)
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
Subject: [PATCH v4 3/6] PM / devfreq: Introduce devfreq_get_freq_range
Date:   Mon, 26 Aug 2019 16:44:30 +0300
Message-Id: <f47c1c342fe83be54ec046bf8e41e2dcd541accc.1566826075.git.leonard.crestez@nxp.com>
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

Moving handling of min/max freq to a single function and call it from
update_devfreq and for printing min/max freq values in sysfs.

This changes the behavior of out-of-range min_freq/max_freq: clamping
is now done at evaluation time. This means that if an out-of-range
constraint is imposed by sysfs and it later becomes valid then it will
be enforced.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/devfreq.c | 111 +++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9b3bf64dc37d..96e218b07771 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -24,10 +24,12 @@
 #include <linux/printk.h>
 #include <linux/hrtimer.h>
 #include <linux/of.h>
 #include "governor.h"
 
+#define HZ_PER_KHZ 1000
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
 static struct class *devfreq_class;
 
@@ -96,10 +98,50 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 		dev_pm_opp_put(opp);
 
 	return max_freq;
 }
 
+/**
+ * devfreq_get_freq_range() - Get the current freq range
+ * @devfreq:	the devfreq instance
+ * @min_freq:	the min frequency
+ * @max_freq:	the max frequency
+ *
+ * This takes into consideration all constraints.
+ */
+static void devfreq_get_freq_range(struct devfreq *devfreq,
+				   unsigned long *min_freq,
+				   unsigned long *max_freq)
+{
+	unsigned long *freq_table = devfreq->profile->freq_table;
+
+	lockdep_assert_held(&devfreq->lock);
+
+	/* Init min/max frequency from freq table */
+	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
+		*min_freq = freq_table[0];
+		*max_freq = freq_table[devfreq->profile->max_state - 1];
+	} else {
+		*min_freq = freq_table[devfreq->profile->max_state - 1];
+		*max_freq = freq_table[0];
+	}
+
+	/* constraints from sysfs: */
+	*min_freq = max(*min_freq, devfreq->min_freq);
+	*max_freq = min(*max_freq, devfreq->max_freq);
+
+	/* constraints from opp interface: */
+	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
+	/* scaling_max_freq can be zero on error */
+	if (devfreq->scaling_max_freq)
+		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
+
+	/* max_freq takes precedence over min_freq */
+	if (*min_freq > *max_freq)
+		*min_freq = *max_freq;
+}
+
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
  * @freq:	the target frequency
  */
@@ -348,21 +390,13 @@ int update_devfreq(struct devfreq *devfreq)
 
 	/* Reevaluate the proper frequency */
 	err = devfreq->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 
-	/*
-	 * Adjust the frequency with user freq, QoS and available freq.
-	 *
-	 * List from the highest priority
-	 * max_freq
-	 * min_freq
-	 */
-	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
-	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
-
+	/* max freq takes priority over min freq */
 	if (freq < min_freq) {
 		freq = min_freq;
 		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
 	}
 	if (freq > max_freq) {
@@ -1297,40 +1331,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-
-	if (value) {
-		if (value > df->max_freq) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	} else {
-		unsigned long *freq_table = df->profile->freq_table;
-
-		/* Get minimum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
-			value = freq_table[0];
-		else
-			value = freq_table[df->profile->max_state - 1];
-	}
-
 	df->min_freq = value;
 	update_devfreq(df);
-	ret = count;
-unlock:
 	mutex_unlock(&df->lock);
-	return ret;
+
+	return count;
 }
 
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
+	unsigned long min_freq, max_freq;
 
-	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
+	mutex_lock(&df->lock);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
+	mutex_unlock(&df->lock);
+
+	return sprintf(buf, "%lu\n", min_freq);
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1342,40 +1364,33 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
 
-	if (value) {
-		if (value < df->min_freq) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-	} else {
-		unsigned long *freq_table = df->profile->freq_table;
-
-		/* Get maximum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
-			value = freq_table[df->profile->max_state - 1];
-		else
-			value = freq_table[0];
-	}
+	/* Interpret zero as "don't care" */
+	if (!value)
+		value = ULONG_MAX;
 
 	df->max_freq = value;
 	update_devfreq(df);
-	ret = count;
-unlock:
 	mutex_unlock(&df->lock);
-	return ret;
+
+	return count;
 }
 static DEVICE_ATTR_RW(min_freq);
 
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
+	unsigned long min_freq, max_freq;
+
+	mutex_lock(&df->lock);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
+	mutex_unlock(&df->lock);
 
-	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
+	return sprintf(buf, "%lu\n", max_freq);
 }
 static DEVICE_ATTR_RW(max_freq);
 
 static ssize_t available_frequencies_show(struct device *d,
 					  struct device_attribute *attr,
-- 
2.17.1

