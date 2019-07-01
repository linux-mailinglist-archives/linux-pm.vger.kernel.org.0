Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC65BC80
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfGANMQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57981 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbfGANL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131157euoutp0143bbad96fdeedd00f15cabcc90be1912~tSqTqzcCh2458924589euoutp01k
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131157euoutp0143bbad96fdeedd00f15cabcc90be1912~tSqTqzcCh2458924589euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986717;
        bh=XPlbzfyPq+2tb60F1xt6+L5cVtwUM4v/x4YUlMpHRb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCrJU7jtDGgwrD4KjaH8tR2B15Vb9RliqEogvQ7cyXbWKsgdwy95zGLhlA3FXWgrq
         iNOMn1n76+S9UT2NGNd4VAMngO2oD9DT/HEy7F7/IMQffgWjv0TDNRHVwPuMgbAO9t
         hXxuNBKEqI4NjSep0X/H/5+kZc6+z7CQvKMGHou0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701131157eucas1p2b180e6de8e1dbaeed8b0fadcd23b01c1~tSqS2a2Zm0905409054eucas1p2n;
        Mon,  1 Jul 2019 13:11:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.87.04325.C960A1D5; Mon,  1
        Jul 2019 14:11:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701131156eucas1p2b43f31c138c4afdd8a8cd07bb9d04a20~tSqSHdxZv0905409054eucas1p2m;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131156eusmtrp2f30a8ab7bc5324a759c65690cd51445a~tSqR5S2G-0788807888eusmtrp2I;
        Mon,  1 Jul 2019 13:11:56 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-e2-5d1a069c9bfd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.EA.04140.B960A1D5; Mon,  1
        Jul 2019 14:11:55 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131154eusmtip1b0515db8510e5218f7f1f0d6dbdfffc5~tSqQ7MOtP2637626376eusmtip1f;
        Mon,  1 Jul 2019 13:11:54 +0000 (GMT)
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
Subject: [PATCH v11 7/9] ARM: dts: exynos: add syscon to clock compatible
Date:   Mon,  1 Jul 2019 15:11:36 +0200
Message-Id: <20190701131138.22666-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29k5O1vNjlPyyyJhIVTQVpTwRdKFkk7+qQj6UYiteTBzW7WT
        qWU1q5Uzl6WQ4jQNoca01Lm8dfGeUbqlhYpuUi4wzQtmapmtmmfVv+d93uf5nvd9+UhMMogH
        k3GaM4xWo1BJCRG/6sV3+/p8Ijhqg21Ajipyy3DU83UIR4UtdhyVTLoBulJcRqDsVwU81H5D
        jTLdnzHkcJQLUMflUQHq061EkxkDOHpbl0+gKWMLQLmO5zz0sMUlQJ2vIlB/qplAzaPXceTp
        ruCj+neRqP+HH5p5OQh2BNEz01l8eqJXL6BNuk4+XZvnEtBWi4Gg6wtKBbTxyjhBN44/5dE3
        bRZAV74+T09ZV+1ffFgUHsOo4s4yWvm2o6LjE44e/JRdmGTMvMvXAT2ZDoQkpDZDW/8Qlg5E
        pIQyA1hcYSK44iuA7c5UHldMAThX8AVPB+SC5VE1yfEPAPzRXM7753A1OAiviKBksMZy2hsR
        SOUCaPp00KvBqGoMjvU7gbcRQO2F1xrtmBfzqVDoGnmDe7GY2g478k0Cbr4QWFLesKARUjtg
        17RrYTxIGUhYaPmIcaLd8Krd7DMEwJE2mw+vhL9qC3kcZqHOeA9wOAW6Mwt8mq2wua1zYTOM
        WgvL6uQcvRMWtg4DbmE/2Dvm76WxPzCrKgfjaDFMuybh1GugLeONL2gZfFB6x/c4DfPHG3Hu
        PNkA6h/piVsgJO9/WBEAFhDEJLDqWIbdpGESZaxCzSZoYmXKk2or+PPzXnvapmvA8/ljTYAi
        gXSJWOeEURJccZZNVjcBSGLSQHG9eXmURByjSD7HaE9GaxNUDNsEVpB8aZD4/KL3RyRUrOIM
        E88wpxjt3y6PFAbrgCY6cD5SDz4sCc3xn+1rzWhyZu+rfKxsdog3b3JFC4pUq7uIXdKsWTTc
        vSu04bbEfWfA/OL0hYjwpVPOud2JtDKgcVnSoU+aNKvsy8gBS9j3sPuRaYaJWdU3V9/FLeF7
        KnufpdcCXZcyRSm/dMJQ4vngKf2ZE188N/9kLE4WZZDy2eOKjeswLav4DYwHaPB1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7qz2aRiDTbvsbDYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y3h//jprwTnOit7+eSwNjK0cXYwcHBICJhLrtgOZXBxCAksZJU4eucLUxcgJFBeTmLRvOzuE
        LSzx51oXG0TRJ0aJrdO7WECa2QT0JHasKgSJiwjMYZT42bWNEcRhFjjLLLF7xRuwScICnhJt
        B88xg9gsAqoSd19dYAWxeQXsJc7OmQ21QV5i9YYDYDWcAg4Sl77eZQOxhYBq1i2+wTiBkW8B
        I8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwCjcduznlh2MXe+CDzEKcDAq8fBq3JKIFWJN
        LCuuzD3EKMHBrCTCu3+FZKwQb0piZVVqUX58UWlOavEhRlOgoyYyS4km5wMTRF5JvKGpobmF
        paG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbVImcO9wsRLGadhXzOAudEJ4RF
        +SSXL9fcPyObJ/qX9J+vXeKri2d8svE3CJF3m6vzuJ1nj1lUkaKhyW7bbxe9nLd67NzZzmU0
        cWf9s2mZrnobNtvu5mufu6bg3Kbf2g78n2wLmfquf6zfcDph9m8Z6/Xqy9LqrKfF7t39L7mZ
        y3aFz+dbe5VYijMSDbWYi4oTAY24bwjYAgAA
X-CMS-MailID: 20190701131156eucas1p2b43f31c138c4afdd8a8cd07bb9d04a20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131156eucas1p2b43f31c138c4afdd8a8cd07bb9d04a20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131156eucas1p2b43f31c138c4afdd8a8cd07bb9d04a20
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131156eucas1p2b43f31c138c4afdd8a8cd07bb9d04a20@eucas1p2.samsung.com>
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
index 5fb2326875dc..d153617ff1a3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -173,7 +173,7 @@
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

