Return-Path: <linux-pm+bounces-25120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAFA8468D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6627B4ED1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9528D85C;
	Thu, 10 Apr 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ggw3KOpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2528D827;
	Thu, 10 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296001; cv=none; b=IyoX3yewsJ4GvT5KBNEJuQdAzbZQjNzCtdYjtrfyfua0Ue/B483YtkxkdAZP5UvTRSUD1+oTpkagnHLTuiAFOeghgs8+3OYXr3Tn0paV8yowyv08H5hnMP7DX2zysJ6nwwuxyr+7xGoirDOd9wO2SWbrIH/PQ8A+c8pkasRRuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296001; c=relaxed/simple;
	bh=wvUSNSoZ8pJi4ykMHP3xo96tkZFq+NkEiGppS8pl5I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4R+Z7JrqCigo7SkTNySiuFe2I1Z4OSAxdKq8d9Tzl9tF2hoO40MB/y2OtJ8j9zF8iwVGNemo9lpMezVDu89GQuUVuhVrHSsFEcUPV/RzEFGRqUqk710fGXpKKN5w6YqGNJ00tKXyTG4u49dSzFrHsyMthOnu9CeQq9GyJLc+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ggw3KOpe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744295996;
	bh=wvUSNSoZ8pJi4ykMHP3xo96tkZFq+NkEiGppS8pl5I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ggw3KOpe5YjgdoTRaF9gFxRTZjoWQoTOmVXDpgVzGBy2w0S7fl7LjapLha38b5IMk
	 odJD9SU8IszBkSz9uGzvdzgZ7xWduvX/W8IDsmIcx96BqUIaD+iH8GIUB0L6Ccv39f
	 wHXFye9KNfRx1dA/ZsNdpucDWuvwk9cvSMWj5PGMnvyP2bjeOIaC+IMH4Hg7Gc5dZa
	 55VREMplRNiagqVLhQ94l27ltAjSa2uMt9BSbt2+p0lq3+Ke6Awpk3iTC65Ni70QxX
	 wH5T7iguc4A4Kllm1XeYTSWIAVM3fbKNfwPSZ24ZX/kem3oDWzFn1vo0BIKNlXz765
	 KgEb5WnwFMtJg==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 544CB17E1072;
	Thu, 10 Apr 2025 16:39:55 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 3/3] pmdomain: mediatek: Add support for Dimensity 1200 MT6893
Date: Thu, 10 Apr 2025 16:39:44 +0200
Message-ID: <20250410143944.475773-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domains definitions to implement support for the
MediaTek Dimensity 1200 (MT6893) SoC.

Since this chip's MTCMOS are similar to the ones of Kompanio
820 (MT8192), the definitions from that have been reused where
possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt6893-pm-domains.h | 585 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
 2 files changed, 590 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/mt6893-pm-domains.h

diff --git a/drivers/pmdomain/mediatek/mt6893-pm-domains.h b/drivers/pmdomain/mediatek/mt6893-pm-domains.h
new file mode 100644
index 000000000000..5baa965d22da
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt6893-pm-domains.h
@@ -0,0 +1,585 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H
+#define __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H
+
+#include <linux/soc/mediatek/infracfg.h>
+#include <dt-bindings/power/mediatek,mt6893-power.h>
+#include "mtk-pm-domains.h"
+
+#define MT6893_TOP_AXI_PROT_EN_MCU_STA1				0x2e4
+#define MT6893_TOP_AXI_PROT_EN_MCU_SET				0x2c4
+#define MT6893_TOP_AXI_PROT_EN_MCU_CLR				0x2c8
+#define MT6893_TOP_AXI_PROT_EN_VDNR_1_SET			0xba4
+#define MT6893_TOP_AXI_PROT_EN_VDNR_1_CLR			0xba8
+#define MT6893_TOP_AXI_PROT_EN_VDNR_1_STA1			0xbb0
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET		0xbb8
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR		0xbbc
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1		0xbc4
+
+#define MT6893_TOP_AXI_PROT_EN_1_MFG1_STEP1			GENMASK(21, 19)
+#define MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP2			GENMASK(6, 5)
+#define MT6893_TOP_AXI_PROT_EN_MFG1_STEP3			GENMASK(22, 21)
+#define MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP4			BIT(7)
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP5	GENMASK(19, 17)
+#define MT6893_TOP_AXI_PROT_EN_MM_VDEC0_STEP1			BIT(24)
+#define MT6893_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2			BIT(25)
+#define MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP1			BIT(6)
+#define MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP2			BIT(7)
+#define MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP1			BIT(26)
+#define MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP2			BIT(0)
+#define MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP3			BIT(27)
+#define MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP4			BIT(1)
+#define MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP1			GENMASK(30, 28)
+#define MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP2			GENMASK(31, 29)
+#define MT6893_TOP_AXI_PROT_EN_MDP_STEP1			BIT(10)
+#define MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP2			(BIT(2) | BIT(4) | BIT(6) |	\
+								 BIT(8) | BIT(18) | BIT(22) |	\
+								 BIT(28) | BIT(30))
+#define MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP3			(BIT(0) | BIT(2) | BIT(4) |	\
+								 BIT(6) | BIT(8))
+#define MT6893_TOP_AXI_PROT_EN_MDP_STEP4			BIT(23)
+#define MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP5			(BIT(3) | BIT(5) | BIT(7) |	\
+								 BIT(9) | BIT(19) | BIT(23) |	\
+								 BIT(29) | BIT(31))
+#define MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP6			(BIT(1) | BIT(7) | BIT(9) | BIT(11))
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MDP_STEP7		BIT(20)
+#define MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP1			(BIT(0) | BIT(6) | BIT(8) |	\
+								 BIT(10) | BIT(12) | BIT(14) |	\
+								 BIT(16) | BIT(20) | BIT(24) |	\
+								 BIT(26))
+#define MT6893_TOP_AXI_PROT_EN_DISP_STEP2			BIT(6)
+#define MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP3			(BIT(1) | BIT(7) | BIT(9) |	\
+								 BIT(15) | BIT(17) | BIT(21) |	\
+								 BIT(25) | BIT(27))
+#define MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_DISP_STEP4	BIT(21)
+#define MT6893_TOP_AXI_PROT_EN_2_ADSP				BIT(3)
+#define MT6893_TOP_AXI_PROT_EN_2_CAM_STEP1			BIT(1)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP2			(BIT(0) | BIT(2) | BIT(4))
+#define MT6893_TOP_AXI_PROT_EN_1_CAM_STEP3			BIT(22)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP4			(BIT(1) | BIT(3) | BIT(5))
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP1		BIT(18)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP2		BIT(19)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP1		BIT(20)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP2		BIT(21)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP1		BIT(22)
+#define MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP2		BIT(23)
+
+/*
+ * MT6893 Power Domain (MTCMOS) support
+ *
+ * The register layout for this IP is very similar to MT8192 so where possible
+ * the same definitions are reused to avoid duplication.
+ * Where the bus protection bits are also the same, the entire set is reused.
+ */
+static const struct scpsys_domain_data scpsys_domain_data_mt6893[] = {
+	[MT6893_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x304,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_CONN,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_CONN_2ND,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_1_CONN,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x308,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT6893_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_1_MFG1_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MFG1_STEP3,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP5,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT6893_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x310,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x314,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MFG4] = {
+		.name = "mfg4",
+		.sta_mask = BIT(6),
+		.ctl_offs = 0x318,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MFG5] = {
+		.name = "mfg5",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x31c,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MFG6] = {
+		.name = "mfg6",
+		.sta_mask = BIT(8),
+		.ctl_offs = 0x320,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x330,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_ISP_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_ISP2] = {
+		.name = "isp2",
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x334,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_ISP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_ISP2_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_IPE] = {
+		.name = "ipe",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x338,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_IPE,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_MM_IPE_2ND,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_VDEC0] = {
+		.name = "vdec0",
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x33c,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_VDEC1] = {
+		.name = "vdec1",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x340,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_VENC0] = {
+		.name = "venc0",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x344,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VENC0_STEP3,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_2_VENC0_STEP4,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_VENC1] = {
+		.name = "venc1",
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x348,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_VENC1_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT6893_POWER_DOMAIN_MDP] = {
+		.name = "mdp",
+		.sta_mask = BIT(19),
+		.ctl_offs = 0x34c,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MDP_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP3,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MDP_STEP4,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_MDP_STEP5,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_2_MDP_STEP6,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MDP_STEP7,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x350,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_DISP_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_SET,
+				    MT8192_TOP_AXI_PROT_EN_CLR,
+				    MT8192_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_DISP_STEP3,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_DISP_STEP4,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT6893_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x354,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT8192_TOP_AXI_PROT_EN_2_AUDIO,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_ADSP] = {
+		.name = "audio",
+		.sta_mask = BIT(22),
+		.ctl_offs = 0x358,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_2_ADSP,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x35c,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_2_CAM_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_2_SET,
+				    MT8192_TOP_AXI_PROT_EN_2_CLR,
+				    MT8192_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_1_CAM_STEP3,
+				    MT8192_TOP_AXI_PROT_EN_1_SET,
+				    MT8192_TOP_AXI_PROT_EN_1_CLR,
+				    MT8192_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_STEP4,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_CAM_RAWA] = {
+		.name = "cam_rawa",
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x360,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWA_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_CAM_RAWB] = {
+		.name = "cam_rawb",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x364,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWB_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_CAM_RAWC] = {
+		.name = "cam_rawc",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x368,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP1,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(INFRA,
+				    MT6893_TOP_AXI_PROT_EN_MM_CAM_RAWC_STEP2,
+				    MT8192_TOP_AXI_PROT_EN_MM_SET,
+				    MT8192_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8192_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT6893_POWER_DOMAIN_DP_TX] = {
+		.name = "dp_tx",
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x3ac,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+};
+
+static const struct scpsys_soc_data mt6893_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt6893,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6893),
+};
+
+#endif /* __PMDOMAIN_MEDIATEK_MT6893_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index b866b006af69..9a33321d9fac 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -18,6 +18,7 @@
 
 #include "mt6735-pm-domains.h"
 #include "mt6795-pm-domains.h"
+#include "mt6893-pm-domains.h"
 #include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
@@ -617,6 +618,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt6795-power-controller",
 		.data = &mt6795_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt6893-power-controller",
+		.data = &mt6893_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8167-power-controller",
 		.data = &mt8167_scpsys_data,
-- 
2.49.0


