Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1F42D505
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhJNIe4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:34:56 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:34916 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhJNIey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:34:54 -0400
Date:   Thu, 14 Oct 2021 08:32:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200362;
        bh=VsdfyoxZtxf2aEgruzizGpW/tKmbNgVPJacbplvM49U=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=spxPEn1yqpU6afKwln80xj/DGPmbYKDDfjsp68rQsQLh6+cEIrFKibo8BELWVriMK
         S+N6BPkGynos/CaKTDhW4JGix3Oug9qLI/Sdz1W+cL4ZG3XFLhflE65A262IoZTDxa
         p3EXBM4Py0jAB7T0gjjNSb07r3XBxWve9Mgpanbk=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 5/8] dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
Message-ID: <20211014083016.137441-6-y.oudjana@protonmail.com>
In-Reply-To: <20211014083016.137441-1-y.oudjana@protonmail.com>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
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

Convert qcom-nvmem-cpufreq to DT schema format.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/opp/qcom-cpufreq-nvmem.yaml      | 877 ++++++++++++++++++
 .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ----------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 878 insertions(+), 797 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpufreq-nvme=
m.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufre=
q.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml =
b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
new file mode 100644
index 000000000000..4a7d4826746e
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
@@ -0,0 +1,877 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/qcom-cpufreq-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
+
+maintainers:
+  - Ilia Lin <ilia.lin@kernel.org>
+
+description: |
+  In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
+  the CPU frequencies subset and voltage value of each OPP varies based on
+  the silicon variant in use.
+  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
+  defines the voltage and frequency value based on the msm-id in SMEM
+  and speedbin blown in the efuse combination.
+  The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the =
SoC
+  to provide the OPP framework with required information (existing HW bitm=
ap).
+  This is used to determine the voltage and frequency value for each OPP o=
f
+  operating-points-v2 table when it is parsed by the OPP framework.
+
+patternProperties:
+  compatible:
+    enum:
+      - qcom,apq8096
+      - qcom,msm8996
+      - qcom,qcs404
+      - qcom,ipq8064
+      - qcom,apq8064
+      - qcom,msm8974
+      - qcom,msm8960
+
+  '^opp-table(-[a-z0-9]+)?$':
+    type: object
+
+    patternProperties:
+      compatible:
+        const: operating-points-v2-kryo-cpu
+
+      nvmem-cells:
+        description: |
+          A phandle pointing to a nvmem-cells node representing the
+          efuse registers that has information about the
+          speedbin that is used to select the right frequency/voltage
+          value pair.
+
+      opp-shared: true
+
+      '^opp-?[0-9]+$':
+        type: object
+
+        properties:
+          opp-hz: true
+          opp-microvolt: true
+          clock-latency-ns: true
+
+          opp-supported-hw:
+            description: |
+              A single 32 bit bitmap value, representing compatible HW.
+              Bitmap:
+              0:  MSM8996 V3, speedbin 0
+              1:  MSM8996 V3, speedbin 1
+              2:  MSM8996 V3, speedbin 2
+              3:  unused
+              4:  MSM8996 SG, speedbin 0
+              5:  MSM8996 SG, speedbin 1
+              6:  MSM8996 SG, speedbin 2
+              7-31:  unused
+
+        required:
+          - opp-hz
+          - opp-supported-hw
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qcs404
+    then:
+      patternProperties:
+        cpus:
+          type: object
+
+          patternProperties:
+            'cpu@[0-9a-f]+':
+              type: object
+=20
+              properties:
+                power-domains:
+                  items:
+                    - description: A phandle pointing to the PM domain spe=
cifier
+                        which provides the performance states available fo=
r active
+                        state management.
+                power-domain-names:
+                  items:
+                    - const: cpr
+
+        '^opp-?[0-9]+$':
+          properties:
+            required-opps: true
+
+          required:
+            - opp-hz
+            - opp-supported-hw
+            - required-opps
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    / {
+        model =3D "Qualcomm Technologies, Inc. MSM8996";
+        compatible =3D "qcom,msm8996";
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        cpus {
+            #address-cells =3D <2>;
+            #size-cells =3D <0>;
+
+            CPU0: cpu@0 {
+                device_type =3D "cpu";
+                compatible =3D "qcom,kryo";
+                reg =3D <0x0 0x0>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                capacity-dmips-mhz =3D <1024>;
+                clocks =3D <&kryocc 0>;
+                operating-points-v2 =3D <&cluster0_opp>;
+                #cooling-cells =3D <2>;
+                next-level-cache =3D <&L2_0>;
+                L2_0: l2-cache {
+                    compatible =3D "cache";
+                    cache-level =3D <2>;
+                };
+            };
+
+            CPU1: cpu@1 {
+                device_type =3D "cpu";
+                compatible =3D "qcom,kryo";
+                reg =3D <0x0 0x1>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                capacity-dmips-mhz =3D <1024>;
+                clocks =3D <&kryocc 0>;
+                operating-points-v2 =3D <&cluster0_opp>;
+                #cooling-cells =3D <2>;
+                next-level-cache =3D <&L2_0>;
+            };
+
+            CPU2: cpu@100 {
+                device_type =3D "cpu";
+                compatible =3D "qcom,kryo";
+                reg =3D <0x0 0x100>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                capacity-dmips-mhz =3D <1024>;
+                clocks =3D <&kryocc 1>;
+                operating-points-v2 =3D <&cluster1_opp>;
+                #cooling-cells =3D <2>;
+                next-level-cache =3D <&L2_1>;
+                L2_1: l2-cache {
+                    compatible =3D "cache";
+                    cache-level =3D <2>;
+                };
+            };
+
+            CPU3: cpu@101 {
+                device_type =3D "cpu";
+                compatible =3D "qcom,kryo";
+                reg =3D <0x0 0x101>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                capacity-dmips-mhz =3D <1024>;
+                clocks =3D <&kryocc 1>;
+                operating-points-v2 =3D <&cluster1_opp>;
+                #cooling-cells =3D <2>;
+                next-level-cache =3D <&L2_1>;
+            };
+
+            cpu-map {
+                cluster0 {
+                    core0 {
+                        cpu =3D <&CPU0>;
+                    };
+
+                    core1 {
+                        cpu =3D <&CPU1>;
+                    };
+                };
+
+                cluster1 {
+                    core0 {
+                        cpu =3D <&CPU2>;
+                    };
+
+                    core1 {
+                        cpu =3D <&CPU3>;
+                    };
+                };
+            };
+        };
+
+        cluster0_opp: opp_table0 {
+            compatible =3D "operating-points-v2-kryo-cpu";
+            nvmem-cells =3D <&speedbin_efuse>;
+            opp-shared;
+
+            opp-307200000 {
+                opp-hz =3D /bits/ 64 <307200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x77>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-384000000 {
+                opp-hz =3D /bits/ 64 <384000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-422400000 {
+                opp-hz =3D /bits/ 64 <422400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-460800000 {
+                opp-hz =3D /bits/ 64 <460800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-480000000 {
+                opp-hz =3D /bits/ 64 <480000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-537600000 {
+                opp-hz =3D /bits/ 64 <537600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-556800000 {
+                opp-hz =3D /bits/ 64 <556800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-614400000 {
+                opp-hz =3D /bits/ 64 <614400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-652800000 {
+                opp-hz =3D /bits/ 64 <652800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-691200000 {
+                opp-hz =3D /bits/ 64 <691200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-729600000 {
+                opp-hz =3D /bits/ 64 <729600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-768000000 {
+                opp-hz =3D /bits/ 64 <768000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-844800000 {
+                opp-hz =3D /bits/ 64 <844800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x77>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-902400000 {
+                opp-hz =3D /bits/ 64 <902400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-960000000 {
+                opp-hz =3D /bits/ 64 <960000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-979200000 {
+                opp-hz =3D /bits/ 64 <979200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1036800000 {
+                opp-hz =3D /bits/ 64 <1036800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1056000000 {
+                opp-hz =3D /bits/ 64 <1056000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1113600000 {
+                opp-hz =3D /bits/ 64 <1113600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1132800000 {
+                opp-hz =3D /bits/ 64 <1132800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1190400000 {
+                opp-hz =3D /bits/ 64 <1190400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1209600000 {
+                opp-hz =3D /bits/ 64 <1209600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1228800000 {
+                opp-hz =3D /bits/ 64 <1228800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1286400000 {
+                opp-hz =3D /bits/ 64 <1286400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1324800000 {
+                opp-hz =3D /bits/ 64 <1324800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x5>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1363200000 {
+                opp-hz =3D /bits/ 64 <1363200000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x72>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1401600000 {
+                opp-hz =3D /bits/ 64 <1401600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x5>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1440000000 {
+                opp-hz =3D /bits/ 64 <1440000000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1478400000 {
+                opp-hz =3D /bits/ 64 <1478400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x1>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1497600000 {
+                opp-hz =3D /bits/ 64 <1497600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x4>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1516800000 {
+                opp-hz =3D /bits/ 64 <1516800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1593600000 {
+                opp-hz =3D /bits/ 64 <1593600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x71>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1996800000 {
+                opp-hz =3D /bits/ 64 <1996800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x20>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2188800000 {
+                opp-hz =3D /bits/ 64 <2188800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x10>;
+                clock-latency-ns =3D <200000>;
+            };
+        };
+
+        cluster1_opp: opp_table1 {
+            compatible =3D "operating-points-v2-kryo-cpu";
+            nvmem-cells =3D <&speedbin_efuse>;
+            opp-shared;
+
+            opp-307200000 {
+                opp-hz =3D /bits/ 64 <307200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x77>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-384000000 {
+                opp-hz =3D /bits/ 64 <384000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-403200000 {
+                opp-hz =3D /bits/ 64 <403200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-460800000 {
+                opp-hz =3D /bits/ 64 <460800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-480000000 {
+                opp-hz =3D /bits/ 64 <480000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-537600000 {
+                opp-hz =3D /bits/ 64 <537600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-556800000 {
+                opp-hz =3D /bits/ 64 <556800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-614400000 {
+                opp-hz =3D /bits/ 64 <614400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-652800000 {
+                opp-hz =3D /bits/ 64 <652800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-691200000 {
+                opp-hz =3D /bits/ 64 <691200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-729600000 {
+                opp-hz =3D /bits/ 64 <729600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-748800000 {
+                opp-hz =3D /bits/ 64 <748800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-806400000 {
+                opp-hz =3D /bits/ 64 <806400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-825600000 {
+                opp-hz =3D /bits/ 64 <825600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-883200000 {
+                opp-hz =3D /bits/ 64 <883200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-902400000 {
+                opp-hz =3D /bits/ 64 <902400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-940800000 {
+                opp-hz =3D /bits/ 64 <940800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-979200000 {
+                opp-hz =3D /bits/ 64 <979200000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1036800000 {
+                opp-hz =3D /bits/ 64 <1036800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1056000000 {
+                opp-hz =3D /bits/ 64 <1056000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1113600000 {
+                opp-hz =3D /bits/ 64 <1113600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1132800000 {
+                opp-hz =3D /bits/ 64 <1132800000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1190400000 {
+                opp-hz =3D /bits/ 64 <1190400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1209600000 {
+                opp-hz =3D /bits/ 64 <1209600000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1248000000 {
+                opp-hz =3D /bits/ 64 <1248000000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1286400000 {
+                opp-hz =3D /bits/ 64 <1286400000>;
+                opp-microvolt =3D <905000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1324800000 {
+                opp-hz =3D /bits/ 64 <1324800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1363200000 {
+                opp-hz =3D /bits/ 64 <1363200000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1401600000 {
+                opp-hz =3D /bits/ 64 <1401600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1440000000 {
+                opp-hz =3D /bits/ 64 <1440000000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1478400000 {
+                opp-hz =3D /bits/ 64 <1478400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1516800000 {
+                opp-hz =3D /bits/ 64 <1516800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1555200000 {
+                opp-hz =3D /bits/ 64 <1555200000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1593600000 {
+                opp-hz =3D /bits/ 64 <1593600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1632000000 {
+                opp-hz =3D /bits/ 64 <1632000000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1670400000 {
+                opp-hz =3D /bits/ 64 <1670400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1708800000 {
+                opp-hz =3D /bits/ 64 <1708800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1747200000 {
+                opp-hz =3D /bits/ 64 <1747200000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x70>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1785600000 {
+                opp-hz =3D /bits/ 64 <1785600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x7>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1804800000 {
+                opp-hz =3D /bits/ 64 <1804800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x6>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1824000000 {
+                opp-hz =3D /bits/ 64 <1824000000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x71>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1900800000 {
+                opp-hz =3D /bits/ 64 <1900800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x74>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1920000000 {
+                opp-hz =3D /bits/ 64 <1920000000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x1>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1977600000 {
+                opp-hz =3D /bits/ 64 <1977600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x30>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-1996800000 {
+                opp-hz =3D /bits/ 64 <1996800000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x1>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2054400000 {
+                opp-hz =3D /bits/ 64 <2054400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x30>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2073600000 {
+                opp-hz =3D /bits/ 64 <2073600000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x1>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2150400000 {
+                opp-hz =3D /bits/ 64 <2150400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x31>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2246400000 {
+                opp-hz =3D /bits/ 64 <2246400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x10>;
+                clock-latency-ns =3D <200000>;
+            };
+            opp-2342400000 {
+                opp-hz =3D /bits/ 64 <2342400000>;
+                opp-microvolt =3D <1140000 905000 1140000>;
+                opp-supported-hw =3D <0x10>;
+                clock-latency-ns =3D <200000>;
+            };
+        };
+
+        reserved-memory {
+            #address-cells =3D <2>;
+            #size-cells =3D <2>;
+            ranges;
+
+            smem_mem: smem-mem@86000000 {
+                reg =3D <0x0 0x86000000 0x0 0x200000>;
+                no-map;
+            };
+        };
+
+        smem {
+            compatible =3D "qcom,smem";
+            memory-region =3D <&smem_mem>;
+            hwlocks =3D <&tcsr_mutex 3>;
+        };
+
+        soc {
+            #address-cells =3D <1>;
+            #size-cells =3D <1>;
+
+            qfprom: qfprom@74000 {
+                compatible =3D "qcom,msm8996-qfprom", "qcom,qfprom";
+                reg =3D <0x00074000 0x8ff>;
+                #address-cells =3D <1>;
+                #size-cells =3D <1>;
+
+                speedbin_efuse: speedbin@133 {
+                    reg =3D <0x133 0x1>;
+                    bits =3D <5 3>;
+                };
+            };
+        };
+    };
+
+  - |
+    / {
+        model =3D "Qualcomm Technologies, Inc. QCS404";
+        compatible =3D "qcom,qcs404";
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        cpus {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            cpu@100 {
+                device_type =3D "cpu";
+                compatible =3D "arm,cortex-a53";
+                reg =3D <0x100>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                next-level-cache =3D <&L2_0>;
+                #cooling-cells =3D <2>;
+                clocks =3D <&apcs_glb>;
+                operating-points-v2 =3D <&cpu_opp_table>;
+                power-domains =3D <&cpr>;
+                power-domain-names =3D "cpr";
+            };
+
+            cpu@101 {
+                device_type =3D "cpu";
+                compatible =3D "arm,cortex-a53";
+                reg =3D <0x101>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                next-level-cache =3D <&L2_0>;
+                #cooling-cells =3D <2>;
+                clocks =3D <&apcs_glb>;
+                operating-points-v2 =3D <&cpu_opp_table>;
+                power-domains =3D <&cpr>;
+                power-domain-names =3D "cpr";
+            };
+
+            cpu@102 {
+                device_type =3D "cpu";
+                compatible =3D "arm,cortex-a53";
+                reg =3D <0x102>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                next-level-cache =3D <&L2_0>;
+                #cooling-cells =3D <2>;
+                clocks =3D <&apcs_glb>;
+                operating-points-v2 =3D <&cpu_opp_table>;
+                power-domains =3D <&cpr>;
+                power-domain-names =3D "cpr";
+            };
+
+            cpu@103 {
+                device_type =3D "cpu";
+                compatible =3D "arm,cortex-a53";
+                reg =3D <0x103>;
+                enable-method =3D "psci";
+                cpu-idle-states =3D <&CPU_SLEEP_0>;
+                next-level-cache =3D <&L2_0>;
+                #cooling-cells =3D <2>;
+                clocks =3D <&apcs_glb>;
+                operating-points-v2 =3D <&cpu_opp_table>;
+                power-domains =3D <&cpr>;
+                power-domain-names =3D "cpr";
+            };
+        };
+
+        cpu_opp_table: cpu-opp-table {
+            compatible =3D "operating-points-v2-kryo-cpu";
+            opp-shared;
+
+            opp-1094400000 {
+                opp-hz =3D /bits/ 64 <1094400000>;
+                required-opps =3D <&cpr_opp1>;
+            };
+            opp-1248000000 {
+                opp-hz =3D /bits/ 64 <1248000000>;
+                required-opps =3D <&cpr_opp2>;
+            };
+            opp-1401600000 {
+                opp-hz =3D /bits/ 64 <1401600000>;
+                required-opps =3D <&cpr_opp3>;
+            };
+        };
+
+        cpr_opp_table: cpr-opp-table {
+            compatible =3D "operating-points-v2-qcom-level";
+
+            cpr_opp1: opp1 {
+                opp-level =3D <1>;
+                qcom,opp-fuse-level =3D <1>;
+            };
+            cpr_opp2: opp2 {
+                opp-level =3D <2>;
+                qcom,opp-fuse-level =3D <2>;
+            };
+            cpr_opp3: opp3 {
+                opp-level =3D <3>;
+                qcom,opp-fuse-level =3D <3>;
+            };
+        };
+
+        soc {
+            #address-cells =3D <1>;
+            #size-cells =3D <1>;
+
+            cpr: power-controller@b018000 {
+                compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
+                reg =3D <0x0b018000 0x1000>;
+
+                vdd-apc-supply =3D <&pms405_s3>;
+                #power-domain-cells =3D <0>;
+                operating-points-v2 =3D <&cpr_opp_table>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b=
/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
deleted file mode 100644
index 64f07417ecfb..000000000000
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ /dev/null
@@ -1,796 +0,0 @@
-Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
-the CPU frequencies subset and voltage value of each OPP varies based on
-the silicon variant in use.
-Qualcomm Technologies, Inc. Process Voltage Scaling Tables
-defines the voltage and frequency value based on the msm-id in SMEM
-and speedbin blown in the efuse combination.
-The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the So=
C
-to provide the OPP framework with required information (existing HW bitmap=
).
-This is used to determine the voltage and frequency value for each OPP of
-operating-points-v2 table when it is parsed by the OPP framework.
-
-Required properties:
---------------------
-In 'cpu' nodes:
-- operating-points-v2: Phandle to the operating-points-v2 table to use.
-
-In 'operating-points-v2' table:
-- compatible: Should be
-=09- 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
-=09=09=09=09=09     apq8064, ipq8064, msm8960 and ipq8074.
-
-Optional properties:
---------------------
-In 'cpu' nodes:
-- power-domains: A phandle pointing to the PM domain specifier which provi=
des
-=09=09the performance states available for active state management.
-=09=09Please refer to the power-domains bindings
-=09=09Documentation/devicetree/bindings/power/power_domain.txt
-=09=09and also examples below.
-- power-domain-names: Should be
-=09- 'cpr' for qcs404.
-
-In 'operating-points-v2' table:
-- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
-=09=09efuse registers that has information about the
-=09=09speedbin that is used to select the right frequency/voltage
-=09=09value pair.
-=09=09Please refer the for nvmem-cells
-=09=09bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
-=09=09and also examples below.
-
-In every OPP node:
-- opp-supported-hw: A single 32 bit bitmap value, representing compatible =
HW.
-=09=09    Bitmap:
-=09=09=090:=09MSM8996 V3, speedbin 0
-=09=09=091:=09MSM8996 V3, speedbin 1
-=09=09=092:=09MSM8996 V3, speedbin 2
-=09=09=093:=09unused
-=09=09=094:=09MSM8996 SG, speedbin 0
-=09=09=095:=09MSM8996 SG, speedbin 1
-=09=09=096:=09MSM8996 SG, speedbin 2
-=09=09=097-31:=09unused
-
-Example 1:
----------
-
-=09cpus {
-=09=09#address-cells =3D <2>;
-=09=09#size-cells =3D <0>;
-
-=09=09CPU0: cpu@0 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "qcom,kryo";
-=09=09=09reg =3D <0x0 0x0>;
-=09=09=09enable-method =3D "psci";
-=09=09=09clocks =3D <&kryocc 0>;
-=09=09=09cpu-supply =3D <&pm8994_s11_saw>;
-=09=09=09operating-points-v2 =3D <&cluster0_opp>;
-=09=09=09#cooling-cells =3D <2>;
-=09=09=09next-level-cache =3D <&L2_0>;
-=09=09=09L2_0: l2-cache {
-=09=09=09      compatible =3D "cache";
-=09=09=09      cache-level =3D <2>;
-=09=09=09};
-=09=09};
-
-=09=09CPU1: cpu@1 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "qcom,kryo";
-=09=09=09reg =3D <0x0 0x1>;
-=09=09=09enable-method =3D "psci";
-=09=09=09clocks =3D <&kryocc 0>;
-=09=09=09cpu-supply =3D <&pm8994_s11_saw>;
-=09=09=09operating-points-v2 =3D <&cluster0_opp>;
-=09=09=09#cooling-cells =3D <2>;
-=09=09=09next-level-cache =3D <&L2_0>;
-=09=09};
-
-=09=09CPU2: cpu@100 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "qcom,kryo";
-=09=09=09reg =3D <0x0 0x100>;
-=09=09=09enable-method =3D "psci";
-=09=09=09clocks =3D <&kryocc 1>;
-=09=09=09cpu-supply =3D <&pm8994_s11_saw>;
-=09=09=09operating-points-v2 =3D <&cluster1_opp>;
-=09=09=09#cooling-cells =3D <2>;
-=09=09=09next-level-cache =3D <&L2_1>;
-=09=09=09L2_1: l2-cache {
-=09=09=09      compatible =3D "cache";
-=09=09=09      cache-level =3D <2>;
-=09=09=09};
-=09=09};
-
-=09=09CPU3: cpu@101 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "qcom,kryo";
-=09=09=09reg =3D <0x0 0x101>;
-=09=09=09enable-method =3D "psci";
-=09=09=09clocks =3D <&kryocc 1>;
-=09=09=09cpu-supply =3D <&pm8994_s11_saw>;
-=09=09=09operating-points-v2 =3D <&cluster1_opp>;
-=09=09=09#cooling-cells =3D <2>;
-=09=09=09next-level-cache =3D <&L2_1>;
-=09=09};
-
-=09=09cpu-map {
-=09=09=09cluster0 {
-=09=09=09=09core0 {
-=09=09=09=09=09cpu =3D <&CPU0>;
-=09=09=09=09};
-
-=09=09=09=09core1 {
-=09=09=09=09=09cpu =3D <&CPU1>;
-=09=09=09=09};
-=09=09=09};
-
-=09=09=09cluster1 {
-=09=09=09=09core0 {
-=09=09=09=09=09cpu =3D <&CPU2>;
-=09=09=09=09};
-
-=09=09=09=09core1 {
-=09=09=09=09=09cpu =3D <&CPU3>;
-=09=09=09=09};
-=09=09=09};
-=09=09};
-=09};
-
-=09cluster0_opp: opp_table0 {
-=09=09compatible =3D "operating-points-v2-kryo-cpu";
-=09=09nvmem-cells =3D <&speedbin_efuse>;
-=09=09opp-shared;
-
-=09=09opp-307200000 {
-=09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x77>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-384000000 {
-=09=09=09opp-hz =3D /bits/ 64 <384000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-422400000 {
-=09=09=09opp-hz =3D /bits/ 64 <422400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-460800000 {
-=09=09=09opp-hz =3D /bits/ 64 <460800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-480000000 {
-=09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-537600000 {
-=09=09=09opp-hz =3D /bits/ 64 <537600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-556800000 {
-=09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-614400000 {
-=09=09=09opp-hz =3D /bits/ 64 <614400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-652800000 {
-=09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-691200000 {
-=09=09=09opp-hz =3D /bits/ 64 <691200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-729600000 {
-=09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-768000000 {
-=09=09=09opp-hz =3D /bits/ 64 <768000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-844800000 {
-=09=09=09opp-hz =3D /bits/ 64 <844800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x77>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-902400000 {
-=09=09=09opp-hz =3D /bits/ 64 <902400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-960000000 {
-=09=09=09opp-hz =3D /bits/ 64 <960000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-979200000 {
-=09=09=09opp-hz =3D /bits/ 64 <979200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1036800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1056000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1113600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1132800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1190400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1209600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1228800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1228800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1286400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1324800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x5>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1363200000 {
-=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x72>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1401600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x5>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1440000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1478400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x1>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1497600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1497600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x4>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1516800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1593600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x71>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1996800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1996800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x20>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2188800000 {
-=09=09=09opp-hz =3D /bits/ 64 <2188800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x10>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09};
-
-=09cluster1_opp: opp_table1 {
-=09=09compatible =3D "operating-points-v2-kryo-cpu";
-=09=09nvmem-cells =3D <&speedbin_efuse>;
-=09=09opp-shared;
-
-=09=09opp-307200000 {
-=09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x77>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-384000000 {
-=09=09=09opp-hz =3D /bits/ 64 <384000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-403200000 {
-=09=09=09opp-hz =3D /bits/ 64 <403200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-460800000 {
-=09=09=09opp-hz =3D /bits/ 64 <460800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-480000000 {
-=09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-537600000 {
-=09=09=09opp-hz =3D /bits/ 64 <537600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-556800000 {
-=09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-614400000 {
-=09=09=09opp-hz =3D /bits/ 64 <614400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-652800000 {
-=09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-691200000 {
-=09=09=09opp-hz =3D /bits/ 64 <691200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-729600000 {
-=09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-748800000 {
-=09=09=09opp-hz =3D /bits/ 64 <748800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-806400000 {
-=09=09=09opp-hz =3D /bits/ 64 <806400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-825600000 {
-=09=09=09opp-hz =3D /bits/ 64 <825600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-883200000 {
-=09=09=09opp-hz =3D /bits/ 64 <883200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-902400000 {
-=09=09=09opp-hz =3D /bits/ 64 <902400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-940800000 {
-=09=09=09opp-hz =3D /bits/ 64 <940800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-979200000 {
-=09=09=09opp-hz =3D /bits/ 64 <979200000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1036800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1056000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1113600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1132800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1190400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1209600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1248000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1248000000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1286400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
-=09=09=09opp-microvolt =3D <905000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1324800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1363200000 {
-=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1401600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1440000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1478400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1516800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1555200000 {
-=09=09=09opp-hz =3D /bits/ 64 <1555200000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1593600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1632000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1632000000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1670400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1670400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1708800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1708800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1747200000 {
-=09=09=09opp-hz =3D /bits/ 64 <1747200000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x70>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1785600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1785600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x7>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1804800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1804800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x6>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1824000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1824000000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x71>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1900800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1900800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x74>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1920000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1920000000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x1>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1977600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1977600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x30>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-1996800000 {
-=09=09=09opp-hz =3D /bits/ 64 <1996800000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x1>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2054400000 {
-=09=09=09opp-hz =3D /bits/ 64 <2054400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x30>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2073600000 {
-=09=09=09opp-hz =3D /bits/ 64 <2073600000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x1>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2150400000 {
-=09=09=09opp-hz =3D /bits/ 64 <2150400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x31>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2246400000 {
-=09=09=09opp-hz =3D /bits/ 64 <2246400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x10>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09=09opp-2342400000 {
-=09=09=09opp-hz =3D /bits/ 64 <2342400000>;
-=09=09=09opp-microvolt =3D <1140000 905000 1140000>;
-=09=09=09opp-supported-hw =3D <0x10>;
-=09=09=09clock-latency-ns =3D <200000>;
-=09=09};
-=09};
-
-....
-
-reserved-memory {
-=09#address-cells =3D <2>;
-=09#size-cells =3D <2>;
-=09ranges;
-....
-=09smem_mem: smem-mem@86000000 {
-=09=09reg =3D <0x0 0x86000000 0x0 0x200000>;
-=09=09no-map;
-=09};
-....
-};
-
-smem {
-=09compatible =3D "qcom,smem";
-=09memory-region =3D <&smem_mem>;
-=09hwlocks =3D <&tcsr_mutex 3>;
-};
-
-soc {
-....
-=09qfprom: qfprom@74000 {
-=09=09compatible =3D "qcom,qfprom";
-=09=09reg =3D <0x00074000 0x8ff>;
-=09=09#address-cells =3D <1>;
-=09=09#size-cells =3D <1>;
-=09=09....
-=09=09speedbin_efuse: speedbin@133 {
-=09=09=09reg =3D <0x133 0x1>;
-=09=09=09bits =3D <5 3>;
-=09=09};
-=09};
-};
-
-Example 2:
----------
-
-=09cpus {
-=09=09#address-cells =3D <1>;
-=09=09#size-cells =3D <0>;
-
-=09=09CPU0: cpu@100 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "arm,cortex-a53";
-=09=09=09reg =3D <0x100>;
-=09=09=09....
-=09=09=09clocks =3D <&apcs_glb>;
-=09=09=09operating-points-v2 =3D <&cpu_opp_table>;
-=09=09=09power-domains =3D <&cpr>;
-=09=09=09power-domain-names =3D "cpr";
-=09=09};
-
-=09=09CPU1: cpu@101 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "arm,cortex-a53";
-=09=09=09reg =3D <0x101>;
-=09=09=09....
-=09=09=09clocks =3D <&apcs_glb>;
-=09=09=09operating-points-v2 =3D <&cpu_opp_table>;
-=09=09=09power-domains =3D <&cpr>;
-=09=09=09power-domain-names =3D "cpr";
-=09=09};
-
-=09=09CPU2: cpu@102 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "arm,cortex-a53";
-=09=09=09reg =3D <0x102>;
-=09=09=09....
-=09=09=09clocks =3D <&apcs_glb>;
-=09=09=09operating-points-v2 =3D <&cpu_opp_table>;
-=09=09=09power-domains =3D <&cpr>;
-=09=09=09power-domain-names =3D "cpr";
-=09=09};
-
-=09=09CPU3: cpu@103 {
-=09=09=09device_type =3D "cpu";
-=09=09=09compatible =3D "arm,cortex-a53";
-=09=09=09reg =3D <0x103>;
-=09=09=09....
-=09=09=09clocks =3D <&apcs_glb>;
-=09=09=09operating-points-v2 =3D <&cpu_opp_table>;
-=09=09=09power-domains =3D <&cpr>;
-=09=09=09power-domain-names =3D "cpr";
-=09=09};
-=09};
-
-=09cpu_opp_table: cpu-opp-table {
-=09=09compatible =3D "operating-points-v2-kryo-cpu";
-=09=09opp-shared;
-
-=09=09opp-1094400000 {
-=09=09=09opp-hz =3D /bits/ 64 <1094400000>;
-=09=09=09required-opps =3D <&cpr_opp1>;
-=09=09};
-=09=09opp-1248000000 {
-=09=09=09opp-hz =3D /bits/ 64 <1248000000>;
-=09=09=09required-opps =3D <&cpr_opp2>;
-=09=09};
-=09=09opp-1401600000 {
-=09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09required-opps =3D <&cpr_opp3>;
-=09=09};
-=09};
-
-=09cpr_opp_table: cpr-opp-table {
-=09=09compatible =3D "operating-points-v2-qcom-level";
-
-=09=09cpr_opp1: opp1 {
-=09=09=09opp-level =3D <1>;
-=09=09=09qcom,opp-fuse-level =3D <1>;
-=09=09};
-=09=09cpr_opp2: opp2 {
-=09=09=09opp-level =3D <2>;
-=09=09=09qcom,opp-fuse-level =3D <2>;
-=09=09};
-=09=09cpr_opp3: opp3 {
-=09=09=09opp-level =3D <3>;
-=09=09=09qcom,opp-fuse-level =3D <3>;
-=09=09};
-=09};
-
-....
-
-soc {
-....
-=09cpr: power-controller@b018000 {
-=09=09compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
-=09=09reg =3D <0x0b018000 0x1000>;
-=09=09....
-=09=09vdd-apc-supply =3D <&pms405_s3>;
-=09=09#power-domain-cells =3D <0>;
-=09=09operating-points-v2 =3D <&cpr_opp_table>;
-=09=09....
-=09};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index a7715fc859f7..e62cd1f613c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15660,7 +15660,7 @@ QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:=09Ilia Lin <ilia.lin@kernel.org>
 L:=09linux-pm@vger.kernel.org
 S:=09Maintained
-F:=09Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+F:=09Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
 F:=09drivers/cpufreq/qcom-cpufreq-nvmem.c
=20
 QUALCOMM CRYPTO DRIVERS
--=20
2.33.0


