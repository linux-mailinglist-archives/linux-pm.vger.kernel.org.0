Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549954596A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFNJxi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35857 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfFNJxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095334euoutp016880922fdb9c449fa4bca4d1875c6e14~oB-PJ0aY10906709067euoutp01O
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095334euoutp016880922fdb9c449fa4bca4d1875c6e14~oB-PJ0aY10906709067euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506014;
        bh=Rv+G7xRM5W0qIJMO/1XEZpXdtXED3pTULKiTBpTxK9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqCvA7AnOuF0NzeOFqalIpglXNfHQQ3WWwIG6iZ6msiSJ6i/AKOqwqmiSNWAkZNvn
         fgGRZfQL9S+kL8iG7/M4FunHo2w2WzMsmNtZw7ytaia3iy/5WHK5xiFAEDh5lOlJgG
         U2euMpzcoydhqmZwBIEOLYug0iSbZNAU/RelzHLw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095333eucas1p177d0ae9f420ce5d8cecf1e16e482e29a~oB-OTXveF1133711337eucas1p1g;
        Fri, 14 Jun 2019 09:53:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.B5.04298.D9E630D5; Fri, 14
        Jun 2019 10:53:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614095332eucas1p10e0a690604c6210d5f61c55175532785~oB-NeZsE11136511365eucas1p1W;
        Fri, 14 Jun 2019 09:53:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095332eusmtrp2350e5e78017c06082698342f7a82df4f~oB-NOsSKg2148621486eusmtrp2N;
        Fri, 14 Jun 2019 09:53:32 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-48-5d036e9dbe90
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.40.04146.C9E630D5; Fri, 14
        Jun 2019 10:53:32 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095331eusmtip287a1b11711375a82978c084705a1a5ad~oB-MTglbl2261522615eusmtip2z;
        Fri, 14 Jun 2019 09:53:31 +0000 (GMT)
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
Subject: [PATCH v10 13/13] ARM: exynos_defconfig: enable DMC driver
Date:   Fri, 14 Jun 2019 11:53:09 +0200
Message-Id: <20190614095309.24100-14-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu7D7VJrct8lCRNAgqSTOCTilRlHAzKDGhqMxW3VRy0+71kWmw
        FT18TEvJTF0rIrJZqHMsLdPlI9d6mD3MNEtcDzU1bSrM6OHcrP++3/f4fT8Oh8YkNmI+HatM
        5HilPE5GeuKmR47nK7RKLHLlRYcUVRaWE+jt2FcC6ZqeE6hs1AbQqevlJMq3akXoaZYC5dq+
        Yai1tYJCz04OUqhTtRCNZn8g0Kt7JSSya5oAKmytE6E7Td0UarOGoC51KYkaB88S6Hd7JY7q
        X4eirp/eaMLSCzb4sBPjeTj7veM0xRar2nC2pqibYg36DJKt196mWM2pYZJ9OFwrYnOMesBW
        PUlj7YZFYV67PYMPcXGxyRwfsH6/Z4zJWksmjBDHxi+/w1WggMgEHjRkVsPezEZRJvCkJUwp
        gB9z9bhrGAPws8ZOugY7gFX5J/GZSP/9SbdwE8AHLSbqX8T4Szu1jKZJxh9W6486A3OZQgCL
        +3Y4PRhzF4NDXe+BU5Aym2DFhdfTW3FmCTR+KRA5sZjZADs/2YGrzReWVZgxJ/aY4pt1g9PN
        kMmgYY3FIXKZNsO+yRJ3QAoHWoyUCy+Ef2p0bo8AVZprbk86tOVq3Z4g2NjSRjiPxphlsPxe
        gIveCF92OignDRlv2DE0x0ljUzDPdAlz0WJ47ozE5V4Kjdkv3EXz4M3bBe7lLJwYGXa/VT6A
        6tp+cB74Fv0vuwqAHvhwSYIimhMClVyKvyBXCEnKaP+D8QoDmPp6T363/KgG4y8PNACGBrLZ
        YvM6UaSEkCcLqYoGAGlMNld8JQiLlIgPyVOPc3x8FJ8UxwkNYAGNy3zEabN69kiYaHkid4Tj
        Ejh+RhXRHvNVwLdntF+Xslu9/Y6l1LxmLbPoSqApY9W6cHNtRcezhL7QG5uLNSHqiI07w17c
        qiuGhzOpAdtQ2/Gf5n220Tf8Yq/H9r4TW6r94o9Kf/Ee6eut0oCY4J5Q69alEWFk+wSD7c1d
        4hduWOaw+ORE7YrwHTPwlmadwyaO35bYnjWZ+kaGCzHywOUYL8j/Av5WhQV2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7pz8phjDWbekbTYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9h2ag9bwQfWiq8zb7I0ME5j7WLk5JAQMJF4ufsXWxcjF4eQwFJGiVXndzFDJMQkJu3bzg5h
        C0v8udYFVfSJUeLu2p1ADgcHm4CexI5VhSBxEYE5jBI/u7YxgjjMAmeZJXaveMME0i0s4Cyx
        YeIVFhCbRUBVYsuzaWBxXgEHiVtPPjNCbJCXWL3hANhmTqD40flvwBYICdhLfJ/BP4GRbwEj
        wypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAKNx27OfmHYyXNgYfYhTgYFTi4T1gxRQrxJpY
        VlyZe4hRgoNZSYR3njVzrBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnAxNEXkm8oamhuYWl
        obmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxr5GP5VA3VUZDA/1NDL7/sYEfdJt
        8iq3E0tW6l7a4X6kT7HJe/dWVxN2U8fzVeICU90lOCzsGO779oXe32nlOcVhYeHv7Zw3nz0W
        vf5XpevLimvuQv08iwLmF4g+nOpds9w4QVRhhdOneLUTN6Wvekzr859ScDXXh79Lz9xEwYNj
        0vOHLy8osRRnJBpqMRcVJwIALtZL0NgCAAA=
X-CMS-MailID: 20190614095332eucas1p10e0a690604c6210d5f61c55175532785
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095332eucas1p10e0a690604c6210d5f61c55175532785
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095332eucas1p10e0a690604c6210d5f61c55175532785
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095332eucas1p10e0a690604c6210d5f61c55175532785@eucas1p1.samsung.com>
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

