Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1014F9A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEFPMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49986 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfEFPMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151221euoutp0265b2e29a7fe7b4779e279f7cf6bd0a46~cILb0Dl7c3008330083euoutp02C
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151221euoutp0265b2e29a7fe7b4779e279f7cf6bd0a46~cILb0Dl7c3008330083euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155541;
        bh=AGIyJXj9oHA+UB3UKk/PkCJb1DafTfIIIhIZ0/3jDEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGOH+oFtq85V4iBcBMJsT+V2OTsfRLOg+nxIJxCu+YluuEDFKz3ZIIYMyzFlB8JHQ
         +5Vt/F6uajiw1vCBGP9v9sAltX0aLh4ZBYVBmghPVOoLwID2+Jz0koEPEOYPuzMDDy
         XOyRhukF3Qnu938xPm+iAU/TE9GdoTAcJq2VIEwI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151220eucas1p2e6e846d16eef702c61b65c4f4388d4ed~cILbRH-g10631606316eucas1p2a;
        Mon,  6 May 2019 15:12:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.A3.04377.4DE40DC5; Mon,  6
        May 2019 16:12:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e~cILakfV6V1435614356eucas1p2G;
        Mon,  6 May 2019 15:12:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151219eusmtrp2a4b018adb61f9eda2f86d9333f1a7d95~cILaWe1g90466604666eusmtrp2C;
        Mon,  6 May 2019 15:12:19 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-8e-5cd04ed4b2d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.4B.04140.3DE40DC5; Mon,  6
        May 2019 16:12:19 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151218eusmtip1cf33cb301b625102f58e232a9b8f3396~cILZmE7Ka0071300713eusmtip1R;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
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
Subject: [PATCH v7 12/13] ARM: dts: exynos: add DMC device for exynos5422
Date:   Mon,  6 May 2019 17:12:00 +0200
Message-Id: <1557155521-30949-13-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ12ZtpQMhYiN0BQm2hwAzE+3EQkQHwYMTEYfRAl0QoTFlvA
        Djs8VAgIFCyCYZXFYAIWCVvDFgOBIiAIFAQBAYMQxCCgLCKLqJQp8e3k/79z/nNuLolJ9AJr
        MiAolFEGyeRSXMSv69jsPzN01eB9Nu+tNarOqRSgkbU5ASpq7xOg8uUZgDK7C3jonVqBNDPf
        MNTfX0Wg3rgFAn1U2aL3Tc9wtJrWDlBOfzMPVbRPEmj8YRmO9AuPBKhlyAONb5uj9a5p4GpB
        r//M4NP5qgE+3Zg3SdA12mScTotfwunWpdc8+rFOC+janhh6tcbOU3hL5OzLyAPCGaWjy12R
        /2xRWEiOW+TOiBZTgRmnFCAkIXUeJhTreClAREqoMgDX6rsFRkNCrQGYkBrIGasAJtYuY/sd
        c7p6goNKAWwddOKg3YaB7BI8BZAkTjnABu0DI2NJxcCJkRbMyGDUAg/2bm3wjYYFdRlu6JP2
        0vjUMTg6Nrw3VExdgS9zn+JcmB0c60veCxbu6jtJbcA4CFKfCNj9QUNw0CU4q241bWcB5zt1
        Jt0W/m0s4nE1C1VpzwFXx8IZTYGJuQD1nQMC49IYdQJWNjlyshus6BveuwVS5nB08aBRxnbL
        jLpsjJPFMClRwtH2UJdqMAUdgqWvskzDaRhXXgy45ykE8HNWIZEODuf9DysGQAusmDBW4cew
        54KYCAdWpmDDgvwcfIIVNWD3a/X86VxrAE2/77UBigRSM3G6u8FbIpCFs1GKNgBJTGopln3p
        85aIfWVR0Ywy+I4yTM6wbcCG5EutxDEHpm5LKD9ZKHOfYUIY5b7LI4XWKpC7STjfFAXazHvg
        9ga18qKrZ/Tpkl6NOvL4UsdXny15R3WovPWoOqVxNi3WtSsqtOuU+5FYr6k4NmKz3Wb8icRq
        siSjseuFh+XWtpdhSli5/GYlv2TcrNl9JbPpR0dV943BX5NyzfS1ic6JKaLQJul64OK8iz47
        zje+Tvh9NaNBymf9ZU4nMSUr+wd7tpvMVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7qX/S7EGOzv0rbYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBaH37SzWuy/4mVx+zefxbcTjxgdhD2+fZ3E4jG74SKLx85Zd9k9Nq3q
        ZPPobX7H5nHw3R4mj74tqxg9Np+u9vi8SS6AM0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+n80oIZjhV/r69ibmB8bNjFyMkhIWAi8XzLdvYu
        Ri4OIYGljBKTZzQwQSTEJCbtA0mA2MISf651sUEUfWKUuNe1hLGLkYODTUBPYseqQpAaEYF6
        if43l8BqmAUamCXWbL/KCpIQFvCU+HG4A8xmEVCVuHHzKthQXgFviZUzp7BBLJCTuHmukxnE
        5gSK/+04xAhiCwl4Sez7+JtlAiPfAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRtO3Y
        zy07GLveBR9iFOBgVOLhfWB7IUaINbGsuDL3EKMEB7OSCG/is3MxQrwpiZVVqUX58UWlOanF
        hxhNgY6ayCwlmpwPjPK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2Mh/u2BsrcPbZ0c/ezxIBvr33eKMW5bBOavGOBoKpE3nKHOzpbj5w9pGFUsE+zkCeiSO+3
        yeTzk+LEA5TmxuetnvynQvxoYdvXpdJ7Amu+Ve0Ij7Dy3XfqXgu/TtMNubsZ66c8Wtl9RPdm
        8IWaxKib+mKHPuorMwo6llyeW1ZyuUffx2ziuT3RSizFGYmGWsxFxYkABZtspboCAAA=
X-CMS-MailID: 20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151219eucas1p2b5c3368873696f51e7d0d3a3e6d6bf1e@eucas1p2.samsung.com>
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
 arch/arm/boot/dts/exynos5420.dtsi             | 121 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 122 ++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..1b66601 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/exynos5420.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pmu/exynos_ppmu.h>
 
 / {
 	compatible = "samsung,exynos5420", "samsung,exynos5";
@@ -235,6 +236,38 @@
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
+			samsung,syscon-chipid = <&chipid>;
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +304,94 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event0_dmc0_0: ppmu-event0-dmc0_0 {
+					event-name = "ppmu-event0-dmc0_0";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc0_0: ppmu-event1-dmc0_0 {
+					event-name = "ppmu-event1-dmc0_0";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
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
+				ppmu_event0_dmc0_1: ppmu-event0-dmc0_1 {
+					event-name = "ppmu-event0-dmc0_1";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc0_1: ppmu-event1-dmc0_1 {
+					event-name = "ppmu-event1-dmc0_1";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
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
+				ppmu_event0_dmc1_0: ppmu-event0-dmc1_0 {
+					event-name = "ppmu-event0-dmc1_0";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc1_0: ppmu-event1-dmc1_0 {
+					event-name = "ppmu-event1-dmc1_0";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
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
+				ppmu_event0_dmc1_1: ppmu-event0-dmc1_1 {
+					event-name = "ppmu-event0-dmc1_1";
+					event-data-type = <PPMU_RO_DATA_CNT>;
+				};
+				ppmu_event1_dmc1_1: ppmu-event1-dmc1_1 {
+					event-name = "ppmu-event1-dmc1_1";
+					event-data-type = <PPMU_WO_DATA_CNT>;
+				};
+				ppmu_event3_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+					event-data-type = <(PPMU_RO_DATA_CNT |
+						PPMU_WO_DATA_CNT)>;
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de1..76abf03 100644
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
+		compatible	= "Samsung,K3QF2F20DB", "jedec,lpddr3";
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
+		timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
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
@@ -132,6 +223,21 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_event0_dmc0_0>, <&ppmu_event1_dmc0_0>,
+			<&ppmu_event3_dmc0_0>,
+			<&ppmu_event0_dmc0_1>,<&ppmu_event1_dmc0_1>,
+			<&ppmu_event3_dmc0_1>,
+			<&ppmu_event0_dmc1_0>, <&ppmu_event1_dmc1_0>,
+			<&ppmu_event3_dmc1_0>,
+			<&ppmu_event0_dmc1_1>,<&ppmu_event1_dmc1_1>,
+			<&ppmu_event3_dmc1_1>;
+	device-handle = <&samsung_K3QF2F20DB>;
+	operating-points-v2 = <&dmc_opp_table>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -540,6 +646,22 @@
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
2.7.4

