Return-Path: <linux-pm+bounces-15130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19098FC79
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 05:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA16B1C222BB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701D45007;
	Fri,  4 Oct 2024 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JtxXIg4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075712B2DA;
	Fri,  4 Oct 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010931; cv=none; b=TRF2PYQ/I5EgDI1AZ8pPwCj3Fy6+vec3eWY4NAvSWHRS3YNZ64usFbncyISy7xueetlC3U/0YRjlwcs/5Cbhr53rcQfA3vXnRs0L2GmyRESQsQKXqyqRlvQjfH8XPdB7pRu7RQFr/o4cYUg+TKgqplXXl/AaXBaS6L59SZ1KwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010931; c=relaxed/simple;
	bh=GstCkWPShMQ/UszwQe5t8ZxgyO018igh7DIxzE2l6KQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvXGiK9eonvpqzuFCh8E/aBfFVp3swg8OINBjwpPK0flNRTE2J057DnLEV3cqGIGR9FcChWR+/rjhz6ILo6v8IQ1QSbot4lDi95dKakepoweQcWvp/iLzBGHn6T9Pp8B2iptkgMUYhs7Fsj4GdHOoYEJTFYpEr9qzK7/HQGswFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JtxXIg4s; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 07a1587a81fd11efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=I5K+nSN5T2E6nZK8faQwTndLJFZXOZd9+jaIpIgcUmI=;
	b=JtxXIg4se85SUpMfFG/MS9btK5uNS+KI/iGLan25sATf+ad+KRzf2qwAXFPyD9ODpPXXKi42xEaxnu1po6btao0EZB3kw4bIX2Eu/HjMaGtKwVBP03hsxE/k5z1FVoaSFOU+MvKJLZ2+YQOWhbbSLyfeIEVPhFmrHYEGENBGId8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5ba1abf4-9ec8-4cc1-93df-cde14933b573,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:68614326-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 07a1587a81fd11efb66947d174671e26-20241004
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1143322155; Fri, 04 Oct 2024 11:02:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 11:01:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 11:01:59 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: add adc, codec and regulators for mt6359
Date: Fri, 4 Oct 2024 11:01:47 +0800
Message-ID: <20241004030148.13366-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.650800-8.000000
X-TMASE-MatchedRID: 4TOfFruLyYi6lIBLPjRk6RWCVBr+Ay98wQ0CCpqVHSz98u70/pR9GipO
	gudjiL0DF8NKa4AxCmBzNWqZAVqAAh9J5bZqJbIJvHKClHGjjr0W40XiUkbrG9zOQo7mTgA+cCE
	8iA5iVa0ZoBsQWiqLArpjAjMHHtZlHxPMjOKY7A8LbigRnpKlKWxlRJiH43972G1cTkcL58gA5L
	rtblF1DqM775K4TBnPkhIGp65r72JaobKNZg9nXg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.650800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3EB65091C26E2076BB07561CB10BB184BCAB13156FBE39F3D07547B13E47422F2000:8
X-MTK: N

Since MT6359 PMIC has been added as one of the compatibles of
"mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC",
"MT6359 Audio Codec"  and "MT6359 PMIC Regulators" should also be
contained in this DT Schema as well.

This patch includes:
 - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
 - add 'mt6359-regulator' to the compatibles of regulators.
 - add 'mt6359-codec' to the compatibles of audio-codec.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

Changes for v2:
 - Rebase on top of the DT schema conversion patch V8 (should be final version)
   without adc, audio-codec, and regulator.
   [1] https://lore.kernel.org/all/20241001104145.24054-3-macpaul.lin@mediatek.com/
 - Add 'mt6359-codec' to the compatibles of 'audio-codec' property.
   Please help to review it again.

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 95e9566fc535..35c4bc199b4e 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -17,6 +17,7 @@ description: |
   MT6397/MT6323 is a multifunction device with the following sub modules:
   - Regulators
   - RTC
+  - ADC
   - Audio codec
   - GPIO
   - Clock
@@ -86,6 +87,7 @@ properties:
           - enum:
               - mediatek,mt6323-regulator
               - mediatek,mt6358-regulator
+              - mediatek,mt6359-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
@@ -95,6 +97,11 @@ properties:
     required:
       - compatible
 
+  adc:
+    type: object
+    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
+    unevaluatedProperties: false
+
   audio-codec:
     type: object
     description:
@@ -106,6 +113,7 @@ properties:
         oneOf:
           - enum:
               - mediatek,mt6358-sound
+              - mediatek,mt6359-codec
               - mediatek,mt6397-codec
           - items:
               - enum:
-- 
2.45.2


