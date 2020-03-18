Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B477F189B0B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCRLq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:46:56 -0400
Received: from foss.arm.com ([217.140.110.172]:49026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLqz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 07:46:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE4E1FB;
        Wed, 18 Mar 2020 04:46:54 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2CE23F534;
        Wed, 18 Mar 2020 04:46:44 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
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
Subject: [PATCH v5 3/5] thermal: devfreq_cooling: Use PM QoS to set frequency limits
Date:   Wed, 18 Mar 2020 11:45:46 +0000
Message-Id: <20200318114548.19916-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318114548.19916-1-lukasz.luba@arm.com>
References: <20200318114548.19916-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Now that devfreq supports limiting the frequency range of a device
through PM QoS make use of it instead of disabling OPPs that should
not be used.

The switch from disabling OPPs to PM QoS introduces a subtle behavioral
change in case of conflicting requests (min > max): PM QoS gives
precedence to the MIN_FREQUENCY request, while higher OPPs disabled
with dev_pm_opp_disable() would override MIN_FREQUENCY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

Added missing Chanwoo's Reviewed-by in posted patch v3.

 drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a87d4fa031c8..f7f32e98331b 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -24,11 +24,13 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/thermal.h>
 
 #include <trace/events/thermal.h>
 
-#define SCALE_ERROR_MITIGATION 100
+#define HZ_PER_KHZ		1000
+#define SCALE_ERROR_MITIGATION	100
 
 static DEFINE_IDA(devfreq_ida);
 
@@ -54,6 +56,8 @@ static DEFINE_IDA(devfreq_ida);
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
  * @capped_state:	index to cooling state with in dynamic power budget
+ * @req_max_freq:	PM QoS request for limiting the maximum frequency
+ *			of the devfreq device.
  */
 struct devfreq_cooling_device {
 	int id;
@@ -66,49 +70,9 @@ struct devfreq_cooling_device {
 	struct devfreq_cooling_power *power_ops;
 	u32 res_util;
 	int capped_state;
+	struct dev_pm_qos_request req_max_freq;
 };
 
-/**
- * partition_enable_opps() - disable all opps above a given state
- * @dfc:	Pointer to devfreq we are operating on
- * @cdev_state:	cooling device state we're setting
- *
- * Go through the OPPs of the device, enabling all OPPs until
- * @cdev_state and disabling those frequencies above it.
- */
-static int partition_enable_opps(struct devfreq_cooling_device *dfc,
-				 unsigned long cdev_state)
-{
-	int i;
-	struct device *dev = dfc->devfreq->dev.parent;
-
-	for (i = 0; i < dfc->freq_table_size; i++) {
-		struct dev_pm_opp *opp;
-		int ret = 0;
-		unsigned int freq = dfc->freq_table[i];
-		bool want_enable = i >= cdev_state ? true : false;
-
-		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
-
-		if (PTR_ERR(opp) == -ERANGE)
-			continue;
-		else if (IS_ERR(opp))
-			return PTR_ERR(opp);
-
-		dev_pm_opp_put(opp);
-
-		if (want_enable)
-			ret = dev_pm_opp_enable(dev, freq);
-		else
-			ret = dev_pm_opp_disable(dev, freq);
-
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
 					 unsigned long *state)
 {
@@ -135,7 +99,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
-	int ret;
+	unsigned long freq;
 
 	if (state == dfc->cooling_state)
 		return 0;
@@ -145,9 +109,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	if (state >= dfc->freq_table_size)
 		return -EINVAL;
 
-	ret = partition_enable_opps(dfc, state);
-	if (ret)
-		return ret;
+	freq = dfc->freq_table[state];
+
+	dev_pm_qos_update_request(&dfc->req_max_freq,
+				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
 
 	dfc->cooling_state = state;
 
@@ -530,9 +495,15 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err)
 		goto free_dfc;
 
-	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
+	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
 	if (err < 0)
 		goto free_tables;
+
+	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
+	if (err < 0)
+		goto remove_qos_req;
 	dfc->id = err;
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
@@ -553,6 +524,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 release_ida:
 	ida_simple_remove(&devfreq_ida, dfc->id);
+
+remove_qos_req:
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
+
 free_tables:
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
@@ -601,6 +576,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(dfc->cdev);
 	ida_simple_remove(&devfreq_ida, dfc->id);
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
 
-- 
2.17.1

