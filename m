Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007FBB7C22
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfISOXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46496 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390572AbfISOXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142330euoutp010a391aad5e5586ac13d5d8688fe030ef~F3PnclHEv2200122001euoutp01_
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142330euoutp010a391aad5e5586ac13d5d8688fe030ef~F3PnclHEv2200122001euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903010;
        bh=4kG6qE0VCmH9gQI7bgdBe+khJWWomB1XqLRfnIX4VG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOINmmmKaPK8aJILecaUTQWIITuNNeEWgbhCu7FUqXien5IZQybeJaViYUzuYVSIH
         +QcEdf3tdIP73znI6kvqkMFkt8wUZfj2DVUlvm+PAF5/5RTLPeP6jIXfk8vTKqGSmM
         xkaRTqJW0lC4QoxDDXSz/Zj2hqjPrywEiCi65vS0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919142330eucas1p1f715b753b2134f8715c31ad53ceeba37~F3PmtgJcX1885218852eucas1p1c;
        Thu, 19 Sep 2019 14:23:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AB.0C.04469.16F838D5; Thu, 19
        Sep 2019 15:23:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142329eucas1p299762f99dd55a5d625633ceec84219f9~F3PlxHo1y3081230812eucas1p2m;
        Thu, 19 Sep 2019 14:23:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142328eusmtrp1e7e9e485ce2ebd973b537efbd222d550~F3Plimzbc0555105551eusmtrp1g;
        Thu, 19 Sep 2019 14:23:28 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-17-5d838f6124d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.65.04117.06F838D5; Thu, 19
        Sep 2019 15:23:28 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142328eusmtip15930d3c33f56712647f28e35c4242502~F3Pkv2Ktx3032330323eusmtip14;
        Thu, 19 Sep 2019 14:23:27 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
Date:   Thu, 19 Sep 2019 16:22:33 +0200
Message-Id: <20190919142236.4071-9-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+93X7qTJdQqeTHqsgl66yoJfGJYUcaF/gkohk1p609JZ7frI
        +qOlGFnOTPOtKWW2pqJOywdWtoZLfAwrLUib9CAUUktFBZWc1x7/fc453+95wGFJpYP2Ys/G
        xAq6GE20inGhnrbN2H00t5NDt7V3qrGl7YkMO+6lIFybV03j9xPfaVxi7abxu8lRBuc+MzM4
        05FBYbu9RoaNAz9pbP7SR+O3zUUMHjdYEc6zPydwlXVAhj9eMzI4L2uI2efGm02pDN/f18Lw
        jls2gq8ru8rXjjQS/MuRFoJPrzchfty86jB73GVPuBB9Nl7QqQNOuUSO9HfTF6wrLjVM3af1
        KMPjJpKzwO2ENP0UcRO5sErOiOBB5iAjBRMIXtytJaVgHIHeYif+WHobDUuWRwgMhiryr2Wk
        q5xyqhguEDKzB2XOggdnRZBVOko5A5IrIyC90E46Ve5cGJjSpheZ4jaAqb+cdrKCw1Az1stI
        81ZDRU3rokbO7YaJ5yWUpHGD9vyvi0wuaJKfFJKSPpWF8mfnJD4AX/p7lvq4w7CtXiaxN3Rk
        pVESi/CtyUE7lwNOj8Bcbl1q5A+vbD0LBXZhwCaoblZL6UC4Xpkrc6aBc4UPP9ykFVwh82ku
        KaUVcOO6UkIVNOe7SkaApIq+pd48TKZ2EhlobcF/txT8d0vBv7GliDQhTyFO1EYI4vYYIcFX
        1GjFuJgI37DzWjNaeLuOeduvRjT55rQFcSxSLVesSUgOVdKaeDFRa0HAkioPRdGupFClIlyT
        eFnQnT+pi4sWRAtayVIqT8WVZYMhSi5CEytECcIFQfenSrByLz3au784I33w4Py6uxWd3Kr0
        1zNbPx36uT4o6chQ8MYmuJiDWw5u3nKsWjtXeWf2RMq09Y1vXXjrXPFD/6MB96YbgoN2B+Z/
        19oeljxOaugzqtunBD+f4AfyyrYzMKYO0WUb5DrTax+Pz+0nc2aj56NWdyHuQN1n7wSvmTJj
        4LDfjmAVJUZqtm8mdaLmN5oPPI9yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7oJ/c2xBj82G1ocOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL+PdnXOsBUckK7Z/X8TawDhBpIuRk0NCwETi6o5epi5GLg4hgaWMEqde
        vmaHSEhIfFx/gxXCFpb4c62LDaLoE6PE7UnPWUASbAKOEpOmPmAHSYgInGKU2Lr8HFgVs8AG
        JonlT18CtXNwCAskStw/4QDSwCKgKrHqzjKwqbwCFhIbPlxlg9ggL7F6wwFmEJtTwFLiy775
        YAuEgGrmPp7LCFEvKHFy5hMWkJHMAuoS6+cJgYSZgVqbt85mnsAoOAtJ1SyEqllIqhYwMq9i
        FEktLc5Nzy020itOzC0uzUvXS87P3cQIjOFtx35u2cHY9S74EKMAB6MSD69CeXOsEGtiWXFl
        7iFGCQ5mJRHeOaZNsUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wveSXxhqaG5haWhubG
        5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGDl1WDT+Rb83zPa1cft/o/25Z94rkxOP
        Vlgz2l/Xyjb8vnYK+7nzd3lF1ifM33SisXpWyXP9d7kz+f/JBxoyT41ZdcDRWmJq0Ztg2W1F
        vy+es5tted1I4Fqw5kzRe5N12qLf5CaGODvwTwpYFX63kXv6pk8HdX48CDi29VhqhJtJ7sLd
        BzM+qyuxFGckGmoxFxUnAgAbkcaK9wIAAA==
X-CMS-MailID: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p299762f99dd55a5d625633ceec84219f9@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds two fields to the Exynos4412 DTS:
  - parent: to declare connections between nodes that are not in a
    parent-child relation in devfreq;
  - #interconnect-cells: required by the interconnect framework.

Please note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere. The above-mentioned parent-child relation in devfreq
means that there is a shared power line ('devfreq' property). The 'parent'
property only signifies an interconnect connection.

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

