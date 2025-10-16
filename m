Return-Path: <linux-pm+bounces-36222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2093DBE1E83
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787B4483A1D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC92FB62A;
	Thu, 16 Oct 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bcyTM3lC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835482E3B11
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599486; cv=none; b=Fa8INFsW88KQK3I49rO2CtpZUJyidKaRKWLVqzTSPIkUd/gLcNpkG2G3yR3IFj4mxYIJ1AylXZAKnFQHuBuEskq1ySbDYJHqSGM1ANNedNKNp4zI5dW8Wqud9Y2Qd5H5GG7sS0leqpwtdjZz1bsqOV81aLg4jRtkv9aMqSvjCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599486; c=relaxed/simple;
	bh=UHWJLuWheeuOfykfnjuhI2yeC9VTO3Hkx5VGd1+/p7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PgbXvgTQ+Dcj2AtzLY+2SEBAjkaTbStXkI85qgWyJKHg4KktQkMBsJqtcrH94eht6aVFQQ/2gFtyriWwDM8zrs9iFt6JRbFVcYoG7fErLWgc9QMeSOlEUcO+bGy2M97FTiUJQ5uIkb1HwL9fKtIyBRAiDZI6pC0+ZwAcVfZTYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bcyTM3lC; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251016072440epoutp01b78cbd47fff980f02985fea2dadadae1~u5_Zc8OQv2775127751epoutp01K
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 07:24:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251016072440epoutp01b78cbd47fff980f02985fea2dadadae1~u5_Zc8OQv2775127751epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760599480;
	bh=lLbacaR5clbNto/ko7Nx4/YFPvA6DfmhL0b6nWQNI0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcyTM3lCfKEUKlgJe+3BnfJ7R4ZCYaafE0rn74rHaCwqOlfxv31eKKVXRksGDYKS+
	 uzhD6MY4oa3PAnS9yLg2aCpiDXb1FGtvynv+pbrHuvSQ1L2JsmDFDvIOvk7PE8e6Ip
	 cm8tM0XLknskzPLnHnRSrqVJiAuqijm5R28d/mtQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20251016072440epcas2p1cd477800baf46f4d74c41efa8ab9f6ab~u5_Y_15eF1895118951epcas2p1g;
	Thu, 16 Oct 2025 07:24:40 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.206]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cnKGJ0htsz6B9mM; Thu, 16 Oct
	2025 07:24:40 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20251016072439epcas2p1989ee82845107b8f5d1790aa66d93ab3~u5_XxaufD1895118951epcas2p1U;
	Thu, 16 Oct 2025 07:24:39 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251016072438epsmtip113d7afd72a26704e7544afd2248a49ee~u5_XoxzZQ2023420234epsmtip1d;
	Thu, 16 Oct 2025 07:24:38 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Henrik Grimler
	<henrik@grimler.se>
Cc: Shin Son <shin.son@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: thermal: samsung: Adjust
 '#thermal-sensor-cells' to 1
Date: Thu, 16 Oct 2025 16:24:27 +0900
Message-ID: <20251016072429.1933024-2-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016072429.1933024-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251016072439epcas2p1989ee82845107b8f5d1790aa66d93ab3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251016072439epcas2p1989ee82845107b8f5d1790aa66d93ab3
References: <20251016072429.1933024-1-shin.son@samsung.com>
	<CGME20251016072439epcas2p1989ee82845107b8f5d1790aa66d93ab3@epcas2p1.samsung.com>

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


