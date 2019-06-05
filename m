Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E71C361CC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfFEQzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:55:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32979 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfFEQyl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165440euoutp01fe28ddbb67ccf812850ea8d751bc06a7~lW7VUTFXT0154001540euoutp01H
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165440euoutp01fe28ddbb67ccf812850ea8d751bc06a7~lW7VUTFXT0154001540euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753680;
        bh=3WP8EDAu+5H7APsQt9nFgGZ+xA43IHtfClvOa7dqrls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASRtdo/3qaRN09CEGKHBv2s+wXgu+tB60eDJK3vCunIFYdls3LSm1Qs/brqN/uocQ
         zrqtMyXAWkw+oTd2AgQIs2cv5amqWTy9P+Fnv4HjoM5qBeuLWEN1crga+0ImMemRKp
         FdRNL8yhVyFPLhKyrdTTlCujKbjPYZ1aeTaaU41g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165439eucas1p2d24c94a52168d41846b050aece3c22d5~lW7UgU_jK0671106711eucas1p24;
        Wed,  5 Jun 2019 16:54:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9D.08.04325.FC3F7FC5; Wed,  5
        Jun 2019 17:54:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165437eucas1p1321cd8369e1ffc6b4b6c3ca2d69bcd70~lW7TJGyT40348103481eucas1p1a;
        Wed,  5 Jun 2019 16:54:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165437eusmtrp2e0550da0b14e3103497bb3c6ba9f25a9~lW7S5iEhZ2868028680eusmtrp2e;
        Wed,  5 Jun 2019 16:54:37 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-40-5cf7f3cfe31a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.B2.04146.DC3F7FC5; Wed,  5
        Jun 2019 17:54:37 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165436eusmtip102b2b27b6f511f440596ca49c8707182~lW7R7Yyo90338903389eusmtip1P;
        Wed,  5 Jun 2019 16:54:36 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v8 10/13] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Wed,  5 Jun 2019 18:54:07 +0200
Message-Id: <20190605165410.14606-11-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTQRjHne52d6lUl3JNkKhpovECz4dJFAMJmg0+qIRooiRScQONbYUu
        p/hQIYgCBVIi4kFAExRBLRaCQJSjHDVYKURC1YoXCh5AwHJjxJat+Pab//F9k8lQmKRD6EfJ
        VQmsWiVTSAkRXtc5Zwmw2Gcid5Q8I9DjYr0QWSeHhai0vVuIqiYGASrsKhEgc44S5Q/+xJDF
        Uk2il+kjJHqr8UevGm8RyK5tB6jY0iRAD9sHSGS7WEGgtpEsIWruC0O2hVVo+vlnEOzJTE/p
        cOamphdnGm4MkIyh8grBaDPGCKZ17KmAyautBEzNizTGblh7xO2EaN8ZViFPYtXb90eJYrs6
        prA4M5HSVzYFNKBWmA3cKEjvgYaCnCWW0BUAVleszgYiB08CqBnVCviDHcAP9vzlhuXOE4w3
        7gFo1JUTy5UZ4zdHhaIIOhDWV8Y7C150GnxnbV4qYPSIAL6cn8WdhicdAe8W2Egn4/QG2K3r
        WWIxHQytukbXtnWwqroFc7KbQy8y1eDOQZB+T8JZQwbBh0KhtbyM5NkT/jDVutgfLjaUCnjm
        oEZ7G/B8AQ7ml7gye2GbqVfovDRGb4b6xu28HAK/dOhIpwzpVfD1qIdTxhyoq7uG8bIYXr4k
        4dObYG1uj2uRD7z3oMg1nIHXi4dcj1gI4EL7G1AA1t34v6wMgErgyyZyyhiW261ikwM5mZJL
        VMUERp9TGoDjc734Y5qqB02/TxsBTQGpuxg+nomUCGVJXKrSCCCFSb3EMttkpER8RpZ6nlWf
        O6VOVLCcEayhcKmvOG3Fx5MSOkaWwJ5l2ThW/c8VUG5+GtC81f/QTeqwScSAqxEdp8x9bOm3
        UNNia0vWYljNbN7Gzpr1c8PjJBaUotAek/uRCvcNAY9oH7sq/cfBgNVlep/QMEn4LnP0xMqj
        /blf+/W/bEHyvPvzPUPHvfXxUYGf8jeePxYnCKe2bcEPjXkkZyQeaKvKvP79YXIIGH/kbc2U
        4lysbOcWTM3J/gJlTW6HWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7pnP3+PMdi4Wt1i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFNHvzIXnGGruLLgK2MD4xbWLkZODgkBE4nzi7Yz
        dzFycQgJLGWUeNW8hxEiISYxad92dghbWOLPtS42EFtI4BOjxLcrpl2MHBxsAnoSO1YVgoRF
        BOol+t9cYgOZwyzQwCyxZvtVsAXCAkESb2ZsYQaxWQRUJc5NugA2k1fAQeL6pF1QR8hLrN5w
        AKyGEyg+7fhmFohd9hKXrv9mnsDIt4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgJG07
        9nPzDsZLG4MPMQpwMCrx8Eps/B4jxJpYVlyZe4hRgoNZSYQ38faXGCHelMTKqtSi/Pii0pzU
        4kOMpkBHTWSWEk3OB0Z5Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYO
        TqkGRsOvzSr5vre2r6ndu/PE+262VMOXifamGaG71yuENDGIyIdM27jMJ+TvRwvD98uWnxWu
        q3zdGpP1eMMDzkKxn0LJrwrTz92TE5/Ys/fd8fw+0y8lC3wfJmW2Fx+dm6V67fHCDT6yz5lq
        FM+ezVbZU/GkwLF79qOFJic/pHEf6r8f+lHGabuXkBJLcUaioRZzUXEiAFvNcV+6AgAA
X-CMS-MailID: 20190605165437eucas1p1321cd8369e1ffc6b4b6c3ca2d69bcd70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165437eucas1p1321cd8369e1ffc6b4b6c3ca2d69bcd70
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165437eucas1p1321cd8369e1ffc6b4b6c3ca2d69bcd70
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165437eucas1p1321cd8369e1ffc6b4b6c3ca2d69bcd70@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the chipid label which allows to use it in phandle from other device.
Use syscon in compatible to get the regmap of the device register set.
The chipid is used in DMC during initialization to compare compatibility.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 67f9b4504a42..4801ca759feb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,8 +35,8 @@
 		#size-cells = <1>;
 		ranges;
 
-		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+		chipid: chipid@10000000 {
+			compatible = "samsung,exynos4210-chipid", "syscon";
 			reg = <0x10000000 0x100>;
 		};
 
-- 
2.17.1

