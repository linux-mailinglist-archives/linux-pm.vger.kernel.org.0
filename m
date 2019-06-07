Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0838D34
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfFGOgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40486 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfFGOff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143534euoutp0219900d8f99903366f6cb30a7d42d5164~l8UdGQOVn0264302643euoutp02E
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607143534euoutp0219900d8f99903366f6cb30a7d42d5164~l8UdGQOVn0264302643euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918134;
        bh=UBJ3ezgLAW9CV2O9TqzTmKdZoxg8g/WoDRJ0caW6E6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unWdWA/2a6FBnEUJyifrNFWL0u/QRs6chTqUdKqXtiZQr1U60iK41BRnzPL4oyn/3
         p/ZEJR614kMTsw9YCEDl4HqkcOTOFYbSG81YraGMkiS9Yoc0G2LSyUyxwwwEjP1KtK
         +pi9/nHSUD0sWpIsRhbuFjnY6myUEI8aop3NQMdM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143533eucas1p17961cf9fa03c5437ed119d221c90d420~l8UcNswX80691606916eucas1p1S;
        Fri,  7 Jun 2019 14:35:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.D0.04325.5367AFC5; Fri,  7
        Jun 2019 15:35:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143532eucas1p275590080c3b1ce9e2ce90f5b5da9be60~l8UbThlvA2700727007eucas1p2Y;
        Fri,  7 Jun 2019 14:35:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143532eusmtrp26c81e46d1ff93924eb4341dc7d621170~l8UbD2WYh1494514945eusmtrp2A;
        Fri,  7 Jun 2019 14:35:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-9f-5cfa7635db46
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.56.04146.4367AFC5; Fri,  7
        Jun 2019 15:35:32 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143531eusmtip12623c0d36f31dc8b201fd56a4d004d3e~l8UaGmrGx2464524645eusmtip1Y;
        Fri,  7 Jun 2019 14:35:31 +0000 (GMT)
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
Subject: [PATCH v9 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
Date:   Fri,  7 Jun 2019 16:35:03 +0200
Message-Id: <20190607143507.30286-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0zNUQDHnft7Vm5+XU1nMXKxIYqwHWMWZX4xW61lLW1c9VPR7XF/dUnY
        FaF0y0qJCi30uq1cvanoIfK4laZ3rGaih6XCDdHtd/HfZ9/H+Z6dHRqTvCWs6YCgME4RJAuU
        kqZ46RO9bu0m5ZT3ung1je6lFhKofeIDgW7WvyJQ/tgAQGezCkmU1JQhQi8uyVHCwBCGdLoi
        Cr2MGqZQl2oRGovrI9DrynQSjavrAUrVVYtQQX0vhVqadqLuMzkkqhu+QKDpN/dwVNO2G3X/
        MEdfn/YDRyv262Qizn7uiKbYNFULzlZc76VYbV4MydZkaChWfXaUZB+PPhSx8cV5gL3/PJId
        1y52NfMy3erLBQYoOYX9toOm/lWxh0P05PGGF5coFZgiYoEJDZmN8Eb+F8rAEiYHQF3Dvlhg
        OsMTAGoLWo3GOIBND7C/hdzEbFIIZQNYk5FJ/WvomqPxWEDTJGMHy/NCDQVLJhXAtEF3QwZj
        yjA40t0DDMZ8xhV2REeJDHmcWQFTp10MsphxhAPPWo1jS2B+0aNZNpnR00rLZ4chE0ND3WgU
        KYScYW1FFSXwfPipsdjIi+DvipsigXmoUmcCgU/CgYQMY2YLrGtsIQx3wJhVsLDSXpC3w/Qr
        t2dlyJjDjhELg4zNYGLpVUyQxfDieYmQXgmL45qNQwtgtibFeDgLz50ZwYTXSQKwre8XcRks
        uf5/7BYAecCKC+flfhy/IYg7ZsfL5Hx4kJ+dT7BcC2a+3fPpxslyUP3zUC1gaCCdK2YpvbeE
        kCn5CHktgDQmtRQrm797S8S+sogTnCL4gCI8kONrwUIal1qJI+e82y9h/GRh3FGOC+EUf10R
        bWKtAjbismrJHRuHoa4Hjm1OISuCN1dla3OOlCwNlTckJHnoPdwmn6W3FnZ6ys1yv9dTSo1P
        e1lK0vCQ/qOtJjkzYepuwJpr6Jpt/ynHfnrP0IGoEtyZ6OzhPXc3RtzNqpqX1alettfVwm2H
        y3IH5fma927fnJ6elnC7fg66J3tNt7G2Upz3l61fjSl42R+FK4vWcgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7omZb9iDH4cYrPYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9jblVbwk63i6Jlu9gbGX6xdjJwcEgImEisnLWfrYuTiEBJYyijxrWEdO0RCTGLSvu1QtrDE
        n2tdUEWfGCXOfZsBlODgYBPQk9ixqhAkLiIwh1HiZ9c2RhCHWeAss8TuFW+YQLqFBfwkFr5f
        wwjSwCKgKjHjnydImFfAQeLxyUvMEAvkJVZvOABmcwLFZ2/bwQZSLiRgL7HqucMERr4FjAyr
        GEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNw27Gfm3cwXtoYfIhRgINRiYfXgeFnjBBrYllx
        Ze4hRgkOZiUR3rILP2KEeFMSK6tSi/Lji0pzUosPMZoCnTSRWUo0OR+YHPJK4g1NDc0tLA3N
        jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCGJD/9f5jff6tpUnnInV8bJjvVHnaU
        tQx6sfUf4xmZzk3r2x6oZRWc9YnT3VkTOdVJ/dn1zFlf+ScsCTyjuuV9479WK9urViwn9ONk
        HDzv/pZsTF1280rF1nV21ZOft4ctP5dntDP7wcOdlu9UhD851O3deT9yyuH7vwIPl76ex+28
        asbMiGtsSizFGYmGWsxFxYkA5mc8v9YCAAA=
X-CMS-MailID: 20190607143532eucas1p275590080c3b1ce9e2ce90f5b5da9be60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143532eucas1p275590080c3b1ce9e2ce90f5b5da9be60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143532eucas1p275590080c3b1ce9e2ce90f5b5da9be60
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143532eucas1p275590080c3b1ce9e2ce90f5b5da9be60@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c2ea94957501..ce658c262c27 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.17.1

