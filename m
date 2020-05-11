Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A71CD7D0
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEKLVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 07:21:23 -0400
Received: from foss.arm.com ([217.140.110.172]:57496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgEKLVX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 May 2020 07:21:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15129106F;
        Mon, 11 May 2020 04:21:22 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0919F3F305;
        Mon, 11 May 2020 04:21:11 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, lukasz.luba@arm.com,
        patrick.bellasi@matbug.net, orjan.eide@arm.com,
        rdunlap@infradead.org, mka@chromium.org
Subject: [PATCH v7 10/15] thermal: devfreq_cooling: get device load and frequency directly
Date:   Mon, 11 May 2020 12:19:07 +0100
Message-Id: <20200511111912.3001-11-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511111912.3001-1-lukasz.luba@arm.com>
References: <20200511111912.3001-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devfreq cooling needs to now the correct status of the device in order
to operate. Do not rely on Devfreq last_status which might be a stale data
and get more up-to-date values of load and frequency.

In addition this patch adds normalization function, which also makes sure
that whatever data comes from the device, it is in a sane range.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 52694d4bd819..396f16bb6566 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -235,6 +235,24 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
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
@@ -242,14 +260,22 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
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
@@ -277,16 +303,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
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
-- 
2.17.1

