Return-Path: <linux-pm+bounces-38861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21620C90D39
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 05:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9482734F373
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F02FC893;
	Fri, 28 Nov 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uAuHG3V4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DC2E92B4;
	Fri, 28 Nov 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764303466; cv=none; b=kWaxaUTSMn7R7CkkOy+UCJFPVvkV3MksHY/t5fdF+U4ZQqDCqtCpCYDK4WeEJn1ABDyPILDV9DrMQ578aycYVFhOzSYosnmZkSMNZoNy+HUL2zkqgnuWlkboeEXg2/GIIsLL8fgj4ifAka4x6vGAKCNIMwRblrtZIr9CThBeKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764303466; c=relaxed/simple;
	bh=Zf4IkwpT8UKKZSnCyMuagxPXOWk7DyEamr/50V6CcEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hS13eIJgg7UaFXhu5PpIClqk69au+gpUDKl/BuLVRRkIu8V2wdonAQiWK7S0agURpJximzykHL7VjBwfxI7nh3cb2n3nHLj+WHwHGr3AFUvkEV2MI8LjvDu6KF8EXCr9OJA8gNonHF/WCuezhmXZgSiYi7kVheVzfy67izu9YeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uAuHG3V4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2bf9eba6cc1111f0b2bf0b349165d6e0-20251128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8SXboeAZgfntpAeaS84XqhIpOOcXl92xvZI5XQYTmYU=;
	b=uAuHG3V4bO6zlP83OgKcZa/ACPD4hWfofM1uROTGq6RUhtw/ZylWO24j5kDh+IAIkezB7AtFDNSnIWYSvX6Tvjhls3D6NCssnVqGRohs0zQPBFIOvEcGaEpIXgrQKlLMiTMegbnwmsPq5dCcghYmUStga6AtEa+Ttt9y3m2ryXU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5b5bd644-d021-4f5d-8d74-4200b9bc0e84,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:59eccca7-1697-4a34-a2ba-2404d254a770,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2bf9eba6cc1111f0b2bf0b349165d6e0-20251128
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 96179658; Fri, 28 Nov 2025 12:17:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 28 Nov 2025 12:17:35 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 28 Nov 2025 12:17:35 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Macpaul Lin <macpaul.lin@mediatek.com>, "Chen-Yu
 Tsai" <wenst@chromium.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Weiyi Lu <Weiyi.Lu@mediatek.com>, Jian Hui Lee
	<jianhui.lee@canonical.com>, Irving-CH Lin <Irving-CH.Lin@mediatek.com>,
	<conor@kernel.org>, <krzk@kernel.org>, Louis-Alexis Eyraud
	<louisalexis.eyraud@collabora.com>, Bear Wang <bear.wang@mediatek.com>,
	"Pablo Sun" <pablo.sun@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <Stable@vger.kernel.org>
Subject: [PATCH v2] pmdomain: mtk-pm-domains: improve spinlock recursion fix in probe with correcting reference count
Date: Fri, 28 Nov 2025 12:17:22 +0800
Message-ID: <20251128041722.3540037-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Remove scpsys_get_legacy_regmap(), replacing its usage with
of_find_node_with_property().  Explicitly call of_node_get(np) before each
of_find_node_with_property() to maintain correct node reference counting.

The of_find_node_with_property() function "consumes" its input by calling
of_node_put() internally, whether or not it finds a match.
Currently, dev->of_node (np) is passed multiple times in sequence without
incrementing its reference count, causing it to be decremented multiple times
and risking early memory release.

Adding of_node_get(np) before each call balances the reference count,
preventing premature node release.

Fixes: c1bac49fe91f ("pmdomains: mtk-pm-domains: Fix spinlock recursion in probe")
Cc: Stable@vger.kernel.org
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

Changes for v2:
 - Rewording commit message.
 - Add Fixes: and Tested-by: tag, thanks.

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 80561d27f2b2..f64f24d520dd 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -984,18 +984,6 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 	}
 }
 
-static struct device_node *scpsys_get_legacy_regmap(struct device_node *np, const char *pn)
-{
-	struct device_node *local_node;
-
-	for_each_child_of_node(np, local_node) {
-		if (of_property_present(local_node, pn))
-			return local_node;
-	}
-
-	return NULL;
-}
-
 static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *scpsys)
 {
 	const u8 bp_blocks[3] = {
@@ -1017,7 +1005,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	 * this makes it then possible to allocate the array of bus_prot
 	 * regmaps and convert all to the new style handling.
 	 */
-	node = scpsys_get_legacy_regmap(np, "mediatek,infracfg");
+	of_node_get(np);
+	node = of_find_node_with_property(np, "mediatek,infracfg");
 	if (node) {
 		regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
 		of_node_put(node);
@@ -1030,7 +1019,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 		regmap[0] = NULL;
 	}
 
-	node = scpsys_get_legacy_regmap(np, "mediatek,smi");
+	of_node_get(np);
+	node = of_find_node_with_property(np, "mediatek,smi");
 	if (node) {
 		smi_np = of_parse_phandle(node, "mediatek,smi", 0);
 		of_node_put(node);
@@ -1048,7 +1038,8 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 		regmap[1] = NULL;
 	}
 
-	node = scpsys_get_legacy_regmap(np, "mediatek,infracfg-nao");
+	of_node_get(np);
+	node = of_find_node_with_property(np, "mediatek,infracfg-nao");
 	if (node) {
 		regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
 		num_regmaps++;
-- 
2.45.2


