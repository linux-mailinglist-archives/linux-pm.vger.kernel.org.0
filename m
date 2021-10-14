Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF342D511
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJNIfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:35:14 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:46586 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhJNIfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:35:01 -0400
Date:   Thu, 14 Oct 2021 08:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200370;
        bh=bWgO6L6XhMrJXLdSTzSziDp7dYGdmglvp3oroqvvhMU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AHNwI4wttIBUQwgY6/zuqbzrNM9U70WJ2odE4RDq1i81KvYQPSdIDrm5UCsZDVBQX
         NHjwECjysdsxet0aymZK2BjWFFTXa80DEhWhHvq1p3EjWDz8BoJvGms2q7x9237FY8
         VJALpamXe9zCWqIBayDlHBFL0+ZLEzUOcKOd5CnA=
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
Subject: [PATCH 6/8] dt-bindings: opp: qcom-cpufreq-nvmem: Remove SMEM
Message-ID: <20211014083016.137441-7-y.oudjana@protonmail.com>
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

qcom-cpufreq-nvmem no longer uses SMEM. Remove all references to it,
and update the opp-supported-hw description to show the new
possible values

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/opp/qcom-cpufreq-nvmem.yaml      | 362 +-----------------
 1 file changed, 21 insertions(+), 341 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml =
b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
index 4a7d4826746e..338781c63ba6 100644
--- a/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/opp/qcom-cpufreq-nvmem.yaml
@@ -13,11 +13,11 @@ description: |
   In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
   the CPU frequencies subset and voltage value of each OPP varies based on
   the silicon variant in use.
-  Qualcomm Technologies, Inc. Process Voltage Scaling Tables
-  defines the voltage and frequency value based on the msm-id in SMEM
-  and speedbin blown in the efuse combination.
-  The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the =
SoC
-  to provide the OPP framework with required information (existing HW bitm=
ap).
+  Qualcomm Technologies, Inc. Process Voltage Scaling Tables defines
+  the voltage and frequency value based on the speedbin blown in the
+  efuse combination.
+  The qcom-cpufreq-nvmem driver reads the efuse value from the SoC to prov=
ide
+  the OPP framework with required information (existing HW bitmap).
   This is used to determine the voltage and frequency value for each OPP o=
f
   operating-points-v2 table when it is parsed by the OPP framework.
=20
@@ -60,14 +60,10 @@ patternProperties:
             description: |
               A single 32 bit bitmap value, representing compatible HW.
               Bitmap:
-              0:  MSM8996 V3, speedbin 0
-              1:  MSM8996 V3, speedbin 1
-              2:  MSM8996 V3, speedbin 2
-              3:  unused
-              4:  MSM8996 SG, speedbin 0
-              5:  MSM8996 SG, speedbin 1
-              6:  MSM8996 SG, speedbin 2
-              7-31:  unused
+              0:  MSM8996, speedbin 0
+              1:  MSM8996, speedbin 1
+              2:  MSM8996, speedbin 2
+              3-31:  unused
=20
         required:
           - opp-hz
@@ -212,206 +208,82 @@ examples:
=20
             opp-307200000 {
                 opp-hz =3D /bits/ 64 <307200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x77>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-384000000 {
-                opp-hz =3D /bits/ 64 <384000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-422400000 {
                 opp-hz =3D /bits/ 64 <422400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-460800000 {
-                opp-hz =3D /bits/ 64 <460800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-480000000 {
                 opp-hz =3D /bits/ 64 <480000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-537600000 {
-                opp-hz =3D /bits/ 64 <537600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-556800000 {
                 opp-hz =3D /bits/ 64 <556800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-614400000 {
-                opp-hz =3D /bits/ 64 <614400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-652800000 {
                 opp-hz =3D /bits/ 64 <652800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-691200000 {
-                opp-hz =3D /bits/ 64 <691200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-729600000 {
                 opp-hz =3D /bits/ 64 <729600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-768000000 {
-                opp-hz =3D /bits/ 64 <768000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-844800000 {
                 opp-hz =3D /bits/ 64 <844800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x77>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-902400000 {
-                opp-hz =3D /bits/ 64 <902400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-960000000 {
                 opp-hz =3D /bits/ 64 <960000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-979200000 {
-                opp-hz =3D /bits/ 64 <979200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1036800000 {
                 opp-hz =3D /bits/ 64 <1036800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1056000000 {
-                opp-hz =3D /bits/ 64 <1056000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1113600000 {
                 opp-hz =3D /bits/ 64 <1113600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1132800000 {
-                opp-hz =3D /bits/ 64 <1132800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1190400000 {
                 opp-hz =3D /bits/ 64 <1190400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1209600000 {
-                opp-hz =3D /bits/ 64 <1209600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1228800000 {
                 opp-hz =3D /bits/ 64 <1228800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1286400000 {
-                opp-hz =3D /bits/ 64 <1286400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1324800000 {
                 opp-hz =3D /bits/ 64 <1324800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x5>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1363200000 {
-                opp-hz =3D /bits/ 64 <1363200000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x72>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-1401600000 {
                 opp-hz =3D /bits/ 64 <1401600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x5>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1440000000 {
-                opp-hz =3D /bits/ 64 <1440000000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-1478400000 {
                 opp-hz =3D /bits/ 64 <1478400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x1>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1497600000 {
-                opp-hz =3D /bits/ 64 <1497600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x4>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1516800000 {
-                opp-hz =3D /bits/ 64 <1516800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-1593600000 {
                 opp-hz =3D /bits/ 64 <1593600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x71>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1996800000 {
-                opp-hz =3D /bits/ 64 <1996800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x20>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-2188800000 {
-                opp-hz =3D /bits/ 64 <2188800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x10>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
         };
@@ -423,323 +295,131 @@ examples:
=20
             opp-307200000 {
                 opp-hz =3D /bits/ 64 <307200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x77>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-384000000 {
-                opp-hz =3D /bits/ 64 <384000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-403200000 {
                 opp-hz =3D /bits/ 64 <403200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-460800000 {
-                opp-hz =3D /bits/ 64 <460800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-480000000 {
                 opp-hz =3D /bits/ 64 <480000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-537600000 {
-                opp-hz =3D /bits/ 64 <537600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-556800000 {
                 opp-hz =3D /bits/ 64 <556800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-614400000 {
-                opp-hz =3D /bits/ 64 <614400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-652800000 {
                 opp-hz =3D /bits/ 64 <652800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-691200000 {
-                opp-hz =3D /bits/ 64 <691200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-729600000 {
                 opp-hz =3D /bits/ 64 <729600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-748800000 {
-                opp-hz =3D /bits/ 64 <748800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-806400000 {
                 opp-hz =3D /bits/ 64 <806400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-825600000 {
-                opp-hz =3D /bits/ 64 <825600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-883200000 {
                 opp-hz =3D /bits/ 64 <883200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-902400000 {
-                opp-hz =3D /bits/ 64 <902400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-940800000 {
                 opp-hz =3D /bits/ 64 <940800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-979200000 {
-                opp-hz =3D /bits/ 64 <979200000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1036800000 {
                 opp-hz =3D /bits/ 64 <1036800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1056000000 {
-                opp-hz =3D /bits/ 64 <1056000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1113600000 {
                 opp-hz =3D /bits/ 64 <1113600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1132800000 {
-                opp-hz =3D /bits/ 64 <1132800000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1190400000 {
                 opp-hz =3D /bits/ 64 <1190400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1209600000 {
-                opp-hz =3D /bits/ 64 <1209600000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1248000000 {
                 opp-hz =3D /bits/ 64 <1248000000>;
-                opp-microvolt =3D <905000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1286400000 {
-                opp-hz =3D /bits/ 64 <1286400000>;
-                opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1324800000 {
                 opp-hz =3D /bits/ 64 <1324800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1363200000 {
-                opp-hz =3D /bits/ 64 <1363200000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1401600000 {
                 opp-hz =3D /bits/ 64 <1401600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1440000000 {
-                opp-hz =3D /bits/ 64 <1440000000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1478400000 {
                 opp-hz =3D /bits/ 64 <1478400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1516800000 {
-                opp-hz =3D /bits/ 64 <1516800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1555200000 {
                 opp-hz =3D /bits/ 64 <1555200000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1593600000 {
-                opp-hz =3D /bits/ 64 <1593600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1632000000 {
                 opp-hz =3D /bits/ 64 <1632000000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1670400000 {
-                opp-hz =3D /bits/ 64 <1670400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1708800000 {
                 opp-hz =3D /bits/ 64 <1708800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1747200000 {
-                opp-hz =3D /bits/ 64 <1747200000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1785600000 {
                 opp-hz =3D /bits/ 64 <1785600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
                 opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1804800000 {
-                opp-hz =3D /bits/ 64 <1804800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x6>;
-                clock-latency-ns =3D <200000>;
-            };
             opp-1824000000 {
                 opp-hz =3D /bits/ 64 <1824000000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x71>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1900800000 {
-                opp-hz =3D /bits/ 64 <1900800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x74>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-1920000000 {
                 opp-hz =3D /bits/ 64 <1920000000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x1>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-1977600000 {
-                opp-hz =3D /bits/ 64 <1977600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x30>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-1996800000 {
                 opp-hz =3D /bits/ 64 <1996800000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x1>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-2054400000 {
-                opp-hz =3D /bits/ 64 <2054400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x30>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-2073600000 {
                 opp-hz =3D /bits/ 64 <2073600000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x1>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
             opp-2150400000 {
                 opp-hz =3D /bits/ 64 <2150400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x31>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-2246400000 {
-                opp-hz =3D /bits/ 64 <2246400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x10>;
-                clock-latency-ns =3D <200000>;
-            };
-            opp-2342400000 {
-                opp-hz =3D /bits/ 64 <2342400000>;
-                opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x10>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
         };
=20
-        reserved-memory {
-            #address-cells =3D <2>;
-            #size-cells =3D <2>;
-            ranges;
-
-            smem_mem: smem-mem@86000000 {
-                reg =3D <0x0 0x86000000 0x0 0x200000>;
-                no-map;
-            };
-        };
-
-        smem {
-            compatible =3D "qcom,smem";
-            memory-region =3D <&smem_mem>;
-            hwlocks =3D <&tcsr_mutex 3>;
-        };
-
         soc {
             #address-cells =3D <1>;
             #size-cells =3D <1>;
--=20
2.33.0


