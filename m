Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C46E23E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDNM6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDNM56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:57:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DBB46F;
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w24so7805103wra.10;
        Fri, 14 Apr 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477051; x=1684069051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FjuQyxE6PbfpJxzLBZ3ivqNaKU/XIl3CzS5rxOJdxk=;
        b=oalyN7EcFY8cdMg1zKCRVPOZh1XVXojCezIfjmO25M7pXXKm0qCI18bfUaFhOtyUhO
         8I2L/S6A/POwTVz0UekwWjyeygexm8kjHU2NrVnDCBsCxz2zwguAajmxOGr04HAxZFB0
         wZ2p8HUBHetBGpjvH7/QIQ+iq/oEbaTq6GEGo8K13unP4wIHPXRlA+bIiyhAjZfv/Qxg
         cwo5e1265Jc4ppa5jMT46FNvY678ruu1HjMC6R9FOh6s+lQyDMza9834krYk0Owzcwvk
         O1QJzIN5kF0tz+vYrcLq/Ar+4Hz1n0/faCAMv+0+RtImkYy5wRKXk6Mx+dwNFiBwqVcd
         WiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477051; x=1684069051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FjuQyxE6PbfpJxzLBZ3ivqNaKU/XIl3CzS5rxOJdxk=;
        b=KRRxwuB5ne/mUtNmrt5fZh5BICVl0D8qM/VEgzqUFs7PM+zsXFLpre4r/svVhnGoG8
         JyAV0Rv98qazypLjslLXuO949Lym/CXqsBDmKmRhk4Ctxc+CqWIE1/PDnXflKE3mnuxi
         NZ+7JBSO4CXe+ddUHJn8sr+XUa79jaJngTIWxod7sTjCvH2jeJFxbDNSSgIh2zodElvG
         ueoJUeom07mpy9s9IJ+m84IZxh+eGcHdKLFnJmduSJe+e8TOqO2at+4PlSSM2OhPoTCn
         hU6StW2WofZBFhyZlIPnGV5Ia6YyWubXy7I0n+8z61w6BYpfvGwQ6EQd3gCqvnjpeEhy
         mvHw==
X-Gm-Message-State: AAQBX9c6qeOeke94om2UfqkC1oSuWbHeBnmY7PoyPPclUsKVhYU/6F5y
        9awB7okllWiRAgWsM9Phpac=
X-Google-Smtp-Source: AKy350aNl4zMXNHIJD6sXK33P90cQPuQcvk3Lzbzli80+Ki9sXMlkX4qI1z1PzCQ2b+U7W6mnCM7ow==
X-Received: by 2002:adf:e5cc:0:b0:2ef:b6e6:5985 with SMTP id a12-20020adfe5cc000000b002efb6e65985mr4388493wrn.58.1681477050774;
        Fri, 14 Apr 2023 05:57:30 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d6a89000000b002cf1c435afcsm3532875wru.11.2023.04.14.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:30 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 04/10] thermal: tegra: Do not register cooling device
Date:   Fri, 14 Apr 2023 14:57:15 +0200
Message-Id: <20230414125721.1043589-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/tegra/soctherm.c          | 148 +++-------------------
 drivers/thermal/tegra/soctherm.h          |   1 +
 drivers/thermal/tegra/tegra124-soctherm.c |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c |   4 +
 5 files changed, 33 insertions(+), 128 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 958fa10de516..eb12e8cc0a2f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -317,11 +317,11 @@ struct soctherm_throt_cfg {
 	const char *name;
 	unsigned int id;
 	u8 priority;
+	int temperature;
 	u8 cpu_throt_level;
 	u32 cpu_throt_depth;
 	u32 gpu_throt_level;
 	struct soctherm_oc_cfg oc_cfg;
-	struct thermal_cooling_device *cdev;
 	bool init;
 };
 
@@ -606,25 +606,6 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
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
@@ -685,26 +666,6 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
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
  * @dev: struct device * of the SOC_THERM instance
@@ -734,7 +695,7 @@ static int tegra_soctherm_set_hwtrips(struct tegra_soctherm *ts,
 				      struct thermal_zone_device *tz)
 {
 	struct soctherm_throt_cfg *stc;
-	int i, trip, temperature, ret;
+	int temperature, ret;
 
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
@@ -752,42 +713,19 @@ static int tegra_soctherm_set_hwtrips(struct tegra_soctherm *ts,
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
+	/* if configured, program the pulse skipper for CPU and GPU zones */
+	if (sg->can_throttle) {
+		stc = find_throttle_cfg_by_name(ts, "heavy");
+		if (stc && stc->init) {
+			ret = throttrip_program(ts, sg, stc, temperature);
+			if (ret) {
+				dev_err(ts->dev,
+					"throttrip: %s: failed to enable: %d\n",
+					sg->name, ret);
+			}
 		}
-
-		dev_info(ts->dev,
-			 "throttrip: will throttle when %s reaches %d mC\n",
-			 sg->name, temperature);
-		break;
 	}
 
-	if (i == THROTTLE_SIZE)
-		dev_info(ts->dev, "throttrip: %s: missing throttle cdev\n",
-			 sg->name);
-
 	return 0;
 }
 
@@ -1494,40 +1432,6 @@ static int soctherm_clk_enable(struct tegra_soctherm *tegra, bool enable)
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
@@ -1633,6 +1537,10 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 	else
 		goto err;
 
+	ret = of_property_read_u32(np, "temperature", &stc->temperature);
+	if (ret < 0)
+		goto err;
+
 	return 0;
 
 err:
@@ -1642,14 +1550,12 @@ static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
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
@@ -1666,11 +1572,10 @@ static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
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
@@ -1692,19 +1597,6 @@ static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
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
 
@@ -2148,7 +2040,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	soctherm_thermtrips_parse(tegra);
 
-	soctherm_init_hw_throt_cdev(tegra);
+	soctherm_init_hw_throttling(tegra);
 
 	soctherm_init(tegra);
 
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
2.40.0

