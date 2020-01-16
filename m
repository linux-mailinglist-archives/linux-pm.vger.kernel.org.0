Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAB13FCC8
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 00:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbgAPXM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 18:12:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34605 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbgAPXM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 18:12:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id s94so3512241pjc.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrsnGmD7k4euNniLrflPRPNagVyaAgLcBWPJAW+V44Q=;
        b=NR8T0dXfdUVUwJqxHxbpqe7dQKDKAShl/Nx238yaSB4fITUPrX/k99w+/SNTUaIEMZ
         FK6mraGxEGM5MyNmYP+JWWWAHC+1S8s2Up9ze9xrgNw6StM1OwjyB/bO0vDX+LimAZEt
         Y8nJvJpRQVwb02vL6LBCZ8HsywXP0tuzgdA6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrsnGmD7k4euNniLrflPRPNagVyaAgLcBWPJAW+V44Q=;
        b=oNEmnGXV5ByxzXOObW68OCvejJeCWyhw0A34GuxZBHRlyL6SvFc+cfH+8zJqAgodeG
         zeZ3k/hxeY/+Tt002aTfeQPOuU2YKppfxZEYewuUk5YXyRrEG/fQKIG5/t0wm569lMQV
         sozRo65m3VzehMpla7cFLA7akPpBRjncosUmmP7LcSy3CF7Q6djmclJTAASZKiK1m4rW
         q3OpkIBOHEb0ZKCgrsWH8LBDq0OqmR4CMKLg7O2kART/amtlDGEm6iw68XKwrO2ceege
         zXcBauagzCiGUfQLeyYthoyipzCC94zXaqQUeByWaKNQOu/v46LDSYDbW8AnRyQYcy24
         GEpA==
X-Gm-Message-State: APjAAAVqSZJFHuTm7hVR+u80ftv5LuwJJRUavq5rZVbi2w98RUgV502L
        ysrbZIe+ONwlWsXIVig96fz5Zg==
X-Google-Smtp-Source: APXvYqx22R84RCDJhB84vPYmaLLC1U7qP0HpuXKmLONtNcIIEF1ZBkCOu85pu3TTuNkcH+psBHl6TA==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr2165967pjr.142.1579216347569;
        Thu, 16 Jan 2020 15:12:27 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b15sm26703081pft.58.2020.01.16.15.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 15:12:26 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH v2] thermal: devfreq_cooling: Use PM QoS to set frequency limits
Date:   Thu, 16 Jan 2020 15:12:23 -0800
Message-Id: <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that devfreq supports limiting the frequency range of a device
through PM QoS make use of it instead of disabling OPPs that should
not be used.

The switch from disabling OPPs to PM QoS introduces a subtle behavioral
change in case of conflicting requests (min > max): PM QoS gives
precedence to the MIN_FREQUENCY request, while higher OPPs disabled
with dev_pm_opp_disable() would override MIN_FREQUENCY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- added documentation for 'req_max_freq'
- fixed jumps in of_devfreq_cooling_register_power() unwind
- added comment about behavioral change to the commit message

 drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff63..cbbaf5bc425d1a 100644
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
 
@@ -53,6 +55,8 @@ static DEFINE_IDA(devfreq_ida);
  *		'utilization' (which is	'busy_time / 'total_time').
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
+ * @req_max_freq:	PM QoS request for limiting the maximum frequency
+ *			of the devfreq device.
  */
 struct devfreq_cooling_device {
 	int id;
@@ -65,49 +69,9 @@ struct devfreq_cooling_device {
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
@@ -134,7 +98,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
-	int ret;
+	unsigned long freq;
 
 	if (state == dfc->cooling_state)
 		return 0;
@@ -144,9 +108,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
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
 
@@ -529,9 +494,15 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
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
@@ -552,6 +523,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 release_ida:
 	ida_simple_remove(&devfreq_ida, dfc->id);
+
+remove_qos_req:
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
+
 free_tables:
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
@@ -600,6 +575,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(dfc->cdev);
 	ida_simple_remove(&devfreq_ida, dfc->id);
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
 
-- 
2.25.0.341.g760bfbb309-goog

