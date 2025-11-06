Return-Path: <linux-pm+bounces-37523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A026C3AFDE
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261E34207B9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E833711C;
	Thu,  6 Nov 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VeI9fAjH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8E331A48;
	Thu,  6 Nov 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433035; cv=none; b=gTEYRTpOBIqGqa+oOh4n1amp/Kf5jGxMVR7SzlxkJIDm20xEpiK+NPboa3QeRbs8ZGXAGRhtclNLu5j4zC35g/QFRZYrAbPFFDbZc2hX27U6sewURBlbja3Jmf2EIL+Y9VN1oOu0gDgAabLVUIuYmSknVV9e/jRkhwslLtQQVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433035; c=relaxed/simple;
	bh=Ac2ZtvxcMCd02A2PV+ubg3kgL5zET++woDGi4q3cd3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5rzzV6Nvw5WffojjwGbPPlz69/Hznk8bWFehJA8py8E+/oxid7E0VUHOVCxofnT3nvlrQ2fBgVzaLE0GqB7p+YewoS9HG9OEnBFDmzK+53Nen/AHORrCItjciEizTI3hjxKEyI6eDwYqcmNPj8iw++kjE+05N1/m0jXfmCX1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VeI9fAjH; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 396bf0eabb0e11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UuE8WJ8FVhOmmwdUfgQkAB8Os9dplaQ1phAbB/AUpAE=;
	b=VeI9fAjHm8xcF21mKwAVIu1Nzb4LrBQDgdLxbwxm2nPB6uwXbgfj9eAexRvdo15yq0Dfbbi3lDWQExOO4S39ZVTqbfISoWzha6eXR3fKsufT+ShdLKgbtu9DHG/ul4VJHR5lUxQKAndEIGfxEDRqc5iRAHexlN6O38ciD+6ZBQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:33de7faa-718f-49b0-ba9b-f91ed93a3d12,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:e913fc7c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 396bf0eabb0e11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1069938215; Thu, 06 Nov 2025 20:43:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 20:43:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 20:43:40 +0800
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
Subject: [PATCH v3 20/21] pmdomain: mediatek: Add bus protect control flow for MT8189
Date: Thu, 6 Nov 2025 20:42:05 +0800
Message-ID: <20251106124330.1145600-21-irving-ch.lin@mediatek.com>
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

In MT8189 mminfra power domain, the bus protect policy separates
into two parts, one is set before subsys clocks enabled, and another
need to enable after subsys clocks enable.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 31 ++++++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  5 ++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 164c6b519af3..222846e52daf 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -250,7 +250,7 @@ static int scpsys_bus_protect_set(struct scpsys_domain *pd,
 					MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
-static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd, u8 flags)
 {
 	for (int i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
@@ -259,6 +259,10 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			break;
 
+		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=
+		    (flags & BUS_PROT_IGNORE_SUBCLK))
+			continue;
+
 		if (bpd->flags & BUS_PROT_INVERTED)
 			ret = scpsys_bus_protect_clear(pd, bpd);
 		else
@@ -270,7 +274,7 @@ static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd, u8 flags)
 {
 	for (int i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
 		const struct scpsys_bus_prot_data *bpd = &pd->data->bp_cfg[i];
@@ -279,6 +283,10 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
 		if (!bpd->bus_prot_set_clr_mask)
 			continue;
 
+		if ((bpd->flags & BUS_PROT_IGNORE_SUBCLK) !=
+		    (flags & BUS_PROT_IGNORE_SUBCLK))
+			continue;
+
 		if (bpd->flags & BUS_PROT_INVERTED)
 			ret = scpsys_bus_protect_set(pd, bpd);
 		else
@@ -632,6 +640,15 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		goto err_pwr_ack;
 
+	/*
+	 * In MT8189 mminfra power domain, the bus protect policy separates
+	 * into two parts, one is set before subsys clocks enabled, and another
+	 * need to enable after subsys clocks enable.
+	 */
+	ret = scpsys_bus_protect_disable(pd, BUS_PROT_IGNORE_SUBCLK);
+	if (ret < 0)
+		goto err_pwr_ack;
+
 	/*
 	 * In few Mediatek platforms(e.g. MT6779), the bus protect policy is
 	 * stricter, which leads to bus protect release must be prior to bus
@@ -648,7 +665,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_subsys_clks;
 
-	ret = scpsys_bus_protect_disable(pd);
+	ret = scpsys_bus_protect_disable(pd, 0);
 	if (ret < 0)
 		goto err_disable_sram;
 
@@ -662,7 +679,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	return 0;
 
 err_enable_bus_protect:
-	scpsys_bus_protect_enable(pd);
+	scpsys_bus_protect_enable(pd, 0);
 err_disable_sram:
 	scpsys_sram_disable(pd);
 err_disable_subsys_clks:
@@ -683,7 +700,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	bool tmp;
 	int ret;
 
-	ret = scpsys_bus_protect_enable(pd);
+	ret = scpsys_bus_protect_enable(pd, 0);
 	if (ret < 0)
 		return ret;
 
@@ -697,6 +714,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 
 	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
 
+	ret = scpsys_bus_protect_enable(pd, BUS_PROT_IGNORE_SUBCLK);
+	if (ret < 0)
+		return ret;
+
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
 		scpsys_modem_pwrseq_off(pd);
 	else
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index f608e6ec4744..a5dca24cbc2f 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -56,6 +56,7 @@ enum scpsys_bus_prot_flags {
 	BUS_PROT_REG_UPDATE = BIT(1),
 	BUS_PROT_IGNORE_CLR_ACK = BIT(2),
 	BUS_PROT_INVERTED = BIT(3),
+	BUS_PROT_IGNORE_SUBCLK = BIT(4),
 };
 
 enum scpsys_bus_prot_block {
@@ -95,6 +96,10 @@ enum scpsys_bus_prot_block {
 		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
 			  BUS_PROT_REG_UPDATE)
 
+#define BUS_PROT_WR_IGN_SUBCLK(_hwip, _mask, _set, _clr, _sta)		\
+		_BUS_PROT(_hwip, _mask, _set, _clr, _mask, _sta,	\
+			  BUS_PROT_IGNORE_CLR_ACK | BUS_PROT_IGNORE_SUBCLK)
+
 #define BUS_PROT_INFRA_UPDATE_TOPAXI(_mask)			\
 		BUS_PROT_UPDATE(INFRA, _mask,			\
 				INFRA_TOPAXI_PROTECTEN,		\
-- 
2.45.2


