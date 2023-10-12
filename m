Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C27C756D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442093AbjJLR7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379671AbjJLR6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391CB8;
        Thu, 12 Oct 2023 10:58:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so2039652a12.2;
        Thu, 12 Oct 2023 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133527; x=1697738327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sul7VIEtKmE6Ca4YfS1+LkRAlSPAG09Y67S7vqcXqTY=;
        b=VVGP+9yBjbQnhGI4nAX9o7w7Mw2v7lK7kP7EyyLnC4D3w/cTX8KR21WLKpzBEIFeCI
         oWFlEdXvz3hqnl42CX3EeoHL/vWWdu1oVbCmsRvlZGR1ou/3vx5qLg+aD0DDyOUs8ZIx
         iyRua6n5QYydNekneo61KGwMJPSMRoAT10oBNxxnge2KrOLDSPX2Lebmt/w+Pwv3MtRk
         GNDhdfJC5UkaG4qFww6fRf3e5tPa+svjCRoVwaIk1jR+9sC+MT0HVQu0j+97FYNhpC8v
         8IUB+s3yYZhiB5hWJvO6wzbbTz2YJekQhS9Qmn4PpDiZUvg4h1958S5eEJV4zENDhClT
         CJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133527; x=1697738327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sul7VIEtKmE6Ca4YfS1+LkRAlSPAG09Y67S7vqcXqTY=;
        b=UhfdFCrH98y5rO1kC25fCe/BZWibG62+O4DngIuarDQR9L/O1pBeE/3fSWWduRvqpn
         Obhis0bNrMqmu87tKhhPq3vvZvvr07HaJ1cHQdckpuxtdXaISFecg2JdaFW0zRkxQ1Ar
         g8AYUyn1vjNvLBMDj4pYkIcbxsdVytoE1XGJYuqc0z8Dwx12piS9mP8psrXrFqD+nzg3
         Q35VNVS6hL2XuyemJZLu689N1Y7W02/F9T5GKs6g/cV6EF7BUQ2hxbpQX7Gv7TlQB23t
         O+Dj9s5sW2Gqo/uD11ZeGA965Y4pGMIORJgphJHC38GS+CXgkohJQIH4uZNnwE+UKRhI
         N/bQ==
X-Gm-Message-State: AOJu0YyJWv4iAp41icrogPfa3Qe1lD5jErWL29c4xaD7I1fz0jscDpUX
        JagriA0rnIOVeZ19deNukiI=
X-Google-Smtp-Source: AGHT+IG7ySSfvPXg82HUmFgUA1OoZ7PFPJxrAMwD/Y8NJcjqqQTX/DkgJubwU0voepnoyCNphYiWag==
X-Received: by 2002:aa7:c607:0:b0:530:7abf:3a84 with SMTP id h7-20020aa7c607000000b005307abf3a84mr20393321edq.25.1697133527523;
        Thu, 12 Oct 2023 10:58:47 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bd19-20020a056402207300b0053e31113ff7sm193004edb.94.2023.10.12.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:46 -0700 (PDT)
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
Subject: [PATCH v2 04/13] thermal: tegra: Use driver-private data consistently
Date:   Thu, 12 Oct 2023 19:58:25 +0200
Message-ID: <20231012175836.3408077-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Instead of passing around platform and plain devices and figuring out
the driver-private data within each helper, directly pass around the
driver-private data when it's available.

Also store a pointer to the parent device in the main driver-private
data structure for easier access.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 213 ++++++++++++++-----------------
 1 file changed, 95 insertions(+), 118 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index e7fe8683bfc5..f434e141dcdf 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -299,7 +299,6 @@ static const char *const throt_names[] = {
 struct tegra_soctherm;
 struct tegra_thermctl_zone {
 	void __iomem *reg;
-	struct device *dev;
 	struct tegra_soctherm *ts;
 	struct thermal_zone_device *tz;
 	const struct tegra_tsensor_group *sg;
@@ -327,6 +326,7 @@ struct soctherm_throt_cfg {
 };
 
 struct tegra_soctherm {
+	struct device *dev;
 	struct reset_control *reset;
 	struct clk *clock_tsensor;
 	struct clk *clock_soctherm;
@@ -444,14 +444,15 @@ static int tegra_thermctl_get_temp(struct thermal_zone_device *tz, int *out_temp
  *
  * Return: The precision adjusted capped temperature in millicelsius.
  */
-static int enforce_temp_range(struct device *dev, int trip_temp)
+static int enforce_temp_range(struct tegra_soctherm *ts, int trip_temp)
 {
 	int temp;
 
 	temp = clamp_val(trip_temp, min_low_temp, max_high_temp);
 	if (temp != trip_temp)
-		dev_dbg(dev, "soctherm: trip temperature %d forced to %d\n",
+		dev_dbg(ts->dev, "trip temperature %d forced to %d\n",
 			trip_temp, temp);
+
 	return temp;
 }
 
@@ -471,18 +472,17 @@ static int enforce_temp_range(struct device *dev, int trip_temp)
  *
  * Return: 0 upon success, or %-EINVAL upon failure.
  */
-static int thermtrip_program(struct device *dev,
+static int thermtrip_program(struct tegra_soctherm *ts,
 			     const struct tegra_tsensor_group *sg,
 			     int trip_temp)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	int temp;
 	u32 r;
 
 	if (!sg || !sg->thermtrip_threshold_mask)
 		return -EINVAL;
 
-	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
+	temp = enforce_temp_range(ts, trip_temp) / ts->soc->thresh_grain;
 
 	r = readl(ts->regs + THERMCTL_THERMTRIP_CTL);
 	r = REG_SET_MASK(r, sg->thermtrip_threshold_mask, temp);
@@ -496,7 +496,7 @@ static int thermtrip_program(struct device *dev,
 /**
  * throttrip_program() - Configures the hardware to throttle the
  * pulse if a given sensor group reaches a given temperature
- * @dev: ptr to the struct device for the SOC_THERM IP block
+ * @ts: pointer to a struct tegra_soctherm
  * @sg: pointer to the sensor group to set the thermtrip temperature for
  * @stc: pointer to the throttle need to be triggered
  * @trip_temp: the temperature in millicelsius to trigger the thermal trip at
@@ -510,12 +510,11 @@ static int thermtrip_program(struct device *dev,
  *
  * Return: 0 upon success, or %-EINVAL upon failure.
  */
-static int throttrip_program(struct device *dev,
+static int throttrip_program(struct tegra_soctherm *ts,
 			     const struct tegra_tsensor_group *sg,
 			     struct soctherm_throt_cfg *stc,
 			     int trip_temp)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	int temp, cpu_throt, gpu_throt;
 	unsigned int throt;
 	u32 r, reg_off;
@@ -523,7 +522,7 @@ static int throttrip_program(struct device *dev,
 	if (!sg || !stc || !stc->init)
 		return -EINVAL;
 
-	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
+	temp = enforce_temp_range(ts, trip_temp) / ts->soc->thresh_grain;
 
 	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
 	throt = stc->id;
@@ -536,7 +535,7 @@ static int throttrip_program(struct device *dev,
 		cpu_throt = THERMCTL_LVL0_CPU0_CPU_THROT_HEAVY;
 		gpu_throt = THERMCTL_LVL0_CPU0_GPU_THROT_HEAVY;
 		if (throt != THROTTLE_HEAVY)
-			dev_warn(dev,
+			dev_warn(ts->dev,
 				 "invalid throt id %d - assuming HEAVY",
 				 throt);
 	}
@@ -588,7 +587,6 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 	struct tegra_soctherm *ts = zone->ts;
 	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
-	struct device *dev = zone->dev;
 	int ret;
 
 	if (!tz)
@@ -605,7 +603,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 		 * if not, program critical trip to HW.
 		 */
 		if (min_low_temp == tsensor_group_thermtrip_get(ts, sg->id))
-			return thermtrip_program(dev, sg, temp);
+			return thermtrip_program(ts, sg, temp);
 		else
 			return 0;
 
@@ -625,7 +623,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 			else
 				continue;
 
-			return throttrip_program(dev, sg, stc, temp);
+			return throttrip_program(ts, sg, stc, temp);
 		}
 	}
 
@@ -667,9 +665,9 @@ static int tegra_thermctl_set_trips(struct thermal_zone_device *tz, int lo, int
 	r = REG_SET_MASK(r, THERMCTL_LVL0_CPU0_EN_MASK, 0);
 	writel(r, zone->ts->regs + zone->sg->thermctl_lvl0_offset);
 
-	lo = enforce_temp_range(zone->dev, lo) / zone->ts->soc->thresh_grain;
-	hi = enforce_temp_range(zone->dev, hi) / zone->ts->soc->thresh_grain;
-	dev_dbg(zone->dev, "%s hi:%d, lo:%d\n", __func__, hi, lo);
+	lo = enforce_temp_range(zone->ts, lo) / zone->ts->soc->thresh_grain;
+	hi = enforce_temp_range(zone->ts, hi) / zone->ts->soc->thresh_grain;
+	dev_dbg(zone->ts->dev, "%s hi:%d, lo:%d\n", __func__, hi, lo);
 
 	r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_up_thresh_mask, hi);
 	r = REG_SET_MASK(r, zone->sg->thermctl_lvl0_dn_thresh_mask, lo);
@@ -731,11 +729,10 @@ static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
  * this one appears on the serial console:
  * ""throttrip: will throttle when sensor group XXX reaches YYYYYY mC"
  */
-static int tegra_soctherm_set_hwtrips(struct device *dev,
+static int tegra_soctherm_set_hwtrips(struct tegra_soctherm *ts,
 				      const struct tegra_tsensor_group *sg,
 				      struct thermal_zone_device *tz)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct soctherm_throt_cfg *stc;
 	int i, trip, temperature, ret;
 
@@ -745,18 +742,19 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		if (thermal_zone_get_crit_temp(tz, &temperature))
 			temperature = max_high_temp;
 
-	ret = thermtrip_program(dev, sg, temperature);
+	ret = thermtrip_program(ts, sg, temperature);
 	if (ret) {
-		dev_err(dev, "thermtrip: %s: error during enable\n", sg->name);
+		dev_err(ts->dev, "thermtrip: %s: error during enable\n",
+			sg->name);
 		return ret;
 	}
 
-	dev_info(dev, "thermtrip: will shut down when %s reaches %d mC\n",
+	dev_info(ts->dev, "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
 	ret = get_hot_temp(tz, &trip, &temperature);
 	if (ret) {
-		dev_info(dev, "throttrip: %s: missing hot temperature\n",
+		dev_info(ts->dev, "throttrip: %s: missing hot temperature\n",
 			 sg->name);
 		return 0;
 	}
@@ -773,21 +771,21 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 		else
 			continue;
 
-		ret = throttrip_program(dev, sg, stc, temperature);
+		ret = throttrip_program(ts, sg, stc, temperature);
 		if (ret) {
-			dev_err(dev, "throttrip: %s: error during enable\n",
+			dev_err(ts->dev, "throttrip: %s: error during enable\n",
 				sg->name);
 			return ret;
 		}
 
-		dev_info(dev,
+		dev_info(ts->dev,
 			 "throttrip: will throttle when %s reaches %d mC\n",
 			 sg->name, temperature);
 		break;
 	}
 
 	if (i == THROTTLE_SIZE)
-		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
+		dev_info(ts->dev, "throttrip: %s: missing throttle cdev\n",
 			 sg->name);
 
 	return 0;
@@ -1253,8 +1251,7 @@ static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
 #ifdef CONFIG_DEBUG_FS
 static int regs_show(struct seq_file *s, void *data)
 {
-	struct platform_device *pdev = s->private;
-	struct tegra_soctherm *ts = platform_get_drvdata(pdev);
+	struct tegra_soctherm *ts = s->private;
 	const struct tegra_tsensor *tsensors = ts->soc->tsensors;
 	const struct tegra_tsensor_group **ttgs = ts->soc->ttgs;
 	u32 r, state;
@@ -1449,24 +1446,24 @@ static int regs_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(regs);
 
-static void soctherm_debug_init(struct platform_device *pdev)
+static void soctherm_debug_init(struct tegra_soctherm *tegra)
 {
-	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 	struct dentry *root;
 
 	root = debugfs_create_dir("soctherm", NULL);
 
 	tegra->debugfs_dir = root;
 
-	debugfs_create_file("reg_contents", 0644, root, pdev, &regs_fops);
+	debugfs_create_file("reg_contents", 0644, root, tegra, &regs_fops);
 }
 #else
-static inline void soctherm_debug_init(struct platform_device *pdev) {}
+static inline void soctherm_debug_init(struct tegra_soctherm *ts)
+{
+}
 #endif
 
-static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
+static int soctherm_clk_enable(struct tegra_soctherm *tegra, bool enable)
 {
-	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 	int err;
 
 	if (!tegra->clock_soctherm || !tegra->clock_tsensor)
@@ -1531,10 +1528,8 @@ static const struct thermal_cooling_device_ops throt_cooling_ops = {
 	.set_cur_state = throt_set_cdev_state,
 };
 
-static int soctherm_thermtrips_parse(struct platform_device *pdev)
+static int soctherm_thermtrips_parse(struct tegra_soctherm *ts)
 {
-	struct device *dev = &pdev->dev;
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct tsensor_group_thermtrips *tt = ts->soc->thermtrips;
 	const int max_num_prop = ts->soc->num_ttgs * 2;
 	u32 *tlb;
@@ -1543,22 +1538,22 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
 	if (!tt)
 		return -ENOMEM;
 
-	n = of_property_count_u32_elems(dev->of_node, "nvidia,thermtrips");
+	n = of_property_count_u32_elems(ts->dev->of_node, "nvidia,thermtrips");
 	if (n <= 0) {
-		dev_info(dev,
+		dev_info(ts->dev,
 			 "missing thermtrips, will use critical trips as shut down temp\n");
 		return n;
 	}
 
 	n = min(max_num_prop, n);
 
-	tlb = devm_kcalloc(&pdev->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
+	tlb = devm_kcalloc(ts->dev, max_num_prop, sizeof(u32), GFP_KERNEL);
 	if (!tlb)
 		return -ENOMEM;
-	ret = of_property_read_u32_array(dev->of_node, "nvidia,thermtrips",
+	ret = of_property_read_u32_array(ts->dev->of_node, "nvidia,thermtrips",
 					 tlb, n);
 	if (ret) {
-		dev_err(dev, "invalid num ele: thermtrips:%d\n", ret);
+		dev_err(ts->dev, "invalid num ele: thermtrips:%d\n", ret);
 		return ret;
 	}
 
@@ -1575,9 +1570,9 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
 	return 0;
 }
 
-static void soctherm_oc_cfg_parse(struct device *dev,
-				struct device_node *np_oc,
-				struct soctherm_throt_cfg *stc)
+static void soctherm_oc_cfg_parse(struct tegra_soctherm *tegra,
+				  struct device_node *np_oc,
+				  struct soctherm_throt_cfg *stc)
 {
 	u32 val;
 
@@ -1601,19 +1596,20 @@ static void soctherm_oc_cfg_parse(struct device *dev,
 	stc->oc_cfg.mode = OC_THROTTLE_MODE_BRIEF;
 }
 
-static int soctherm_throt_cfg_parse(struct device *dev,
+static int soctherm_throt_cfg_parse(struct tegra_soctherm *ts,
 				    struct device_node *np,
 				    struct soctherm_throt_cfg *stc)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	int ret;
 	u32 val;
 
 	ret = of_property_read_u32(np, "nvidia,priority", &val);
 	if (ret) {
-		dev_err(dev, "throttle-cfg: %s: invalid priority\n", stc->name);
+		dev_err(ts->dev, "throttle-cfg: %s: invalid priority\n",
+			stc->name);
 		return -EINVAL;
 	}
+
 	stc->priority = val;
 
 	ret = of_property_read_u32(np, ts->soc->use_ccroc ?
@@ -1640,7 +1636,7 @@ static int soctherm_throt_cfg_parse(struct device *dev,
 	return 0;
 
 err:
-	dev_err(dev, "throttle-cfg: %s: no throt prop or invalid prop\n",
+	dev_err(ts->dev, "throttle-cfg: %s: no throt prop or invalid prop\n",
 		stc->name);
 	return -EINVAL;
 }
@@ -1648,25 +1644,23 @@ static int soctherm_throt_cfg_parse(struct device *dev,
 /**
  * soctherm_init_hw_throt_cdev() - Parse the HW throttle configurations
  * and register them as cooling devices.
- * @pdev: Pointer to platform_device struct
+ * @tegra: pointer to Tegra soctherm structure
  */
-static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
+static void soctherm_init_hw_throt_cdev(struct tegra_soctherm *tegra)
 {
-	struct device *dev = &pdev->dev;
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	struct device_node *np_stc, *np_stcc;
 	const char *name;
 	int i;
 
 	for (i = 0; i < THROTTLE_SIZE; i++) {
-		ts->throt_cfgs[i].name = throt_names[i];
-		ts->throt_cfgs[i].id = i;
-		ts->throt_cfgs[i].init = false;
+		tegra->throt_cfgs[i].name = throt_names[i];
+		tegra->throt_cfgs[i].id = i;
+		tegra->throt_cfgs[i].init = false;
 	}
 
-	np_stc = of_get_child_by_name(dev->of_node, "throttle-cfgs");
+	np_stc = of_get_child_by_name(tegra->dev->of_node, "throttle-cfgs");
 	if (!np_stc) {
-		dev_info(dev,
+		dev_info(tegra->dev,
 			 "throttle-cfg: no throttle-cfgs - not enabling\n");
 		return;
 	}
@@ -1677,33 +1671,34 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		int err;
 
 		name = np_stcc->name;
-		stc = find_throttle_cfg_by_name(ts, name);
+		stc = find_throttle_cfg_by_name(tegra, name);
 		if (!stc) {
-			dev_err(dev,
-				"throttle-cfg: could not find %s\n", name);
+			dev_err(tegra->dev, "throttle-cfg: could not find %s\n",
+				name);
 			continue;
 		}
 
 		if (stc->init) {
-			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
+			dev_err(tegra->dev, "throttle-cfg: %s: redefined!\n",
+				name);
 			of_node_put(np_stcc);
 			break;
 		}
 
-		err = soctherm_throt_cfg_parse(dev, np_stcc, stc);
+		err = soctherm_throt_cfg_parse(tegra, np_stcc, stc);
 		if (err)
 			continue;
 
 		if (stc->id >= THROTTLE_OC1) {
-			soctherm_oc_cfg_parse(dev, np_stcc, stc);
+			soctherm_oc_cfg_parse(tegra, np_stcc, stc);
 			stc->init = true;
 		} else {
 
 			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
+							 (char *)name, tegra,
 							 &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
-				dev_err(dev,
+				dev_err(tegra->dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
 					name);
 				continue;
@@ -1711,7 +1706,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->cdev = tcd;
 			stc->init = true;
 		}
-
 	}
 
 	of_node_put(np_stc);
@@ -1931,9 +1925,8 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
 	writel(r, ts->regs + THROT_PRIORITY_LOCK);
 }
 
-static void tegra_soctherm_throttle(struct device *dev)
+static void tegra_soctherm_throttle(struct tegra_soctherm *ts)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
 	u32 v;
 	int i;
 
@@ -1969,43 +1962,29 @@ static void tegra_soctherm_throttle(struct device *dev)
 	writel(v, ts->regs + THERMCTL_STATS_CTL);
 }
 
-static int soctherm_interrupts_init(struct platform_device *pdev,
-				    struct tegra_soctherm *tegra)
+static int soctherm_interrupts_init(struct tegra_soctherm *tegra)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = soctherm_oc_int_init(np, TEGRA_SOC_OC_IRQ_MAX);
+	ret = soctherm_oc_int_init(tegra->dev->of_node, TEGRA_SOC_OC_IRQ_MAX);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "soctherm_oc_int_init failed\n");
+		dev_err(tegra->dev, "soctherm_oc_int_init failed\n");
 		return ret;
 	}
 
-	tegra->thermal_irq = platform_get_irq(pdev, 0);
-	if (tegra->thermal_irq < 0) {
-		dev_dbg(&pdev->dev, "get 'thermal_irq' failed.\n");
-		return 0;
-	}
-
-	tegra->edp_irq = platform_get_irq(pdev, 1);
-	if (tegra->edp_irq < 0) {
-		dev_dbg(&pdev->dev, "get 'edp_irq' failed.\n");
-		return 0;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev,
+	ret = devm_request_threaded_irq(tegra->dev,
 					tegra->thermal_irq,
 					soctherm_thermal_isr,
 					soctherm_thermal_isr_thread,
 					IRQF_ONESHOT,
-					dev_name(&pdev->dev),
+					dev_name(tegra->dev),
 					tegra);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+		dev_err(tegra->dev, "failed to request thermal IRQ: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
+	ret = devm_request_threaded_irq(tegra->dev,
 					tegra->edp_irq,
 					soctherm_edp_isr,
 					soctherm_edp_isr_thread,
@@ -2013,16 +1992,15 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 					"soctherm_edp",
 					tegra);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+		dev_err(tegra->dev, "failed to request EDP IRQ: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void soctherm_init(struct platform_device *pdev)
+static void soctherm_init(struct tegra_soctherm *tegra)
 {
-	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 	const struct tegra_tsensor_group **ttgs = tegra->soc->ttgs;
 	int i;
 	u32 pdiv, hotspot;
@@ -2048,7 +2026,7 @@ static void soctherm_init(struct platform_device *pdev)
 	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
 
 	/* Configure hw throttle */
-	tegra_soctherm_throttle(&pdev->dev);
+	tegra_soctherm_throttle(tegra);
 }
 
 static const struct of_device_id tegra_soctherm_of_match[] = {
@@ -2096,9 +2074,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
-	mutex_init(&tegra->thermctl_lock);
 	dev_set_drvdata(&pdev->dev, tegra);
-
+	mutex_init(&tegra->thermctl_lock);
+	tegra->dev = &pdev->dev;
 	tegra->soc = soc;
 
 	tegra->regs = devm_platform_ioremap_resource_byname(pdev, "soctherm-reg");
@@ -2121,6 +2099,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 	}
 
+	tegra->thermal_irq = platform_get_irq(pdev, 0);
+	tegra->edp_irq = platform_get_irq(pdev, 1);
+
 	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
 	if (IS_ERR(tegra->reset)) {
 		dev_err(&pdev->dev, "can't get soctherm reset\n");
@@ -2165,15 +2146,15 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (!tegra->thermctl_tzs)
 		return -ENOMEM;
 
-	err = soctherm_clk_enable(pdev, true);
+	err = soctherm_clk_enable(tegra, true);
 	if (err)
 		return err;
 
-	soctherm_thermtrips_parse(pdev);
+	soctherm_thermtrips_parse(tegra);
 
-	soctherm_init_hw_throt_cdev(pdev);
+	soctherm_init_hw_throt_cdev(tegra);
 
-	soctherm_init(pdev);
+	soctherm_init(tegra);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
 		struct tegra_thermctl_zone *zone =
@@ -2184,7 +2165,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		}
 
 		zone->reg = tegra->regs + soc->ttgs[i]->sensor_temp_offset;
-		zone->dev = &pdev->dev;
 		zone->sg = soc->ttgs[i];
 		zone->ts = tegra;
 
@@ -2202,19 +2182,19 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
 		/* Configure hw trip points */
-		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
+		err = tegra_soctherm_set_hwtrips(tegra, soc->ttgs[i], z);
 		if (err)
 			goto disable_clocks;
 	}
 
-	err = soctherm_interrupts_init(pdev, tegra);
+	err = soctherm_interrupts_init(tegra);
 
-	soctherm_debug_init(pdev);
+	soctherm_debug_init(tegra);
 
 	return 0;
 
 disable_clocks:
-	soctherm_clk_enable(pdev, false);
+	soctherm_clk_enable(tegra, false);
 
 	return err;
 }
@@ -2225,42 +2205,39 @@ static void tegra_soctherm_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(tegra->debugfs_dir);
 
-	soctherm_clk_enable(pdev, false);
+	soctherm_clk_enable(tegra, false);
 }
 
 static int __maybe_unused soctherm_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
+	struct tegra_soctherm *tegra = dev_get_drvdata(dev);
 
-	soctherm_clk_enable(pdev, false);
+	soctherm_clk_enable(tegra, false);
 
 	return 0;
 }
 
 static int __maybe_unused soctherm_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+	struct tegra_soctherm *tegra = dev_get_drvdata(dev);
 	struct tegra_soctherm_soc *soc = tegra->soc;
 	int err, i;
 
-	err = soctherm_clk_enable(pdev, true);
+	err = soctherm_clk_enable(tegra, true);
 	if (err) {
-		dev_err(&pdev->dev,
-			"Resume failed: enable clocks failed\n");
+		dev_err(dev, "Resume failed: enable clocks failed\n");
 		return err;
 	}
 
-	soctherm_init(pdev);
+	soctherm_init(tegra);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
 		struct thermal_zone_device *tz;
 
 		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
-		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
+		err = tegra_soctherm_set_hwtrips(tegra, soc->ttgs[i], tz);
 		if (err) {
-			dev_err(&pdev->dev,
-				"Resume failed: set hwtrips failed\n");
+			dev_err(dev, "Resume failed: set hwtrips failed\n");
 			return err;
 		}
 	}
-- 
2.42.0

