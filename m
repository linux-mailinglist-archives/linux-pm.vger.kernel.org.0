Return-Path: <linux-pm+bounces-29738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C0AEC607
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15ADB7A703E
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B586228CBC;
	Sat, 28 Jun 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uiKRNm9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D39226541
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751101427; cv=none; b=F05vTJ60mxJcIU6EmuQiY6SpXWZ07qIl6B69RZwNC3IPvTcX0hoYdZn/yySVuYSSWMQriNeHsLJyXBepAGQ5xklNqyPCwY/1/6Y4V3Yeg9g/zdJaapx5nZEq1ZZKOskTSPaqLsN53fwAd3kFVYPOncluyhJuYGNsM1dEpPCdsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751101427; c=relaxed/simple;
	bh=nkVcV3wUNVe/zcsTpVmUYTSaAg8gW0lc9PLvnuMVIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI3+IkJRAZwHoJAAXlVd9ZWk0rinRnPqKRzsC28OtbHLGhVcdt3s3sOWYayhw8vvAPfAm74wc8mkQZ0UGHhTyxorWjrhSEhkqx6Y+EYqmw9KzLyol3QKqrAVvvE/3ZVNs02SvCfcCRu8DIz9PNNUIw66/V2pfoKf/Rf3uqfLLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uiKRNm9q; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751101421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/pxDHLdKM59vQwtrSmRPlY+HDheivtQ/80IDfz7MYk=;
	b=uiKRNm9qcS9nl7TbUPDs9XyqHBP69P8tY6XgbwKXzAUcPGRByiDW8nx7bXlciNWa5y9ezr
	WcLoIo8Uki7XCiPD39P4KrMxBrLxf/sXRstzT4ASxIH7tMp8XKoUGvol+Q2KW26wgJV7oO
	0AOmwxC/N0AIsR0Us1hSjEcwDwzjp6k=
From: Frank Wunderlich <frank.wunderlich@linux.dev>
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
Subject: [PATCH v6 02/15] dt-bindings: net: mediatek,net: allow irq names
Date: Sat, 28 Jun 2025 11:03:13 +0200
Message-ID: <20250628090330.57264-3-frank.wunderlich@linux.dev>
In-Reply-To: <20250628090330.57264-1-frank.wunderlich@linux.dev>
References: <20250628090330.57264-1-frank.wunderlich@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Frank Wunderlich <frank-w@public-files.de>

In preparation for MT7988 and RSS/LRO allow the interrupt-names
property. Also increase the maximum IRQ count to 8 (4 FE + 4 RSS),
but set boundaries for all compatibles same as irq count.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v6: new patch splitted from the mt7988 changes
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 74a139000f60..6672db206b38 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -28,8 +28,7 @@ properties:
       - ralink,rt5350-eth
 
   reg:
-    items:
-      - description: Register for accessing the MACs.
+    maxItems: 1
 
   clocks:
     minItems: 2
@@ -67,10 +66,6 @@ properties:
       - const: gmac
       - const: ppe
 
-  sram:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to mmio SRAM
-
   mediatek,ethsys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -423,7 +418,7 @@ allOf:
             - const: xgp3
 
 patternProperties:
-  "^mac@[0-2]$":
+  "^mac@[0-1]$":
     type: object
     unevaluatedProperties: false
     allOf:
-- 
2.43.0


