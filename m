Return-Path: <linux-pm+bounces-39729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED13CD3599
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 19:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3A13024ADE
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A67311977;
	Sat, 20 Dec 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jEa18x1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE373101B4;
	Sat, 20 Dec 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256693; cv=pass; b=ky/GxONuylnP9D5xoknKYJQgI4MfF9Dx4+6KK83RagFSdCOvQIq4D2incCE8GaQRO710g632olzSvCpkm6A6nzQKwez5+9p/9xG6ZeuI72pDUepazr69KGl8epe/IRhV5eq93rYm3/AeeiquQPLDcFswXnFEgUY83uPG0vmoVPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256693; c=relaxed/simple;
	bh=l8GFAMteQwDOPcHMRwlYGJAGz14nVP7EwRua/mTh5A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9JTpxp8JkNtYate9LCuuVRDh9QCm0qHAwejfoJIcnsNYSlzs4YEsMSwtvmfmWhFwTBcDeL3MH1RwykemFzk5BC2TU0FKyFtpWxY0zZmEKloOOs54iLbSspSx7fqis5/H/uixhDOLxJbxCgpc8dKtNay5F5sSSzLkWQPWjCpYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jEa18x1N; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766256629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G8xgTZWTJjB4ImOOXFRogkyAppca3TcwYZiVjfFeoWw4cnf3J6yz1l0TmFFFM69NVBZKqPXvn9qVxy8axHJzrAjdanOreLGymgDlXr19Y7ud5gjoh2mrcYVQCCz+DN4sKfQKMUF7CBihUxC0XwKABVYfHrqRvrjJR46bDyrf8vw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766256629; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8IbRY714eO2zGl6q64FE7lg6CXtlWXzXvxXQfYH5rwI=; 
	b=kyZmEgzFo3uCZqEt92Fqf1irIMioiyGvG4VCWM0XG6OY1+lX1o6vtUu9yFuocGMKQrBoM8gmxJc4Qk57fsYGruRAVHkLTy5x7LTZ9A1WgvOc+3Jovg7Bsf/zfk5g43lC+OivDYF4gltniOLqdMvn6Sn8r+TyP5acGEdedyGK7Cc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766256629;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8IbRY714eO2zGl6q64FE7lg6CXtlWXzXvxXQfYH5rwI=;
	b=jEa18x1NgxTIWetBz2e1aTELkeupFac1ViPHoq7QhKZkaVQrtk55dqLMOL0RR9hZ
	b8KoIp+hlNHz9aVpsO0h+1GKcn9zR0Ai4Px2QJm5PBEz3xdUYuBTqMexCkgRUYF/pEU
	8FII1oDeCA1XiYsC9keOrmMm7hYhBu7JiR2iX/jE=
Received: by mx.zohomail.com with SMTPS id 1766256628125717.7120182725639;
	Sat, 20 Dec 2025 10:50:28 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 20 Dec 2025 19:49:52 +0100
Subject: [PATCH v2 1/4] dt-bindings: gpu: mali-valhall-csf: Add
 shader-present nvmem cell
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-mt8196-shader-present-v2-1-45b1ff1dfab0@collabora.com>
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
In-Reply-To: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


