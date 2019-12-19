Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99C0125FE2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 11:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLSKvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 05:51:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40673 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLSKvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 05:51:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219105137euoutp023afe5daa8290e16adecca36ae6e06856~hwDlh5a7G1355413554euoutp023
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 10:51:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219105137euoutp023afe5daa8290e16adecca36ae6e06856~hwDlh5a7G1355413554euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576752697;
        bh=AAw0b+1qzRYTW1wIvFK18I98e+PSs+/CSrQFupSp29o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZxNTyPRHOvALXB+a53IKepEChyMHC8iU54tJVY0vEQ0RDody+x+QP1dRJnyeYc0q
         q3gQW+cOJfBghWc4A/X5K4JdpoprStrA1XPjg9da3bIc6tDmkC6lIrVaCURP2Rgrra
         lY8NZK5/2pqiNzX0wRRTE2LaaKeUUnr7u8wbCVZ0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191219105137eucas1p1699357914b3b982556eed2166120d0b9~hwDlTnbcD1663416634eucas1p1i;
        Thu, 19 Dec 2019 10:51:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.DB.60698.8365BFD5; Thu, 19
        Dec 2019 10:51:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce~hwDkvEl8P1660016600eucas1p1f;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219105136eusmtrp194cfa658e92bb921d1ce0c206a23b913~hwDkubS-J2881728817eusmtrp1E;
        Thu, 19 Dec 2019 10:51:36 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e6-5dfb5638dd57
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.6D.07950.8365BFD5; Thu, 19
        Dec 2019 10:51:36 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219105135eusmtip1db09dca786dbd3b8084de16a0dba3635~hwDkNRhvN0870108701eusmtip1W;
        Thu, 19 Dec 2019 10:51:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/2] ARM: dts: exynos: Move bus related OPPs to the
 boards DTS
Date:   Thu, 19 Dec 2019 11:51:29 +0100
Message-Id: <20191219105130.29394-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219105130.29394-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87oWYb9jDRqfWFlsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kdODw2repk8+jbsorR4/MmuQDmKC6b
        lNSczLLUIn27BK6MzU+vMRZsqq+Y8Ki+gfFzbBcjJ4eEgIlE9+57zF2MXBxCAisYJeYcnsAK
        4XxhlPj/upEJwvnMKHH9wXcmmJY77/vZIRLLGSX+bd/MBtcycdl5dpAqNgFDia63XWwgtohA
        vMSj/rssIEXMAo8ZJY7/OwU2SlggWOL5/HWsIDaLgKrEwaaXzCA2r4CtxNFNq1kg1slLrN5w
        ACzOKWAnceHzWrCbJASes0l8fdTBCFHkIvH8dzsbhC0s8er4FnYIW0bi9OQeFoiGZkaJh+fW
        skM4PYwSl5tmQHVbSxw+fhHoDA6g+zQl1u/SBzElBBwl/i0RgzD5JG68FQQpZgYyJ22bzgwR
        5pXoaBOCmKEmMev4OritBy9cYoawPSQW7PkJDdOJjBJPXh5hmcAoPwth1wJGxlWM4qmlxbnp
        qcXGeanlesWJucWleel6yfm5mxiByeH0v+NfdzDu+5N0iFGAg1GJh/eH669YIdbEsuLK3EOM
        EhzMSiK8tzt+xgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TB
        KdXAOIXvqM0N7Ql/RadttVv6Xc9E7gzv93lxi41WxYXZ5SQuSgnv5FlkFKvWetQ6yp+3c/3d
        SJ5DDwyuWdyr95C9Lx3axSKTaLKW+7je5A6zOqX9Ei9OnZ5rOGXa082SS9r27b9kNql+urin
        zkfOI5ufBX4RfRNxZFfztzMXpRRmfU9aIXFTlv/aTyWW4oxEQy3mouJEAPzGVT4KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t/xu7oWYb9jDRpOCFpsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF5V1z2Cw+9x5htJhxfh+Txdojd9kdODw2repk8+jbsorR4/MmuQDmKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MzU+vMRZs
        qq+Y8Ki+gfFzbBcjJ4eEgInEnff97CC2kMBSRolXK1wh4jISJ6c1sELYwhJ/rnWxdTFyAdV8
        YpS40XSRCSTBJmAo0fUWJMHJISKQKDH742ywImaBp4wSq9ZMAesWFgiUmPalmwXEZhFQlTjY
        9JIZxOYVsJU4umk1C8QGeYnVGw6AxTkF7CQufF7LBHGRrcTuucsYJzDyLWBkWMUoklpanJue
        W2ykV5yYW1yal66XnJ+7iREYqNuO/dyyg7HrXfAhRgEORiUe3gCPX7FCrIllxZW5hxglOJiV
        RHhvd/yMFeJNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8YBTllcQbmhqaW1gamhubG5tZKInz
        dggcjBESSE8sSc1OTS1ILYLpY+LglGpgTE8/6MugKfTGINbEY3H7Fw6nwqay4peiM+8zMj9c
        E7jxpQnffM29ZfPn6UnaexiXSlwV0izO5pp9e7VsisTaefqL1/3kahbWjeVMjrr6Jdtd335n
        uPC9zW8OZLQfijJ8ol5YkM/CkXZFKOlMdd+8Hh3jlXInojJqa/7+YZPbeT+nc5LrwTYlluKM
        REMt5qLiRABh1/wuagIAAA==
X-CMS-MailID: 20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce
References: <20191219105130.29394-1-m.szyprowski@samsung.com>
        <CGME20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the only Exynos5422-based boards that support bus frequency
scaling are Hardkernel's Odroid XU3/XU4/HC1. Move the bus related OPPs to
the boards DTS, because those OPPs heavily depend on the clock topology
and top PLL rates, which are being configured by the board's bootloader.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 259 -----------------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 261 +++++++++++++++++-
 2 files changed, 260 insertions(+), 260 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f95567bc10e3..f66a2d1b3428 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1092,7 +1092,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_wcore_opp_table>;
 			status = "disabled";
 		};
 
@@ -1100,7 +1099,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK100_NOC>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_noc_opp_table>;
 			status = "disabled";
 		};
 
@@ -1108,7 +1106,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys_apb_opp_table>;
 			status = "disabled";
 		};
 
@@ -1116,7 +1113,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys_apb_opp_table>;
 			status = "disabled";
 		};
 
@@ -1124,7 +1120,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_fsys2_opp_table>;
 			status = "disabled";
 		};
 
@@ -1132,7 +1127,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK333>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_mfc_opp_table>;
 			status = "disabled";
 		};
 
@@ -1140,7 +1134,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK266>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_gen_opp_table>;
 			status = "disabled";
 		};
 
@@ -1148,7 +1141,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK66>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_peri_opp_table>;
 			status = "disabled";
 		};
 
@@ -1156,7 +1148,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK333_G2D>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_g2d_opp_table>;
 			status = "disabled";
 		};
 
@@ -1164,7 +1155,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK266_G2D>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_g2d_acp_opp_table>;
 			status = "disabled";
 		};
 
@@ -1172,7 +1162,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_jpeg_opp_table>;
 			status = "disabled";
 		};
 
@@ -1180,7 +1169,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK166>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_jpeg_apb_opp_table>;
 			status = "disabled";
 		};
 
@@ -1188,7 +1176,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_disp1_fimd_opp_table>;
 			status = "disabled";
 		};
 
@@ -1196,7 +1183,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_disp1_opp_table>;
 			status = "disabled";
 		};
 
@@ -1204,7 +1190,6 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_gscl_opp_table>;
 			status = "disabled";
 		};
 
@@ -1212,252 +1197,8 @@
 			compatible = "samsung,exynos-bus";
 			clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
 			clock-names = "bus";
-			operating-points-v2 = <&bus_mscl_opp_table>;
 			status = "disabled";
 		};
-
-		bus_wcore_opp_table: opp_table2 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
-				opp-microvolt = <925000 925000 1400000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <111000000>;
-				opp-microvolt = <950000 950000 1400000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <222000000>;
-				opp-microvolt = <950000 950000 1400000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <333000000>;
-				opp-microvolt = <950000 950000 1400000>;
-			};
-			opp04 {
-				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <987500 987500 1400000>;
-			};
-		};
-
-		bus_noc_opp_table: opp_table3 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <67000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <75000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <86000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-		};
-
-		bus_fsys_apb_opp_table: opp_table4 {
-			compatible = "operating-points-v2";
-			opp-shared;
-
-			opp00 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-		};
-
-		bus_fsys2_opp_table: opp_table5 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <75000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <100000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <150000000>;
-			};
-		};
-
-		bus_mfc_opp_table: opp_table6 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <96000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <111000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <167000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <222000000>;
-			};
-			opp04 {
-				opp-hz = /bits/ 64 <333000000>;
-			};
-		};
-
-		bus_gen_opp_table: opp_table7 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <89000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <133000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <178000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <267000000>;
-			};
-		};
-
-		bus_peri_opp_table: opp_table8 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <67000000>;
-			};
-		};
-
-		bus_g2d_opp_table: opp_table9 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <167000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <222000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-			opp04 {
-				opp-hz = /bits/ 64 <333000000>;
-			};
-		};
-
-		bus_g2d_acp_opp_table: opp_table10 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <67000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <133000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <178000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <267000000>;
-			};
-		};
-
-		bus_jpeg_opp_table: opp_table11 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <75000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <150000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-		};
-
-		bus_jpeg_apb_opp_table: opp_table12 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <111000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <134000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <167000000>;
-			};
-		};
-
-		bus_disp1_fimd_opp_table: opp_table13 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <120000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-		};
-
-		bus_disp1_opp_table: opp_table14 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <120000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-		};
-
-		bus_gscl_opp_table: opp_table15 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <150000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <200000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-		};
-
-		bus_mscl_opp_table: opp_table16 {
-			compatible = "operating-points-v2";
-
-			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
-			};
-			opp01 {
-				opp-hz = /bits/ 64 <167000000>;
-			};
-			opp02 {
-				opp-hz = /bits/ 64 <222000000>;
-			};
-			opp03 {
-				opp-hz = /bits/ 64 <333000000>;
-			};
-			opp04 {
-				opp-hz = /bits/ 64 <400000000>;
-			};
-		};
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 80b0acfec547..5fb771680e98 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -35,7 +35,250 @@
 		};
 	};
 
-	dmc_opp_table: opp_table2 {
+	bus_wcore_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+			opp-microvolt = <925000 925000 1400000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+			opp-microvolt = <950000 950000 1400000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+			opp-microvolt = <950000 950000 1400000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <333000000>;
+			opp-microvolt = <950000 950000 1400000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <987500 987500 1400000>;
+		};
+	};
+
+	bus_noc_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <67000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <86000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+	bus_fsys_apb_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_fsys2_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+	};
+
+	bus_mfc_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <96000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+	};
+
+	bus_gen_opp_table: opp_table7 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <89000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <178000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table8 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <67000000>;
+		};
+	};
+
+	bus_g2d_opp_table: opp_table9 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+	};
+
+	bus_g2d_acp_opp_table: opp_table10 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <67000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <133000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <178000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+	};
+
+	bus_jpeg_opp_table: opp_table11 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <75000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_jpeg_apb_opp_table: opp_table12 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <111000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+	};
+
+	bus_disp1_fimd_opp_table: opp_table13 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <120000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_disp1_opp_table: opp_table14 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <120000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_gscl_opp_table: opp_table15 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <300000000>;
+		};
+	};
+
+	bus_mscl_opp_table: opp_table16 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <84000000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <167000000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+	};
+
+	dmc_opp_table: opp_table17 {
 		compatible = "operating-points-v2";
 
 		opp00 {
@@ -134,6 +377,7 @@
 };
 
 &bus_wcore {
+	operating-points-v2 = <&bus_wcore_opp_table>;
 	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
 			<&nocp_mem1_0>, <&nocp_mem1_1>;
 	vdd-supply = <&buck3_reg>;
@@ -142,76 +386,91 @@
 };
 
 &bus_noc {
+	operating-points-v2 = <&bus_noc_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys_apb {
+	operating-points-v2 = <&bus_fsys_apb_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys {
+	operating-points-v2 = <&bus_fsys_apb_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_fsys2 {
+	operating-points-v2 = <&bus_fsys2_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_mfc {
+	operating-points-v2 = <&bus_mfc_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_gen {
+	operating-points-v2 = <&bus_gen_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_peri {
+	operating-points-v2 = <&bus_peri_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_g2d {
+	operating-points-v2 = <&bus_g2d_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_g2d_acp {
+	operating-points-v2 = <&bus_g2d_acp_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_jpeg {
+	operating-points-v2 = <&bus_jpeg_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_jpeg_apb {
+	operating-points-v2 = <&bus_jpeg_apb_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_disp1_fimd {
+	operating-points-v2 = <&bus_disp1_fimd_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_disp1 {
+	operating-points-v2 = <&bus_disp1_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_gscl_scaler {
+	operating-points-v2 = <&bus_gscl_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
 
 &bus_mscl {
+	operating-points-v2 = <&bus_mscl_opp_table>;
 	devfreq = <&bus_wcore>;
 	status = "okay";
 };
-- 
2.17.1

