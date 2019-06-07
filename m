Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F138D64
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfFGOhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:37:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50170 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfFGOfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143529euoutp015b24587eca5d0257aa7fa99fd14d7f0e~l8UYli5kC0173401734euoutp01H
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143529euoutp015b24587eca5d0257aa7fa99fd14d7f0e~l8UYli5kC0173401734euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918129;
        bh=3H94DwFFG3R37/yu4OYC3ESOKXTLkDswHp/nkojvINE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGf9XI7lCZH07DMl4W6WX1aTCLmhlgcyhwZb8A2kki5KyRnO/AU18aVF6uKItM7nC
         jUhwH6lG+U39EkT39MDppflY1AlxqF4jpXsm9pjI1uNRNWTV88T4lpoGD8bIFYw3QB
         jcpipUg/ny9oC7S53r4+6pb/+XA2zSLCJ9cxc4L4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143527eucas1p2112eb8cfae9239238502e1c8f472794b~l8UW3kO6a2699926999eucas1p2l;
        Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.D0.04325.F267AFC5; Fri,  7
        Jun 2019 15:35:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143526eucas1p1b11e7a7bf57b80de893b5b5664d3fa09~l8UV5ltjR1609116091eucas1p12;
        Fri,  7 Jun 2019 14:35:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143526eusmtrp25779065ac77e798cbfe3c469d90351b6~l8UVpzd591498514985eusmtrp2w;
        Fri,  7 Jun 2019 14:35:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-91-5cfa762fe213
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.56.04146.E267AFC5; Fri,  7
        Jun 2019 15:35:26 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143525eusmtip144e7a6414157a416edcac107220d2e37~l8UUvAptN2929529295eusmtip1A;
        Fri,  7 Jun 2019 14:35:25 +0000 (GMT)
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
Subject: [PATCH v9 03/13] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Fri,  7 Jun 2019 16:34:57 +0200
Message-Id: <20190607143507.30286-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHPbtPV5Pb0jypJC2iMtTKgoOGWRRc+iOKoKTsseqmkZu6qyvT
        aCVmDx8tIU0dWpbKXExNbNnDxyxD0ylGik4xlZLKhtkkrVbOu+q/7+/z/X3P93A4NCZ9R/jQ
        p5SJnEopj5WRYrzu5YwlMFg9G7Xup9YLVecbCdT77QOBils6CVQ5OQpQWqmRRLltOhF6fV2B
        ckY/YchiqaJQx6XPFOrX+KHJzCEC9dQXkWgqqwWgfMtzEXrQMkih7rYdaOBiBYnMnzMI5Hhb
        jaOGNzvRwA8PNP1qBER4s9P2mzhr60un2EJNN84+Lhik2Br9VZJt0BkoNivtC8k2fXkqYrNr
        9YB92J7CTtUs273ggHjzCS72lJpTBYcfFceUPb2Cx9uYswZTh0gDnnhcA+40ZDbCxmyj6BoQ
        01KmAkDd2DQQhm8AdlgzMWGYAtBRasX+RvR3ZwjBKAdQW1xJ/osUDL2bc2iaZIKgSZ/gDHgy
        +QAWju917mDMIwxODFiB01jM7IHaFxmkU+PMSpjdNY47tYTZAq31TSKhzR9WVjXON7szEbCw
        zkQKXEvDPFOqoLfDEdt1F18MP7bWUoL2g78fF7vO4aEm6w4QdCoczdG5dsKgubV7/s4YswYa
        64MFvBUW9ZdQTgwZD9g3sciJsTl5sy4PE7AEXrksFbZXw9rMLlfRElhuuOVKsrBnjBceJxfA
        X9WF4AbwL/jfVQKAHnhzSbwimuNDlNyZIF6u4JOU0UHH4xQ1YO7jtTta7Sbw/OexZsDQQLZQ
        wlIzUVJCruaTFc0A0pjMU6Lu+h4llZyQJ5/jVHFHVEmxHN8MfGlc5i1JcRs+KGWi5YncaY6L
        51R/XRHt7qMB+Y7htYfsr9p1F448PPT10cFn9tR9dg9jwvvjWsOisvjAcMOmiYCW3vTDfbeJ
        Vnz4vrExJ0wpGulX+fYlz1q5FX6/vAzNIXf0LBcasm1/3HLaHCAOW94b5ec4eUGt3OBp9l9l
        S8Y7OyPvFV3adaPKOzSy7Z7N7fxY6HjprfC8pdtkOB8jXx+AqXj5Hyqhu/90AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7p6Zb9iDP7dEbLYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y1i2p4Ol4L1AxZodZ5kaGHfzdTFyckgImEisWvSTtYuRi0NIYCmjxNVJ71ghEmISk/ZtZ4ew
        hSX+XOtigyj6xCjRveETUIKDg01AT2LHqkKQuIjAHEaJn13bGEEcZoGzzBK7V7xhAukWFvCX
        uH/3CSOIzSKgKtF34QULiM0rYC9xZ9dBJogN8hKrNxxgBrE5BRwkZm/bwQayQAioZtVzhwmM
        fAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERuG2Yz8372C8tDH4EKMAB6MSD68Dw88Y
        IdbEsuLK3EOMEhzMSiK8ZRd+xAjxpiRWVqUW5ccXleakFh9iNAW6aSKzlGhyPjBB5JXEG5oa
        mltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYORqEN5oVpvV9Mf7RLjzU4Ep
        ryfMzvbg+GkluVO2fVtUwZyfp0pLXaznBlyJPBczI9V9XaiZTaqk3q36N6rnP3DemFlcF3H3
        dUahqBlPa4cn/9TOP6tTKh7tmXx7pfehdXLfM+dd+35Wt7/n74Ef5ap525Z+X2t9eP6cbXNO
        LXnSxRpQzCL9ul+JpTgj0VCLuag4EQD7rk4M2AIAAA==
X-CMS-MailID: 20190607143526eucas1p1b11e7a7bf57b80de893b5b5664d3fa09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143526eucas1p1b11e7a7bf57b80de893b5b5664d3fa09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143526eucas1p1b11e7a7bf57b80de893b5b5664d3fa09
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143526eucas1p1b11e7a7bf57b80de893b5b5664d3fa09@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 514e16310227..16ad498e3f3f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1334,6 +1334,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1476,9 +1487,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 	}
 
+	if (soc == EXYNOS5420)
+		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+	else
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
+
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(ctx, exynos5x_fixed_rate_clks,
-- 
2.17.1

