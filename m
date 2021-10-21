Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66F4362E0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJUN1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:27:49 -0400
Received: from mail-40138.protonmail.ch ([185.70.40.138]:16716 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJUN1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:27:47 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2021 09:27:46 EDT
Date:   Thu, 21 Oct 2021 13:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822726;
        bh=nuOvHKjHTwxeAM9TscBnoeXxs/55JU1OgJG+jydjNjU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=NZYCHXTTgfLYN6D2i++aL5NaDf/JmvoybTWbpk2sWUCgVnPjjzj7x4ltb9EzwVi/x
         m9tCxACJZfuo0uk3BqGj5vkGhIijOrR221Cl4P3awENRvb321VJENgI/jQQafr6HvK
         ozA2JkVte8hygwT0I8DqFr34/CcNbWck6i/lRWbI=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v5 5/5] arm64: dts: qcom: msm8996: Add interconnect support
Message-ID: <20211021132329.234942-6-y.oudjana@protonmail.com>
In-Reply-To: <20211021132329.234942-1-y.oudjana@protonmail.com>
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
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

Add interconnect providers for the multiple NoCs available on the platform,
and assign interconnects used by some blocks.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v4:
 - Add support for Aggregate 0 NoC (a0noc).
Changes since v2:
 - Remove interconnect paths from CPUs since cpufreq driver doesn't support=
 icc scaling yet.

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 93 +++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 465cd19a4951..9f0cfe19163c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/interconnect/qcom,msm8996.h>
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/thermal/thermal.h>
=20
@@ -683,6 +684,15 @@ gcc: clock-controller@300000 {
 =09=09=09clock-names =3D "cxo2";
 =09=09};
=20
+=09=09bimc: interconnect@408000 {
+=09=09=09compatible =3D "qcom,msm8996-bimc";
+=09=09=09reg =3D <0x00408000 0x5a000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_BIMC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+=09=09};
+
 =09=09tsens0: thermal-sensor@4a9000 {
 =09=09=09compatible =3D "qcom,msm8996-tsens", "qcom,tsens-v2";
 =09=09=09reg =3D <0x004a9000 0x1000>, /* TM */
@@ -705,6 +715,74 @@ tsens1: thermal-sensor@4ad000 {
 =09=09=09#thermal-sensor-cells =3D <1>;
 =09=09};
=20
+=09=09cnoc: interconnect@500000 {
+=09=09=09compatible =3D "qcom,msm8996-cnoc";
+=09=09=09reg =3D <0x00500000 0x1000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_CNOC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+=09=09};
+
+=09=09snoc: interconnect@524000 {
+=09=09=09compatible =3D "qcom,msm8996-snoc";
+=09=09=09reg =3D <0x00524000 0x1c000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_SNOC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+=09=09};
+
+=09=09a0noc: interconnect@543000 {
+=09=09=09compatible =3D "qcom,msm8996-a0noc";
+=09=09=09reg =3D <0x00543000 0x6000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "aggre0_snoc_axi",
+=09=09=09=09      "aggre0_cnoc_ahb",
+=09=09=09=09      "aggre0_noc_mpu_cfg";
+=09=09=09clocks =3D <&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
+=09=09=09=09 <&gcc GCC_AGGRE0_CNOC_AHB_CLK>,
+=09=09=09=09 <&gcc GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK>;
+=09=09=09power-domains =3D <&gcc AGGRE0_NOC_GDSC>;
+=09=09};
+
+=09=09a1noc: interconnect@562000 {
+=09=09=09compatible =3D "qcom,msm8996-a1noc";
+=09=09=09reg =3D <0x00562000 0x5000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_AGGR1_NOC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_AGGR1_NOC_A_CLK>;
+=09=09};
+
+=09=09a2noc: interconnect@583000 {
+=09=09=09compatible =3D "qcom,msm8996-a2noc";
+=09=09=09reg =3D <0x00583000 0x7000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+=09=09};
+
+=09=09mnoc: interconnect@5a4000 {
+=09=09=09compatible =3D "qcom,msm8996-mnoc";
+=09=09=09reg =3D <0x005a4000 0x1c000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a", "iface";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_MMAXI_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_MMAXI_A_CLK>,
+=09=09=09=09 <&mmcc AHB_CLK_SRC>;
+=09=09};
+
+=09=09pnoc: interconnect@5c0000 {
+=09=09=09compatible =3D "qcom,msm8996-pnoc";
+=09=09=09reg =3D <0x005c0000 0x3000>;
+=09=09=09#interconnect-cells =3D <1>;
+=09=09=09clock-names =3D "bus", "bus_a";
+=09=09=09clocks =3D <&rpmcc RPM_SMD_PCNOC_CLK>,
+=09=09=09=09 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+=09=09};
+
 =09=09tcsr_mutex_regs: syscon@740000 {
 =09=09=09compatible =3D "syscon";
 =09=09=09reg =3D <0x00740000 0x40000>;
@@ -784,6 +862,11 @@ mdp: mdp@901000 {
 =09=09=09=09assigned-clock-rates =3D <300000000>,
 =09=09=09=09=09 <19200000>;
=20
+=09=09=09=09interconnects =3D <&mnoc MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>=
,
+=09=09=09=09=09=09<&mnoc MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
+=09=09=09=09=09=09<&mnoc MASTER_ROTATOR &bimc SLAVE_EBI_CH0>;
+=09=09=09=09interconnect-names =3D "mdp0-mem", "mdp1-mem", "rotator-mem";
+
 =09=09=09=09ports {
 =09=09=09=09=09#address-cells =3D <1>;
 =09=09=09=09=09#size-cells =3D <0>;
@@ -959,6 +1042,9 @@ gpu: gpu@b00000 {
 =09=09=09=09"mem",
 =09=09=09=09"mem_iface";
=20
+=09=09=09interconnects =3D <&bimc MASTER_GRAPHICS_3D &bimc SLAVE_EBI_CH0>;
+=09=09=09interconnect-names =3D "gfx-mem";
+
 =09=09=09power-domains =3D <&mmcc GPU_GX_GDSC>;
 =09=09=09iommus =3D <&adreno_smmu 0>;
=20
@@ -1986,6 +2072,9 @@ venus: video-codec@c00000 {
 =09=09=09=09 <&mmcc VIDEO_AXI_CLK>,
 =09=09=09=09 <&mmcc VIDEO_MAXI_CLK>;
 =09=09=09clock-names =3D "core", "iface", "bus", "mbus";
+=09=09=09interconnects =3D <&mnoc MASTER_VIDEO_P0 &bimc SLAVE_EBI_CH0>,
+=09=09=09=09=09<&bimc MASTER_AMPSS_M0 &mnoc SLAVE_VENUS_CFG>;
+=09=09=09interconnect-names =3D "video-mem", "cpu-cfg";
 =09=09=09iommus =3D <&venus_smmu 0x00>,
 =09=09=09=09 <&venus_smmu 0x01>,
 =09=09=09=09 <&venus_smmu 0x0a>,
@@ -2602,6 +2691,10 @@ usb3: usb@6af8800 {
 =09=09=09=09=09  <&gcc GCC_USB30_MASTER_CLK>;
 =09=09=09assigned-clock-rates =3D <19200000>, <120000000>;
=20
+=09=09=09interconnects =3D <&a2noc MASTER_USB3 &bimc SLAVE_EBI_CH0>,
+=09=09=09=09=09<&bimc MASTER_AMPSS_M0 &snoc SLAVE_USB3>;
+=09=09=09interconnect-names =3D "usb-ddr", "apps-usb";
+
 =09=09=09power-domains =3D <&gcc USB30_GDSC>;
 =09=09=09status =3D "disabled";
=20
--=20
2.33.1


