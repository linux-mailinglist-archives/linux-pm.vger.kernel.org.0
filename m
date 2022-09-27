Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384D5EC688
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiI0Of4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiI0Ody (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA111B912A
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36so6690294wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jLn+zEfCM4URHe7bMSEwNlD2QENA2eAivlgbUdbannc=;
        b=QDRiP3bKfA2gJfj8BbD2L4K3qTrlzpz8S6jHFq3UyH9mjfl87zFuVL3M9gxK7IolLJ
         Led+LXNR+vhh6ZaLnyRWpAJGIU5tdMUdRSxJETSWYJKC2ZKKRSNcEJ1rO7yC3B2l7apz
         tqsshrEBLwQqN0ZAbzLwZZxwXxwv+5aJR+TgKArzBF9bzsXL0brtEsWCZ+CKRZhRSZM6
         3rEtIPRKf5oKYkBKy5HH63ulFrwm5hUm3qwxhteMSycSOrvMros6zZgwdZDeqxdBoEFm
         BGWiltIa2v88Bi3nfZzLqhfy38Bv58rDpmWA1m/7dY6uoJ/OBpR0nYr2Ag1AyKScXdR7
         dFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jLn+zEfCM4URHe7bMSEwNlD2QENA2eAivlgbUdbannc=;
        b=U23xnY7D5bJw7XT/hF8+bdxEGqf1FPzjuI5lcJmH6rCYVVbMRpTVlW0/TQF6YUauPD
         BMdVedyHPGwFnKNWNp3Xc8c91GOiFCc3+IgD2Mv+n4B/CK1jVfG7ncO4HpZufmPb1d8V
         mTkEWPLTgT+lHZzLq3XrfQ0xshckoTKXSFrdfx/CsiRQezwOMPR4MrbyyjYnevSdSGWW
         28A8IQLhoCXvAC2dK1QScFns6RoqZ/P2tWw7lsbQKLN9KzTjnGfN5eLrvHMIb23EVKzr
         4LKNdl36C19sBP3BhCo9bN0/hCNGkHIdHSTCrv47ehfr1+WZMrDsGwRnlbXIg0oy2eMR
         be4g==
X-Gm-Message-State: ACrzQf0X4VcdFtyfAcjUEB36DpSIP6nHtDa4qZycfGOIpMl8xbE+ekqv
        axKp8aP0A0t3ogDg3qIR1e2h+Q==
X-Google-Smtp-Source: AMsMyM7ZVL3GOdJ4hfBheFdjZtbthO7dLrg/Au1wJb6gfGF3bhL1KPdQhiNj1HbgcRDRnMWZEx4UVg==
X-Received: by 2002:a05:600c:2118:b0:3b4:76ce:d274 with SMTP id u24-20020a05600c211800b003b476ced274mr2993331wml.95.1664289215285;
        Tue, 27 Sep 2022 07:33:35 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v6 29/29] thermal/drivers/intel: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:39 +0200
Message-Id: <20220927143239.376737-30-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 ++++++++++---------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index a0e234fce71a..e7c3b78d959c 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -53,6 +53,7 @@ struct zone_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
+	struct thermal_trip		*trips;
 	struct cpumask			cpumask;
 };
 
@@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return -EINVAL;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-			     int trip, int *temp)
-{
-	struct zone_device *zonedev = tzd->devdata;
-	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
-	int ret;
-
-	if (trip >= MAX_NUMBER_OF_TRIPS)
-		return -EINVAL;
-
-	if (trip) {
-		mask = THERM_MASK_THRESHOLD1;
-		shift = THERM_SHIFT_THRESHOLD1;
-	} else {
-		mask = THERM_MASK_THRESHOLD0;
-		shift = THERM_SHIFT_THRESHOLD0;
-	}
-
-	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &eax, &edx);
-	if (ret < 0)
-		return ret;
-
-	thres_reg_value = (eax & mask) >> shift;
-	if (thres_reg_value)
-		*temp = zonedev->tj_max - thres_reg_value * 1000;
-	else
-		*temp = THERMAL_TEMP_INVALID;
-	pr_debug("sys_get_trip_temp %d\n", *temp);
-
-	return 0;
-}
-
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
@@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 			l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type = THERMAL_TRIP_PASSIVE;
-	return 0;
-}
-
 /* Thermal zone callback registry */
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
 	return 0;
 }
 
+static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
+{
+	struct thermal_trip *trips;
+	unsigned long thres_reg_value;
+	u32 mask, shift, eax, edx;
+	int ret, i;
+
+	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
+	if (!trips)
+		return ERR_PTR(-ENOMEM);
+	
+	for (i = 0; i < num_trips; i++) {
+
+		if (i) {
+			mask = THERM_MASK_THRESHOLD1;
+			shift = THERM_SHIFT_THRESHOLD1;
+		} else {
+			mask = THERM_MASK_THRESHOLD0;
+			shift = THERM_SHIFT_THRESHOLD0;
+		}
+
+		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				   &eax, &edx);
+		if (ret < 0) {
+			kfree(trips);
+			return ERR_PTR(ret);
+		}
+
+		thres_reg_value = (eax & mask) >> shift;
+
+		trips[i].temperature = thres_reg_value ?
+			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
+
+		trips[i].type = THERMAL_TRIP_PASSIVE;
+		
+		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
+			 __func__, cpu, i, trips[i].temperature);
+	}
+
+	return trips;
+}
+
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int id = topology_logical_die_id(cpu);
@@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!zonedev)
 		return -ENOMEM;
 
+	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
+	if (IS_ERR(zonedev->trips)) {
+		err = PTR_ERR(zonedev->trips);
+		goto out_kfree_zonedev;
+	}
+	
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tj_max = tj_max;
-	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
-			thres_count,
+	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
+			zonedev->trips, thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
-		kfree(zonedev);
-		return err;
+		goto out_kfree_trips;
 	}
 	err = thermal_zone_device_enable(zonedev->tzone);
-	if (err) {
-		thermal_zone_device_unregister(zonedev->tzone);
-		kfree(zonedev);
-		return err;
-	}
+	if (err)
+		goto out_unregister_tz;
+
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
 	      zonedev->msr_pkg_therm_high);
@@ -379,7 +382,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
 	raw_spin_unlock_irq(&pkg_temp_lock);
-	return 0;
+
+out_unregister_tz:	
+	thermal_zone_device_unregister(zonedev->tzone);
+out_kfree_trips:
+	kfree(zonedev->trips);
+out_kfree_zonedev:
+	kfree(zonedev);
+	return err;
 }
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
@@ -463,8 +473,10 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
-	if (lastcpu)
+	if (lastcpu) {
+		kfree(zonedev->trips);
 		kfree(zonedev);
+	}
 	return 0;
 }
 
-- 
2.34.1

