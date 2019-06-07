Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDED938D24
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFGOfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:35:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50260 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfFGOfi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143537euoutp010bd1dbd790606ebdda5a316743c48903~l8UfwjTRS0114101141euoutp01_
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143537euoutp010bd1dbd790606ebdda5a316743c48903~l8UfwjTRS0114101141euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918137;
        bh=kHJVCTeohYCMusBRC0aBAn9CjjIj5zED4ztI6qCEjMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSigioiNLnzRC889JAoNOlCC+sRUL0MMfO8pgpHIvyhK0SMHTwSAgbr5yCdkUaIce
         ghbU4qBXV13RiqEkx3mzPlYgVY0Qvf4PdF9JAF9x+6tKQsT5fLNcwyWu7njO4XuqsE
         CULSq0Y2Ox8g3+PtsjTg4OTf84zITTmaT0QTYgYo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143536eucas1p1d73425f498516dcdf546e177f75a68f0~l8Uey4UqO1839218392eucas1p1V;
        Fri,  7 Jun 2019 14:35:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.B3.04298.7367AFC5; Fri,  7
        Jun 2019 15:35:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143535eucas1p2e1c3843aca8dd39a615f4ce26e845ed8~l8Ud8Kx402161921619eucas1p2b;
        Fri,  7 Jun 2019 14:35:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143535eusmtrp160ca8098acbcb199efb3eef28d26e38d~l8UdsiPjT1284512845eusmtrp1h;
        Fri,  7 Jun 2019 14:35:35 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-96-5cfa7637fec3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.C0.04140.6367AFC5; Fri,  7
        Jun 2019 15:35:34 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143534eusmtip17944938c89a69ec3340459288cd5ff38~l8Uc0OnyP2464524645eusmtip1Z;
        Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
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
Subject: [PATCH v9 12/13] ARM: dts: exynos: add DMC device for exynos5422
Date:   Fri,  7 Jun 2019 16:35:06 +0200
Message-Id: <20190607143507.30286-13-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG/XaurhbHJflRUrAKKtBpKH5glIbF6SIV9UeUYqsdnOVW7ejK
        lFgXK+fMlViWrTTpwiqca5qNyrzQQjNdmYqX0gZdTF1qimVIzqP03+99nud934+Xj8akn4iF
        dJImhdNqFMkyUoxXvPrdFBSh+xMXYvOEobKCUgK1/fpKoFt1bwn0YMgN0JmSUhLl1ZtF6E22
        GuW6f2CoqclKocbT/RTq0AeiIeNHAr133CDRSE4dQAVNL0ToUV03hVz1G1Dnqfskqu0/T6DJ
        1jIcVbVsRp0T89DY688gKoAdG72Ms572TIot1Ltw9un1boq1WbJItsr8kGJzzgySbPXgMxF7
        0W4B7OOGdHbEtnj7nD3iNUouOUnHaeVr94lVxvwWcKQy5Pjtd1dwPWhcZgC+NGTCoPvvS9IA
        xLSUuQ/gtdI+XCh+AdjjtGJCMQJgrqFPNNviOPeFEox7ABZ1DBNeY7ol/06aAdA0yQTDSstR
        r+zPFABY+G2nN48xTzA40NkFvMZ8ZhMcLzNiXsaZ5fCuo2t6gYSJgtW1jZiwbAl8YH05zb5T
        emFFJSnoWTQsL5YLHAMv9mYBgefDPqedEjgQNuQZcYF5qM8pnslkQHeueSYTCWudLsL7ZoxZ
        CUsdci9CJhoai1QCzoPtA37eMDaFlyuuYoIsgRfOSYUZK6Dd2DxznAXw3sMrM7NZaJ7wUMJt
        8gB87txlAkuu/19VBIAFBHCpvDqR40M13LFgXqHmUzWJwQcOq21g6ts1TDqHK8Hou/01gKGB
        bK6EpX7HSQmFjk9T1wBIYzJ/ia55PE4qUSrSTnDawwna1GSOrwGLaFwWIEn36dkrZRIVKdwh
        jjvCaWddEe27UA/WR4RfivneOlQfuDHEJy8j6IfFNWLPHl+2+mxffP2d9PifX9iqHSrPbr/y
        cM3f2IRvJVvIquoxd8zoDbnZbahwtOZvTlJGGtXBgTbTVsrSYW0fzlwH428aWr5z3Mm9sUEN
        9rY/GQdDg0zxPr0fVOJon4kYk5/HunhptLLDtC1WhvMqRegqTMsr/gEfdiX7cgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7pmZb9iDM5/tLbYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y+iZeoWxYIdBxaJL01gaGM+qdDFyckgImEjsanvG3sXIxSEksJRR4sG1zUwQCTGJSfu2s0PY
        whJ/rnWxQRR9YpR493U/UIKDg01AT2LHqkKQuIjAHEaJn13bGEEcZoGzzBK7V7wBmyQs4Cnx
        Y2MPM4jNIqAqsWzXHbA4r4CDxMHDZ5khNshLrN5wAMzmBIrP3raDDWSBkIC9xKrnDhMY+RYw
        MqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMJtx35u2cHY9S74EKMAB6MSD+8Mpp8xQqyJ
        ZcWVuYcYJTiYlUR4yy78iBHiTUmsrEotyo8vKs1JLT7EaAp000RmKdHkfGCCyCuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwOgV8CN8Qe+fyJp+lq/b5jtEZRaX
        qrcfk1/kOs/ik52cyfK52zlOG7lUhW07ICkyZ5GZV4BO5T3u3Uc+bpff1Wxfm3D1vrLsJbnF
        GvYNVYJyhxN99uouat7KUhUk/9Tyf7Qcu33nmr1Tckt3TouYfWv/yqNPeetS5hg9fsVQU9dh
        c5tliaD9eyWW4oxEQy3mouJEAE7u6r3YAgAA
X-CMS-MailID: 20190607143535eucas1p2e1c3843aca8dd39a615f4ce26e845ed8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143535eucas1p2e1c3843aca8dd39a615f4ce26e845ed8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143535eucas1p2e1c3843aca8dd39a615f4ce26e845ed8
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143535eucas1p2e1c3843aca8dd39a615f4ce26e845ed8@eucas1p2.samsung.com>
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

