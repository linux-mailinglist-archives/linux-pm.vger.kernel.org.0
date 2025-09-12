Return-Path: <linux-pm+bounces-34567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77837B5565C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626F21B235B0
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA130E830;
	Fri, 12 Sep 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IuzaXCrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F0322DA1;
	Fri, 12 Sep 2025 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702290; cv=pass; b=cIiFnMAQ5mNTkYiCD+9+3O7uVVtrNj7xoV7Vv+FPzu1SIiIp/v1FRpEZ4mH2eTL+YLfXHbHq12jBjxrUMLybhfpUq9jNp0XrtxJOXj6s5/rABdmqRM/cDXlCtyagTOWCAjO8B/FB40BU7ljAcnvTNywSEnIfQro9V1Aj65y5nBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702290; c=relaxed/simple;
	bh=F453NAbKHQxKALRGtrMTD9hbrreE2rO6rqwharzVOo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dcv/5G0By1us4Qqpa+hKrueWc7GYMwqqxGjZD8AgKeAePgZpwghwxK+tfhHwWNAEZwg8uLPVfD5eqsOrrd9cO+SzEsrnctvGoHEuenrgpZWljPvp1XXqWL4pMl59ndtbONd6iBLEgPMn25eOwgZjVPjbL1rvuVia4/krYVoNSBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IuzaXCrb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757702254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nMlPsYpy2O8sEcroQQZEZB2sKLF7HSiNy8bY58RoZ1PGORvnrM+Q4n+80vKG6cj2AtW6WMAyLT0yDU/mPwrSW1Fww0kbNL3bevFRdcBKcnS3WutXjspb0OROZ1qsQpgHvnOsgsHTRTkvQUxLNT5l7zu7QXD8o1bLAmSpJFEiONo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757702254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O8WVt9Ctmn2q0vEpVu4PvAu7OrnSPQKmq2jz3bFRmnY=; 
	b=feGg57ILtO1r890uqwsMAFPu7FWpIIBgqs2qrm7uRNzvdkjDuN3g2102FETPss5Zz1vZ4b3IsY8GBJKUOrXGl398hsaAnmsm5+rkW4GH2leQwV+Usidh3/IJ1+tMWoR6BzK0+OsKwFlhy3dImyADMDFWSTxGfSD5XvTTvMKmhEo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757702254;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=O8WVt9Ctmn2q0vEpVu4PvAu7OrnSPQKmq2jz3bFRmnY=;
	b=IuzaXCrbeixNucRXQlr1GWvGgkjWhmvEIGSFxjrTvwfbEde7Yrg8lpjswtQ5ifuM
	kf2gYL/EIjY6rkh5WLbij9F1pctgZvCwYqowX1q23sKAGwv3nJTGdAH9XkPJHdFat90
	QEEy0Ekcjfe9MHOKdrZFpeJjRpt51CW0Tgrll0dk=
Received: by mx.zohomail.com with SMTPS id 1757702252894215.80562166132404;
	Fri, 12 Sep 2025 11:37:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 12 Sep 2025 20:37:00 +0200
Subject: [PATCH v2 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-mt8196-gpufreq-v2-1-779a8a3729d9@collabora.com>
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
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
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
control the power and frequency of the GPU.

It lets us omit the OPP tables from the device tree, as those can now be
enumerated at runtime from the MCU.

Add the mediatek,mt8196-mali compatible, and a performance-domains
property which points to the MCU's device tree node in this case. It's
required on mt8196 devices.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e00217587c5d1f889094e2fff7b76e6148eb..163b4457f7f25dcdd509c558558a73694521c96d 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3588-mali
+              - mediatek,mt8196-mali
           - const: arm,mali-valhall-csf   # Mali Valhall GPU model/revision is fully discoverable
 
   reg:
@@ -53,6 +54,9 @@ properties:
   opp-table:
     type: object
 
+  performance-domains:
+    maxItems: 1
+
   power-domains:
     minItems: 1
     maxItems: 5
@@ -91,7 +95,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - mali-supply
 
 additionalProperties: false
 
@@ -105,9 +108,24 @@ allOf:
       properties:
         clocks:
           minItems: 3
+        performance-domains: false
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
+      required:
+        - performance-domains
 
 examples:
   - |
@@ -143,5 +161,17 @@ examples:
             };
         };
     };
+  - |
+    gpu@48000000 {
+        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
+        reg = <0x48000000 0x480000>;
+        clocks = <&mfgpll 0>;
+        clock-names = "core";
+        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        performance-domains = <&gpufreq>;
+    };
 
 ...

-- 
2.51.0


