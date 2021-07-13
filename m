Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89E13C6864
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGMCIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 22:08:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233098AbhGMCIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 22:08:54 -0400
X-UUID: fead5c4eda964668a9dd57438443c5f0-20210713
X-UUID: fead5c4eda964668a9dd57438443c5f0-20210713
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yt.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 539074025; Tue, 13 Jul 2021 10:06:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 10:06:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 10:06:00 +0800
From:   YT Lee <yt.lee@mediatek.com>
To:     <yt.lee@mediatek.com>, <roger.lu@mediatek.com>,
        <matthias.bgg@gmail.com>, <eballetbo@gmail.com>,
        <khilman@kernel.org>, <robh+dt@kernel.org>, <drinkcat@google.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>
CC:     <srv_heupstream@mediatek.com>, <fan.chen@mediatek.com>,
        <xiaoqing.liu@mediatek.com>, <charles.yang@mediatek.com>,
        <angus.lin@mediatek.com>, <mark.rutland@arm.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux@roeck-us.net>, <louis.yu@mediatek.com>
Subject: [PATCH 2/2] soc: mediatek: SVS: add mt8195 SVS GPU driver
Date:   Tue, 13 Jul 2021 10:05:52 +0800
Message-ID: <20210713020552.18667-3-yt.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210713020552.18667-1-yt.lee@mediatek.com>
References: <20210713020552.18667-1-yt.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To support SVS GPU on mt8195, add corresponding
bank information, platform data and parsing function.

Signed-off-by: YT Lee <yt.lee@mediatek.com>
---
This patch depends on "soc: mediatek: SVS: introduce MTK SVS"[1],
also refine svs_suspend, svs_resume functions according to [2].

[1]http://lists.infradead.org/pipermail/linux-mediatek/2021-July/026270.html
[2]http://lists.infradead.org/pipermail/linux-mediatek/2021-July/026282.html

 drivers/soc/mediatek/mtk-svs.c | 228 +++++++++++++++++++++++++++++++--
 1 file changed, 216 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 67f1ea23ea0a..2a07d79d24cb 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1440,6 +1440,88 @@ static int svs_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
+static bool svs_mt8195_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct nvmem_cell *cell;
+	u32 idx, i, ft_pgm, vmin, golden_temp;
+
+	for (i = 0; i < svsp->efuse_num; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	/* Svs efuse parsing */
+	ft_pgm = svsp->efuse[0] & GENMASK(7, 0);
+	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->sw_id != SVSB_GPU)
+			return false;
+
+		if (vmin == 0x1)
+			svsb->vmin = 0x1e;
+
+		if (ft_pgm == 0)
+			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
+
+		if (svsb->type == SVSB_LOW) {
+			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[8] >> 8) & GENMASK(7, 0);
+			svsb->vmax += svsb->dvt_fixed;
+		} else if (svsb->type == SVSB_HIGH) {
+			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[8]) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[8] >> 8) & GENMASK(7, 0);
+			svsb->vmax += svsb->dvt_fixed;
+		}
+	}
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
+		for (idx = 0; idx < svsp->bank_num; idx++) {
+			svsb = &svsp->banks[idx];
+			svsb->mode_support &= ~SVSB_MODE_MON;
+		}
+
+		return true;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_num);
+	svsp->tefuse_num /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	for (i = 0; i < svsp->tefuse_num; i++)
+		if (svsp->tefuse[i] != 0)
+			break;
+
+	if (i == svsp->tefuse_num)
+		golden_temp = 50; /* All thermal efuse data are 0 */
+	else
+		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->sw_id != SVSB_GPU)
+			return false;
+
+		svsb->mts = 500;
+		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
 static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb;
@@ -1771,12 +1853,10 @@ static int svs_suspend(struct device *dev)
 		}
 	}
 
-	if (svsp->rst) {
-		ret = reset_control_assert(svsp->rst);
-		if (ret) {
-			dev_err(svsp->dev, "cannot assert reset %d\n", ret);
-			return ret;
-		}
+	ret = reset_control_assert(svsp->rst);
+	if (ret) {
+		dev_err(svsp->dev, "cannot assert reset %d\n", ret);
+		return ret;
 	}
 
 	clk_disable_unprepare(svsp->main_clk);
@@ -1797,12 +1877,10 @@ static int svs_resume(struct device *dev)
 		return ret;
 	}
 
-	if (svsp->rst) {
-		ret = reset_control_deassert(svsp->rst);
-		if (ret) {
-			dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
-			return ret;
-		}
+	ret = reset_control_deassert(svsp->rst);
+	if (ret) {
+		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
+		return ret;
 	}
 
 	for (idx = 0; idx < svsp->bank_num; idx++) {
@@ -2081,6 +2159,89 @@ static int svs_create_svs_debug_cmds(struct svs_platform *svsp)
 	return 0;
 }
 
+static struct svs_bank svs_mt8195_banks[] = {
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freqs_pct		= svs_set_freqs_pct_v3,
+		.get_vops		= svs_get_vops_v3,
+		.hw_id			= 0,
+		.tzone_name		= "gpu1",
+		.buck_name		= "mali",
+		.volt_flags		= SVSB_INIT02_RM_DVTFIXED |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= 16,
+		.freq_base		= 640000000,
+		.turn_freq_base		= 640000000,
+		.vboot			= 0x38,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_offset		= 0,
+		.vmax			= 0x38,
+		.vmin			= 0x14,
+		.dthi			= 0x1,
+		.dtlo			= 0xfe,
+		.det_window		= 0xa28,
+		.det_max		= 0xffff,
+		.age_config		= 0x555555,
+		.agem			= 0,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x1,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.temp_upper_bound	= 0x64,
+		.temp_lower_bound	= 0xb2,
+		.tzone_high_temp	= 85000,
+		.tzone_high_temp_offset	= 0,
+		.tzone_low_temp		= 25000,
+		.tzone_low_temp_offset	= 7,
+		.core_sel		= 0x0fff0100,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00540003,
+		.type			= SVSB_LOW,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freqs_pct		= svs_set_freqs_pct_v3,
+		.get_vops		= svs_get_vops_v3,
+		.hw_id			= 1,
+		.tzone_name		= "gpu1",
+		.buck_name		= "mali",
+		.volt_flags		= SVSB_INIT02_RM_DVTFIXED |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= 16,
+		.freq_base		= 880000000,
+		.turn_freq_base		= 640000000,
+		.vboot			= 0x38,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_offset		= 0,
+		.vmax			= 0x38,
+		.vmin			= 0x14,
+		.dthi			= 0x1,
+		.dtlo			= 0xfe,
+		.det_window		= 0xa28,
+		.det_max		= 0xffff,
+		.age_config		= 0x555555,
+		.agem			= 0,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.temp_upper_bound	= 0x64,
+		.temp_lower_bound	= 0xb2,
+		.tzone_high_temp	= 85000,
+		.tzone_high_temp_offset	= 0,
+		.tzone_low_temp		= 25000,
+		.tzone_low_temp_offset	= 7,
+		.core_sel		= 0x0fff0101,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00540003,
+		.type			= SVSB_HIGH,
+	},
+};
+
 static struct svs_bank svs_mt8192_banks[] = {
 	{
 		.sw_id			= SVSB_GPU,
@@ -2318,6 +2479,46 @@ static struct svs_bank svs_mt8183_banks[] = {
 	},
 };
 
+static int svs_get_svs_mt8195_platform_data(struct svs_platform *svsp)
+{
+	struct device *dev;
+	struct svs_bank *svsb;
+	u32 idx;
+
+	svsp->name = "mt8195-svs";
+	svsp->banks = svs_mt8195_banks;
+	svsp->efuse_parsing = svs_mt8195_efuse_parsing;
+	svsp->regs = svs_regs_v2;
+	svsp->irqflags = IRQF_TRIGGER_HIGH;
+	svsp->bank_num = ARRAY_SIZE(svs_mt8195_banks);
+	svsp->efuse_check = 10;
+
+	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
+	if (IS_ERR(svsp->rst)) {
+		dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
+			      "cannot get svs reset control\n");
+		return PTR_ERR(svsp->rst);
+	}
+
+	dev = svs_add_device_link(svsp, "lvts");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->type == SVSB_HIGH)
+			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+		else if (svsb->type == SVSB_LOW)
+			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
+
+		if (IS_ERR(svsb->opp_dev))
+			return PTR_ERR(svsb->opp_dev);
+	}
+
+	return 0;
+}
+
 static int svs_get_svs_mt8192_platform_data(struct svs_platform *svsp)
 {
 	struct device *dev;
@@ -2414,6 +2615,9 @@ static const struct of_device_id mtk_svs_of_match[] = {
 	}, {
 		.compatible = "mediatek,mt8192-svs",
 		.data = &svs_get_svs_mt8192_platform_data,
+	}, {
+		.compatible = "mediatek,mt8195-svs",
+		.data = &svs_get_svs_mt8195_platform_data,
 	}, {
 		/* Sentinel */
 	},
-- 
2.18.0

