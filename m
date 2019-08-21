Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008029775A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfHUKng (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53360 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfHUKn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104325euoutp01417f62635845b98de6609e168887cce2~86iLdJz6_0803008030euoutp01K
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190821104325euoutp01417f62635845b98de6609e168887cce2~86iLdJz6_0803008030euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384205;
        bh=780SP4kncWfgZ+yoXX6+SOGKZxP85S28KmhHTw/7MOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V76VPvy1zimXsfX8Y6jsoO5tfH8f4HMwM8+MDbSj5k/OJOCNiTE0ZmU/VR11N76nf
         WxtiJfAAYkSPzdGBPJaonWOUm3p7BcIEUPsam/Cx09YVhKJ892mocSIxV+WL5gV6Ms
         jyA4sEuqLu1lNErni/sty7CfWfPbXVJxc8XNz2lU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190821104324eucas1p1b0bea3e18e7ab4450b484defd89ceaee~86iKhiHSr1325113251eucas1p1J;
        Wed, 21 Aug 2019 10:43:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.A6.04374.C402D5D5; Wed, 21
        Aug 2019 11:43:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104323eucas1p2e0956d08d3d6c3934760ea76c2de0d57~86iJsYzhI0898008980eucas1p27;
        Wed, 21 Aug 2019 10:43:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104323eusmtrp27be02219a1d95f1d60364d7419e8d8e0~86iJeJtSy2827528275eusmtrp2B;
        Wed, 21 Aug 2019 10:43:23 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-67-5d5d204cf493
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.38.04117.B402D5D5; Wed, 21
        Aug 2019 11:43:23 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104322eusmtip2b6225e2653a8b87e9565a8e795f368ac~86iIYaLVV1273812738eusmtip2h;
        Wed, 21 Aug 2019 10:43:22 +0000 (GMT)
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
Subject: [PATCH v13 6/8] ARM: dts: exynos: add syscon to clock compatible
Date:   Wed, 21 Aug 2019 12:43:01 +0200
Message-Id: <20190821104303.32079-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa1BMURx39t679+5Om2trONIU2zBK2qjGMQyZ0cz1+GCY8SEWS9cWu6v2
        9kLMxpREj/GoJiWN52yRklTouYkesoO2URkqJKlJD5JZut0a337n95z5z6Ew+SDhRIXow1mD
        Xq1ViKV4ybPxluVbF6pU3o8fLUaFGQUEso58IVCO+SWB8oa6ATp9vUCMLjZki1DTOR1K6f6G
        oZaW+yRqPtVPondGZzR0/j2BXpdnidFwkhmgjJYKEbpr7iTRTatFhCwNAag99o4YxT01k6i2
        /wyBbK2FOKp8sxm1T9ijseddwH8+k381HzBjoxdwZrAtjmSuGC04U5bZSTJFprNipjI7n2SS
        Tg+ImeqBJyImudgEmAeNx5nhIpdtdoHStUGsNiSSNSjX7ZMGm7/fAqEvJdHWjt8iI4ijEoGE
        grQvrL/3FUsEUkpO3wGwLyUX5wU5PQJgz7UTgjAMYNeNfmwmYSuqAoJwG8DWhhRSeEwm6vq+
        TMYpSkx7wVJTGB9wpDMAvNK7g/dg9EcMJt/NArzgQG+CPb8uT7Xi9GI43nNJxGdl9HrY27NF
        GHOFeferpiwS2h/aUl8QfA+kcymYV/IQCKaNsLr9Ey5gB9hXX0wK2Bn+LcsRCZiDxqTcaX8M
        7E7JnvasgbX1FoLfxWh3WFCuFOgN0Bo7JOZpSNvDtu9zeBqbhBdK0jGBlsGEeLngXgqLz7+a
        HpoLb+enTZczsCy+kxDueRHAZ61LU4Fr5v+tawCYwDw2gtNpWM5Hz0Z5cWodF6HXeB04oisC
        k9+w0VY/Wgoq/uyvATQFFHayfdZdKjmhjuSO6moApDCFoyw6K1AllwWpjx5jDUf2GiK0LFcD
        FlC4Yp7s+KwPu+S0Rh3OHmbZUNYwo4ooiZMRxNakOe5dvVLrk97poV/o9mCDf/VuJ50ypm72
        KklzdEifUVMsJXW1ltDPhzyxX4m947Uyt3uJ291/BLzd09xk8njtp0RjymiVxrbn0U699mfw
        bJfArLAXePmA+y3vZQXEJr+JBTbfQcfBr43b3UOXnEjb7NRxsvBgq2ezYdF4VAKjwLlg9QoP
        zMCp/wEicnClggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7reCrGxBp23NSw2zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFkuvX2SyuHjK1eJ24wo2i9a9R9gtDr9pZ7X4d20ji8X+K14W
        t3/zWXw78YjRQdJjzbw1jB7fvk5i8Xh/o5XdY3bDRRaPnbPusntsWtXJ5rF/7hp2j97md2we
        B9/tYfLo27KK0WPz6WqPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DKOvF3GWHCOs+L6nV9MDYytHF2MnBwSAiYS/zYdYOxi5OIQEljK
        KNF68QoLREJMYtK+7ewQtrDEn2tdbBBFnxgl7vZOY+1i5OBgE9CT2LGqECQuIjCHUeJn1zaw
        ScwCv5klDt7tB+sWFvCUePJjKjOIzSKgKvHzyRQmkGZeAXuJF0+8IRbIS6zecACshFPAQeLf
        hJOsILYQUMnUDW9ZJzDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYo9uO/dyyg7Hr
        XfAhRgEORiUe3h03o2OFWBPLiitzDzFKcDArifBWzImKFeJNSaysSi3Kjy8qzUktPsRoCnTT
        RGYp0eR8YPrIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAyPCb
        qzxsQwuf7Uqv3T9Vl6YousccTS6RbfhktTVKoCenYvnxntIpF8wYb1S/XVaS+Spz94O8s6GZ
        c0JfOm7ImTkjuaiE22u30d6mZecDc1bVHYybzDdlU8wXRcbb53+sbSioq3r6N7vt1QFJyX2M
        zq0bltaH6/s6Wfhv/nkqmv1yScSZX+f2KrEUZyQaajEXFScCABVCIHfnAgAA
X-CMS-MailID: 20190821104323eucas1p2e0956d08d3d6c3934760ea76c2de0d57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104323eucas1p2e0956d08d3d6c3934760ea76c2de0d57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104323eucas1p2e0956d08d3d6c3934760ea76c2de0d57
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104323eucas1p2e0956d08d3d6c3934760ea76c2de0d57@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get the clock by phandle and use it with regmap it needs to be
compatible with syscon. The DMC driver uses two registers from clock
register set and needs the regmap of them.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 55d4dbf6f83a..97dc10915680 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -175,7 +175,7 @@
 		};
 
 		clock: clock-controller@10010000 {
-			compatible = "samsung,exynos5420-clock";
+			compatible = "samsung,exynos5420-clock", "syscon";
 			reg = <0x10010000 0x30000>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b319fd65..0a2b3287ed92 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,7 +17,7 @@
 };
 
 &clock {
-	compatible = "samsung,exynos5800-clock";
+	compatible = "samsung,exynos5800-clock", "syscon";
 };
 
 &cluster_a15_opp_table {
-- 
2.17.1

