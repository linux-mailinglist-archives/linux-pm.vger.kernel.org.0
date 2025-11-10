Return-Path: <linux-pm+bounces-37707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6AC45C40
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5F1890A38
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1330214B;
	Mon, 10 Nov 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jWPmc88r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B342FF16C;
	Mon, 10 Nov 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768603; cv=none; b=CYp04byjxIHORtuLxRapMO5JJM/pfhrrO6xVI+bf6IVIXxXbSM0Yjp7iyVbm7+lWT2Xw1NQkKJkDz+rwDA1b0EEqaaVImjMfJ8dHImOH7TYjSQkDN9DTTGkOpX/g2dnm99EMN0PMkV4BdClnzHB5rxor62S5gSD/hC8RXYXYiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768603; c=relaxed/simple;
	bh=NetGNVTtSXdCtVDqG2li3RD91v4UAdx5sqJ7R+nB05Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVn55y7gN1x0gjzzlfFlDZl3k7c63+go/suSds0nk/+lnbTzfhv2BSRRIuQqGFxtkNlRMpUEtIRI0yOEiNQfpl6yULRIMswW7bJ+fKbGaH/UsE+zjZv/2PT9BIzwN9BcwQT5xwEwjmBA0lZ1m0tPS+zXk96I2J+hVzgOybih1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jWPmc88r; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6daafed8be1911f08ac0a938fc7cd336-20251110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QTZzDelfQTA4uZrVZJdbpfidqUQQQNkgj+JIycA97gE=;
	b=jWPmc88rj4fMeO9OKP+kKNGKIO+Q1xHznS+YZGZMTI/FpQ71eqtaBT8ke4Al+vghz2Q0q9O3hDX2KTbm7As/T4wT4WjVGJOFXvp588qLGhL+RY6zcR+Vc6ebeT1g9w1FNCAgfplHSksemILEoYLtsKvH6AZdlO92nZRe0CtKw0g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7e918598-7a88-4f6f-8081-d5008d7d441b,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:6d96ba57-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6daafed8be1911f08ac0a938fc7cd336-20251110
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 408716870; Mon, 10 Nov 2025 17:41:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 10 Nov 2025 17:41:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 10 Nov 2025 17:41:24 +0800
From: Hanchien Lin <hanchien.lin@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam
 CHIHI <bchihi@baylibre.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <hanchien.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<raymond.sun@mediatek.com>, <Irving-CH.lin@mediatek.com>
Subject: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Add MT8189 support
Date: Mon, 10 Nov 2025 17:40:39 +0800
Message-ID: <20251110094113.3965182-3-hanchien.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
References: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for the MediaTek MT8189 SoC to the LVTS thermal driver.

Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 155 ++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ab55b20cda47..8c15fdaac48c 100644
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
+								const struct lvts_data *lvts_data)
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
@@ -1322,9 +1341,15 @@ static int lvts_probe(struct platform_device *pdev)
 	if (!lvts_data)
 		return -ENODEV;
 
-	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(lvts_td->clk))
-		return dev_err_probe(dev, PTR_ERR(lvts_td->clk), "Failed to retrieve clock\n");
+	if (!lvts_data->clock_gate_no_need) {
+		lvts_td->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(lvts_td->clk))
+			return dev_err_probe(
+				dev,
+				PTR_ERR(lvts_td->clk),
+				"Failed to retrieve clock\n"
+			);
+	}
 
 	res = platform_get_mem_or_io(pdev, 0);
 	if (!res)
@@ -1334,9 +1359,15 @@ static int lvts_probe(struct platform_device *pdev)
 	if (IS_ERR(lvts_td->base))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
 
-	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
-	if (IS_ERR(lvts_td->reset))
-		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
+	if (!lvts_data->reset_no_need) {
+		lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
+		if (IS_ERR(lvts_td->reset))
+			return dev_err_probe(
+				dev,
+				PTR_ERR(lvts_td->reset),
+				"Failed to get reset control\n"
+			);
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -1586,6 +1617,78 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
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
@@ -1804,6 +1907,34 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.def_calibration = 35000,
 };
 
+static const struct lvts_data mt8189_lvts_ap_data = {
+	.lvts_ctrl		= mt8189_lvts_ap_data_ctrl,
+	.conn_cmd	= default_conn_cmds,
+	.init_cmd	= default_init_cmds,
+	.num_lvts_ctrl		= ARRAY_SIZE(mt8189_lvts_ap_data_ctrl),
+	.num_conn_cmd	= ARRAY_SIZE(default_conn_cmds),
+	.num_init_cmd	= ARRAY_SIZE(default_init_cmds),
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
@@ -1861,6 +1992,8 @@ static const struct of_device_id lvts_of_match[] = {
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


