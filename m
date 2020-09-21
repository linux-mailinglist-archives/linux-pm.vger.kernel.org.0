Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66FE2723BC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIUMU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 08:20:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgIUMUy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 08:20:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96384D6E;
        Mon, 21 Sep 2020 05:20:53 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D4463F73B;
        Mon, 21 Sep 2020 05:20:43 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 2/5] thermal: devfreq_cooling: get a copy of device status
Date:   Mon, 21 Sep 2020 13:20:04 +0100
Message-Id: <20200921122007.29610-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921122007.29610-1-lukasz.luba@arm.com>
References: <20200921122007.29610-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devfreq cooling needs to now the correct status of the device in order
to operate. Do not rely on Devfreq last_status which might be a stale data
and get more up-to-date values of the load.

Devfreq framework can change the device status in the background. To
mitigate this situation make a copy of the status structure and use it
for internal calculations.

In addition this patch adds normalization function, which also makes sure
that whatever data comes from the device, it is in a sane range.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 52 +++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 7063ccb7b86d..cf045bd4d16b 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -227,6 +227,24 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
 							       voltage);
 }
 
+static void _normalize_load(struct devfreq_dev_status *status)
+{
+	/* Make some space if needed */
+	if (status->busy_time > 0xffff) {
+		status->busy_time >>= 10;
+		status->total_time >>= 10;
+	}
+
+	if (status->busy_time > status->total_time)
+		status->busy_time = status->total_time;
+
+	status->busy_time *= 100;
+	status->busy_time /= status->total_time ? : 1;
+
+	/* Avoid division by 0 */
+	status->busy_time = status->busy_time ? : 1;
+	status->total_time = 100;
+}
 
 static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
 					       struct thermal_zone_device *tz,
@@ -234,14 +252,22 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct devfreq_dev_status *status = &df->last_status;
+	struct devfreq_dev_status status;
 	unsigned long state;
-	unsigned long freq = status->current_frequency;
+	unsigned long freq;
 	unsigned long voltage;
 	u32 dyn_power = 0;
 	u32 static_power = 0;
 	int res;
 
+	mutex_lock(&df->lock);
+	res = df->profile->get_dev_status(df->dev.parent, &status);
+	mutex_unlock(&df->lock);
+	if (res)
+		return res;
+
+	freq = status.current_frequency;
+
 	state = freq_get_state(dfc, freq);
 	if (state == THERMAL_CSTATE_INVALID) {
 		res = -EAGAIN;
@@ -269,16 +295,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	} else {
 		dyn_power = dfc->power_table[state];
 
+		_normalize_load(&status);
+
 		/* Scale dynamic power for utilization */
-		dyn_power *= status->busy_time;
-		dyn_power /= status->total_time;
+		dyn_power *= status.busy_time;
+		dyn_power /= status.total_time;
 		/* Get static power */
 		static_power = get_static_power(dfc, freq);
 
 		*power = dyn_power + static_power;
 	}
 
-	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
+	trace_thermal_power_devfreq_get_power(cdev, &status, freq, *power);
 
 	return 0;
 fail:
@@ -312,14 +340,20 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct devfreq_dev_status *status = &df->last_status;
-	unsigned long freq = status->current_frequency;
+	struct devfreq_dev_status status;
 	unsigned long busy_time;
+	unsigned long freq;
 	s32 dyn_power;
 	u32 static_power;
 	s32 est_power;
 	int i;
 
+	mutex_lock(&df->lock);
+	status = df->last_status;
+	mutex_unlock(&df->lock);
+
+	freq = status.current_frequency;
+
 	if (dfc->power_ops->get_real_power) {
 		/* Scale for resource utilization */
 		est_power = power * dfc->res_util;
@@ -331,8 +365,8 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 		dyn_power = dyn_power > 0 ? dyn_power : 0;
 
 		/* Scale dynamic power for utilization */
-		busy_time = status->busy_time ?: 1;
-		est_power = (dyn_power * status->total_time) / busy_time;
+		busy_time = status.busy_time ?: 1;
+		est_power = (dyn_power * status.total_time) / busy_time;
 	}
 
 	/*
-- 
2.17.1

