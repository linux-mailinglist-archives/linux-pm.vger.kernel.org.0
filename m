Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912CC5BC89
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfGANMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57933 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfGANL5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131156euoutp01edae705aabc3465a6bd96df575cdb56b~tSqSwRkm42458724587euoutp01l
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131156euoutp01edae705aabc3465a6bd96df575cdb56b~tSqSwRkm42458724587euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986716;
        bh=3WP8EDAu+5H7APsQt9nFgGZ+xA43IHtfClvOa7dqrls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYbmHMXqJPZJXoyxn2ub6VHICC1AdjDg4fbEwEXHVXm5XF5qhovbddyeY3+XHM53G
         qzVoyrIRgxuJpmRIcaAfStbafO9o1r2S36RBr/gmJ51gtoFpboHh3M2cWBbm0Epgqh
         XjAJFqtmG0tSYWSnACUXnMemX5yQ4Qej8+BAx6gs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701131156eucas1p18fe3f9d993e0f29d29cf24a5079cfef7~tSqSAoocr2887728877eucas1p1C;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 35.87.04325.B960A1D5; Mon,  1
        Jul 2019 14:11:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131155eucas1p1f51297a17dd902fc431f62234ef5e677~tSqRL5l-m1003810038eucas1p1M;
        Mon,  1 Jul 2019 13:11:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131155eusmtrp2edc7471d6b24b073583c79efc33480ee~tSqQ9wQRL0788807888eusmtrp2E;
        Mon,  1 Jul 2019 13:11:55 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-df-5d1a069b4488
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.EA.04140.A960A1D5; Mon,  1
        Jul 2019 14:11:54 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131154eusmtip1fba7469971607afadf65bde5a40b0d11~tSqQA8iKX2804728047eusmtip1T;
        Mon,  1 Jul 2019 13:11:53 +0000 (GMT)
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
Subject: [PATCH v11 6/9] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Mon,  1 Jul 2019 15:11:35 +0200
Message-Id: <20190701131138.22666-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSZ0xTURjl9k2qxWcx9hNXUjcqDtBcRwQSTV5c0fADoyFa5AWItGgfKKjB
        KnFTNDUqggRwBGSVUWXEsBUDSEVRlCEGElFAFKEYByrl1fjv3DO+892byxLKLsqNDdVFCHqd
        JkxNy8kHj783Lk2i3QKW3zV54vwEM4VbhnsonFLTSOGswW6EY2+baXylLlmGGy5q8aXuPgJb
        rXkMfnqqn8Gthhl4MO4thV+U3qTxkLEG4QRrmQzn1HQwuKluE247mUHj6v6zFP79Kp/E5c2b
        cdtPFzzypAv5qPgRm4nkP78+zfBJhiaSL0nsYPiCzPM0X56czfDG2AGarxx4KOPjLZmIL6w/
        xg8VzNoxYbd8fZAQFnpY0C/bsE8eUvfIRhxsoKOaU23IgCzUBeTMAucFOT2d6AKSs0ouA0FJ
        fDxjF5TcMIKs0ROSMITANFJJ/ksUxd8gJCEdwUfzN0Y6jCVONb8cc7EszXlAceYhe2AKl4Ag
        6YOf3UNwRQR8amtHdsGV84PPLQ3jdSQ3D4pexI03KDhvOJt9hpDaZkNWXsU4duZ84Lmtg7YP
        As7IQlqK2bHSRrjfmujArtBba2EkPAP+lKTIJCyCwZiGJHwcui8lOzzroLq2ibIvTXCLwFy6
        TKJ9oaJxdPwuwLnA60+T7TQxBk0PrhMSrYBzZ5SSeyFY4p45iqZCevY1x3Aeinvek9LzXEHQ
        Z2ghL6PZif/LUhHKRCohUtQGC6KnTjjiIWq0YqQu2GN/uLYAjf28+t+1tmJU9iuwCnEsUk9U
        GNohQElpDovR2ioELKGeoijPmBagVARpoo8K+vC9+sgwQaxC01lSrVIcc3q3R8kFayKEA4Jw
        UND/U2Wss5sBha0soTaFL+i8EzXXW5W72G3Ozug3Mbd8+4ZGmydZf5jcff1jvmzp9brxM8pF
        7ntdljjTM33rtltRLUHnnDy8nQLeq5y+lfv0ybOvFg7Mj1i13TPX2B7q3rV29en78/YSIeY1
        IaaL9Rml1l1LCmOHd/T7m2RNlq861zvDFXk+Ffvu+QWqSTFEs8Kd0Iuavx5UxVd1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qz2KRiDb59s7LYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        yzh19CtzwRm2iisLvjI2MG5h7WLk5JAQMJHY3jeTuYuRi0NIYCmjxKT3y6ESYhKT9m1nh7CF
        Jf5c62KDKPrEKHHp7jvGLkYODjYBPYkdqwpB4iICcxglfnZtYwRxmAXOMkvsXvGGCaRbWCBQ
        Yu+zB2A2i4CqxPbLPSwgNq+AvUT7mjZmiA3yEqs3HACzOQUcJC59vcsGYgsB1axbfINxAiPf
        AkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFxuO3Yzy07GLveBR9iFOBgVOLh1bglESvE
        mlhWXJl7iFGCg1lJhHf/CslYId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4Hpoi8knhDU0Nz
        C0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MG9XO6e7V1lvzdkrSGg2TD1du
        ZQffzw5nMNS8t0VOs/zKief5k1/+Za9Pu636+HDMJf1/Sx9Yrw24Exa1qLjM7cWDA0lHXy4T
        XVDNyPNyAuN0pdeePgZaelU1c/M+rl0Y++7JGzG76+bFax8U582KncQu9nMav1gYN/ciEdHZ
        spsPRT3REpSoUGIpzkg01GIuKk4EAPVNaMfZAgAA
X-CMS-MailID: 20190701131155eucas1p1f51297a17dd902fc431f62234ef5e677
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131155eucas1p1f51297a17dd902fc431f62234ef5e677
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131155eucas1p1f51297a17dd902fc431f62234ef5e677
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131155eucas1p1f51297a17dd902fc431f62234ef5e677@eucas1p1.samsung.com>
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

