Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4750A97753
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfHUKna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35693 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfHUKn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104328euoutp02c94c7fe877147ccb9b855bb482d0def3~86iOBYt6H0339203392euoutp02P
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104328euoutp02c94c7fe877147ccb9b855bb482d0def3~86iOBYt6H0339203392euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384208;
        bh=WNEl3Tg78F0IeuBzIomZpFxDfnKkZ4Oivfi2xCmRXSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkGGS6wIqehm1W8fJcgztS1DdWo1owyLwopmVJdle8AB/sE3VzeuyosA4ojbDumrT
         D/uvIlD/ymBW5wWezvScB+GJBPzuRlq4iJ5fidxu19/+CCzCQ63oj+C9ZBrvCiKWGt
         8as2ib05983dmMyCCeK9gNouMnlXL5XPie6k3FA0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821104327eucas1p21f49a607327c0981a477b74fdf560cff~86iMs573g0902309023eucas1p2K;
        Wed, 21 Aug 2019 10:43:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.48.04469.E402D5D5; Wed, 21
        Aug 2019 11:43:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906~86iL2KyH90917909179eucas1p1Z;
        Wed, 21 Aug 2019 10:43:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104326eusmtrp2075e87e6d1380e7694de89786cd77d6f~86iLn8F_k2827428274eusmtrp2J;
        Wed, 21 Aug 2019 10:43:26 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-38-5d5d204e7dcb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0F.A6.04166.D402D5D5; Wed, 21
        Aug 2019 11:43:25 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104324eusmtip24bfb5fa911274810401b3b87b8b017d0~86iKf58ZG1735217352eusmtip2s;
        Wed, 21 Aug 2019 10:43:24 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v13 8/8] ARM: exynos_defconfig: enable DMC driver
Date:   Wed, 21 Aug 2019 12:43:03 +0200
Message-Id: <20190821104303.32079-9-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3Z2Lg4nxxn5lVIxClTIMgy+6GaUcCoIMSrSlk49mOWW7XjN
        LjNRy7Jkdhnl3cyYllfKxDLncKXZUjNv2U3CTJvoUtJA83Ss/vt97/s87/Py8lGYzIovoyLU
        0axGrYyUExLxw+Zpy5q9KxWKdd9nvFGlvhxH3T+GcJRneoWj0vFBgJKLygmU1ZIjQi8vqdDV
        wREMWSwVJGo7P0qiPq0rGr/8HkedddkEsmWYANJbnorQfdMAiYq720WovcUX9SfdI1DKExOJ
        mkbTcDT7tlKMGt7sRv2/HNDU88/AZylTllsGmKlJnZgZ60khmdvadjHz+NYAyVQZLhJMQ04Z
        yWQkWwmm0VovYq7UGABT3ZrI2KqW+9kHSDaHsZERsaxm7dZgydHqqS4QNYbHTzQU4lpwHU8H
        dhSkvaFxvEmUDiSUjL4HYGHqV0x4/ACwLV9P8ioZbQOwrmTTX8ed3PO4ICoB0JzSiv9zTNe3
        iNMBRRG0J6w1nOQNi2k9gLe/7uM1GP0Jg1fuZwO+4URvh7aCLzivF9OrocG4ni9L6W2wta+U
        FMJWwNKKZxjPdrQPnM188ScL0gUU7M4cwQTRTjjz6jUhsBP8Zq5ZMLvCucd5IoE5qM0oAAKf
        hoNXcxY0m2CTuf3PDhjtDsvr1vII51cbbXYR0AH2fHfkxdg86h7exISyFF5IlQkz3GDN5dcL
        OUtgSdmNhdkMvDZWTQgXzAKwK9kvE6y49T8qHwADcGZjOFU4y3mp2ThPTqniYtThnqEnVFVg
        /he2zponasFkR4gR0BSQ20trewMVMlwZyyWojABSmHyxND47QCGThikTTrGaE0GamEiWMwIX
        Six3liYu+hgoo8OV0exxlo1iNX+7IspumRYEjXzKHzZ3YsNz9p0GiX+I488ko867Yki/68G5
        xrwPzbtMcdv8RW2TRUW9SWNqlfOQ683naYkRL/YfSOh4hx7pLDt0xYum4ZnDRw5Frw+2WTfq
        AyJ7f4KiZKtCsmrV2eE8h6yTvn61E2ywx5YNU+tO+29PC3U75t6VEHq3ec/B/hi5mDuq9PLA
        NJzyN5TVkhmBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7q+CrGxBts/WltsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GVs/naVseA9a8Wn/YtYGxinsnYxcnJICJhILJnXBGRzcQgJLGWU
        uPn0CyNEQkxi0r7t7BC2sMSfa11sEEWfGCX6up8wdzFycLAJ6EnsWFUIEhcRmMMo8bNrGyOI
        wyzwm1ni4N1+sG5hAUeJzwufsoI0sAioSqw6ZAQS5hWwlzh9azXUAnmJ1RsOMIPYnAIOEv8m
        nAS7TgioZuqGt6wTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzRbcd+bt7BeGlj
        8CFGAQ5GJR7eHTejY4VYE8uKK3MPMUpwMCuJ8FbMiYoV4k1JrKxKLcqPLyrNSS0+xGgKdNNE
        ZinR5Hxg+sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDIVHJg
        Tc+NOoH0r4enbJpcdURY+lvJje1ehnXFR2Li+jf/eaXSHWOwXubthrAbJz07jCZE2co3RByP
        6FN6xP/+7joG75g9Bfn+pof1y9Tn87oe9jPwKzcx+RHO4st3q9H44sZrasysN3MW+S4MXP9Q
        aoLE6TOua02/3K+PvPR1i9y9Ble7BgklluKMREMt5qLiRABiOSnK5wIAAA==
X-CMS-MailID: 20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104326eucas1p1f22b49095a17f0b303910c391ff1e906@eucas1p1.samsung.com>
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
index 2e6a863d25aa..ebed93236a47 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_EXYNOS5422_DMC=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
-- 
2.17.1

