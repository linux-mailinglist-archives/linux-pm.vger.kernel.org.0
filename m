Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B945CFB96
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfJHNtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 09:49:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59383 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfJHNtx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 09:49:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191008134951euoutp025ea7aceed115ea7f00f422321998344b~LsCqAFR_43158931589euoutp02M
        for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2019 13:49:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191008134951euoutp025ea7aceed115ea7f00f422321998344b~LsCqAFR_43158931589euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570542591;
        bh=L6jrGOKBnyfCH0sLXoEEAMCWGWvKLLesnLO7aFiGlP0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PTBVEb+xkHqR5ME9pH119lRq/Ei202LrebfL8/M76gAWQ/IYq4Y+MNI8ym9LszFwq
         aHDloHS9AVRT8A9MXNesyCC/nw7CnDRXhH3Ya7mqA+k28xeUz48TKgbaLfOpXmHqtp
         Mzn5cz7qgN1W65EBkZf/n003Wy4k137YW42YBJ6U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191008134951eucas1p2e647b9672cc01a735fe27b502c9d3f03~LsCpqTaP71989419894eucas1p2o;
        Tue,  8 Oct 2019 13:49:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.86.04374.FF39C9D5; Tue,  8
        Oct 2019 14:49:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b~LsCpSvYXp2879228792eucas1p1W;
        Tue,  8 Oct 2019 13:49:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191008134950eusmtrp1f4a5410a8e962016417ab111bb505d5c~LsCpSBZgO0486604866eusmtrp1B;
        Tue,  8 Oct 2019 13:49:50 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-84-5d9c93ff4962
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.7C.04166.EF39C9D5; Tue,  8
        Oct 2019 14:49:50 +0100 (BST)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191008134950eusmtip296671187e8381e8e1458f31035479996~LsCov6rwO0868008680eusmtip2B;
        Tue,  8 Oct 2019 13:49:50 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
Date:   Tue,  8 Oct 2019 15:49:23 +0200
Message-Id: <20191008134923.30123-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87r/J8+JNdj/m99i44z1rBbXvzxn
        tejb95/Rov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHm
        wOOxaVUnm8fmJfUeB9/tYfLo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujFcHPjIXbBeqmDX1
        IlMD40L+LkZODgkBE4kTK9YydzFycQgJrGCUmD77HBuE84VRYsbv/awQzmdGiedL77PAtDSt
        3w6VWM4o8WXCa1a4lnv7JrKBVLEJqEpsmfGSHcQWEVCWmHxvOtgSZoENzBLdiw8zgiSEBdIl
        3rzsYgKxWYAaVrxZwwxi8wq4SNxevg6omQNonbzE4UNZEGFBiZMzn4BdwQwUbt46G2ymhMB0
        dokfpx6yQtS7SExvN4a4VFji1fEt7BC2jMTpyT1QH5RLPF3Yxw7R28Io8aD9I1TCWuLw8Ytg
        c5gFNCXW79KHCDtKvL1/mRFiPJ/EjbeCECfwSUzaBvIWSJhXoqNNCKJaVeL5qR4mCFtaouv/
        OlYI20NiTe8qsGuEBGIl1j3qZJ/AqDALyWOzkDw2C+GGBYzMqxjFU0uLc9NTi43zUsv1ihNz
        i0vz0vWS83M3MQJT0+l/x7/uYNz3J+kQowAHoxIPr0PVnFgh1sSy4srcQ4wSHMxKIrxyS2fE
        CvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamBsvDa7utWM
        j9NV7tOqwx+CNU6vV90r+fvwlZjjynt5WLWs+UqkWSx/pi3mVS7udUisMN4+JfSG/J47C9dK
        fHnntEI199Gl6701O2dwtgfM5j2lrVLA7yimu/WHa5D45VXRUy56zP185ytDlOhhQQ0G950n
        hVr13tx8eN8+sreGJeva+gbNCxOVWIozEg21mIuKEwFek+OtSQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd1/k+fEGmz7YWSxccZ6VovrX56z
        WvTt+89o0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLW43rmBz
        4PHYtKqTzWPzknqPg+/2MHn0bVnF6PF5k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexqsDH5kLtgtVzJp6kamBcSF/FyMnh4SAiUTT+u2s
        XYxcHEICSxkldh8+wwKRkJZoPL2aCcIWlvhzrYsNougTo8Tf639YQRJsAqoSW2a8ZAexRQSU
        JSbfm84MUsQssItZ4uny32AJYYFUiannjzOD2CxADSverAGzeQVcJG4vXwdUwwG0QV7i8KEs
        iLCgxMmZT8COYAYKN2+dzTyBkW8WktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcx
        AqNi27Gfm3cwXtoYfIhRgINRiYfXoWpOrBBrYllxZe4hRgkOZiURXrmlM2KFeFMSK6tSi/Lj
        i0pzUosPMZoC3TqRWUo0OR8YsXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KL
        YPqYODilGhi1Ntx7bmh8t1464eSdXi4XGcV1m33MY2NFQlsMNs9M55aabaDsmNrGWebgu3Mm
        j7yOya3761/elZc39/2qFZc5yYeL5b748sfyF6cc9FKw3f3sCfNefrn6kt+pitFW+1ueVebn
        nP7rz6Fm4707sMrp0kKWwPMntE6tT1P9cK1GLUPnj8SVbiWW4oxEQy3mouJEAGOxeLKgAgAA
X-CMS-MailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
dev_pm_opp_set_rate()") introduced errors:
exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
...
exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)

They are caused by incorrect PLL assigned to clock source, which results
in clock rate outside of OPP range. Add workaround for this in
exynos_bus_parse_of() by adjusting clock rate to those present in OPP.

Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c832673273a2..37bd34d5625b 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
 {
 	struct device *dev = bus->dev;
 	struct dev_pm_opp *opp;
-	unsigned long rate;
+	unsigned long rate, opp_rate;
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
@@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
 	}
 
 	rate = clk_get_rate(bus->clk);
-
-	opp = devfreq_recommended_opp(dev, &rate, 0);
+	opp_rate = rate;
+	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "failed to find dev_pm_opp\n");
 		ret = PTR_ERR(opp);
 		goto err_opp;
 	}
+	/*
+	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
+	 * in clock rate outside defined OPP rate. Work around this bug by
+	 * setting clock rate to recommended one.
+	 */
+	if (rate > opp_rate)
+		clk_set_rate(bus->clk, opp_rate);
+
 	bus->curr_freq = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-- 
2.23.0

