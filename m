Return-Path: <linux-pm+bounces-37518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2BC3AF72
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38D53BECD9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7125333434;
	Thu,  6 Nov 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WRfoNZuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CD32E739;
	Thu,  6 Nov 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433032; cv=none; b=qDCOCmB8my7TT2ZYw8gTn3qc7AqDXQxJeesvOx3HOCBu9woM3kJ0WScOhb/4xqpvCOT+KUoS4HdCckYPDDOvnY1uNj0PbpRBkUMf6L4eO48hZKFnoiVtUpmOctYXcVFz7Y3NX+MslkC7bzTsch2JHadyjWZPYNskyklkXlg+RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433032; c=relaxed/simple;
	bh=qMLuPn1qYQzzIpbecNHD8jIgpEuMtDfmOd/8aEmlg6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0p7GUkWRnvXJot5+jQukyuF4EAm66qz46tLKln69fUlM02MfwcEhLScs38Te1wXbNOQwHyNqImkvK+rRCDABbq+AiOZ9XvsKyVT37yKh8RJ3PeJArJGmSg7ST/94QGoalzukYXIbpMogK/0dL9ifKB8UroxwY15yl0RApWyjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WRfoNZuQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 394bf240bb0e11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kh0LsKi37vUlol+pGbo9Xy1GjmojdPqAYTHASgGHVf4=;
	b=WRfoNZuQQgUjZt0e1dAiO1iFOWpNvT4i11xNngE81aRraePaGeRD0nJM3laCiLsOc5rSNZ3I0aPAQlKLegMXBAjCSmTsRYSTcdAn0R+unwtf+S2aykRO451/0D2JEu9SZYzIb/8ex9G6TYkOOGjmjcI+x+HGHNJSZCobjEbvhb4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f1452f8a-cd68-4fab-a868-72dbe2e66fb9,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-50
X-CID-META: VersionHash:a9d874c,CLOUDID:e813fc7c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 394bf240bb0e11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1744521212; Thu, 06 Nov 2025 20:43:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 20:43:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 20:43:39 +0800
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
Subject: [PATCH v3 19/21] clk: mediatek: Add MT8189 vcodec clock support
Date: Thu, 6 Nov 2025 20:42:04 +0800
Message-ID: <20251106124330.1145600-20-irving-ch.lin@mediatek.com>
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

Add support for the MT8189 vcodec clock controller,
which provides clock gate control for video encoder/decoder.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig             |  10 +++
 drivers/clk/mediatek/Makefile            |   1 +
 drivers/clk/mediatek/clk-mt8189-vcodec.c | 108 +++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8189-vcodec.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 3ef964b19d97..2ae5966d4c56 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -951,6 +951,16 @@ config COMMON_CLK_MT8189_UFS
 	  option if the system includes a UFS device that relies on the MT8189
 	  SoC for clock management.
 
+config COMMON_CLK_MT8189_VCODEC
+	tristate "Clock driver for MediaTek MT8189 vcodec"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  This driver supports the video codec (VCODEC) clocks on the MediaTek
+	  MT8189 SoCs. Enabling this option will allow the system to manage
+	  clocks required for the operation of hardware video encoding and
+	  decoding features provided by the VCODEC unit of the MT8189 platform.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 4179808dba7b..614371c92e81 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_MFG) += clk-mt8189-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8189_MMSYS) += clk-mt8189-dispsys.o
 obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
 obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
+obj-$(CONFIG_COMMON_CLK_MT8189_VCODEC) += clk-mt8189-vcodec.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-vcodec.c b/drivers/clk/mediatek/clk-mt8189-vcodec.c
new file mode 100644
index 000000000000..56f135e104df
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vcodec.c
@@ -0,0 +1,108 @@
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
+static const struct mtk_gate_regs vdec_core0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vdec_core1_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDEC_CORE0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vdec_core0_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+#define GATE_VDEC_CORE1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &vdec_core1_cg_regs,		\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate vdec_core_clks[] = {
+	/* VDEC_CORE0 */
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_CKEN, "vdec_core_vdec_cken", "vdec_sel", 0),
+	GATE_VDEC_CORE0(CLK_VDEC_CORE_VDEC_ACTIVE, "vdec_core_vdec_active", "vdec_sel", 4),
+	/* VDEC_CORE1 */
+	GATE_VDEC_CORE1(CLK_VDEC_CORE_LARB_CKEN, "vdec_core_larb_cken", "vdec_sel", 0),
+};
+
+static const struct mtk_clk_desc vdec_core_mcd = {
+	.clks = vdec_core_clks,
+	.num_clks = ARRAY_SIZE(vdec_core_clks),
+};
+
+static const struct mtk_gate_regs ven1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VEN1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ven1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr_inv,	\
+		.flags = CLK_OPS_PARENT_ENABLE | CLK_IGNORE_UNUSED,	\
+	}
+
+static const struct mtk_gate ven1_clks[] = {
+	GATE_VEN1(CLK_VEN1_CKE0_LARB, "ven1_larb", "venc_sel", 0),
+	GATE_VEN1(CLK_VEN1_CKE1_VENC, "ven1_venc", "venc_sel", 4),
+	GATE_VEN1(CLK_VEN1_CKE2_JPGENC, "ven1_jpgenc", "venc_sel", 8),
+	GATE_VEN1(CLK_VEN1_CKE3_JPGDEC, "ven1_jpgdec", "venc_sel", 12),
+	GATE_VEN1(CLK_VEN1_CKE4_JPGDEC_C1, "ven1_jpgdec_c1", "venc_sel", 16),
+	GATE_VEN1(CLK_VEN1_CKE5_GALS, "ven1_gals", "venc_sel", 28),
+	GATE_VEN1(CLK_VEN1_CKE6_GALS_SRAM, "ven1_gals_sram", "venc_sel", 31),
+};
+
+static const struct mtk_clk_desc ven1_mcd = {
+	.clks = ven1_clks,
+	.num_clks = ARRAY_SIZE(ven1_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_vcodec[] = {
+	{ .compatible = "mediatek,mt8189-vdec-core", .data = &vdec_core_mcd },
+	{ .compatible = "mediatek,mt8189-venc", .data = &ven1_mcd },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8189_vcodec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8189-vcodec",
+		.of_match_table = of_match_clk_mt8189_vcodec,
+	},
+};
+
+module_platform_driver(clk_mt8189_vcodec_drv);
+MODULE_LICENSE("GPL");
-- 
2.45.2


