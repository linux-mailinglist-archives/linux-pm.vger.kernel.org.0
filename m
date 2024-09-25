Return-Path: <linux-pm+bounces-14724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44300986566
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AE828BB2E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891312AAC6;
	Wed, 25 Sep 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E3YYUJP3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F58134BD;
	Wed, 25 Sep 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284341; cv=none; b=SDh6/ejfavZU5QV0XJ7zzKXnIED/lJ9OFqZ9BFRvp7/02DNP77oNRTt3tuUISE2N5d3qBUynpJKjAJotQaLJtY8SFfAusEwXbgwKlsJXvBiLEoFy/Mb6LBKZ2Mgnuf82JdBQeO2jGbKbeyIjcplGB3APg0NSsQVu7BXErc99kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284341; c=relaxed/simple;
	bh=gYWxM1TeoQg6TO2sus0j7GCmOr+z2YV/d6+5qLSlM8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K/vtbSSbhii+o4Jsyhbug0e6YDAuMc2jxy1XKAz9AJYKUM0hIkT1YinZHU8F5uQKg8FgUdgV4rGCfuYmyKUqYmGZPGcJAZLUgiaLUrndjtXc1/ax4sHXBO+KLSXzNM7zknDNTT9xUQCPnOEWe43p5QLVcIglIDFDiP/Wz/HjCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E3YYUJP3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e1f18f27b6111efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QoTT/6NBpLK4C3nKaQBc7mw+Qc83kZKYIzQinskh5z4=;
	b=E3YYUJP3qFE9CEzvkSi92QwQmgSvurO67cJMihMVaMXQhNG6Bu0BB0IjHL5eOAD+aoSbC6YEOER/of2D6ymuRTWRJ1GW/7LaKl6g3dCjiWBQ5DGwOU1imvfwFUTPSYwR4pudx4p3FaJPVGFuel+P6XDYteG/eL9VVm07iZE4WPU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:909b3bb8-c860-4021-bf38-7ebda0659179,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a078c2d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4e1f18f27b6111efb66947d174671e26-20240926
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 129292092; Thu, 26 Sep 2024 01:12:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 01:12:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 01:12:08 +0800
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
Subject: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: add adc and regulators for mt6359
Date: Thu, 26 Sep 2024 01:11:55 +0800
Message-ID: <20240925171156.9115-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--4.079200-8.000000
X-TMASE-MatchedRID: SsmlBu/h5g26lIBLPjRk6RWCVBr+Ay98wQ0CCpqVHSz98u70/pR9Gpas
	fA8Y/RCFDGo03EdVgDKjp64yUKGpZGaAyMVnPatL6/xAZojbl7cP4vBWNr0zgZsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNSjkRB+q9uV+Jsb3yTJxofTGAeY87hnlSO/NyqpYUkJBsqIjn1nHtvvMuU
	MG5xRFzczHQD4nSrHNeHsfn6gZqBMJzWjfPdXPzo7NPt9DnHpk82Gj2QC3yG0smXVK/H8eHzG7s
	r7xobSAsPEFD+rZA81DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.079200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B3DCA1ED930D0C66E8405AD4634D85CB39EA432A4B1306D31E1ACE828E230CF82000:8
X-MTK: N

Since MT6359 PMIC has been added as one of the compatibles of
"mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC" and
"MT6359 PMIC Regulators" should also be contained in this DT Schema as
well.

This patch includes:
 - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
 - add 'mt6359-regulator' to the compatibles of regulators.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 953358bc997a..40cabaf60d0d 100644
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
     additionalProperties: false
-- 
2.45.2


