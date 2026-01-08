Return-Path: <linux-pm+bounces-40501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2153D05EA7
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B79E30230EF
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB732C932;
	Thu,  8 Jan 2026 19:53:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63832C92D;
	Thu,  8 Jan 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902026; cv=none; b=ixZVPLy2SZOWqSbEg2YAk+bm6w86jRVWFVlbu9qUXMqWiSa627RHvHWqFcxkZf7bIpobkGyHRcUbeibfMwYmD5Wo4i5rfbhpBG48yIQSkw/kII7+7/lkvgbcJvc2MfQP5bjRsbBEk29IYWpaaki9LzsemAKl9HPO4qYAigcaSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902026; c=relaxed/simple;
	bh=9KVmirLiYMYEIopFy26QTxH35LfuQsRgwCKPY9nroc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDNEefFs4lFv8GyKsOzozUce18o56NC2X0orwZfgp4KYWv/a/DH3Q5LZhw6T0zu3DcsoSYMF0tnMWksFNG1Vi6DQCT+BuwclotPJHJglc4gem5DDKGfPB414WlZE5zE+SPmYU9TdDIJeP3QuKJOEbgf25hpkxJSvTg6kBWCCIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: IzwKbpdnRlGeoZQ27+3h6g==
X-CSE-MsgGUID: ywJwhMhBQRC/DoPF+cKXLA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 04:53:41 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 43D07475F1F5;
	Fri,  9 Jan 2026 04:53:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v5 3/5] thermal: renesas: rzg3e: make calibration value retrieval per-chip
Date: Thu,  8 Jan 2026 21:52:21 +0200
Message-ID: <20260108195223.193531-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration data via SMC SIP calls.

To prepare for supporting these SoCs, do the following changes.

Rename rzg3e_thermal_parse_dt() to rzg3e_thermal_get_syscon_trim().

Move the syscon usage out of rzg3e_thermal_get_calibration() and into
rzg3e_thermal_get_syscon_trim() and remove single-use variables from the
private state.

Place a pointer to rzg3e_thermal_get_syscon_trim() into the
chip-specific struct, and use it in the probe function to retrieve the
calibration values.

Now that syscon usage has been moved out of
rzg3e_thermal_get_calibration(), remove it and inline the calibration
validation into the probe function.

Also, reuse the TSU_CODE_MAX macro to mask the calibration values, as
GEMASK(11, 0) and 0xFFF are equivalent, and replace the hardcoded 0xFFF
with TSU_CODE_MAX in the calibration validation.

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V5:
 * replace hardcoded 0xFFF values with TSU_CODE_MAX

V4:
 * pick up John's Reviewed-by and Tested-by
 * replace new macro TSU_TEMP_MASK usage with existing macro
   TSU_CODE_MAX
 * remove "Validate calibration data" comments
 * inline rzg3e_validate_calibration() into rzg3e_thermal_probe()

V3:
 * no changes

V2:
 * no changes

 drivers/thermal/renesas/rzg3e_thermal.c | 79 +++++++++++--------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 3c9ff5e43d7e..97c4053303e0 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -70,7 +70,10 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+struct rzg3e_thermal_priv;
+
 struct rzg3e_thermal_info {
+	int (*get_trim)(struct rzg3e_thermal_priv *priv);
 	int temp_d_mc;
 	int temp_e_mc;
 };
@@ -91,13 +94,11 @@ struct rzg3e_thermal_info {
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
 
@@ -334,48 +335,30 @@ static const struct thermal_zone_device_ops rzg3e_tz_ops = {
 	.set_trips = rzg3e_thermal_set_trips,
 };
 
-static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv)
-{
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
-	/* Validate calibration data */
-	if (!priv->trmval0 || !priv->trmval1 ||
-	    priv->trmval0 == priv->trmval1 ||
-	    priv->trmval0 == 0xFFF || priv->trmval1 == 0xFFF) {
-		dev_err(priv->dev, "Invalid calibration: b=0x%03x, c=0x%03x\n",
-			priv->trmval0, priv->trmval1);
-		return -EINVAL;
-	}
-
-	dev_dbg(priv->dev, "Calibration: b=0x%03x (%u), c=0x%03x (%u)\n",
-		priv->trmval0, priv->trmval0, priv->trmval1, priv->trmval1);
-
-	return 0;
-}
-
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
+	priv->trmval0 = val & TSU_CODE_MAX;
+
+	ret = regmap_read(syscon, offset + 4, &val);
+	if (ret)
+		return ret;
+	priv->trmval1 = val & TSU_CODE_MAX;
+
 	return 0;
 }
 
@@ -402,11 +385,20 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	/* Parse device tree for trim register info */
-	ret = rzg3e_thermal_parse_dt(priv);
+	ret = priv->info->get_trim(priv);
 	if (ret)
 		return ret;
 
+	if (!priv->trmval0 || !priv->trmval1 ||
+	    priv->trmval0 == priv->trmval1 ||
+	    priv->trmval0 == TSU_CODE_MAX || priv->trmval1 == TSU_CODE_MAX)
+		return dev_err_probe(priv->dev, -EINVAL,
+				     "Invalid calibration: b=0x%03x, c=0x%03x\n",
+				     priv->trmval0, priv->trmval1);
+
+	dev_dbg(priv->dev, "Calibration: b=0x%03x (%u), c=0x%03x (%u)\n",
+		priv->trmval0, priv->trmval0, priv->trmval1, priv->trmval1);
+
 	/* Get clock to verify frequency - clock is managed by power domain */
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
@@ -423,12 +415,6 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
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
@@ -533,6 +519,7 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops = {
 };
 
 static const struct rzg3e_thermal_info rzg3e_thermal_info = {
+	.get_trim = rzg3e_thermal_get_syscon_trim,
 	.temp_d_mc = -41000,
 	.temp_e_mc = 126000,
 };
-- 
2.52.0

