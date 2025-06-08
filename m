Return-Path: <linux-pm+bounces-28271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36875AD1493
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B6A188B03B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345C25B1FF;
	Sun,  8 Jun 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="KpiNgaca"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A41A5B91;
	Sun,  8 Jun 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417738; cv=none; b=WoQVfM6bpfyqXujYO1XR9gp2+MpiD7rlCas8OgttkspnfRM4W52jAvm2/f/DtFXu7Tx7l4yb9uwQpkjlgOkDKOYWOyzuEHbpERy2QwPA6PuhcyWbRYZD6at9aIZi1WUVDy/ZZQnxcvRUP4ebKPbC2rUotO2wkOYmPvy7gPywfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417738; c=relaxed/simple;
	bh=htqcoHAk8wG4t8I4v7JXMnGKMG3faePy59bduotEJlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W76Hk+bxrORB5EHE5OQRpdldB8mEvBbYEkZwGmUhEuGtrSYE8VaQ3bPy44DBB6juiIUBR/UfkDxAB0BN1KBceLuvytQ/kabG0KUHVu+nwujTXXA0iD+Jg74lEVTaDsFFzfWOJgk15zbxc+5OT1spWK9eoDkNJbsV3h9C8+FqJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=KpiNgaca; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id D61C23FD96;
	Sun,  8 Jun 2025 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8bX81MxPTi+Jhd3n3SJZqbc7e3SnaNqOjwZqHrKmH0=;
	b=KpiNgacaDEvmnOScUpbA2d8BGHEjQiHUk6Pp89YEl1H0XNOFjF1kcWUCROGCrSAspM59xc
	XGL3EW10RO9tDO9Kg9NwL6ibdO/ci+VCfH8RKFCJ1ZrDKhfa7vhLPamQZUBjKt+eSRrIn8
	zqxv+H5NsCdBq8N34RgDTWEbw0L/YSs=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 70BCD1226D6;
	Sun,  8 Jun 2025 21:14:59 +0000 (UTC)
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
Subject: [PATCH v3 02/13] dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for mt7988
Date: Sun,  8 Jun 2025 23:14:35 +0200
Message-ID: <20250608211452.72920-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250608211452.72920-1-linux@fw-web.de>
References: <20250608211452.72920-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add own dsa-port binding for SoC with internal switch where only phy-mode
'internal' is valid.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 51205f9f2985..9b983fdbf3c7 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -190,6 +190,18 @@ required:
   - reg
 
 $defs:
+  builtin-dsa-port:
+    patternProperties:
+      "^(ethernet-)?ports$":
+        patternProperties:
+          "^(ethernet-)?port@[0-6]$":
+            if:
+              required: [ ethernet ]
+            then:
+              properties:
+                phy-mode:
+                  const: internal
+
   mt7530-dsa-port:
     patternProperties:
       "^(ethernet-)?ports$":
@@ -297,7 +309,7 @@ allOf:
             - airoha,en7581-switch
             - airoha,an7583-switch
     then:
-      $ref: "#/$defs/mt7530-dsa-port"
+      $ref: "#/$defs/builtin-dsa-port"
       properties:
         gpio-controller: false
         mediatek,mcm: false
-- 
2.43.0


