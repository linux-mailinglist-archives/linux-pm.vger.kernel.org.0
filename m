Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC23C90C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHEJTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 05:19:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54173 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgHEJQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 05:16:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200805091613euoutp021a3bdf18ec435f4ca7535a464e714c01~oVH9YmIIl3016230162euoutp02K
        for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2020 09:16:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200805091613euoutp021a3bdf18ec435f4ca7535a464e714c01~oVH9YmIIl3016230162euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596618973;
        bh=UiCY4burw31eX0WgddWD+DELe95NCTyywlbqk5mMtB0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fqaluxcMKD7IHQgcWKQV3KYTrA/LEPWroy4V7/rcHr+uWshkgCsC3AX1va7aazk7j
         yd+6VUsJXnJE7HWpy5igfuBhVDzmMqE+fZaeT2iR+HfxAmkpAoZBneBytZTZIKhc49
         /R9iWaXRaWZMSB8wtXJzMv3WGm4wDB2Wz5ZJQfdY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200805091613eucas1p26ff7229e1d378aa6026beffa778a8a89~oVH9IHzzk0179101791eucas1p2b;
        Wed,  5 Aug 2020 09:16:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.45.05997.DD87A2F5; Wed,  5
        Aug 2020 10:16:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18~oVH8m01qO2393023930eucas1p2S;
        Wed,  5 Aug 2020 09:16:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200805091612eusmtrp290fc50ac46c6fed521ebb8466d7bc885~oVH8mLMT41223712237eusmtrp2p;
        Wed,  5 Aug 2020 09:16:12 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-f1-5f2a78dd73f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.8F.06017.CD87A2F5; Wed,  5
        Aug 2020 10:16:12 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200805091612eusmtip28c92a430366eb8ed83b364fafeb04671~oVH740-1H0273702737eusmtip2A;
        Wed,  5 Aug 2020 09:16:12 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: samsung: Mark top BPLL mux on Exynos542x as critical
Date:   Wed,  5 Aug 2020 11:16:01 +0200
Message-Id: <20200805091601.11983-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87p3K7TiDS7+kbXYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sli0P33J7MDlsWbeGkaPTas6
        2Tz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEro2leN1tBE2dF2+8X7A2MF9m7GDk5JARMJHYs
        7geyuTiEBFYwSqy62cAM4XxhlLi+ezILhPOZUWLe920sMC3tlxayQiSWM0p8ebCIDa5l/5PN
        YIPZBAwlut52sYHYIgIxEruuH2ECKWIWWMkk8eLUfSaQhLCAl8SDWWeBFnJwsAioShy8Xw8S
        5hWwlVi14hArxDZ5idUbDoDdJCHwmE3i9cR7zBAJF4kLE69C2cISr45vgfpIRuL/zvlMEA3N
        jBIPz61lh3B6GCUuN81ghKiylrhz7hcbyGZmAU2J9bv0IcKOEi1LG8EOkhDgk7jxVhAkzAxk
        Tto2HSrMK9HRJgRRrSYx6/g6uLUHL1yCKvGQuHCmGiQsJBArMWfufcYJjHKzEFYtYGRcxSie
        Wlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZggTv87/mUH464/SYcYBTgYlXh4T4RoxguxJpYV
        V+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalF
        MFkmDk6pBsbYB4+D8pK+Xd3uvKs1ffvvst2124OP6ByzfnLoI+en5/eecBhEqbbe7tge5aYb
        G5zaeEJPKXRzR/d5vwUMa9c49532Mktc9u1V5Mfuf87Fe5O+nijK2jhFdsda56sW7lc+xjQv
        8paYOuWogK7uz2snputIbk/MXJZh+zzrmoRRZlg5d5D8h4NKLMUZiYZazEXFiQAQfldPDAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xe7p3KrTiDSaftLLYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sli0P33J7MDlsWbeGkaPTas6
        2Tz6tqxi9Pi8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1
        J7MstUjfLkEvo2leN1tBE2dF2+8X7A2MF9m7GDk5JARMJNovLWTtYuTiEBJYyihx5dcOJoiE
        jMTJaQ2sELawxJ9rXWwQRZ8YJQ4vbgZLsAkYSnS9BUlwcogIxEk86b4P1swssJZJ4s4teRBb
        WMBL4sGss8xdjBwcLAKqEgfv14OEeQVsJVatOAQ1X15i9YYDzBMYeRYwMqxiFEktLc5Nzy02
        0itOzC0uzUvXS87P3cQIDMttx35u2cHY9S74EKMAB6MSD++JEM14IdbEsuLK3EOMEhzMSiK8
        TmdPxwnxpiRWVqUW5ccXleakFh9iNAXaPZFZSjQ5HxgzeSXxhqaG5haWhubG5sZmFkrivB0C
        B2OEBNITS1KzU1MLUotg+pg4OKUaGEPOKfw2l89hyCv/LvnS6/O6GpmzH31cWKVaOZf47gxI
        s1UNL882MVZ5nd0lIWq24fvsPnn+FXr6Jzof5z09tfsn692Tjx/7V/wUPbkrRWab8l6XyZ8j
        Zkw4/Z3LIeihv2pqZ6y7l1PsEUfeNuMH8ZNSM5dfL1PLPt3jl3ha80eEMktqB2eBEktxRqKh
        FnNRcSIA2lGulWECAAA=
X-CMS-MailID: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18
References: <CGME20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BPLL clock must not be disabled because it is needed for proper DRAM
operation. This is normally handled by respective memory devfreq driver,
but when that driver is not yet probed or its probe has been deferred the
clock might got disabled what causes board hang. Fix this by marking it
as critical.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index fea33399a632..5ef78928938a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -734,7 +734,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX_F(CLK_MOUT_MCLK_CDREX, "mout_mclk_cdrex", mout_mclk_cdrex_p,
 			SRC_CDREX, 4, 1, CLK_SET_RATE_PARENT, 0),
 	MUX_F(CLK_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 
 	/* MAU Block */
 	MUX(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
-- 
2.17.1

