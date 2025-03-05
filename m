Return-Path: <linux-pm+bounces-23500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7CA50A9B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D817188E4AC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC7255E30;
	Wed,  5 Mar 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Abo9Xoco"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906E255250;
	Wed,  5 Mar 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201169; cv=none; b=WK2AwAgDmxOipgpXC7qAkbKK+bWO7im+qclC1dQe/0DFvI7M4VhsG5yNwNy0kADaTdwYfUweLdoEHeZYXENCASwlQcY7+n/4MTFF8MIGKyAV20UazNhR+sI7M6ZkwfcIuR2fsVh5n82pkTnpfOJvSS8NMVAgQ+fg6f/4kgLk4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201169; c=relaxed/simple;
	bh=acUZEVmdOu80f/7L3NgXf/R3B0sCOGH3PeEgX6a2U2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGr5UJ0t1otYhlwpv4SiryTlfFyNp5zn94brxwZdoV+6ttk6vKwmfituq7uOUGSYgoxTjdfDB2lD+dE+uvKlZ9mTJg5aF0sOw02O+0NzG5X9qlUe/jdjQszrLz3Y/lattXeouYpkq08KvMCw/vLaOl7jctdTCTqRzsGSqwkaY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Abo9Xoco; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741201166;
	bh=acUZEVmdOu80f/7L3NgXf/R3B0sCOGH3PeEgX6a2U2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Abo9Xoco5BZ6WU42i2n8OHs+MacWHLzr5cWpH/Vj8lV7FobM5DrotgY3UG/QBPmhL
	 pinANvay6rnmht2LOK3N+1p+D1/XHDbTUIJX8x/UVNWB6xZ2epK7GLkhBDn/4pKE1v
	 yxTOWcCwjsUWKvnGJkRv6q2HiUtIY2gnVEfkkP7zhP4iFBVPKYoLhflODNnghG2CbZ
	 nRqBW5z2eQvI3owf1W/sW9C9rQwM1QA1yrdZipgiC4t9cwUcUPLbSePr15liY7s59+
	 bUnz/L6hIntMre5JBbD2oF5HOE1Dm5iyoq6nZdZ0SsSTCsTQLZD7DSzraHEfpFzg+E
	 D0tXnQe8ECUrw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AE5617E05E7;
	Wed,  5 Mar 2025 19:59:20 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 05 Mar 2025 15:58:16 -0300
Subject: [PATCH v4 01/19] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
In-Reply-To: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Describe the accessory detection (accdet) module as a possible subnode
of the MT6359 PMIC.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..51012b8bbfaef3df7bdb619a4f8d828d6f9cc15a 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -24,6 +24,7 @@ description: |
   - LED
   - Keys
   - Power controller
+  - Accessory Detection
 
   It is interfaced to host controller using SPI interface by a proprietary hardware
   called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of pwrap.
@@ -224,6 +225,30 @@ properties:
     description:
       Pin controller
 
+  accdet:
+    type: object
+    additionalProperties: false
+    description:
+      The Accessory Detection module found on the PMIC allows detecting audio
+      jack insertion and removal, as well as identifying the type of events
+      connected to the jack.
+
+    properties:
+      compatible:
+        const: mediatek,mt6359-accdet
+
+      mediatek,hp-eint-high:
+        type: boolean
+        description:
+          By default, MT6359's HP_EINT pin is assumed to be pulled high and
+          connected to a normally open 3.5mm jack. Plug insertion is detected
+          when the pin is brought low in that case. Add this property if the
+          behavior should be inverted, for example if a normally closed 3.5mm
+          jack is used, or if the line is pulled low on open.
+
+    required:
+      - compatible
+
 required:
   - compatible
   - regulators
@@ -598,3 +623,29 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6359";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        accdet {
+            compatible = "mediatek,mt6359-accdet";
+            mediatek,hp-eint-high;
+        };
+
+        regulators {
+            compatible = "mediatek,mt6359-regulator";
+
+            buck_vs1 {
+                    regulator-name = "vs1";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <2200000>;
+                    regulator-enable-ramp-delay = <0>;
+                    regulator-always-on;
+            };
+        };
+    };

-- 
2.48.1


