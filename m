Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC771804
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGWMUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38688 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389729AbfGWMUc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122029euoutp016cc9889444f78312731235e5e04227d1~0CJpLr1xm2863228632euoutp01n
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122029euoutp016cc9889444f78312731235e5e04227d1~0CJpLr1xm2863228632euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884429;
        bh=R63VpqUTGKXGRrP/Yb1S0i4GgWkwdvgJxrH4IVxwNhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alUIgy8HfMBCrHlSu1PrgNIlc1vQFZxwBniyeQNWLkTRKeIczRmJVO5EOoZQkUtUc
         x+dP1KhI3NnT4qY+c9H3Hs1aOtXgb7UyQiYPjjC0YC1Jd6PMOWiftkigb9/J71p38E
         6bmUsrZVU+nkHNq75wBo/0h3uMrzT6UzwhXrAQyY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723122028eucas1p23bc8d09d1147876131f35f41d4918929~0CJoZ6rhy1082110821eucas1p2a;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.5B.04298.C8BF63D5; Tue, 23
        Jul 2019 13:20:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98~0CJns5a7L2096920969eucas1p2A;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122027eusmtrp1969382de17b4f9b7cc567e489c022d2b~0CJnh3fqJ2543725437eusmtrp1B;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-85-5d36fb8cefdb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.D8.04140.B8BF63D5; Tue, 23
        Jul 2019 13:20:27 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122026eusmtip2b8aa141a3c4a8a402bed53888c0e08d8~0CJm6ZS3E1733017330eusmtip2j;
        Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
Date:   Tue, 23 Jul 2019 14:20:13 +0200
Message-Id: <20190723122016.30279-9-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRzue++Pe50ur6P5VPp1W7OukFb6bjWlWnv7p/KPtZpy8oZx6F5E
        al21ECecVqiVP0ztZKcLU5PChVJnUSi1MzFjk/JjrVk/nK/Kf8/zfJ/n+Xw+25ejVHZmORcT
        nyTq47VxalZB17b8sPsaZwLDNpWP8bippUaOHxRZGNwzNczgOzY7g99Oj7P4xhMri02OfBp3
        dFTJsfVzN4O7Ht9i8WSuDeGijgYZrrR9kuO+C/dYXFQ4wu5yE6zmK6zwsbueFRw5rTLhYdl5
        ofFLvUy4Wm1GwqR11SH5EcWOSDEuJkXU+weFK6J/DmQyiT1eqbktjTIDsqmykQsH/BZ4NZiH
        spGCU/H3ENjvG1hCphBcK3MwhEwi+P1yYtbGzUUa7Bqi30XwNLOZ+pcYGs5inL0svx+MBXVz
        aU/ehqCwdJx2Eoo3z5Lvtcjp8uDDIdvxlXJiml8Hl4xP5nQlHwwVr/NkZMPVUFH1bM7jwu+G
        7OeZLPG4w4viQdqJqVnPpZqbFPF/k0NeWxBZdS/UVx0ksgeMtlbLCfaG9kIjTbAEQ4/ImcAb
        EFjLbfM926G59Q3j7KH49WB57E/kYJhqz6RJ/RLoHXMnGywBU+0NishKyMpQEaiB0pmjJAhw
        saJ7vluAh0P32Xy0tmTBKSULTin5P7YUUWbkJSZLuihRCogXT/tJWp2UHB/ldyJBZ0Wzv6z9
        V+tEHZrujGhCPIfUi5VV9VvDVIw2RUrTNSHgKLWnMsQQGKZSRmrTzoj6hOP65DhRakIrOFrt
        pUxf1H9UxUdpk8RYUUwU9X9fZZzLcgNKVdwO7X53zpbk2ulJW7xHik/hEJ+AB16Ma9/OPMvZ
        X7aNyt3gYQ3bfHLZq8GKZNOVw4npO/pMjg+aBvW+9JiGdaM5Rpc6of9yQYbGsvRYXP71ct17
        t0RzZXhoSqVJ75YUMeq7YcDsI+yNDlK1HSjYhbeOXV0jlHT1rrywrS92j5qWorUBGkovaf8A
        7or2X2EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7rdv81iDT62qFgcOraV3WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3HwXd7mDz6tqxi9Pi8SS6A
        PUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4++j
        dtaC6+IVvccOMjUwHhHqYuTgkBAwkdh3TquLkYtDSGApo8TvOxOYuhg5geISEh/X32CFsIUl
        /lzrYoMo+sQo8Wp7I1gRm4CnRM/EHawgCRGBU4wSW5efA6tiFtjEKHH3+ER2kCphgTiJC9N/
        go1iEVCVaO7Zywhi8wo4Sqw+2w+1Tl5i9YYDzCA2p4CTRNfRdjYQWwioZtv211D1ghInZz5h
        ATmbWUBdYv08IZAwM1Br89bZzBMYBWchqZqFUDULSdUCRuZVjCKppcW56bnFRnrFibnFpXnp
        esn5uZsYgVG67djPLTsYu94FH2IU4GBU4uHdsMc0Vog1say4MvcQowQHs5IIb2CDWawQb0pi
        ZVVqUX58UWlOavEhRlOg1yYyS4km5wMTSF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU
        7NTUgtQimD4mDk6pBsYDj91+HuN46Pxgs+CKCwyvsw/9VV3XVJ2hE8zfynysZvXfkDU3d/fk
        70yOEF4jH/94xhnBpAvPP2dyRMjteOPRHHkxhe1DPnfnD63/F+QcHl6Z9mxtyfZvO1k6X8n5
        hfNUu6UuYNyjwXznFKupq3fRHb2Ers+df6+etD+V+nfzxjDbui+xUQeVWIozEg21mIuKEwER
        cQgI6AIAAA==
X-CMS-MailID: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds two fields tp the Exynos4412 DTS:
  - parent: to declare connections between nodes that are not in a
    parent-child relation in devfreq;
  - #interconnect-cells: required by the interconnect framework.

Please note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
 arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ea55f377d17c..bdd61ae86103 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -106,6 +106,7 @@
 &bus_leftbus {
 	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
+	parent = <&bus_dmc>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d20db2dfe8e2..a70a671acacd 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -390,6 +390,7 @@
 			clocks = <&clock CLK_DIV_DMC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -398,6 +399,7 @@
 			clocks = <&clock CLK_DIV_ACP>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_acp_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -406,6 +408,7 @@
 			clocks = <&clock CLK_DIV_C2C>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -459,6 +462,7 @@
 			clocks = <&clock CLK_DIV_GDL>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -467,6 +471,7 @@
 			clocks = <&clock CLK_DIV_GDR>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -475,6 +480,7 @@
 			clocks = <&clock CLK_ACLK160>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_display_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -483,6 +489,7 @@
 			clocks = <&clock CLK_ACLK133>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_fsys_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -491,6 +498,7 @@
 			clocks = <&clock CLK_ACLK100>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_peri_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -499,6 +507,7 @@
 			clocks = <&clock CLK_SCLK_MFC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.17.1

