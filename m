Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A162D1931
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgLGTKi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 14:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLGTKi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 14:10:38 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686BC0611C5
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 11:09:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r7so2603878wrc.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCh3YkTolPPOUud4un2kHWaTqPIRbwaR3OZE9Pv+gLk=;
        b=fyN6Oo4AHvNfExKI3HUy9bxEsBXaospDterXXGQ6XkEsXSMLmrDW9PFE8cyudstWjn
         i7NX9DAyhd8HWewIznJzD+NCzyZs1yOEZnt7GMC3tzwwuMtD9Ri1T1+EkOsxuxIwE2Ir
         9y7rdQXBfmDpUOkvyEjtCdP5bS3shDIzdayYjJQkk8+GCd+8EQi93zIUkp28Iju7Xjbp
         Pe60IVcvvmJjwpQ6jLmUloQ6u0y6BgibxHIp1iOZ9GlHsWeaMLcYW8oTarxMGOrBnYtw
         nhUvV6IXYS19IasG/g28MZxh25CHTs0Smjr/JoAqsurG15MDDFLkoktuIA19MN65y2KO
         66FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCh3YkTolPPOUud4un2kHWaTqPIRbwaR3OZE9Pv+gLk=;
        b=OflBj3ES/sItmMVB2MfVH2xolaz6UngIUE3MziwB5kfNTmfQGAsQ1uQjiy2Y/HfzoP
         PRaUZ59uDPaR6rYatiDhCrwHVQ+R8AvHEuFRYIzS7vlklBLrjUbfSCafn/Z4o2euLe8b
         FJfpKttZ+Y7d6HVuyRlq6BY4UbmDrZy3LU+9BxZzCLAhe3HurEVzgmcqu1Gzv0QTfUbk
         cBq6NEyyaieOQ7E1rCbV5Zp4Z51PegWkAlDXKO2ElySFtIb1ODW7XqTGyE48r45tut7+
         BW+ZRPvX2eCdKKDAaL+uJj9OXUqXTj8lHf2rXppm2UW6+H7ZtqBAZ4QCDBs6Q4rgaw8y
         Xchg==
X-Gm-Message-State: AOAM533OFn/Pu5hbg58Yu0dBAK7PG7irSVFWprftge52KahbbQMsbbKo
        5wLY3++tnWLJLqhED23KDHRcXg==
X-Google-Smtp-Source: ABdhPJyhAG6yZyaRuAu0PqhYSC+X7/QFU9aFw3pipwinmMKg36yA1qqPssLj5eC550qN+GaWP6S3CQ==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr20729608wrp.323.1607368159250;
        Mon, 07 Dec 2020 11:09:19 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id v1sm16335827wrr.48.2020.12.07.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:09:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] thermal/core: Remove ms based delay fields
Date:   Mon,  7 Dec 2020 20:09:02 +0100
Message-Id: <20201207190902.30464-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code does no longer use the ms unit based fields to set the
delays as they are replaced by the jiffies.

Remove them and replace their user to use the jiffies version instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/platform/x86/acerhdf.c                     | 3 ++-
 drivers/thermal/da9062-thermal.c                   | 4 ++--
 drivers/thermal/gov_power_allocator.c              | 2 +-
 drivers/thermal/thermal_core.c                     | 2 +-
 drivers/thermal/thermal_core.h                     | 2 --
 drivers/thermal/thermal_sysfs.c                    | 2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 include/linux/thermal.h                            | 7 -------
 8 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 7b26f601b407..b7dbcf6be13e 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 			pr_notice("interval changed to: %d\n", interval);
 
 		if (thermal)
-			thermal->polling_delay_ms = interval*1000;
+			thermal->polling_delay_jiffies =
+				msecs_to_jiffies(interval * 1000);
 
 		prev_interval = interval;
 	}
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index ebb3d0b4a5be..180edec34e07 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-		delay = msecs_to_jiffies(thermal->zone->passive_delay_ms);
+		delay = thermal->zone->passive_delay_jiffies;
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev,
 		"TJUNC temperature polling period set at %d ms\n",
-		thermal->zone->passive_delay_ms);
+		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0) {
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index f7a663f698d4..f8c3d1e40b86 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 * power being applied, slowing down the controller)
 	 */
 	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
-	d = div_frac(d, tz->passive_delay_ms);
+	d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
 	params->prev_err = err;
 
 	power_range = p + i + d;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 16ef5d652d85..aff15c6b1c61 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 
 	if (!stop && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
-	else if (!stop && tz->polling_delay_ms)
+	else if (!stop && tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2c9551ed5ef8..5baa308ee7a5 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -131,7 +131,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz);
 static inline void thermal_zone_set_passive_delay(
 	struct thermal_zone_device *tz, int delay_ms)
 {
-	tz->passive_delay_ms = delay_ms;
 	tz->passive_delay_jiffies = msecs_to_jiffies(delay_ms);
 	if (delay_ms > 1000)
 		tz->passive_delay_jiffies = round_jiffies(tz->passive_delay_jiffies);
@@ -140,7 +139,6 @@ static inline void thermal_zone_set_passive_delay(
 static inline void thermal_zone_set_polling_delay(
 	struct thermal_zone_device *tz, int delay_ms)
 {
-	tz->polling_delay_ms = delay_ms;
 	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
 	if (delay_ms > 1000)
 		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 9598b288a0a1..8532b1dd0608 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -233,7 +233,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (state && !tz->forced_passive) {
-		if (!tz->passive_delay_ms)
+		if (!tz->passive_delay_jiffies)
 			thermal_zone_set_passive_delay(tz, 1000);
 		thermal_zone_device_rebind_exception(tz, "Processor",
 						     sizeof("Processor"));
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 4baff19e1142..f84375865c97 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -166,6 +166,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 			     char *domain)
 {
 	struct ti_thermal_data *data;
+	int interval;
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
@@ -183,9 +184,10 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
+
 	ti_bandgap_set_sensor_data(bgp, id, data);
-	ti_bandgap_write_update_interval(bgp, data->sensor_id,
-					data->ti_thermal->polling_delay_ms);
+	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
 
 	return 0;
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5dd9bdb6c6ad..f23a388ded15 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -116,13 +116,8 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
- * @passive_delay_ms:	number of milliseconds to wait between polls when
- *			performing passive cooling.
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
- * @polling_delay_ms:	number of milliseconds to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
  * @polling_delay_jiffies: number of jiffies to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
@@ -164,8 +159,6 @@ struct thermal_zone_device {
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
-	int passive_delay_ms;
-	int polling_delay_ms;
 	int passive_delay_jiffies;
 	int polling_delay_jiffies;
 	int temperature;
-- 
2.17.1

