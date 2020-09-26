Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05467279900
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgIZMvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgIZMvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2020 08:51:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBABC0613D3;
        Sat, 26 Sep 2020 05:51:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so1945122wme.0;
        Sat, 26 Sep 2020 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIBlyOXWyk+Ey56dr3+VehdkarLEB826T2xtWdw9REU=;
        b=XPvo0vho3CDq/nsVYa5VbFlGPKbtrNbyQcn4noi4jB1Apr3207j/sqcBQX4SqulbSA
         jTz175fjQUg4XfqvWH4frjDduSc6mP4ECnZ9rrG28l5ROu4CaA5hj9qQuN7bsZ7fM2xz
         +/rORRlmrhPv7lS+K73BtzeAR5x1Mtc2itBEMB/JdznowS27VR3hoiA8blrxKNF998HY
         VSH0x8EpJAhHFwHVYMWBso87+KdJD/a9/o8Vh4wLRxsGx9TY5iSKjp42UDdy/JBfaclb
         dwsIoxcmON12YD1v4/XzL4u3DDOfxImdPjN9vhzY51Ql8i6p2nEt8f2CRVptq/OnSBDt
         bsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIBlyOXWyk+Ey56dr3+VehdkarLEB826T2xtWdw9REU=;
        b=OJoXOowhJNr9PrTC8+QF5EseLqRitcekF4nzzzneY2tKmq3SMY9FGNzTPVddo5Uqd2
         JYV6WlhPsxwkzOlMHMXBcBb1JfwKKuplxFK9usov/4/KitAGiK6T86e3MXbN3CipJDQs
         D28iLCXmjycs/Lh9HJgSLpStJLhj6FqiBUcnTyWMoAqekcn7aCW1jicFQk9IW+8W+je2
         +nU5fj9/SqfQyTRuNsuZPqmaX3HZ586SeXemWBiYtYCb2Qu9HnH70S5Z4R4DK7jekiWI
         7ZXbc4KmZVSDLkb0dmVvvzXRJHo/x5iOW1SO1AzMlly0cMtaTD8MnE9vBu6sQDFWfpx7
         JMDg==
X-Gm-Message-State: AOAM533/dEdWolM759YgSNSYYnydo8OpWgodDhlKmyVrFFVJCV3MeVyF
        7pzflQ9Tpp3YBHQOb48r2QY=
X-Google-Smtp-Source: ABdhPJzQeIyVJUN4UcJrKKAzZo5+CHIFCKfcUbGRVMxlsKlI+ao1vUtF8R57TJbWkwLFMY1ECTKmjA==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr2472388wmh.44.1601124672405;
        Sat, 26 Sep 2020 05:51:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id z15sm6765225wrv.94.2020.09.26.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 05:51:12 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
Date:   Sat, 26 Sep 2020 14:51:01 +0200
Message-Id: <20200926125101.12712-3-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926125101.12712-1-kholk11@gmail.com>
References: <20200926125101.12712-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Add the bindings for the Qualcomm SDM660-class NoC, valid for
SDM630, SDM636, SDM660 and SDA variants.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../bindings/interconnect/qcom,sdm660.yaml    | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
new file mode 100644
index 000000000000..1d1d48ae8fc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM660 Network-On-Chip interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+  The Qualcomm SDM660 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sdm660-a2noc
+      - qcom,sdm660-bimc
+      - qcom,sdm660-cnoc
+      - qcom,sdm660-gnoc
+      - qcom,sdm660-mnoc
+      - qcom,sdm660-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-mnoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: CPU-NoC High-performance Bus Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: iface
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-a2noc
+              - qcom,sdm660-bimc
+              - qcom,sdm660-cnoc
+              - qcom,sdm660-gnoc
+              - qcom,sdm660-snoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+
+      bimc: interconnect@1008000 {
+              compatible = "qcom,sdm660-bimc";
+              reg = <0x01008000 0x78000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      cnoc: interconnect@1500000 {
+              compatible = "qcom,sdm660-cnoc";
+              reg = <0x01500000 0x10000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
+      };
+
+      snoc: interconnect@1626000 {
+              compatible = "qcom,sdm660-snoc";
+              reg = <0x01626000 0x7090>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
+
+      a2noc: interconnect@1704000 {
+              compatible = "qcom,sdm660-a2noc";
+              reg = <0x01704000 0xc100>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+      };
+
+      mnoc: interconnect@1745000 {
+              compatible = "qcom,sdm660-mnoc";
+              reg = <0x01745000 0xa010>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a", "iface";
+              clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
+                       <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
+                       <&mmcc AHB_CLK_SRC>;
+      };
+
+      gnoc: interconnect@17900000 {
+              compatible = "qcom,sdm660-gnoc";
+              reg = <0x17900000 0xe000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&xo_board>, <&xo_board>;
+      };
-- 
2.28.0

