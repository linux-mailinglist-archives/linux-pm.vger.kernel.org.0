Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6F5BC76
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfGANMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57940 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbfGANMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:12:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131200euoutp010c50c2b8fd3df02b539e7f1d185f6c39~tSqV7UsrR2481624816euoutp01N
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131200euoutp010c50c2b8fd3df02b539e7f1d185f6c39~tSqV7UsrR2481624816euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986720;
        bh=6Yr0cfbNf5pOBz/M7zrCaVD8oUBVDD8thshT1MqD9b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDheMqmD4KeN3kAPIrzzUJ+Ywxh8fp/Jh+nNPcT7/YnR8Ad+obSIHoovW5y9X9Zvn
         KvnP8e36jA+E/WIaxsBBnH00asCay2SZ2IMhj7hMVc+xTJlThP6pulaxwDeSv7Ytn4
         iPVn3fkrUL/pgLGWI2TVSPik+RNUdtXx/WnWlRiA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701131158eucas1p133fc961ac9c32734c5d9cb90da50b96e~tSqUlWEtk0797807978eucas1p1I;
        Mon,  1 Jul 2019 13:11:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.2B.04298.E960A1D5; Mon,  1
        Jul 2019 14:11:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701131158eucas1p2392cc10dfabbd2628c160d0aa3abecb8~tSqT59B7m0924209242eucas1p2g;
        Mon,  1 Jul 2019 13:11:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131157eusmtrp25676b4a56ce3fbb7d8603a47677b6420~tSqTryTav0788807888eusmtrp2W;
        Mon,  1 Jul 2019 13:11:57 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-ae-5d1a069e5948
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.02.04146.D960A1D5; Mon,  1
        Jul 2019 14:11:57 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131156eusmtip14f13b22fca0fc3af7a8f07488f5e180d~tSqSsyDpI2796027960eusmtip1Y;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
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
Subject: [PATCH v11 9/9] ARM: exynos_defconfig: enable DMC driver
Date:   Mon,  1 Jul 2019 15:11:38 +0200
Message-Id: <20190701131138.22666-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7tPzeVtiZ5MFJZFVmpW1IkiFAwuQRD2tJJaeVHRTdvVfAUt
        pVLTfFam+cgi56N8NEyl8knLRzkrU1yGuswyK8w0hmRt3kn/fc73+/2d7zmHQ2OSEcKRDlFE
        ckqFLExKWuN1z4097oWkY8CmwZR1qCa3ikD9v8YJVNT+ikAVUwaAEu9WkSi7s0CEuq/KUbrh
        K4Z6eqop9DJhkkKDKic0lfqBQG8ab5NoOq0doNyeZyL0oH2IQr2de5D+oppEbZNXCDT/rgZH
        TW/3Iv3cMjT7YhR4O7CzM1k4+2PgEsXmq3pxtiFviGJry5NJtqmgkmLTEr+TbMv3JyL2mqYc
        sI+64tnpWuf9S49Z7wrkwkLOcUrP3aesg2815+ARf4gY3Vw2pQJ3iBRgRUNmK0wwaExsTUsY
        NYAZn4cWDAnzC8D+nAjBmAawNOkuuThRaLhPCkYpgPPDbSJhYZrQDv+mUgBNk4wHrC8/ax6w
        Y3IBzP98wJzBmMcY/KZ/D8zGCsYHDnwxUmbGmTWwrmpUZGYx4w11mhlMaHOBFdXNC2xl0l/P
        DC00QyaZhk19lZZL+MIBoxEIvAJOaDWUwE7wb0ORSGAeqtLuWDLnoSG9wJLZCdu0vYT50Bjj
        BqsaPQXZB+r0H3GzDJllcODbcrOMmTCr7iYmyGKYdFkipNdBTarOUmQPSytvWDZn4bi6jBIe
        NBvAT3qfDOCS97+rGIBy4MBF8fIgjvdScNEevEzORymCPM6Ey2uB6eN1zWt/1oOZ16dbAUMD
        qY1Y9R4GSAjZOT5W3gogjUntxE3qlQEScaAsNo5Thp9URoVxfCtYReNSB3H8kuHjEiZIFsmF
        clwEp1x0RbSVowrkrc5rrRw7FOPkb6codna9l9lnsxl/Ol5S7Gd/9DAaLBNv3qDWcW62k598
        u/0f8tjs9f0fqidatAcjjcszjXHx0SPNJTd18WBtuo0/6zcy1ebO+jA5218eWTraHJd7YpvL
        xjHke/RR5IWSkyEdE/tcU0Kfde2IRlvGwi/E2Xbkc1KcD5Z5rceUvOwfq2NeqXQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7pz2aRiDV5uM7bYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y5h5YApLwV/Wigu/J7M3MC5k7WLk5JAQMJGY93gZWxcjF4eQwFJGiTfrjrNDJMQkJu3bDmUL
        S/y51gVV9IlRonP2A6BuDg42AT2JHasKQeIiAnMYJX52bWMEcZgFzjJL7F7xhgmkW1jAUeLG
        y59gk1gEVCW2rX8EFucVcJC4sOUrM8QGeYnVGw6A2ZxA8Utf77KB2EIC9hLrFt9gnMDIt4CR
        YRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgHG479nPzDsZLG4MPMQpwMCrx8GrckogVYk0s
        K67MPcQowcGsJMK7f4VkrBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbnA1NEXkm8oamhuYWl
        obmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRsFQs88h66S+8FSWSXzZ17Q5tI7f
        d6XAA8eFNs5/fsZ/Ffv4as7Mj5H6HvN+XxLpOSFjb3UydUpJi99Gj8TZrj+Kg7d+kfi0+WNp
        1Nfl8rpC2ce6c1RL8tndFR/uYlOY0RH6+67+BIs3rumndr3yMag5e42JXVa293sFJ6vzi0U7
        wo+4J64xUGIpzkg01GIuKk4EAD86CovZAgAA
X-CMS-MailID: 20190701131158eucas1p2392cc10dfabbd2628c160d0aa3abecb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131158eucas1p2392cc10dfabbd2628c160d0aa3abecb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131158eucas1p2392cc10dfabbd2628c160d0aa3abecb8
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131158eucas1p2392cc10dfabbd2628c160d0aa3abecb8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..4e7e52786174 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -290,6 +290,8 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_EXYNOS5422_DMC=y
+CONFIG_DDR=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.17.1

