Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7295242D50C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhJNIfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:35:08 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19]:38613 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJNIe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:34:57 -0400
Date:   Thu, 14 Oct 2021 08:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634200370;
        bh=Hrrk35JGBJVgR6EyIxicF+zgWHKrEmK2CKz919gONyo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=lAsAmdvre78Npd4Y4LgiKN2Lp27+gNIHXFTB6EnwgOq2WimB4WiW46/6aJB5wfvVV
         nQqBSPXZSIdo7AxssbcUeU1fPaRz/Nn3pLehVkcTe7SKw+IyYvpMWr8p63W5ymz2HT
         B2QSmYQZFBSEJmyw9WVG9x/39DJWGVN4ZqgvjZGA=
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
Subject: [PATCH 7/8] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
Message-ID: <20211014083016.137441-8-y.oudjana@protonmail.com>
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

Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU OPPs.
CBF OPPs and CPR parameters will be added to it as well once support for
CBF scaling and CPR is introduced.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi    |  82 +++----
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281 +++++++++++++++++++++++
 2 files changed, 322 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 94a846c3f1ee..5b2600a4fb2a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -142,82 +142,82 @@ cluster0_opp: opp_table0 {
 =09=09/* Nominal fmax for now */
 =09=09opp-307200000 {
 =09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-422400000 {
 =09=09=09opp-hz =3D /bits/ 64 <422400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-480000000 {
 =09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-556800000 {
 =09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-652800000 {
 =09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-729600000 {
 =09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-844800000 {
 =09=09=09opp-hz =3D /bits/ 64 <844800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-960000000 {
 =09=09=09opp-hz =3D /bits/ 64 <960000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1036800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1113600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1190400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1228800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1228800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1324800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1401600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1478400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1593600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1593600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09};
@@ -230,127 +230,127 @@ cluster1_opp: opp_table1 {
 =09=09/* Nominal fmax for now */
 =09=09opp-307200000 {
 =09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-403200000 {
 =09=09=09opp-hz =3D /bits/ 64 <403200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-480000000 {
 =09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-556800000 {
 =09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-652800000 {
 =09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-729600000 {
 =09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-806400000 {
 =09=09=09opp-hz =3D /bits/ 64 <806400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-883200000 {
 =09=09=09opp-hz =3D /bits/ 64 <883200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-940800000 {
 =09=09=09opp-hz =3D /bits/ 64 <940800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1036800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1113600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1190400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1248000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1248000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1324800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1401600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1478400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1555200000 {
 =09=09=09opp-hz =3D /bits/ 64 <1555200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1632000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1632000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1708800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1708800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1785600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1785600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1824000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1824000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1920000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1920000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1996800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1996800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-2073600000 {
 =09=09=09opp-hz =3D /bits/ 64 <2073600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-2150400000 {
 =09=09=09opp-hz =3D /bits/ 64 <2150400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09};
diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts=
/qcom/msm8996pro.dtsi
new file mode 100644
index 000000000000..8c8dd5614f4d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include "msm8996.dtsi"
+
+/*
+ * MSM8996 Pro (also known as MSM8996SG) is a revision of MSM8996 with
+ * different CPU, CBF and GPU frequencies as well as CPR parameters.
+ */
+/delete-node/ &cluster0_opp;
+/delete-node/ &cluster1_opp;
+
+/ {
+=09qcom,msm-id =3D <305 0x10000>;
+
+=09cluster0_opp: opp_table0 {
+=09=09compatible =3D "operating-points-v2-kryo-cpu";
+=09=09nvmem-cells =3D <&speedbin_efuse>;
+=09=09opp-shared;
+
+=09=09opp-307200000 {
+=09=09=09opp-hz =3D /bits/ 64 <307200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-384000000 {
+=09=09=09opp-hz =3D /bits/ 64 <384000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-460800000 {
+=09=09=09opp-hz =3D /bits/ 64 <460800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-537600000 {
+=09=09=09opp-hz =3D /bits/ 64 <537600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-614400000 {
+=09=09=09opp-hz =3D /bits/ 64 <614400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-691200000 {
+=09=09=09opp-hz =3D /bits/ 64 <691200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-768000000 {
+=09=09=09opp-hz =3D /bits/ 64 <768000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-844800000 {
+=09=09=09opp-hz =3D /bits/ 64 <844800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-902400000 {
+=09=09=09opp-hz =3D /bits/ 64 <902400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-979200000 {
+=09=09=09opp-hz =3D /bits/ 64 <979200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1056000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1132800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1209600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1286400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1363200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1440000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1516800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1593600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1996800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1996800000>;
+=09=09=09opp-supported-hw =3D <0x2>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2188800000 {
+=09=09=09opp-hz =3D /bits/ 64 <2188800000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09};
+
+=09cluster1_opp: opp_table1 {
+=09=09compatible =3D "operating-points-v2-kryo-cpu";
+=09=09nvmem-cells =3D <&speedbin_efuse>;
+=09=09opp-shared;
+
+=09=09opp-307200000 {
+=09=09=09opp-hz =3D /bits/ 64 <307200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-384000000 {
+=09=09=09opp-hz =3D /bits/ 64 <384000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-460800000 {
+=09=09=09opp-hz =3D /bits/ 64 <460800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-537600000 {
+=09=09=09opp-hz =3D /bits/ 64 <537600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-614400000 {
+=09=09=09opp-hz =3D /bits/ 64 <614400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-691200000 {
+=09=09=09opp-hz =3D /bits/ 64 <691200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-748800000 {
+=09=09=09opp-hz =3D /bits/ 64 <748800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-825600000 {
+=09=09=09opp-hz =3D /bits/ 64 <825600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-902400000 {
+=09=09=09opp-hz =3D /bits/ 64 <902400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-979200000 {
+=09=09=09opp-hz =3D /bits/ 64 <979200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1056000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1132800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1209600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1286400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1363200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1440000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1516800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1593600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1670400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1670400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1747200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1747200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1824000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1824000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1900800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1900800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1977600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1977600000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2054400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2054400000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2150400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2150400000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2246400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2246400000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2342400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2342400000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09};
+};
+
+&gpu_opp_table {
+=09/*
+=09 * All MSM8996 GPU OPPs are available on MSM8996 Pro,
+=09 * in addition to one:
+=09 */
+=09opp-652800000 {
+=09=09opp-hz =3D /bits/ 64 <652800000>;
+=09=09opp-supported-hw =3D <0x1>;
+=09};
+};
+
+&kryocc {
+=09compatible =3D "qcom,msm8996pro-apcc";
+};
--=20
2.33.0


