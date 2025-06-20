Return-Path: <linux-pm+bounces-29132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B38AE163F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8D6188F20B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A72238144;
	Fri, 20 Jun 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="GupZjz9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2932376E0;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408575; cv=none; b=dfrSm6CjqdshR3MUqWtCfoyr/B36NCIVAyBkpo+zM+5SjH6JY+hytgOOeCboP5YReFPiu9mNTJ9x9NjNvswDQrMQt3u0j9KQxnvLVgePuIV39q7YA+Jd8tPbimhw9yrnDalAQySUr49BH37kVPDjXJO/y5lAZoFfS8mW3IxNCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408575; c=relaxed/simple;
	bh=vt5HXulULwFMSk/DZzmUsWX+J6ZMRGPWe31G+LQyzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLgyvpfx24Hik4ud+GD8zLmIoTK/gew1iJxYMctmx15m1MWVBb8LowOQL3e5Qb6Pe72/5mxBxCRwfIfI1810kuy0Gy+XLrg7XIHmAePcekNiEk2xTdrvKqUt/m8otAOD30PpftfwJpi5F98/ViIAwRqKqHX8GF9dnb7sag5Tx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=GupZjz9U; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id ECE71100870;
	Fri, 20 Jun 2025 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750408571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEipcKAdukHIximsR/pW1XDMAY4xIuxLf5mfX3Vm1mQ=;
	b=GupZjz9UnsS2GlDvj8TRtLdgxoX4+KHTXmbCVdO6hD6eyKHVlnqFQSY6hcQXY53bECn7kZ
	C/C9hlI9OQR5EDcuRr89vT+6cQll16EexXh8rMlwCJcPHUTqvPo89KN4w/V5GFBaW90VY3
	vuUmSmQ811u5DjKwi5hjYxvYpHNAG2Q=
Received: from frank-u24.. (fttx-pool-157.180.225.81.bambit.de [157.180.225.81])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 91770122700;
	Fri, 20 Jun 2025 08:36:10 +0000 (UTC)
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 01/13] dt-bindings: net: mediatek,net: update for mt7988
Date: Fri, 20 Jun 2025 10:35:32 +0200
Message-ID: <20250620083555.6886-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620083555.6886-1-linux@fw-web.de>
References: <20250620083555.6886-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Update binding for mt7988 which has 3 gmac and 2 reg items.

MT7988 has 4 FE IRQs (currently only 2 are used) and the 4 IRQs for
use with RSS/LRO later.

Add interrupt-names to make them accessible by name.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v5:
- fix v4 logmessage and change description a bit describing how i get
  the irq count.
- update binding for 8 irqs with different names (rx,tx => fe0..fe3)
  including the 2 reserved irqs which can be used later
- change rx-ringX to pdmaX to be closer to hardware documentation

v4:
- increase max interrupts to 6 because of adding RSS/LRO interrupts (4)
  and dropping 2 reserved irqs (0+3) around rx+tx
- dropped Robs RB due to this change
- allow interrupt names
- add interrupt-names without reserved IRQs on mt7988
  this requires mtk driver patch:
  https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/

v2:
- change reg to list of items
---
 .../devicetree/bindings/net/mediatek,net.yaml | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 9e02fd80af83..9465b40683ad 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -28,7 +28,10 @@ properties:
       - ralink,rt5350-eth
 
   reg:
-    maxItems: 1
+    items:
+      - description: Register for accessing the MACs.
+      - description: SoC internal SRAM used for DMA operations.
+    minItems: 1
 
   clocks:
     minItems: 2
@@ -40,7 +43,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 4
+    maxItems: 8
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 8
 
   power-domains:
     maxItems: 1
@@ -348,7 +355,19 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 4
+          minItems: 2
+
+        interrupt-names:
+          minItems: 2
+          items:
+            - const: fe0
+            - const: fe1
+            - const: fe2
+            - const: fe3
+            - const: pdma0
+            - const: pdma1
+            - const: pdma2
+            - const: pdma3
 
         clocks:
           minItems: 24
@@ -381,8 +400,11 @@ allOf:
             - const: xgp2
             - const: xgp3
 
+        reg:
+          minItems: 2
+
 patternProperties:
-  "^mac@[0-1]$":
+  "^mac@[0-2]$":
     type: object
     unevaluatedProperties: false
     allOf:
-- 
2.43.0


