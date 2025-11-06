Return-Path: <linux-pm+bounces-37516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD898C3B041
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714634FE726
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7E332911;
	Thu,  6 Nov 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZF2k8GOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7E32E6A7;
	Thu,  6 Nov 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433031; cv=none; b=phF0ICFNEWPb7zFQubdDGZKoXmenXXOFdNyczhzujrTbOXy5RpQ0FUa1bWRmLBfoLL/6wK971AY9Ad64NcQJCJINxOGw26piOFvFxJ5ErHDIvepuHdnGQiifLax/rRe76OpBLKFUCFOUQ6C5NwmxsXId/IBxE2tkZK4/yguMmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433031; c=relaxed/simple;
	bh=iWmIAl5GK0S3ASksR/l7iPRvDGNTQqjoAhevB2YVHO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJIAe3SEZp2gQzQ74YBbshLoYhxAVHhB3HUnH0KrqYunlTWEFV7JfxfO2GGLGk4FjNWbTWn4PXYMaY6lpVg6pFcbSQazCzPATmO1rbsE33gKPOfCltVsEai7f6prjroFysRX7pEf7IHMQABkEJRcPVNFlyheWAlBVjCx7meeME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZF2k8GOo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 376c1900bb0e11f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FThgz2BEX8Ok3/HoFJ68sv45+Zt7sNKUupQOE+a8H9E=;
	b=ZF2k8GOoBlznODxnHPqYX79szHex3im5lbdPyBobZsBRTGjbLi3k5O5W7wbiVyHC4V9zGJoyssj06qP0IGj7XrV+hjfLQk/9gooEtOLkDh1bYDX4MpCuELQLNWk79HbTwbkMax5MF1HzeMNQzNVkn2jOCj4roZ8TSnNpejHhxSs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7db03d55-9a00-4fb5-b58c-5e6037b62768,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:c413fc7c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 376c1900bb0e11f08ac0a938fc7cd336-20251106
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1166933572; Thu, 06 Nov 2025 20:43:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 20:43:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 20:43:37 +0800
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
Subject: [PATCH v3 06/21] clk: mediatek: Add MT8189 vlpckgen clock support
Date: Thu, 6 Nov 2025 20:41:51 +0800
Message-ID: <20251106124330.1145600-7-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 vlpckgen clock controller, which provides
muxes and dividers for clock selection in vlp domain for other IP blocks.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Makefile              |   3 +-
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c | 278 +++++++++++++++++++++
 2 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vlpckgen.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 9d3d2983bfb2..3b25df9e7b50 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,7 +123,8 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
-obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
+				   clk-mt8189-vlpckgen.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-vlpckgen.c b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
new file mode 100644
index 000000000000..277957e0b0d8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vlpckgen.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static DEFINE_SPINLOCK(mt8189_vlpclk_lock);
+
+static const char * const vlp_26m_oscd10_parents[] = {
+	"clk26m",
+	"osc_d10"
+};
+
+static const char * const vlp_vadsp_vowpll_parents[] = {
+	"clk26m",
+	"vowpll"
+};
+
+static const char * const vlp_sspm_ulposc_parents[] = {
+	"ulposc",
+	"univpll_d5_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_aud_adc_parents[] = {
+	"clk26m",
+	"vowpll",
+	"aud_adc_ext",
+	"osc_d10"
+};
+
+static const char * const vlp_scp_iic_spi_parents[] = {
+	"clk26m",
+	"mainpll_d5_d4",
+	"mainpll_d7_d2",
+	"osc_d10"
+};
+
+static const char * const vlp_vadsp_uarthub_b_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"univpll_d6_d4",
+	"univpll_d6_d2"
+};
+
+static const char * const vlp_axi_kp_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"osc_d2",
+	"mainpll_d7_d4",
+	"mainpll_d7_d2"
+};
+
+static const char * const vlp_sspm_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"mainpll_d5_d2",
+	"ulposc",
+	"mainpll_d6"
+};
+
+static const char * const vlp_pwm_vlp_parents[] = {
+	"clk26m",
+	"osc_d4",
+	"clk32k",
+	"osc_d10",
+	"mainpll_d4_d8"
+};
+
+static const char * const vlp_pwrap_ulposc_parents[] = {
+	"clk26m",
+	"osc_d10",
+	"osc_d7",
+	"osc_d8",
+	"osc_d16",
+	"mainpll_d7_d8"
+};
+
+static const char * const vlp_vadsp_parents[] = {
+	"clk26m",
+	"osc_d20",
+	"osc_d10",
+	"osc_d2",
+	"ulposc",
+	"mainpll_d4_d2"
+};
+
+static const char * const vlp_scp_parents[] = {
+	"clk26m",
+	"univpll_d4",
+	"univpll_d3",
+	"mainpll_d3",
+	"univpll_d6",
+	"apll1",
+	"mainpll_d4",
+	"mainpll_d6",
+	"mainpll_d7",
+	"osc_d10"
+};
+
+static const char * const vlp_spmi_p_parents[] = {
+	"clk26m",
+	"f26m_d2",
+	"osc_d8",
+	"osc_d10",
+	"osc_d16",
+	"osc_d7",
+	"clk32k",
+	"mainpll_d7_d8",
+	"mainpll_d6_d8",
+	"mainpll_d5_d8"
+};
+
+static const char * const vlp_camtg_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d6_d8",
+	"univpll_192m_d4",
+	"osc_d16",
+	"osc_d20",
+	"osc_d10",
+	"univpll_d6_d16",
+	"tvdpll1_d16",
+	"f26m_d2",
+	"univpll_192m_d10",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const struct mtk_mux vlp_ck_muxes[] = {
+	/* VLP_CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_SCP_SEL, "vlp_scp_sel",
+			     vlp_scp_parents, 0x008, 0x00c, 0x010,
+			     0, 4, 7, 0x04, 0),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWRAP_ULPOSC_SEL, "vlp_pwrap_osc_sel",
+			vlp_pwrap_ulposc_parents, 0x008, 0x00c, 0x010,
+			8, 3, 0x04, 1),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SPMI_P_MST_SEL, "vlp_spmi_p_sel",
+			vlp_spmi_p_parents, 0x008, 0x00c, 0x010,
+			16, 4, 0x04, 2),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_DVFSRC_SEL, "vlp_dvfsrc_sel",
+			vlp_26m_oscd10_parents, 0x008, 0x00c, 0x010,
+			24, 1, 0x04, 3),
+	/* VLP_CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWM_VLP_SEL, "vlp_pwm_vlp_sel",
+			vlp_pwm_vlp_parents, 0x014, 0x018, 0x01c,
+			0, 3, 0x04, 4),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AXI_VLP_SEL, "vlp_axi_vlp_sel",
+			vlp_axi_kp_parents, 0x014, 0x018, 0x01c,
+			8, 3, 0x04, 5),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SYSTIMER_26M_SEL, "vlp_timer_26m_sel",
+			vlp_26m_oscd10_parents, 0x014, 0x018, 0x01c,
+			16, 1, 0x04, 6),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_SEL, "vlp_sspm_sel",
+			vlp_sspm_parents, 0x014, 0x018, 0x01c,
+			24, 3, 0x04, 7),
+	/* VLP_CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_F26M_SEL, "vlp_sspm_f26m_sel",
+			vlp_26m_oscd10_parents, 0x020, 0x024, 0x028,
+			0, 1, 0x04, 8),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SRCK_SEL, "vlp_srck_sel",
+			vlp_26m_oscd10_parents, 0x020, 0x024, 0x028,
+			8, 1, 0x04, 9),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_SEL, "vlp_scp_spi_sel",
+			vlp_scp_iic_spi_parents, 0x020, 0x024, 0x028,
+			16, 2, 0x04, 10),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_SEL, "vlp_scp_iic_sel",
+			vlp_scp_iic_spi_parents, 0x020, 0x024, 0x028,
+			24, 2, 0x04, 11),
+	/* VLP_CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL,
+			"vlp_scp_spi_hs_sel",
+			vlp_scp_iic_spi_parents, 0x02c, 0x030, 0x034,
+			0, 2, 0x04, 12),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL,
+			"vlp_scp_iic_hs_sel",
+			vlp_scp_iic_spi_parents, 0x02c, 0x030, 0x034,
+			8, 2, 0x04, 13),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_ULPOSC_SEL, "vlp_sspm_ulposc_sel",
+			vlp_sspm_ulposc_parents, 0x02c, 0x030, 0x034,
+			16, 2, 0x04, 14),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_APXGPT_26M_SEL, "vlp_apxgpt_26m_sel",
+			vlp_26m_oscd10_parents, 0x02c, 0x030, 0x034,
+			24, 1, 0x04, 15),
+	/* VLP_CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_SEL, "vlp_vadsp_sel",
+			     vlp_vadsp_parents, 0x038, 0x03c, 0x040,
+			     0, 3, 7, 0x04, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_VOWPLL_SEL,
+			     "vlp_vadsp_vowpll_sel",
+			     vlp_vadsp_vowpll_parents, 0x038, 0x03c, 0x040,
+			     8, 1, 15, 0x04, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL,
+			     "vlp_vadsp_uarthub_b_sel",
+			     vlp_vadsp_uarthub_b_parents,
+			     0x038, 0x03c, 0x040, 16, 2, 23, 0x04, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG0_SEL, "vlp_camtg0_sel",
+			     vlp_camtg_parents, 0x038, 0x03c, 0x040,
+			     24, 4, 31, 0x04, 19),
+	/* VLP_CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG1_SEL, "vlp_camtg1_sel",
+			     vlp_camtg_parents, 0x044, 0x048, 0x04c,
+			     0, 4, 7, 0x04, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG2_SEL, "vlp_camtg2_sel",
+			     vlp_camtg_parents, 0x044, 0x048, 0x04c,
+			     8, 4, 15, 0x04, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_AUD_ADC_SEL, "vlp_aud_adc_sel",
+			     vlp_aud_adc_parents, 0x044, 0x048, 0x04c,
+			     16, 2, 23, 0x04, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_KP_IRQ_GEN_SEL, "vlp_kp_irq_sel",
+			     vlp_axi_kp_parents, 0x044, 0x048, 0x04c,
+			     24, 3, 31, 0x04, 23),
+};
+
+static const struct mtk_gate_regs vlp_ck_cg_regs = {
+	.set_ofs = 0x1f4,
+	.clr_ofs = 0x1f8,
+	.sta_ofs = 0x1f0,
+};
+
+#define GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, _flag) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vlp_ck_cg_regs,		\
+		.shift = _shift,			\
+		.flags = _flag,				\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+	}
+
+#define GATE_VLP_CK(_id, _name, _parent, _shift)	\
+	GATE_VLP_CK_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate vlp_ck_clks[] = {
+	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m", "clk26m", 1),
+	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",
+			  "osc_d10", 11, CLK_IS_CRITICAL),
+};
+
+static const struct mtk_clk_desc vlpck_desc = {
+	.mux_clks = vlp_ck_muxes,
+	.num_mux_clks = ARRAY_SIZE(vlp_ck_muxes),
+	.clks = vlp_ck_clks,
+	.num_clks = ARRAY_SIZE(vlp_ck_clks),
+	.clk_lock = &mt8189_vlpclk_lock,
+};
+
+static const struct of_device_id of_match_clk_mt8189_vlpck[] = {
+	{ .compatible = "mediatek,mt8189-vlpckgen", .data = &vlpck_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_vlpck_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-vlpck",
+		.of_match_table = of_match_clk_mt8189_vlpck,
+	},
+};
+
+module_platform_driver(clk_mt8189_vlpck_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


