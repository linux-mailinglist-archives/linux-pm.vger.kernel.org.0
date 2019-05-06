Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE114F9F
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEFPMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50055 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfEFPMV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151220euoutp026bf37433352d4caac1e743b12e94edf9~cILa0fzui3023330233euoutp02j
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151220euoutp026bf37433352d4caac1e743b12e94edf9~cILa0fzui3023330233euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155540;
        bh=dbC39dHhZokC+Zaz0CxIqpmaX0JLlXOu8hvQxqLnfeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtoMYkX1ExrI+nFOaTTv4lJTenhOvCtB5cj88GCEEMH5sK/0ean8qnVXQaaMGKM+f
         5gtBaMVF7ObbE+Vhj5QB4fxhMWwN8GAofkvYc9X9UBgrBGk5Bbxsnp3RFzGCA4kdbM
         UY9GxYDzxRZIhEbL3aEwkbkrM0Kv5o97B4ArDSFg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506151219eucas1p1a9dae8b2fa31257c98ec5c9fba6b91b0~cILaPbITd1016510165eucas1p1z;
        Mon,  6 May 2019 15:12:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.A3.04377.3DE40DC5; Mon,  6
        May 2019 16:12:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151218eucas1p1f3bf0b48470595537a893bd0b39e75b7~cILZBYekA2011820118eucas1p1i;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151218eusmtrp236e672c5ad255ffec09c9304fd591767~cILYzW0ZA0409004090eusmtrp2g;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-8a-5cd04ed39ff2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.6D.04146.2DE40DC5; Mon,  6
        May 2019 16:12:18 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151217eusmtip166d04db1fad6bc53dd22f48c755dd3aa~cILYBuLWF3136331363eusmtip18;
        Mon,  6 May 2019 15:12:17 +0000 (GMT)
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
Subject: [PATCH v7 10/13] ARM: dts: exynos: add chipid label and syscon
 compatible
Date:   Mon,  6 May 2019 17:11:58 +0200
Message-Id: <1557155521-30949-11-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87qX/S7EGJy9LWqxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+XQJXxroW/oKDbBVbbp9m
        a2BcydrFyMkhIWAi8fHmJZYuRi4OIYEVjBJH3p9ng3C+MEqcOL6MCcL5zCixZ/YsZpiWBysu
        QCWWM0osufkPoeVv/0agDAcHm4CexI5VhSANIgLVEneu72cGqWEWeMMkcfbXDxaQhLBAiMS/
        HS/BprIIqErcfbIILM4r4C3x6cVjdohtchI3z3WC1XACxf92HGIEGSQhcI9d4vC0R0wQRS4S
        698ugLKFJV4d3wLVLCPxf+d8qHixREPvQkYIu0bicf9cqBpricPHL7KCHM0soCmxfpc+RNhR
        YvOiBjaQsIQAn8SNt4IgYWYgc9K26cwQYV6JjjYhiGoNiS09F6AWiUksXzMNariHRM/pY9Cw
        msco8fL/XOYJjPKzEJYtYGRcxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZi4Tv87/mUH
        464/SYcYBTgYlXh4JzhdiBFiTSwrrsw9xCjBwawkwpv47FyMEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsYpUZ6OV91WfkwxXMn29t5f1tb6kx6tFvZa
        8zbmnGj7G2xkKMtbwyDXE3X8zwvxqoBsrzed8zV9G/iqWz5ZO7efqBPmiXi6m/vl1QqlkteR
        a0+wbc2a84h739vgpQ4JQjYBx7xU3BxThB0k2Cq4f4e1h+18c7DyYkudh9rjSo4tW/Jf95ll
        K7EUZyQaajEXFScCAEMUu/dYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7qX/C7EGJyfzGyxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexroW/oKDbBVbbp9ma2BcydrFyMkhIWAi8WDFBaYu
        Ri4OIYGljBJb3uxlgkiISUzat50dwhaW+HOtiw2i6BOjxPmvkxi7GDk42AT0JHasKgSpERGo
        l+h/cwmshlmggVlizfarYBuEBYIkWt58BBvKIqAqcffJIhYQm1fAW+LTi8dQC+Qkbp7rZAax
        OYHifzsOMYLYQgJeEvs+/maZwMi3gJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmAkbTv2
        c/MOxksbgw8xCnAwKvHwPrC9ECPEmlhWXJl7iFGCg1lJhDfx2bkYId6UxMqq1KL8+KLSnNTi
        Q4ymQEdNZJYSTc4HRnleSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5O
        qQZGn42vJvgd/RSfvVKMlc1ck6mDe6lL7NHnWz9ftcu/Jfhz/f/dr4JPXRZoErl878LS49P2
        9E07/0nyqXG9X7gVC5Ot1GPt4z9bmjzFFp66cGXWEqWT/1evVql+qPRn6lsJpw8931wPBtzR
        mz1jAWOX8Z4vMbYVNw7+EpRZaikj2RD244e9pJXzWyWW4oxEQy3mouJEAKz9DPO6AgAA
X-CMS-MailID: 20190506151218eucas1p1f3bf0b48470595537a893bd0b39e75b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151218eucas1p1f3bf0b48470595537a893bd0b39e75b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151218eucas1p1f3bf0b48470595537a893bd0b39e75b7
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151218eucas1p1f3bf0b48470595537a893bd0b39e75b7@eucas1p1.samsung.com>
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
index 67f9b45..4801ca7 100644
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
2.7.4

