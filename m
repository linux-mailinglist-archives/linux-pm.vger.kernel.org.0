Return-Path: <linux-pm+bounces-38959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E3C96905
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58C884E101F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F02302160;
	Mon,  1 Dec 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tdJdCIMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8843019B7;
	Mon,  1 Dec 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583615; cv=none; b=shBHt29xyusDYLntdqYl7UOhBqjZtlbuxhiyoWhVGB6m2sjTh9fJkl/84V6Q+/7p69m1JDVzwys4/5Y6uGRqgHqt718nsoJzGCibRm8exteRV7czc8oI8HDccRkE0Bjo3kV2UhFhS1tbVNs++hVFiRSyON3yKb7vfR/AjUr0rQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583615; c=relaxed/simple;
	bh=8vNaKVLIN0v1y2Ur3Slgtg4IdZHKBIA32PckBEJAwy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpZnuTtGxSsiLLkEAimx5pnJpGH9j7Qshf9FZDziAtT18PutgWbSScPvyCpTrZmB14kjGuizv753ioIAt61kNR61dcqR76N8IduZHrun6+dkXOPoQl7f1WvXxyLiA7QmHh9px3g+xOxOI21Er0Z2uZ+9iHuKTAxB3TkDiKOurTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tdJdCIMY; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 70fad7e0ce9d11f0b33aeb1e7f16c2b6-20251201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=B8j8aUs8ppeXcdKHZ4eX6gnU9Jno7ZbOrIec63SATAo=;
	b=tdJdCIMYgJdvKaS5uaqgF/BTLmdnsw8gL8VPbmtZ2o34YoGcGOrdgsWXaldmpEoxjAVB+ONVrFEL3LRfKK/pMa28Xyqm5DOPVWXXFPnQ4+8nlYOFQPd/RKs/oTxD+HpUjppZS7pgx1Vph8i5MvFdkXQUu/w9op4WxBpvzkd8BxM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:50f53aab-0f4e-4dfd-954c-796e676a6970,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-45
X-CID-META: VersionHash:a9d874c,CLOUDID:437e0528-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70fad7e0ce9d11f0b33aeb1e7f16c2b6-20251201
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 511114541; Mon, 01 Dec 2025 18:06:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 1 Dec 2025 18:06:43 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 1 Dec 2025 18:06:43 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Balsam
 CHIHI" <bchihi@baylibre.com>
CC: <Hanchien.lin@mediatek.com>, <Irving-CH.lin@mediatek.com>, Jh Hsu
	<Jh.Hsu@mediatek.com>, WH Wu <vincent.wu@mediatek.com>, Raymond Sun
	<Raymond.Sun@mediatek.com>, Sirius Wang <Sirius.Wang@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <hanchien.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 2/2] thermal/drivers/mediatek/lvts_thermal: Add MT8189 support
Date: Mon, 1 Dec 2025 18:06:20 +0800
Message-ID: <20251201100620.1557608-3-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251201100620.1557608-1-hanchien.lin@mediatek.com>
References: <20251201100620.1557608-1-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Changes in v2:
- Change reset functions from devm_reset_control_get_by_index to devm_reset_control_get_exclusive from reviewers comment.
- Change some use of line breaks and commas for coding style from other mediatek drivers.

Add support for the MediaTek MT8189 SoC to the LVTS thermal driver.

Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 151 ++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ab55b20cda47..c1eee0c2167f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,6 +65,7 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
+#define LVTS_MONINT_CONF_STAGE3		BIT(31)
 
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
 #define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
@@ -107,6 +108,7 @@ struct lvts_sensor_data {
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	u8 valid_sensor_mask;
+	int hw_tshut_temp;
 	int offset;
 	int mode;
 };
@@ -134,6 +136,9 @@ struct lvts_data {
 	int temp_offset;
 	int gt_calib_bit_offset;
 	unsigned int def_calibration;
+	bool clock_gate_no_need;
+	bool reset_no_need;
+	bool conf_stage3_need;
 };
 
 struct lvts_sensor {
@@ -150,6 +155,7 @@ struct lvts_ctrl {
 	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
+	u32 hw_tshut_raw_temp;
 	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
@@ -859,6 +865,14 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
 
+		/*
+		 * The temperature to raw temperature must be done
+		 * after initializing the calibration.
+		 */
+		lvts_ctrl[i].hw_tshut_raw_temp =
+			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp,
+					 lvts_data->temp_factor);
+
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
@@ -919,7 +933,7 @@ static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, int
 	}
 }
 
-static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
+static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl, const struct lvts_data *lvts_data)
 {
 	/*
 	 * LVTS_PROTCTL : Thermal Protection Sensor Selection
@@ -947,6 +961,7 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
 	 * writel(0x0, LVTS_PROTTC(lvts_ctrl->base));
 	 */
+	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
 
 	/*
 	 * LVTS_MONINT : Interrupt configuration register
@@ -954,7 +969,10 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
 	 * register, except we set the bits to enable the interrupt.
 	 */
-	writel(0, LVTS_MONINT(lvts_ctrl->base));
+	if (lvts_data->conf_stage3_need)
+		writel(LVTS_MONINT_CONF_STAGE3, LVTS_MONINT(lvts_ctrl->base));
+	else
+		writel(0, LVTS_MONINT(lvts_ctrl->base));
 
 	return 0;
 }
@@ -1041,7 +1059,8 @@ static int lvts_ctrl_calibrate(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	return 0;
 }
 
-static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl,
+			       const struct lvts_data *lvts_data)
 {
 	u32 value;
 
@@ -1143,7 +1162,7 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	value = LVTS_FILTER_INTERVAL << 16 | LVTS_SENSOR_INTERVAL;
 	writel(value, LVTS_MONCTL2(lvts_ctrl->base));
 
-	return lvts_irq_init(lvts_ctrl);
+	return lvts_irq_init(lvts_ctrl, lvts_data);
 }
 
 static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
@@ -1290,7 +1309,7 @@ static int lvts_domain_init(struct device *dev, struct lvts_domain *lvts_td,
 			return ret;
 		}
 
-		ret = lvts_ctrl_configure(dev, lvts_ctrl);
+		ret = lvts_ctrl_configure(dev, lvts_ctrl, lvts_data);
 		if (ret) {
 			dev_dbg(dev, "Failed to configure controller");
 			return ret;
@@ -1322,9 +1341,13 @@ static int lvts_probe(struct platform_device *pdev)
 	if (!lvts_data)
 		return -ENODEV;
 
-	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(lvts_td->clk))
-		return dev_err_probe(dev, PTR_ERR(lvts_td->clk), "Failed to retrieve clock\n");
+	if (!lvts_data->clock_gate_no_need) {
+		lvts_td->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(lvts_td->clk))
+			return dev_err_probe(dev,
+					     PTR_ERR(lvts_td->clk),
+					     "Failed to retrieve clock\n");
+	}
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -1334,9 +1357,13 @@ static int lvts_probe(struct platform_device *pdev)
 	if (IS_ERR(lvts_td->base))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
 
-	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
-	if (IS_ERR(lvts_td->reset))
-		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
+	if (!lvts_data->reset_no_need) {
+		lvts_td->reset = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(lvts_td->reset))
+			return dev_err_probe(dev,
+					     PTR_ERR(lvts_td->reset),
+					     "Failed to get reset control\n");
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1586,6 +1613,78 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_ctrl_data mt8189_lvts_mcu_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8189_MCU_LITTLE_CPU1,
+			  .cal_offsets = { 4, 5, 6 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU2,
+			  .cal_offsets = { 8, 9, 10 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU3,
+			  .cal_offsets = { 12, 13, 14 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU4,
+			  .cal_offsets = { 16, 17, 18 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x0,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8189_MCU_LITTLE_CPU5,
+			  .cal_offsets = { 24, 25, 26 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU6,
+			  .cal_offsets = { 28, 29, 30 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU7,
+			  .cal_offsets = { 32, 33, 34 } },
+			{ .dt_id = MT8189_MCU_LITTLE_CPU8,
+			  .cal_offsets = { 36, 37, 38 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x100,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8189_MCU_BIG_CPU1,
+			  .cal_offsets = { 44, 45, 46 } },
+			{ .dt_id = MT8189_MCU_BIG_CPU2,
+			  .cal_offsets = { 48, 49, 50 } },
+			{ .dt_id = MT8189_MCU_BIG_CPU3,
+			  .cal_offsets = { 52, 53, 54 } },
+			{ .dt_id = MT8189_MCU_BIG_CPU4,
+			  .cal_offsets = { 56, 57, 58 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x200,
+	}
+};
+
+static const struct lvts_ctrl_data mt8189_lvts_ap_data_ctrl[] = {
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8189_AP_SOC1,
+			  .cal_offsets = { 64, 65, 66 } },
+			{ .dt_id = MT8189_AP_SOC2,
+			  .cal_offsets = { 68, 69, 70 } },
+			{ .dt_id = MT8189_AP_SOC3,
+			  .cal_offsets = { 72, 73, 74 } },
+			{ .dt_id = MT8189_AP_APU,
+			  .cal_offsets = { 76, 77, 78 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset = 0x0,
+	},
+	{
+		.lvts_sensor = {
+			{ .dt_id = MT8189_AP_GPU1,
+			  .cal_offsets = { 84, 85, 86 } },
+			{ .dt_id = MT8189_AP_GPU2,
+			  .cal_offsets = { 88, 89, 90 } }
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset = 0x100,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
 	{
 		.lvts_sensor = {
@@ -1804,6 +1903,34 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.def_calibration = 35000,
 };
 
+static const struct lvts_data mt8189_lvts_ap_data = {
+	.lvts_ctrl		= mt8189_lvts_ap_data_ctrl,
+	.conn_cmd		= default_conn_cmds,
+	.init_cmd		= default_init_cmds,
+	.num_lvts_ctrl		= ARRAY_SIZE(mt8189_lvts_ap_data_ctrl),
+	.num_conn_cmd		= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd		= ARRAY_SIZE(default_init_cmds),
+	.temp_factor		= LVTS_COEFF_A_MT8195,
+	.temp_offset		= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset	= 0,
+	.def_calibration	= 35000,
+	.clock_gate_no_need	= true,
+	.reset_no_need		= true,
+	.conf_stage3_need	= true,
+};
+
+static const struct lvts_data mt8189_lvts_mcu_data = {
+	.lvts_ctrl		= mt8189_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl		= ARRAY_SIZE(mt8189_lvts_mcu_data_ctrl),
+	.temp_factor		= LVTS_COEFF_A_MT8195,
+	.temp_offset		= LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset	= 0,
+	.def_calibration	= 35000,
+	.clock_gate_no_need	= true,
+	.reset_no_need		= true,
+	.conf_stage3_need	= true,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.conn_cmd	= default_conn_cmds,
@@ -1861,6 +1988,8 @@ static const struct of_device_id lvts_of_match[] = {
 	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
 	{ .compatible = "mediatek,mt8188-lvts-mcu", .data = &mt8188_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8188-lvts-ap", .data = &mt8188_lvts_ap_data },
+	{ .compatible = "mediatek,mt8189-lvts-mcu", .data = &mt8189_lvts_mcu_data },
+	{ .compatible = "mediatek,mt8189-lvts-ap", .data = &mt8189_lvts_ap_data },
 	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
 	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
 	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
-- 
2.45.2


