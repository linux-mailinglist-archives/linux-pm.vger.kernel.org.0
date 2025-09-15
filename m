Return-Path: <linux-pm+bounces-34616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB08B56F2F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E7317577F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DA26B2D3;
	Mon, 15 Sep 2025 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U7LIIgpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052C255E40
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909274; cv=none; b=eBweBC+g0n6CAWpGXSJDOp56ahimSC66Fj7vdobFLXX2yBsyeo9OpngFPISjtH5HzmwiDsWFdasl6ca/hINgXiw24s9oAtvCHQUhduS2ttDPVXHdSM6odORE3oiL69REpeUrfy+OKsal3SNE0J70U+y5g4biQbp4qmmza032LWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909274; c=relaxed/simple;
	bh=/OKMi0PnO4k+dDlZzQopdGGaUBSxmOlHHX8LMLoa7Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qWbj/oDYaQ8if0KMI9UaWEjigzUSUcm05JmScbPRd/0iKZhBCnZ6yPB/XEYs4l9Sc37G9lG9Sfs109wEIN6bZOeyvALzrW3qKA5lpC07u1Aaw1MKrUjHLO0B5vkkG8MMN48wVJFjXNmpAVXHlcXTpoOVDhE12ubP9bsOJ2ZeyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U7LIIgpu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250915040744epoutp02421baa9fc5c2894f85dcb3209ba0ce0b~lWSmFcIvk2118021180epoutp02O
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 04:07:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250915040744epoutp02421baa9fc5c2894f85dcb3209ba0ce0b~lWSmFcIvk2118021180epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757909264;
	bh=2lZzaMhkerEF9X8trQsLpjUpa3JpSWLt4zEQJ0GLguw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7LIIgpuGUhCXSZnPDcOsUAc9ZRqaGGj77Fhp8+/CFpc/QGaitY4fo47RvgyN8Pbe
	 CLTQm2fRC3f8J3hzZBRkKG6sN5S0KiQEZ3ehE3cJ25FgwjGgOfhu4QeydFHAobqR8p
	 mXbRk3995l2jhu3SQSFbnP/52XjTmO0OaxqHgCrk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250915040743epcas2p12771b571ce7f5fc30b1a2d5c21cf092f~lWSlknehV2098120981epcas2p19;
	Mon, 15 Sep 2025 04:07:43 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.101]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cQBMM1dXrz6B9m6; Mon, 15 Sep
	2025 04:07:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d~lWSkYbScR0669406694epcas2p47;
	Mon, 15 Sep 2025 04:07:42 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250915040742epsmtip1c26994646df08c79e3a53cfd16ff13e9~lWSkRItFT3249532495epsmtip1e;
	Mon, 15 Sep 2025 04:07:42 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: thermal: samsung: Add a
 hw-sensor-indices property
Date: Mon, 15 Sep 2025 13:07:13 +0900
Message-ID: <20250915040715.486733-2-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915040715.486733-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d
References: <20250915040715.486733-1-shin.son@samsung.com>
	<CGME20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d@epcas2p4.samsung.com>

The exynosautov920 TMU requires per-sensor interrupt enablement
for its critical trip points.

- **samsung,hw-sensor-indices**: List of sensor indices physically
                                 monitored by this TMU block.
				 Indicies not listed exist in the SoC
				 register map but are not part of
				 this TMU instance

Additionally, add myself to the bindings' maintainers list, as I plan
to actively work on the exynosautov920 TMU support and handle further
updates in this area.
I also restrict 'samsung,hw-sensor-indices' to the V920 variant. To
ensure properties introduced in 'if/then' blocks are recognized, I
replace 'addtionalProperties: false' with 'unevaluatedProperties: false'.

Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../thermal/samsung,exynos-thermal.yaml       | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..448c68986b10 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -8,6 +8,7 @@ title: Samsung Exynos SoC Thermal Management Unit (TMU)
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
+  - Shin Son <shin.son@samsung.com>
 
 description: |
   For multi-instance tmu each instance should have an alias correctly numbered
@@ -27,6 +28,7 @@ properties:
       - samsung,exynos5420-tmu-ext-triminfo
       - samsung,exynos5433-tmu
       - samsung,exynos7-tmu
+      - samsung,exynosautov920-tmu
 
   clocks:
     minItems: 1
@@ -62,7 +64,7 @@ properties:
     minItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    enum: [0, 1]
 
   vtmu-supply:
     description: The regulator node supplying voltage to TMU.
@@ -97,6 +99,8 @@ allOf:
         reg:
           minItems: 2
           maxItems: 2
+        '#thermal-sensor-cells':
+          const: 0
   - if:
       properties:
         compatible:
@@ -119,6 +123,8 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        '#thermal-sensor-cells':
+          const: 0
 
   - if:
       properties:
@@ -139,8 +145,38 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        '#thermal-sensor-cells':
+          const: 0
 
-additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynosautov920-tmu
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        reg:
+          minItems: 1
+          maxItems: 1
+        '#thermal-sensor-cells':
+          const: 1
+        samsung,hw-sensor-indices:
+          description:
+            List of thermal sensor indices physically monitored by this TMU instance.
+            Indices not listed correspond to registers that exist in the SoC
+            but are not connected to this TMU hardware block.
+          $ref: /schemas/types.yaml#/definitions/uint32-array
+          minItems: 1
+          maxItems: 16
+          uniqueItems: true
+          items:
+            minimum: 0
+            maximum: 15
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.50.1


