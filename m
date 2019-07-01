Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953245BC7D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfGANMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58000 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGANMA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:12:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131158euoutp015cd827ca9d3a61dc513c156bdfb6d504~tSqUlYX-72478224782euoutp01Q
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131158euoutp015cd827ca9d3a61dc513c156bdfb6d504~tSqUlYX-72478224782euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986718;
        bh=rYJkkCMUDQzLMRwM3+Cmq3HZXco9QSEYJGZXrRgmzNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/IfQwKVGLvJsQuTAnmBMCVeRBhPCN9asLC8mKXxtttq/tOEmXlP4G5akb6qMyb3L
         shFKcdGLJ7zq2fEykx4EvV3n8KuPVuMG5cYqf/cQs4si683epsDmfQJGtY02S3bBwJ
         Ga1dunMoBfkB3lGIb5PiTCzFIhaZeBsUwwSysaSY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701131157eucas1p1746cb551ba17790a0f3af5918b765b1d~tSqTfk8NI1003910039eucas1p1B;
        Mon,  1 Jul 2019 13:11:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 45.2B.04298.D960A1D5; Mon,  1
        Jul 2019 14:11:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701131156eucas1p22e9d3919bd70875cabd410c925c3a52c~tSqSwx-eW1085610856eucas1p2T;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131156eusmtrp23a4d0ad258d09d129b899d981366d7c5~tSqSwGW5H0788807888eusmtrp2Q;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-a9-5d1a069d7fb1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.02.04146.C960A1D5; Mon,  1
        Jul 2019 14:11:56 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131155eusmtip118a0dca13c6b1fdac664ebab4baa4f6a~tSqR0ZByw2623726237eusmtip1f;
        Mon,  1 Jul 2019 13:11:55 +0000 (GMT)
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
Subject: [PATCH v11 8/9] ARM: dts: exynos: add DMC device for exynos5422
Date:   Mon,  1 Jul 2019 15:11:37 +0200
Message-Id: <20190701131138.22666-9-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTYRD163a322rNWhCmeGAajUoCheiPL4EIRk02/iJqjEeIVtkgkRbs
        CqLyo0rwxgM8agFBDdIUSIWiCLFyHwJaQSOkHB4YFYsHQolHAtJu1X9v3rx5bzIZmlC8IYPo
        RN1BTq/TJKkomfh+68+noQVUUFz4B+ciXGG0krh34gOJC5ufkrh0bBjhzNtWCud2FIhw11kt
        vjDsIrDDcVeCnxwflWCnYSEeOzdE4ue1+RQez25G2Oh4JMLlzYMS3N2xAfcfM1O4afQkiade
        Vohx3YuNuP/3XDzZ/hbFBLKT7hwx+7UvS8LmGbrFbI1pUMJWWk5TbF1BmYTNzvxCsQ1fHorY
        81UWxNo6j7LjlYtjZ++QRcVzSYlpnF69Zrdsnz1TmfJOnd7iqCcMKHvpGSSlgVkNV+x20Rkk
        oxWMGUHVSC8pFBMIrOVGSijGEYzXFBN/R4ZfVftUJQgKrUOifyOuruKZgqYpJgweWA54BvwZ
        I4K8j5s9GoKpJuBz/wDyNPwYFq5b8r2uYmYZNExPe7GciQbXHatISAuG0rv1Xl7KxECPe9C7
        EjCnaXDebPaGAbMeit2+7fzgU1uVRMALYbqm0OfDgyH7JhJwBgxfKPBpIqGprZv02BDMSrDW
        qgV6LWRdy0WC+1zo+zzPQxMzMOf+NUKg5XDqhEJQr4Cqc898QQFQUnbVZ85CxZuXvuvkIrht
        Oi65iIJN/8OKELKgQC6V1yZwfISOOxTGa7R8qi4hbG+ythLNPF7nVNv3B8jds6cRMTRSzZEb
        BiBOQWrS+MPaRgQ0ofKX15mVcQp5vObwEU6fvEufmsTxjWgBLVYFyo/Oer1TwSRoDnL7OS6F
        0//timhp0MwXSO2LK7Q2AyQt+TEGRoezZY8yqlA6tNSkIZV3lseczY31d66LzVsecNVtVubn
        tD8skkcFv92wVnwguu995/bMX/D1Ul/1DbrTZLqluDzR5Jr+tmWbq0M9v9VmVwfZzt+yhQdv
        yUCV5hHZJt2CkLR+51YqMl2bHrrq8b2wtliVmN+niQgh9LzmDy6lFw90AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7pz2KRiDV4fNrHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9jbLFnwRL/i6PkDzA2MvSpdjJwcEgImEo/vb2ftYuTiEBJYyihx7cNLJoiEmMSkfdvZIWxh
        iT/Xutggij4xSqzr7AIq4uBgE9CT2LGqECQuIjCHUeJn1zZGEIdZ4CyzxO4Vb8AmCQt4SMxc
        NYcZxGYRUJU4+P8/mM0rYC/xetl6qG3yEqs3HACLcwo4SFz6epcNxBYCqlm3+AbjBEa+BYwM
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjcNuxn5t3MF7aGHyIUYCDUYmHV+OWRKwQa2JZ
        cWXuIUYJDmYlEd79KyRjhXhTEiurUovy44tKc1KLDzGaAh01kVlKNDkfmCDySuINTQ3NLSwN
        zY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwzsmc5l7Z8UP66aeS0h37pZ1Wv7ht
        8tA8LoSjtv9Oinqlg3Ht7VmBz1zOnbj1cLeuwdbbG7jZFOw2bvzxU+h9xhfmSdOdQ86Y97T0
        tHusyW7PmtPN6HchR/jmFsebz59kcvT15QU0ZLIw7BOLYkqdECPJXX2isEnv5UKPk8oyDHGL
        reRiHz5VYinOSDTUYi4qTgQA6nIDVNgCAAA=
X-CMS-MailID: 20190701131156eucas1p22e9d3919bd70875cabd410c925c3a52c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131156eucas1p22e9d3919bd70875cabd410c925c3a52c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131156eucas1p22e9d3919bd70875cabd410c925c3a52c
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131156eucas1p22e9d3919bd70875cabd410c925c3a52c@eucas1p2.samsung.com>
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
index d153617ff1a3..9dbfe400cdd2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,29 @@
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
@@ -271,6 +294,54 @@
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

