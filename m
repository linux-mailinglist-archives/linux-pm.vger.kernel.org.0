Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6F303A90
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392027AbhAZKlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 05:41:42 -0500
Received: from foss.arm.com ([217.140.110.172]:60912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404266AbhAZKlP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 05:41:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC855106F;
        Tue, 26 Jan 2021 02:40:29 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.2.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B1633F66B;
        Tue, 26 Jan 2021 02:40:26 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com, amitk@kernel.org,
        rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [RFC][PATCH 2/3] thermal: devfreq_cooling: add new callback to get user limit for min state
Date:   Tue, 26 Jan 2021 10:40:00 +0000
Message-Id: <20210126104001.20361-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

User can limit the maximum frequency of the device via sysfs interface.
It limits also corresponding maximum allowed power consumption. The IPA
governor needs to know maximum power of the device to split the budget.
If the user limit is not provided, some power is wasted while it could
be added to other capable device. This new callback helps to solve such
scenario.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 33 +++++++++++++++++++++++++++++++
 include/linux/thermal.h           |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121ff2a1..e13ef86191e8 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -64,6 +64,8 @@ struct devfreq_cooling_device {
 	struct em_perf_domain *em_pd;
 };
 
+static int get_perf_idx(struct em_perf_domain *em_pd, unsigned long freq);
+
 static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
 					 unsigned long *state)
 {
@@ -74,6 +76,36 @@ static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static int
+devfreq_cooling_get_user_min_state(struct thermal_cooling_device *cdev,
+				   unsigned long *state)
+{
+	struct devfreq_cooling_device *dfc = cdev->devdata;
+	struct devfreq *df = dfc->devfreq;
+	struct device *dev = df->dev.parent;
+	struct dev_pm_opp *opp;
+	unsigned long freq;
+	int ret;
+
+	mutex_lock(&df->lock);
+	freq = df->user_max_freq;
+	mutex_unlock(&df->lock);
+
+	opp = dev_pm_opp_find_freq_floor(dev, &freq);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	dev_pm_opp_put(opp);
+
+	ret = get_perf_idx(dfc->em_pd, freq / 1000);
+	if (ret < 0)
+		return -EINVAL;
+
+	*state = dfc->max_state - ret;
+
+	return 0;
+}
+
 static int devfreq_cooling_get_cur_state(struct thermal_cooling_device *cdev,
 					 unsigned long *state)
 {
@@ -297,6 +329,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 
 static struct thermal_cooling_device_ops devfreq_cooling_ops = {
 	.get_max_state = devfreq_cooling_get_max_state,
+	.get_user_min_state = devfreq_cooling_get_user_min_state,
 	.get_cur_state = devfreq_cooling_get_cur_state,
 	.set_cur_state = devfreq_cooling_set_cur_state,
 };
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6ac7bb1d2b1f..2af3149dd052 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -82,6 +82,7 @@ struct thermal_zone_device_ops {
 
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
+	int (*get_user_min_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
 	int (*get_requested_power)(struct thermal_cooling_device *, u32 *);
-- 
2.17.1

