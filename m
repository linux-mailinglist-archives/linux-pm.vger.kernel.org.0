Return-Path: <linux-pm+bounces-30457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839BAFE728
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B20171855
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892F28FFCF;
	Wed,  9 Jul 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="cPzLell4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DA28DB5E;
	Wed,  9 Jul 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059527; cv=none; b=WXQVM2kFse/5qCeDaCrioj9xKf6OeVLae4aGYkUPIM7Ldu4tBNgrKjg8l4QNF6BsYEsZi33S5jQMl2JgzKEoW0r1Z0CBN+7hJCQxV7clx9B1rFWO68khjlhq7JjTGz45uF8uSDaTbP+r/1QYEJYrBrJzEZo5d4DaXywzL+Mefjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059527; c=relaxed/simple;
	bh=DXD601dCHjG/IeJJ4zYhvxLgHvhDD4JGTSqzTPEUyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUI+nPE+3+rxoPY6sXMCiUG9ARw+SlDfX4zsvJLJrXW/KOEY54ITHVlDAXaalgdzSdJfSxGOn0JkbjXl5z4Xu8NTvg8bN1mB1FJTZEn2ePe7F1fVNeVcTka3SXr06L3+ZzPGdpg2eNH/zQeSonsv8DCYmPv0ploWk8SFg4HqA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=cPzLell4; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 1A15A60FC0;
	Wed,  9 Jul 2025 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1752059517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5oYVbNPFfzoohPL6ayLqmjVRgDniDHqGOnI/CRFHHI=;
	b=cPzLell4YaPiY1K/gXjudjgwVWJ0gjgm298qVUHPOYxFFxuVjSrq56FO5j7cLj8WdB3eej
	CZ5r8f4/wXoELm1glyIDDlsxJqBu/cQX3WAcse7+JG0fdWW5kd/7oHnf8uah0t67lh172X
	wcEWFD/CEU3oGeI2MTNHxWf0u/0o/tU=
Received: from frank-u24.. (fttx-pool-217.61.157.99.bambit.de [217.61.157.99])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id B36511226D4;
	Wed,  9 Jul 2025 11:11:56 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v9 02/13] dt-bindings: net: mediatek,net: allow up to 8 IRQs
Date: Wed,  9 Jul 2025 13:09:38 +0200
Message-ID: <20250709111147.11843-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709111147.11843-1-linux@fw-web.de>
References: <20250709111147.11843-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO).

Frame-engine-IRQs (max 4):
MT7621, MT7628: 1 FE-IRQ
MT7622, MT7623: 3 FE-IRQs (only two used by the driver for now)
MT7981, MT7986, MT7988: 4 FE-IRQs (only two used by the driver for now)

Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
LRO. So MT798x have 8 IRQs in total.

MT7981 does not have a ethernet-node yet.
MT7986 Ethernet node is updated with RSS/LRO IRQs in this series.
MT7988 Ethernet node is added in this series.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v9:
- set interrupt minitems to 8 for filogic
  - mt7981 does not have a ethernet node yet, so no ABI break
  - devicetree for mt7986 is updated later in this series, ABI-Break,
    but RSS/LRO should use interrupt names and is simply disabled when
    using older DT
- extend mt7986 example with PDMA-IRQs because minItems now 8
v8: separate irq-count change from interrupt-names patch
---
 .../devicetree/bindings/net/mediatek,net.yaml      | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 175d1d011dc6..99dc0401eb9a 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -40,7 +40,7 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 4
+    maxItems: 8
 
   power-domains:
     maxItems: 1
@@ -272,7 +272,7 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 4
+          minItems: 8
 
         clocks:
           minItems: 15
@@ -310,7 +310,7 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 4
+          minItems: 8
 
         clocks:
           minItems: 15
@@ -348,7 +348,7 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 4
+          minItems: 8
 
         clocks:
           minItems: 24
@@ -507,7 +507,11 @@ examples:
         interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&ethsys CLK_ETH_FE_EN>,
                  <&ethsys CLK_ETH_GP2_EN>,
                  <&ethsys CLK_ETH_GP1_EN>,
-- 
2.43.0


