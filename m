Return-Path: <linux-pm+bounces-36697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BCBFFD9F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24743AA9C5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2C2F5333;
	Thu, 23 Oct 2025 08:20:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA62F39B9;
	Thu, 23 Oct 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207631; cv=none; b=GR4owAFRA+wLAhdbbCNZ7thdNZOOKV9ji7FZ7kZjZMrCbwPRvpMC6Wfqn8rZ2qvyIxDCvIK5czae8o2Q/hGfDXFHpSr/rT+SfYINHdkgvlutVrAaNhZaw2OesrmY9XVfxyuaXSPbnE/x35F0OHLJLmYe5mKsaagFuRl1/GwNTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207631; c=relaxed/simple;
	bh=Stj18Qd+XArNtfv+ovPOZBZd6ZIg/WDzc0UuZ3vuZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVALc/3V17NX1XJZ5bjyFonB04YCwrGsqaw979PuKtuKNK5+0QJYbPBHJOTm9lh97cN3hw336j6neYCtA4qYNnnXGTpaWTCm66lWR3dlu2+mgI0VVIVmJIolWUoC3FF7LPOubpU4rZ+mfrcEZoR1pGYukuZSqahcEky+abnWeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: RtLKIBtWR2il/HUT5E69aQ==
X-CSE-MsgGUID: NTXLpINlS0WIBbJc4UXwXg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:28 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 577B2417CA94;
	Thu, 23 Oct 2025 17:20:22 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 04/10] thermal: renesas: rzg3e: make calibration value retrieval per-chip
Date: Thu, 23 Oct 2025 11:19:18 +0300
Message-ID: <20251023081925.2412325-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration data via SMC SIP calls.

Prepare for them by moving the syscon usage into a single function, and
placing it in the chip-specific struct.

Rename the functions to match their functionality, and remove single-use
variables from the private state.

Also, move the calibration value mask into a macro.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 62 +++++++++++++------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 3c9ff5e43d7e..d2525ad3ffcc 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -70,7 +70,12 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+#define TSU_TEMP_MASK		GENMASK(11, 0)
+
+struct rzg3e_thermal_priv;
+
 struct rzg3e_thermal_info {
+	int (*get_trim)(struct rzg3e_thermal_priv *priv);
 	int temp_d_mc;
 	int temp_e_mc;
 };
@@ -91,13 +96,11 @@ struct rzg3e_thermal_info {
 struct rzg3e_thermal_priv {
 	void __iomem *base;
 	struct device *dev;
-	struct regmap *syscon;
 	struct thermal_zone_device *zone;
 	struct reset_control *rstc;
 	const struct rzg3e_thermal_info *info;
 	u16 trmval0;
 	u16 trmval1;
-	u32 trim_offset;
 	struct mutex lock;
 };
 
@@ -334,22 +337,8 @@ static const struct thermal_zone_device_ops rzg3e_tz_ops = {
 	.set_trips = rzg3e_thermal_set_trips,
 };
 
-static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv)
+static int rzg3e_validate_calibration(struct rzg3e_thermal_priv *priv)
 {
-	u32 val;
-	int ret;
-
-	/* Read calibration values from syscon */
-	ret = regmap_read(priv->syscon, priv->trim_offset, &val);
-	if (ret)
-		return ret;
-	priv->trmval0 = val & GENMASK(11, 0);
-
-	ret = regmap_read(priv->syscon, priv->trim_offset + 4, &val);
-	if (ret)
-		return ret;
-	priv->trmval1 = val & GENMASK(11, 0);
-
 	/* Validate calibration data */
 	if (!priv->trmval0 || !priv->trmval1 ||
 	    priv->trmval0 == priv->trmval1 ||
@@ -365,17 +354,30 @@ static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv)
 	return 0;
 }
 
-static int rzg3e_thermal_parse_dt(struct rzg3e_thermal_priv *priv)
+static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
 {
 	struct device_node *np = priv->dev->of_node;
+	struct regmap *syscon;
 	u32 offset;
+	int ret;
+	u32 val;
 
-	priv->syscon = syscon_regmap_lookup_by_phandle_args(np, "renesas,tsu-trim", 1, &offset);
-	if (IS_ERR(priv->syscon))
-		return dev_err_probe(priv->dev, PTR_ERR(priv->syscon),
+	syscon = syscon_regmap_lookup_by_phandle_args(np, "renesas,tsu-trim", 1, &offset);
+	if (IS_ERR(syscon))
+		return dev_err_probe(priv->dev, PTR_ERR(syscon),
 				     "Failed to parse renesas,tsu-trim\n");
 
-	priv->trim_offset = offset;
+	/* Read calibration values from syscon */
+	ret = regmap_read(syscon, offset, &val);
+	if (ret)
+		return ret;
+	priv->trmval0 = val & TSU_TEMP_MASK;
+
+	ret = regmap_read(syscon, offset + 4, &val);
+	if (ret)
+		return ret;
+	priv->trmval1 = val & TSU_TEMP_MASK;
+
 	return 0;
 }
 
@@ -402,11 +404,16 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	/* Parse device tree for trim register info */
-	ret = rzg3e_thermal_parse_dt(priv);
+	ret = priv->info->get_trim(priv);
 	if (ret)
 		return ret;
 
+	/* Validate calibration data */
+	ret = rzg3e_validate_calibration(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get valid calibration data\n");
+
 	/* Get clock to verify frequency - clock is managed by power domain */
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
@@ -423,12 +430,6 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "Failed to get/deassert reset control\n");
 
-	/* Get calibration data */
-	ret = rzg3e_thermal_get_calibration(priv);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to get valid calibration data\n");
-
 	/* Get comparison interrupt */
 	irq = platform_get_irq_byname(pdev, "adcmpi");
 	if (irq < 0)
@@ -533,6 +534,7 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops = {
 };
 
 static const struct rzg3e_thermal_info rzg3e_thermal_info = {
+	.get_trim = rzg3e_thermal_get_syscon_trim,
 	.temp_d_mc = -41000,
 	.temp_e_mc = 126000,
 };
-- 
2.51.1.dirty


