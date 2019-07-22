Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3D6FC9E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfGVJrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42272 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbfGVJrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094734euoutp02ba2e9ba8c4bf8b6a7f99522508cbc61e~zsa2Nk-et2886828868euoutp02n
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094734euoutp02ba2e9ba8c4bf8b6a7f99522508cbc61e~zsa2Nk-et2886828868euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788854;
        bh=TAPWPPhwwkIk8EwgyjxnFQvKK3TRw7k8bAwvjvG/ja4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBpjxp5c2nwto7sOLYBi4Ng2qOSqJdnGC25LeDJpZvh/nulf2kGhay8VtWiLSYet4
         aw+kEyL3yoxK47EeTX9v0x1c5usapcEnPniKkDmt/P/X7ncto90HZtiWJvzJsjHrqw
         2R10zQ3ujuCMS8lvmwrqV011NTWiGxjQp/F0qJKg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722094733eucas1p1352d430a1ca53d9d757f83b842f8f49b~zsa02cvS83210732107eucas1p1O;
        Mon, 22 Jul 2019 09:47:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.50.04325.436853D5; Mon, 22
        Jul 2019 10:47:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722094732eucas1p1bd2c7e20744637f9f48f40be71db0168~zsa0FCDqi1116311163eucas1p1j;
        Mon, 22 Jul 2019 09:47:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722094732eusmtrp10155eaa30cc6b46e3df1197681c9fddb~zsaz20RXI3266032660eusmtrp15;
        Mon, 22 Jul 2019 09:47:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-11-5d35863466b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.2A.04140.336853D5; Mon, 22
        Jul 2019 10:47:32 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094731eusmtip2213b97df39d3d0786303461c5ed5a20f~zsay5Sws_1004610046eusmtip2Y;
        Mon, 22 Jul 2019 09:47:30 +0000 (GMT)
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
Subject: [PATCH v12 8/9] ARM: dts: exynos: add DMC device for exynos5422
Date:   Mon, 22 Jul 2019 11:46:45 +0200
Message-Id: <20190722094646.13342-9-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjuO5ed42jjNCO/TIpWQUaplcIH2RWrQz8isF+J2CkPXjdrR8tL
        wVS0tE1NwSQ1lZTZ1Mw1TKVm6nJ5a42ymxiZRabmBXV2Eal5rP4973N7+V4+GldMkp50lDqe
        16i5WKVESjR2/rDv8M8MCPXrqNiFGorqSfR69guJyqzPSFQzPQxQ+u16CSroLsVQ7zUVyh0e
        w5Hdfo9CfWnjFHqn9ULTuvcketFSIkEzeitARXYLhuqsgxSqeu3AkKP7MBpIrZagjEdWCnWM
        XyHR4qsGArW+PIYGfsmR8+lHcGAtW3urFrDOuXyCnXyTQbHFWgfBNt8cpFiTMUvCtpbWUqw+
        fULCtk08xNgcsxGw93tS2BnT+hMrT0kDw/nYqAu8xnffaWnkQv8IOPfJN3E8Qwe0QL85G9A0
        ZPxhVjmWDaS0gqkG8P6N64Q4zAL4/d1VShxmAOwqGcWzgdtSorepHIiCAcA0i4n8FzHkvcJc
        vRLGBzYZz7sCq5kiAItHgl0enBnCYU5dCXAJ7gwLLT+fYy5MMFtgZqFuiZcx++FkXy8hbtsA
        a+49xl2dbswB+NWmEukKGg7lXBZxECw3PyBF7A5HbWZKxF6wp0C3XCNArb4CiPgSHM4tXfbs
        gR02B+mqxxlvWN/iK9IH4aDTIhEvJIdvvq1y0fgfmN94AxdpGbyaqRDdW6FZJ74DMmugobZw
        uZyFV6wty5cqAHDuVyWWBzbc/L+sHAAj8OATBFUEL+xW8xd9BE4lJKgjfM7GqUzgzzfsWbTN
        NQHLwpl2wNBAuVLm1+gfqiC5C0KSqh1AGleulqn9AkIVsnAuKZnXxIVpEmJ5oR2sowmlhyxl
        xYcQBRPBxfMxPH+O1/xVMdrNUwtCrYa99hN3gxY2yjZ6v52PHDJ7GTeB/mL/5LmT6xTNRbit
        Lcood3S3Nocs2o9I5bsmjk5tj5OnBj/Zn1g51V8WH5GlyU4N4TpHwmNP87qUqsNQf83pITSc
        bbuVuqnz+E86MHr4/dgd5w73ec40EP05RpceeKhsrSFd1hXnXRymJIRIbuc2XCNwvwF2ueCC
        ggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7ombaaxBvf0LTbOWM9qcf3Lc1aL
        +UfOsVqs/viY0aJ58Xo2i8mn5jJZnOnOteh//JrZ4vz5DewWZ5vesFvcapCx+Nhzj9Xi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLxf4rXha3
        f/NZfDvxiNFB0mPNvDWMHt++TmLxeH+jld1jdsNFFo+ds+6ye2xa1cnmsX/uGnaP3uZ3bB4H
        3+1h8ujbsorRY/Ppao/Pm+QCeKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0Mv5cfcFY8ES/4k1rD2MDY69KFyMnh4SAicSZHQsYuxi5OIQEljJK
        NH3exAyREJOYtG87O4QtLPHnWhcbRNEnRom+Kf1ACQ4ONgE9iR2rCkHiIgJzGCV+dm0Dm8Qs
        8JtZ4uDdfrBuYQEPiX2/LjCB2CwCqhJt03oYQWxeAXuJ92fPsEBskJdYveEAM8hQTgEHiZfH
        c0HCQkAl+19sZ5zAyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIRuO/Zzyw7GrnfB
        hxgFOBiVeHhvbDaJFWJNLCuuzD3EKMHBrCTCm2dgGivEm5JYWZValB9fVJqTWnyI0RToponM
        UqLJ+cDkkVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgfEca/gv
        nefBn7d0ac2Irt4ZvUn/qeGPHdfTdzGELxCweu3++ilD0fm5UbKTZy+0vhzsszhP8bzY1Y35
        UtyN6UXnbI43H7m3Y5mXtnR0zNlPP+O+S/h1+2xbf2z+I+2nst9sT/56/iAiozW+o+HQHnFz
        0Wtthj95eXqjdv7lbHvBl/rkoPNFu2wlluKMREMt5qLiRACi9x7s5gIAAA==
X-CMS-MailID: 20190722094732eucas1p1bd2c7e20744637f9f48f40be71db0168
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094732eucas1p1bd2c7e20744637f9f48f40be71db0168
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094732eucas1p1bd2c7e20744637f9f48f40be71db0168
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094732eucas1p1bd2c7e20744637f9f48f40be71db0168@eucas1p1.samsung.com>
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

