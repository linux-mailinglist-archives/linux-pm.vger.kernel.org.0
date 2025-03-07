Return-Path: <linux-pm+bounces-23598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD9A55EED
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442FC1898E78
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2651A727D;
	Fri,  7 Mar 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="azh6aSE0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF041A2632;
	Fri,  7 Mar 2025 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319114; cv=none; b=OYnJEj4HKR48F95ORcRf+EyDM8ryQbTKh3btRbnCzza13sdFmfI2/I0cb+weNXvH0Av0UfTwcNL1WwYtfiw/5WA7pjSmPCqD7b4Cf1AMSelo0IbbZUSNkZCimvinGeJ3ELrTfh0+Ga5j4MbLdJgPBwnirssQC4+/a+TJjA4Ov3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319114; c=relaxed/simple;
	bh=WHfPPhpg4DaHJWjXuzSkn0WQGKdZjbTnGP7db00bd2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZwnyKNDdC4ToESMXiYYPa3UWqAKR9k6AH7opnRj6+wFTGqB+jzbgYy1dnMN3ls5X+1z/oBy+yKT96GurZkfqFhlvaxufPtyVljAagBQjzAEj5o6fWXzSEWtRB+5F9RBeYlAyRQiv/H/9JrTETW+SpaiBZOooJTTWnzRVFZadrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=azh6aSE0; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8f7f7358fb0611ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Gn5fVtPWjhwE/dkaw+mHySONmW2E1NkGCUMO1sHmiBU=;
	b=azh6aSE0FW2rtR+h02vtzEf+s4H2fg7Wdcaf4UoAu7QBCXWMkwgM21xI2HNm04Y+3nwwy1FgsX89dgBdVTBF50C2G1ipGI/uxLic8Z8wr14ndIw9K46Gpyg7QLVjvaALxBqda2WkIFAccjMOMPAsKDC7+sLz/QWV2EcNykOqp2E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f4fff39e-4991-4c97-8366-0512aceea563,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:730d08c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8f7f7358fb0611ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1618381742; Fri, 07 Mar 2025 11:45:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:04 +0800
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
Subject: [PATCH 10/13] pmdomain: mediatek: Support bus protect with table
Date: Fri, 7 Mar 2025 11:44:34 +0800
Message-ID: <20250307034454.12243-11-guangjie.song@mediatek.com>
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

Support bus protect with table which can contain multiple items.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 179 ++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 47d5d5abcaee..c10756fa1685 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -31,6 +31,8 @@
 #define MTK_RTFF_DELAY_US		10
 #define MTK_STABLE_DELAY_US		100
 
+#define MTK_BUS_PROTECTION_RETY_TIMES	10
+
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
 #define MTK_SCPD_SRAM_ISO		BIT(2)
@@ -106,6 +108,24 @@
 #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
 #define PWR_STATUS_WB			BIT(27)	/* MT7622 */
 
+#define _BUS_PROT(_type, _set_ofs, _clr_ofs,			\
+		_en_ofs, _sta_ofs, _mask, _ack_mask,		\
+		_ignore_clr_ack) {				\
+		.type = _type,					\
+		.set_ofs = _set_ofs,				\
+		.clr_ofs = _clr_ofs,				\
+		.en_ofs = _en_ofs,				\
+		.sta_ofs = _sta_ofs,				\
+		.mask = _mask,					\
+		.ack_mask = _ack_mask,				\
+		.ignore_clr_ack = _ignore_clr_ack,		\
+	}
+
+#define BUS_PROT_IGN(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask)		\
+		_BUS_PROT(_type, _set_ofs, _clr_ofs,	\
+		_en_ofs, _sta_ofs, _mask, _mask, true)
+
 enum clk_id {
 	CLK_NONE,
 	CLK_MM,
@@ -135,6 +155,18 @@ static const char * const clk_names[] = {
 };
 
 #define MAX_CLKS	3
+#define MAX_STEPS	3
+
+struct bus_prot {
+	u32 type;
+	u32 set_ofs;
+	u32 clr_ofs;
+	u32 en_ofs;
+	u32 sta_ofs;
+	u32 mask;
+	u32 ack_mask;
+	bool ignore_clr_ack;
+};
 
 /**
  * struct scp_domain_data - scp domain data for power on/off flow
@@ -157,6 +189,7 @@ static const char * const clk_names[] = {
  * @sram_slp_ack_bits: The mask for sram low power control acked bits.
  * @bus_prot_mask: The mask for single step bus protection.
  * @clk_id: The basic clocks required by this power domain.
+ * @bp_table: The bus protect configs for the power domain.
  * @caps: The flag for active wake-up action.
  */
 struct scp_domain_data {
@@ -179,6 +212,7 @@ struct scp_domain_data {
 	u32 sram_slp_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
+	struct bus_prot bp_table[MAX_STEPS];
 	u32 caps;
 };
 
@@ -207,6 +241,8 @@ struct scp {
 	struct regmap *infracfg;
 	struct scp_ctrl_reg ctrl_reg;
 	bool bus_prot_reg_update;
+	struct regmap **bp_regmap;
+	int num_bp;
 };
 
 struct scp_subdomain {
@@ -221,6 +257,8 @@ struct scp_soc_data {
 	int num_subdomains;
 	const struct scp_ctrl_reg regs;
 	bool bus_prot_reg_update;
+	const char **bp_list;
+	int num_bp;
 };
 
 static int scpsys_domain_is_on(struct scp_domain *scpd)
@@ -375,10 +413,121 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
 			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 }
 
+static int set_bus_protection(struct regmap *map, struct bus_prot *bp)
+{
+	u32 val = 0;
+	int retry = 0;
+	int ret = 0;
+
+	while (retry <= MTK_BUS_PROTECTION_RETY_TIMES) {
+		if (bp->set_ofs)
+			regmap_write(map,  bp->set_ofs, bp->mask);
+		else
+			regmap_update_bits(map, bp->en_ofs, bp->mask, bp->mask);
+
+		/* check bus protect enable setting */
+		regmap_read(map, bp->en_ofs, &val);
+		if ((val & bp->mask) == bp->mask)
+			break;
+
+		retry++;
+	}
+
+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,
+					      (val & bp->ack_mask) == bp->ack_mask,
+					      MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0) {
+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
+	}
+
+	return ret;
+}
+
+static int clear_bus_protection(struct regmap *map, struct bus_prot *bp)
+{
+	u32 val = 0;
+	int ret = 0;
+
+	if (bp->clr_ofs)
+		regmap_write(map, bp->clr_ofs, bp->mask);
+	else
+		regmap_update_bits(map, bp->en_ofs, bp->mask, 0);
+
+	if (bp->ignore_clr_ack)
+		return 0;
+
+	ret = regmap_read_poll_timeout_atomic(map, bp->sta_ofs, val,
+					      !(val & bp->ack_mask),
+					      MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret < 0) {
+		pr_err("%s val=0x%x, mask=0x%x, (val & mask)=0x%x\n",
+		       __func__, val, bp->ack_mask, (val & bp->ack_mask));
+	}
+	return ret;
+}
+
+static int scpsys_bus_protect_table_disable(struct scp_domain *scpd, unsigned int index)
+{
+	struct scp *scp = scpd->scp;
+	const struct bus_prot *bp_table = scpd->data->bp_table;
+	int ret = 0;
+	int i;
+
+	for (i = index; i >= 0; i--) {
+		struct regmap *map;
+		struct bus_prot bp = bp_table[i];
+
+		if (bp.type == 0 || bp.type >= scp->num_bp)
+			continue;
+
+		map = scp->bp_regmap[bp.type];
+		if (!map)
+			continue;
+
+		ret = clear_bus_protection(map, &bp);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int scpsys_bus_protect_table_enable(struct scp_domain *scpd)
+{
+	struct scp *scp = scpd->scp;
+	const struct bus_prot *bp_table = scpd->data->bp_table;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < MAX_STEPS; i++) {
+		struct regmap *map;
+		struct bus_prot bp = bp_table[i];
+
+		if (bp.type == 0 || bp.type >= scp->num_bp)
+			continue;
+
+		map = scp->bp_regmap[bp.type];
+		if (!map)
+			continue;
+
+		ret = set_bus_protection(map, &bp);
+		if (ret) {
+			scpsys_bus_protect_table_disable(scpd, i);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static int scpsys_bus_protect_enable(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
 
+	if (scp->bp_regmap && scp->num_bp > 0)
+		return scpsys_bus_protect_table_enable(scpd);
+
 	if (!scpd->data->bus_prot_mask)
 		return 0;
 
@@ -391,6 +540,9 @@ static int scpsys_bus_protect_disable(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
 
+	if (scp->bp_regmap && scp->num_bp > 0)
+		return scpsys_bus_protect_table_disable(scpd, MAX_STEPS - 1);
+
 	if (!scpd->data->bus_prot_mask)
 		return 0;
 
@@ -833,12 +985,27 @@ static struct scp *init_scp(struct platform_device *pdev, const struct scp_soc_d
 	if (!pd_data->domains)
 		return ERR_PTR(-ENOMEM);
 
-	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-			"infracfg");
-	if (IS_ERR(scp->infracfg)) {
-		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
-				PTR_ERR(scp->infracfg));
-		return ERR_CAST(scp->infracfg);
+	if (soc->bp_list && soc->num_bp > 0) {
+		scp->num_bp = soc->num_bp;
+		scp->bp_regmap = devm_kcalloc(&pdev->dev, scp->num_bp,
+					      sizeof(*scp->bp_regmap), GFP_KERNEL);
+		if (!scp->bp_regmap)
+			return ERR_PTR(-ENOMEM);
+
+		/* get bus prot regmap from dts node, 0 means invalid bus type */
+		for (i = 1; i < scp->num_bp; i++) {
+			ret = mtk_pd_get_regmap(pdev, &scp->bp_regmap[i], soc->bp_list[i]);
+			if (ret)
+				return ERR_PTR(ret);
+		}
+	} else {
+		scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+				"infracfg");
+		if (IS_ERR(scp->infracfg)) {
+			dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
+					PTR_ERR(scp->infracfg));
+			return ERR_CAST(scp->infracfg);
+		}
 	}
 
 	for (i = 0; i < soc->num_domains; i++) {
-- 
2.45.2


