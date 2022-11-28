Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C563AAED
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 15:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiK1O3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 09:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiK1O3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 09:29:35 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1B22503;
        Mon, 28 Nov 2022 06:29:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6BABC41F4A;
        Mon, 28 Nov 2022 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669645770; bh=ZjlR4kP5lVlH6ae1l9tl2In7/rCadhjHVu/7ZfsAgu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Von0MhmPHSu99+yjBWuB7nUZrwtyrp4us8zvyS6u/j8i//aFdglkh6O+tLOYvpnMO
         Xv23z666dhfgSrj+uoRZ85b6+BzdVQwE7/PwBVxisvC0/6fzP/4UHcLcn8/1AwYcqa
         eEMlIfn5OqIkInjRJtRbjkVyLRPwiy13Jaw6r+9vueFtF5jLnUMjacFVBvQiF1VeJy
         DmIgPbFs0m+EjnkMH6dWvnv2CHnQyHBANivs8+pQ9KkZvkW3yJL/qPl5ceT30wb9M2
         yPqhmaS6RMM1l/YrDXumpEFgnAWqRFBAtoO21GUVXscLDVrHDXSPgpn8T3JQk6LWQD
         KHpekb+Y1lTKg==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC cpufreq
Date:   Mon, 28 Nov 2022 23:29:10 +0900
Message-Id: <20221128142912.16022-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128142912.16022-1-marcan@marcan.st>
References: <20221128142912.16022-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
The hardware has an independent controller per CPU cluster, and we
represent them as unique nodes in order to accurately describe the
hardware. The driver is responsible for binding them as a single cpufreq
device (in the Linux cpufreq model).

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
new file mode 100644
index 000000000000..76cb9726660e
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/apple,cluster-cpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC cluster cpufreq device
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
+  the cluster management register block. This binding uses the standard
+  operating-points-v2 table to define the CPU performance states, with the
+  opp-level property specifying the hardware p-state index for that level.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - apple,t8103-cluster-cpufreq
+              - apple,t8112-cluster-cpufreq
+          - const: apple,cluster-cpufreq
+      - items:
+          - const: apple,t6000-cluster-cpufreq
+          - const: apple,t8103-cluster-cpufreq
+          - const: apple,cluster-cpufreq
+
+  reg:
+    maxItems: 1
+
+  '#performance-domain-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#performance-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    // This example shows a single CPU per domain and 2 domains,
+    // with two p-states per domain.
+    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
+    cpus {
+      #address-cells = <2>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        compatible = "apple,icestorm";
+        device_type = "cpu";
+        reg = <0x0 0x0>;
+        operating-points-v2 = <&ecluster_opp>;
+        performance-domains = <&cpufreq_e>;
+      };
+
+      cpu@10100 {
+        compatible = "apple,firestorm";
+        device_type = "cpu";
+        reg = <0x0 0x10100>;
+        operating-points-v2 = <&pcluster_opp>;
+        performance-domains = <&cpufreq_p>;
+      };
+    };
+
+    ecluster_opp: opp-table-0 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp01 {
+        opp-hz = /bits/ 64 <600000000>;
+        opp-level = <1>;
+        clock-latency-ns = <7500>;
+      };
+      opp02 {
+        opp-hz = /bits/ 64 <972000000>;
+        opp-level = <2>;
+        clock-latency-ns = <22000>;
+      };
+    };
+
+    pcluster_opp: opp-table-1 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp01 {
+        opp-hz = /bits/ 64 <600000000>;
+        opp-level = <1>;
+        clock-latency-ns = <8000>;
+      };
+      opp02 {
+        opp-hz = /bits/ 64 <828000000>;
+        opp-level = <2>;
+        clock-latency-ns = <19000>;
+      };
+    };
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      cpufreq_e: performance-controller@210e20000 {
+        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+        reg = <0x2 0x10e20000 0 0x1000>;
+        #performance-domain-cells = <0>;
+      };
+
+      cpufreq_p: performance-controller@211e20000 {
+        compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
+        reg = <0x2 0x11e20000 0 0x1000>;
+        #performance-domain-cells = <0>;
+      };
+    };
-- 
2.35.1

