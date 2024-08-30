Return-Path: <linux-pm+bounces-13229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935796602E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B5F2840E4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477291AD413;
	Fri, 30 Aug 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iGqqLOqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B991A76A8;
	Fri, 30 Aug 2024 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016124; cv=none; b=Pg+Edhc+Osjh0lQPOuYAekfNNQk6Ah6DrAEUVF6raZlWFaMgGi8cDadhlL9GH1GwcAlmRA0KZWLDVCJFoTEQuXtOKCquOjCJxwuUNpNvM/oXuWjpGNUg/5dx58IuIm8/MpzB6vH0eP6C/zuVlrEBSaVnl2+IgCxNyUeMuyK9HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016124; c=relaxed/simple;
	bh=BdrWRkMfz8aAGdpO7GoavDMJsRYpW1HQUL7r86UF0oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2rBVt5NDc8B+KAzPbFpZo30s1LqfbhQLBbYiH9AaEoC75UzYGssgGa+NjKn2E/mnBwXSB6EbIjwBhvpFRTmGhInr0NSCX2bcO+27Oxs0p0RrGZ/QlXjcyTigRmo0N/4/XWeV5CpCd67hZXaiLjlKxHEk/FY4EXU2+0ncmdrK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iGqqLOqX; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2e30336a66c011ef8593d301e5c8a9c0-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JWd69Ny/qdwYRea4GxALoosea+AET1Gx/x1z1oiee9U=;
	b=iGqqLOqXD1DwfmdlLH2aEq3PFRlg9TbVi62G4yv2xtPCOaXq8a9fWOVQ2mhYKQ4bkhIxg4MMJu8ytKXIBGGZDc56LZph6ktfuKIskBicfEsx2yI6oigbbNhEfHtdRa82VsMG2cvL0Fd/+A9TIMgOXegLbL6DmxKau2UYFISQjLY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0bb84d7f-79ca-415f-b516-2b61f4aa8a28,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:18356fcf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2e30336a66c011ef8593d301e5c8a9c0-20240830
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1498479787; Fri, 30 Aug 2024 19:08:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Aug 2024 19:08:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Aug 2024 19:08:28 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-leds@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek
	<pavel@ucw.cz>, Sean Wang <sean.wang@mediatek.com>, Lee Jones
	<lee@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>, Flora Fu
	<flora.fu@mediatek.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 3/7] dt-bindings: rtc: mt6397: merge to MFD mediatek,mt6397 DT schema
Date: Fri, 30 Aug 2024 19:07:28 +0800
Message-ID: <20240830110732.30080-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240830110732.30080-1-macpaul.lin@mediatek.com>
References: <20240830110732.30080-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Convert rtc-mt6397.txt be compatible with the DT schema.
Since this is a simple RTC device node, merge it into parent
mediatek,mt6397.yaml. Subsequently, remove rtc-mt6397.txt with a
separate patch.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/rtc/rtc-mt6397.txt    | 31 -------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

Changes for v1 and v2:
 - This is the first version of converting rtc-mt6397.txt.
   This is because converting rtc-mt6397 together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of submitting single patch for each subdevice.
 - This patch has been made base on linux-next/master git repo.

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
deleted file mode 100644
index 7212076..0000000
--- a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Device-Tree bindings for MediaTek PMIC based RTC
-
-MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
-as a type of multi-function device (MFD). The RTC can be configured and set up
-with PMIC wrapper bus which is a common resource shared with the other
-functions found on the same PMIC.
-
-For MediaTek PMIC MFD bindings, see:
-../mfd/mt6397.txt
-
-For MediaTek PMIC wrapper bus bindings, see:
-../soc/mediatek/pwrap.txt
-
-Required properties:
-- compatible: Should be one of follows
-       "mediatek,mt6323-rtc": for MT6323 PMIC
-       "mediatek,mt6358-rtc": for MT6358 PMIC
-       "mediatek,mt6366-rtc", "mediatek,mt6358-rtc": for MT6366 PMIC
-       "mediatek,mt6397-rtc": for MT6397 PMIC
-
-Example:
-
-       pmic {
-               compatible = "mediatek,mt6323";
-
-               ...
-
-               rtc {
-                       compatible = "mediatek,mt6323-rtc";
-               };
-       };
-- 
2.45.2


