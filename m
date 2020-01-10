Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB013752F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAJRt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 12:49:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37509 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgAJRtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 12:49:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1120333plz.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 09:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfYJy9R3cN1g1cl3Z2QjlyF1rhKAw3VaBUq5ODQS3kM=;
        b=WwNfzBmvT9dFIfcQGzf4IrMgK5HDEAz4hlD9fsRCVa/yhu8hCCvdWBH6mWgr8t6427
         8xwW8+0bU+6Ukap/xHuqxW8PLx7LFxF1J+Xen8noDMvr+jEawAnnFLjm8aYjHtekWTVM
         f2HhPtDdawhlf1air4fv6rygDcuPQnDWRfCzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfYJy9R3cN1g1cl3Z2QjlyF1rhKAw3VaBUq5ODQS3kM=;
        b=MaFBveMaQKK3G4EXQ6/c4gG4yvalM0YW+hRAvdJuufKVI9wpHT541WaEQydkxlIVhD
         quVTAR8vZ/RAmaQmLEDMr17DvqqcRz8Qas0jIbpfXy3vOJ7HHE/pKDQwLQ0CTnD+OgIe
         GSDwfrRqaR02MtlI8XzClh/bjzbAFubB2fQ6xcqy99oMVjpsPXTI0qBorAmhwASyRALW
         yn9HKdN53MF6Z0GiSyMIgXiLuSV6gqCaUaKTf5EbBSEa68GLXOFDpKAr5bpMJU7TKexf
         UT0AFsFGPePNGvwMDp+deMd4QHU1Z3S6jhvURgPLCmcM84o0u1aCGUZGelQ8LbvkoZSw
         0xRw==
X-Gm-Message-State: APjAAAV+iWgk5xSW3RXLHYSjRsz1nPCWxAn/AgWcKSNLCYa8MGNhBpk0
        nvjFq0u3Br5IZezV0lWo0z72ESFZKfg=
X-Google-Smtp-Source: APXvYqyZtuhKFcYp6Lr/tH6mKtCyycxBtpGzWPFU7a6zD32Vu8rJ0s7UH+QhNLlj1aLi2riDdJFh2Q==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr5654804plp.149.1578678565058;
        Fri, 10 Jan 2020 09:49:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 83sm3486093pgh.12.2020.01.10.09.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:49:24 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set frequency limits
Date:   Fri, 10 Jan 2020 09:49:18 -0800
Message-Id: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that devfreq supports limiting the frequency range of a device
through PM QoS make use of it instead of disabling OPPs that should
not be used.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/thermal/devfreq_cooling.c | 66 ++++++++++---------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff..3a63603afcf2 100644
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
 
@@ -65,49 +67,9 @@ struct devfreq_cooling_device {
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
@@ -134,7 +96,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
 	struct device *dev = df->dev.parent;
-	int ret;
+	unsigned long freq;
 
 	if (state == dfc->cooling_state)
 		return 0;
@@ -144,9 +106,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
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
 
@@ -529,6 +492,12 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err)
 		goto free_dfc;
 
+	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (err < 0)
+		goto remove_qos_req;
+
 	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
 	if (err < 0)
 		goto free_tables;
@@ -552,6 +521,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 release_ida:
 	ida_simple_remove(&devfreq_ida, dfc->id);
+
+remove_qos_req:
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
+
 free_tables:
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
@@ -600,6 +573,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(dfc->cdev);
 	ida_simple_remove(&devfreq_ida, dfc->id);
+	dev_pm_qos_remove_request(&dfc->req_max_freq);
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog

