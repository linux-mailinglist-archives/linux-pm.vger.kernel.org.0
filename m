Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149322EEE1B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbhAHHtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 02:49:45 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45669 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727790AbhAHHtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 02:49:39 -0500
X-UUID: bd77d16cd34f4150b1feb08ceb458a8d-20210108
X-UUID: bd77d16cd34f4150b1feb08ceb458a8d-20210108
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1875947030; Fri, 08 Jan 2021 15:48:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 15:48:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 15:48:19 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V7 04/13] soc: mediatek: add support for mt6873
Date:   Fri, 8 Jan 2021 15:48:06 +0800
Message-ID: <1610092095-5113-5-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D5EFBD8A8DC1F84F5494280AFBA05935AE9872D6DABAC11923ADA940AB9E0EE82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add support for mt6873

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index c0c6d91..a422680 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -102,6 +102,16 @@ enum dvfsrc_regs {
 	[DVFSRC_SW_BW] =	0x160,
 };
 
+static const int mt6873_regs[] = {
+	[DVFSRC_SW_REQ] =		0xC,
+	[DVFSRC_LEVEL] =		0xD44,
+	[DVFSRC_SW_PEAK_BW] =		0x278,
+	[DVFSRC_SW_BW] =		0x26C,
+	[DVFSRC_SW_HRT_BW] =		0x290,
+	[DVFSRC_TARGET_LEVEL] =		0xD48,
+	[DVFSRC_VCORE_REQUEST] =	0x6C,
+};
+
 static const struct dvfsrc_opp *get_current_opp(struct mtk_dvfsrc *dvfsrc)
 {
 	int level;
@@ -127,6 +137,78 @@ static int dvfsrc_wait_for_vcore_level(struct mtk_dvfsrc *dvfsrc, u32 level)
 					 POLL_TIMEOUT);
 }
 
+static int mt6873_get_target_level(struct mtk_dvfsrc *dvfsrc)
+{
+	return dvfsrc_read(dvfsrc, DVFSRC_TARGET_LEVEL);
+}
+
+static int mt6873_get_current_level(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 curr_level;
+
+	/* HW level 0 is begin from 0x1, and max opp is 0x1*/
+	curr_level = ffs(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
+	if (curr_level > dvfsrc->curr_opps->num_opp)
+		curr_level = 0;
+	else
+		curr_level = dvfsrc->curr_opps->num_opp - curr_level;
+
+	return curr_level;
+}
+
+static int mt6873_wait_for_opp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	const struct dvfsrc_opp *target, *curr;
+
+	target = &dvfsrc->curr_opps->opps[level];
+	return readx_poll_timeout_atomic(get_current_opp, dvfsrc, curr,
+		curr->dram_opp >= target->dram_opp,
+		STARTUP_TIME, POLL_TIMEOUT);
+}
+
+static u32 mt6873_get_vcore_level(struct mtk_dvfsrc *dvfsrc)
+{
+	return (dvfsrc_read(dvfsrc, DVFSRC_SW_REQ) >> 4) & 0x7;
+}
+
+static u32 mt6873_get_vcp_level(struct mtk_dvfsrc *dvfsrc)
+{
+	return (dvfsrc_read(dvfsrc, DVFSRC_VCORE_REQUEST) >> 12) & 0x7;
+}
+
+static void mt6873_set_dram_bw(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	bw = div_u64(kbps_to_mbps(bw), 100);
+	bw = min_t(u64, bw, 0xFF);
+	dvfsrc_write(dvfsrc, DVFSRC_SW_BW, bw);
+}
+
+static void mt6873_set_dram_peak_bw(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	bw = div_u64(kbps_to_mbps(bw), 100);
+	bw = min_t(u64, bw, 0xFF);
+	dvfsrc_write(dvfsrc, DVFSRC_SW_PEAK_BW, bw);
+}
+
+static void mt6873_set_dram_hrtbw(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	bw = div_u64((kbps_to_mbps(bw) + 29), 30);
+	bw = min_t(u64, bw, 0x3FF);
+	dvfsrc_write(dvfsrc, DVFSRC_SW_HRT_BW, bw);
+}
+
+static void mt6873_set_vcore_level(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	spin_lock(&dvfsrc->req_lock);
+	dvfsrc_rmw(dvfsrc, DVFSRC_SW_REQ, level, 0x7, 4);
+	spin_unlock(&dvfsrc->req_lock);
+}
+
+static void mt6873_set_vscp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	dvfsrc_rmw(dvfsrc, DVFSRC_VCORE_REQUEST, level, 0x7, 12);
+}
+
 static int mt8183_wait_for_opp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
 {
 	const struct dvfsrc_opp *target, *curr;
@@ -377,6 +459,35 @@ static int mtk_dvfsrc_probe(struct platform_device *pdev)
 	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level,
 };
 
+static const struct dvfsrc_opp dvfsrc_opp_mt6873_lp4[] = {
+	{0, 0}, {1, 0}, {2, 0}, {3, 0},
+	{0, 1}, {1, 1}, {2, 1}, {3, 1},
+	{0, 2}, {1, 2}, {2, 2}, {3, 2},
+	{1, 3}, {2, 3}, {3, 3}, {1, 4},
+	{2, 4}, {3, 4}, {2, 5}, {3, 5},
+	{3, 6},
+};
+
+static const struct dvfsrc_opp_desc dvfsrc_opp_mt6873_desc[] = {
+	DVFSRC_OPP_DESC(dvfsrc_opp_mt6873_lp4),
+};
+
+static const struct dvfsrc_soc_data mt6873_data = {
+	.opps_desc = dvfsrc_opp_mt6873_desc,
+	.regs = mt6873_regs,
+	.get_target_level = mt6873_get_target_level,
+	.get_current_level = mt6873_get_current_level,
+	.get_vcore_level = mt6873_get_vcore_level,
+	.get_vcp_level = mt6873_get_vcp_level,
+	.set_dram_bw = mt6873_set_dram_bw,
+	.set_dram_peak_bw = mt6873_set_dram_peak_bw,
+	.set_dram_hrtbw = mt6873_set_dram_hrtbw,
+	.set_vcore_level = mt6873_set_vcore_level,
+	.set_vscp_level = mt6873_set_vscp_level,
+	.wait_for_opp_level = mt6873_wait_for_opp_level,
+	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level,
+};
+
 static int mtk_dvfsrc_remove(struct platform_device *pdev)
 {
 	struct mtk_dvfsrc *dvfsrc = platform_get_drvdata(pdev);
@@ -392,6 +503,9 @@ static int mtk_dvfsrc_remove(struct platform_device *pdev)
 		.compatible = "mediatek,mt8183-dvfsrc",
 		.data = &mt8183_data,
 	}, {
+		.compatible = "mediatek,mt6873-dvfsrc",
+		.data = &mt6873_data,
+	}, {
 		/* sentinel */
 	},
 };
-- 
1.9.1

