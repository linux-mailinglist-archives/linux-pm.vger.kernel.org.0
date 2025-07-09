Return-Path: <linux-pm+bounces-30458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6EAFE72B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE11BC4DAE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083E291C02;
	Wed,  9 Jul 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="E3Dsrg/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D928DF23;
	Wed,  9 Jul 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059527; cv=none; b=sStmPHkD2ZqbCS6ulNrqxX+nF9iPL0s+FRsag2QXyDeB3tYCJRWejV075RNENeQFUsbOTdmOJrrPyF0K5IQ+ARJFgXojtb5xPHQzOMf1RZ0/Nlm7geEjrXRub5U0bLhe1KLYP50LvHwUSjkdRR3245Pm2amQW7tsRPUEwlRLZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059527; c=relaxed/simple;
	bh=uPn48diOGZBtLQOkWW7G6OT3hvBkeThACjnlKlvsVGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEeubxVIlBTCn+1o1fkgw1tqsfqAkNV4RB0C5pic5Z0fbFd3H592bRJrGuPEQwYAqM/cF5M7FZmBO90LxFC1Fv1JBzV3mr6YTwswko0tqXoQYo3Nk0WtRkMBJnYyU5hFG0YQneKcHUqhP3QMThZpXsP0aBJHKQtPvhxoHF/8igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=E3Dsrg/z; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 7C60D100864;
	Wed,  9 Jul 2025 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1752059517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgqruDlJ2JwMJ376oRztOa8rbeaRA0eUEn0DX/LJh+M=;
	b=E3Dsrg/zsmdmFUoQrGlkMDLg/LbNOHZllMVBxvpkbFBEoOY/+809aqMHJs6FczTFXtkw+u
	mXdmRSTFu6ToV+IgrG22OSYw4WJsgY6S1vEmbfm1s6gWU7SnB0OyTJBjmm073saHUSjN7h
	0ScHHSlY4cy0e4qp2rbFd3K40jlYUtA=
Received: from frank-u24.. (fttx-pool-217.61.157.99.bambit.de [217.61.157.99])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 1FDB2122701;
	Wed,  9 Jul 2025 11:11:57 +0000 (UTC)
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
Subject: [PATCH v9 03/13] dt-bindings: net: mediatek,net: allow irq names
Date: Wed,  9 Jul 2025 13:09:39 +0200
Message-ID: <20250709111147.11843-4-linux@fw-web.de>
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

In preparation for MT7988 and RSS/LRO allow the interrupt-names
property.
In this way driver can request the interrupts by name which is much
more readable in the driver code and SoC's dtsi than relying on a
specific order.

Frame-engine-IRQs (fe0..3):
MT7621, MT7628: 1 FE-IRQ
MT7622, MT7623: 3 FE-IRQs (only two used by the driver for now)
MT7981, MT7986: 4 FE-IRQs (only two used by the driver for now)

RSS/LRO IRQs (pdma0..3) additional only on Filogic (MT798x) with
count of 4. So all IRQ-names (8) for Filogic.

Set boundaries for all compatibles same as irq count.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v9:
- add interrupt-names minitems to 8 for filogic
  - mt7981 does not have a ethernet node yet
  - devicetree for mt7986 is updated later in this series
- small rephrase IRQ => FE-IRQ and mention total count of IRQs on Filogic.
- kept angelos RB because of small change, i hope it is ok :)

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
index 99dc0401eb9a..d2b5461e73bc 100644
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
           minItems: 8
 
+        interrupt-names:
+          minItems: 8
+
         clocks:
           minItems: 15
           maxItems: 15
@@ -312,6 +342,9 @@ allOf:
         interrupts:
           minItems: 8
 
+        interrupt-names:
+          minItems: 8
+
         clocks:
           minItems: 15
           maxItems: 15
@@ -350,6 +383,9 @@ allOf:
         interrupts:
           minItems: 8
 
+        interrupt-names:
+          minItems: 8
+
         clocks:
           minItems: 24
           maxItems: 24
-- 
2.43.0


