Return-Path: <linux-pm+bounces-23600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E4A55EF5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3383F1899D37
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA591AB530;
	Fri,  7 Mar 2025 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bTKNBLe/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A41A9B34;
	Fri,  7 Mar 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319117; cv=none; b=qfvhZWNKJ7pt/PcjWkCujCdo2SrdKoJ5X6JBXIb4XtjndvXYc7iorOmdCis1VnZ15pKM5r0gfm+HEfhjoqonRBwWoXidhO74SMtw/net9O75B15kQa6/eNiShE7/OfQBoxrBGfJYmcHb+C6NmW2cxpVgjUmUOlD20GFthPelELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319117; c=relaxed/simple;
	bh=ufcGm46IsX8XdOb7dfGm0G3o7ziji13dl1VlQPJX+ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcAnpaT1b3nthgRUCL8aUzg1sTsxlJOxt3Fm2eC0KxRxxdG/I6RO+OWId/gXpxGoEWN+uDmqMc8yPanyhPzDIKX+PMXeBkjbE+s5ox2rvRArUmKpo0E5gOKppBQq2SFg1Dc/pH8t9YFVFvmL61vzwmlc2ztvOrOEECR8exAD9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bTKNBLe/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8fe13390fb0611efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GsxSiAUY8gIW0rKNWS5fXVl7nSgevJ6sl+dGukX1DfY=;
	b=bTKNBLe/269VlaANpfIMwdauWRiTKhxYWwsc3hlJLbP5LYRRfLGH7DWR3OmCRt3stkTL+q9+r+NHY5tek7CkGJJ7EBsJ25yE0sHhCaDt1/bRYBuxo079QOfsehbamUNAB/wYBBqw2nUfZBDY+iyJKw9BXy+Z9ITbdMTROwL+Sh4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:70bad2fd-1210-494d-96b8-2bbd4d86f80e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:e851cc49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8fe13390fb0611efaae1fd9735fae912-20250307
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1940875903; Fri, 07 Mar 2025 11:45:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:05 +0800
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
Subject: [PATCH 11/13] pmdomain: mediatek: Add post init callback
Date: Fri, 7 Mar 2025 11:44:35 +0800
Message-ID: <20250307034454.12243-12-guangjie.song@mediatek.com>
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

Add post init callback.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index c10756fa1685..7bfe36c1a1ae 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -250,6 +250,9 @@ struct scp_subdomain {
 	int subdomain;
 };
 
+typedef int (*scp_soc_post_probe_fn)(struct platform_device *pdev,
+		struct scp *scp);
+
 struct scp_soc_data {
 	const struct scp_domain_data *domains;
 	int num_domains;
@@ -259,6 +262,7 @@ struct scp_soc_data {
 	bool bus_prot_reg_update;
 	const char **bp_list;
 	int num_bp;
+	scp_soc_post_probe_fn post_probe;
 };
 
 static int scpsys_domain_is_on(struct scp_domain *scpd)
@@ -1691,6 +1695,12 @@ static int scpsys_probe(struct platform_device *pdev)
 				ret);
 	}
 
+	if (soc->post_probe) {
+		ret = soc->post_probe(pdev, scp);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.45.2


