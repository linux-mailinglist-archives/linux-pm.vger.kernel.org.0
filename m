Return-Path: <linux-pm+bounces-30456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB2AFE726
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C75D1691FE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBD28FA8D;
	Wed,  9 Jul 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RFZxMvmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815528DB48;
	Wed,  9 Jul 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059527; cv=none; b=i4rU1l72smuhIqf1m6XlohJHAMyn0djqbre+sxCBx44OlacFajXD3oNoYFb/s8bpKdo887hf9qRV0OtQAwlEo/uPC3f87l4Em9A6zvuAXFCB6bLLVFKbOOukM6aH0UIcuWYiMMbjsY7iWAiShsKox6Js8y+MVBK5hpByFKI657E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059527; c=relaxed/simple;
	bh=a0wG9B1wdMoAKQ8jKykL5CDdJ2yJntzJ5rgOaL6Jkxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2S/olMbF7NzzHV7A6nprg4nxSvpUelH1pF7hDVL7Oqyl+fGAwWDdKWwayAfdchKLHHD6UsTVz5EDJsO+jVnLfVaDEwd4AkKnaanNf61M0cMSWb6j+PdRvx1nWDD7Ceb7prPoEhC0Q3ccDEYVIFU29ZHbNeyRqSoqhsBU+62CV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RFZxMvmJ; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id DDE0B603F9;
	Wed,  9 Jul 2025 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1752059518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5yOskSQPOfeXqxzAKp+ra3y71xfGoumsHkxo/gxJUM=;
	b=RFZxMvmJ/Twz30DHlBhpB9sfybpktL4WYCl7NgYMWsNRwcZuVmxR5ajqPh1IUrsRuw0ygK
	qr5+9Y96dApHHtjMLEqvbZ0oWSUOarZzTdZ+UP/ja1ac1M4sPMB0tC4gy0UeP1Yq+MVE03
	p6jIOaP2TlwfiuMU6e1OlHjYl6FDUi4=
Received: from frank-u24.. (fttx-pool-217.61.157.99.bambit.de [217.61.157.99])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 867901226D4;
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
Subject: [PATCH v9 04/13] dt-bindings: net: mediatek,net: add sram property
Date: Wed,  9 Jul 2025 13:09:40 +0200
Message-ID: <20250709111147.11843-5-linux@fw-web.de>
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

Meditak Filogic SoCs (MT798x) have dedicated MMIO-SRAM for dma operations.

MT7981 and MT7986 currently use static offset to ethernet MAC register
which will be changed in separate patch once this way is accepted.

Add "sram" property to map ethernet controller to dedicated mmio-sram node.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v9:
- add "sram: false" for non-filogic

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
 .../devicetree/bindings/net/mediatek,net.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index d2b5461e73bc..b45f67f92e80 100644
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
@@ -162,6 +166,8 @@ allOf:
             - const: gp1
             - const: gp2
 
+        sram: false
+
         mediatek,infracfg: false
 
         mediatek,wed: false
@@ -194,6 +200,8 @@ allOf:
             - const: ethif
             - const: fe
 
+        sram: false
+
         mediatek,infracfg: false
 
         mediatek,wed: false
@@ -233,6 +241,8 @@ allOf:
             - const: sgmii_ck
             - const: eth2pll
 
+        sram: false
+
         mediatek,infracfg: false
 
         mediatek,sgmiisys:
@@ -283,6 +293,8 @@ allOf:
             - const: sgmii_ck
             - const: eth2pll
 
+        sram: false
+
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
-- 
2.43.0


