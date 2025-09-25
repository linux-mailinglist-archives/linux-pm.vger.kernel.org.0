Return-Path: <linux-pm+bounces-35382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E59BA0087
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C6717B176
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85C2DF121;
	Thu, 25 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NobN07bN"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD832DC77B;
	Thu, 25 Sep 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810696; cv=none; b=lHdvYckmyocCqFjLtNSP5EttJBMAIeW+sY3ix7D3koQ1+A9fPBTgwGVkCyXaYVsh1j2O2SlaPQ8scDMj1YPuwncZ0wZH09cv/N9e4W1fEH4MAyRu489xbG/uOTWYLZirSezVmh5B2wk3H7VxIQ3ZRnirddDSjEx0JXSrAab7Kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810696; c=relaxed/simple;
	bh=Z2etouC0e/MupXGZRqvPNjZ+eDUkxJ7q4FAYyzxRnbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5FmtUzUPqOOksT2Mu690JNLF/crFF+PILGsvxaC5qKBHFhrNZ5sU8py/7WNrVKVNWiSvjzgTakTuGmoPiG54HUyk4+WDkMvpv0v/jGKh907yF+YLnnDGU1y1c6axYAuHp8dnTvEaQU1xE5X2WvBqeKCH+zOLSvdYhmwq54MsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NobN07bN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758810693;
	bh=Z2etouC0e/MupXGZRqvPNjZ+eDUkxJ7q4FAYyzxRnbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NobN07bNPhtZDfAE2nl12FeQcoOPv+RSZ15qU+YcnirjSx8jEIkW013s/v8el7PCk
	 hEtjtjwxbLhFR/Hjxp8kAVtoiCbjOySaOzpv4Oh7iJhty53Ca4rIwtg3x0Eq8iI2JQ
	 L1AvRjOzQBaq3IYb1W1vCQy1NbgXvnqcEy793HZXI56lo2kMl3hqHs+XJxGEshJS2L
	 HWopjBGYeS5Hj29zFsmJYQHidUrSlzH0WH8gZHnUtk33fiIJ3RvxQ980CONTQ/Ve3N
	 6GD4cQhdQv1+0Dk+eDp1efbZq/rTzDuZtHhODG+Za5GgTDnohuuyGd7x9CttLTGaMP
	 /N/eLkzpOyvGg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CE7F17E14FB;
	Thu, 25 Sep 2025 16:31:32 +0200 (CEST)
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
Subject: [PATCH v2 5/5] pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains
Date: Thu, 25 Sep 2025 16:31:16 +0200
Message-ID: <20250925143122.39796-6-angelogioacchino.delregno@collabora.com>
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

Add support for the HFRPSYS Multimedia power domains found in the
MediaTek MT8196 Chromebook SoC.
Those power domains are all managed by the Hardware Voter MCU.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
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
index 18f0b9b960d9..ac144ab8fce0 100644
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
2.51.0


