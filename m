Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F567361E1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfFEQyd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51467 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfFEQyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165431euoutp028df05db9504a8e121ce7fc15b1cc9e29~lW7M_5KLY3044930449euoutp02G
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190605165431euoutp028df05db9504a8e121ce7fc15b1cc9e29~lW7M_5KLY3044930449euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753671;
        bh=XyFjfR/cYrCTH0M0iV/FnYwEiiDKK2JrkvAOocEhoto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij9ydd0qVzUnA9Ek+gtYZMA1yelJGFZS8tI46bKppto8Hh4KoJxG4xNuyBbBI9AbG
         1McVhaul9Mtwhzu5Q2lCY3eQf1TXs0dq4UrcFOE5CcfSjB2EJM9VJtpCMQd7ehQ9s8
         quBsTsf03hZnX35+mLAIQsdmAmH1fvG5gX3l8HOQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165430eucas1p1bb87fda58806139834a725083dcb83c6~lW7MB787E0347003470eucas1p1X;
        Wed,  5 Jun 2019 16:54:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.A9.04298.6C3F7FC5; Wed,  5
        Jun 2019 17:54:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3~lW7LOTs910084800848eucas1p2T;
        Wed,  5 Jun 2019 16:54:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165429eusmtrp2781ed2becf57084265aed84a55b7bdfb~lW7K_vRo92868028680eusmtrp2K;
        Wed,  5 Jun 2019 16:54:29 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-06-5cf7f3c6fb52
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.B2.04146.5C3F7FC5; Wed,  5
        Jun 2019 17:54:29 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165428eusmtip117ed547712691d0faf5bfeff28c39383~lW7KEMtIF0289902899eusmtip1Q;
        Wed,  5 Jun 2019 16:54:28 +0000 (GMT)
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
Subject: [PATCH v8 03/13] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Wed,  5 Jun 2019 18:54:00 +0200
Message-Id: <20190605165410.14606-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0gUURTHuzszO6O1Mq2aB5MeG0EPfJXBDaOSxCZBKkKEknTLQSVXbUdN
        0w9rhpVlG0lZpqQYKGvis8VHaLniSqVWmlYqlRuEpmbuqD1Mc5utvv3Ouf/H5XIZQmmi3JnY
        +CReG6+OU8kdSWPH927PDutcuM90JYFrblVReED8ROG77d0UrvhqQTjvSZEMP7uswXrLZwL3
        9FTTuOvcOI3f6jxwb1OhHFtz2xG+1dMiw5XtwzQezCyXY9P4BQq39gXjwZ9OeLZzBO115mZn
        rpPcHd0LkmssGKa5WsMlOZebNSnnHk8+lHFX6w2Iq3uazllr1xxyOOq4K4qPi03htd67Ix1j
        JusekIktbGr/jSFKh/ROOciBAdYPMosGUQ5yZJRsOYKZ5mZaGkQEJks7JQ1WBD39euKv5Y65
        za4qQ9BsnSb+WVrm3yyFMYyc9YIGw2mbwYVNh6GB1j8agh2XQdePb6RN48weBnEq2KYh2Y1Q
        XqFHNlawe+CDblYula2FiupHf4od2L1w01xHSvsRGs4P7ZM4EHLzemmJnWHMXG9nD1hsvCuT
        WABdbgmSOAMs+iK7xh9M5heU7ToEuxmqmrxtCGwAXHy1Q0IneD2x0iYmlvC6MZ+Q1gq4mK2U
        MjZB/ZXn9p5VUHb/pj2bg5kJs1x6mzwEYwvZ9DW0tuB/VzFCBuTGJwuaaF7wjefPeAlqjZAc
        H+11MkFTi5a+1tMF83QDmnl5og2xDFKtUEDNXLiSUqcIaZo2BAyhclGoB8VwpSJKnXaW1yZE
        aJPjeKENrWZIlZsifdn7Y0o2Wp3En+L5RF7791TGOLjrUBVsNepDA8PEs9V+h77qji+Llk3P
        TVkiwzKMrgfR4p7AAPbLu1TjsLbQ95csmN5/ZEOnf7Z4an2CGHqipM+jYD4kYHtxyIqyoGuK
        jvPN1qCkoNJ7xZ4xfj4l3Kj3zonl2w64PEq6nR/VsS5r1BQbWZcjcs8iPqZ5iK6G0vR8TYCK
        FGLUvlsIraD+DV//tmJWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7pHP3+PMdiykNti44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHebt7IU7BOouDb1DmsDYz9fFyMnh4SAicTs44fY
        uxi5OIQEljJKPDxykhkiISYxad92dghbWOLPtS42iKJPjBKdF++ydDFycLAJ6EnsWFUIUiMi
        UC/R/+YSWA2zQAOzxJrtV1lBEsIC/hKLOqeDDWIRUJVYsbqfEcTmFbCXeNjwjQ1igbzE6g0H
        wBZzCjhITDu+mQXEFgKquXT9N/MERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNp
        27Gfm3cwXtoYfIhRgINRiYdXYuP3GCHWxLLiytxDjBIczEoivIm3v8QI8aYkVlalFuXHF5Xm
        pBYfYjQFOmois5Rocj4wzvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQx
        cXBKNTDy3zlwPz7kVUrq1pqFz62qWQQtevm4XGwZyr+sqww/qnUm9eDmo8aFkrF+ezyWxnyr
        dxE4wrVLpE6DxfF2+uWTXbKTJTaH7G0stpO59iDJu/Fhho7tilXZmp6TFFuleWLuyMYkzt+/
        95/7pLAZW/co7rjgqaPjYLbF9ab4gzdCYccWGl7TFVViKc5INNRiLipOBAC5c6XEuwIAAA==
X-CMS-MailID: 20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165429eucas1p224e803c851c9fd28e3d8737392a8a5c3@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index eecbfcc6b3cf..7ba6bf6700b2 100644
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

