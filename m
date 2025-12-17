Return-Path: <linux-pm+bounces-39661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D5CC9163
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C374231C7B28
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224933CE85;
	Wed, 17 Dec 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TYF0e3zq"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69633A9E3;
	Wed, 17 Dec 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991066; cv=pass; b=OdvSNVFZ4tcBo4zXmUujgFm8cBfCx+SZMCRswt7WjUurc5thoPnJWsDK6rqX8SNrW6vp5zMQGzOvrwchVNv1/83W6IMORVE7xIMoE4eG1WlY3mE7ZkVj9tVsBgyj2u0rEuid594eqoW8Xs1MnsjK9BTDNQjmU60TMVTjHYSr7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991066; c=relaxed/simple;
	bh=4sq6E36JCBJ2UveeXTFD78ZCyLlw2rbM4xzZTTVHbHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anUC6Tj4ruIKraGf0QQ6HWRhNISveBq3eLv163pJ/hSdVkHJRZXK0/zObp8wAOVauZFz4YGaDbHEjB0CfYc90NjcziSC34fP4gjwQRRUGuRrABGcr0urrh9smqq63Qr46W7686so2XlyM9qINkYhZaq4CMr0QpDtCIbGQDbKhZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=TYF0e3zq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765991046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RdZEoObAi69A7BXQH+VVF3hMq4oOW5uPwfCNNqxQkVqeekoWEPWPh/G8o/j18RjeYm2ATJ/8n8QqzPOUhVlrg0hiypKPSBxMXemRLNNPwP0aXjCVVKUYZmbqKfqY3hGrjENjrNWssv5219GNgnNjygnbkwm1ZAN5mxdiLrxijd8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765991046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J0hm26JZwx6v0Ry2T0SEUpthc+tXhioEHL+8VAV//SU=; 
	b=msX9GsQspDMB1LSW9AKbYEUdb5PR35fIDUO23uHN7p6vUQRG0r+RpaxgpjsUjf7nUPClpM5cFi5wp3zN1GApfMvYXwDQDBtUlYerTzSmOEKKBukBgEpKJG6Dj9JaFuwTKqIkdTcdS/zajgWrYsD2e4JRWyI6/LWBWq+FhNpxTDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765991046;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=J0hm26JZwx6v0Ry2T0SEUpthc+tXhioEHL+8VAV//SU=;
	b=TYF0e3zqs2OyQJdTA5j8qvuLHjvvlb07BeVcVQWey27yJ4sB2r3uAXdujYuAeZJF
	pOFIeXuXOQvDDZ4kAJu2E40hTK++vSvcqqaMJyw8Ac8nLL0CbehQSCnovc7ud/SNAuM
	5gPhibIl37GtM9bp+JwNupALEiY6YzI/n7Ft5dzQ=
Received: by mx.zohomail.com with SMTPS id 1765991044199539.6895741631515;
	Wed, 17 Dec 2025 09:04:04 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 17 Dec 2025 18:03:27 +0100
Subject: [PATCH 1/4] dt-bindings: gpu: mali-valhall-csf: Add shader-present
 nvmem cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-mt8196-shader-present-v1-1-f6f8f3aa1e93@collabora.com>
References: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
In-Reply-To: <20251217-mt8196-shader-present-v1-0-f6f8f3aa1e93@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

On the MediaTek MT8196 SoC, the bitmask for which shader cores are
present and functional is not the one in the Mali GPU's registers, but
in an external efuse.

Add the nvmem cell properties to describe such a setup, and make them
required on MT8196.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index bee9faf1d3f8..8eccd4338a2b 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -51,6 +51,14 @@ properties:
           - stacks
       - const: stacks
 
+  nvmem-cells:
+    items:
+      - description: bitmask of functional shader cores
+
+  nvmem-cell-names:
+    items:
+      - const: shader-present
+
   mali-supply: true
 
   operating-points-v2: true
@@ -108,6 +116,8 @@ allOf:
       properties:
         clocks:
           minItems: 3
+        nvmem-cells: false
+        nvmem-cell-names: false
         power-domains:
           maxItems: 1
         power-domain-names: false
@@ -133,6 +143,8 @@ allOf:
             - const: core
             - const: stacks
       required:
+        - nvmem-cells
+        - nvmem-cell-names
         - power-domains
 
 examples:
@@ -179,6 +191,8 @@ examples:
                      <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH 0>,
                      <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH 0>;
         interrupt-names = "job", "mmu", "gpu";
+        nvmem-cells = <&shader_present>;
+        nvmem-cell-names = "shader-present";
         power-domains = <&gpufreq>;
     };
 

-- 
2.52.0


