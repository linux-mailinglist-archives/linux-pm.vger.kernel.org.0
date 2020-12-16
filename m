Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0032DC8B5
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgLPWFS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 17:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbgLPWFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 17:05:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C250CC061285
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y17so24607708wrr.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 14:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFgXPJfjD7GeFy7r1aNbCblOGwmVkP2fCvjV5sFWQVs=;
        b=N//iL0qvMkM0Utn3XGW/DDwZKo1Pqhsxj9g55/jjA6eTsq7OWprE1A+hlwObC3j4YG
         UKVth+jr8dLa5rF1NxXgceugn+T5E+bQYE7q3D0Mm1Hmm99B4cERmLM2o2OSV3sc5wV9
         LDl3HsMnQKOtpKfK8kppLwXLSmwTE5gAxfdU9WrwzkAjF8mKC2TC7sUCsjEoNnUmBN6+
         YQy+oWS256SpX3G2qY9gG+Qu4xLVEOFplbZNmNrPoAatRZsruVky6bdvVZgOFMQnLDlT
         u0Nnmdrm1W9vfyPS5pkdTjYlmbQ3IQYKUiS6uXdECDYKSzKuJBY9hp/XJ+pAsXPwjmeN
         X+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFgXPJfjD7GeFy7r1aNbCblOGwmVkP2fCvjV5sFWQVs=;
        b=pqv1h6VbJpgmll7Boqn3cZSNvexJVDoO9PnowE8vWO6I0VlLJ3MNXH38v2GfRWQEhQ
         iiRhx8UIASBhm4F0oVIUljW35RQhH5V8eo+qphP9l2gvE0jVFallsPC7jRWB/hGhBsF1
         OW0vZQwSoQlJhrJoiU6TNgJncOe8riWG/xXv25o+NKIT96ZXTQLG2t+8496E3jj3mfyT
         NfHYeU13Th20hS6znzam8CYoL/NmXbIrNXMIBWOUO36q4CCBesU09IxqJpgny6ZjCIS/
         CRNr1JRxy8n3K62GZ3u8+jM4xo9gCwJ8UHjMtRdTXmF6CRBZCd6RNWNThe5/Xr1ooubY
         wz9w==
X-Gm-Message-State: AOAM532vamj4LjgQObxm3P3BopOLHxfxshwyG7qTFGMiYHzBfBpgfG5n
        GMQNXSZErqKXJiw91/+4EONT8g==
X-Google-Smtp-Source: ABdhPJzRlBrP1Gt6pfGYHMtTrFWaZBlGy41UgcCO9oorV/UieHGo5rhYF50u8hVIgHR0SKfY8v7o+A==
X-Received: by 2002:adf:e443:: with SMTP id t3mr4687971wrm.366.1608156238097;
        Wed, 16 Dec 2020 14:03:58 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.gmail.com with ESMTPSA id a17sm5277933wrs.20.2020.12.16.14.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:03:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
Date:   Wed, 16 Dec 2020 23:03:37 +0100
Message-Id: <20201216220337.839878-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201216220337.839878-1-daniel.lezcano@linaro.org>
References: <20201216220337.839878-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code does no longer use the ms unit based fields to set the
delays as they are replaced by the jiffies.

Remove them and replace their user to use the jiffies version instead.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/platform/x86/acerhdf.c                     | 3 ++-
 drivers/thermal/da9062-thermal.c                   | 4 ++--
 drivers/thermal/gov_power_allocator.c              | 2 +-
 drivers/thermal/thermal_core.c                     | 4 +---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 include/linux/thermal.h                            | 7 -------
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index b6aa6e5514f4..6b8b3ab8db48 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -336,7 +336,8 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 			pr_notice("interval changed to: %d\n", interval);
 
 		if (thermal)
-			thermal->polling_delay = interval*1000;
+			thermal->polling_delay_jiffies =
+				round_jiffies(msecs_to_jiffies(interval * 1000));
 
 		prev_interval = interval;
 	}
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 4d74994f160a..180edec34e07 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -95,7 +95,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-		delay = msecs_to_jiffies(thermal->zone->passive_delay);
+		delay = thermal->zone->passive_delay_jiffies;
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -245,7 +245,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev,
 		"TJUNC temperature polling period set at %d ms\n",
-		thermal->zone->passive_delay);
+		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0) {
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 7a4170a0b51f..f8c3d1e40b86 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -258,7 +258,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 * power being applied, slowing down the controller)
 	 */
 	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
-	d = div_frac(d, tz->passive_delay);
+	d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
 	params->prev_err = err;
 
 	power_range = p + i + d;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d96c515af3cb..b2615449b18f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,7 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 
 	if (!stop && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
-	else if (!stop && tz->polling_delay)
+	else if (!stop && tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
@@ -1307,8 +1307,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
-	tz->passive_delay = passive_delay;
-	tz->polling_delay = polling_delay;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 2ce4b19f312a..f84375865c97 100644
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
-					data->ti_thermal->polling_delay);
+	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
 
 	return 0;
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d1b82c70de69..1e686404951b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -115,13 +115,8 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
- * @passive_delay:	number of milliseconds to wait between polls when
- *			performing passive cooling.
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
- * @polling_delay:	number of milliseconds to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
  * @polling_delay_jiffies: number of jiffies to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
@@ -162,8 +157,6 @@ struct thermal_zone_device {
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-	int passive_delay;
-	int polling_delay;
 	int temperature;
 	int last_temperature;
 	int emul_temperature;
-- 
2.25.1

