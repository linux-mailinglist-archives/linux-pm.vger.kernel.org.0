Return-Path: <linux-pm+bounces-34853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B00B7D58B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74397584A2D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005C2FBE13;
	Wed, 17 Sep 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="bIjg0A4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DD2F999F;
	Wed, 17 Sep 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111815; cv=pass; b=Hfx1qCIkLBqS4nh4ZCn9gZX38VgrrXNplq7sd6SvXFCs+hd4lgFvjnakKf2hylsyKqqllI+yunGoZ8eIVWMv19ykiLbT5t28IPucHoKPwejKFbiH4NZHPcSUeJEc1Z835e6x1PMmGSy6MMD2afkzVPAPA/xDUJ+bRx5u77BM0tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111815; c=relaxed/simple;
	bh=XnIhP7yQiaQBt9JytqTAzPjYhgCh99KUWgmMsNOQxeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOwgYNxb8byf7KoIildkWdWpXiG7PbtGPR7Pcjp9zAO7yeUyS4Y1VmHOwv5erCo9LRk3vmMH7MViKW8MLtIV4bdpFvBRH9+1k741d4FsOMEmt6bzlgwwkbK56l8nl+1LK3j7nX/P2bE1YxKzvvFWu/NbPIegGcGard+tmk7pmF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=bIjg0A4i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758111783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YWhHIKB2S29CoxvFP7qWFsagQSxmI2Vb/yqrsCFWrm9b++lzd6XqggkzOUEOVJ19y1NqLI00N5V0P+MOZfh2xsEwWdJo3cmdnIQMu8ONlm2sNziDUEt+fMnNzRtb1mME8SsT543wKxb0V7rMa4dxgtimWKPl8DtpnZiNvDbwS7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758111783; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZPHNvWMDChdk1KgHmazWkV1NbFnEmc2Tt67lRg8cQJA=; 
	b=f8tO9oC7wK3xO3uKguZHAxGspsEVya0zKgAzvxUEdUwUv/OJbGsCv+43wxTueV/+By9PuV/pcowxZykSJ8a4Ttr0OgP4WC9ePddmAm2NGrylT4NJKgSloeGd5XN4q4pCDwabuUfrARMyCZ3u5DqyQafUKwEgd275LuHtG57/2c4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758111783;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ZPHNvWMDChdk1KgHmazWkV1NbFnEmc2Tt67lRg8cQJA=;
	b=bIjg0A4iOf8smoz3P2aFnPBIVJODsMNZVvP7foTYWlJd+gBuJ7ZOGw/X5JjdJnkK
	fMROBwzjgs/nM2knorkYhE3tYcqRJsOpSBW9vegm7eCQ2N4ZXayq+u+k2seA+aNzra9
	FeGZbPfWl+VH+MSFRodUlSHr0RFT2GQ7vJ1IDbJk=
Received: by mx.zohomail.com with SMTPS id 1758111782362530.9872816275248;
	Wed, 17 Sep 2025 05:23:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 17 Sep 2025 14:22:32 +0200
Subject: [PATCH v3 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
In-Reply-To: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
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
enumerated at runtime from the MCU. It also means the mali GPU node
described in this binding does not have any clocks in this case, as all
clock control is delegated to the MCU.

Add the mediatek,mt8196-mali compatible, and a performance-domains
property which points to the MCU's device tree node in this case. It's
required on mt8196 devices.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..ccab2dd0ea852187e3ab75923e19739622b2b3b8 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -38,7 +38,6 @@ properties:
       - const: gpu
 
   clocks:
-    minItems: 1
     maxItems: 3
 
   clock-names:
@@ -54,6 +53,9 @@ properties:
   opp-table:
     type: object
 
+  performance-domains:
+    maxItems: 1
+
   power-domains:
     minItems: 1
     maxItems: 5
@@ -92,7 +94,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - mali-supply
 
 additionalProperties: false
 
@@ -106,9 +107,26 @@ allOf:
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
+        clocks: false
+        clock-names: false
+      required:
+        - performance-domains
 
 examples:
   - |
@@ -144,5 +162,15 @@ examples:
             };
         };
     };
+  - |
+    gpu@48000000 {
+        compatible = "mediatek,mt8196-mali", "arm,mali-valhall-csf";
+        reg = <0x48000000 0x480000>;
+        interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "job", "mmu", "gpu";
+        performance-domains = <&gpufreq>;
+    };
 
 ...

-- 
2.51.0


