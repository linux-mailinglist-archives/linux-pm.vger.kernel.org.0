Return-Path: <linux-pm+bounces-30203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29CAFA53A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA318189480E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCC214A8B;
	Sun,  6 Jul 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HHVo/YJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D445191F7E;
	Sun,  6 Jul 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808158; cv=none; b=rXtkL5XHJPmUYztu5+7airpWg6PzteM24c7P9dCohzIWH2Jxreu6jL29HsUFpofm/fEGiqUPvuX4o21sAml29jWKyYmElgObiWKy4Hn99ssJDixgxKY27wvH/XA8ovyCSjutessbIgIObNVyl+UPXDArKbYsoJRFcrYA+dvwRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808158; c=relaxed/simple;
	bh=nNNXCz0QoVlTtDWFNzY0gqKDOSoNeIlY3uahvtlyf00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHDzp5QqxPb91bDsiNQMB2j67InPLbO8TlgewM9srwaKGH5d/sxLCzmnsBhFsgUfhcHtEef8QTuwkbPWhix02OklV+ucDVCGFNNv8JxfJEFOZv7ubgqbcbTYQtF3XDWDbEvUj7HdJina9tB5NOgQH0BjYKDW6GOhw1Bu8QbcGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HHVo/YJL; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 8A230604DC;
	Sun,  6 Jul 2025 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKLGNFT60/m9GUw3XIxCW7kQ4f+bA70MARehu2D8Bjk=;
	b=HHVo/YJL16+z5Nb0XQhrqvB5SFG6D9j/isP+KpY+kF72N2OQRDNcEeMmkdDPxM0l1fqIWi
	BYFcGGKTdXSxJkgKBb7nW6j4IP3yuctvV81sCADm/z4MIhoHMrkAS/OXV789B4TXaDg0RH
	lv+69pcvXKWCNSOD0FoWoadIpxJ4FOc=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 34B8E1226A5;
	Sun,  6 Jul 2025 13:22:28 +0000 (UTC)
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
Subject: [PATCH v8 04/16] dt-bindings: net: mediatek,net: add sram property
Date: Sun,  6 Jul 2025 15:21:59 +0200
Message-ID: <20250706132213.20412-5-linux@fw-web.de>
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

Meditak Filogic SoCs (MT798x) have dedicated MMIO-SRAM for dma operations.

MT7981 and MT7986 currently use static offset to ethernet MAC register
which will be changed in separate patch once this way is accepted.

Add "sram" property to map ethernet controller to dedicated mmio-sram node.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v8:
- splitted out mac subnode pattern
- dropped reg naming change
- rephrased description
- drop change of reg-name

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
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index da7bda20786a..afacd30b37c0 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -66,6 +66,10 @@ properties:
       - const: gmac
       - const: ppe
 
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to mmio SRAM
+
   mediatek,ethsys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.43.0


