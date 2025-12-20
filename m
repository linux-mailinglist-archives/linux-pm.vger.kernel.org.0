Return-Path: <linux-pm+bounces-39727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AF7CD3587
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E922E301A73D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC4310630;
	Sat, 20 Dec 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ItW7jbSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8C30FC22;
	Sat, 20 Dec 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256692; cv=pass; b=Zo3wH7Is+JZEbuoNKBWKsJ3mdYU3ofFZU7RM8Ig3GFG7zpwa0vcDIJdjcyhBTHc66s+C8op19PQmbXrsOf755Kphos7BFrt58K3WMy3MuOQ8HGXkq41Oa9wTlvLWeb7XgXkWAmkmTuEbH4Zw6LefWNDu7Zf4BRiu5jsixCm7j4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256692; c=relaxed/simple;
	bh=ttC9oOJ4k8J1XToYpWDv/nbXkNlNjaFMSyqfvuK/aiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGgdK8CB+9oZtRW01egZwZVw1HvyJ+Dl1MeFAU6DizL2a8nJuYdD5fPgD5k/3XL3W9UvWy1DMzkW5flU9wpiFmNuSjvJLcRsBGrkWkFuDfE3FmzE0SHG7wybol6eLJGtmxLq+/ync9oVX62ViOuXZ0Tx2PBNcyGptgOlKnn9DLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ItW7jbSZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766256635; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RcSApAUIVHOQQ/PxKnGD95WnMzfQvGyERWSxzZMbadXIeaP0GjeVMJE1dpYqFjvkS3Z8RvxlJ+apXRiuNwoTwkS53Wzi1neqpgLaAurOwhhB2mOIPcQBiSamSZSbcytmHzi6A5P9XPkLOlDG6T07cGKdz9M3cIH2qUXimMYS9Kk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766256635; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cKOC4sPnmtkQ7L+JdsUlBb5Bsh8vjqzfoYmPcpjnenM=; 
	b=gXoPv05aAM4S9McpI7E5eUhlRoG5iRR+B6VmdOdKkSqrxNTHuxR9HuO83Tq1Wcw5ICftOPCSS22TxcMzT1VGoWSk8fUwm9F1kzyQvX6He/R9uJ67I1Z061GCevUC3vvQ1T1OPxRNmdR6WIir+XWzYGVNnkm36WA1rlGRo+9TSMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766256635;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cKOC4sPnmtkQ7L+JdsUlBb5Bsh8vjqzfoYmPcpjnenM=;
	b=ItW7jbSZjDFdna655b7OCzhvdzkW0QxENSTZ6BK+Jp7zm4AIrDNFQHft3sklcy7T
	2Wx+pRZtz90Eg7AZ8rLe3Q9N8YHUUf8Ie3FcC6PFyvq4aRMkz+1bXRgBo/ASAFDpj6P
	uZa6RFtTQ/4w4N+GpTwBMIYIZFAgVjr3K2j5NX90=
Received: by mx.zohomail.com with SMTPS id 1766256633664149.3015413763843;
	Sat, 20 Dec 2025 10:50:33 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 20 Dec 2025 19:49:53 +0100
Subject: [PATCH v2 2/4] dt-bindings: power: mt8196-gpufreq: Describe nvmem
 provider ability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-mt8196-shader-present-v2-2-45b1ff1dfab0@collabora.com>
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

On the MediaTek MT8196 SoC, the Mali GPU's "shader_present" hardware
register may also include a non-functional shader core, along with the
present shader cores. An efuse elsewhere in the SoC provides the
shader_present mask with the fused off core omitted.

However, the efuse address is not publicly disclosed. What is known
though is that the GPUEB MCU reads this efuse, and exposes its contents
in the memory it shares with the application processor.

We can therefore describe the mediatek,mt8196-gpufreq device as being an
nvmem provider for this purpose, as it does provide nvmem access in an
indirect way.

The shader-present child node is left out of the list of required
properties as we may one day be able to describe the actual efuse region
this value comes from, so the gpufreq device isn't necessarily the only
device that can provide this cell, and implementations shouldn't need to
implement this functionality once this is the case.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
index b9e43abaf8a4..66fc59b3c8b4 100644
--- a/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
@@ -74,9 +74,18 @@ properties:
   "#clock-cells":
     const: 1
 
+  "#nvmem-cell-cells":
+    const: 0
+
   "#power-domain-cells":
     const: 0
 
+  shader-present:
+    type: object
+
+dependencies:
+  shader-present: [ "#nvmem-cell-cells" ]
+
 required:
   - compatible
   - reg
@@ -113,5 +122,9 @@ examples:
                      "ccf", "fast-dvfs";
         memory-region = <&gpueb_shared_memory>;
         #clock-cells = <1>;
+        #nvmem-cell-cells = <0>;
         #power-domain-cells = <0>;
+
+        shader-present {
+        };
     };

-- 
2.52.0


