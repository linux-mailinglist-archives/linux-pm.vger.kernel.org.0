Return-Path: <linux-pm+bounces-28809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20571ADACCC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618C9172B14
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A3527933E;
	Mon, 16 Jun 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="w9j266aP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1E275872;
	Mon, 16 Jun 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067932; cv=none; b=bHfy9hOCY9tOsZXMiPhSZEQDTQ4CffigXP9ajNIGjh0CG773Jbc+ZNsaggA240iTua1nG9cujaWOAaFKhbGVewWQ8JxmkOfHTNX1EA1JN5VQo7GyEHcrGVdmjLldXkuG4uLr9lZFazXLiHg9B9ZPbdzws4ecp355CtMNBFmUUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067932; c=relaxed/simple;
	bh=NmNAyu0KKfpkhLYRgdYFFTVxljyKCh4bwWLzFaJdjj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ollnkZ5eLVrlDXPJpWEwg8XbmUWXRN5und3atnrlBaVM5EgWU6PGkEogGO+khziz/XddWvSyM3jo3E5lU73TulaqmESFNwTpxvoM/5FZDDOwFPBLZ9fEvKcZVhWrtp3yaZs6gn/LCBmZBLqRXAaz5A4guBAVLRYS5fLVMoZlhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=w9j266aP; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 41863100941;
	Mon, 16 Jun 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cILgw7jh0mrvewNLFWEizuxV/iOA66tlT6a6wOh74A=;
	b=w9j266aPJj0lkFKIFfXlekWZwIlt41cm+yjRslDnO6Q9fEepo9gnTTvb+Tjpv/hm+hMvca
	yd0zNcbE2hIkj0govm4MboQezqO7FZpbCvfwOPeeeX5vUvnabPthZf83HdmSAuB6MTFNl6
	sJekymiy6KtNMLayS4TjaHW5H1UGKAs=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id D7892122704;
	Mon, 16 Jun 2025 09:58:39 +0000 (UTC)
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
Subject: [PATCH v4 01/13] dt-bindings: net: mediatek,net: update for mt7988
Date: Mon, 16 Jun 2025 11:58:11 +0200
Message-ID: <20250616095828.160900-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616095828.160900-1-linux@fw-web.de>
References: <20250616095828.160900-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Update binding for mt7988 which has 3 gmac and 2 reg items.

With RSS-IRQs the interrupt max-items is now 6. Add interrupt-names
to make them accessible by name.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- increase max interrupts to 8 because of RSS/LRO interrupts
- dropped Robs RB due to this change
- allow interrupt names
- add interrupt-names without reserved IRQs on mt7988
  this requires mtk driver patch:
  https://patchwork.kernel.org/project/netdevbpf/patch/20250616080738.117993-2-linux@fw-web.de/

v2:
- change reg to list of items
---
 .../devicetree/bindings/net/mediatek,net.yaml | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 9e02fd80af83..f8025f73b1cb 100644
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
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
 
   power-domains:
     maxItems: 1
@@ -348,7 +355,17 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 4
+          minItems: 2
+
+        interrupt-names:
+          minItems: 2
+          items:
+            - const: tx
+            - const: rx
+            - const: rx-ring0
+            - const: rx-ring1
+            - const: rx-ring2
+            - const: rx-ring3
 
         clocks:
           minItems: 24
@@ -381,8 +398,11 @@ allOf:
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


