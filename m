Return-Path: <linux-pm+bounces-38629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A4C85ECD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37AA24E33C2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648DB326D4A;
	Tue, 25 Nov 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JCWEVvDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066525CC6C;
	Tue, 25 Nov 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087471; cv=none; b=cAnBYvehg4l1sr8Y02uNNvL5s29Ce+xFdRdZCtweFP5AjmDVqMybtahLqDcIf/4hG3BbnUmGJPrcBLOGtWineHmQp3zDTjzarMhp9wVEUEHcaH4TxmARPFDeeRZ6BkMXMtOQJavgg89jbabljY8XLqHF5rbxIeOD8sSFBt2Ekg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087471; c=relaxed/simple;
	bh=cUDI3eSSoHntMYAGbqLy2cJen7HYe07X9GsFSH/qza4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtbxmWpWS6VXeVc4YYvORJuPV27bCXAe1lVFLXo07Vt/3QWB5RcKc7aVhfqExwCTlv2FXT7F4t+ULK58uzLoPISFodlrtjI/iQ6eoUjjUITxA8BbP53aU3iDXk7yD5SI88bY/ZbrccTdL/iOPe/DdCYiRSSuM8m0OUs3iNTf2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JCWEVvDr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087467;
	bh=cUDI3eSSoHntMYAGbqLy2cJen7HYe07X9GsFSH/qza4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCWEVvDrdE108TaMSJc3OFX7PkQLDfD2hkCZyN+YNTfnWvfT2UtVEOWygqjuM3W80
	 AVCCu3Cod/nYfjz+214i4MXdRbt1bjDOJADNrOO5xNR9UFA9G6RS4evdeOFRTgYaHE
	 QuETjgg8QpW/59NEedrmOWG/vYaMop7AzjPHrei637EVIo7HZgS8LGgVL/phhXFvII
	 TgHmxfGSP0x1sfU3cac7s8ghyqd6I01WFLyV7QOma1AQbChwU6g72vkk7Kh53Xiieo
	 WO4RqUTfA3keLWc9Et6ZECYl9yTEvQNECvoOqNbeF01YNF7vgtEVsmlcQA/dsPNXdz
	 bmNJ7AP78aGRQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 348BA17E12D2;
	Tue, 25 Nov 2025 17:17:46 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 7/8] thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
Date: Tue, 25 Nov 2025 17:16:57 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-7-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add LVTS driver support for MT8196.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 165 ++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 93eb62cae512..cb68494f086c 100644
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
@@ -100,6 +104,7 @@
 
 #define LVTS_MAX_CAL_OFFSETS		3
 #define LVTS_NUM_CAL_OFFSETS_MT7988	3
+#define LVTS_NUM_CAL_OFFSETS_MT8196	2
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
@@ -784,6 +789,39 @@ static int lvts_decode_sensor_calibration(const struct lvts_sensor_data *sensor,
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
@@ -1849,11 +1887,112 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
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
 static const struct lvts_platform_ops lvts_platform_ops_mt7988 = {
 	.lvts_raw_to_temp = lvts_raw_to_temp_mt7988,
 	.lvts_temp_to_raw = lvts_temp_to_raw_mt7988,
 };
 
+static const struct lvts_platform_ops lvts_platform_ops_mt8196 = {
+	.lvts_raw_to_temp = lvts_raw_to_temp_mt7988,
+	.lvts_temp_to_raw = lvts_temp_to_raw_mt8196,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1973,6 +2112,30 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.ops = &lvts_platform_ops_mt7988,
 };
 
+static const struct lvts_data mt8196_lvts_mcu_data = {
+	.lvts_ctrl	= mt8196_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8196,
+	.temp_offset	= LVTS_COEFF_B_MT8196,
+	.gt_calib_bit_offset = 0,
+	.def_calibration = 14437,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
+	.msr_offset = LVTS_MSR_OFFSET_MT8196,
+	.ops = &lvts_platform_ops_mt8196,
+};
+
+static const struct lvts_data mt8196_lvts_ap_data = {
+	.lvts_ctrl	= mt8196_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8196_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8196,
+	.temp_offset	= LVTS_COEFF_B_MT8196,
+	.gt_calib_bit_offset = 0,
+	.def_calibration = 14437,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
+	.msr_offset = LVTS_MSR_OFFSET_MT8196,
+	.ops = &lvts_platform_ops_mt8196,
+};
+
 static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
@@ -1982,6 +2145,8 @@ static const struct of_device_id lvts_of_match[] = {
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

