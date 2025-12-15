Return-Path: <linux-pm+bounces-39509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B230FCBC66D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 04:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B58830393DF
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D73203A1;
	Mon, 15 Dec 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MAw9v5Im"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B431A801;
	Mon, 15 Dec 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770612; cv=none; b=RDtCdKfvfmiClXK8mFYS4BkwtB1mIvVcNlgSab4tyEXrPjEaHI29D47VflIhwqvd4+o+VU20lTqe+XNl8uafMsM1uaci+2/Wxx82fhl+r5UBXLYWFTk3V2njGM7ZeXOmGf5HY4i1NpV8PxBwanEkgHrOWXfDCswZDOkOsFk6HgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770612; c=relaxed/simple;
	bh=mrBDlE4ETM41eeca2CRnaHjf+xtmVA5puh1Czn8kKcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDldX1PwnEtRWBA6Hh6/XIs6R5FqHREziGvErB71nEZxhqIjQCSMhavb81WZ3m6/hZ+GRJr9m+xWhWhl0YImJoKS3tlNQ4tkrjsWBudle5w328k781QPbuNVPUdN4wvb1BefQQueW4rfDj//3joBZE4y/FEZuo+lIRKyqLdLae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MAw9v5Im; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d9f638cd96911f0b2bf0b349165d6e0-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Gy92obh8Ukix7BUauEXFxVr7F2CXq0uko5Tmi9maIEg=;
	b=MAw9v5ImBzkuZvnPKf8aIkAdkLDqKfY1OE3QxYMwHqBF2pYda1eaVKOZqYzk8m+Z7W8c9oe2NJlSP8HUEiV5Hx2yEuDlUey3ab4VEy5XJ5WXEs9o5mCX0cZuLj4NSinWWflJ+Buce+ThW28hoUsq0NsFFue/SA3Nb+8DWnRXLP4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:08179ddd-8b2a-498d-8a01-a9ad7f0b7c52,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-45
X-CID-META: VersionHash:a9d874c,CLOUDID:bb078528-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d9f638cd96911f0b2bf0b349165d6e0-20251215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1570989961; Mon, 15 Dec 2025 11:49:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 11:49:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 11:49:53 +0800
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
Subject: [PATCH v4 15/21] clk: mediatek: Add MT8189 mfg clock support
Date: Mon, 15 Dec 2025 11:49:24 +0800
Message-ID: <20251215034944.2973003-16-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add support for the MT8189 mfg clock controller,
which provides clock gate control for the GPU.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          | 11 ++++++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8189-mfg.c | 53 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-mfg.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ef962f5816a8..316d010b503a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -906,6 +906,17 @@ config COMMON_CLK_MT8189_MDPSYS
 	  chipset, ensuring that the display system operates efficiently and
 	  effectively.
 
+config COMMON_CLK_MT8189_MFG
+	tristate "Clock driver for MediaTek MT8189 mfg"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this option to support the manufacturing clocks for the MediaTek
+	  MT8189 chipset. This driver provides the necessary clock framework
+	  integration for manufacturing tests and operations that are specific to
+	  the MT8189 chipset. Enabling this will allow the manufacturing mode of
+	  the chipset to function correctly with the appropriate clock settings.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 9b23e4c5e019..07f11760cf68 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IMG) += clk-mt8189-img.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MDPSYS) += clk-mt8189-mdpsys.o
+obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-mfg.c b/drivers/clk/mediatek/clk-mt8189-mfg.c
new file mode 100644
index 000000000000..a09bf8f2e017
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-mfg.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs mfg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MFG(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)
+
+static const struct mtk_gate mfg_clks[] = {
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel_mfgpll", 0),
+};
+
+static const struct mtk_clk_desc mfg_mcd = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_mfg[] = {
+	{ .compatible = "mediatek,mt8189-mfgcfg", .data = &mfg_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_mfg);
+
+static struct platform_driver clk_mt8189_mfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-mfg",
+		.of_match_table = of_match_clk_mt8189_mfg,
+	},
+};
+
+module_platform_driver(clk_mt8189_mfg_drv);
+MODULE_DESCRIPTION("MediaTek MT8189 mfg clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


