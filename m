Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419D2125CA8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLSI3t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 03:29:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48515 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLSI3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 03:29:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191219082939euoutp015cb64a4119443e7c46e97c17b73c3ec9~huHpFWhDC0149201492euoutp01c
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191219082939euoutp015cb64a4119443e7c46e97c17b73c3ec9~huHpFWhDC0149201492euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576744179;
        bh=nYnNYHjIeHpPJVAuMK4SQTeW2r0ZkViQKE2fsdcHZU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3RlzEvfxC1CknlI6mkSo0nd2jRvKTL48QGBkw6+mvQp9oKxvtnpQwx8ohSR5nZWQ
         /wtvpaUr3hQSPGDLg1hkwA3eZyfSJiD1+3+FBUkgINF2i5rP/4gIq2u2coLd4J7bgQ
         aYk58C9KE846tXksletFcIg3gWLW5w0q9CELY03s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191219082939eucas1p1f84a491256cc8802f6fc1bc996762a6d~huHo2lx8a1482914829eucas1p1p;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.EA.60679.3F43BFD5; Thu, 19
        Dec 2019 08:29:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927~huHohWWcA3116531165eucas1p2g;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219082939eusmtrp183b102c57d8ce50779fb8bc859a5230f~huHoguxEh0048200482eusmtrp1u;
        Thu, 19 Dec 2019 08:29:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-05-5dfb34f3a98c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.F6.08375.3F43BFD5; Thu, 19
        Dec 2019 08:29:39 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219082938eusmtip1ecfc4991f1fc4432d24b99d854dc3baa~huHoIToMW1672716727eusmtip1H;
        Thu, 19 Dec 2019 08:29:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] ARM: dts: exynos: Move bus related OPPs to the boards
 DTS
Date:   Thu, 19 Dec 2019 09:29:26 +0100
Message-Id: <20191219082927.11898-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219082927.11898-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djP87qfTX7HGnx/KWexccZ6VovrX56z
        Wiz4NIPV4vz5DewWl3fNYbP43HuE0WLG+X1MFmuP3GV34PDYtKqTzaNvyypGj8+b5AKYo7hs
        UlJzMstSi/TtErgyNu//wFhwrq7i2ZObLA2MM2O7GDk5JARMJE5PvMPexcjFISSwglHiVuNB
        NgjnC6PEtiltUJnPjBJHbz1jg2nZvvMYI0RiOaPE8s5zjHAt0971MIJUsQkYSnS97QLrEBGI
        l3jUf5cFpIhZ4DGjxPF/p5hAEsICARJnTvxkB7FZBFQlLjVsZAaxeQVsJU7POsYIsU5eYvWG
        A2BxTgE7iX8bljNDxJ+zSXR1h0DYLhKfr82BqheWeHV8CzuELSNxenIP2GIJgWZGiYfn1rJD
        OD2MEpebZkB1WEscPn6RtYuRA+g8TYn1u/Qhwo4Sm7b8AgtLCPBJ3HgrCBJmBjInbZvODBHm
        lehoE4KoVpOYdXwd3NqDFy5BnekhsbbxMSskgCYCQ2vaLtYJjPKzEJYtYGRcxSieWlqcm55a
        bJSXWq5XnJhbXJqXrpecn7uJEZgeTv87/mUH464/SYcYBTgYlXh4f7j+ihViTSwrrsw9xCjB
        wawkwnu742esEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxS
        DYy+an2X929cxdiUvleacetM06X3E9eVLRd9+vLVJF7uENVZHZ9uPfbhazwsp6ksLyVxd+vF
        jnfxv2V8v4r61qrbSzxv/TyxzYZ90h6dpLXhJcem5kfu2HwhRjTKM+1126FL66b2cx3/zlk8
        P7H9tGzvhH2v7TPfSGqnX+GaPX/HLG+//66vM+qUWIozEg21mIuKEwHQualgCwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t/xu7qfTX7HGvy6zGOxccZ6VovrX56z
        Wiz4NIPV4vz5DewWl3fNYbP43HuE0WLG+X1MFmuP3GV34PDYtKqTzaNvyypGj8+b5AKYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyNu//wFhw
        rq7i2ZObLA2MM2O7GDk5JARMJLbvPMYIYgsJLGWUWLVIByIuI3FyWgMrhC0s8edaF1sXIxdQ
        zSdGiTmTp4Ml2AQMJbregiQ4OUQEEiVmf5wNVsQs8BRo0JopYEXCAn4SG/Z0MYPYLAKqEpca
        NoLZvAK2EqdnQWyWEJCXWL3hAFicU8BO4t+G5cwQF9lKLHt8iWUCI98CRoZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgaG67djPzTsYL20MPsQowMGoxMP7w/VXrBBrYllxZe4hRgkOZiUR
        3tsdP2OFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8YR3kl8YamhuYWlobmxubGZhZK4rwd
        AgdjhATSE0tSs1NTC1KLYPqYODilGhhZ67os7Rn8JyZcs8vMsX663G17+xxHPYb011OjbiVf
        urFp0kGR2/8XX1M5KqQZES8oKB3dvZKd59XEh3rbl2aEhnfVWXl7lxQ4nPwx7ef056FLH0du
        aRVv51q4PUXFdL/EzZ33fn87veP+cTnpk28DpvJwWrltOfOH7fvWa0+Xzjl02OUTR6qkEktx
        RqKhFnNRcSIA1XAWgmsCAAA=
X-CMS-MailID: 20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927
References: <20191219082927.11898-1-m.szyprowski@samsung.com>
        <CGME20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the only Exynos5422-based boards that support bus frequency
scaling are Hardkernel's Odroid XU3/XU4/HC1. Move the bus related OPPs to
the boards DTS, because those OPPs heavily depend on the clock topology
and top PLL rates, which are being configured by the board's bootloader.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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
index 80b0acfec547..663a38d53c9e 100644
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
+	dmc_opp_table: opp_table18 {
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

