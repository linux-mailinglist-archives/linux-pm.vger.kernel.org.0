Return-Path: <linux-pm+bounces-35702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C67BB811B
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762604EF2F7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCFB244660;
	Fri,  3 Oct 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="F3vppZbG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E057221710;
	Fri,  3 Oct 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522591; cv=pass; b=G9+tvMA8TmIh+M2tm4KnWHVWNHBSmOyEqc57gcwRPcdZ0pqOwoG4MSAcTUiV8EzwmNgM8l6A1bPKCusKQwTcCsW1s8txlkRA7g6H3WAQdoAn5uARoOiRlybeHDDkFFsbsbb7tkeG/K0xKiWOckm/GR+ZJMeGsQN3bt0JCUPUxgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522591; c=relaxed/simple;
	bh=dE1cson/uP5XGOxL3Emzs0y6poaO/Pvzy72edBioZV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbkgUYwvZlyLEdVwCm6KkEm95acQqbfZmXRin94VLZZA6eLvRaduJtishbwjHIMBVAkR7M8kU0qXSUu+/ipmf4oIxrpXzgwpYndXgw2/0ZZCULbHp5K4v5PTKyDgBzEsfmMRbpvkWRKReEwPItBVg+RhF60ur0d2//cf4Wwq6gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=F3vppZbG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759522541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EGsR7BrvMlzQiGzSUqbjkdcpwEhwClVLQUTL1hBcvpeHooPOYWyteFVMUQy7gMAxgR6pgD9cUKE/seb/k96UUrMbP1sRgBMaBRv0MUGbdI9RYNPC5fqtKvFIJ9QGRovR0JmVGe/NwSek+nqra/uumVBn4psyWqZP999MTNzy518=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759522541; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MyTZIankaLF5a06YDy1KIdFXkQpVaw5MiopvoWPWCGU=; 
	b=ToaYnCMsM4BUh7jGSRQ8/8t75GqCeAQ/T7mQkb5xeWgG82lfhuaS2dzueN2F7a5/XS6lBYIOWrhHoukEfuiGI7BcJVbZYpNiASdjclObl4QOtUGpKNzK9u+1awn/GLdUHAZizTnZfonEI9RjUlUqNPRKQHFv3aq1I2bLPIdJ2Qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759522541;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=MyTZIankaLF5a06YDy1KIdFXkQpVaw5MiopvoWPWCGU=;
	b=F3vppZbGfNEvnAj1nGUnzqTzc6d/RQ1wfXBA7LqXa42YxPWpj2GrjraNhfqCZGBw
	FLgN9bMYm+JYnAQXmr9glUB6wM2Qi8IC0YVS8uOQSh8rLaYDfnoz6qsKoloN1Z45K7v
	xTO58NJyA6YLK5A38oz0WodX4hCt86YREa8KBUDI=
Received: by mx.zohomail.com with SMTPS id 1759522534788242.36207723608516;
	Fri, 3 Oct 2025 13:15:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 03 Oct 2025 22:15:03 +0200
Subject: [PATCH v6 1/7] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-mt8196-gpufreq-v6-1-76498ad61d9e@collabora.com>
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
control the power and frequency of the GPU. This is modelled as a power
domain and clock provider.

It lets us omit the OPP tables from the device tree, as those can now be
enumerated at runtime from the MCU.

Add the necessary schema logic to handle what this SoC expects in terms
of clocks and power-domains.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 40 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..860691ce985e560536b6c515b82441ba6d367c46 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -45,7 +45,9 @@ properties:
     minItems: 1
     items:
       - const: core
-      - const: coregroup
+      - enum:
+          - coregroup
+          - stacks
       - const: stacks
 
   mali-supply: true
@@ -92,7 +94,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - mali-supply
 
 additionalProperties: false
 
@@ -109,6 +110,29 @@ allOf:
         power-domains:
           maxItems: 1
         power-domain-names: false
+      required:
+        - mali-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8196-mali
+    then:
+      properties:
+        mali-supply: false
+        sram-supply: false
+        operating-points-v2: false
+        power-domains:
+          maxItems: 1
+        power-domain-names: false
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: core
+            - const: stacks
+      required:
+        - power-domains
 
 examples:
   - |
@@ -144,5 +168,17 @@ examples:
             };
         };
     };
+  - |
+    gpu@48000000 {
+        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
+        reg = <0x48000000 0x480000>;
+        clocks = <&gpufreq 0>, <&gpufreq 1>;
+        clock-names = "core", "stacks";
+        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        power-domains = <&gpufreq>;
+    };
 
 ...

-- 
2.51.0


