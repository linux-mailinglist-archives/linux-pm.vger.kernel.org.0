Return-Path: <linux-pm+bounces-23596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF27A55EE1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 04:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D403A5D1F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763F19E971;
	Fri,  7 Mar 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L+wBWNcC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A2DF59;
	Fri,  7 Mar 2025 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319111; cv=none; b=uE5Bqka78RgG0jxTLsxk1hhYL/OEPqVPFa2nuAh/rejdfSMUpjYXaB8DJ8o6At4gEscLx2y/KcqYlRDxjuP+jPOVt28YiT7cOXfSGLLkAoLsdNIyvwIu5Vvu9GwA4y3Z7GoSlDZ8kFsig0HQJ56NgRq3y+pBnDSV9nb6lBEJqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319111; c=relaxed/simple;
	bh=psH0Cen3XwT713uGgcHxFDdlMdyyc6jGHeNKumTW1BQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uhu1DKF6VuFmIAEUIH5c0uaSkc9BcRPejNlorzQmhf9y4FkTsIAFa/I08Z1nJkuZOePGz9RTHoxAcVDSroNCXC7mvNFjkiFTmNWXIa8frX0i5DccrIaHcJj/jBtisv+pz5+bHL6XiivfV1fChalNp1Pi1BdKw7qmh0K/UdNEKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L+wBWNcC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e6a9ceafb0611ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kYM4hvbLwgewE5wpLMWiHp9tZ+VYzGQoqppmjV5gfOA=;
	b=L+wBWNcCXYtTYy1BY6DEC55GN1eP0HgWG8aJYsQ/qg2RuredDX9z2lHcup17E8qHiNurIiJJ5840/yrNlQuqNivgUg/AHt67X4XZGYF7VVkcZdfxdOOPliBek60v+Ihd6aJ3mfFqbnHv5RuzXpSFKIp5nG++PyCEj5FoaVkWTjo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bc11a585-9c04-4099-a96f-f40c5c88171b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:420d08c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8e6a9ceafb0611ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <guangjie.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 431097394; Fri, 07 Mar 2025 11:45:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 11:45:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 11:45:02 +0800
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
Subject: [PATCH 08/13] pmdomain: mediatek: Support power domain always on
Date: Fri, 7 Mar 2025 11:44:32 +0800
Message-ID: <20250307034454.12243-9-guangjie.song@mediatek.com>
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

Support power domain always on with MTK_SCPD_ALWAYS_ON.

Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 467c54e24bea..f0a5e1653b5f 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -43,6 +43,7 @@
 #define MTK_SCPD_UFS_RTFF		BIT(9)
 #define MTK_SCPD_RTFF_DELAY		BIT(10)
 #define MTK_SCPD_IRQ_SAFE		BIT(11)
+#define MTK_SCPD_ALWAYS_ON		BIT(12)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -900,6 +901,8 @@ static struct scp *init_scp(struct platform_device *pdev,
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_IRQ_SAFE))
 			genpd->flags |= GENPD_FLAG_IRQ_SAFE;
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ALWAYS_ON))
+			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
 	}
 
 	return scp;
-- 
2.45.2


