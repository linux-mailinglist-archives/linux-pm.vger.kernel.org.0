Return-Path: <linux-pm+bounces-30934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4AB07C4D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA6A7ACB11
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B4285043;
	Wed, 16 Jul 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Rjqul+t8"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371E27F006;
	Wed, 16 Jul 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688309; cv=pass; b=h/etU8UIoZdC8PAWRjTsFtuMvthOD72i3JYH2NFIY8h17vZMcGVlCN2aHZe1FGWnq6YRwImQsQot9Uqea61CeS8BsgviSOf+IeZNBjzKmaXbcfyYabhmG4u0Nbdlv862WZqumD1GDD7BMgGT1CHcraP4ohB8DPmjWQ7Cjh1kEOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688309; c=relaxed/simple;
	bh=n8eTmJHFPK+87Ro15/PECQdlwAnPjm6LOtCx/hHBK1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9q8bDEfvO1X25dZqOrSWykVrWasHxMV8s/nfZh3S4OPE4zchZMfj4ZMm4y6uifUg08jwVtuq/HrA8vlFTMNKR4NcSXEnsBnVyLFusSwaQ+xySmHg3yAEZczhfRV2OojEbrq2nR8dQ0SPJqBZ1T6PdURgBdSczkwDUtutf4WsQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Rjqul+t8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752688291; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bPRBQxPfnwzs1gjZA3GgAFdfwbegJ17WohAHpaWx7n5firjUOwZjudlgjU/kganPPPpTd3Oojxsk5Us5XvEaWs0pScWv2mzGJHvuq2ilKkSrH0FwWjGwvchbWUFKQ3yivyrSbX7hU/hlSaRHCXvYtUmFK0tDdaIE1UQPHk1EKNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752688291; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3+1vi8bZzQ07I9vWMHC48+ZnxZElk7NeHkY4J8vrkhM=; 
	b=Yr3GeeYhK+9QsDs+MitvcYMFj4OBBiW27xK9Tjc9wxMJM4Uf5pDh8EkTr46UHuHyCM2Rf300y5SKY9CVFGxupbzSVYVsZyX1Jo0RQw5FSfO/8uNTMRilWoGalqoHbBLuPZVN7wKOO+sGra/c/f+v5+nfCl5sNZBLAD3AIlfmuVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752688291;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=3+1vi8bZzQ07I9vWMHC48+ZnxZElk7NeHkY4J8vrkhM=;
	b=Rjqul+t8exoR/AN8FvRtQnmIckb7djHzQdpCNdZfetUdtV92ecDRruyBxC1pYJ89
	PDthIhpOz1bTDcH7sSwUls7roS4NK9CPZPSoFT3X10s6jmuK4phUVGwm7ofnPRrSawZ
	ryw+EqAwn8Pv/IHYHYhUMVJE4sOiL1nblSma5EBY=
Received: by mx.zohomail.com with SMTPS id 1752688289851648.2288655206119;
	Wed, 16 Jul 2025 10:51:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 16 Jul 2025 19:51:22 +0200
Subject: [PATCH v3 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-mt8196-cpufreq-v3-1-d440fb810d7e@collabora.com>
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
In-Reply-To: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The MediaTek MT8196 SoC has new cpufreq hardware, with added memory
register ranges to control Dynamic-Voltage-Frequency-Scaling.

The DVFS hardware is controlled through a set of registers referred to
as "FDVFS". They set the target frequency the DVFS hardware should aim
for for each performance domain.

Instead of working around the old binding and its already established
meanings for the reg items, add a new binding. The FDVFS register memory
region is at the beginning, which allows us to easily expand this
binding for future SoCs which may have more than 3 performance domains.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5f3c7db3f3aa0abf90061b2d735f975135cb35eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/mediatek,mt8196-cpufreq-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Hybrid CPUFreq for MT8196/MT6991 series SoCs
+
+maintainers:
+  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+description:
+  MT8196 uses CPUFreq management hardware that supports dynamic voltage
+  frequency scaling (dvfs), and can support several performance domains.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-cpufreq-hw
+
+  reg:
+    items:
+      - description: FDVFS control register region
+      - description: OPP tables and control for performance domain 0
+      - description: OPP tables and control for performance domain 1
+      - description: OPP tables and control for performance domain 2
+
+  "#performance-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#performance-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cpus {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            cpu0: cpu@0 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a720";
+                enable-method = "psci";
+                performance-domains = <&performance 0>;
+                reg = <0x000>;
+            };
+
+            /* ... */
+
+            cpu6: cpu@600 {
+                device_type = "cpu";
+                compatible = "arm,cortex-x4";
+                enable-method = "psci";
+                performance-domains = <&performance 1>;
+                reg = <0x600>;
+            };
+
+            cpu7: cpu@700 {
+                device_type = "cpu";
+                compatible = "arm,cortex-x925";
+                enable-method = "psci";
+                performance-domains = <&performance 2>;
+                reg = <0x700>;
+            };
+    };
+
+    /* ... */
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        performance: performance-controller@c2c2034 {
+            compatible = "mediatek,mt8196-cpufreq-hw";
+            reg = <0 0xc220400 0 0x20>, <0 0xc2c0f20 0 0x120>,
+                  <0 0xc2c1040 0 0x120>, <0 0xc2c1160 0 0x120>;
+            #performance-domain-cells = <1>;
+        };
+    };

-- 
2.50.1


