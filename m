Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D104362B1
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJUNVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:21:55 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:54981 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhJUNVz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:21:55 -0400
Date:   Thu, 21 Oct 2021 13:19:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822376;
        bh=AfVYCFQdKCdmFWj4WldBvSqi3zgq359IaRLBqHgjcMU=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=GC5Wr7urBTMmvib8S5PMX66E671/o/zeJPaKx+w14csDnUMLI9GJzCVUt8LNcp9g4
         dOBG6j9V/jQzTVpu05RD9ebHq5oXfpPE7J7h2AMOd41PeLBHWvUmZnSHaDN45RgZro
         D05VY7Fzr5r5M3euZoftAXMJXT6yhHH6Lbrec3Bk=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v5 1/5] dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
Message-ID: <20211021131839.234662-2-y.oudjana@protonmail.com>
In-Reply-To: <20211021131839.234662-1-y.oudjana@protonmail.com>
References: <20211021131839.234662-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SDM660 interconnect bindings are similar to other RPM interconnect
providers, and now it shares the same common driver with them, so
it is better to combine them into qcom,rpm.yaml.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/interconnect/qcom,rpm.yaml       | 103 +++++++++-
 .../bindings/interconnect/qcom,sdm660.yaml    | 185 ------------------
 2 files changed, 95 insertions(+), 193 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm=
660.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b=
/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 983d71fb5399..6c39c0529e36 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -30,19 +30,23 @@ properties:
       - qcom,qcs404-bimc
       - qcom,qcs404-pcnoc
       - qcom,qcs404-snoc
+      - qcom,sdm660-a2noc
+      - qcom,sdm660-bimc
+      - qcom,sdm660-cnoc
+      - qcom,sdm660-gnoc
+      - qcom,sdm660-mnoc
+      - qcom,sdm660-snoc
=20
   '#interconnect-cells':
     const: 1
=20
-  clock-names:
-    items:
-      - const: bus
-      - const: bus_a
-
   clocks:
-    items:
-      - description: Bus Clock
-      - description: Bus A Clock
+    minItems: 2
+    maxItems: 7
+
+  clock-names:
+    minItems: 2
+    maxItems: 7
=20
 required:
   - compatible
@@ -53,6 +57,89 @@ required:
=20
 additionalProperties: false
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8916-bimc
+              - qcom,msm8916-pcnoc
+              - qcom,msm8916-snoc
+              - qcom,msm8939-bimc
+              - qcom,msm8939-pcnoc
+              - qcom,msm8939-snoc
+              - qcom,msm8939-snoc-mm
+              - qcom,qcs404-bimc
+              - qcom,qcs404-pcnoc
+              - qcom,qcs404-snoc
+              - qcom,sdm660-bimc
+              - qcom,sdm660-cnoc
+              - qcom,sdm660-gnoc
+              - qcom,sdm660-snoc
+
+      then:
+        properties:
+          clock-names:
+            items:
+              - const: bus
+              - const: bus_a
+
+          clocks:
+            items:
+              - description: Bus Clock
+              - description: Bus A Clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-mnoc
+
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: iface
+
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: CPU-NoC High-performance Bus Clock.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-a2noc
+
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: ipa
+            - const: ufs_axi
+            - const: aggre2_ufs_axi
+            - const: aggre2_usb3_axi
+            - const: cfg_noc_usb2_axi
+
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: IPA Clock.
+            - description: UFS AXI Clock.
+            - description: Aggregate2 UFS AXI Clock.
+            - description: Aggregate2 USB3 AXI Clock.
+            - description: Config NoC USB2 AXI Clock.
+
 examples:
   - |
       #include <dt-bindings/clock/qcom,rpmcc.h>
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yam=
l b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
deleted file mode 100644
index bcd41e491f1d..000000000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
+++ /dev/null
@@ -1,185 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SDM660 Network-On-Chip interconnect
-
-maintainers:
-  - AngeloGioacchino Del Regno <kholk11@gmail.com>
-
-description: |
-  The Qualcomm SDM660 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
-
-properties:
-  reg:
-    maxItems: 1
-
-  compatible:
-    enum:
-      - qcom,sdm660-a2noc
-      - qcom,sdm660-bimc
-      - qcom,sdm660-cnoc
-      - qcom,sdm660-gnoc
-      - qcom,sdm660-mnoc
-      - qcom,sdm660-snoc
-
-  '#interconnect-cells':
-    const: 1
-
-  clocks:
-    minItems: 1
-    maxItems: 7
-
-  clock-names:
-    minItems: 1
-    maxItems: 7
-
-required:
-  - compatible
-  - reg
-  - '#interconnect-cells'
-  - clock-names
-  - clocks
-
-additionalProperties: false
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdm660-mnoc
-    then:
-      properties:
-        clocks:
-          items:
-            - description: Bus Clock.
-            - description: Bus A Clock.
-            - description: CPU-NoC High-performance Bus Clock.
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-            - const: iface
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdm660-a2noc
-    then:
-      properties:
-        clocks:
-          items:
-            - description: Bus Clock.
-            - description: Bus A Clock.
-            - description: IPA Clock.
-            - description: UFS AXI Clock.
-            - description: Aggregate2 UFS AXI Clock.
-            - description: Aggregate2 USB3 AXI Clock.
-            - description: Config NoC USB2 AXI Clock.
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-            - const: ipa
-            - const: ufs_axi
-            - const: aggre2_ufs_axi
-            - const: aggre2_usb3_axi
-            - const: cfg_noc_usb2_axi
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdm660-bimc
-              - qcom,sdm660-cnoc
-              - qcom,sdm660-gnoc
-              - qcom,sdm660-snoc
-    then:
-      properties:
-        clocks:
-          items:
-            - description: Bus Clock.
-            - description: Bus A Clock.
-        clock-names:
-          items:
-            - const: bus
-            - const: bus_a
-
-examples:
-  - |
-      #include <dt-bindings/clock/qcom,rpmcc.h>
-      #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
-      #include <dt-bindings/clock/qcom,gcc-sdm660.h>
-
-      bimc: interconnect@1008000 {
-              compatible =3D "qcom,sdm660-bimc";
-              reg =3D <0x01008000 0x78000>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus", "bus_a";
-              clocks =3D <&rpmcc RPM_SMD_BIMC_CLK>,
-                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
-      };
-
-      cnoc: interconnect@1500000 {
-              compatible =3D "qcom,sdm660-cnoc";
-              reg =3D <0x01500000 0x10000>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus", "bus_a";
-              clocks =3D <&rpmcc RPM_SMD_CNOC_CLK>,
-                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
-      };
-
-      snoc: interconnect@1626000 {
-              compatible =3D "qcom,sdm660-snoc";
-              reg =3D <0x01626000 0x7090>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus", "bus_a";
-              clocks =3D <&rpmcc RPM_SMD_SNOC_CLK>,
-                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
-      };
-
-      a2noc: interconnect@1704000 {
-              compatible =3D "qcom,sdm660-a2noc";
-              reg =3D <0x01704000 0xc100>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus",
-                            "bus_a",
-                            "ipa",
-                            "ufs_axi",
-                            "aggre2_ufs_axi",
-                            "aggre2_usb3_axi",
-                            "cfg_noc_usb2_axi";
-              clocks =3D <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
-                       <&rpmcc RPM_SMD_IPA_CLK>,
-                       <&gcc GCC_UFS_AXI_CLK>,
-                       <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
-                       <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
-                       <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
-      };
-
-      mnoc: interconnect@1745000 {
-              compatible =3D "qcom,sdm660-mnoc";
-              reg =3D <0x01745000 0xa010>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus", "bus_a", "iface";
-              clocks =3D <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
-                       <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
-                       <&mmcc AHB_CLK_SRC>;
-      };
-
-      gnoc: interconnect@17900000 {
-              compatible =3D "qcom,sdm660-gnoc";
-              reg =3D <0x17900000 0xe000>;
-              #interconnect-cells =3D <1>;
-              clock-names =3D "bus", "bus_a";
-              clocks =3D <&xo_board>, <&xo_board>;
-      };
--=20
2.33.1


