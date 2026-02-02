Return-Path: <linux-pm+bounces-41879-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHvFLeRIgGnC5gIAu9opvQ
	(envelope-from <linux-pm+bounces-41879-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 07:49:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A7C8F2E
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 07:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DAEE301456C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63F30B50A;
	Mon,  2 Feb 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WSqhJBRF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEB2F90C4;
	Mon,  2 Feb 2026 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014916; cv=none; b=g7POwIxiE0DctcQX4Br3wrSuoeVR54K2rNZ+t+PbdXU6Z94zutlSsVNPzfCPxZBKBieoplXD4CR3Wj7MjwOK48m/wVaczRbT2k5DzVnHrZqLrfhl4moe23rR6L6MPgDk7fK0u6PGn5hNgue76S3hDbj6Aa7Is3vVMYEXnjDG9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014916; c=relaxed/simple;
	bh=pu4rCZig85vET5et3PP75U5/i510XLKE/Mb2CwBrfjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik56VyFVdvlI1IrbPuWxjuycAOtshfhv2jKWbZMB90pUTzie0TgoNyLtWivNOKWJ0x+IRsJvuzGizWHmlOAFzleq+YMLdVSL0e1Xp3gEO/zDJ6JWw0AIgLOUAZAqxR5bHaYDnkTYV7fRV7Dzdl1fsjjabrATqjBqfXxht964orY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WSqhJBRF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2bd37c7a000311f1b7fc4fdb8733b2bc-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6WNKW5goEwaRlHDoKmv4Vl+byjPHj/KUF5mZ0U/9vLE=;
	b=WSqhJBRFKvG6RP03oZxgEdQNkAZV6sADZsr6a4DKu7ktpSskdeQ7Haa3qJKgpY7mMbZAxKHqKH8eFonGRCJ/2Dap4wW/AR/kztpGTtEBWGh1PHMa2FjMRNBaz9jW/8nhW+CgN3sKiDLNCoelBiF0/+DCGTiNQUht3aKBLvSvX+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:4cd3464b-07eb-49ac-99a4-d28cf43bcd6f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:a20939f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2bd37c7a000311f1b7fc4fdb8733b2bc-20260202
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 748384559; Mon, 02 Feb 2026 14:48:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 14:48:22 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 14:48:22 +0800
From: irving.ch.lin <irving-ch.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <mbrugger@suse.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Qiqi Wang
	<qiqi.wang@mediatek.com>, <sirius.wang@mediatek.com>,
	<vince-wl.liu@mediatek.com>, <jh.hsu@mediatek.com>,
	<irving-ch.lin@mediatek.com>
Subject: [PATCH 3/3] pmdomain: mediatek: Add power domain driver for MT8189 SoC
Date: Mon, 2 Feb 2026 14:48:15 +0800
Message-ID: <20260202064820.347550-4-irving-ch.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41879-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irving-ch.lin@mediatek.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mediatek.com:dkim,mediatek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A9A7C8F2E
X-Rspamd-Action: no action

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
This driver ports and refines the power domain framework, dividing
hardware blocks (CPU, GPU, peripherals, etc.) into independent power
domains for precise and energy-efficient power management.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/pmdomain/mediatek/mt8189-pm-domains.h | 485 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
 2 files changed, 490 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h

diff --git a/drivers/pmdomain/mediatek/mt8189-pm-domains.h b/drivers/pmdomain/mediatek/mt8189-pm-domains.h
new file mode 100644
index 000000000000..c28b9460c074
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt8189-pm-domains.h
@@ -0,0 +1,485 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef __SOC_MEDIATEK_MT8189_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8189_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt8189-power.h>
+
+/*
+ * MT8189 power domain support
+ */
+
+#define MT8189_SPM_PWR_STATUS				0x0f40
+#define MT8189_SPM_PWR_STATUS_2ND			0x0f44
+#define MT8189_SPM_PWR_STATUS_MSB			0x0f48
+#define MT8189_SPM_PWR_STATUS_MSB_2ND			0x0f4c
+#define MT8189_SPM_XPU_PWR_STATUS			0x0f50
+#define MT8189_SPM_XPU_PWR_STATUS_2ND			0x0f54
+
+#define MT8189_PROT_EN_EMICFG_GALS_SLP_SET		0x0084
+#define MT8189_PROT_EN_EMICFG_GALS_SLP_CLR		0x0088
+#define MT8189_PROT_EN_EMICFG_GALS_SLP_RDY		0x008c
+#define MT8189_PROT_EN_MMSYS_STA_0_SET			0x0c14
+#define MT8189_PROT_EN_MMSYS_STA_0_CLR			0x0c18
+#define MT8189_PROT_EN_MMSYS_STA_0_RDY			0x0c1c
+#define MT8189_PROT_EN_MMSYS_STA_1_SET			0x0c24
+#define MT8189_PROT_EN_MMSYS_STA_1_CLR			0x0c28
+#define MT8189_PROT_EN_MMSYS_STA_1_RDY			0x0c2c
+#define MT8189_PROT_EN_INFRASYS_STA_0_SET		0x0c44
+#define MT8189_PROT_EN_INFRASYS_STA_0_CLR		0x0c48
+#define MT8189_PROT_EN_INFRASYS_STA_0_RDY		0x0c4c
+#define MT8189_PROT_EN_INFRASYS_STA_1_SET		0x0c54
+#define MT8189_PROT_EN_INFRASYS_STA_1_CLR		0x0c58
+#define MT8189_PROT_EN_INFRASYS_STA_1_RDY		0x0c5c
+#define MT8189_PROT_EN_PERISYS_STA_0_SET		0x0c84
+#define MT8189_PROT_EN_PERISYS_STA_0_CLR		0x0c88
+#define MT8189_PROT_EN_PERISYS_STA_0_RDY		0x0c8c
+#define MT8189_PROT_EN_MCU_STA_0_SET			0x0c94
+#define MT8189_PROT_EN_MCU_STA_0_CLR			0x0c98
+#define MT8189_PROT_EN_MCU_STA_0_RDY			0x0c9c
+#define MT8189_PROT_EN_MD_STA_0_SET			0x0ca4
+#define MT8189_PROT_EN_MD_STA_0_CLR			0x0ca8
+#define MT8189_PROT_EN_MD_STA_0_RDY			0x0cac
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
+#define MT8189_PROT_EN_EMICFG_GALS_SLP_MFG1		(GENMASK(5, 4))
+
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8189[] = {
+	BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_SMI
+};
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8189[] = {
+	[MT8189_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0xe04,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MCU_STA_0_CONN,
+					MT8189_PROT_EN_MCU_STA_0_SET,
+					MT8189_PROT_EN_MCU_STA_0_CLR,
+					MT8189_PROT_EN_MCU_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_INFRASYS_STA_1_CONN,
+					MT8189_PROT_EN_INFRASYS_STA_1_SET,
+					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
+					MT8189_PROT_EN_MCU_STA_0_SET,
+					MT8189_PROT_EN_MCU_STA_0_CLR,
+					MT8189_PROT_EN_MCU_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_INFRASYS_STA_0_CONN,
+					MT8189_PROT_EN_INFRASYS_STA_0_SET,
+					MT8189_PROT_EN_INFRASYS_STA_0_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_0_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = BIT(6),
+		.ctl_offs = 0xe18,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
+					MT8189_PROT_EN_PERISYS_STA_0_SET,
+					MT8189_PROT_EN_PERISYS_STA_0_CLR,
+					MT8189_PROT_EN_PERISYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT] = {
+		.name = "adsp-top-dormant",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0xe1c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = BIT(13),
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED |
+			MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_INFRA] = {
+		.name = "adsp-infra",
+		.sta_mask = BIT(8),
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.ctl_offs = 0xe20,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ADSP_AO] = {
+		.name = "adsp-ao",
+		.sta_mask = BIT(9),
+		.ctl_offs = 0xe24,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG1] = {
+		.name = "isp-img1",
+		.sta_mask = BIT(10),
+		.ctl_offs = 0xe28,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IMG2] = {
+		.name = "isp-img2",
+		.sta_mask = BIT(11),
+		.ctl_offs = 0xe2c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_ISP_IPE] = {
+		.name = "isp-ipe",
+		.sta_mask = BIT(12),
+		.ctl_offs = 0xe30,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_VDE0] = {
+		.name = "vde0",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0xe38,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_VDE0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_VDE0,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_VEN0] = {
+		.name = "ven0",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0xe40,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_VEN0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_VEN0,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_CAM_MAIN] = {
+		.name = "cam-main",
+		.sta_mask = BIT(18),
+		.ctl_offs = 0xe48,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBA] = {
+		.name = "cam-suba",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0xe50,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_CAM_SUBB] = {
+		.name = "cam-subb",
+		.sta_mask = BIT(21),
+		.ctl_offs = 0xe54,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_MDP0] = {
+		.name = "mdp0",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0xe68,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_MDP0,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = BIT(28),
+		.ctl_offs = 0xe70,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_0_DISP,
+					MT8189_PROT_EN_MMSYS_STA_0_SET,
+					MT8189_PROT_EN_MMSYS_STA_0_CLR,
+					MT8189_PROT_EN_MMSYS_STA_0_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_MM_INFRA] = {
+		.name = "mm-infra",
+		.sta_mask = BIT(30),
+		.ctl_offs = 0xe78,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
+					MT8189_PROT_EN_MMSYS_STA_1_SET,
+					MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN_SUBCLK(INFRA,
+					       MT8189_PROT_EN_MM_INFRA_IGN,
+					       MT8189_PROT_EN_MMSYS_STA_1_SET,
+					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
+			BUS_PROT_WR_IGN_SUBCLK(INFRA,
+					       MT8189_PROT_EN_MM_INFRA_2_IGN,
+					       MT8189_PROT_EN_MMSYS_STA_1_SET,
+					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
+					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
+		},
+	},
+	[MT8189_POWER_DOMAIN_DP_TX] = {
+		.name = "dp-tx",
+		.sta_mask = BIT(0),
+		.ctl_offs = 0xe80,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_CSI_RX] = {
+		.name = "csi-rx",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0xe9c,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8189_POWER_DOMAIN_SSUSB] = {
+		.name = "ssusb",
+		.sta_mask = BIT(10),
+		.ctl_offs = 0xea8,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
+					MT8189_PROT_EN_PERISYS_STA_0_SET,
+					MT8189_PROT_EN_PERISYS_STA_0_CLR,
+					MT8189_PROT_EN_PERISYS_STA_0_RDY),
+		},
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8189_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0xeb4,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT8189_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
+		.sta_mask = BIT(2),
+		.ctl_offs = 0xeb8,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
+					MT8189_PROT_EN_INFRASYS_STA_1_SET,
+					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
+					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MD_STA_0_MFG1,
+					MT8189_PROT_EN_MD_STA_0_SET,
+					MT8189_PROT_EN_MD_STA_0_CLR,
+					MT8189_PROT_EN_MD_STA_0_RDY),
+			BUS_PROT_WR_IGN(INFRA,
+					MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
+					MT8189_PROT_EN_MD_STA_0_SET,
+					MT8189_PROT_EN_MD_STA_0_CLR,
+					MT8189_PROT_EN_MD_STA_0_RDY),
+			BUS_PROT_WR_IGN(SMI,
+					MT8189_PROT_EN_EMICFG_GALS_SLP_MFG1,
+					MT8189_PROT_EN_EMICFG_GALS_SLP_SET,
+					MT8189_PROT_EN_EMICFG_GALS_SLP_CLR,
+					MT8189_PROT_EN_EMICFG_GALS_SLP_RDY),
+		},
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT8189_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0xebc,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0xec0,
+		.pwr_sta_offs = MT8189_SPM_XPU_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8189_POWER_DOMAIN_EDP_TX_DORMANT] = {
+		.name = "edp-tx-dormant",
+		.sta_mask = BIT(12),
+		.ctl_offs = 0xf70,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED,
+	},
+	[MT8189_POWER_DOMAIN_PCIE] = {
+		.name = "pcie",
+		.sta_mask = BIT(13),
+		.ctl_offs = 0xf74,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8189_POWER_DOMAIN_PCIE_PHY] = {
+		.name = "pcie-phy",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0xf78,
+		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
+		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
+	},
+};
+
+static const struct scpsys_soc_data mt8189_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8189,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8189),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8189,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8189),
+};
+
+#endif /* __SOC_MEDIATEK_MT8189_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 3eeb0dabf7d7..58648f4f689b 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -26,6 +26,7 @@
 #include "mt8183-pm-domains.h"
 #include "mt8186-pm-domains.h"
 #include "mt8188-pm-domains.h"
+#include "mt8189-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
 #include "mt8196-pm-domains.h"
@@ -1171,6 +1172,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8188-power-controller",
 		.data = &mt8188_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8189-power-controller",
+		.data = &mt8189_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8192-power-controller",
 		.data = &mt8192_scpsys_data,
-- 
2.45.2


