Return-Path: <linux-pm+bounces-35381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D2BA007B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF84A76CE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90492DECBA;
	Thu, 25 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fo2vlmX4"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4112DC353;
	Thu, 25 Sep 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810696; cv=none; b=mxOJLnsiTouOT/IFOvXha4/GFYYVCWfeNqNqt9q5DKHrZ7xC5bvV2+FGZvGUSuJazaC6E2j6TTeb/1AL5IqBCOmzgVK9C5etlMWkyCMSCPvDRHr5nYROcvfxToNDEwC7zoZ5oOlH+Gh6NgBeqcFdEA3ya4COjjOTi8payKo9KDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810696; c=relaxed/simple;
	bh=/znEDOpCCt5yuHnPOnm5XVsVGFaByYXeLMMEMygmgrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVV4sEtVRUihuPjOxLmsLSfNHNgqkRHPjroAnWfwDo0KunkNn/ggXKWby8Vx8Gv37OuiMu1V528AEuzKveINZpjQkxv0/Qxg5USSHmZonj0OmSKKIQnOA1+DmP4YoKrlttq4e2H7pKUwhbg1HO+mVGE7jlsG7yPm9Mj9GxU0+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fo2vlmX4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758810692;
	bh=/znEDOpCCt5yuHnPOnm5XVsVGFaByYXeLMMEMygmgrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fo2vlmX46QmZZrMk8OjxvTPtLfzgotboREWzFXjrmIl/XCOREkkQ2jPE2gp0X+yr+
	 f7D6bwNsEC0ttqJev8X0PDuQdCHlCl7K5C1RuVk9/v0Vxicys7QeTL2PKmKuJRHGYh
	 lIcWJxtkvfjhQKJ9oya0PP7K9KZA6zEMOamoFG3Hbela6EBEMy2EpDQXMRTCbghlQZ
	 8Fdlv1xT5sO+97XmtdWjo7WigAdtrB6MiYbzvnYIXvkRGdcDrDSsHnHfXzMCvRXxoh
	 RvXvAbtSjPY5Dk0WjSFbb6FrnvXqkjlPPX3pTkeWtt3Cmd2gjwlZbvPlLAr2ei6LTv
	 INnDaXE77+qNA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D3E4F17E13D5;
	Thu, 25 Sep 2025 16:31:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	fshao@chromium.org,
	y.oudjana@protonmail.com,
	wenst@chromium.org,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 4/5] pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
Date: Thu, 25 Sep 2025 16:31:15 +0200
Message-ID: <20250925143122.39796-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
References: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new SPM bus protection block and add support for both the
direct control and HW Voter control SCPSYS power domains found
in the MT8196 and MT6991 SoCs.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 386 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  18 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |   3 +
 3 files changed, 404 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8196-pm-domains.h

diff --git a/drivers/pmdomain/mediatek/mt8196-pm-domains.h b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
new file mode 100644
index 000000000000..ce8d594c46f8
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __SOC_MEDIATEK_MT8196_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8196_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt8196-power.h>
+
+/*
+ * MT8196 and MT6991 power domain support
+ */
+
+/* INFRA TOP_AXI registers */
+#define MT8196_TOP_AXI_PROT_EN_SET		0x4
+#define MT8196_TOP_AXI_PROT_EN_CLR		0x8
+#define MT8196_TOP_AXI_PROT_EN_STA		0xc
+ #define MT8196_TOP_AXI_PROT_EN_SLEEP0_MD	BIT(29)
+
+#define MT8196_TOP_AXI_PROT_EN_1_SET		0x24
+#define MT8196_TOP_AXI_PROT_EN_1_CLR		0x28
+#define MT8196_TOP_AXI_PROT_EN_1_STA		0x2c
+ #define MT8196_TOP_AXI_PROT_EN_1_SLEEP1_MD	BIT(0)
+
+/* SPM BUS_PROTECT registers */
+#define MT8196_SPM_BUS_PROTECT_CON_SET		0xdc
+#define MT8196_SPM_BUS_PROTECT_CON_CLR		0xe0
+#define MT8196_SPM_BUS_PROTECT_RDY		0x208
+ #define MT8196_SPM_PROT_EN_BUS_CONN		BIT(1)
+ #define MT8196_SPM_PROT_EN_BUS_SSUSB_DP_PHY_P0	BIT(6)
+ #define MT8196_SPM_PROT_EN_BUS_SSUSB_P0	BIT(7)
+ #define MT8196_SPM_PROT_EN_BUS_SSUSB_P1	BIT(8)
+ #define MT8196_SPM_PROT_EN_BUS_SSUSB_P23	BIT(9)
+ #define MT8196_SPM_PROT_EN_BUS_SSUSB_PHY_P2	BIT(10)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_MAC0	BIT(13)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_MAC1	BIT(14)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_MAC2	BIT(15)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_PHY0	BIT(16)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_PHY1	BIT(17)
+ #define MT8196_SPM_PROT_EN_BUS_PEXTP_PHY2	BIT(18)
+ #define MT8196_SPM_PROT_EN_BUS_AUDIO		BIT(19)
+ #define MT8196_SPM_PROT_EN_BUS_ADSP_TOP	BIT(21)
+ #define MT8196_SPM_PROT_EN_BUS_ADSP_INFRA	BIT(22)
+ #define MT8196_SPM_PROT_EN_BUS_ADSP_AO		BIT(23)
+ #define MT8196_SPM_PROT_EN_BUS_MM_PROC		BIT(24)
+
+/* PWR_CON registers */
+#define MT8196_PWR_ACK				BIT(30)
+#define MT8196_PWR_ACK_2ND			BIT(31)
+
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8196[] = {
+	BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_SPM
+};
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8196[] = {
+	[MT8196_POWER_DOMAIN_MD] = {
+		.name = "md",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe00,
+		.pwr_sta_offs = 0xe00,
+		.pwr_sta2nd_offs = 0xe00,
+		.ext_buck_iso_offs = 0xefc,
+		.ext_buck_iso_mask = GENMASK(1, 0),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8196_TOP_AXI_PROT_EN_SLEEP0_MD,
+					MT8196_TOP_AXI_PROT_EN_SET,
+					MT8196_TOP_AXI_PROT_EN_CLR,
+					MT8196_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(INFRA, MT8196_TOP_AXI_PROT_EN_1_SLEEP1_MD,
+					MT8196_TOP_AXI_PROT_EN_1_SET,
+					MT8196_TOP_AXI_PROT_EN_1_CLR,
+					MT8196_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_MODEM_PWRSEQ | MTK_SCPD_EXT_BUCK_ISO |
+			MTK_SCPD_SKIP_RESET_B | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8196_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe04,
+		.pwr_sta_offs = 0xe04,
+		.pwr_sta2nd_offs = 0xe04,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_CONN,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_SSUSB_DP_PHY_P0] = {
+		.name = "ssusb-dp-phy-p0",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe18,
+		.pwr_sta_offs = 0xe18,
+		.pwr_sta2nd_offs = 0xe18,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_SSUSB_DP_PHY_P0,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_ALWAYS_ON,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_SSUSB_P0] = {
+		.name = "ssusb-p0",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe1c,
+		.pwr_sta_offs = 0xe1c,
+		.pwr_sta2nd_offs = 0xe1c,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_SSUSB_P0,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_ALWAYS_ON,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_SSUSB_P1] = {
+		.name = "ssusb-p1",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe20,
+		.pwr_sta_offs = 0xe20,
+		.pwr_sta2nd_offs = 0xe20,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_SSUSB_P1,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_ALWAYS_ON,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_SSUSB_P23] = {
+		.name = "ssusb-p23",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe24,
+		.pwr_sta_offs = 0xe24,
+		.pwr_sta2nd_offs = 0xe24,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_SSUSB_P23,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_SSUSB_PHY_P2] = {
+		.name = "ssusb-phy-p2",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe28,
+		.pwr_sta_offs = 0xe28,
+		.pwr_sta2nd_offs = 0xe28,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_SSUSB_PHY_P2,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_MAC0] = {
+		.name = "pextp-mac0",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe34,
+		.pwr_sta_offs = 0xe34,
+		.pwr_sta2nd_offs = 0xe34,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_MAC0,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_MAC1] = {
+		.name = "pextp-mac1",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe38,
+		.pwr_sta_offs = 0xe38,
+		.pwr_sta2nd_offs = 0xe38,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_MAC1,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_MAC2] = {
+		.name = "pextp-mac2",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe3c,
+		.pwr_sta_offs = 0xe3c,
+		.pwr_sta2nd_offs = 0xe3c,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_MAC2,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_PHY0] = {
+		.name = "pextp-phy0",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe40,
+		.pwr_sta_offs = 0xe40,
+		.pwr_sta2nd_offs = 0xe40,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_PHY0,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_PHY1] = {
+		.name = "pextp-phy1",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe44,
+		.pwr_sta_offs = 0xe44,
+		.pwr_sta2nd_offs = 0xe44,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_PHY1,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_PEXTP_PHY2] = {
+		.name = "pextp-phy2",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe48,
+		.pwr_sta_offs = 0xe48,
+		.pwr_sta2nd_offs = 0xe48,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_PEXTP_PHY2,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_PCIE_PHY,
+	},
+	[MT8196_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe4c,
+		.pwr_sta_offs = 0xe4c,
+		.pwr_sta2nd_offs = 0xe4c,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_AUDIO,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT] = {
+		.name = "adsp-top-dormant",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe54,
+		.pwr_sta_offs = 0xe54,
+		.pwr_sta2nd_offs = 0xe54,
+		/* Note: This is not managing powerdown (pdn), but sleep instead (slp) */
+		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = BIT(13),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_ADSP_TOP,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED,
+	},
+	[MT8196_POWER_DOMAIN_ADSP_INFRA] = {
+		.name = "adsp-infra",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe58,
+		.pwr_sta_offs = 0xe58,
+		.pwr_sta2nd_offs = 0xe58,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_ADSP_INFRA,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_ALWAYS_ON,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+	[MT8196_POWER_DOMAIN_ADSP_AO] = {
+		.name = "adsp-ao",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0xe5c,
+		.pwr_sta_offs = 0xe5c,
+		.pwr_sta2nd_offs = 0xe5c,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(SPM, MT8196_SPM_PROT_EN_BUS_ADSP_AO,
+					MT8196_SPM_BUS_PROTECT_CON_SET,
+					MT8196_SPM_BUS_PROTECT_CON_CLR,
+					MT8196_SPM_BUS_PROTECT_RDY),
+		},
+		.caps = MTK_SCPD_ALWAYS_ON,
+		.rtff_type = SCPSYS_RTFF_TYPE_GENERIC,
+	},
+};
+
+static const struct scpsys_hwv_domain_data scpsys_hwv_domain_data_mt8196[] = {
+	[MT8196_POWER_DOMAIN_MM_PROC_DORMANT] = {
+		.name = "mm-proc-dormant",
+		.set = 0x0218,
+		.clr = 0x021c,
+		.done = 0x141c,
+		.en = 0x1410,
+		.set_sta = 0x146c,
+		.clr_sta = 0x1470,
+		.setclr_bit = 0,
+		.caps = MTK_SCPD_ALWAYS_ON,
+	},
+	[MT8196_POWER_DOMAIN_SSR] = {
+		.name = "ssrsys",
+		.set = 0x0218,
+		.clr = 0x021c,
+		.done = 0x141c,
+		.en = 0x1410,
+		.set_sta = 0x146c,
+		.clr_sta = 0x1470,
+		.setclr_bit = 1,
+	},
+};
+
+static const struct scpsys_soc_data mt8196_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8196,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8196),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8196,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8196),
+	.type = SCPSYS_MTCMOS_TYPE_DIRECT_CTL,
+};
+
+static const struct scpsys_soc_data mt8196_scpsys_hwv_data = {
+	.hwv_domains_data = scpsys_hwv_domain_data_mt8196,
+	.num_hwv_domains = ARRAY_SIZE(scpsys_hwv_domain_data_mt8196),
+	.type = SCPSYS_MTCMOS_TYPE_HW_VOTER,
+};
+
+#endif /* __SOC_MEDIATEK_MT8196_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f400b0c6b5fd..18f0b9b960d9 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -27,6 +27,7 @@
 #include "mt8188-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
+#include "mt8196-pm-domains.h"
 #include "mt8365-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
@@ -81,13 +82,16 @@ struct scpsys {
 static bool scpsys_domain_is_on(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
-	u32 status, status2;
+	u32 mask = pd->data->sta_mask;
+	u32 status, status2, mask2;
+
+	mask2 = pd->data->sta2nd_mask ? pd->data->sta2nd_mask : mask;
 
 	regmap_read(scpsys->base, pd->data->pwr_sta_offs, &status);
-	status &= pd->data->sta_mask;
+	status &= mask;
 
 	regmap_read(scpsys->base, pd->data->pwr_sta2nd_offs, &status2);
-	status2 &= pd->data->sta_mask;
+	status2 &= mask2;
 
 	/* A domain is on when both status bits are set. */
 	return status && status2;
@@ -1150,6 +1154,14 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8195-power-controller",
 		.data = &mt8195_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8196-power-controller",
+		.data = &mt8196_scpsys_data,
+	},
+	{
+		.compatible = "mediatek,mt8196-hwv-scp-power-controller",
+		.data = &mt8196_scpsys_hwv_data,
+	},
 	{
 		.compatible = "mediatek,mt8365-power-controller",
 		.data = &mt8365_scpsys_data,
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 36adcfca80c6..f608e6ec4744 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -62,6 +62,7 @@ enum scpsys_bus_prot_block {
 	BUS_PROT_BLOCK_INFRA,
 	BUS_PROT_BLOCK_INFRA_NAO,
 	BUS_PROT_BLOCK_SMI,
+	BUS_PROT_BLOCK_SPM,
 	BUS_PROT_BLOCK_COUNT,
 };
 
@@ -143,6 +144,7 @@ enum scpsys_mtcmos_type {
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @name: The name of the power domain.
  * @sta_mask: The mask for power on/off status bit.
+ * @sta2nd_mask: The mask for second power on/off status bit.
  * @ctl_offs: The offset for main power control register.
  * @sram_pdn_bits: The mask for sram power control bits.
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
@@ -155,6 +157,7 @@ enum scpsys_mtcmos_type {
 struct scpsys_domain_data {
 	const char *name;
 	u32 sta_mask;
+	u32 sta2nd_mask;
 	int ctl_offs;
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
-- 
2.51.0


