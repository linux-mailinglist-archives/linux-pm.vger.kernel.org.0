Return-Path: <linux-pm+bounces-33956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CCB45487
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20FDA41E81
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD52D63E4;
	Fri,  5 Sep 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="X8H3fZlw"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7C285C99;
	Fri,  5 Sep 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067852; cv=pass; b=HKdol5IAGneI2okIiUp9r6tGykFocWGZGuXVfMw/52Lanxui53JanzBSq4hn0LjaR2emYHUGAz/7KLSLG8A5NI5e7zI8OIjCGIKSW1iYWkSqFxYE2rE+dnBOfcjpKsd5JVd4dGjcD6jwTrcKQ9caRgXeXXyhylvEPUMS7DtoJ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067852; c=relaxed/simple;
	bh=doo3dsFiTqKsGg19O+EDQAM/al9bo9cfIianA6jd4fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0TeA1ONT0zyqHQuyn5TA3p6Udq5aVT3UsqVOOPDUyPs3GrkoM6fVnJu9jwswksgZtHZJYCYs3lzPtA/AVJFq644sym2hNUkmudNUfyPaF0rDTI9Gep5HQNEt2a1OEDuUyNMdY2pIQssuVZRwYVl7HbQuoiYBZ9GwK9bIh6c1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=X8H3fZlw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757067824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fORs12r/9P+bFpGppwpXrPNY9ard+PY5cVLBuKdNL3SdN9NZBThRxBIqwBRC3RRlt9JmdS1HgWkXvVGWe1k4WvDv74hVAxzlKBp5Z17eMKIclj4g+cXgXIjTJNVO/YHOiO3dC/b7eFlPCI2Qt+8fOytzOodT60firynnIf+z62M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757067824; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Us0SdR9VkXymGZbNuZ4zsRJNiU5eRP0UPu2QfVitveY=; 
	b=iEcxPCRcnqRrp7tx8S1d9qLPnjZJL+OZkt1xQx4yq4wXFal9F3KPmLmLJYfqW81v8uF1MUKH5fZxmprzD84DMXtNTmEr7rltV0YuwodzKJfaxVECq6B5LVIyv9nuPoNqIYhzTA6dPnnE5EWvel35sIqiWVZ2HMCSJPk7JJ4heZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757067824;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Us0SdR9VkXymGZbNuZ4zsRJNiU5eRP0UPu2QfVitveY=;
	b=X8H3fZlwvrqV2W9DrXWK9DH2likHLKheHzb2jOGK1XKGCSDA3mGwvFcXFXWQfwZV
	0xvKfdth+jiNISINF6+NsEBWJXizf1P5aeUEHkGZfuAYc/jQrXTe+HpChlxbDyUVovd
	vG2bxmWJKpiaycfJ4dB2MDjwcYAQB6pu5b4MlmLo=
Received: by mx.zohomail.com with SMTPS id 1757067820867668.3962305402956;
	Fri, 5 Sep 2025 03:23:40 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 05 Sep 2025 12:22:57 +0200
Subject: [PATCH RFC 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-mt8196-gpufreq-v1-1-7b6c2d6be221@collabora.com>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
In-Reply-To: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Mali-based GPU on the MediaTek MT8196 SoC is shackled to its concept
of "MFlexGraphics", which in this iteration includes an embedded MCU
that needs to be poked to power on the GPU, and is in charge of
controlling all the clocks and regulators.

In return, it lets us omit the OPP tables from the device tree, as those
can now be enumerated at runtime from the MCU.

Add the mediatek,mt8196-mali compatible, and a performance-controller
property which points to a node representing such setups. It's required
on mt8196 devices.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e00217587c5d1f889094e2fff7b76e6148eb..6df802e900b744d226395c29f8d87fb6d3282d26 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3588-mali
+              - mediatek,mt8196-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 
   reg:
@@ -53,6 +54,13 @@ properties:
   opp-table:
     type: object
 
+  performance-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle of a device that controls this GPU's power and frequency,
+      if any. If present, this is usually in the form of some specialised
+      embedded MCU.
+
   power-domains:
     minItems: 1
     maxItems: 5
@@ -91,7 +99,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - mali-supply
 
 additionalProperties: false
 
@@ -105,9 +112,24 @@ allOf:
       properties:
         clocks:
           minItems: 3
+        performance-controller: false
         power-domains:
           maxItems: 1
         power-domain-names: false
+      required:
+        - mali-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,mt8196-mali
+    then:
+      properties:
+        mali-supply: false
+        sram-supply: false
+        operating-points-v2: false
+      required:
+        - performance-controller
 
 examples:
   - |
@@ -143,5 +165,17 @@ examples:
             };
         };
     };
+  - |
+    gpu2: gpu@48000000 {
+        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
+        reg = <0x48000000 0x480000>;
+        clocks = <&mfgpll 0>;
+        clock-names = "core";
+        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        performance-controller = <&gpufreq>;
+    };
 
 ...

-- 
2.51.0


