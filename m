Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13E91838C2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLSe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 14:34:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37129 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCLSe0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 14:34:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id f16so3002436plj.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxXUM8X0VSorgx/wC+WOqJ59jWbP1RkpforxOuGX84w=;
        b=XQXgG6DbUoC1O8IpMMSoxTu6r6jB8BhGoe3jqkQfSfWZK3K5ETsMpdSgAWlYTpL0bG
         mrYx/aZDA/p92XXtQgN01NUUn4qdGKT9ChkmgChDwupu6e5FVd3EDzuZA+IARCQRc8Z+
         l+BOmTUqMFGgOTutUHPi4nslwxK+Bc0AXh1+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxXUM8X0VSorgx/wC+WOqJ59jWbP1RkpforxOuGX84w=;
        b=AVVuztIdcAqmiFmnhWlbPDNvPa2/JjS544YBSUgZDENZym/uzptwVNSxNaB0SAS9C/
         MXiBbWRKHJJG15pM3aVX2KsqvR5Ma6eH853SRe7fdgLp2CfgLUSNoJg4N9dNDoA4oqDW
         1p7q/ZOJ/DDC94OF0IEL6JqSi6rjdPu3I33Ik8tGK09LEjrZWQu+41TgS9DAk0Fl6mkk
         Isgruy33sKJUb+3j2nZqRu+TyDKKRWfAqoELzazbWfcYpKSiJCwEO/thesazmqnXOrFr
         Vw8R1PkhC3R1eD7GaVIxAUaHs7zaa+v2BcC/qCDYKI5qcmuuw7OUcQEe9L7T1VyY7BfI
         WyYw==
X-Gm-Message-State: ANhLgQ3zGG2Zg/jL9wPbnMCcir78Nt4Lr/51NF2jM46dNSxvTNymrVRs
        5r4aYtmGQEdGERimNwi4lJ7ayQ==
X-Google-Smtp-Source: ADFU+vvvrVImNd6BARHJ3d7y+g69G5nAVGkL4Yx4WCpuUzlf8cpLnGtQSdldzNTSJHYH/EBZISXBPA==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr5620646pje.144.1584038064911;
        Thu, 12 Mar 2020 11:34:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id e11sm13150050pfj.95.2020.03.12.11.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:34:24 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3] thermal: devfreq_cooling: Use PM QoS to set frequency limits
Date:   Thu, 12 Mar 2020 11:34:20 -0700
Message-Id: <20200312113416.v3.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

Changes in v3:
- rebased on bf3a650ab8df ("thermal: qoriq: Fix a compiling issue")
- added 'Reviewed-by' tag from Lukasz

Changes in v2:
- added documentation for 'req_max_freq'
- fixed jumps in of_devfreq_cooling_register_power() unwind
- added comment about behavioral change to the commit message

 drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a87d4fa031c87..f7f32e98331b1 100644
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
2.25.1.481.gfbce0eb801-goog

