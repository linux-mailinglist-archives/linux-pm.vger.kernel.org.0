Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A297361C8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfFEQy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32968 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfFEQyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165442euoutp0155c73f79af0032fb39186bea6b1fcf6f~lW7XYxOrM3068430684euoutp01Q
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165442euoutp0155c73f79af0032fb39186bea6b1fcf6f~lW7XYxOrM3068430684euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753682;
        bh=mthdXt8+1BBqAwDpS+JBQSoIDQoTopKi0vJ3nHDe/FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1gu0GZKq6RuIelibQWpv0FuyT66zmoLIyneQ3pp5AGMei6UjkllLEobL643l2Xfk
         dt+xF0DufwZQSyD4QE3aOa7j7dt3r8MGv8mneM5COaKAao7lp+8G74MJFTWphBPgbb
         /Qppd7Nff/NWmYJuATc9F6W/GlqQBV5+6FDm8OXY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165441eucas1p12461b6c3de5b57302019576f92684375~lW7WalZoa0348103481eucas1p1b;
        Wed,  5 Jun 2019 16:54:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F2.5E.04377.1D3F7FC5; Wed,  5
        Jun 2019 17:54:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165440eucas1p104d84f6485afae10ce9d68cd25200ae1~lW7VjBMYp0348903489eucas1p1b;
        Wed,  5 Jun 2019 16:54:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165440eusmtrp2b57eb71a1f5c90cd6004f9922c9e821f~lW7VTdEYW2868028680eusmtrp2h;
        Wed,  5 Jun 2019 16:54:40 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-04-5cf7f3d1bb92
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.4D.04140.0D3F7FC5; Wed,  5
        Jun 2019 17:54:40 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165438eusmtip1e6b25a622838eb164b39a9644fc10c3f~lW7UDsZ5u0289902899eusmtip1T;
        Wed,  5 Jun 2019 16:54:38 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v8 12/13] ARM: dts: exynos: add DMC device for exynos5422
Date:   Wed,  5 Jun 2019 18:54:09 +0200
Message-Id: <20190605165410.14606-13-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG/XbO2Y7i7DQj30oylkYWaVf6oggFg1MQ9E//lKCnPKm0Ld3x
        bsUqsNK8oGWtshuJti3UZeIlvMyxRWabKGSp3bSrWrPZ1aicZ9Z/z/d7n+d7Xj4+mlBYqYV0
        siaN12o4lVLqRzbYfjhW9bi/xa4uGfTHdRdqKPx48i2Fr1ofUdg4MYxw2YMKCX5YoMbFw6ME
        djhqZbj7+JgMP9UF497my1LsLrQifMHRKsG3rUMyPHCsWoo7x05SuK1vBx6YCsBf779CUYHs
        1y+lJHtJ10OyTReHZKzZcFrKFp74KGU7Pt6TsEX1BsTe6cpl3ebFu3z3+G1J4FXJGbw2cmu8
        X9LL+w1kyviarLcFHUiHbGH5yJcGZj04R3qIfORHK5hqBDW2blI8TCK4fKqd8rgUjBtB7U1q
        NlHWb/SaqhC0OR7I/iXu6i9J8hFNS5kIaDSkegLzmFwYfNw2U0EwYxLo/vmd9AwCme1gfPNw
        xk8yYaDLi/RgORMFva4pQiwLAWNt+4z2nebl9jszxcA8k8Ez67BUNMXAZ1e5VwfCB3u9TNTB
        8KfpqkTUAugKryNRH4bh4gqvZzN02nsozw4EEw41zZEijobSSpfMg4EJgP7xuR5MTMvShvOE
        iOVwKk8hupdD/Rmnt2g+VJnKvZez8PqKWyq+ThkCi7ELlaCQi//LriFkQEF8uqBO5IW1Gj4z
        QuDUQromMWL/IbUZTf+trt/2yUbU/GufBTE0UvrLoe5brILiMoRstQUBTSjnybmByViFPIHL
        zuG1h+K06SpesKBFNKkMkuf6vNirYBK5NP4gz6fw2tmphPZdqEPnnpvObqu9Ucmf1zv79K2d
        lU6VYk76RnXrkZzmd6m/4s4NFPQVbQiNgdBNK4/6r1q/JH+KOzCGN8Tsiyejl96qHMqq+rHA
        ZNZPkMU3W0b7Xe6AwrzdO1P1LRHX1SN9E5mfRmPJcGNRgU355H2qsr8iwNVh0CwLJE0+R33W
        3VgqV5JCErdmBaEVuL8yxN0CVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7oXPn+PMdh2mc9i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jIcntrEUvDWseN59kLGB8ZhqFyMnh4SAicTkG6tZ
        uhi5OIQEljJKLN70iQ0iISYxad92dghbWOLPtS42iKJPjBIHv11k7mLk4GAT0JPYsaoQpEZE
        oF6i/80lsBpmgQZmiTXbr7KCJIQFPCVWPzvDBFLPIqAq0dCmDxLmFXCQuPzhNzPEfHmJ1RsO
        gNmcQPFpxzezgNhCAvYSl67/Zp7AyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYCRt
        O/Zzyw7GrnfBhxgFOBiVeHglNn6PEWJNLCuuzD3EKMHBrCTCm3j7S4wQb0piZVVqUX58UWlO
        avEhRlOgmyYyS4km5wOjPK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8T
        B6dUA6NV+AO3y+kzGQpVjrHorzbhP1/9QfNwa7Lag/r/yo+P7bgpmpX2Qmy+1CfD57lSrzL/
        rJeuy9Nb+tSizfSXb3RtSTpD5o6NbYHvM/8VnRYXOHL9ZJfI9cTGwLPdQezXlf1X7J1YU+u7
        wMbhhuLenCVqDfa90w/v35w8S4gzM7hqelb8huv+v5RYijMSDbWYi4oTAYnQ0gS6AgAA
X-CMS-MailID: 20190605165440eucas1p104d84f6485afae10ce9d68cd25200ae1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165440eucas1p104d84f6485afae10ce9d68cd25200ae1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165440eucas1p104d84f6485afae10ce9d68cd25200ae1
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165440eucas1p104d84f6485afae10ce9d68cd25200ae1@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5422-dmc driver.
There is a definition of the memory chip, which is then used during
calculation of timings for each OPP.
The algorithm in the driver needs these two sets to bound the timings.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             |  79 ++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 116 ++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d153617ff1a3..a18b225c983e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,37 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
+			clocks = <&clock CLK_FOUT_SPLL>,
+				 <&clock CLK_MOUT_SCLK_SPLL>,
+				 <&clock CLK_FF_DOUT_SPLL2>,
+				 <&clock CLK_FOUT_BPLL>,
+				 <&clock CLK_MOUT_BPLL>,
+				 <&clock CLK_SCLK_BPLL>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				 <&clock CLK_MOUT_MCLK_CDREX>,
+				 <&clock CLK_DOUT_CLK2X_PHY0>,
+				 <&clock CLK_CLKM_PHY0>,
+				 <&clock CLK_CLKM_PHY1>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mx_mspll_ccore_phy",
+				      "mout_mclk_cdrex",
+				      "dout_clk2x_phy0",
+				      "clkm_phy0",
+				      "clkm_phy1";
+			samsung,syscon-clk = <&clock>;
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +302,54 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+				};
+			};
+		};
+
+		ppmu_dmc0_1: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d10000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+				};
+			};
+		};
+
+		ppmu_dmc1_0: ppmu@10d60000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d60000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+				};
+			};
+		};
+
+		ppmu_dmc1_1: ppmu@10d70000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d70000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de15c9b..30e569c13ee7 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -34,6 +34,97 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	dmc_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <165000000>;
+			opp-microvolt = <875000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <206000000>;
+			opp-microvolt = <875000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <275000000>;
+			opp-microvolt = <875000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <413000000>;
+			opp-microvolt = <887500>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <543000000>;
+			opp-microvolt = <937500>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <633000000>;
+			opp-microvolt = <1012500>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <728000000>;
+			opp-microvolt = <1037500>;
+		};
+		opp07 {
+			opp-hz = /bits/ 64 <825000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
+	samsung_K3QF2F20DB: lpddr3 {
+		compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
+		density		= <16384>;
+		io-width	= <32>;
+		#address-cells  = <1>;
+		#size-cells     = <0>;
+
+		tRFC-min-tck		= <17>;
+		tRRD-min-tck		= <2>;
+		tRPab-min-tck		= <2>;
+		tRPpb-min-tck		= <2>;
+		tRCD-min-tck		= <3>;
+		tRC-min-tck		= <6>;
+		tRAS-min-tck		= <5>;
+		tWTR-min-tck		= <2>;
+		tWR-min-tck		= <7>;
+		tRTP-min-tck		= <2>;
+		tW2W-C2C-min-tck	= <0>;
+		tR2R-C2C-min-tck	= <0>;
+		tWL-min-tck		= <8>;
+		tDQSCK-min-tck		= <5>;
+		tRL-min-tck		= <14>;
+		tFAW-min-tck		= <5>;
+		tXSR-min-tck		= <12>;
+		tXP-min-tck		= <2>;
+		tCKE-min-tck		= <2>;
+		tCKESR-min-tck		= <2>;
+		tMRD-min-tck		= <5>;
+
+		timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
+			compatible	= "jedec,lpddr3-timings";
+			reg		= <800000000>; /* workaround: it shows max-freq */
+			min-freq	= <100000000>;
+			tRFC		= <65000>;
+			tRRD		= <6000>;
+			tRPab		= <12000>;
+			tRPpb		= <12000>;
+			tRCD		= <10000>;
+			tRC		= <33750>;
+			tRAS		= <23000>;
+			tWTR		= <3750>;
+			tWR		= <7500>;
+			tRTP		= <3750>;
+			tW2W-C2C	= <0>;
+			tR2R-C2C	= <0>;
+			tFAW		= <25000>;
+			tXSR		= <70000>;
+			tXP		= <3750>;
+			tCKE		= <3750>;
+			tCKESR		= <3750>;
+			tMRD		= <7000>;
+		};
+	};
 };
 
 &adc {
@@ -132,6 +223,15 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
+			<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+	device-handle = <&samsung_K3QF2F20DB>;
+	operating-points-v2 = <&dmc_opp_table>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -540,6 +640,22 @@
 	};
 };
 
+&ppmu_dmc0_0 {
+	status = "okay";
+};
+
+&ppmu_dmc0_1 {
+	status = "okay";
+};
+
+&ppmu_dmc1_0 {
+	status = "okay";
+};
+
+&ppmu_dmc1_1 {
+	status = "okay";
+};
+
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 };
-- 
2.17.1

