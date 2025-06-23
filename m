Return-Path: <linux-pm+bounces-29297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCAAE3F7D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A3E3A2F69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422526A08E;
	Mon, 23 Jun 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dqaQ63Oe"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975F267B74;
	Mon, 23 Jun 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680135; cv=none; b=DkGtErDNN8BpIGYLoiRA1e+MPB6Kj+Uu+uaatJLn6kNev51SMc1XyLdFXskrWhdL579wCm6nRKmty860nN0pRA5RHUMyGr+DdYUeQSamRIQozvAFBk8UjESWzCbtAJcBQ4MT82odEYHxr7pekH+3AOjE1CONtbGPqpsxv1nXx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680135; c=relaxed/simple;
	bh=PHnrPrLPZrEAkmVxB1XCxlvMbcWS8VMEtIIdU8TdwDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGSs/z96T0GgRb7/WBOso4HbXeXNGscqpCgi5+mQ3rdNfc9OuFQlJmOM0lr6HG7zKAVkYQFisNq93XdXMytkxszyYWPvYquqUHzjehC0iVHYPwBvt7N+Id2nBlX9RCN23NUO9CUa1pAea9ftc2UsGbF+UJX8FXJkjDTwHpzganw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dqaQ63Oe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680131;
	bh=PHnrPrLPZrEAkmVxB1XCxlvMbcWS8VMEtIIdU8TdwDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqaQ63OeW15GeUeHSetEPOuh7EAifyIRSD0MTjW7pg/eDc8AE2aaquyumN4RJnJSa
	 GKzcyRaEP8VfS9kEjBdyOxeGG/5dxupZ5F8OWeWhzFWBgYDgBPIRn/wTwD5AC69eQc
	 K95hnZuIF/v8c8dYlkyqTGk3/yDw08W1KVgALUzYT24x71lalb1LakIUEYMZqNBM+y
	 huOZO3mJsC23Q0HTeUCa53+G6XnDKZtx6hbFNsBRqdaV7CoyUyNalVOKQn1jUPBAFx
	 y9NlzBI5rNkIBN8kobU76Qd6EDFDXHyvQTjsFRNbE/fX0bqfurSk/EcexpGjl4EPGK
	 QMAnuCygfliAA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E04AD17E3659;
	Mon, 23 Jun 2025 14:02:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 13/13] pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains
Date: Mon, 23 Jun 2025 14:01:54 +0200
Message-ID: <20250623120154.109429-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the HFRPSYS Multimedia power domains found in the
MediaTek MT8196 Chromebook SoC.
Those power domains are all managed by the Hardware Voter MCU.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 239 ++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |   4 +
 2 files changed, 243 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mt8196-pm-domains.h b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
index ce8d594c46f8..2e4b28720659 100644
--- a/drivers/pmdomain/mediatek/mt8196-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
@@ -369,6 +369,239 @@ static const struct scpsys_hwv_domain_data scpsys_hwv_domain_data_mt8196[] = {
 	},
 };
 
+static const struct scpsys_hwv_domain_data hfrpsys_hwv_domain_data_mt8196[] = {
+	[MT8196_POWER_DOMAIN_VDE0] = {
+		.name = "vde0",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 7,
+	},
+	[MT8196_POWER_DOMAIN_VDE1] = {
+		.name = "vde1",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 8,
+	},
+	[MT8196_POWER_DOMAIN_VDE_VCORE0] = {
+		.name = "vde-vcore0",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 9,
+	},
+	[MT8196_POWER_DOMAIN_VEN0] = {
+		.name = "ven0",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 10,
+	},
+	[MT8196_POWER_DOMAIN_VEN1] = {
+		.name = "ven1",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 11,
+	},
+	[MT8196_POWER_DOMAIN_VEN2] = {
+		.name = "ven2",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 12,
+	},
+	[MT8196_POWER_DOMAIN_DISP_VCORE] = {
+		.name = "disp-vcore",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 24,
+	},
+	[MT8196_POWER_DOMAIN_DIS0_DORMANT] = {
+		.name = "dis0-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 25,
+	},
+	[MT8196_POWER_DOMAIN_DIS1_DORMANT] = {
+		.name = "dis1-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 26,
+	},
+	[MT8196_POWER_DOMAIN_OVL0_DORMANT] = {
+		.name = "ovl0-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 27,
+	},
+	[MT8196_POWER_DOMAIN_OVL1_DORMANT] = {
+		.name = "ovl1-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 28,
+	},
+	[MT8196_POWER_DOMAIN_DISP_EDPTX_DORMANT] = {
+		.name = "disp-edptx-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 29,
+	},
+	[MT8196_POWER_DOMAIN_DISP_DPTX_DORMANT] = {
+		.name = "disp-dptx-dormant",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 30,
+	},
+	[MT8196_POWER_DOMAIN_MML0_SHUTDOWN] = {
+		.name = "mml0-shutdown",
+		.set = 0x0218,
+		.clr = 0x021C,
+		.done = 0x141C,
+		.en = 0x1410,
+		.set_sta = 0x146C,
+		.clr_sta = 0x1470,
+		.setclr_bit = 31,
+	},
+	[MT8196_POWER_DOMAIN_MML1_SHUTDOWN] = {
+		.name = "mml1-shutdown",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 0,
+	},
+	[MT8196_POWER_DOMAIN_MM_INFRA0] = {
+		.name = "mm-infra0",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 1,
+	},
+	[MT8196_POWER_DOMAIN_MM_INFRA1] = {
+		.name = "mm-infra1",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 2,
+	},
+	[MT8196_POWER_DOMAIN_MM_INFRA_AO] = {
+		.name = "mm-infra-ao",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 3,
+	},
+	[MT8196_POWER_DOMAIN_CSI_BS_RX] = {
+		.name = "csi-bs-rx",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 5,
+	},
+	[MT8196_POWER_DOMAIN_CSI_LS_RX] = {
+		.name = "csi-ls-rx",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 6,
+	},
+	[MT8196_POWER_DOMAIN_DSI_PHY0] = {
+		.name = "dsi-phy0",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 7,
+	},
+	[MT8196_POWER_DOMAIN_DSI_PHY1] = {
+		.name = "dsi-phy1",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 8,
+	},
+	[MT8196_POWER_DOMAIN_DSI_PHY2] = {
+		.name = "dsi-phy2",
+		.set = 0x0220,
+		.clr = 0x0224,
+		.done = 0x142C,
+		.en = 0x1420,
+		.set_sta = 0x1474,
+		.clr_sta = 0x1478,
+		.setclr_bit = 9,
+	},
+};
+
 static const struct scpsys_soc_data mt8196_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8196,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8196),
@@ -383,4 +616,10 @@ static const struct scpsys_soc_data mt8196_scpsys_hwv_data = {
 	.type = SCPSYS_MTCMOS_TYPE_HW_VOTER,
 };
 
+static const struct scpsys_soc_data mt8196_hfrpsys_hwv_data = {
+	.hwv_domains_data = hfrpsys_hwv_domain_data_mt8196,
+	.num_hwv_domains = ARRAY_SIZE(hfrpsys_hwv_domain_data_mt8196),
+	.type = SCPSYS_MTCMOS_TYPE_HW_VOTER,
+};
+
 #endif /* __SOC_MEDIATEK_MT8196_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index bff78775baf7..6b807fc6ee72 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1158,6 +1158,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8196-power-controller",
 		.data = &mt8196_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8196-hwv-hfrp-power-controller",
+		.data = &mt8196_hfrpsys_hwv_data,
+	},
 	{
 		.compatible = "mediatek,mt8196-hwv-scp-power-controller",
 		.data = &mt8196_scpsys_hwv_data,
-- 
2.49.0


