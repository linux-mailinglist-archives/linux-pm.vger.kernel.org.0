Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB43E88E9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhHKDiw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 23:38:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53878 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233506AbhHKDiw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 23:38:52 -0400
X-UUID: 6f8b3e15670344d3be99955f0d1c25b2-20210811
X-UUID: 6f8b3e15670344d3be99955f0d1c25b2-20210811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yt.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 798261421; Wed, 11 Aug 2021 11:38:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 11:38:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 11:38:24 +0800
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
Subject: [PATCH v2 2/2] soc: mediatek: SVS: add mt8195 SVS GPU driver
Date:   Wed, 11 Aug 2021 11:37:49 +0800
Message-ID: <20210811033749.30490-3-yt.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210811033749.30490-1-yt.lee@mediatek.com>
References: <20210811033749.30490-1-yt.lee@mediatek.com>
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
 drivers/soc/mediatek/mtk-svs.c | 207 +++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 363f189e6054..732e8d7b4ab7 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1443,6 +1443,88 @@ static int svs_resource_setup(struct svs_platform *svsp)
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
@@ -2080,6 +2162,88 @@ static int svs_create_svs_debug_cmds(struct svs_platform *svsp)
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
+		.volt_flags		= SVSB_INIT02_RM_DVTFIXED,
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
@@ -2316,6 +2480,46 @@ static struct svs_bank svs_mt8183_banks[] = {
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
@@ -2412,6 +2616,9 @@ static const struct of_device_id mtk_svs_of_match[] = {
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

