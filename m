Return-Path: <linux-pm+bounces-23599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F298A55EEB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFDB16E719
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047711A83E2;
	Fri,  7 Mar 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V64XtOSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E71A314E;
	Fri,  7 Mar 2025 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319114; cv=none; b=mSCYfesFtdShzt0OuXvkK22NgHR4uTkVhE/K+g/sbo13RGMFMVeprLaUns4crx0s5fKEqa4vrp399NJwbeKIa4ol7qoSginRb9hHVPHWUVz0nG4m8+7PIIvtzZLKogx5vfBhdcEbE6/1E9Ae8B453P/0V37Qvj45B+WSo5giDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319114; c=relaxed/simple;
	bh=F3BQBYQ1zH02AzgoLKE7onBEKXtdo/OKRLJBqs+r8KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSw2P9eLhYtb1rZ91BaZFeoBKpmw6sWtTS9pl+jPiZBHlPaM3sOjrnUFEfckFL8/w1MgLd/vftPCZ1vJMGH/QM5mjMjfbs0AZyyVx5r96buwMnAZ0lrLW459MFkAgpTaGm6P6ew2lHBV1545QYhHC3wJPvd3Mt+4ZfTgFk2aUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V64XtOSl; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e8cf7ccfb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XG/7OP0R5QHKcseOjpNc9pY7M9WOw2SIwXbWVLzcAo4=;
	b=V64XtOSlAZM+7JrysKPX2XptLbdGr46OI8mjIgdq0CXcv88DmltDFYmHGMa2y/GEjpvmafenQBSf4EaHTEbWYbLDGwBaF8IHMJZR6zbKCx9Uj+vBaESjvbBWpye+9llptid4Tfoo/3mXGtsUWqk9i7Wv7jth9yvW0Hh6pxlWptM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4290ff8b-8d79-48fb-bd2e-6afb5c14d07a,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:be51cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8e8cf7ccfb0611efaae1fd9735fae912-20250307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1313304591; Fri, 07 Mar 2025 11:45:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:04 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:03 +0800
From: Guangjie Song <guangjie.song@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, Guangjie Song <guangjie.song@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 09/13] pmdomain: mediatek: Refactor parameters of init_scp
Date: Fri, 7 Mar 2025 11:44:33 +0800
Message-ID: <20250307034454.12243-10-guangjie.song@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307034454.12243-1-guangjie.song@mediatek.com>
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refactor parameters of init_scp which will use other fields of soc data.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 28 +++++++++++---------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index f0a5e1653b5f..47d5d5abcaee 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -798,10 +798,7 @@ static int mtk_pd_get_regmap(struct platform_device *pdev, struct regmap **regma
 	return 0;
 }
 
-static struct scp *init_scp(struct platform_device *pdev,
-			const struct scp_domain_data *scp_domain_data, int num,
-			const struct scp_ctrl_reg *scp_ctrl_reg,
-			bool bus_prot_reg_update)
+static struct scp *init_scp(struct platform_device *pdev, const struct scp_soc_data *soc)
 {
 	struct genpd_onecell_data *pd_data;
 	int i, j;
@@ -813,10 +810,10 @@ static struct scp *init_scp(struct platform_device *pdev,
 	if (!scp)
 		return ERR_PTR(-ENOMEM);
 
-	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
-	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
+	scp->ctrl_reg.pwr_sta_offs = soc->regs.pwr_sta_offs;
+	scp->ctrl_reg.pwr_sta2nd_offs = soc->regs.pwr_sta2nd_offs;
 
-	scp->bus_prot_reg_update = bus_prot_reg_update;
+	scp->bus_prot_reg_update = soc->bus_prot_reg_update;
 
 	scp->dev = &pdev->dev;
 
@@ -825,14 +822,14 @@ static struct scp *init_scp(struct platform_device *pdev,
 		return ERR_CAST(scp->base);
 
 	scp->domains = devm_kcalloc(&pdev->dev,
-				num, sizeof(*scp->domains), GFP_KERNEL);
+				soc->num_domains, sizeof(*scp->domains), GFP_KERNEL);
 	if (!scp->domains)
 		return ERR_PTR(-ENOMEM);
 
 	pd_data = &scp->pd_data;
 
 	pd_data->domains = devm_kcalloc(&pdev->dev,
-			num, sizeof(*pd_data->domains), GFP_KERNEL);
+			soc->num_domains, sizeof(*pd_data->domains), GFP_KERNEL);
 	if (!pd_data->domains)
 		return ERR_PTR(-ENOMEM);
 
@@ -844,9 +841,9 @@ static struct scp *init_scp(struct platform_device *pdev,
 		return ERR_CAST(scp->infracfg);
 	}
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < soc->num_domains; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-		const struct scp_domain_data *data = &scp_domain_data[i];
+		const struct scp_domain_data *data = &soc->domains[i];
 
 		scpd->supply = devm_regulator_get_optional(&pdev->dev, data->name);
 		if (IS_ERR(scpd->supply)) {
@@ -857,14 +854,14 @@ static struct scp *init_scp(struct platform_device *pdev,
 		}
 	}
 
-	pd_data->num_domains = num;
+	pd_data->num_domains = soc->num_domains;
 
 	init_clks(pdev, clk);
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < soc->num_domains; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
 		struct generic_pm_domain *genpd = &scpd->genpd;
-		const struct scp_domain_data *data = &scp_domain_data[i];
+		const struct scp_domain_data *data = &soc->domains[i];
 
 		pd_data->domains[i] = genpd;
 		scpd->scp = scp;
@@ -1511,8 +1508,7 @@ static int scpsys_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
-			soc->bus_prot_reg_update);
+	scp = init_scp(pdev, soc);
 	if (IS_ERR(scp))
 		return PTR_ERR(scp);
 
-- 
2.45.2


