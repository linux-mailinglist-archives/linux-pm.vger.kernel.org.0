Return-Path: <linux-pm+bounces-37909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE8C55F16
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 07:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 286F14E3865
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B5320CBB;
	Thu, 13 Nov 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IQqPXiJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1343009F1
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016045; cv=none; b=tyhX8R27DF5NYKH1F1uZ3IFIBL5BCMUU72uncs6d4keio91+1d8nxLmYjCpblGjsWXFvVKe9q+3xEcHPPhUE52D74Gob5pu8U75JyR1AXFF9IZU9w1ZIPhwesTzwjXBiA1Ba1luv0uUaZI5PZ8hJ+xlBySgJ2rrz6qBtSIrsiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016045; c=relaxed/simple;
	bh=UHWJLuWheeuOfykfnjuhI2yeC9VTO3Hkx5VGd1+/p7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=acB9nLH/IGbvwwwh7ViKhB/UT1PyXnGzzA7Ln8fcUuri9gAwf0a82o4aDexuBn2ESFZ7JzIleT2/iHo775H1z/RHGvr5QSP+og4UQ+71xbmpJcXMFa0isvwVUYiRxe24p6goV6xk+bsWyfhipYUMOpNlB6EKGCizEUIY4XZPs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IQqPXiJ3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251113064041epoutp02ce92c121a9fc112ac6f0be70ff0f0b43~3fb-J89S11288612886epoutp023
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251113064041epoutp02ce92c121a9fc112ac6f0be70ff0f0b43~3fb-J89S11288612886epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763016041;
	bh=lLbacaR5clbNto/ko7Nx4/YFPvA6DfmhL0b6nWQNI0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQqPXiJ3/oxaL4v6sB3KvXD1L6ioNLQHixtSuj3bCsFZ3SYkCdkWSlV7Hhuq/vHMx
	 nMjx47Ub1eGOddZDnBb4MUsXp6eNkHoqXsVPyA47s3OuNVFZ42pItSN4CwbUzKLnFq
	 873fLHJkcX0CKxwaIV71lcGCjA8O0RhCaRpDXnlM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20251113064041epcas2p4f9f150d07cc3310bd8ef664c34f596ea~3fb_pyfWI0213302133epcas2p4i;
	Thu, 13 Nov 2025 06:40:41 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.211]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d6Vyc5dn7z6B9mB; Thu, 13 Nov
	2025 06:40:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20251113064040epcas2p2df8da3f9c5a2c41c6aedc37d37b366de~3fb9gbpRX1513415134epcas2p2q;
	Thu, 13 Nov 2025 06:40:40 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113064039epsmtip2d3d1a6afb1b99aa8c0726f1ee01e8ca0~3fb9U2F5c0205702057epsmtip2T;
	Thu, 13 Nov 2025 06:40:39 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, Shin Son <shin.son@samsung.com>,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 RESEND 1/3] dt-bindings: thermal: samsung: Adjust
 '#thermal-sensor-cells' to 1
Date: Thu, 13 Nov 2025 15:40:20 +0900
Message-ID: <20251113064022.2701578-2-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113064022.2701578-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113064040epcas2p2df8da3f9c5a2c41c6aedc37d37b366de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064040epcas2p2df8da3f9c5a2c41c6aedc37d37b366de
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064040epcas2p2df8da3f9c5a2c41c6aedc37d37b366de@epcas2p2.samsung.com>

The ExynosAuto v920 SoC includes multiple TMU instances; each instance
monitors a subset of the SoC's up to 16 hardware thermal sensors.

Additionally, add myself to the bindings' maintainers list, as I plan
to actively work on the exynosautov920 TMU support and handle further
updates in this area.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shin Son <shin.son@samsung.com>
---
 .../thermal/samsung,exynos-thermal.yaml       | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..6b01f508542c 100644
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
@@ -62,11 +64,17 @@ properties:
     minItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    enum: [0, 1]
 
   vtmu-supply:
     description: The regulator node supplying voltage to TMU.
 
+  samsung,sensors:
+    description: Number of thermal sensors monitored by this TMU instance.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+
 required:
   - compatible
   - clocks
@@ -97,6 +105,8 @@ allOf:
         reg:
           minItems: 2
           maxItems: 2
+        '#thermal-sensor-cells':
+          const: 0
   - if:
       properties:
         compatible:
@@ -119,6 +129,8 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        '#thermal-sensor-cells':
+          const: 0
 
   - if:
       properties:
@@ -139,6 +151,25 @@ allOf:
         reg:
           minItems: 1
           maxItems: 1
+        '#thermal-sensor-cells':
+          const: 0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynosautov920-tmu
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: tmu_apbif
+        reg:
+          maxItems: 1
+        '#thermal-sensor-cells':
+          const: 1
 
 additionalProperties: false
 
-- 
2.50.1


