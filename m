Return-Path: <linux-pm+bounces-13226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E047966017
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E31F23D61
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4016192D93;
	Fri, 30 Aug 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VQ6zC21B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6518E370;
	Fri, 30 Aug 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016119; cv=none; b=Y8R8bZukQEJgZtRjuhGTdidScXvR6EsNTmXs+mzMVmJczUIwhoLGGqf/IcUpVmUBcdpaJVLJ/SiMyTsuwcGrmTGBmMkVX2aZ0A9z7Ukcm1K+CS9EPEImTbHd58jHm+LCdV+Q0YBEyDA08wj/OmotF6AvLhp5X0QcX8y+3slok3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016119; c=relaxed/simple;
	bh=FDXpEFMdCgHKKnsiYxb9lfTvUOuOlXHynWcUecvE1VQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9iJF5n8Bm0kwzwZ44jCdbTmEXoIwdnLvIqCE4fzKWVz8nlU0m3e+4L+RXYWxpTgB4KLc5sA6EMK1MRaVKBOSUwnXJPdJG8vJO7sM3AkjMNLAa2Yt9pVsYBwO63jGkfDmKbrLnwE1ypPHNS69yANv3+jtTqIe+zgCxzQb4cvFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VQ6zC21B; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2fc27fee66c011ef8b96093e013ec31c-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UyRBBoZvs5yZx9ee1wQlM3Yzcbs7XG0PM0g15NAHr6k=;
	b=VQ6zC21BjAHL2ADw07ofbgtSxGKewqdmdJsymRcFTecF+MG6/xDL6GwSUbNyqwaP+wzsttgr6XEm6PedgGD0QpIAS1pw9a1CZUviLYRT9RqID4IZlehrTlKhWzPqX/tHWfgiEUgqYRDplGOjJlRrmpSVd22wLE3TeB8t3gj9Fkg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:91cee89e-c5ed-4cc4-8e07-df5d81c97582,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:f08d30bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2fc27fee66c011ef8b96093e013ec31c-20240830
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1173315110; Fri, 30 Aug 2024 19:08:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
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
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 5/7] dt-bindings: leds: mt6323: merge to MFD mediatek,mt6397 DT schema
Date: Fri, 30 Aug 2024 19:07:30 +0800
Message-ID: <20240830110732.30080-5-macpaul.lin@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.873000-8.000000
X-TMASE-MatchedRID: pZGT1+TJBEa1DfGM6db7X7Gj3LN0+Ey9I9yVcHNDU7bo1+KnG60kJ0d0
	Rzx07LDVAE+AZVTHj3U5b8Cn2AtzZF0U3RPW+iLPhK8o4aoss8rljSRvSGpq3Fmmz7LVVfOpQ0U
	kLoLY8eZQnoa+pHlSjSRYcCcgpfWXvop7Aj3Fk4EMH4SsGvRsAx83WxJo1IH1bJknz+3f3aXET4
	xkmX4BvK2hFZjS5hc6FXEpsEnvAUxDeuA2fujoFQe06kQGFaIWfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtc20lvB2foahAByKL5N6oM/dme64tMkQaUW4CUJyXHz2zYHV6i90eh1Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.873000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BAD89263B4BD01370AC4A7538461DFC4BBBB5232013248BBBC92DB454517322F2000:8
X-MTK: N

Convert leds-mt6323.txt to be compatible with DT schema.
Since this is a simple LED device node, merge it into parent
mediatek,mt6397.yaml. Subsequently, remove leds-mt6323.txt with a
separate patch.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/leds/leds-mt6323.txt  | 63 -------------------
 1 file changed, 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt

Changes for v1 and v2:
 - This is the first version of converting leds-mt6323.
   This is because converting leds-mt6323 together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of submitting single patch for each subdevice.
 - This patch has been made base on linux-next/master git repo.

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
deleted file mode 100644
index 052dccb8..0000000
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Device Tree Bindings for LED support on MT6323 PMIC
-
-MT6323 LED controller is subfunction provided by MT6323 PMIC, so the LED
-controllers are defined as the subnode of the function node provided by MT6323
-PMIC controller that is being defined as one kind of Muti-Function Device (MFD)
-using shared bus called PMIC wrapper for each subfunction to access remote
-MT6323 PMIC hardware.
-
-For MT6323 MFD bindings see:
-Documentation/devicetree/bindings/mfd/mt6397.txt
-For MediaTek PMIC wrapper bindings see:
-Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
-
-Required properties:
-- compatible : Must be one of
-  - "mediatek,mt6323-led"
-  - "mediatek,mt6331-led"
-  - "mediatek,mt6332-led"
-- address-cells : Must be 1
-- size-cells : Must be 0
-
-Each led is represented as a child node of the mediatek,mt6323-led that
-describes the initial behavior for each LED physically and currently only four
-LED child nodes can be supported.
-
-Required properties for the LED child node:
-- reg : LED channel number (0..3)
-
-Optional properties for the LED child node:
-- label : See Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
-- default-state: See Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-	mt6323: pmic {
-		compatible = "mediatek,mt6323";
-
-		...
-
-		mt6323led: leds {
-			compatible = "mediatek,mt6323-led";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			led@0 {
-				reg = <0>;
-				label = "LED0";
-				linux,default-trigger = "timer";
-				default-state = "on";
-			};
-			led@1 {
-				reg = <1>;
-				label = "LED1";
-				default-state = "off";
-			};
-			led@2 {
-				reg = <2>;
-				label = "LED2";
-				default-state = "on";
-			};
-		};
-	};
-- 
2.45.2


