Return-Path: <linux-pm+bounces-36843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3075C0A72A
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C0E3AAC9C
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E9298CA6;
	Sun, 26 Oct 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="H5fyZmsx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7428BA83;
	Sun, 26 Oct 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481912; cv=none; b=HRpKYrQ579lsreNM6dmT++4GvQ131UMp2YuYGkgzPY8JLdRdEd5vAf4aWHE7GduR3PeYBybFTf1pdFljWx/ZbjL4w6vZ+QWbZ8sGjM3591itkDGu1NFQTF4dy+GARlcFgK47MD3UhnJw1J30Wsc32VN3mM9n7RDh9Bb9r2vzneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481912; c=relaxed/simple;
	bh=zwniZlxloGKkihQAQmGZNdKCwt+F5x7WAUh5EQNZHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx2cTMkTnuob35HrnN941DcAEJHKgqqEUVarxFS9iZsEe0iHeRj0kwMsTlAC8PobxtqFX3a5+FImDHH6XZKj0O4I6TQdbrNBzm4sMFKM6nJL8atkSjjWmNr5It8nnyauf6D+XG575ev047n8NQHEbykgAlt4gW8YxExG5xQT3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=H5fyZmsx; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 6A3535FE85;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBBB63EbQu+3f69j7eVhdhDTMGpiISE40F1PbWVxzkk=;
	b=H5fyZmsxeTaTkwjUhvyWEMIY+V43xldUQTi4lENvCw/BoYIq5r0akakLk6SFNtUyyHDcHX
	+4qHOsMVIT2u5ZSYMAHvF4Y/Iey116ekP0R/bSknUR7Y6ZVBALu/L8oE4nTfuQs4NnLyNz
	2Ep6/ysaC3vmoA01tUeTb6FsPiNGwy8=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 310831226BC;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/5] thermal/drivers/mediatek/lvts_thermal: Add no-irq-mode for mt7987
Date: Sun, 26 Oct 2025 13:21:32 +0100
Message-ID: <20251026122143.71100-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026122143.71100-1-linux@fw-web.de>
References: <20251026122143.71100-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Upcoming MT7987 does not have IRQ for thermal. Add a field in lvts_data
to configure this based on SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 51 ++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ab55b20cda47..9413b30f7b69 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -94,6 +94,8 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
+#define LVTS_HW_RESET_TEMP		125000
+
 #define LVTS_MINIMUM_THRESHOLD		20000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
@@ -134,6 +136,7 @@ struct lvts_data {
 	int temp_offset;
 	int gt_calib_bit_offset;
 	unsigned int def_calibration;
+	bool irq_enable;
 };
 
 struct lvts_sensor {
@@ -151,6 +154,7 @@ struct lvts_ctrl {
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u8 valid_sensor_mask;
+	u32 hw_reset_raw_temp;
 	int mode;
 	void __iomem *base;
 	int low_thresh;
@@ -410,6 +414,9 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	}
 	lvts_update_irq_mask(lvts_ctrl);
 
+	if (!lvts_data->irq_enable)
+		return 0;
+
 	if (!should_update_thresh)
 		return 0;
 
@@ -859,6 +866,14 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
 
+		/*
+		 * The temperature to raw temperature must be done
+		 * after initializing the calibration.
+		 */
+		lvts_ctrl[i].hw_reset_raw_temp =
+			lvts_temp_to_raw(LVTS_HW_RESET_TEMP,
+					 lvts_data->temp_factor);
+
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
@@ -915,12 +930,13 @@ static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, int
 	 */
 	for (i = 0; i < nr_cmds; i++) {
 		writel(cmds[i], LVTS_CONFIG(lvts_ctrl->base));
-		usleep_range(2, 4);
+		usleep_range(5, 15);
 	}
 }
 
 static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 {
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	/*
 	 * LVTS_PROTCTL : Thermal Protection Sensor Selection
 	 *
@@ -954,8 +970,12 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(0, LVTS_MONINT(lvts_ctrl->base));
-
+	if (lvts_data->irq_enable) {
+		writel(0, LVTS_MONINT(lvts_ctrl->base));
+	} else {
+		writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
+		writel(lvts_ctrl->hw_reset_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
+	}
 	return 0;
 }
 
@@ -1338,9 +1358,11 @@ static int lvts_probe(struct platform_device *pdev)
 	if (IS_ERR(lvts_td->reset))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (lvts_data->irq_enable) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+	}
 
 	golden_temp_offset = lvts_data->temp_offset;
 
@@ -1352,10 +1374,12 @@ static int lvts_probe(struct platform_device *pdev)
 	 * At this point the LVTS is initialized and enabled. We can
 	 * safely enable the interrupt.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), lvts_td);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+	if (lvts_data->irq_enable) {
+		ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
+						IRQF_ONESHOT, dev_name(dev), lvts_td);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+	}
 
 	platform_set_drvdata(pdev, lvts_td);
 
@@ -1763,6 +1787,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
+	.irq_enable = true, //SDK false
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1776,6 +1801,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1789,6 +1815,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1802,6 +1829,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1815,6 +1843,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1828,6 +1857,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1841,6 +1871,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.irq_enable = true,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
-- 
2.43.0


