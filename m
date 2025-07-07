Return-Path: <linux-pm+bounces-30282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACAFAFB1CF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72902189F953
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E00129E0E0;
	Mon,  7 Jul 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M0UQOlgg"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870F29B8E0;
	Mon,  7 Jul 2025 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885788; cv=none; b=QF+igeIueJaoM3M+qVS3Q7a3Yq3l/c5tMI4Y1OqSXjMttGyZ4kn/71wStLvrhhCuuMSG8C1R8OYloFfyLeI6M3n6sCtchbj2vh1UoqOPvTn7s54fhQiSDAKFX9unhZpKbP0gEP/pmI1r1cAdSAmP0Mhg57MGqvdSkmv2N+vNSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885788; c=relaxed/simple;
	bh=5y06/XlzJ5VBPy4ECaMag5vxMElWvOWR9o/ilb4yPeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agofHWW9dwY2Ku7yHK0rDKYhm6RSeL92SdwhCP8EIf40RTMBnBh/V9V/LR4ett/5VUpPZEao+khnyuaxcxIDHz2NUP+cD10f3GAOLQh83YeIgBH9xcSiQBY+zPWDR2KC1bNRnHxZbtbIJlRIqfrBK56Rxs5mhtOOxoU8RMRhLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M0UQOlgg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885785;
	bh=5y06/XlzJ5VBPy4ECaMag5vxMElWvOWR9o/ilb4yPeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0UQOlggPmkkSt2lOoCV7BaINTUC4MPtcVfXwyzZZpRIyHe3L+UZQxyj+DhjzrhCJ
	 cUnZJ8rJvRLgh1AbgeFZ5oXv8ILcehfLY9niRpdf9KCP0e5sFTLxwwEbpNPxKUlj6M
	 MBPTtQMJPcYmU02YpbkhUk7x9hTOdTWDkvvFUD8xqIEAR4IKCFZSN+DyDijrLzhzhP
	 VZLFEo4zmI59ECJWUOs/QTQvxXAk2F2Y4DykscDYxszJB9PYXJz1tCUbo5sgsKlTyp
	 eUtrP6ICf/bmUJqUqppGCLUFP+y2e9C7q2Se0+6ge8UPzWeqv+fYhg1Ri58a07S6NA
	 oKwBfaYO5ydaQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 673EA17E053B;
	Mon,  7 Jul 2025 12:56:24 +0200 (CEST)
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
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 09/10] pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
Date: Mon,  7 Jul 2025 12:56:04 +0200
Message-ID: <20250707105605.98248-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the bus_prot_blocks handle and declare num_bus_prot_blocks to
allow all of the currently supported AArch64 MediaTek SoCs to use
the new style regmap retrieval in the driver when a new style
devicetree declaring the mediatek,bus-protection phandle(s) in
the main power controller node is found.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt6795-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8167-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8173-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8183-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8186-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 6 ++++++
 drivers/pmdomain/mediatek/mt8192-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 5 +++++
 drivers/pmdomain/mediatek/mt8365-pm-domains.h | 6 ++++++
 9 files changed, 47 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mt6795-pm-domains.h b/drivers/pmdomain/mediatek/mt6795-pm-domains.h
index a3f7785b04bd..dc8e9f8877ad 100644
--- a/drivers/pmdomain/mediatek/mt6795-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt6795-pm-domains.h
@@ -9,6 +9,9 @@
 /*
  * MT6795 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt6795[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 	[MT6795_POWER_DOMAIN_VDEC] = {
@@ -107,6 +110,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt6795[] = {
 static const struct scpsys_soc_data mt6795_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt6795,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6795),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt6795,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt6795),
 };
 
 #endif /* __SOC_MEDIATEK_MT6795_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8167-pm-domains.h b/drivers/pmdomain/mediatek/mt8167-pm-domains.h
index 8a0e898b79ab..f6ee48a711a1 100644
--- a/drivers/pmdomain/mediatek/mt8167-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8167-pm-domains.h
@@ -12,6 +12,9 @@
 /*
  * MT8167 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8167[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 	[MT8167_POWER_DOMAIN_MM] = {
@@ -99,6 +102,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 static const struct scpsys_soc_data mt8167_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8167,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8167),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8167,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8167),
 };
 
 #endif /* __SOC_MEDIATEK_MT8167_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8173-pm-domains.h b/drivers/pmdomain/mediatek/mt8173-pm-domains.h
index 7be0f47f5214..561a644b5d1c 100644
--- a/drivers/pmdomain/mediatek/mt8173-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8173-pm-domains.h
@@ -9,6 +9,9 @@
 /*
  * MT8173 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8173[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 	[MT8173_POWER_DOMAIN_VDEC] = {
@@ -118,6 +121,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 static const struct scpsys_soc_data mt8173_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8173),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8173,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8173),
 };
 
 #endif /* __SOC_MEDIATEK_MT8173_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
index c4c1b63d85b1..3742782a2702 100644
--- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
@@ -9,6 +9,9 @@
 /*
  * MT8183 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8183[] = {
+	BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_SMI
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 	[MT8183_POWER_DOMAIN_AUDIO] = {
@@ -290,6 +293,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 static const struct scpsys_soc_data mt8183_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8183,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8183),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8183,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8183),
 };
 
 #endif /* __SOC_MEDIATEK_MT8183_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8186-pm-domains.h b/drivers/pmdomain/mediatek/mt8186-pm-domains.h
index cbac715c38fa..00b9861af7c9 100644
--- a/drivers/pmdomain/mediatek/mt8186-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8186-pm-domains.h
@@ -13,6 +13,9 @@
 /*
  * MT8186 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8186[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 	[MT8186_POWER_DOMAIN_MFG0] = {
@@ -361,6 +364,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
 static const struct scpsys_soc_data mt8186_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8186,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8186),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8186,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8186),
 };
 
 #endif /* __SOC_MEDIATEK_MT8186_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 007235be9efe..3a989e83e9b7 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -14,6 +14,10 @@
  * MT8188 power domain support
  */
 
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8188[] = {
+	BUS_PROT_BLOCK_INFRA
+};
+
 static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 	[MT8188_POWER_DOMAIN_MFG0] = {
 		.name = "mfg0",
@@ -685,6 +689,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 static const struct scpsys_soc_data mt8188_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8188,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8188),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8188,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8188),
 };
 
 #endif /* __SOC_MEDIATEK_MT8188_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8192-pm-domains.h b/drivers/pmdomain/mediatek/mt8192-pm-domains.h
index 6f139eed3769..5d62fac5f682 100644
--- a/drivers/pmdomain/mediatek/mt8192-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8192-pm-domains.h
@@ -9,6 +9,9 @@
 /*
  * MT8192 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8192[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 	[MT8192_POWER_DOMAIN_AUDIO] = {
@@ -380,6 +383,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 static const struct scpsys_soc_data mt8192_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8192,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8192),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8192,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8192),
 };
 
 #endif /* __SOC_MEDIATEK_MT8192_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
index 59aa031ae632..9405e8f62eaf 100644
--- a/drivers/pmdomain/mediatek/mt8195-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
@@ -13,6 +13,9 @@
 /*
  * MT8195 power domain support
  */
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8195[] = {
+	BUS_PROT_BLOCK_INFRA
+};
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 	[MT8195_POWER_DOMAIN_PCIE_MAC_P0] = {
@@ -661,6 +664,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 static const struct scpsys_soc_data mt8195_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8195,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8195),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8195,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8195),
 };
 
 #endif /* __SOC_MEDIATEK_MT8195_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
index 6fbd5ef8d672..33265ab8ce76 100644
--- a/drivers/pmdomain/mediatek/mt8365-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -33,6 +33,10 @@
 			      _sta_mask, _sta,				\
 			      BUS_PROT_INVERTED | BUS_PROT_REG_UPDATE)
 
+static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8365[] = {
+	BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_INFRA_NAO, BUS_PROT_BLOCK_SMI
+};
+
 static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 	[MT8365_POWER_DOMAIN_MM] = {
 		.name = "mm",
@@ -190,6 +194,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 static const struct scpsys_soc_data mt8365_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8365,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8365),
+	.bus_prot_blocks = scpsys_bus_prot_blocks_mt8365,
+	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt8365),
 };
 
 #endif /* __SOC_MEDIATEK_MT8365_PM_DOMAINS_H */
-- 
2.49.0


