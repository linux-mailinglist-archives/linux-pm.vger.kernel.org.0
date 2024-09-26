Return-Path: <linux-pm+bounces-14800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEDB987008
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC51F24A6B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533CB1AB518;
	Thu, 26 Sep 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O5A6t4RS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC449146596;
	Thu, 26 Sep 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342743; cv=none; b=sJzG/u3bUaxIPQRKS/iHxQqCLrVYJVuhTtShYGv9WRwtWSXuMSZBKiJYbg1aflCy4+1Td33sPCqoFUIVQ7SBou88+m/1yKfGqnR1QP78m2P43hQshwumF3wcUKcZgsS1462z3J4Oei76aDnhUfHn6JsAXt9sUgHUTMzIVMesDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342743; c=relaxed/simple;
	bh=WOTEcCH1q+vXiU5+IcfW8u8/9hRynPOT7CZFFoTf05M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAakDKc6NIbFnCphW2tiarwhd+YmkJJNn/XY/vwY7EALLsm+dNbzYkD+Gdzh4vGMX60TEnPyiyVLYRQoD8Drc4CGFuIBEx8s5llgwn/k3SzniFC+Aj2nR5yBnmQ7U++8cc8R0REnm6R5kWwfaE2l9JjJlL7HZd+wxy6BmFucr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O5A6t4RS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43cb2c507be911ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gGORMmyAt9xsZXh0Ovwbl04Yo5sJ4S7NR8EIjHh5Gdk=;
	b=O5A6t4RSnX4EperVbWtBAt6SymW7DXERWTw7R7XMi3dxf41oZQZxFHzGqEuVx1WsgPOL9xf+9HpXSYgP4+IWTVhQMX63WBHTrVO3Bvpc3XGOQo8GcSri0/GMC5uH27Xd58hfbEsnGdsQDolu9pklf48XSc5Rx97juBNDM/8ABnI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0c6f0e59-db39-4a13-9c25-e6c7d049b234,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:69ad999e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 43cb2c507be911ef8b96093e013ec31c-20240926
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 770929033; Thu, 26 Sep 2024 17:25:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 17:25:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 17:25:25 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eason Yen
	<eason.yen@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>, Shane Chien
	<shane.chien@mediatek.com>, Hui Liu <hui.liu@mediatek.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-sound@vger.kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH 3/3] arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec
Date: Thu, 26 Sep 2024 17:25:19 +0800
Message-ID: <20240926092519.6556-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240926092519.6556-1-macpaul.lin@mediatek.com>
References: <20240926092519.6556-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This change fixes these dtbs_check errors for audio-codec:
1. pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
 - Replace device node name to generic 'audio-codec'
2. pmic: regulators: 'compatible' is a required property
 - Add 'mediatek,mt6359-codec' to compatible.

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index dd732a820a7c..47bbd665a5a5 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -14,7 +14,8 @@ pmic_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
-		mt6359codec: mt6359codec {
+		mt6359codec: audio-codec {
+			compatible = "mediatek,mt6359-codec";
 		};
 
 		regulators {
-- 
2.45.2


