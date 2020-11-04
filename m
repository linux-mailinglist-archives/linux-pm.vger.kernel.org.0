Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD382A61FB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgKDKiL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:38:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47674 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgKDKhq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103732euoutp01fb74a52ed487bfb34404602914dc06ca~ER77s8l7w0749307493euoutp01V
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104103732euoutp01fb74a52ed487bfb34404602914dc06ca~ER77s8l7w0749307493euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486252;
        bh=/FRHhipH0++LZ7DwDFHNxX1ifPoUb6bj7wyOz1N82q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phylOyLTVRGfOX96jMkRmRoUfQ6BUntV3IrHJfrgjx77DnUXaL9lCtBNG+sxqve0k
         M29fE+AHBbzZRRiCmFLcNsx+zqoovfpR0rVmxlGfJ4dwqwaxmqDQQWQ2lY4WyNZhQ5
         JSgQLQb2Jl9zf3gTnaslrIHI9JBqUOPjBELXokJU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103727eucas1p1419756f7d67f72df4b1596005e515ba6~ER72xAL3m2673626736eucas1p11;
        Wed,  4 Nov 2020 10:37:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4A.8F.06456.76482AF5; Wed,  4
        Nov 2020 10:37:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d~ER72YMUwJ1141511415eucas1p2m;
        Wed,  4 Nov 2020 10:37:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103726eusmtrp15b3c784d0eb581c0cc5c77f1693c7036~ER72XcegN0620706207eusmtrp1C;
        Wed,  4 Nov 2020 10:37:26 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-1c-5fa28467056e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.64.06017.66482AF5; Wed,  4
        Nov 2020 10:37:26 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103726eusmtip2cbd0e037625fc6dd810c4dccea497dee~ER71orAeJ1010110101eusmtip2k;
        Wed,  4 Nov 2020 10:37:26 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 5/7] ARM: dts: exynos: Add interconnect properties to
 Exynos4412 bus nodes
Date:   Wed,  4 Nov 2020 11:36:55 +0100
Message-Id: <20201104103657.18007-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO7cdpSPHdXuxSBoFJZVKBR8k5Q0ZUhj96EdWa9VhWZvGjmYa
        ZLE00xTRUDM1KytbpDbXkJUybF7KG1prmdWE7F5aeQEzZs6j5b/nfZ/n+d7ngY8l5Q7aj42L
        TxT08WqtgvGmLC0TXes1566rgmqzOOwqT0f4fnENjZ2jH2l81d5F4+djwwwuajAxON+VR+Hu
        7loZNr17QeNn1lIGj+TYES7ubiTwPfsbGe4/W8Xg9Aa7DD/+dp7GxQWfmVBfpcl4gVG+fvGI
        UbqyWwllXWWaMtdsRMoR04qdzB7vkMOCNu6EoA/cesD7SKejmj5u5k8WOHLRGXSVy0JeLPCb
        oM5pIzxYzlchaCk9lYW8p/EogrIiKyENIwh+ljvQnGPyxx2ZRNxGYO2tYP5ZpqqHZB4VwwdD
        TnPujGMRHwkZ78spj4jkM0mw1OeTHmIhrwK30zljoPjVcNv8kM5CLMvxW6DUcFS65g93a20z
        ci8+BHpGDDNyjveFJ5cHKQ8mpzWGB1dIz/vAT8igwXSfksyR0DjQQUt4IXxpNcskvBzaCy5S
        ksGA4OLDfpk05CFwtVbMFt0Cr7t+M55EJL8WaqyB0joM6ly3CM8aeB94+d1XCuED+ZYiUlpz
        kJkhl9SrYNJYREjYD7IHp2ajKeHmuJvIQytL5tUpmVen5P/dCkQa0VIhSdRpBDE4XkjeIKp1
        YlK8ZsOhBJ0JTX+2dnfrr3o01nuwCfEsUizgbJZrKjmtPiGm6JoQsKRiERfe2b5fzh1Wp6QK
        +gSVPkkriE1oGUsplnIbr3/eJ+c16kThmCAcF/RzLMF6+Z1B/lXhm2sSYx2X0t3bQqkYy9Nh
        +3Cnue90yPvnjd8jOnw0bW557GDI28pCh/FVik/dx7KvkRG2gcaYxLxB07qAnvpo7ZrJHanj
        0bvD+nqT28Kao2452e3ronQZv7q3HgpojnpcUVhdMrQkaPEH8QvRZ/WLTN2bVvZn1yctydy4
        m71aQYlH1MEBpF5U/wXJ/8veaAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7ppLYviDS5t1re4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7G2avrWAu2CFRMvtrH2MA4n7eLkZNDQsBE4veHlexdjFwcQgJLGSV2nX0K5HAAJaQk5rco
        QdQIS/y51sUGUfOJUeLH2YdsIAk2AUOJ3qN9jCC2iICHxKnWtawgNrPADGaJ07NMQeYIC8RK
        7NzGBxJmEVCVWL5lNytImFfAWmJOcxbEeHmJ1RsOMIPYnAI2Ehc/N7OD2EJAJYufn2MCsXkF
        BCVOznzCAtLKLKAusX6eEMQieYnmrbOZJzAKzkJSNQuhahaSqgWMzKsYRVJLi3PTc4uN9IoT
        c4tL89L1kvNzNzEC43TbsZ9bdjB2vQs+xCjAwajEw3tg28J4IdbEsuLK3EOMEhzMSiK8TmdP
        xwnxpiRWVqUW5ccXleakFh9iNAX6bCKzlGhyPjCF5JXEG5oamltYGpobmxubWSiJ83YIHIwR
        EkhPLEnNTk0tSC2C6WPi4JRqYFzukXgt4eepbzcY9A75r+7WMqzYsjvwgKJK7x7NF7/M78o9
        MWtZ5PrHKNN+lqlT/sTdgW0Rd4oyz6p+//g2oMtQYQKn7NrI0g1K1bPn7lvVxVO4W2gG/xUH
        jodvfLp/1y3cqX5T4l1HfuqK5knHuvwiv1zkq3q+72ZK6OJFngvm/ecRqfbQUFNiKc5INNRi
        LipOBADta0Q06QIAAA==
X-CMS-MailID: 20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103726eucas1p248b51b25f5ee42898bf03e9cb2229c5d@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the following properties for Exynos4412 interconnect
bus nodes:
 - interconnects: to declare connections between nodes in order to
   guarantee PM QoS requirements between nodes,
 - #interconnect-cells: required by the interconnect framework,
 - samsung,data-clk-ratio: which allows to specify minimum data clock
   frequency corresponding to requested bandwidth for each bus.

Note that #interconnect-cells is always zero and node IDs are not
hardcoded anywhere.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v8:
 - none.

Changes for v7:
 - adjusted to the DT property changes: "interconnects" instead
   of "samsung,interconnect-parent", "samsung,data-clk-ratio"
   instead of "bus-width".

Changes for v6:
 - added bus-width property in bus_dmc node.

Changes for v5:
 - adjust to renamed exynos,interconnect-parent-node property,
 - add properties in common exynos4412.dtsi file rather than
   in Odroid specific odroid4412-odroid-common.dtsi.
---
 arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e76881d..4999e68 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -383,6 +383,8 @@
 			clocks = <&clock CLK_DIV_DMC>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_dmc_opp_table>;
+			samsung,data-clock-ratio = <4>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -452,6 +454,8 @@
 			clocks = <&clock CLK_DIV_GDL>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_leftbus_opp_table>;
+			interconnects = <&bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
@@ -468,6 +472,8 @@
 			clocks = <&clock CLK_ACLK160>;
 			clock-names = "bus";
 			operating-points-v2 = <&bus_display_opp_table>;
+			interconnects = <&bus_leftbus &bus_dmc>;
+			#interconnect-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.7.4

