Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B021F6B3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGNQID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 12:08:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5846 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNQID (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 12:08:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0dd7f10001>; Tue, 14 Jul 2020 09:06:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 09:08:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 09:08:03 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 16:07:59 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jul 2020 16:07:59 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0dd85a0001>; Tue, 14 Jul 2020 09:07:58 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ PATCH v6 1/4] dt-bindings: arm: Add NVIDIA Tegra194 CPU Complex binding
Date:   Tue, 14 Jul 2020 21:37:50 +0530
Message-ID: <1594742870-19957-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
References: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594742769; bh=1dBLDP4PGuNfttH15wzchZO1kkAghBjJKlbYsdl9U78=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nIxTOnai/j/kl+2qVXVH+6Je2bGs6nQeYnTZZDcc4CRZudogNcl9paf7xq8okJS38
         oLSimMmro9r3f0ii31RxC/GqngyM0lUfTTPicn7zs4O+LXerwxbMEEu/nZ3ZsN+Zfh
         0HT+dajlM1GVRFicMnJ/0Sir/lVbfFtSLOHlA9/C/vwttc1FZujFdPAQ791GS8NMty
         gvoQsPQz4XCPsmhpVShwvcZ15C3a2hW+SfrqWijxRthoAvLMhXCJxteaYizDJNiwab
         CwhFeym3QxhOdPiCQ79iRoFDMiiCrjMYyit/61qJ+lOCqWAhO+ZNhFg6d3+4POLzla
         fhhYmokcuFqyg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device-tree binding documentation to represent Tegra194
CPU Complex with compatible string under 'cpus' node. This
can be used by drivers like cpufreq which don't have their
node or CPU Complex node to bind to. Also, documenting
'nvidia,bpmp' property which points to BPMP device.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml

diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
new file mode 100644
index 0000000..06dbdaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/nvidia,tegra194-ccplex.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 CPU Complex device tree bindings
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  Tegra194 SOC has homogeneous architecture where each cluster has two
+  symmetric cores. Compatible string in "cpus" node represents the CPU
+  Complex having all clusters.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra194-ccplex
+
+  nvidia,bpmp:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the bpmp node that needs to be queried to get
+      operating point data for all CPUs.
+
+      Optional for systems that have a "compatible"
+      property value of "nvidia,tegra194-ccplex".
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+dependencies:
+  nvidia,bpmp: [compatible]
+
+examples:
+  - |
+    cpus {
+      compatible = "nvidia,tegra194-ccplex";
+      nvidia,bpmp = <&bpmp>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpu0_0: cpu@0 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x0>;
+        enable-method = "psci";
+      };
+
+      cpu0_1: cpu@1 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x001>;
+        enable-method = "psci";
+      };
+
+      cpu1_0: cpu@100 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x100>;
+        enable-method = "psci";
+      };
+
+      cpu1_1: cpu@101 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x101>;
+        enable-method = "psci";
+      };
+
+      cpu2_0: cpu@200 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x200>;
+        enable-method = "psci";
+      };
+
+      cpu2_1: cpu@201 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x201>;
+        enable-method = "psci";
+      };
+
+      cpu3_0: cpu@300 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x300>;
+        enable-method = "psci";
+      };
+
+      cpu3_1: cpu@301 {
+        compatible = "nvidia,tegra194-carmel";
+        device_type = "cpu";
+        reg = <0x301>;
+        enable-method = "psci";
+       };
+    };
+...
-- 
2.7.4

