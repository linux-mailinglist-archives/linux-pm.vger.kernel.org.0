Return-Path: <linux-pm+bounces-30697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2EB01FEA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84218A450D2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83A2EA744;
	Fri, 11 Jul 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PLZ6DB7h"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C342EA732;
	Fri, 11 Jul 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245892; cv=pass; b=eFMXdbTewklN16jxIjrJCyb1YZI5EWCoqwgxedxAQlgTh3mym3mc5tf+ltmbJBmz8MXohlzIuO2NHm+kXUuLO4w0eEDPqftqyWiF9j7/gEA5otm8aqCtdHtt86jXOH6non0WFqQgNLRBrKna/fdJAl89vexjJUOVeP4s9vTK8ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245892; c=relaxed/simple;
	bh=YLtt44xoNziAwSpmKjypho6rCb1JDd9izmCr3ewXM9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSYgZCqIFlaAvOlLArpHQXywPI6y5v7BJdBZMTBZGNf5+IeOtpkv9+T/DbtxdJjNpgX6wgAVSxSyWC1mBwtcpiHy+Yr8nhnTATHnUzIcxosDtIh5bPDz2RiUAIgiIvmXeGglu++Vm0knm90K0sYnWkP6cRTqyYy/p3zM+cRjdrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PLZ6DB7h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752245873; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AJJvdNxsOEJnho+xtOqxoDRJ6EdIYlIACMEE+8Q0YPbliNKu8R04mSm0JxqYLdb92lVRrVKZ0LSKfeu0BmfzN9ccG1V5oKu83eL5OLYerMTgvc1YDkaPhSo9nAJjuEiUuDeORfHlYEMDLjArW3+u3gt73IeDLRU6dauhddme84w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752245873; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dzcn15vklIxbdKo0iUkTyzz8Nnt7ea8eiW8ExHt379E=; 
	b=a5Spyo14Pjy3FFA+yOTDCdnu80+nBXs6Cpa6xblTxaxWgHjinAfcAJGHe58TY5nuLc5JXPvgXaqMPmiENdzHkIDx+JgdC889x12qaUmDKtsSiPOKksKyA3Gfk47am01/PKfCDTeKM88+bulkPYy0WrrDWG//dYviRJdZmZOWiXQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752245873;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Dzcn15vklIxbdKo0iUkTyzz8Nnt7ea8eiW8ExHt379E=;
	b=PLZ6DB7h7PY7nEQcuRD+SZKsEKlKQRMB9/mcbsENmfn4/MVD/ws2iJ3i9GSXYiFW
	JHMJO8IOAvylMVMC59BohWVwuVIg2ipJKmdxPXgw5zQek8q3j+pQamPBFCvE63jkczX
	vqn3TFTihMtyD7Q8O11p5WumdC7ZF6J8CPmG1yi0=
Received: by mx.zohomail.com with SMTPS id 1752245870786939.833352414672;
	Fri, 11 Jul 2025 07:57:50 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 11 Jul 2025 16:57:34 +0200
Subject: [PATCH 2/5] dt-bindings: cpufreq: mediatek-hw: add mt8196 cpufreq
 binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mt8196-cpufreq-v1-2-e1b0a3b4ac61@collabora.com>
References: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
In-Reply-To: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The MediaTek MT8196 SoC's cpufreq has three performance domains, each
with their own reg item, compared to the existing mediatek,cpufreq-hw
compatible that only uses two.

In addition, the hardware requires special handling by driver
implementations, so the new compatible is needed for more than just the
difference in regs.

Add the mediatek,mt8196-cpufreq-hw compatible, increase the maxItems of
reg, and reduce it back down to 2 for mediatek,cpufreq-hw in an if
condition.

A second example is added to help verify the binding's correctness and
document its use appropriately, though some awkward label names had to
be chosen as dt-extract-example concatenates the entire list of examples
for each binding into a single file, so naming conflicts between them
can occur.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      | 64 +++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
index d0aecde2b89b1896c01ea8ae24f26032d8075a11..cee2678b926f845ab131cecef403e127a63fabb2 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
@@ -16,11 +16,14 @@ description:
 
 properties:
   compatible:
-    const: mediatek,cpufreq-hw
+    contains:
+      enum:
+        - mediatek,cpufreq-hw
+        - mediatek,mt8196-cpufreq-hw
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
     description:
       Addresses and sizes for the memory of the HW bases in
       each frequency domain. Each entry corresponds to
@@ -40,6 +43,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,cpufreq-hw
+    then:
+      properties:
+        regs:
+          maxItems: 2
+
 examples:
   - |
     cpus {
@@ -68,3 +83,48 @@ examples:
             #performance-domain-cells = <1>;
         };
     };
+  - |
+    cpus {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mt8196_cpu0: cpu@0 {
+                device_type = "cpu";
+                compatible = "arm,cortex-a720";
+                enable-method = "psci";
+                performance-domains = <&mt8196_performance 0>;
+                reg = <0x000>;
+            };
+
+            /* ... */
+
+            mt8196_cpu6: cpu@600 {
+                device_type = "cpu";
+                compatible = "arm,cortex-x4";
+                enable-method = "psci";
+                performance-domains = <&mt8196_performance 1>;
+                reg = <0x600>;
+            };
+
+            mt8196_cpu7: cpu@700 {
+                device_type = "cpu";
+                compatible = "arm,cortex-x925";
+                enable-method = "psci";
+                performance-domains = <&mt8196_performance 2>;
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
+        mt8196_performance: performance-controller@c2c0f20 {
+            compatible = "mediatek,mt8196-cpufreq-hw";
+            reg = <0 0xc2c0f20 0 0x120>, <0 0xc2c1040 0 0x120>,
+                  <0 0xc2c1160 0 0x120>;
+            #performance-domain-cells = <1>;
+        };
+    };

-- 
2.50.0


