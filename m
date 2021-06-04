Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198C339B710
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFDKcF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:32:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229690AbhFDKcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:32:04 -0400
X-UUID: 8a762e4347dc48cb80fa2fbf28771d9c-20210604
X-UUID: 8a762e4347dc48cb80fa2fbf28771d9c-20210604
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 800001124; Fri, 04 Jun 2021 18:30:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:30:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:30:12 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V10 04/12] soc: mediatek: add support for mt6873
Date:   Fri, 4 Jun 2021 18:29:51 +0800
Message-ID: <20210604102959.13807-5-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210604102959.13807-1-dawei.chien@mediatek.com>
References: <20210604102959.13807-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

add support for mt6873

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-dvfsrc.c | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
index 6ef167cf55bd..1f053367eabe 100644
--- a/drivers/soc/mediatek/mtk-dvfsrc.c
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -102,6 +102,16 @@ static const int mt8183_regs[] = {
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
@@ -377,6 +459,35 @@ static const struct dvfsrc_soc_data mt8183_data = {
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
@@ -391,6 +502,9 @@ static const struct of_device_id mtk_dvfsrc_of_match[] = {
 	{
 		.compatible = "mediatek,mt8183-dvfsrc",
 		.data = &mt8183_data,
+	}, {
+		.compatible = "mediatek,mt6873-dvfsrc",
+		.data = &mt6873_data,
 	}, {
 		/* sentinel */
 	},
-- 
2.14.1

