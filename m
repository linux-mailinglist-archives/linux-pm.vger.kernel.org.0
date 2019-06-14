Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2845990
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfFNJx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35857 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfFNJx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095325euoutp013cb0a775c0bf9f877b100aa69380d092~oB-GpKHCQ0866608666euoutp01V
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095325euoutp013cb0a775c0bf9f877b100aa69380d092~oB-GpKHCQ0866608666euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506005;
        bh=3H94DwFFG3R37/yu4OYC3ESOKXTLkDswHp/nkojvINE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0ErruPK/0zY/0G95uBIcx12PNzMgv27m2YL5aDCMOMpLn5+Apcd+OoSE6br7Dswk
         LFwzo0wbsYbpn7qN9WBe58ntn7f3mcwk4ubnZTJ7nJgJsza2O+WV8WRt7XDdomtpyu
         rWtn5C787cwBlzDCvsahGsTWwP56lqwfr6AGQjRM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614095323eucas1p2877af9f0d86c307e99f8f608cdefecf5~oB-FVuVhO0491904919eucas1p2z;
        Fri, 14 Jun 2019 09:53:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.A5.04298.39E630D5; Fri, 14
        Jun 2019 10:53:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614095323eucas1p1312dd7bcc5a25cbb3af28ed0f52dc7a6~oB-Eb0Dy01136111361eucas1p1P;
        Fri, 14 Jun 2019 09:53:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095322eusmtrp2027306f4afec6a1e88d57f67596639b3~oB-EMLNI32148621486eusmtrp20;
        Fri, 14 Jun 2019 09:53:22 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-29-5d036e93987c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.30.04146.29E630D5; Fri, 14
        Jun 2019 10:53:22 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095321eusmtip2e7b6374b4493d1a4e3d17450e10c6cb5~oB-DRv6gO2247122471eusmtip2V;
        Fri, 14 Jun 2019 09:53:21 +0000 (GMT)
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
Subject: [PATCH v10 03/13] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Fri, 14 Jun 2019 11:52:59 +0200
Message-Id: <20190614095309.24100-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0zMYRzHe+77s+PydbV6JLKLoVEasweNGm1f/EP+sKFx9N2J7qr7Vn5k
        c7Tq0IkaWnWq2apdUZ2WLlGuCKmUUiS7OjuNZLpwMtL5Xvz3ej6f949nzx4ak1oIXzpGlcip
        VfJYGSnGax/96FiZo8KiVr1LXYqqcysJ1DfxnkCFLR0EKv9iBSj1RiWJcp7qRejZBSXKsn7E
        UGdnFYXaz45S6LXGD33JfEugF/UFJLLrWgDK7bwvQjdbBinU9TQCDZwpI1HzaAaBfr+sxlFj
        zzY08NMDfXs8DMJ82G9fs3H2c38axeZrunDWlDdIsUbDOZJt1FdQrC51jGQfjDWI2Is1BsDe
        bkth7caFO2btEYdGc7ExyZw6eOMB8eGSBi0e/5k5XlHXLtKAux7ngTsNmTXwyt0h6jwQ01Km
        DEBTdhouHCYANIw3kk6VlLEDWNy3YMYx1NPqcpQCWHRnkvrncIx3TDtommSCYJ0hwWnwYnIB
        zB/Z5dRgzB0Mfhp4A5wLTyYSOtJ//WWcWQLf1TowJ0uYTTBn4AkQ2vxheVXT37k7EwYfFo6S
        wlxHQ9PIIoG3wB7zd0pgT/ihtcbFfnDKVCgSmIcaXbEr8xS0Zuldmg2wubWLcN4ZY5bDyvpg
        J0ImHN66FymgB+z/NNcpxqYxu/YaJowlUJsuFTKWwZrM564eb1hacdWVzcLHV1+5HicHQO09
        M34J+Of97yoCwAB8uCReqeD4EBV3LIiXK/kklSLoUJzSCKb/Xdvv1vE68LX7oBkwNJDNljSt
        F0VJCXkyf0JpBpDGZF6S6xuwKKkkWn7iJKeO269OiuV4M5hP4zIfSYqbZa+UUcgTuaMcF8+p
        Z7Yi2t1XA8TiPW5JRV4ZY6Grw6DNEvBLkeDoNfoHf7iY/ShGH7Hdd0t33/zNi/Py62MDdt+c
        SiGao409P32WVPTOy9sXX35kp/146FTICk5XZYkTjQ9b0yJKWrJKdLaCkvcNY9bJRPVlm8LU
        3zxnneFj+fprWq+RreGB1WuLJh320zpvm1uADOcPy0MCMTUv/wN40tH5cwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qT8phjDV4s0LbYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y1i2p4Ol4L1AxZodZ5kaGHfzdTFyckgImEg8vHKcHcQWEljKKLHjRAVEXExi0r7t7BC2sMSf
        a11sXYxcQDWfGCW2fd8I5HBwsAnoSexYVQgSFxGYwyjxs2sbI4jDLHCWWWL3ijdMIN3CAgES
        R/atZwWxWQRUJZ5s+8EMYvMK2EtMvn2SEWKDvMTqDQfA4pwCDhJH578BWyAEVPN9Bv8ERr4F
        jAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNw27Gfm3cwXtoYfIhRgINRiYf3gBVTrBBr
        YllxZe4hRgkOZiUR3nnWzLFCvCmJlVWpRfnxRaU5qcWHGE2BbprILCWanA9MD3kl8YamhuYW
        lobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjn991ZwuLT4FEZLmGbfDBk8+qF
        7Fvczm7dvG2Kdod9uQT7tCqGZbadm789rLEI4rrs23jzyyxXU14W01/sEyV2WhxPKfvwUf79
        lDrPmXqrdcVSt4YF1389+k5O6pD2s/cZVxzkJkw4N83pkWif0ZkmEQZJ40qPyOZSpc7jAprP
        7kj5zDWdZajEUpyRaKjFXFScCACc0kpD1wIAAA==
X-CMS-MailID: 20190614095323eucas1p1312dd7bcc5a25cbb3af28ed0f52dc7a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095323eucas1p1312dd7bcc5a25cbb3af28ed0f52dc7a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095323eucas1p1312dd7bcc5a25cbb3af28ed0f52dc7a6
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095323eucas1p1312dd7bcc5a25cbb3af28ed0f52dc7a6@eucas1p1.samsung.com>
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

