Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36438D1D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfFGOfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:35:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50197 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfFGOfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143538euoutp01c9f0020397f886675650cbd4faa3b290~l8Ugn6Oss0083300833euoutp01J
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143538euoutp01c9f0020397f886675650cbd4faa3b290~l8Ugn6Oss0083300833euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918138;
        bh=Rv+G7xRM5W0qIJMO/1XEZpXdtXED3pTULKiTBpTxK9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYGFLDasg8KeRKbSisv3QIe9uJvu9yhLqz3GNo1H4cIUbiqdxSJuV6v2O5WXmPGY/
         AhaEBtS2U2sGdgyDdseNI7YKQcw5+NCQ3pqDp96SK3nG13VZ2+e7r+TFLnizsdrMId
         KN91ymYnHy7r47KI9Di4ZhqbhzEOaRtRcqU3Uebs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143537eucas1p1d4078ed500ef168bce00f1b7bf4f12c4~l8UfulZtU1838418384eucas1p1H;
        Fri,  7 Jun 2019 14:35:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.B3.04298.8367AFC5; Fri,  7
        Jun 2019 15:35:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143536eucas1p2192a9061b835502ada88262ef427ce8a~l8Ue33_As2698526985eucas1p2q;
        Fri,  7 Jun 2019 14:35:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143536eusmtrp16f054f06c43cb13eaba0140ebba26a00~l8UeoNpxL1284512845eusmtrp1j;
        Fri,  7 Jun 2019 14:35:36 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-99-5cfa76382cb8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.D0.04140.7367AFC5; Fri,  7
        Jun 2019 15:35:35 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143535eusmtip18e3f7879766c3a862c64d0d0f3ba6c69~l8UdsELSJ2929529295eusmtip1E;
        Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
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
Subject: [PATCH v9 13/13] ARM: exynos_defconfig: enable DMC driver
Date:   Fri,  7 Jun 2019 16:35:07 +0200
Message-Id: <20190607143507.30286-14-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUxTQRSGnd4VtORaUSZupE1I1ChIADO4r+FGXyA+GBGjBa+lgYL2Ql3w
        oUoUi1SMLKJAQNGgBYPWWsEQwEpEQCmLkU0UxASRRRAwolhse6u+/fOf7585Z2ZoTNJLLKaV
        cQmcOk4eKyPdcfOL6aY1SPMzYu2YMQg9zCkjUPvkAIEKapsIVDLeD1ByURmJMhryRejVJRVK
        7x/CkNX6gEKvzw1TqEu7FI2nvSdQ29M8Ek3oawHKsVaJ0P3aHgq1NOxC3Wfvkuj5cAqBbG8f
        4qj6zW7U/csDfX/5EWz1Yr9PXcXZrx3nKTZX24KzFTd6KNZo0JFsdX4pxeqTR0n22WiliL1s
        MgD2UWMSO2FcHjo33H3jES5WqeHUfpsPu0ebGyrJY2PEyanrnbgWZBOpwI2GTCDUp7TiqcCd
        ljB3AcxKbiaFxSSA41mzrsoEgI+sXfYI7Yz0W6WOtIQpBtB8J/hf4N4bM+VgSMYXlhuOOxhP
        JgfA3M97HQzGPMHgSPc74CgsYLbD4pIBzKFxxgemzOY4fTGzFX6ZnQZCe96w5EGNk3Gz+7nm
        cmd3kNHTsL7S5JphJ9S3WClBL4Bf6kwuvRQ2ZqThguahVn/TtekZ2J+e72I2wOd1Lc7BMGYl
        LHvqJ9jbYLL2l2teD9gxMt9hY3Z51XwNE2wxvHhBItAroCmtWSToRbC4NJsSEBZm2qKE28kA
        cKjwgugK8L7x/6xCAAzAi0vkVQqO94/jTvjychWfGKfwjYpXGYH93zXa6r6Vg6nWSAtgaCCb
        J2ap6QgJIdfwp1QWAGlM5inWNP+IkIiPyE+d5tTxh9SJsRxvAUtoXOYlTprTe0DCKOQJXAzH
        HePUf6si2m2xFsRL9/3+FD6k3DI5GHZ+jWSMMLJhSXJ/qf05TOqM0JlNP3XS+ABYpAs8G9ge
        Yjxom11ZnW6wcKtDIrsvznyQBvWheTsq9t/X+NRk7jnZUdN3VBcckP+4oLOqfszjtmqZUawc
        XHhrS3Pewc21w7q2tqnsmHVmTpGnezyzPtNm6JThfLTcfxWm5uV/AFZEY71zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7rmZb9iDJZMs7LYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9h2ag9bwQfWiq8zb7I0ME5j7WLk4JAQMJF4fF6xi5GLQ0hgKaPE6lP7gOKcQHExiUn7trND
        2MISf651sUEUfWKU6Gz6xgjSzCagJ7FjVSFIXERgDqPEz65tjCAOs8BZZondK94wgXQLCzhJ
        LF/9nBnEZhFQlWj/P4MRxOYVcJB49f8nI8QGeYnVGw6A1XACxWdv28EGskBIwF5i1XOHCYx8
        CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG4LZjP7fsYOx6F3yIUYCDUYmHdwbTzxgh
        1sSy4srcQ4wSHMxKIrxlF37ECPGmJFZWpRblxxeV5qQWH2I0BbppIrOUaHI+MD3klcQbmhqa
        W1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgNBCfsqLHa/+vThku58qpubs/
        zpKO/eu7cVXVsspHm1bOKlWb/WJ51VndmBlV8nyG/mFrfwVtCU2SO255XvWt+AzVC69PtGbz
        Bljd2fp+bdvWT6UmLjUb/iUl/rkx7cqZ+nulJUqXapLVgvy+lCk7CrQ3aHv+5zaa6qW8a7vD
        anGRp4XrVxtFKLEUZyQaajEXFScCAHlofL3XAgAA
X-CMS-MailID: 20190607143536eucas1p2192a9061b835502ada88262ef427ce8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143536eucas1p2192a9061b835502ada88262ef427ce8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143536eucas1p2192a9061b835502ada88262ef427ce8a
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143536eucas1p2192a9061b835502ada88262ef427ce8a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable driver for Exynos5422 Dynamic Memory Controller supporting
dynamic frequency and voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index c95c54284da2..0cd16c924941 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -290,6 +290,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.17.1

