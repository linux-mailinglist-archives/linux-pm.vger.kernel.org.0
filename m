Return-Path: <linux-pm+bounces-36270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92981BE3E54
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D5C585122
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0B342CB2;
	Thu, 16 Oct 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p1UV/kNl"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71272342C81;
	Thu, 16 Oct 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624575; cv=none; b=gOcNmTGZAFquro5eRegUsqoZRuTUoT+CDFRg/feDWLteCES2hk6DH38MY6VSRmZ7UpFLUHj2V1+bVb7VBsXABnTtfrw1iQRMtcBuTpp8qpfXX1ge6qIi5btnKkV/jrgD+XSMmr/Dz5lrx1+WEOjOwntcz8+1wrWITkiDBIaRxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624575; c=relaxed/simple;
	bh=1TbUCvU0S/qUgheQcklD7Uc/uQE1dwCSooV/9vGXvmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEN4L+I6yD3RfOIm4hAuwnPUEQ3Q1QckIsaMEYmEwz/TsU+/ldL2oShEPfMKSUeOVBm43RBkDZTx0/OlZZTM51doHxVGsgsDr2lcaxzioKpPJ6hgwiOR9JKCLJuj5tJuudSHb6tzGBfJ6C0YWwVUMvwFEzlDrR0bvtCSqAr7Ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p1UV/kNl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760624572;
	bh=1TbUCvU0S/qUgheQcklD7Uc/uQE1dwCSooV/9vGXvmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1UV/kNlwMXU7bFbLxCyU9PCouB5hp2rptKFK+KYpQcrZP3OgsSrPSfeFj89OFynH
	 ozn0a8GunaLahjbsSZs+VeCnHAuqRYSESQh8INh78ZXpKIr9MnSgVRN4mBQtgiNZxG
	 7LlfTZTjY74ZA9u0qxrWlEuyxCsJCPkgz0J8jdVjtEbFvYz45698oQmC8lgS4aF/3W
	 eshoAgQ4YnNQG3ZCzuCWz2jep29OHXMrVT70wl07PQ23R93o7zVP26vMIyjhG5gslp
	 34+sEupAU0YLgzBtv6W0IImAPXmHhJwEds7Ecf+/ZpkIGvLa0i1hq9IYP0LXqmnlli
	 IPfW1IKaNxhpw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:655a:5eaa:d2ad:4ee4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0CC517E14DD;
	Thu, 16 Oct 2025 16:22:50 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH RESEND v3 8/9] thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
Date: Thu, 16 Oct 2025 16:21:57 +0200
Message-Id: <20251016142158.740242-9-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
References: <20251016142158.740242-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LVTS driver support for MT8196.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 164 ++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8ca5760cbb76..33f68697d1e3 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -92,6 +92,10 @@
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
 #define LVTS_COEFF_B_MT7988			204650
+#define LVTS_COEFF_A_MT8196			391460
+#define LVTS_COEFF_B_MT8196			-391460
+
+#define LVTS_MSR_OFFSET_MT8196		-984
 
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
@@ -761,6 +765,39 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
  *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
+ * MT8196 :
+ * Stream index map for MCU Domain mt8196 :
+ *
+ * <-sensor#1--> <-sensor#0--> <-sensor#3--> <-sensor#2-->
+ *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <-sensor#5--> <-sensor#4--> <-sensor#7--> <-sensor#6-->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <-sensor#9--> <-sensor#8--> <-sensor#11-> <-sensor#10->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0X1B
+ *
+ * <-sensor#13-> <-sensor#12-> <-sensor#15-> <-sensor#14->
+ *  0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for APU Domain mt8196 :
+ *
+ * <-sensor#1--> <-sensor#0--> <-sensor#3--> <-sensor#2-->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * Stream index map for GPU Domain mt8196 :
+ *
+ * <-sensor#1--> <-sensor#0-->
+ *  0x2C | 0x2D | 0x2E | 0x2F
+ *
+ * Stream index map for AP Domain mt8196 :
+ *
+ * <-sensor#1--> <-sensor#0--> <-sensor#3--> <-sensor#2-->
+ *  0x30 | 0x31 | 0x32 | 0x33 | 0x34 | 0x35 | 0x36 | 0x37
+ *
+ * <-sensor#5--> <-sensor#4--> <-sensor#6--> <-sensor#7-->
+ *  0x38 | 0x39 | 0x3A | 0x3B | 0x3C | 0x3D | 0x3E | 0x3F
+ *
  * Note: In some cases, values don't strictly follow a little endian ordering.
  * The data description gives byte offsets constituting each calibration value
  * for each sensor.
@@ -1829,11 +1866,112 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8196_lvts_mcu_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU6_0,
+			  .cal_offsets = { 0x06, 0x07 } },
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU6_1,
+			  .cal_offsets = { 0x04, 0x05 } },
+			{ .dt_id = MT8196_MCU_DSU2,
+			  .cal_offsets = { 0x0A, 0x0B } },
+			{ .dt_id = MT8196_MCU_DSU3,
+			  .cal_offsets = { 0x08, 0x09 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x0,
+		.mode = LVTS_MSR_ATP_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_MCU_LITTLE_CPU3,
+			  .cal_offsets = { 0x0E, 0x0F } },
+			{ .dt_id = MT8196_MCU_LITTLE_CPU0,
+			  .cal_offsets = { 0x0C, 0x0D } },
+			{ .dt_id = MT8196_MCU_LITTLE_CPU1,
+			  .cal_offsets = { 0x12, 0x13 } },
+			{ .dt_id = MT8196_MCU_LITTLE_CPU2,
+			  .cal_offsets = { 0x10, 0x11 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x100,
+		.mode = LVTS_MSR_ATP_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU4_0,
+			  .cal_offsets = { 0x16, 0x17 } },
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU4_1,
+			  .cal_offsets = { 0x14, 0x15 } },
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU5_0,
+			  .cal_offsets = { 0x1A, 0x1B } },
+			{ .dt_id = MT8196_MCU_MEDIUM_CPU5_1,
+			  .cal_offsets = { 0x18, 0x19 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x200,
+		.mode = LVTS_MSR_ATP_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_MCU_DSU0,
+			  .cal_offsets = { 0x1E, 0x1F } },
+			{ .dt_id = MT8196_MCU_DSU1,
+			  .cal_offsets = { 0x1C, 0x1D } },
+			{ .dt_id = MT8196_MCU_BIG_CPU7_0,
+			  .cal_offsets = { 0x22, 0x23 } },
+			{ .dt_id = MT8196_MCU_BIG_CPU7_1,
+			  .cal_offsets = { 0x20, 0x21 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x300,
+		.mode = LVTS_MSR_ATP_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8196_lvts_ap_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_AP_TOP0,
+			  .cal_offsets = { 0x32, 0x33 } },
+			{ .dt_id = MT8196_AP_TOP1,
+			  .cal_offsets = { 0x30, 0x31 } },
+			{ .dt_id = MT8196_AP_TOP2,
+			  .cal_offsets = { 0x36, 0x37 } },
+			{ .dt_id = MT8196_AP_TOP3,
+			  .cal_offsets = { 0x34, 0x35 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x0,
+		.mode = LVTS_MSR_ATP_MODE,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8196_AP_BOT0,
+			  .cal_offsets = { 0x3A, 0x3B } },
+			{ .dt_id = MT8196_AP_BOT1,
+			  .cal_offsets = { 0x38, 0x39 } },
+			{ .dt_id = MT8196_AP_BOT2,
+			  .cal_offsets = { 0x3E, 0x3F } },
+			{ .dt_id = MT8196_AP_BOT3,
+			  .cal_offsets = { 0x3C, 0x3D } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x100,
+		.mode = LVTS_MSR_ATP_MODE,
+	}
+};
+
 static const struct lvts_platform_ops lvts_platform_ops_v1 = {
 	.lvts_raw_to_temp = lvts_raw_to_temp,
 	.lvts_temp_to_raw = lvts_temp_to_raw,
 };
 
+static const struct lvts_platform_ops lvts_platform_ops_v2 = {
+	.lvts_raw_to_temp = lvts_raw_to_temp,
+	.lvts_temp_to_raw = lvts_temp_to_raw_v2,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1953,6 +2091,30 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.ops = &lvts_platform_ops_v1,
 };
 
+static const struct lvts_data mt8196_lvts_mcu_data = {
+	.lvts_ctrl	= mt8196_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8196,
+	.temp_offset	= LVTS_COEFF_B_MT8196,
+	.gt_calib_bit_offset = 0,
+	.def_calibration = 14437,
+	.num_cal_offsets = 2,
+	.msr_offset = LVTS_MSR_OFFSET_MT8196,
+	.ops = &lvts_platform_ops_v2,
+};
+
+static const struct lvts_data mt8196_lvts_ap_data = {
+	.lvts_ctrl	= mt8196_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8196,
+	.temp_offset	= LVTS_COEFF_B_MT8196,
+	.gt_calib_bit_offset = 0,
+	.def_calibration = 14437,
+	.num_cal_offsets = 2,
+	.msr_offset = LVTS_MSR_OFFSET_MT8196,
+	.ops = &lvts_platform_ops_v2,
+};
+
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
@@ -1962,6 +2124,8 @@ static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8195-lvts-ap", .data = &mt8195_lvts_ap_data },
+	{ .compatible = "mediatek,mt8196-lvts-mcu", .data = &mt8196_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8196-lvts-ap", .data = &mt8196_lvts_ap_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lvts_of_match);
-- 
2.39.5


