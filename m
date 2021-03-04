Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC932CC66
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhCDGJb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:09:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2840 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhCDGI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:08:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079530001>; Wed, 03 Mar 2021 22:08:19 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:18 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:18 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194 CPU nodes
Date:   Wed, 3 Mar 2021 22:08:10 -0800
Message-ID: <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838099; bh=AeHcRoq9hm4Y3F+W1Gxplw/dz7bL3IgrAIK7ZKNNaTs=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=naNRmYJ/G+O+i3b1zVhsYooD+1K7cWCKGfjZlcdq6TbBSO+JsQcBZUhi9f7btn7b+
         1zUDtqGiDI0Aim2OKGKzv5yxFmGe5IOcY8nlf0nnBkuGFqDXOLUjSdfw/iWOD7rTwG
         p8kRiYRRP+cZU3y01cRGtj24/v294lYycf89kGpKiCu2CmRH5aLKQE2ixxynTC1UMS
         S1+/a+41C3akernmDyc5eY1wzXql976hFxanmeF1hkLtrdyBVQH3mkq2ITMUEMqy8z
         mHUKl66hdWEB+EGFqADOD2GQycZy1JSb3xJxlKPJW2DcqwtmtSaJByiWAvC8FajoX8
         yHItFQPl1rW/Q==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds cpu-idle-states and corresponding state nodes to
Tegra194 CPU in dt-binding document

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
index c9675c4..e1a5005 100644
--- a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
+++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
@@ -30,6 +30,36 @@ properties:
       Specifies the bpmp node that needs to be queried to get
       operating point data for all CPUs.
 
+  cluster-deepest-power-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: CPU cluster deepest power state ID.
+
+patternProperties:
+  "^[a-z0-9]+$":
+    type: object
+    description: |
+      CPU core idle state nodes.
+      Refer to Documentation/devicetree/bindings/arm/idle-states.yaml
+
+    properties:
+      compatible:
+        enum:
+          - nvidia,tegra194-cpuidle-core
+
+  cpu_crossover_thresholds:
+    type: object
+    description: CPU idle states crossover threshold time in uSec.
+
+    patternProperties:
+      "^[a-z0-9]+$":
+        type: object
+
+        properties:
+          crossover_c1_c6:
+            $ref: /schemas/types.yaml#/definitions/uint32
+          crossover_cc1_cc6:
+            $ref: /schemas/types.yaml#/definitions/uint32
+
 additionalProperties: true
 
 examples:
@@ -39,12 +69,14 @@ examples:
       nvidia,bpmp = <&bpmp>;
       #address-cells = <1>;
       #size-cells = <0>;
+      cluster-deepest-power-state = <0x6>;
 
       cpu0_0: cpu@0 {
         compatible = "nvidia,tegra194-carmel";
         device_type = "cpu";
         reg = <0x0>;
         enable-method = "psci";
+        cpu-idle-states = <&C6>;
       };
 
       cpu0_1: cpu@1 {
@@ -52,6 +84,7 @@ examples:
         device_type = "cpu";
         reg = <0x001>;
         enable-method = "psci";
+        cpu-idle-states = <&C6>;
       };
 
       cpu1_0: cpu@100 {
@@ -59,6 +92,7 @@ examples:
         device_type = "cpu";
         reg = <0x100>;
         enable-method = "psci";
+        cpu-idle-states = <&C6>;
       };
 
       cpu1_1: cpu@101 {
@@ -66,6 +100,25 @@ examples:
         device_type = "cpu";
         reg = <0x101>;
         enable-method = "psci";
+        cpu-idle-states = <&C6>;
+      };
+
+      cpu_core_power_states {
+       C6: c6 {
+         compatible = "nvidia,tegra194-cpuidle-core";
+         idle-state-name = "CPU powergated, state retained";
+         wakeup-latency-us = <2000>;
+         min-residency-us = <30000>;
+         arm,psci-suspend-param = <0x6>;
+         status = "okay";
+       };
+     };
+
+     cpu_crossover_thresholds {
+      thresholds {
+        crossover_c1_c6         = <30000>;
+        crossover_cc1_cc6       = <80000>;
       };
+     };
     };
 ...
-- 
2.7.4

