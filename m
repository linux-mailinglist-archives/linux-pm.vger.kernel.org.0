Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF797757
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfHUKnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfHUKn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104326euoutp020fe1e513f50b709a8b40ca80c87a4014~86iMVAK-A0273902739euoutp02J
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104326euoutp020fe1e513f50b709a8b40ca80c87a4014~86iMVAK-A0273902739euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384206;
        bh=TAPWPPhwwkIk8EwgyjxnFQvKK3TRw7k8bAwvjvG/ja4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8aFdpVeksx8I5eonW2H1y26JML78EDEso5qqa8T+rHzYJ+OyyOlvIqe2hn/1cXBI
         W3or+w2UDLDlIMRbycLvkVSfrcv6cQb52HRrbJfIHFvdOhqI+OPeDmO1pSarNfsiPr
         FeB6C7WLE++IZbweMTZ6y0HWl0kriKPy16A7kC3o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821104325eucas1p2404caecca8fe338ba49b457907d19fb5~86iLXMTpz0891408914eucas1p2K;
        Wed, 21 Aug 2019 10:43:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.B6.04374.D402D5D5; Wed, 21
        Aug 2019 11:43:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17~86iKgWQ_d1333613336eucas1p1X;
        Wed, 21 Aug 2019 10:43:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104324eusmtrp2a365a112a2efa3b90bf2616b2d7539fc~86iKfsF9I2827428274eusmtrp2H;
        Wed, 21 Aug 2019 10:43:24 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-6d-5d5d204dc56a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.48.04117.C402D5D5; Wed, 21
        Aug 2019 11:43:24 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104323eusmtip2f9f79e629f802dc6ff89f2776eea528c~86iJbtZJi1732517325eusmtip22;
        Wed, 21 Aug 2019 10:43:23 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v13 7/8] ARM: dts: exynos: add DMC device for exynos5422
Date:   Wed, 21 Aug 2019 12:43:02 +0200
Message-Id: <20190821104303.32079-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0yNYRzHPee91jp5nUw/NOksG7YK+eMZ5rK5vGM2zT9WOzj0dplO5bwV
        YXawyFEHlUp1cmmU1DqlteLkUmdSIkdXWW6xUFJL0WUHr/c0/31+3+/393yfPXtYQjVEzWMj
        o+MEfbQ2Sk27klWPx1v8ti/UaJZZbV64PLuMwp0/+ih8xfacwreHexE+VVBG4/QmswI3n9Ph
        8739BG5psTD42ckBBncbvPBwyhsKt97No/FIqg3h7Jb7Clxq62HwjU67AtubNuHXJ4ponFRr
        Y3D9wBkKOzrKSfygbSt+PemOx558QOvn8iX5JYgfG00j+e9dSQyfa7CTfE1OD8NXFJ+l+Qfm
        EoZPPTVI848GrQreVFmM+DtPj/IjFQt2uAW7rgkVoiITBH3A2r2uEVPtn1Hsx4DDA0kpyIBS
        fY3IhQVuJXSVTxJG5MqquCIE/VNtjDz8QGBKG6PkYQTBY6tRMb2S0XTaaRQiSC69R0rGv5UX
        Od5GxLI05w/VxQcleTaXjSD3804pT3DvCTCV5iHJ8OB4+J01QUlMcosg/0sjLe0quXWQ1+Un
        d3nDbctDQmIXbj04LjT+6wXuGgvZAxZKDm2E5JOXaJk94GtDJSOzF/yuueK8tAiG1GtI5mPQ
        e97szKyG+gY7JfUS3BIouxsgyxvAVmllJBk4d+j6NkuSib+YVpVFyLISkk+r5PRiqEx54Sya
        A4Ulmc7DebhenuV8z3QEHx019AXknfO/7CpCxchTiBd14YIYGC0c8he1OjE+Otx/f4yuAv39
        h08dDaPV6P7UvjrEsUjtptzbGaJRUdoEMVFXh4Al1LOVh/OCNSplqDbxiKCP2aOPjxLEOjSf
        JdWeyqMz3oWouHBtnHBAEGIF/bSrYF3mGRBKg3bzJ/vawAJNaOYct7mthT9376iHd+SvPost
        yKRrWx4q/HpVZU08ezFiqXlssLXTccbD8/Kbt80TQ47rq46vSIls3Fa3ZeLRrIf9Rpsltjbd
        58DNXTkd2oXJYd0NYZ4emX0rfHp9gzLu+U2OWsf7MkLG3V8i08TMW36br24M4dWkGKFdvpTQ
        i9o/Z3Y2wYMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7o+CrGxBvfeGlhsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GX8ufqCseCJfsWb1h7GBsZelS5GTg4JAROJKafaWLsYuTiEBJYy
        SvQeX8gMkRCTmLRvOzuELSzx51oXG0TRJ0aJs3tbmLoYOTjYBPQkdqwqBImLCMxhlPjZtY0R
        xGEW+M0scfBuP1i3sICHxP/pv1hBbBYBVYl5L0+ygTTzCthLzLmhC7FAXmL1hgNgizkFHCT+
        TTgJVi4EVDJ1w1vWCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG6LZjP7fsYOx6
        F3yIUYCDUYmHd8fN6Fgh1sSy4srcQ4wSHMxKIrwVc6JihXhTEiurUovy44tKc1KLDzGaAt00
        kVlKNDkfmD7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw8mfk
        Fmy8dX7ppvB1F4wv7v20WuRD9FoTLm3NMI81W0/+2bSt6IHWviOvTc7s+Vuqy5Ma7R8imCK/
        zc5Qa/eeyh5GK6eAE0u+r1q9ZveclI0fEn/tYS0Sn/UwOcqx6jzHSssVWnL86Xv1ii3+Khqd
        dXF88+aBa1OxzORJLpXGD3nEbSOXruk7q8RSnJFoqMVcVJwIAOkkrK3nAgAA
X-CMS-MailID: 20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104324eucas1p16bdeb27250c8c9fa87591d6bd9743a17@eucas1p1.samsung.com>
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
 arch/arm/boot/dts/exynos5420.dtsi             |  71 +++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 116 ++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 97dc10915680..ac49373baae7 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -237,6 +237,29 @@
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
+				 <&clock CLK_MOUT_MCLK_CDREX>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mclk_cdrex";
+			samsung,syscon-clk = <&clock>;
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -273,6 +296,54 @@
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
index 829147e320e0..fe885ca969af 100644
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
 
@@ -634,6 +734,22 @@
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

