Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C9303A8D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404261AbhAZKlb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 05:41:31 -0500
Received: from foss.arm.com ([217.140.110.172]:60888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732057AbhAZKlM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 05:41:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C019D101E;
        Tue, 26 Jan 2021 02:40:26 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.2.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBCAD3F66B;
        Tue, 26 Jan 2021 02:40:23 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com, amitk@kernel.org,
        rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [RFC][PATCH 1/3] PM /devfreq: add user frequency limits into devfreq struct
Date:   Tue, 26 Jan 2021 10:39:59 +0000
Message-Id: <20210126104001.20361-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new fields inside devfreq struct allow to check the frequency limits
set by the user via sysfs. These limits are important for thermal governor
Intelligent Power Allocation (IPA) which needs to know the maximum allowed
power consumption of the device.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/devfreq/devfreq.c | 41 +++++++++++++++++++++++++++++++++++----
 include/linux/devfreq.h   |  4 ++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 94cc25fd68da..e985a76e5ff3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -843,6 +843,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
+	devfreq->user_min_freq = devfreq->scaling_min_freq;
+	devfreq->user_max_freq = devfreq->scaling_max_freq;
+
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
@@ -1513,6 +1516,8 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct device *pdev = df->dev.parent;
+	struct dev_pm_opp *opp;
 	unsigned long value;
 	int ret;
 
@@ -1533,6 +1538,19 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
+	if (!value)
+		value = df->scaling_min_freq;
+
+	opp = dev_pm_opp_find_freq_ceil(pdev, &value);
+	if (IS_ERR(opp))
+		return count;
+
+	dev_pm_opp_put(opp);
+
+	mutex_lock(&df->lock);
+	df->user_min_freq = value;
+	mutex_unlock(&df->lock);
+
 	return count;
 }
 
@@ -1554,7 +1572,9 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
-	unsigned long value;
+	struct device *pdev = df->dev.parent;
+	unsigned long value, value_khz;
+	struct dev_pm_opp *opp;
 	int ret;
 
 	/*
@@ -1579,14 +1599,27 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	 * A value of zero means "no limit".
 	 */
 	if (value)
-		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
+		value_khz = DIV_ROUND_UP(value, HZ_PER_KHZ);
 	else
-		value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+		value_khz = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 
-	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
+	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value_khz);
 	if (ret < 0)
 		return ret;
 
+	if (!value)
+		value = df->scaling_max_freq;
+
+	opp = dev_pm_opp_find_freq_floor(pdev, &value);
+	if (IS_ERR(opp))
+		return count;
+
+	dev_pm_opp_put(opp);
+
+	mutex_lock(&df->lock);
+	df->user_max_freq = value;
+	mutex_unlock(&df->lock);
+
 	return count;
 }
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b6d3bae1c74d..147a229056d2 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -147,6 +147,8 @@ struct devfreq_stats {
  *		touch this.
  * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
  * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
+ * @user_min_freq:	User's minimum frequency
+ * @user_max_freq:	User's maximum frequency
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
@@ -185,6 +187,8 @@ struct devfreq {
 	struct dev_pm_qos_request user_max_freq_req;
 	unsigned long scaling_min_freq;
 	unsigned long scaling_max_freq;
+	unsigned long user_min_freq;
+	unsigned long user_max_freq;
 	bool stop_polling;
 
 	unsigned long suspend_freq;
-- 
2.17.1

