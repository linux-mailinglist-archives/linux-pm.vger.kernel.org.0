Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C145967
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfFNJxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35859 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfFNJxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095333euoutp0135e5d4d209d6eed2f677b2e071035a82~oB-OeDuIU0765507655euoutp01i
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095333euoutp0135e5d4d209d6eed2f677b2e071035a82~oB-OeDuIU0765507655euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506013;
        bh=kHJVCTeohYCMusBRC0aBAn9CjjIj5zED4ztI6qCEjMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZtxzb7vufr4ue/hz3gdh0lgxKGtvygrbnSubmq210WVB9gcQ/yyJUDUqhJpYXoM+
         CbEI45vhgDZLJ+dBZUTx10fJpcnUNgOdQCwUq6lo/JTXIrfdswzV6l0hw2MakuEjun
         vUepvGkVRdsSomihmxl+jybO6gDLI/PNNqwYy99c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095332eucas1p19ac680f2ae4a3719dea4f6edab5d2189~oB-NbdD_c1134111341eucas1p1a;
        Fri, 14 Jun 2019 09:53:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7C.F1.04325.C9E630D5; Fri, 14
        Jun 2019 10:53:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614095331eucas1p138707301cac47902f0d0d9a41bd4a8a4~oB-MiPmdw1137711377eucas1p1K;
        Fri, 14 Jun 2019 09:53:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095331eusmtrp223d3933ed832064d2beaa54a73d73b5b~oB-MSlLkX2148621486eusmtrp2K;
        Fri, 14 Jun 2019 09:53:31 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-2f-5d036e9c8613
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.EA.04140.B9E630D5; Fri, 14
        Jun 2019 10:53:31 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095330eusmtip2c31677556257e67fb73e08c82588f15e~oB-LbFkI42320823208eusmtip2T;
        Fri, 14 Jun 2019 09:53:30 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v10 12/13] ARM: dts: exynos: add DMC device for exynos5422
Date:   Fri, 14 Jun 2019 11:53:08 +0200
Message-Id: <20190614095309.24100-13-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHPbuP3VmT23ydnsLKKCE1ijjNioKSqxREEZIyaulFJTdrN+1h
        xSrLnK5CSUVdWhKOaanTLe2l+cjQdJpWllmS9PIV5qMnK6931X/f8/19fuf7+x0OhcneEPOo
        WM0hVqtRxclJV9z28Lt9Rb4GUwa2VHiiipwyAj2f+ECggsZ2ApWMDQB0pqiMRJktRhF6nKZG
        FweGMGS3l4tR2+lhMXqpW4DG0l8TqOt2PonGDY0A5djvi9CNxj4x6mzZgnpPmUjUMJxCIMez
        ChzVdoei3p9uaOrRW7DRm5mazMCZzz1nxUyerhNnanL7xIzFnEoytcZSMWM4M0oyD0bvipgL
        VWbAVLYmMeOWRdtnhbuui2LjYhNZbcCGva4x6Ze7wYHqwCPXnmThOtC2RA8kFKRXw6KzRSI9
        cKVktAnAp6V1YuEwAWD7o3ckT8nocQDvWBP1gJrpcJiUAlMMYPEnPfmvwZaTRvIQSfvDavNB
        vteDzgEw7+NOnsHoWxgc6X0F+II7HQq//RwkeB6nfaFNv4a3pfRG+EHXIRam84El5XUYryXT
        flPB8EwWpA0UrC6zOaHNMM2RTAraHQ42Vzn9BfB3TYFI0BzUGa4CQR+HAxeNTiYINjR3zsyA
        0cth2e0Awd4E3w99AcK+brBnZA5vY9Myw5aNCbYUnj8nE+hlsCq9wxnkBYtLs5yXMzDlXq1I
        eMFMAA2ZkkvAJ/d/ViEAZuDNJnDqaJZbpWEP+3MqNZegifaPjFdbwPS3a3U0T1aD+7/21QOa
        AvLZ0jqFSCkjVIncUXU9gBQm95BeCcKUMmmU6ugxVhu/R5sQx3L1YD6Fy72lSS79ETI6WnWI
        3c+yB1jt36qIkszTgY4khcfaQhVsStpuMzZk4X6bO43Z+38kv5NeCAqJqEEPgirbpjLaF3p5
        rsfDPnmfv35ya7hiYuloqSK4cWDDCZN1d3/bM0jUWhfnf00dDbhhCk5M3SHxNc8NWb9lV0NX
        eLlX34gtcuSmNVQ+ceXJ3mMvtvU4wk4HWwn/nnwXS1OKHOdiVCv9MC2n+gM2Ks9/cgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7qz85hjDRZMkrLYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y+iZeoWxYIdBxaJL01gaGM+qdDFycEgImEj8WxHbxcjFISSwlFHi7vtNzF2MnEBxMYlJ+7az
        Q9jCEn+udbFBFH1ilFjycx4bSDObgJ7EjlWFIHERgTmMEj+7tjGCOMwCZ5kldq94wwTSLSzg
        JfHj9ytWkAYWAVWJbV1mIGFeAQeJ5w0XoBbIS6zecABsMSdQ/Oj8N2DzhQTsJb7P4J/AyLeA
        kWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYARuO/Zzyw7GrnfBhxgFOBiVeHgPWDHFCrEm
        lhVX5h5ilOBgVhLhnWfNHCvEm5JYWZValB9fVJqTWnyI0RTopInMUqLJ+cDkkFcSb2hqaG5h
        aWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXHPCoEzUwRy/x/9JaFXUT5B8OgE
        Jq8D88968u3/9l6vlLfswt7nxYtZ1p2M2aMux2OyRnTit3Xrz4pmuhlNjHisv0CoynHltJNL
        Jq8/sz1xk32VQsvquN8HpS5KHmZc3Dnto+7S7BVNE6b/aNLlUVgUtjP3YyHX6oo6br3p1XY5
        L4p2S3JvTApXYinOSDTUYi4qTgQAInPcONYCAAA=
X-CMS-MailID: 20190614095331eucas1p138707301cac47902f0d0d9a41bd4a8a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095331eucas1p138707301cac47902f0d0d9a41bd4a8a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095331eucas1p138707301cac47902f0d0d9a41bd4a8a4
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095331eucas1p138707301cac47902f0d0d9a41bd4a8a4@eucas1p1.samsung.com>
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
 arch/arm/boot/dts/exynos5420.dtsi             |  73 +++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 116 ++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d153617ff1a3..79e74ae80938 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,31 @@
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
+				 <&clock CLK_MOUT_MCLK_CDREX>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mx_mspll_ccore_phy",
+				      "mout_mclk_cdrex";
+			samsung,syscon-clk = <&clock>;
+			status = "disabled";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +296,54 @@
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

