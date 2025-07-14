Return-Path: <linux-pm+bounces-30800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721FB04108
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F3B3A36A2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D712550AD;
	Mon, 14 Jul 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PbtmtBnt"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AF25487A;
	Mon, 14 Jul 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502142; cv=pass; b=XtK1Ad6GCk+6IXkaBO2uHQ535TPk/FE3I1SB0rJwL51v8wh9S2ZP4Hx0wH0B6bRrNR+afw4NwSi7cVq4oMnLq7IShu2qJE/7L9Q28xG5FTM7zwyoi4ppPhr1NddJnJizB+HTau36P4ozoXaV7RUfGEery79ATGLIn7ixP1OdzVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502142; c=relaxed/simple;
	bh=DyE00FQQcVIJDfFG/s7v2hZ5Ny7wTLLb2HbgheaPhuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXTQDoNJxTbZ7MOhgHqf7W7t120RAAOdStzbdNnFOqU+tbGncYRcl7MN30RBP+PE/yzT2ZWpMeMgd6ZErv6NXYHUp89B4slI8/tSpJtcw/y+99NWtOL6riw2v5yudIN0olodLqh/qrKbDPIGJtTH2D9U2HkNh4en4aQVC3+NrsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PbtmtBnt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752502115; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g5b0fQ33w0mBOU0W69Sj9WQvn1mS0dem8B7L44jg3B0cqmc75fBWy/Apgznc5AULhxa0IMUw2VJJ/rQ5YvNKyYUPFhdgqlfki9jyJ2jcN5r4x0w6Ba+3Nr+Xse8H554yk31QgJzm1XX0ssHwSAWRwVCU4PxjgK3aGit9F7+noMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752502115; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jEhtdpIHUaCWWVMpS6h9pG+ezJ1H5i0vcgbppdJiInc=; 
	b=MyQmGqZyz39lksZtS/Rv5fGxxSrcdBKMr4uyl0zpH5moirTKdhI9RyWgVKGztkul+880QOMXalVE7+baVp8aKiAb7tRjCjLak1hPFhNdILTTSnviBHQF2/wMHB16kUpJcyXgAOZRFEjHKxGyGtZAzmOXciWm/zdUlgpAcqgLpu4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752502115;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=jEhtdpIHUaCWWVMpS6h9pG+ezJ1H5i0vcgbppdJiInc=;
	b=PbtmtBntlL3qEeoZnc13L9h2LJwkX8NOAljQurTH0yI+4sO2+BExYtRoVJ7tmiDW
	SHjI5emM34tv21NGWl+weUUqS31/AMBRlwPhFj7Ebjodau1AvN/kMZC1kqn9LUbrna3
	Vmog7vCirb5T0H2G8qTzmrp/6nZJnRRQrRBHum/o=
Received: by mx.zohomail.com with SMTPS id 1752502113853539.0996011954999;
	Mon, 14 Jul 2025 07:08:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 14 Jul 2025 16:08:14 +0200
Subject: [PATCH v2 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-mt8196-cpufreq-v2-1-cc85e78855c7@collabora.com>
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
In-Reply-To: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
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
as "FDVFS"; one is a location from which a magic number is read to
ensure DVFS should be used, the other is a region to set the desired
target frequency that DVFS should aim towards for each performance
domain.

Instead of working around the old binding and its already established
meanings for the reg items, add a new binding. The FDVFS register memory
regions are at the beginning, which allows us to easily expand this
binding for future SoCs which may have more than 3 performance domains.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..26bf21e05888646b4d1bdac95bfba0f36e037ffd
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/mediatek,mt8196-cpufreq-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek CPUFreq for MT8196 and related SoCs
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
+      - description: FDVFS magic number register region
+      - description: FDVFS control register region
+      - description: OPP tables and control for performance domain 0
+      - description: OPP tables and control for performance domain 1
+      - description: OPP tables and control for performance domain 2
+
+  "#performance-domain-cells":
+    description:
+      Number of cells in a performance domain specifier. Must be 1.
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
+            reg = <0 0xc2c2034 0 0x4>, <0 0xc220400 0 0x20>,
+                  <0 0xc2c0f20 0 0x120>, <0 0xc2c1040 0 0x120>,
+                  <0 0xc2c1160 0 0x120>;
+            #performance-domain-cells = <1>;
+        };
+    };

-- 
2.50.1


