Return-Path: <linux-pm+bounces-29754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35397AEC64B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191624A73C2
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BCC246771;
	Sat, 28 Jun 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="AjLz9Omz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25917225387;
	Sat, 28 Jun 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751102296; cv=none; b=n/SFA3QVOGceVJeiNfjTzpCKvM++rCWSCYSKnEN9SfgPz3LoWlqWOy9/GQDjmA4ID5lJwaeueLelOpVFDm6Zo6QcYP5Umm+0AiOWrg10tHapq5UE/Ao8Qj3H2R0+ZQWrXp/m4nJwvpDxCWR5E/3mwB2+gE6p16gJdp8LGzJINiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751102296; c=relaxed/simple;
	bh=Hfaa0gy3uc6c4TBbK3YEGBZqHHPIma4PeUvbj0qjqyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9sgDL4x8xSTI34hcxzQUk1TSf2JJl6ZxoA0u2wibd18ArLlg9HEkQwevi0wRIlgLm9BuzfB6MPeFolbYNEQi3ckx3XPQ5DwIHA3s6LD1W6iZmpIvUFvGD4NuCXdp/tTU82eciWkXD0SCSqdjXmFR/1BIZMDX8De/bIwWyOMD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=AjLz9Omz; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 920895FD7B;
	Sat, 28 Jun 2025 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751101851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgeEoJwP1RRKkglcECdGpkEEfNbWqvY35txVx4ntqiU=;
	b=AjLz9OmzYbggR4Ei1+YPIRF1/sNAVGGSlsI/4Z7ZjbytXLQ9j9wcZpPaQrcjjmARskZkHp
	T17tmyPEjUCgU2g8LYa7l3TxXAJC0y2jpiska5emk0t0/2BbGdUlV/ZRTmPJz8anEqRC43
	qsjNZkd+CitzoEwR8MRKESJdsfdm1PE=
Received: from frank-u24.. (fttx-pool-217.61.150.139.bambit.de [217.61.150.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 3618212272D;
	Sat, 28 Jun 2025 09:10:51 +0000 (UTC)
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
Subject: [PATCH v6 03/15] dt-bindings: net: mediatek,net: update for mt7988
Date: Sat, 28 Jun 2025 11:10:27 +0200
Message-ID: <20250628091043.57645-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628091043.57645-1-linux@fw-web.de>
References: <20250628091043.57645-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Update binding for mt7988 which has 3 gmac and a sram for dma
operations.

MT7988 has 4 FE IRQs (currently only 2 are used) and 4 IRQs for use
with RSS/LRO later.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v6:
- split out the interrupt-names into separate patch
- update irq(name) min count to 4
- add sram-property
- drop second reg entry and minitems as there is only 1 item left again

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
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 6672db206b38..74a139000f60 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -28,7 +28,8 @@ properties:
       - ralink,rt5350-eth
 
   reg:
-    maxItems: 1
+    items:
+      - description: Register for accessing the MACs.
 
   clocks:
     minItems: 2
@@ -66,6 +67,10 @@ properties:
       - const: gmac
       - const: ppe
 
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to mmio SRAM
+
   mediatek,ethsys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -418,7 +423,7 @@ allOf:
             - const: xgp3
 
 patternProperties:
-  "^mac@[0-1]$":
+  "^mac@[0-2]$":
     type: object
     unevaluatedProperties: false
     allOf:
-- 
2.43.0


