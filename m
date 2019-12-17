Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F87122435
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 06:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLQFva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 00:51:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26987 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfLQFvP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 00:51:15 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191217055110epoutp0162a9a849b6ba2e94441a9f23ad7cc245~hEqsTiIas0906509065epoutp01r
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 05:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191217055110epoutp0162a9a849b6ba2e94441a9f23ad7cc245~hEqsTiIas0906509065epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576561870;
        bh=X+3c4eWtnhc/wznu8yi8b2cClbqwmxlDm2znKapn0f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HK0PttloJPSZGkm2HOam4m6COdIFX3az4tH/84FvBuGkNxvnn1MOv7vtj9VCP7/e8
         yFLcGhWxFGc5NqNkKVpCZ75rGORaTTtVRE0LJlqUMpay5zVqYCBGb1wbONBf5MVjuK
         ZN643ehFHJe+JzIlzhh2ICc1dG2pW4M+3P6iMkGY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191217055109epcas1p2fe070e79dde850225f8097f2757ef8b6~hEqrjfr242687526875epcas1p2g;
        Tue, 17 Dec 2019 05:51:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47cS1R3lVjzMqYkq; Tue, 17 Dec
        2019 05:51:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.0D.51241.BCC68FD5; Tue, 17 Dec 2019 14:51:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191217055107epcas1p44d46bdea7b326b86689f326742f5444a~hEqpBiy6C1997419974epcas1p4a;
        Tue, 17 Dec 2019 05:51:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217055106epsmtrp2474ac40aa2f41c24ce1585a5371746bf~hEqpAprtW1905819058epsmtrp2A;
        Tue, 17 Dec 2019 05:51:06 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-4d-5df86ccb17e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.5D.10238.ACC68FD5; Tue, 17 Dec 2019 14:51:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217055106epsmtip15cd0260d03155575fcab99c904638b56~hEqolNbTZ3193831938epsmtip1Y;
        Tue, 17 Dec 2019 05:51:06 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     a.swigon@samsung.com, m.szyprowski@samsung.com, kgene@kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 9/9] arm64: dts: exynos: Replace deprecated property for
 Exynos bus
Date:   Tue, 17 Dec 2019 14:57:38 +0900
Message-Id: <20191217055738.28445-10-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217055738.28445-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmru7pnB+xBnNuy1jcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOA3lBSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX
        5qXrJefnWhkaGBiZAhUmZGe8WLeQueC0QMWUDyvZGxiP8HYxcnJICJhI/Lx2ha2LkYtDSGAH
        o8T1BVdYIZxPjBLzzs5mhnC+MUq83P+WBaald+stdojEXkaJ7zePQVV9YZQ4tOcsM0gVm4CW
        xP4XN9hAbBGBOon5h3cwgRQxC9xkkthz6RYrSEJYIFTix5l7YEUsAqoS/9u/gDXzClhL/Jq1
        hglinbzE6g0HwOKcQPHn216DDZIQ+M0m8WvydUaIIheJrpdLoWxhiVfHt7BD2FISn9/tZYOw
        qyVWnjzCBtHcwSixZf8FVoiEscT+pZOBpnIAnacpsX6XPkRYUWLn77lgM5kF+CTefe1hBSmR
        EOCV6GgTgihRlrj84C7UnZISi9s7oVZ5SNzfPQEakH2MErPWPmKcwCg3C2HDAkbGVYxiqQXF
        uempxYYFpsiRtokRnFK1LHcwHjvnc4hRgINRiYdXouR7rBBrYllxZe4hRgkOZiUR3h0KQCHe
        lMTKqtSi/Pii0pzU4kOMpsCgnMgsJZqcD0z3eSXxhqZGxsbGFiaGZqaGhkrivBw/LsYKCaQn
        lqRmp6YWpBbB9DFxcEo1MNpymfLu4D6ZuErzxNLtrz94W/opvctPqTphlXPUXaF934RKsfev
        ZzRKL5F6KSIpxqIv/M41vPXmYvNGH5tVrVeP+zz0Pb2ZJbJc5fyU129v7TWdfrpqdu0r+4W3
        XONDLXivRql6mZ3qre7ZcSvlS/mZ7y9FXVbGKUpKSHTmbPkw7WGE/AvlvUosxRmJhlrMRcWJ
        ALLxzCa/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO6pnB+xBg/eWFjcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4Ml6sW8hccFqgYsqHlewNjEd4uxg5OSQE
        TCR6t95iB7GFBHYzSjzpMoWIS0pMu3iUuYuRA8gWljh8uLiLkQuo5BOjxKMr78Hq2QS0JPa/
        uMEGYosItDFKLPkuB2IzCzxnktjXZQZiCwsES3RcOMYKYrMIqEr8b//CDGLzClhL/Jq1hgli
        l7zE6g0HwOKcQPHn214zQdxjJfFz6jPWCYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al
        6yXn525iBIe8luYOxstL4g8xCnAwKvHwSpR8jxViTSwrrsw9xCjBwawkwrtDASjEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDY9/qFp1Dv7qNp5/du/f0
        DN3NjEYf10ldVg6bt+b9rsemyTz6mjfls4/8KHONW/Iuy95aWy8n06htfZR80PR/f09P2BGj
        sMGI2fbW5dBPLku7K6SV9YpmX1ZU7J3Nvmhlt2CCU52RANNFs97KgP5bfUvCQ+cbxEo9D+7K
        PXyDT833ymzmr1G9SizFGYmGWsxFxYkArvwDlnUCAAA=
X-CMS-MailID: 20191217055107epcas1p44d46bdea7b326b86689f326742f5444a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055107epcas1p44d46bdea7b326b86689f326742f5444a
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055107epcas1p44d46bdea7b326b86689f326742f5444a@epcas1p4.samsung.com>
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

