Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07839220E26
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgGONbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 09:31:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12939 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbgGONbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:31:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0f05020001>; Wed, 15 Jul 2020 06:30:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 06:31:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Jul 2020 06:31:41 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 13:31:39 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Jul 2020 13:31:39 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0f0536000a>; Wed, 15 Jul 2020 06:31:38 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v6 1/3] dt-bindings: arm: Add NVIDIA Tegra194 CPU Complex binding
Date:   Wed, 15 Jul 2020 19:01:23 +0530
Message-ID: <1594819885-31016-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594819843; bh=aJzkPyWAiProNVsIFDsOkvEDW2GKxcvlLuorTbB1t80=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PBtgQHFpqbhjEiTlJmYrFFSppK/mvwPG7+DQFiOT444pZ0YsFXDmAv08/rsDdhMcU
         lYuqhppSjqi/tXQx/0NIjQYj95Y82dk7Qp5iiJM5JA3u8rlmg6LaHkF6cDUTyqHeNO
         FVB7u5I/usJksbTiEf7hzwN7PIQoe4QCJX/+ftS3XS/E7oReadQzWkjFZ3sNF5Rga0
         dS7E1LDGXyRbkShM5JLwS62k6xhQGBOrMb+J8aO1D7s0vb6Klej44HDUQpFA2owVWR
         aJ0GWNAUZDAXtAOKdhKQ/tJa2yRtcTe34VKdYZCzUJtzqKEroHd93koml4h2XyKkuX
         mF15VLXu/2+Fg==
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
 .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml

diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
new file mode 100644
index 0000000..1043e4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  $nodename:
+    const: cpus
+
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
+    };
+...
-- 
2.7.4

