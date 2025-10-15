Return-Path: <linux-pm+bounces-36166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D02BDD883
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275734FFA4B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F5319879;
	Wed, 15 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ciqQhiSO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DB318157;
	Wed, 15 Oct 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518273; cv=pass; b=D3Qz+Q86r78V9u7mg9+xSnjOAxbr2sNwAJ0Jk6xF38H5UMU4Yv6PSl3pHUFGtR+2dCHlIiXvwb2u1wQBHQ/+/8LEOMuhGPsb4uUbMUpahj7IOKlVwxMuZLWsLefrfMlGvwoLr9SXDe9excRBFrT+PiV3s8lw+RsA/AFWwLYxp0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518273; c=relaxed/simple;
	bh=unvPGOFriIHpUd82ExLn3Mme5GmCeuM02RDXIWOXQD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRtppFCFU/6Sj0ycmvRIaVXicku+n6VfABDCF8c3rkrMz88k4EqX9WiY2p7mhbpc9Vzmx3faSyjr6EV92Ayvz2Dt59O12tmp562QzJlTdifSJlEhXwSoGXZflRZPRJy1TYv7pxCe5Hk0v9pPX1iYFaNxC2uDltDvb/SZKP3vh/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ciqQhiSO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760518235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KU8nsY1uLYKqlLextu1or7O4qacnlTQntvNei8N1+k6B36fmsuv0IuS4fTJRCJ7/wSMsNwvj/BmWwUZNsLkMtt8lvh092oIaPZTMnFv9oT2+08fyhyChJmB+3OPi9H7xPCaouMa01SRCDvAyt1Bu1teKcBjXPD1Qy/wkFoWDot4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760518235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5kCSOGJcwbOC+7+5BLR+gRNJdgGMuPaf20hsggRiPEw=; 
	b=l18bYoWFWRlTkoARZ2Rhz0hhU9XkV1Jn5QINewgsVU0sKZfN6x/MJbdyfgbA/fRVQZO57olHYWQK9AyDGYg5u74ckz8gYsU03Tsil+HRuY+hcG9X+VWOZEjBYShvpA/JFPkT7boTVG9Fz01Q1nQfseLriyK19qE8bTleOX9sN+o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760518235;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5kCSOGJcwbOC+7+5BLR+gRNJdgGMuPaf20hsggRiPEw=;
	b=ciqQhiSOoHqcRCrAKnG6Hky0cvRZ8VYuO+6TtT+Hy7mCD5fuqjYLxv9KClVpxm/5
	Zur2WSISTw7sqJzpha4SydW+rO7FBikFLhq/tLAsOzHJrhY2gQkcsM28YdgF6Gc2kvc
	EmnkgYEu6eU/BxIWszrDhA4Aw4hsk2CDLgmCxzRk=
Received: by mx.zohomail.com with SMTPS id 1760518223888154.97368582539445;
	Wed, 15 Oct 2025 01:50:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 15 Oct 2025 10:50:00 +0200
Subject: [PATCH v7 1/5] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-mt8196-gpufreq-v7-1-0a6435da2080@collabora.com>
References: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
In-Reply-To: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
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
X-Mailer: b4 0.14.3

The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
control the power and frequency of the GPU. This is modelled as a power
domain and clock provider.

It lets us omit the OPP tables from the device tree, as those can now be
enumerated at runtime from the MCU.

Add the necessary schema logic to handle what this SoC expects in terms
of clocks and power-domains.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/gpu/arm,mali-valhall-csf.yaml         | 37 +++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index 613040fdb444..860691ce985e 100644
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
@@ -110,6 +112,27 @@ allOf:
         power-domain-names: false
       required:
         - mali-supply
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
@@ -145,5 +168,17 @@ examples:
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


