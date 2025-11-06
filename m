Return-Path: <linux-pm+bounces-37508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A4C3AECD
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56653BC861
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6C32C329;
	Thu,  6 Nov 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QCXtz6b7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2D32C942;
	Thu,  6 Nov 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433026; cv=none; b=OevPI1pM8jOsxdBPtO4NMWqtIavb25kiNaLI10Jmb+RsGYuqhm3/Fg8L2CzXe/Q37F73dD0M0Plw/zRhJH+4LEAJSxfulYLVAkXsCe3Qf5ho/ZOCxRGniEihf6eD70n6LZBvf1wRAJiZBJIRXKbV8NvZM3PbS/RVcr96T571fRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433026; c=relaxed/simple;
	bh=deBh6sN7jnovclPpE/m4WkMZBUHuC8Gxz8lw0C7HMhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gc06e5C9vTO4SohAWetop/E5Bm+7UbgwSvEcbh0L9BslFdjqeM7PLNxVI3g1Z9y3biwtVdPL1M+r+syj7D0Lohcq7yVqtOVn2upD55okhFXTGH3NT1tCI/A+OGJwuZWvV4Wbt28vpKsy7SlSre6YpGjEpaE5tX10+/pV1Dq33dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QCXtz6b7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 37b6b19abb0e11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tkjuVVayDuW7MvowDSdoHxXBhJHpKe5iFYRerieWYOI=;
	b=QCXtz6b7e4pt892gMwQ7YuCu2WsqntpA3V/u3HlQAW9T2T8SabkVSBrUlGbcMdSU3bdMeqhCBiKLV5HrMLug6SCYVTPZCeMHiEj7C+bRlMiXVasPGw9Kf9KJldhmnRSDf3lh5mKlVxnmtvBFzPUEnnhixS4upXCmxWktwubMVec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:df885c5d-2369-4ce0-a061-deee50301c44,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:ba351d6b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 37b6b19abb0e11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 226673906; Thu, 06 Nov 2025 20:43:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH v3 04/21] clk: mediatek: Add MT8189 apmixedsys clock support
Date: Thu, 6 Nov 2025 20:41:49 +0800
Message-ID: <20251106124330.1145600-5-irving-ch.lin@mediatek.com>
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

Add support for the MT8189 apmixedsys clock controller, which provides
PLLs generated from SoC 26m.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig                 |  13 ++
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 135 +++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-apmixedsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 0e8dd82aa84e..2c898fd8a34c 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
 	help
 	  This driver supports MediaTek MT8188 Warp Engine clocks.
 
+config COMMON_CLK_MT8189
+	bool "Clock driver for MediaTek MT8189"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+	default ARCH_MEDIATEK
+	help
+	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d8736a060dbd..66577ccb9b93 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
new file mode 100644
index 000000000000..8d67888737a2
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
@@ -0,0 +1,135 @@
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
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_PLLEN_OFS	0x70
+#define MT8189_INTEGER_BITS	8
+
+#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
+			_pcwbits) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.en_reg = MT8189_PLLEN_OFS,			\
+		.reg = _reg,					\
+		.pll_en_bit = _en_setclr_bit,			\
+		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
+		.flags = _flags,				\
+		.fmax = MT8189_PLL_FMAX,			\
+		.fmin = MT8189_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8189_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
+		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
+		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
+		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
+		   23, HAVE_RST_BAR | PLL_AO,
+		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
+		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
+		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
+		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
+		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
+		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
+		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
+		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
+		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
+		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
+		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
+		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
+		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
+		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
+};
+
+static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	int r;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, apmixed_plls,
+				  ARRAY_SIZE(apmixed_plls), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8189_apmixed_drv = {
+	.probe = clk_mt8189_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8189-apmixed",
+		.of_match_table = of_match_clk_mt8189_apmixed,
+	},
+};
+
+module_platform_driver(clk_mt8189_apmixed_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


