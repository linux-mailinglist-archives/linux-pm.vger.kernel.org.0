Return-Path: <linux-pm+bounces-38551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E12C8499C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841D94E4D8E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2396315D5C;
	Tue, 25 Nov 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fbBITHrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FB314B66;
	Tue, 25 Nov 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068211; cv=none; b=A77gWXqOReCV8CzkN4DkKeLeUZSKvq3ohm8pQ8JGV8mH7x2eg3v7b5pGcVvCsnoFvHEfrOM7rOj1hBCYpSx//1gog0OfioKAKMS3tOuqCdye8bgQ7iZ0KUEbnjytLWk2OdIK8SGh7tXS/0xfhuBlCIZBNYrcE8c4HLcoThkgZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068211; c=relaxed/simple;
	bh=PbIthCq+wuOTovJQI88qM0vhJ+n7T4PfwXv4OUS0Tns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fW0Z9dMHhMfV6fVeYd26QkT/U97efZD+4JTirl7UHWJO6no6G1Q6cq1VKbbhhLBry4ugdCndB6u5uq46XjETmEreWRyGfHtig2KJDfAAh5QtrGyARd9Pt0XP+iDeECuJk5iR6Bg4iN7c740u0HNuMCsSOTq3ncZ2bUCyT3hN93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fbBITHrh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a76a99ec9ed11f08ac0a938fc7cd336-20251125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gNOIyqsndGQOXXdpVgh65LPrGWqk+xJmkNe4l+FKetE=;
	b=fbBITHrh7PPruvSZW+R2GOSa1nWUZDmhM9H0YXlRXxsK/B0y68vDurjFinFEf0jdcM3fIokzEFZAOkq9gJXOYJpXvIRfrYiCPx/+XJd5HfwaGisrsjAlYcqfDY13dhGHzehUQscfTYlw1GSri7yLxsbQyqm+1+eszATyKP5GkAw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9c75ff85-8d5b-464e-bd73-d6e5cdd7d850,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4195896b-ffd0-409b-bec6-a38e02803690,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a76a99ec9ed11f08ac0a938fc7cd336-20251125
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 132949727; Tue, 25 Nov 2025 18:56:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 25 Nov 2025 18:56:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 25 Nov 2025 18:56:36 +0800
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
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] pmdomains: mtk-pm-domains: improve spinlock recursion fix in probe
Date: Tue, 25 Nov 2025 18:56:17 +0800
Message-ID: <20251125105617.1564725-1-macpaul.lin@mediatek.com>
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

Remove scpsys_get_legacy_regmap() and update usages with
of_find_node_with_property(). Use an explicit of_node_get(np) to ensure
correct node referencing against of_node_put() and ensuring it is called
in a safe context (i.e., not while holding devtree_lock).

If fwnode_count_parents() obtains parent nodes via
fwnode_for_each_parent_node() and this process requires device tree
operations, it may result in repeated acquisition of devtree_lock in
the same thread/context, leading to spinlock recursion errors.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

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


