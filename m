Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E062412722B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLTASX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:23 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57693 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfLTASJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:09 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220001804epoutp038a2f2bf95d85891ba249e0b26d37bc94~h7DuGCwdI1395213952epoutp03P
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220001804epoutp038a2f2bf95d85891ba249e0b26d37bc94~h7DuGCwdI1395213952epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801084;
        bh=X+3c4eWtnhc/wznu8yi8b2cClbqwmxlDm2znKapn0f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUvkeAWo6LpnDRHd+QT5dqXOJMdaEGje+uADwMMQp0UZ+oTWrhsRgS+sAbA0BDzpF
         ZeJotKTtgUcG8DQ4Ptc0ZD20or26vjFl4lg1q6y4T/tKOCfC3tqA7d9gCv6vgQ3CaS
         ySgCahu5rar+1WA9VRLgJUmmUf09PNBMM465HA3M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191220001804epcas1p3e2b76ae36447fc53d7cc23897e5a458c~h7DtqGA0b1379413794epcas1p3b;
        Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47f8Tj3XDHzMqYks; Fri, 20 Dec
        2019 00:18:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.E5.57028.9331CFD5; Fri, 20 Dec 2019 09:18:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epcas1p13d5f4ff181c10a118e151a86891a7130~h7DqMcQuI0248302483epcas1p1m;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001800epsmtrp137795fa8ccc38d84bbebd812ec3bb576~h7DqLk-GK1705617056epsmtrp1b;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-1a-5dfc13393711
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.CA.10238.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001800epsmtip1c0d85f62e3a18f1dd3ec9f557ce34298~h7Dp76vdw2050220502epsmtip10;
        Fri, 20 Dec 2019 00:18:00 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 11/11] arm64: dts: exynos: Replace deprecated property
 for Exynos bus on TM2
Date:   Fri, 20 Dec 2019 09:24:30 +0900
Message-Id: <20191220002430.11995-12-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmga6l8J9Yg2vfpS3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjNerFvIXHBaoGLKh5XsDYxHeLsYOTkkBEwkThz7zdzFyMUhJLCD
        UeL7hh4WCOcTo8Sqna+gnG+MEicnvGOGabny/C0bRGIvo8TbTQuZIJwvjBKTOq+zgVSxCWhJ
        7H9xA8wWEciQmPn6MitIEbPARyaJrm13wRLCAokS6/tmgNksAqoS57ZdYgexeQWsJQ4dOgm1
        Tl5i9YYDYDYnUHzLs4fsIIMkBP6zSbQ/egJV5CKxd2sHE4QtLPHq+BZ2CFtK4mV/G5RdLbHy
        5BE2iOYORokt+y+wQiSMJfYvnQzUzAF0nqbE+l36EGFFiZ2/5zKC2MwCfBLvvvawgpRICPBK
        dLQJQZQoS1x+cBdqraTE4vZONgjbQ2Jj21JGSKj0MUpcefidZQKj3CyEDQsYGVcxiqUWFOem
        pxYbFhgiR9omRnBK1TLdwTjlnM8hRgEORiUeXoe037FCrIllxZW5hxglOJiVRHhvd/yMFeJN
        SaysSi3Kjy8qzUktPsRoCgzKicxSosn5wHSfVxJvaGpkbGxsYWJoZmpoqCTOy/HjYqyQQHpi
        SWp2ampBahFMHxMHp1QDIx9nsKem5KoNK6ZlyGewvp2/7eSRty4bfdifOeiZBjEEZeaHPlbh
        i9wi2SDNKMU9YeJZhQ7Du4XvLO7db8u6X3b4q8OTOUyunazlrIt1PXsnqqSVvZ824bvwnTMC
        wpXbcq2TmpkX7VXfou+oPyd+YvKHhxsXZ/a9XX1wmfDcoLkBujd6nFasU2Ipzkg01GIuKk4E
        ANzYs4y/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK6F8J9Yg1dX1C3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGS/WLWQuOC1QMeXDSvYGxiO8XYycHBIC
        JhJXnr9l62Lk4hAS2M0osbt9ARtEQlJi2sWjzF2MHEC2sMThw8UQNZ8YJW4ePsACUsMmoCWx
        /8UNsHoRgTyJTRu/MoMUMQv8Z5L4fvIBI0hCWCBeonHBRSYQm0VAVeLctkvsIDavgLXEoUMn
        mSGWyUus3nAAzOYEim959hCsRkjASuLl+QusExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECA57Lc0djJeXxB9iFOBgVOLhdUj7HSvEmlhWXJl7iFGCg1lJhPd2x89YId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhiNNp8ov+TxRLYk
        MGxfRGjFnp+hV09oyYtkVfcxebIzKnt9qixVv7ze6u7EAo4ggyXlCyd5Fm7YxnSXzSLyp/G0
        iKCqyS2J3gyHGM+88Y97cTC6i/FJRfrXqreNi4Ne+mpZ6Zb66tYVaQbqh+h5dHVcuqnRrdO4
        9oze3l/cKzqvzDlddGfreyWW4oxEQy3mouJEAJUT7m93AgAA
X-CMS-MailID: 20191220001800epcas1p13d5f4ff181c10a118e151a86891a7130
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001800epcas1p13d5f4ff181c10a118e151a86891a7130
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001800epcas1p13d5f4ff181c10a118e151a86891a7130@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the property related to devfreq and devfreq-event device
to remove the deprecated property name.
- Replace 'devfreq' with 'exynos,parent-bus' property
  for getting the parent devfreq device of exynos-bus.
- Replace 'devfreq-events' with 'exynos,ppmu-device' property
  for getting the devfreq-event device to monitor bus utilization.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 6f90b0e62cba..6bdd5b0940a5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -166,54 +166,54 @@
 };
 
 &bus_g2d_400 {
-	devfreq-events = <&ppmu_event0_d0_general>, <&ppmu_event0_d1_general>;
+	exynos,ppmu-device = <&ppmu_event0_d0_general>, <&ppmu_event0_d1_general>;
 	vdd-supply = <&buck4_reg>;
 	exynos,saturation-ratio = <10>;
 	status = "okay";
 };
 
 &bus_g2d_266 {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_gscl {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_hevc {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_jpeg {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_mfc {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_mscl {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_noc0 {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_noc1 {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
 &bus_noc2 {
-	devfreq = <&bus_g2d_400>;
+	exynos,parent-bus = <&bus_g2d_400>;
 	status = "okay";
 };
 
-- 
2.17.1

