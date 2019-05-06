Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A086F14F98
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEFPMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35613 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfEFPMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151220euoutp015f460f4e4c6f285ed4b0648e5fdea164~cILbhD_ID1993219932euoutp01H
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506151220euoutp015f460f4e4c6f285ed4b0648e5fdea164~cILbhD_ID1993219932euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155541;
        bh=KkG3FELvp7hYyME6AQO9B2byb9pT7O9xmiOi/EtQiIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d53NV0AhoOalOHhmJc8uLoX9aDr+Kz45SCW0iU+P0XoCzKX2uTeKh2qr6NqF5QvwS
         LyB4qu/HrN3jDRUh7Eo5I3zRKn3lQKiw+crUYLglazAN9ynxhBm3l6Il4hEL48s31p
         nmQDP2PcP59P74EERtv5yhTb+FZZNz5Vnez7I4/8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151220eucas1p20ccd19179e3284b26bdacd2d7f8c3445~cILat97G31450814508eucas1p2H;
        Mon,  6 May 2019 15:12:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.E1.04325.3DE40DC5; Mon,  6
        May 2019 16:12:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2~cILZ8XjCf1041710417eucas1p27;
        Mon,  6 May 2019 15:12:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151219eusmtrp2d4d981889c14ce9781907d4b1ac72e03~cILZuUENA0466604666eusmtrp2B;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-85-5cd04ed35c65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.6D.04146.2DE40DC5; Mon,  6
        May 2019 16:12:18 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151218eusmtip15991e59e1f91f843d9c6b28dec5aa295~cILYzyJsI3142531425eusmtip1O;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
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
Subject: [PATCH v7 11/13] ARM: dts: exynos: add syscon to clock compatible
Date:   Mon,  6 May 2019 17:11:59 +0200
Message-Id: <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUgUUQDu7czszoor0yr5MFNaSExqrbR4kIQdxLiCmtCfFGrLwXPVdtQ0
        pVaLUvPKrGS9UhNFk12PTMUj1yu8xcjKI1Os8CrzKC0r19nq3/e+k/d4JCZuISxI/+AwRhks
        D5LwjfCajrW+/UNuA94HZmYPo4pMDYGGlz8SKK+tj0Bli1MA3evK4aGeOwqUOjWLof5+rQD1
        xs0J0FuVJRqqz+ajpeQ2gDL7m3iovG1MgEZiS/iode42gZpfytDIDxO0+mISOJvSqyvpOJ2l
        GsTpOvWYgK4sTeDTyTcW+HTLQgOPTqkuBXRVdzS9VGnlITxn5OTDBPlHMEr7YxeM/IYy7wtC
        XxGR31JOq8AonghIElKOMEMVkAiEpJgqAfCdWpkIjDbxMoBNqUk87rAEYNbXLELv0gcKsicJ
        TigGcPhuEfgX6Sh6ulXLp6SwtvSyPmBGRcPR4WZM78GoOR7sXf+O6wVTSgbXphu3ME7tgdrn
        sVsLIsoVqqaaBdyaFXzTl4DpsXCT34jXAY4fF8D8cXPuCqdgUbaBNoUzndWGqCX8XZfH4zAL
        Vcn5Bk8MnErNMXiOwtbOQUJfg1F7oabenqOPw4ZiLcG1m8DX89v1NLYJ02seYhwtgvG3xJzb
        FlYnDRiGdsDiJw8M5TT8HK8RcI+TC+DE2jRIA9bq/2OPACgF5kw4q/BlWIdg5oqUlSvY8GBf
        6aUQRSXY/FjdvzpXakHTz4s6QJFAYixKOzHgLSbkEWyUQgcgiUnMRPIPfd5ikY886iqjDDmv
        DA9iWB3YSeISc1H0tgkvMeUrD2MCGSaUUf5VeaTQQgU8ZIoCV43ycW5uwe4MZ7XUzfOQ1DEX
        t3Q/66LVFerqLXp2uSzVy7xs3ocotEEaauVMMWVVnu8eIwpbd+0cXWyPO9LalVUV8Myp0fe6
        aN9od4mng9orxjnetqJ9Y964XROZVBY9XygN9E8nbOy+3PTMM5axYepPVsy1k9PWwnYJzvrJ
        D9phSlb+B5lMdQFUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7qX/C7EGPRvNLPYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO
        72OyWHvkLrvF7cYVbBaH37SzWuy/4mVx+zefxbcTjxgdhD2+fZ3E4jG74SKLx85Zd9k9Nq3q
        ZPPobX7H5nHw3R4mj74tqxg9Np+u9vi8SS6AM0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4/KMqewF11grvve5NTDeYeli5OSQEDCRWDTnEWsX
        IxeHkMBSRon+I0eYIRJiEpP2bWeHsIUl/lzrYoMo+sQocWbpOcYuRg4ONgE9iR2rCkFqRATq
        JfrfXAKrYRZoYJZYs/0qK0hCWMBL4ufTvWDbWARUJTYcaASL8wp4SzQ83g+1QE7i5rlOsMWc
        QPG/HYcYQWwhoN59H3+zTGDkW8DIsIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwkrYd+7l5
        B+OljcGHGAU4GJV4eB/YXogRYk0sK67MPcQowcGsJMKb+OxcjBBvSmJlVWpRfnxRaU5q8SFG
        U6CjJjJLiSbnA6M8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        o+AEvgOd7mYz3LxuFKhN0Ljme+VTsVy65+63fqdsvBYJee052pYVV2qjmvx76u1Flqu4V/8+
        dePLMt/5yx6LnctdX3hnLYvb68fyU5Te9j15nHy96N/sd6wyn9f+73n9bu5JLe4nu275mr2Z
        dfW7RUaILRPnRpF7bdstF3NGK7d+YxDzidx84pISS3FGoqEWc1FxIgAgNvkTugIAAA==
X-CMS-MailID: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order get the clock by phandle and use it with regmap it needs to be
compatible with syscon. The DMC driver uses two registers from clock
register set and needs the regmap of them.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b31..0a2b328 100644
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
2.7.4

