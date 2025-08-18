Return-Path: <linux-pm+bounces-32539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85CB2A0EC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5EC5E4380
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC3320CB2;
	Mon, 18 Aug 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bBiDVQ3R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8131B12A;
	Mon, 18 Aug 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518291; cv=none; b=o3X0PEmoYjHAYa2oauupXQxiicj1jJSAaEkW0BONa1HYm/lTCOgJGuXZ/2cZgPH7NBw/w6MO3fO1isp83vwwKhD7NlVU0SEbt2d3CTkM/pQH6W7zZAvec1J06G7w8XEoGkSHVZoca7XZ48wRZhZ9TPQiGQckQ17XtHaEdLQdKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518291; c=relaxed/simple;
	bh=BQHkwGOt1Af9kGIjwN4KRUw3rSo0EMWsdJrfp0G5Hjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fg8Qi3Env5XN4hOg16r77s4TE7E/unxjz4zTbjv8NIv1GeM4Ia9O3vWgfJPvjTk605mfWTHCAT1TmWmbSrcDJP1MjmDFonCJoagq9M8NY2u7mnCt1THePC2aVyhUvsXU+W+ZWYjUBcwxLyIZXUTvzNx3fm2RCQKfJufEzzTTwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bBiDVQ3R; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96e2e6487c2a11f08729452bf625a8b4-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ArYvi9uBrCswcyMt4DiOZX7ndEIQA+ir/XHfjlEmFOI=;
	b=bBiDVQ3RJGxJAEpoopewdK7C/ul4SilunauAF10sKHftplZHZr2qfl8Gz4dMkKtnQYFpnRJuEogwdYf9tVddr8QKTigWIRL+U1lqCW7HYccBkbjStxaqQun/cmWYjHdbx9/NEjOTOPeeLmQiX9zCwH6jJbdF0lAJdhXJTf3hQU8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:34b95f27-dfb8-43ce-8aa8-918005e07b5e,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:f1326cf,CLOUDID:db0c417a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96e2e6487c2a11f08729452bf625a8b4-20250818
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1484948761; Mon, 18 Aug 2025 19:58:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 19:58:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 19:57:59 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Cochran <richardcochran@gmail.com>
CC: Qiqi Wang <qiqi.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <irving-ch.lin@mediatek.com>
Subject: [PATCH 6/6] pmdomain: mediatek: Add power domain driver for MT8189 SoC
Date: Mon, 18 Aug 2025 19:57:34 +0800
Message-ID: <20250818115754.1067154-7-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
References: <20250818115754.1067154-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
This driver ports and refines the power domain framework, dividing
hardware blocks (CPU, GPU, peripherals, etc.) into independent power
domains for precise and energy-efficient power management.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
---
 drivers/pmdomain/mediatek/mt8189-scpsys.h |  75 ++
 drivers/pmdomain/mediatek/mtk-scpsys.c    | 957 +++++++++++++++++++++-
 2 files changed, 990 insertions(+), 42 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8189-scpsys.h

diff --git a/drivers/pmdomain/mediatek/mt8189-scpsys.h b/drivers/pmdomain/mediatek/mt8189-scpsys.h
new file mode 100644
index 000000000000..80e17fe3f705
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt8189-scpsys.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+#ifndef __PMDOMAIN_MEDIATEK_MT8189_SCPSYS_H
+#define __PMDOMAIN_MEDIATEK_MT8189_SCPSYS_H
+
+#define MT8189_SPM_CONN_PWR_CON			0xe04
+#define MT8189_SPM_AUDIO_PWR_CON		0xe18
+#define MT8189_SPM_ADSP_TOP_PWR_CON		0xe1c
+#define MT8189_SPM_ADSP_INFRA_PWR_CON		0xe20
+#define MT8189_SPM_ADSP_AO_PWR_CON		0xe24
+#define MT8189_SPM_ISP_IMG1_PWR_CON		0xe28
+#define MT8189_SPM_ISP_IMG2_PWR_CON		0xe2c
+#define MT8189_SPM_ISP_IPE_PWR_CON		0xe30
+#define MT8189_SPM_VDE0_PWR_CON			0xe38
+#define MT8189_SPM_VEN0_PWR_CON			0xe40
+#define MT8189_SPM_CAM_MAIN_PWR_CON		0xe48
+#define MT8189_SPM_CAM_SUBA_PWR_CON		0xe50
+#define MT8189_SPM_CAM_SUBB_PWR_CON		0xe54
+#define MT8189_SPM_MDP0_PWR_CON			0xe68
+#define MT8189_SPM_DISP_PWR_CON			0xe70
+#define MT8189_SPM_MM_INFRA_PWR_CON		0xe78
+#define MT8189_SPM_DP_TX_PWR_CON		0xe80
+#define MT8189_SPM_CSI_RX_PWR_CON		0xe9c
+#define MT8189_SPM_SSUSB_PWR_CON		0xea8
+#define MT8189_SPM_MFG0_PWR_CON			0xeb4
+#define MT8189_SPM_MFG1_PWR_CON			0xeb8
+#define MT8189_SPM_MFG2_PWR_CON			0xebc
+#define MT8189_SPM_MFG3_PWR_CON			0xec0
+#define MT8189_SPM_EDP_TX_PWR_CON		0xf70
+#define MT8189_SPM_PCIE_PWR_CON			0xf74
+#define MT8189_SPM_PCIE_PHY_PWR_CON		0xf78
+
+#define MT8189_PROT_EN_EMISYS_STA_0_MM_INFRA		(GENMASK(21, 20))
+#define MT8189_PROT_EN_INFRASYS_STA_0_CONN		(BIT(8))
+#define MT8189_PROT_EN_INFRASYS_STA_1_CONN		(BIT(12))
+#define MT8189_PROT_EN_INFRASYS_STA_0_MM_INFRA		(BIT(16))
+#define MT8189_PROT_EN_INFRASYS_STA_1_MM_INFRA		(BIT(11))
+#define MT8189_PROT_EN_INFRASYS_STA_1_MFG1		(BIT(20))
+#define MT8189_PROT_EN_MCU_STA_0_CONN			(BIT(1))
+#define MT8189_PROT_EN_MCU_STA_0_CONN_2ND		(BIT(0))
+#define MT8189_PROT_EN_MD_STA_0_MFG1			(BIT(0) | BIT(2))
+#define MT8189_PROT_EN_MD_STA_0_MFG1_2ND		(BIT(4))
+#define MT8189_PROT_EN_MFG1				(GENMASK(5, 4))
+#define MT8189_PROT_EN_MM_INFRA_IGN			(BIT(1))
+#define MT8189_PROT_EN_MM_INFRA_2_IGN			(BIT(0))
+#define MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN		(GENMASK(31, 30))
+#define MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN		(GENMASK(10, 9))
+#define MT8189_PROT_EN_MMSYS_STA_0_DISP			(GENMASK(1, 0))
+#define MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1		(BIT(3))
+#define MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1		(BIT(7))
+#define MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE		(BIT(2))
+#define MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE		(BIT(8))
+#define MT8189_PROT_EN_MMSYS_STA_0_MDP0			(BIT(18))
+#define MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA		(GENMASK(3, 2))
+#define MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND		(GENMASK(15, 7))
+#define MT8189_PROT_EN_MMSYS_STA_0_VDE0			(BIT(20))
+#define MT8189_PROT_EN_MMSYS_STA_1_VDE0			(BIT(13))
+#define MT8189_PROT_EN_MMSYS_STA_0_VEN0			(BIT(12))
+#define MT8189_PROT_EN_MMSYS_STA_1_VEN0			(BIT(12))
+#define MT8189_PROT_EN_PERISYS_STA_0_AUDIO		(BIT(6))
+#define MT8189_PROT_EN_PERISYS_STA_0_SSUSB		(BIT(7))
+
+enum {
+	MT8189_BP_INVALID_TYPE = 0,
+	MT8189_BP_IFR_TYPE = 1,
+	MT8189_BP_VLP_TYPE = 2,
+	MT8189_VLPCFG_REG_TYPE = 3,
+	MT8189_EMICFG_AO_MEM_TYPE = 4,
+	MT8189_BUS_TYPE_NUM,
+};
+
+#endif /* __PMDOMAIN_MEDIATEK_MT8189_SCPSYS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 1a80c1537a43..ff0da0a5c615 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
  */
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -10,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
@@ -19,12 +21,36 @@
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
+#include <dt-bindings/power/mt8189-power.h>
+
+#include "mt8189-scpsys.h"
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
+#define MTK_POLL_TIMEOUT_300MS		(300 * USEC_PER_MSEC)
+#define MTK_POLL_IRQ_TIMEOUT		USEC_PER_SEC
+#define MTK_POLL_HWV_PREPARE_CNT	2500
+#define MTK_POLL_HWV_PREPARE_US		2
+#define MTK_ACK_DELAY_US		50
+#define MTK_RTFF_DELAY_US		10
+#define MTK_STABLE_DELAY_US		100
+
+#define MTK_BUS_PROTECTION_RETY_TIMES	10
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
+#define MTK_SCPD_SRAM_ISO		BIT(2)
+#define MTK_SCPD_SRAM_SLP		BIT(3)
+#define MTK_SCPD_BYPASS_INIT_ON		BIT(4)
+#define MTK_SCPD_IS_PWR_CON_ON		BIT(5)
+#define MTK_SCPD_HWV_OPS		BIT(6)
+#define MTK_SCPD_NON_CPU_RTFF		BIT(7)
+#define MTK_SCPD_PEXTP_PHY_RTFF		BIT(8)
+#define MTK_SCPD_UFS_RTFF		BIT(9)
+#define MTK_SCPD_RTFF_DELAY		BIT(10)
+#define MTK_SCPD_IRQ_SAVE		BIT(11)
+#define MTK_SCPD_ALWAYS_ON		BIT(12)
+#define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(13)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -56,6 +82,15 @@
 #define PWR_ON_BIT			BIT(2)
 #define PWR_ON_2ND_BIT			BIT(3)
 #define PWR_CLK_DIS_BIT			BIT(4)
+#define PWR_SRAM_CLKISO_BIT		BIT(5)
+#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
+#define PWR_RTFF_SAVE			BIT(24)
+#define PWR_RTFF_NRESTORE		BIT(25)
+#define PWR_RTFF_CLK_DIS		BIT(26)
+#define PWR_RTFF_SAVE_FLAG		BIT(27)
+#define PWR_RTFF_UFS_CLK_DIS		BIT(28)
+#define PWR_ACK				BIT(30)
+#define PWR_ACK_2ND			BIT(31)
 
 #define PWR_STATUS_CONN			BIT(1)
 #define PWR_STATUS_DISP			BIT(3)
@@ -78,10 +113,39 @@
 #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
 #define PWR_STATUS_WB			BIT(27)	/* MT7622 */
 
+#define _BUS_PROT(_type, _set_ofs, _clr_ofs,			\
+		_en_ofs, _sta_ofs, _mask, _ack_mask,		\
+		_ignore_clr_ack, _ignore_subsys_clk) {		\
+		.type = _type,					\
+		.set_ofs = _set_ofs,				\
+		.clr_ofs = _clr_ofs,				\
+		.en_ofs = _en_ofs,				\
+		.sta_ofs = _sta_ofs,				\
+		.mask = _mask,					\
+		.ack_mask = _ack_mask,				\
+		.ignore_clr_ack = _ignore_clr_ack,		\
+		.ignore_subsys_clk = _ignore_subsys_clk,		\
+	}
+
+#define BUS_PROT_IGN(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask)		\
+		_BUS_PROT(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask, _mask, true, false)
+
+#define BUS_PROT_SUBSYS_CLK_IGN(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask)		\
+		_BUS_PROT(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask, _mask, true, true)
+
+#define TEST_BP_ACK(bp, val)	((val & bp->ack_mask) == bp->ack_mask)
+#define scpsys_get_infracfg(pdev)	\
+	syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "infracfg")
+
 enum clk_id {
 	CLK_NONE,
 	CLK_MM,
 	CLK_MFG,
+	CLK_MFG_TOP,
 	CLK_VENC,
 	CLK_VENC_LT,
 	CLK_ETHIF,
@@ -89,6 +153,9 @@ enum clk_id {
 	CLK_HIFSEL,
 	CLK_JPGDEC,
 	CLK_AUDIO,
+	CLK_DISP_AO_CONFIG,
+	CLK_DISP_DPC,
+	CLK_MDP,
 	CLK_MAX,
 };
 
@@ -96,6 +163,7 @@ static const char * const clk_names[] = {
 	NULL,
 	"mm",
 	"mfg",
+	"mfg_top",
 	"venc",
 	"venc_lt",
 	"ethif",
@@ -103,10 +171,27 @@ static const char * const clk_names[] = {
 	"hif_sel",
 	"jpgdec",
 	"audio",
+	"disp_ao_config",
+	"disp_dpc",
+	"mdp",
 	NULL,
 };
 
 #define MAX_CLKS	3
+#define MAX_STEPS	4
+#define MAX_SUBSYS_CLKS 20
+
+struct bus_prot {
+	u32 type;
+	u32 set_ofs;
+	u32 clr_ofs;
+	u32 en_ofs;
+	u32 sta_ofs;
+	u32 mask;
+	u32 ack_mask;
+	bool ignore_clr_ack;
+	bool ignore_subsys_clk;
+};
 
 /**
  * struct scp_domain_data - scp domain data for power on/off flow
@@ -125,9 +210,13 @@ struct scp_domain_data {
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
+	u32 sram_slp_bits;
+	u32 sram_slp_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
-	u8 caps;
+	const char *subsys_clk_prefix;
+	struct bus_prot bp_table[MAX_STEPS];
+	u32 caps;
 };
 
 struct scp;
@@ -136,8 +225,11 @@ struct scp_domain {
 	struct generic_pm_domain genpd;
 	struct scp *scp;
 	struct clk *clk[MAX_CLKS];
+	struct clk *subsys_clk[MAX_SUBSYS_CLKS];
 	const struct scp_domain_data *data;
 	struct regulator *supply;
+	bool rtff_flag;
+	bool boot_status;
 };
 
 struct scp_ctrl_reg {
@@ -153,6 +245,8 @@ struct scp {
 	struct regmap *infracfg;
 	struct scp_ctrl_reg ctrl_reg;
 	bool bus_prot_reg_update;
+	struct regmap **bp_regmap;
+	int num_bp;
 };
 
 struct scp_subdomain {
@@ -167,6 +261,8 @@ struct scp_soc_data {
 	int num_subdomains;
 	const struct scp_ctrl_reg regs;
 	bool bus_prot_reg_update;
+	const char **bp_list;
+	int num_bp;
 };
 
 static int scpsys_domain_is_on(struct scp_domain *scpd)
@@ -191,6 +287,21 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
 	return -EINVAL;
 }
 
+static bool scpsys_pwr_ack_is_on(struct scp_domain *scpd)
+{
+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) & PWR_ACK;
+
+	return status ? true : false;
+}
+
+static bool scpsys_pwr_ack_2nd_is_on(struct scp_domain *scpd)
+{
+	u32 status = readl(scpd->scp->base + scpd->data->ctl_offs) &
+		     PWR_ACK_2ND;
+
+	return status ? true : false;
+}
+
 static int scpsys_regulator_enable(struct scp_domain *scpd)
 {
 	if (!scpd->supply)
@@ -233,11 +344,19 @@ static int scpsys_clk_enable(struct clk *clk[], int max_num)
 static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
 {
 	u32 val;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	u32 ack_mask, ack_sta;
 	int tmp;
 
-	val = readl(ctl_addr);
-	val &= ~scpd->data->sram_pdn_bits;
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
+		ack_mask = scpd->data->sram_slp_ack_bits;
+		ack_sta = ack_mask;
+		val = readl(ctl_addr) | scpd->data->sram_slp_bits;
+	} else {
+		ack_mask = scpd->data->sram_pdn_ack_bits;
+		ack_sta = 0;
+		val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
+	}
+
 	writel(val, ctl_addr);
 
 	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
@@ -251,35 +370,184 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
 	} else {
 		/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 		int ret = readl_poll_timeout(ctl_addr, tmp,
-				(tmp & pdn_ack) == 0,
+				(tmp & ack_mask) == ack_sta,
 				MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret < 0)
 			return ret;
 	}
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO)) {
+		val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
+		writel(val, ctl_addr);
+		udelay(1);
+		val &= ~PWR_SRAM_CLKISO_BIT;
+		writel(val, ctl_addr);
+	}
+
 	return 0;
 }
 
 static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
 {
 	u32 val;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	u32 ack_mask, ack_sta;
 	int tmp;
 
-	val = readl(ctl_addr);
-	val |= scpd->data->sram_pdn_bits;
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO)) {
+		val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
+		writel(val, ctl_addr);
+		val &= ~PWR_SRAM_ISOINT_B_BIT;
+		writel(val, ctl_addr);
+		udelay(1);
+	}
+
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_SLP)) {
+		ack_mask = scpd->data->sram_slp_ack_bits;
+		ack_sta = 0;
+		val = readl(ctl_addr) & ~scpd->data->sram_slp_bits;
+	} else {
+		ack_mask = scpd->data->sram_pdn_ack_bits;
+		ack_sta = ack_mask;
+		val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
+	}
 	writel(val, ctl_addr);
 
 	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
 	return readl_poll_timeout(ctl_addr, tmp,
-			(tmp & pdn_ack) == pdn_ack,
+			(tmp & ack_mask) == ack_sta,
 			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scp_domain *scpd)
+static int set_bus_protection(struct regmap *map, struct bus_prot *bp)
+{
+	u32 val = 0;
+	int retry = 0;
+	int ret = 0;
+
+	while (retry <= MTK_BUS_PROTECTION_RETY_TIMES) {
+		if (bp->set_ofs)
+			regmap_write(map,  bp->set_ofs, bp->mask);
+		else
+			regmap_update_bits(map, bp->en_ofs,
+					   bp->mask, bp->mask);
+
+		/* check bus protect enable setting */
+		regmap_read(map, bp->en_ofs, &val);
+		if ((val & bp->mask) == bp->mask)
+			break;
+
+		retry++;
+	}
+
+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,
+					      TEST_BP_ACK(bp, val),
+					      MTK_POLL_DELAY_US,
+					      MTK_POLL_TIMEOUT);
+	if (ret < 0) {
+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
+	}
+
+	return ret;
+}
+
+static int clear_bus_protection(struct regmap *map, struct bus_prot *bp)
+{
+	u32 val = 0;
+	int ret = 0;
+
+	if (bp->clr_ofs)
+		regmap_write(map, bp->clr_ofs, bp->mask);
+	else
+		regmap_update_bits(map, bp->en_ofs, bp->mask, 0);
+
+	if (bp->ignore_clr_ack)
+		return 0;
+
+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,
+					      !(val & bp->ack_mask),
+					      MTK_POLL_DELAY_US,
+					      MTK_POLL_TIMEOUT);
+	if (ret < 0) {
+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
+	}
+	return ret;
+}
+
+static int scpsys_bus_protect_table_disable(struct scp_domain *scpd,
+					    unsigned int index,
+					    bool ignore_subsys_clk)
+{
+	struct scp *scp = scpd->scp;
+	const struct bus_prot *bp_table = scpd->data->bp_table;
+	int ret = 0;
+	int i;
+
+	for (i = index; i >= 0; i--) {
+		struct regmap *map;
+		struct bus_prot bp = bp_table[i];
+
+		if (bp.type == 0 || bp.type >= scp->num_bp)
+			continue;
+
+		if (ignore_subsys_clk != bp.ignore_subsys_clk)
+			continue;
+
+		map = scp->bp_regmap[bp.type];
+		if (!map)
+			continue;
+
+		ret = clear_bus_protection(map, &bp);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int scpsys_bus_protect_table_enable(struct scp_domain *scpd,
+					   bool ignore_subsys_clk)
+{
+	struct scp *scp = scpd->scp;
+	const struct bus_prot *bp_table = scpd->data->bp_table;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < MAX_STEPS; i++) {
+		struct regmap *map;
+		struct bus_prot bp = bp_table[i];
+
+		if (bp.type == 0 || bp.type >= scp->num_bp)
+			continue;
+
+		if (ignore_subsys_clk != bp.ignore_subsys_clk)
+			continue;
+
+		map = scp->bp_regmap[bp.type];
+		if (!map)
+			continue;
+
+		ret = set_bus_protection(map, &bp);
+		if (ret) {
+			scpsys_bus_protect_table_disable(scpd, i,
+							 ignore_subsys_clk);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int scpsys_bus_protect_enable(struct scp_domain *scpd,
+				     bool ignore_subsys_clk)
 {
 	struct scp *scp = scpd->scp;
 
+	if (scp->bp_regmap && scp->num_bp > 0)
+		return scpsys_bus_protect_table_enable(scpd,
+						       ignore_subsys_clk);
+
 	if (!scpd->data->bus_prot_mask)
 		return 0;
 
@@ -288,10 +556,15 @@ static int scpsys_bus_protect_enable(struct scp_domain *scpd)
 			scp->bus_prot_reg_update);
 }
 
-static int scpsys_bus_protect_disable(struct scp_domain *scpd)
+static int scpsys_bus_protect_disable(struct scp_domain *scpd,
+				      bool ignore_subsys_clk)
 {
 	struct scp *scp = scpd->scp;
 
+	if (scp->bp_regmap && scp->num_bp > 0)
+		return scpsys_bus_protect_table_disable(scpd, MAX_STEPS - 1,
+							ignore_subsys_clk);
+
 	if (!scpd->data->bus_prot_mask)
 		return 0;
 
@@ -308,6 +581,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	u32 val;
 	int ret, tmp;
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_KEEP_DEFAULT_OFF) &&
+	    !scpd->boot_status)
+		return 0;
+
 	ret = scpsys_regulator_enable(scpd);
 	if (ret < 0)
 		return ret;
@@ -320,29 +597,114 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val = readl(ctl_addr);
 	val |= PWR_ON_BIT;
 	writel(val, ctl_addr);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on,
+						scpd, tmp, tmp > 0,
+						MTK_POLL_DELAY_US,
+						MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto err_pwr_ack;
+
+		udelay(MTK_ACK_DELAY_US);
+	}
+
 	val |= PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 1 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on,
+						scpd, tmp, tmp > 0,
+						MTK_POLL_DELAY_US,
+						MTK_POLL_TIMEOUT);
+	else
+		ret = readx_poll_timeout(scpsys_domain_is_on,
+					 scpd, tmp, tmp > 0,
+					 MTK_POLL_DELAY_US,
+					 MTK_POLL_TIMEOUT);
 	if (ret < 0)
 		goto err_pwr_ack;
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF) && scpd->rtff_flag) {
+		val |= PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+	}
+
 	val &= ~PWR_CLK_DIS_BIT;
 	writel(val, ctl_addr);
 
 	val &= ~PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
+		udelay(MTK_RTFF_DELAY_US);
+
 	val |= PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF)) {
+		val = readl(ctl_addr);
+		if (val & PWR_RTFF_SAVE_FLAG) {
+			val &= ~PWR_RTFF_SAVE_FLAG;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+		}
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
+		val = readl(ctl_addr);
+		if (val & PWR_RTFF_SAVE_FLAG) {
+			val &= ~PWR_RTFF_SAVE_FLAG;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val |= PWR_RTFF_NRESTORE;
+			writel(val, ctl_addr);
+
+			val &= ~PWR_RTFF_CLK_DIS;
+			writel(val, ctl_addr);
+		}
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF)
+		   && scpd->rtff_flag) {
+		val |= PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_NRESTORE;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_NRESTORE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		scpd->rtff_flag = false;
+	}
+
+	ret = scpsys_bus_protect_disable(scpd, true);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	ret = scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
+	if (ret < 0)
+		goto err_pwr_ack;
+
 	ret = scpsys_sram_enable(scpd, ctl_addr);
 	if (ret < 0)
 		goto err_pwr_ack;
 
-	ret = scpsys_bus_protect_disable(scpd);
+	ret = scpsys_bus_protect_disable(scpd, false);
 	if (ret < 0)
 		goto err_pwr_ack;
 
@@ -366,7 +728,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	u32 val;
 	int ret, tmp;
 
-	ret = scpsys_bus_protect_enable(scpd);
+	ret = scpsys_bus_protect_enable(scpd, false);
 	if (ret < 0)
 		goto out;
 
@@ -374,11 +736,53 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto out;
 
+	scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
+
+	ret = scpsys_bus_protect_enable(scpd, true);
+	if (ret < 0)
+		goto out;
+
 	/* subsys power off */
 	val = readl(ctl_addr);
+
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_NON_CPU_RTFF) ||
+	    MTK_SCPD_CAPS(scpd, MTK_SCPD_PEXTP_PHY_RTFF)) {
+		val |= PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE_FLAG;
+		writel(val, ctl_addr);
+	} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF)) {
+		val |= PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+
+		val |= PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_SAVE;
+		writel(val, ctl_addr);
+
+		val &= ~PWR_RTFF_UFS_CLK_DIS;
+		writel(val, ctl_addr);
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_UFS_RTFF))
+			scpd->rtff_flag = true;
+	}
+
 	val |= PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_RTFF_DELAY) && scpd->rtff_flag)
+		udelay(1);
+
 	val &= ~PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
@@ -388,12 +792,29 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	val &= ~PWR_ON_BIT;
 	writel(val, ctl_addr);
 
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON)) {
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_is_on,
+						scpd, tmp, tmp == 0,
+						MTK_POLL_DELAY_US,
+						MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			goto out;
+	}
+
 	val &= ~PWR_ON_2ND_BIT;
 	writel(val, ctl_addr);
 
 	/* wait until PWR_ACK = 0 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
+		ret = readx_poll_timeout_atomic(scpsys_pwr_ack_2nd_is_on,
+						scpd, tmp, tmp == 0,
+						MTK_POLL_DELAY_US,
+						MTK_POLL_TIMEOUT);
+	else
+		ret = readx_poll_timeout(scpsys_domain_is_on,
+					 scpd, tmp, tmp == 0,
+					 MTK_POLL_DELAY_US,
+					 MTK_POLL_TIMEOUT);
 	if (ret < 0)
 		goto out;
 
@@ -419,54 +840,145 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
 }
 
+static int init_subsys_clks(struct platform_device *pdev,
+			    const char *prefix, struct clk **clk)
+{
+	struct device_node *node = pdev->dev.of_node;
+	u32 prefix_len, sub_clk_cnt = 0;
+	struct property *prop;
+	const char *clk_name;
+
+	if (!node) {
+		dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
+			PTR_ERR(node));
+		return PTR_ERR(node);
+	}
+
+	prefix_len = strlen(prefix);
+
+	of_property_for_each_string(node, "clock-names", prop, clk_name) {
+		if (!strncmp(clk_name, prefix, prefix_len) &&
+		    (strlen(clk_name) > prefix_len + 1) &&
+		    (clk_name[prefix_len] == '-')) {
+			if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
+				dev_err(&pdev->dev,
+					"subsys clk out of range %d\n",
+					sub_clk_cnt);
+				return -EINVAL;
+			}
+
+			clk[sub_clk_cnt] = devm_clk_get(&pdev->dev, clk_name);
+
+			if (IS_ERR(clk[sub_clk_cnt])) {
+				dev_err(&pdev->dev,
+					"Subsys clk get fail %ld\n",
+					PTR_ERR(clk[sub_clk_cnt]));
+				return PTR_ERR(clk[sub_clk_cnt]);
+			}
+			sub_clk_cnt++;
+		}
+	}
+
+	return sub_clk_cnt;
+}
+
+static int mtk_pd_get_regmap(struct platform_device *pdev,
+			     struct regmap **regmap,
+			     const char *name)
+{
+	*regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, name);
+	if (PTR_ERR(*regmap) == -ENODEV) {
+		dev_notice(&pdev->dev, "%s regmap is null(%ld)\n",
+			   name, PTR_ERR(*regmap));
+		*regmap = NULL;
+	} else if (IS_ERR(*regmap)) {
+		dev_notice(&pdev->dev, "Cannot find %s controller: %ld\n",
+			   name, PTR_ERR(*regmap));
+		return PTR_ERR(*regmap);
+	}
+
+	return 0;
+}
+
+static bool scpsys_get_boot_status(struct scp_domain *scpd)
+{
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IS_PWR_CON_ON))
+		return scpsys_pwr_ack_is_on(scpd) &&
+		       scpsys_pwr_ack_2nd_is_on(scpd);
+	return scpsys_domain_is_on(scpd);
+}
+
 static struct scp *init_scp(struct platform_device *pdev,
-			const struct scp_domain_data *scp_domain_data, int num,
-			const struct scp_ctrl_reg *scp_ctrl_reg,
-			bool bus_prot_reg_update)
+		     const struct scp_soc_data *soc)
 {
 	struct genpd_onecell_data *pd_data;
+	struct resource *res;
 	int i, j;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
+	int ret;
 
 	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
 	if (!scp)
 		return ERR_PTR(-ENOMEM);
 
-	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
-	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
+	scp->ctrl_reg.pwr_sta_offs = soc->regs.pwr_sta_offs;
+	scp->ctrl_reg.pwr_sta2nd_offs = soc->regs.pwr_sta2nd_offs;
 
-	scp->bus_prot_reg_update = bus_prot_reg_update;
+	scp->bus_prot_reg_update = soc->bus_prot_reg_update;
 
 	scp->dev = &pdev->dev;
 
-	scp->base = devm_platform_ioremap_resource(pdev, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	scp->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(scp->base))
 		return ERR_CAST(scp->base);
 
-	scp->domains = devm_kcalloc(&pdev->dev,
-				num, sizeof(*scp->domains), GFP_KERNEL);
+	scp->domains = devm_kcalloc(&pdev->dev, soc->num_domains,
+				    sizeof(*scp->domains), GFP_KERNEL);
 	if (!scp->domains)
 		return ERR_PTR(-ENOMEM);
 
 	pd_data = &scp->pd_data;
 
-	pd_data->domains = devm_kcalloc(&pdev->dev,
-			num, sizeof(*pd_data->domains), GFP_KERNEL);
+	pd_data->domains = devm_kcalloc(&pdev->dev, soc->num_domains,
+					sizeof(*pd_data->domains),
+					GFP_KERNEL);
 	if (!pd_data->domains)
 		return ERR_PTR(-ENOMEM);
 
-	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-			"infracfg");
-	if (IS_ERR(scp->infracfg)) {
-		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
+	if (soc->bp_list && soc->num_bp > 0) {
+		scp->num_bp = soc->num_bp;
+		scp->bp_regmap = devm_kcalloc(&pdev->dev, scp->num_bp,
+					      sizeof(*scp->bp_regmap),
+					      GFP_KERNEL);
+		if (!scp->bp_regmap)
+			return ERR_PTR(-ENOMEM);
+
+		/*
+		 * get bus prot regmap from dts node,
+		 * 0 means invalid bus type
+		 */
+		for (i = 1; i < scp->num_bp; i++) {
+			ret = mtk_pd_get_regmap(pdev, &scp->bp_regmap[i],
+						soc->bp_list[i]);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+	} else {
+		scp->infracfg = scpsys_get_infracfg(pdev);
+
+		if (IS_ERR(scp->infracfg)) {
+			dev_err(&pdev->dev,
+				"Cannot find infracfg controller: %ld\n",
 				PTR_ERR(scp->infracfg));
-		return ERR_CAST(scp->infracfg);
+			return ERR_CAST(scp->infracfg);
+		}
 	}
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < soc->num_domains; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-		const struct scp_domain_data *data = &scp_domain_data[i];
+		const struct scp_domain_data *data = &soc->domains[i];
 
 		scpd->supply = devm_regulator_get_optional(&pdev->dev, data->name);
 		if (IS_ERR(scpd->supply)) {
@@ -477,14 +989,14 @@ static struct scp *init_scp(struct platform_device *pdev,
 		}
 	}
 
-	pd_data->num_domains = num;
+	pd_data->num_domains = soc->num_domains;
 
 	init_clks(pdev, clk);
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < soc->num_domains; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
 		struct generic_pm_domain *genpd = &scpd->genpd;
-		const struct scp_domain_data *data = &scp_domain_data[i];
+		const struct scp_domain_data *data = &soc->domains[i];
 
 		pd_data->domains[i] = genpd;
 		scpd->scp = scp;
@@ -503,11 +1015,26 @@ static struct scp *init_scp(struct platform_device *pdev,
 			scpd->clk[j] = c;
 		}
 
+		if (data->subsys_clk_prefix) {
+			ret = init_subsys_clks(pdev,
+					       data->subsys_clk_prefix,
+					       scpd->subsys_clk);
+			if (ret < 0) {
+				dev_notice(&pdev->dev,
+					   "%s: subsys clk unavailable\n",
+					   data->name);
+				return ERR_PTR(ret);
+			}
+		}
 		genpd->name = data->name;
 		genpd->power_off = scpsys_power_off;
 		genpd->power_on = scpsys_power_on;
 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IRQ_SAVE))
+			genpd->flags |= GENPD_FLAG_IRQ_SAFE;
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ALWAYS_ON))
+			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
 	}
 
 	return scp;
@@ -530,8 +1057,17 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		 * software.  The unused domains will be switched off during
 		 * late_init time.
 		 */
-		on = !WARN_ON(genpd->power_on(genpd) < 0);
-
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
+			scpd->boot_status = scpsys_get_boot_status(scpd);
+			if (scpd->boot_status)
+				on = !WARN_ON(genpd->power_on(genpd) < 0);
+			else
+				on = false;
+		} else if (MTK_SCPD_CAPS(scpd, MTK_SCPD_BYPASS_INIT_ON)) {
+			on = false;
+		} else {
+			on = !WARN_ON(genpd->power_on(genpd) < 0);
+		}
 		pm_genpd_init(genpd, NULL, !on);
 	}
 
@@ -1009,6 +1545,328 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
 	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
 };
 
+/*
+ * MT8189 power domain support
+ */
+static const char *mt8189_bus_list[MT8189_BUS_TYPE_NUM] = {
+	[MT8189_BP_IFR_TYPE] = "infra-infracfg-ao-reg-bus",
+	[MT8189_BP_VLP_TYPE] = "vlpcfg-reg-bus",
+	[MT8189_VLPCFG_REG_TYPE] = "vlpcfg-reg-bus",
+	[MT8189_EMICFG_AO_MEM_TYPE] = "emicfg-ao-mem",
+};
+
+static const struct scp_domain_data scp_domain_mt8189_spm_data[] = {
+	[MT8189_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.ctl_offs = MT8189_SPM_CONN_PWR_CON,
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c94, 0x0c98, 0x0c90, 0x0c9c,
+				     MT8189_PROT_EN_MCU_STA_0_CONN),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c54, 0x0c58, 0x0c50, 0x0c5c,
+				     MT8189_PROT_EN_INFRASYS_STA_1_CONN),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c94, 0x0c98, 0x0c90, 0x0c9c,
+				     MT8189_PROT_EN_MCU_STA_0_CONN_2ND),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c44, 0x0c48, 0x0c40, 0x0c4c,
+				     MT8189_PROT_EN_INFRASYS_STA_0_CONN),
+		},
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.ctl_offs = MT8189_SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c84, 0x0c88, 0x0c80, 0x0c8c,
+				     MT8189_PROT_EN_PERISYS_STA_0_AUDIO),
+		},
+		.clk_id = {CLK_AUDIO},
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT] = {
+		.name = "adsp-top-dormant",
+		.ctl_offs = MT8189_SPM_ADSP_TOP_PWR_CON,
+		.sram_slp_bits = GENMASK(9, 9),
+		.sram_slp_ack_bits = GENMASK(13, 13),
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_SLP |
+			MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_ACTIVE_WAKEUP |
+			MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_INFRA] = {
+		.name = "adsp-infra",
+		.ctl_offs = MT8189_SPM_ADSP_INFRA_PWR_CON,
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_AO] = {
+		.name = "adsp-ao",
+		.ctl_offs = MT8189_SPM_ADSP_AO_PWR_CON,
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG1] = {
+		.name = "isp-img1",
+		.ctl_offs = MT8189_SPM_ISP_IMG1_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1),
+		},
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG2] = {
+		.name = "isp-img2",
+		.ctl_offs = MT8189_SPM_ISP_IMG2_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IPE] = {
+		.name = "isp-ipe",
+		.ctl_offs = MT8189_SPM_ISP_IPE_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE),
+		},
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_VDE0] = {
+		.name = "vde0",
+		.ctl_offs = MT8189_SPM_VDE0_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_VDE0),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_VDE0),
+		},
+		.clk_id = {CLK_VDEC},
+		.subsys_clk_prefix = "vdec",
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_VEN0] = {
+		.name = "ven0",
+		.ctl_offs = MT8189_SPM_VEN0_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_VEN0),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_VEN0),
+		},
+		.clk_id = {CLK_VENC},
+		.subsys_clk_prefix = "venc",
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_CAM_MAIN] = {
+		.name = "cam-main",
+		.ctl_offs = MT8189_SPM_CAM_MAIN_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1C,
+				     MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2C,
+				     MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN),
+		},
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBA] = {
+		.name = "cam-suba",
+		.ctl_offs = MT8189_SPM_CAM_SUBA_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBB] = {
+		.name = "cam-subb",
+		.ctl_offs = MT8189_SPM_CAM_SUBB_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_MDP0] = {
+		.name = "mdp0",
+		.ctl_offs = MT8189_SPM_MDP0_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_MDP0),
+		},
+		.clk_id = {CLK_MDP},
+		.subsys_clk_prefix = "mdp0",
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.ctl_offs = MT8189_SPM_DISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c14, 0x0c18, 0x0c10, 0x0c1c,
+				     MT8189_PROT_EN_MMSYS_STA_0_DISP),
+		},
+		.clk_id = {CLK_DISP_AO_CONFIG},
+		.subsys_clk_prefix = "disp",
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_MM_INFRA] = {
+		.name = "mm-infra",
+		.ctl_offs = MT8189_SPM_MM_INFRA_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+				     MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND),
+			BUS_PROT_SUBSYS_CLK_IGN(MT8189_BP_IFR_TYPE,
+						0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+						MT8189_PROT_EN_MM_INFRA_IGN),
+			BUS_PROT_SUBSYS_CLK_IGN(MT8189_BP_IFR_TYPE,
+						0x0c24, 0x0c28, 0x0c20, 0x0c2c,
+						MT8189_PROT_EN_MM_INFRA_2_IGN),
+		},
+		.clk_id = {CLK_MM},
+		.subsys_clk_prefix = "mm_infra",
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_DP_TX] = {
+		.name = "dp-tx",
+		.ctl_offs = MT8189_SPM_DP_TX_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_CSI_RX] = {
+		.name = "csi-rx",
+		.ctl_offs = MT8189_SPM_CSI_RX_PWR_CON,
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_SSUSB] = {
+		.name = "ssusb",
+		.ctl_offs = MT8189_SPM_SSUSB_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c84, 0x0c88, 0x0c80, 0x0c8c,
+				     MT8189_PROT_EN_PERISYS_STA_0_SSUSB),
+		},
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8189_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
+		.ctl_offs = MT8189_SPM_MFG0_PWR_CON,
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+		.clk_id = {CLK_MFG_TOP},
+	},
+	[MT8189_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
+		.ctl_offs = MT8189_SPM_MFG1_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0c54, 0x0c58, 0x0c50, 0x0C5c,
+				     MT8189_PROT_EN_INFRASYS_STA_1_MFG1),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0ca4, 0x0ca8, 0x0ca0, 0x0cac,
+				     MT8189_PROT_EN_MD_STA_0_MFG1),
+			BUS_PROT_IGN(MT8189_BP_IFR_TYPE,
+				     0x0ca4, 0x0ca8, 0x0ca0, 0x0cac,
+				     MT8189_PROT_EN_MD_STA_0_MFG1_2ND),
+			BUS_PROT_IGN(MT8189_EMICFG_AO_MEM_TYPE,
+				     0x0084, 0x0088, 0x0080, 0x008c,
+				     MT8189_PROT_EN_MFG1),
+		},
+		.clk_id = {CLK_MFG},
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
+		.ctl_offs = MT8189_SPM_MFG2_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
+		.ctl_offs = MT8189_SPM_MFG3_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_EDP_TX_DORMANT] = {
+		.name = "edp-tx-dormant",
+		.ctl_offs = MT8189_SPM_EDP_TX_PWR_CON,
+		.sram_slp_bits = GENMASK(9, 9),
+		.sram_slp_ack_bits = 0,
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_SLP |
+			MTK_SCPD_IS_PWR_CON_ON,
+	},
+	[MT8189_POWER_DOMAIN_PCIE] = {
+		.name = "pcie",
+		.ctl_offs = MT8189_SPM_PCIE_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_IS_PWR_CON_ON | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8189_POWER_DOMAIN_PCIE_PHY] = {
+		.name = "pcie-phy",
+		.ctl_offs = MT8189_SPM_PCIE_PHY_PWR_CON,
+		.caps = MTK_SCPD_IS_PWR_CON_ON,
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt8189_spm[] = {
+	{MT8189_POWER_DOMAIN_ADSP_AO, MT8189_POWER_DOMAIN_ADSP_INFRA},
+	{MT8189_POWER_DOMAIN_ADSP_INFRA, MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_ISP_IMG1},
+	{MT8189_POWER_DOMAIN_ISP_IMG1, MT8189_POWER_DOMAIN_ISP_IMG2},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_ISP_IPE},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_VDE0},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_VEN0},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_CAM_MAIN},
+	{MT8189_POWER_DOMAIN_CAM_MAIN, MT8189_POWER_DOMAIN_CAM_SUBA},
+	{MT8189_POWER_DOMAIN_CAM_MAIN, MT8189_POWER_DOMAIN_CAM_SUBB},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_MDP0},
+	{MT8189_POWER_DOMAIN_MM_INFRA, MT8189_POWER_DOMAIN_DISP},
+	{MT8189_POWER_DOMAIN_DISP, MT8189_POWER_DOMAIN_DP_TX},
+	{MT8189_POWER_DOMAIN_MFG0, MT8189_POWER_DOMAIN_MFG1},
+	{MT8189_POWER_DOMAIN_MFG1, MT8189_POWER_DOMAIN_MFG2},
+	{MT8189_POWER_DOMAIN_MFG1, MT8189_POWER_DOMAIN_MFG3},
+	{MT8189_POWER_DOMAIN_DP_TX, MT8189_POWER_DOMAIN_EDP_TX_DORMANT},
+	{MT8189_POWER_DOMAIN_PCIE, MT8189_POWER_DOMAIN_PCIE_PHY},
+};
+
 static const struct scp_soc_data mt2701_data = {
 	.domains = scp_domain_data_mt2701,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
@@ -1075,6 +1933,19 @@ static const struct scp_soc_data mt8173_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt8189_spm_data = {
+	.domains = scp_domain_mt8189_spm_data,
+	.num_domains = ARRAY_SIZE(scp_domain_mt8189_spm_data),
+	.subdomains = scp_subdomain_mt8189_spm,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8189_spm),
+	.regs = {
+		.pwr_sta_offs = 0xF40,
+		.pwr_sta2nd_offs = 0xF44,
+	},
+	.bp_list = mt8189_bus_list,
+	.num_bp = MT8189_BUS_TYPE_NUM,
+};
+
 /*
  * scpsys driver init
  */
@@ -1098,6 +1969,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
+	}, {
+		.compatible = "mediatek,mt8189-scpsys",
+		.data = &mt8189_spm_data,
 	}, {
 		/* sentinel */
 	}
@@ -1113,8 +1987,7 @@ static int scpsys_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
-			soc->bus_prot_reg_update);
+	scp = init_scp(pdev, soc);
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
-- 
2.45.2


