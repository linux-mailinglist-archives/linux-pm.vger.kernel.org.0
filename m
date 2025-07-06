Return-Path: <linux-pm+bounces-30213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897FAFA564
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EEB3AE670
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B6267B89;
	Sun,  6 Jul 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="d7WKfi7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1222FDEA;
	Sun,  6 Jul 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808489; cv=none; b=bV2i2Xk9B9CyDGQAxahjpel67Z8DTG42zoIFOyvcujaFK4kjn5Qj4m6zVahsXes0spHToO9MwE3EgV4IEP137M6i/3NcbUmCm1qfoCTXaZBlH5Z99oRi8yUgE3KKcQqI726Rylu1hya9mGN0lNCm1VkBtO7NL7rcCQ5KPrqD0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808489; c=relaxed/simple;
	bh=iyhUbnvRK9c3a6z3CgOQJwdtebP7P79sf017YIg+RyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxHKvCLFqUdAJ6Zaz2waherNoMUe9lqEWUSE/Xx1i16B+l4Npz4saClQu4R4XxZgVxHzPPGgMoJu+aVC/nvgjIf4yTDeNZ7Vhiia6Jku/yAg8QDGRpJm+JZbE6/ynpSfBxvC8QpYwbRDuh8I8lBZptlTbWu/Lcux4pQYn7k+p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=d7WKfi7x; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 2FABD100813;
	Sun,  6 Jul 2025 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71EqQ6Np0u0pAiJm9Ys2o5R9RiJdK+KyILbtVMDBcO0=;
	b=d7WKfi7xOy9dRKe30aW0RihUiYxjU3MrC1XaYr0/tT8J6vYKj/UBt84kkBGaknzIVqSyTb
	3HPTIyhYkM9e9GstWQrAS+nKatQyc0njUiqilY8nnhKg8/OHa3fxyxc0NdgZEzKT7K9m4E
	zZArF2M7VlVKH7nZIJosywqrr6O7Cp8=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id CBFBB1226F8;
	Sun,  6 Jul 2025 13:22:27 +0000 (UTC)
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
Subject: [PATCH v8 03/16] dt-bindings: net: mediatek,net: allow irq names
Date: Sun,  6 Jul 2025 15:21:58 +0200
Message-ID: <20250706132213.20412-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706132213.20412-1-linux@fw-web.de>
References: <20250706132213.20412-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

In preparation for MT7988 and RSS/LRO allow the interrupt-names
property.
In this way driver can request the interrupts by name which is much
more readable in the driver code and SoC's dtsi than relying on a
specific order.

Frame-engine-IRQs (fe0..3):
MT7621, MT7628: 1 IRQ
MT7622, MT7623: 3 IRQs (only two used by the driver for now)
MT7981, MT7986: 4 IRQs (only two used by the driver for now)

RSS/LRO IRQs (pdma0..3) only on Filogic (MT798x) with count of 4.

Set boundaries for all compatibles same as irq count.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v8:
  - fixed typo in mt7621 section "interrupt-namess"
  - separated interrupt count from interrupt-names
  - rephrased description a bit to explain the "why"
v7: fixed wrong rebase
v6: new patch splitted from the mt7988 changes
---
 .../devicetree/bindings/net/mediatek,net.yaml | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 766224e4ed86..da7bda20786a 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -42,6 +42,18 @@ properties:
     minItems: 1
     maxItems: 8
 
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: fe0
+      - const: fe1
+      - const: fe2
+      - const: fe3
+      - const: pdma0
+      - const: pdma1
+      - const: pdma2
+      - const: pdma3
+
   power-domains:
     maxItems: 1
 
@@ -135,6 +147,10 @@ allOf:
           minItems: 3
           maxItems: 3
 
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+
         clocks:
           minItems: 4
           maxItems: 4
@@ -166,6 +182,9 @@ allOf:
         interrupts:
           maxItems: 1
 
+        interrupt-names:
+          maxItems: 1
+
         clocks:
           minItems: 2
           maxItems: 2
@@ -192,6 +211,10 @@ allOf:
           minItems: 3
           maxItems: 3
 
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+
         clocks:
           minItems: 11
           maxItems: 11
@@ -232,6 +255,10 @@ allOf:
           minItems: 3
           maxItems: 3
 
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+
         clocks:
           minItems: 17
           maxItems: 17
@@ -274,6 +301,9 @@ allOf:
         interrupts:
           minItems: 4
 
+        interrupt-names:
+          minItems: 4
+
         clocks:
           minItems: 15
           maxItems: 15
@@ -312,6 +342,9 @@ allOf:
         interrupts:
           minItems: 4
 
+        interrupt-names:
+          minItems: 4
+
         clocks:
           minItems: 15
           maxItems: 15
@@ -350,6 +383,9 @@ allOf:
         interrupts:
           minItems: 4
 
+        interrupt-names:
+          minItems: 4
+
         clocks:
           minItems: 24
           maxItems: 24
-- 
2.43.0


