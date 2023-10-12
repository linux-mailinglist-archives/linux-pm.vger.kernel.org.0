Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440D17C756C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442057AbjJLR7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441986AbjJLR6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF01C9;
        Thu, 12 Oct 2023 10:58:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad810be221so200445866b.2;
        Thu, 12 Oct 2023 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133529; x=1697738329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WNElS/gVnJhRodzwUmP0WXL6VdUMTQJu5AaQ9GZlUg=;
        b=SPR6d2QwufOKWrXD2/9Q++jxb+iO7DJcj4nOwhln0SMWvYHA4FUeM2k22oL04Uoi+9
         YyPfuCOzvA0ME4eNpBkOoqTcEVyJyLNcd8t7H740RXTWMOY1klh1bfuy3FHqit+ugpie
         NmySB39ZxmDZ7FKZOiNhcJBA8vqNj4eiW7K2YalKXKZ1g1gcGEn1jVZHXtZDTi2c9yu2
         GFUDYKlsGkZg/lIeE37DvENcdTeunoOQ5cieWQunqM+THZ8fYnz9gyI3GuVlR/Wv5y/8
         RLuWFVKwJCFH5fInU3/YCd3XDxUYJ9QvcPXchADYXZDYYIKFx18BXxROHgRuyrWmLWOJ
         Dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133529; x=1697738329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WNElS/gVnJhRodzwUmP0WXL6VdUMTQJu5AaQ9GZlUg=;
        b=clc4p77qZnHdM78j+Yi63fq/RHp9GLcpCas/KTy7M6Ezwuqy6dnpovmebrr5nZh1Yn
         XrIb1jvLaNtawZhtQWHnxzBuKkh5I7pI5uMr/bnM1KZ9ppS4Yk0ttd9cwSz0ZKP2rGoy
         GVj+liPFC3iBqf0FCzxKLXgK4uIq9aJdsx9Cef2otiAX9fZnZpn/BktNud8V8EMGlNoK
         6NxqAyVbMQQoDHHkzYlr1NSyk10P+6nSjC7VwBTj3K0LAlHdUX/kMozdQeg1qgIbKP1s
         9wyrtQQYMsT4u5AWnOZKCvCSQg0PymB5OkPbGwO2iXXsiZ0huj08Yj5OWIuCP5nlvEDE
         Ju+Q==
X-Gm-Message-State: AOJu0Yzulhws463wXg5TsEcWDFrrHsgNtqwlTBWW5c+1nD6QZvta8xWV
        ihZyX8gemQwvC7m/kYPmKkA=
X-Google-Smtp-Source: AGHT+IHcE/jBQFNxQ41NPCURuAvnpb/2vkuwQ1FGV1bsMXNlj5dqIlQYfKNQyIRn2B0k5iQBXy23pA==
X-Received: by 2002:a17:907:7603:b0:9b2:b633:ada2 with SMTP id jx3-20020a170907760300b009b2b633ada2mr21913345ejc.36.1697133529446;
        Thu, 12 Oct 2023 10:58:49 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b20-20020a170906491400b00988dbbd1f7esm11314362ejq.213.2023.10.12.10.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 06/13] thermal: tegra: Do not register cooling device
Date:   Thu, 12 Oct 2023 19:58:27 +0200
Message-ID: <20231012175836.3408077-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The SOCTHERM's built-in throttling mechanism doesn't map well to the
concept of a cooling device because it will automatically start to
throttle when the programmed temperature threshold is crossed.

Remove the cooling device implementation and instead unconditionally
program the throttling for the CPU and GPU thermal zones.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- adapt to new DT bindings

 drivers/thermal/tegra/soctherm.c          | 287 +++++++++-------------
 drivers/thermal/tegra/soctherm.h          |   1 +
 drivers/thermal/tegra/tegra124-soctherm.c |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c |   4 +
 5 files changed, 132 insertions(+), 168 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 11c23ace2c81..105ec20d509d 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -33,7 +33,6 @@
 
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
-#include "../thermal_core.h"
 #include "soctherm.h"
 
 #define SENSOR_CONFIG0				0
@@ -317,12 +316,16 @@ struct soctherm_throt_cfg {
 	const char *name;
 	unsigned int id;
 	u8 priority;
+	int temperature;
+	int hysteresis;
 	u8 cpu_throt_level;
 	u32 cpu_throt_depth;
 	u32 gpu_throt_level;
 	struct soctherm_oc_cfg oc_cfg;
-	struct thermal_cooling_device *cdev;
 	bool init;
+
+	unsigned int num_zones;
+	struct device_node **zones;
 };
 
 struct tegra_soctherm {
@@ -497,9 +500,7 @@ static int thermtrip_program(struct tegra_soctherm *ts,
  * throttrip_program() - Configures the hardware to throttle the
  * pulse if a given sensor group reaches a given temperature
  * @ts: pointer to a struct tegra_soctherm
- * @sg: pointer to the sensor group to set the thermtrip temperature for
  * @stc: pointer to the throttle need to be triggered
- * @trip_temp: the temperature in millicelsius to trigger the thermal trip at
  *
  * Sets the thermal trip threshold and throttle event of the given sensor
  * group. If this threshold is crossed, the hardware will trigger the
@@ -510,43 +511,68 @@ static int thermtrip_program(struct tegra_soctherm *ts,
  *
  * Return: 0 upon success, or %-EINVAL upon failure.
  */
-static int throttrip_program(struct tegra_soctherm *ts,
-			     const struct tegra_tsensor_group *sg,
-			     struct soctherm_throt_cfg *stc,
-			     int trip_temp)
+static int throttrip_program(struct tegra_soctherm *tegra,
+			     struct soctherm_throt_cfg *stc)
 {
-	int temp, cpu_throt, gpu_throt;
-	unsigned int throt;
-	u32 r, reg_off;
+	int high, low, cpu_throt, gpu_throt;
+	unsigned int throt, i, j;
 
-	if (!sg || !stc || !stc->init)
-		return -EINVAL;
+	high = enforce_temp_range(tegra, stc->temperature);
+	high /= tegra->soc->thresh_grain;
+	low = enforce_temp_range(tegra, stc->temperature - stc->hysteresis);
+	low /= tegra->soc->thresh_grain;
 
-	temp = enforce_temp_range(ts, trip_temp) / ts->soc->thresh_grain;
+	for (i = 0; i < stc->num_zones; i++) {
+		struct tegra_thermctl_zone *zone = NULL;
+		unsigned int offset;
+		u32 r;
 
-	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
-	throt = stc->id;
-	reg_off = THERMCTL_LVL_REG(sg->thermctl_lvl0_offset, throt + 1);
+		for (j = 0; j < tegra->soc->num_ttgs; j++) {
+			struct thermal_zone_device *tz = tegra->thermctl_tzs[j];
 
-	if (throt == THROTTLE_LIGHT) {
-		cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_LIGHT;
-		gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_LIGHT;
-	} else {
-		cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY;
-		gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY;
-		if (throt != THROTTLE_HEAVY)
-			dev_warn(ts->dev,
-				 "invalid throt id %d - assuming HEAVY",
-				 throt);
-	}
+			if (tz->device.of_node == stc->zones[i]) {
+				zone = thermal_zone_device_priv(tz);
+				break;
+			}
+		}
 
-	r = readl(ts->regs + reg_off);
-	r = REG_SET_MASK(r, sg->thermctl_lvl0_up_thresh_mask, temp);
-	r = REG_SET_MASK(r, sg->thermctl_lvl0_dn_thresh_mask, temp);
-	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_CPU_THROT_MASK, cpu_throt);
-	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_GPU_THROT_MASK, gpu_throt);
-	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 1);
-	writel(r, ts->regs + reg_off);
+		if (!zone)
+			continue;
+
+		if (!zone->sg->can_throttle) {
+			dev_warn(tegra->dev, "zone %s cannot be throttled\n",
+				 zone->sg->name);
+			continue;
+		}
+
+		/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
+		throt = stc->id;
+		offset = THERMCTL_LVL_REG(zone->sg->thermctl_lvl0_offset, throt + 1);
+
+		if (throt == THROTTLE_LIGHT) {
+			cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_LIGHT;
+			gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_LIGHT;
+		} else {
+			cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY;
+			gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY;
+			if (throt != THROTTLE_HEAVY)
+				dev_warn(tegra->dev,
+					 "invalid throt id %d - assuming HEAVY",
+					 throt);
+		}
+
+		r = readl(tegra->regs + offset);
+		r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_up_thresh_mask, high);
+		r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_dn_thresh_mask, low);
+		r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_CPU_THROT_MASK, cpu_throt);
+		r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_GPU_THROT_MASK, gpu_throt);
+		r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 1);
+		writel(r, tegra->regs + offset);
+
+		dev_info(tegra->dev,
+			 "throttrip: will throttle when %s reaches %d mC\n",
+			 zone->sg->name, stc->temperature);
+	}
 
 	return 0;
 }
@@ -606,25 +632,6 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 			return thermtrip_program(ts, sg, temp);
 		else
 			return 0;
-
-	} else if (trip.type == THERMAL_TRIP_HOT) {
-		int i;
-
-		for (i = 0; i < THROTTLE_SIZE; i++) {
-			struct thermal_cooling_device *cdev;
-			struct soctherm_throt_cfg *stc;
-
-			if (!ts->throt_cfgs[i].init)
-				continue;
-
-			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip_id))
-				stc = find_throttle_cfg_by_name(ts, cdev->type);
-			else
-				continue;
-
-			return throttrip_program(ts, sg, stc, temp);
-		}
 	}
 
 	return 0;
@@ -685,29 +692,9 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
-{
-	int i, ret;
-	struct thermal_trip trip;
-
-	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
-
-		ret = thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			return -EINVAL;
-
-		if (trip.type == THERMAL_TRIP_HOT) {
-			*trip_id = i;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 /**
  * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
- * @dev: struct device * of the SOC_THERM instance
+ * @ts: pointer to a struct tegra_soctherm
  * @sg: pointer to the sensor group to set the thermtrip temperature for
  * @tz: struct thermal_zone_device *
  *
@@ -725,16 +712,12 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
  * THERMTRIP has been enabled successfully when a message similar to
  * this one appears on the serial console:
  * "thermtrip: will shut down when sensor group XXX reaches YYYYYY mC"
- * THROTTLE has been enabled successfully when a message similar to
- * this one appears on the serial console:
- * ""throttrip: will throttle when sensor group XXX reaches YYYYYY mC"
  */
 static int tegra_soctherm_set_hwtrips(struct tegra_soctherm *ts,
 				      const struct tegra_tsensor_group *sg,
 				      struct thermal_zone_device *tz)
 {
-	struct soctherm_throt_cfg *stc;
-	int i, trip, temperature, ret;
+	int temperature, ret;
 
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
@@ -752,43 +735,31 @@ static int tegra_soctherm_set_hwtrips(struct tegra_soctherm *ts,
 	dev_info(ts->dev, "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
-	ret = get_hot_temp(tz, &trip, &temperature);
-	if (ret) {
-		dev_info(ts->dev, "throttrip: %s: missing hot temperature\n",
-			 sg->name);
-		return 0;
-	}
-
-	for (i = 0; i < THROTTLE_OC1; i++) {
-		struct thermal_cooling_device *cdev;
-
-		if (!ts->throt_cfgs[i].init)
-			continue;
-
-		cdev = ts->throt_cfgs[i].cdev;
-		if (get_thermal_instance(tz, cdev, trip))
-			stc = find_throttle_cfg_by_name(ts, cdev->type);
-		else
-			continue;
-
-		ret = throttrip_program(ts, sg, stc, temperature);
-		if (ret) {
-			dev_err(ts->dev, "throttrip: %s: error during enable\n",
-				sg->name);
-			return ret;
-		}
+	return 0;
+}
 
-		dev_info(ts->dev,
-			 "throttrip: will throttle when %s reaches %d mC\n",
-			 sg->name, temperature);
-		break;
-	}
+/*
+ * soctherm_enable_hw_throttling() - enable hardware throttling trip points
+ * @tegra: pointer to a struct tegra_soctherm
+ *
+ * THROTTLE has been enabled successfully when a message similar to
+ * this one appears on the serial console:
+ * ""throttrip: will throttle when sensor group XXX reaches YYYYYY mC"
+ */
+static void soctherm_enable_hw_throttling(struct tegra_soctherm *tegra)
+{
+	struct soctherm_throt_cfg *stc;
+	int err;
 
-	if (i == THROTTLE_SIZE)
-		dev_info(ts->dev, "throttrip: %s: missing throttle cdev\n",
-			 sg->name);
+	/* if configured, program the pulse skipper for CPU and GPU zones */
+	stc = find_throttle_cfg_by_name(tegra, "heavy");
+	if (!stc)
+		return;
 
-	return 0;
+	err = throttrip_program(tegra, stc);
+	if (err)
+		dev_err(tegra->dev, "throttrip: %s: failed to enable: %d\n",
+			stc->name, err);
 }
 
 static irqreturn_t soctherm_thermal_isr(int irq, void *dev_id)
@@ -1494,40 +1465,6 @@ static int soctherm_clk_enable(struct tegra_soctherm *tegra, bool enable)
 	return 0;
 }
 
-static int throt_get_cdev_max_state(struct thermal_cooling_device *cdev,
-				    unsigned long *max_state)
-{
-	*max_state = 1;
-	return 0;
-}
-
-static int throt_get_cdev_cur_state(struct thermal_cooling_device *cdev,
-				    unsigned long *cur_state)
-{
-	struct tegra_soctherm *ts = cdev->devdata;
-	u32 r;
-
-	r = readl(ts->regs + THROT_STATUS);
-	if (REG_GET_MASK(r, THROT_STATUS_STATE_MASK))
-		*cur_state = 1;
-	else
-		*cur_state = 0;
-
-	return 0;
-}
-
-static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
-				unsigned long cur_state)
-{
-	return 0;
-}
-
-static const struct thermal_cooling_device_ops throt_cooling_ops = {
-	.get_max_state = throt_get_cdev_max_state,
-	.get_cur_state = throt_get_cdev_cur_state,
-	.set_cur_state = throt_set_cdev_state,
-};
-
 static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 {
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
@@ -1633,6 +1570,33 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 	else
 		goto err;
 
+	ret = of_property_read_u32(np, "temperature-millicelsius",
+				   &stc->temperature);
+	if (ret < 0)
+		goto err;
+
+	ret = of_property_read_u32(np, "hysteresis-millicelsius",
+				   &stc->hysteresis);
+	if (ret < 0)
+		goto err;
+
+	stc->num_zones = of_count_phandle_with_args(np, "nvidia,thermal-zones",
+						    NULL);
+	if (stc->num_zones > 0) {
+		struct device_node *zone;
+		unsigned int i;
+
+		stc->zones = devm_kcalloc(ts->dev, stc->num_zones, sizeof(zone),
+					  GFP_KERNEL);
+		if (!stc->zones)
+			return -ENOMEM;
+
+		for (i = 0; i < stc->num_zones; i++) {
+			zone = of_parse_phandle(np, "nvidia,thermal-zones", i);
+			stc->zones[i] = zone;
+		}
+	}
+
 	return 0;
 
 err:
@@ -1642,14 +1606,12 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 }
 
 /**
- * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
- * and register them as cooling devices.
+ * soctherm_init_hw_throttling() - parse the HW throttle configurations
  * @tegra: pointer to Tegra soctherm structure
  */
-static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
+static void soctherm_init_hw_throttling(struct tegra_soctherm *tegra)
 {
 	struct device_node *np_stc, *np_stcc;
-	const char *name;
 	int i;
 
 	for (i = 0; i < THROTTLE_SIZE; i++) {
@@ -1666,11 +1628,10 @@ static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
 	}
 
 	for_each_child_of_node(np_stc, np_stcc) {
+		const char *name = np_stcc->name;
 		struct soctherm_throt_cfg *stc;
-		struct thermal_cooling_device *tcd;
 		int err;
 
-		name = np_stcc->name;
 		stc = find_throttle_cfg_by_name(tegra, name);
 		if (!stc) {
 			dev_err(tegra->dev, "throttle-cfg: could not find %s\n",
@@ -1692,19 +1653,6 @@ static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
 		if (stc->id >= THROTTLE_OC1) {
 			soctherm_oc_cfg_parse(tegra, np_stcc, stc);
 			stc->init = true;
-		} else {
-
-			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, tegra,
-							 &throt_cooling_ops);
-			if (IS_ERR_OR_NULL(tcd)) {
-				dev_err(tegra->dev,
-					"throttle-cfg: %s: failed to register cooling device\n",
-					name);
-				continue;
-			}
-			stc->cdev = tcd;
-			stc->init = true;
 		}
 	}
 
@@ -2148,7 +2096,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	soctherm_thermtrips_parse(tegra);
 
-	soctherm_init_hw_throt_cdev(tegra);
+	soctherm_init_hw_throttling(tegra);
 
 	soctherm_init(tegra);
 
@@ -2183,6 +2131,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 	}
 
+	soctherm_enable_hw_throttling(tegra);
 	err = soctherm_interrupts_init(tegra);
 
 	soctherm_debug_init(tegra);
@@ -2238,6 +2187,8 @@ static int __maybe_unused soctherm_resume(struct device *dev)
 		}
 	}
 
+	soctherm_enable_hw_throttling(tegra);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 70501e73d586..894bee5d96c5 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -83,6 +83,7 @@ struct tegra_tsensor_group {
 	u16 thermctl_lvl0_offset;
 	u32 thermctl_lvl0_up_thresh_mask;
 	u32 thermctl_lvl0_dn_thresh_mask;
+	bool can_throttle;
 };
 
 struct tegra_tsensor_configuration {
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
index 20ad27f4d1a1..7b11fa8fb533 100644
--- a/drivers/thermal/tegra/tegra124-soctherm.c
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -60,6 +60,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
@@ -79,6 +80,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
@@ -96,6 +98,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
@@ -115,6 +118,7 @@ static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA124_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA124_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group *tegra124_tsensor_groups[] = {
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
index b76308fdad9e..304561fe9110 100644
--- a/drivers/thermal/tegra/tegra132-soctherm.c
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -60,6 +60,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_cpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
@@ -79,6 +80,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
@@ -96,6 +98,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
@@ -115,6 +118,7 @@ static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA132_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA132_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group *tegra132_tsensor_groups[] = {
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
index d0ff793f18c5..6277a8e12b8a 100644
--- a/drivers/thermal/tegra/tegra210-soctherm.c
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -61,6 +61,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
@@ -80,6 +81,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = true,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
@@ -97,6 +99,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
@@ -116,6 +119,7 @@ static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
 	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
 	.thermctl_lvl0_up_thresh_mask = TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK,
 	.thermctl_lvl0_dn_thresh_mask = TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK,
+	.can_throttle = false,
 };
 
 static const struct tegra_tsensor_group *tegra210_tsensor_groups[] = {
-- 
2.42.0

