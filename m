Return-Path: <linux-pm+bounces-29741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19CAEC60D
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12A86E154A
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAC2356BE;
	Sat, 28 Jun 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJypZ3Wn"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2D230BF6
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751101432; cv=none; b=S01N3ZZE3cYEmFDOPbGoIJFfwkQaJi8nAULggTeuA44OmhGpPLIzveCQbqrrmQ0cgOs3sccajf9C2jj2YZy7QsylVEAvGuqJgvBWDf8kJXUyPnxDQkr4q3j06ZWU0cKnbki34/Sj4aW332Ur5af7zbbrU4ALqKm5VCBWXjrXDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751101432; c=relaxed/simple;
	bh=/2RYzQamWMFGRk3UZGy8S3jPYaE9HT85GHRvJ+BZpds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qczgzoe7IXv/wpcR34mUawVb4VXu4KU91PQHwjk5PqdiCXs0QAt3OZldT8HdQQrBBOn7pEbmY6JnsIuXMF7xDIgiQxQTAo+6NxkBtUxTHL4xPVe0U7jct9S5vFwYa3H/NVZ4Tb56ztn0EktZHKqeenGfHPLVXAdndNGi2D+zdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJypZ3Wn; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751101428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvtxU4D3ohmA54ipUVXLZQjWygAPvZxaNNALd63s61k=;
	b=IJypZ3WnWhqvaXlHovteJEr+LrXxj4zgXSnIBxxW0XLxrYRU/9Yc54loK5qLY8zEV8+EV8
	t1ffnWcIXhPi+kIHSi2UdMRw+4j7q75Oe8t6NUXdoEmCti4VSwk+yvg1G5GDIwELGHjXca
	thg2WxuGcTG+S7BtnFP7ufjPL4tDkdY=
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
Subject: [PATCH v6 05/15] dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
Date: Sat, 28 Jun 2025 11:03:16 +0200
Message-ID: <20250628090330.57264-6-frank.wunderlich@linux.dev>
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

Mt7988 buildin switch has own mdio bus where ge-phys are connected.
Add related property for this.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v2:
- change from patternproperty to property
- add unevaluatedProperties and mediatek,pio subproperty
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 9b983fdbf3c7..815a90808901 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -136,6 +136,16 @@ properties:
       See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
       details for the regulator setup on these boards.
 
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      mediatek,pio:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          Phandle pointing to the mediatek pinctrl node.
+
   mediatek,mcm:
     type: boolean
     description:
-- 
2.43.0


