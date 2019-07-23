Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8802A7181A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfGWMVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:21:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57700 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbfGWMU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122025euoutp0298e56fbf7b0c71fd2b234dff8a248378~0CJl_BSpz3179531795euoutp02T
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723122025euoutp0298e56fbf7b0c71fd2b234dff8a248378~0CJl_BSpz3179531795euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884425;
        bh=acZs1C2PRXwgbejpkVZ0Vnfcq1LUt8CLhBHrsSuxE7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX7wFcfx5NUSBYQhVLs/QbIJFXdyxKVOYVo4VWrMZmJtYiEGHc024I31M0hi56c9b
         scmOX1QseG5IPTlABKDVvx3WavUfZRYNACLiippBPKXDo/mVnYKCiVqbsMYbfcGCb5
         Uu7LCBqDbSj45xVpQ2MS60KmrSXlIvJxA+a6E+b4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723122024eucas1p26984f8d4bb6c97f37d8fc6535c0a4820~0CJlDQ9ta1104811048eucas1p2X;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.5B.04298.88BF63D5; Tue, 23
        Jul 2019 13:20:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8~0CJkXbnIu0081400814eucas1p1U;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122024eusmtrp18f9c48318e32cff566cc8092b45ff466~0CJkWtNwe2491824918eusmtrp1V;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-7a-5d36fb888d8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.41.04146.88BF63D5; Tue, 23
        Jul 2019 13:20:24 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122023eusmtip253ad15b0f5b4c58cad1e29511fa48b91~0CJjqaCxF1612616126eusmtip2J;
        Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 03/11] devfreq: exynos-bus: Change goto-based logic to
 if-else logic
Date:   Tue, 23 Jul 2019 14:20:08 +0200
Message-Id: <20190723122016.30279-4-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj281x2Zi6P0/LFwmggqOCNTA9lF0Nh0h/7UeRMaulhijptx0tq
        kGXZNCsvkWY3kVCbeGleUNOotWZhOXRlkqmBhTdMzUuUWG0eLf89z/s8z/e8L3wUJjYSzlSs
        MplVKeXxEtIGbzH87PFUL/tH+rRNeDI6Q7OAeVxaTzAfFsYI5oG+h2DeLc6QTEmnlmSKRgpw
        xmhsEDDa0X6CMbXfJZn5a3rElBqfWjO1+iEBM3ihmmRKiyfIg3ZSrSaXlH7q7yClI1e7rKWN
        D89Ln3/rsJZeb9Ig6bzWJUwgswmMZuNjU1mV9/5TNjF1tWN40tyms+//dGJZqEKYh4QU0H4w
        XdUgyEM2lJiuRvCmaArxZAHByPIzjCfzCHpKpsj1yOyrFsKCxXQVArXW5V+ic+4RsggkHQr5
        ha2ERXCk9QiKy2dwC8FojZn8aFl1OdAyGB6tWsU47QqagaVVLKKDYOh+DeLrdkBNg2UPISWk
        D0Heyysk77GH17e/4BaMmT3ZzXdWdwV6TgDLw7MYHw4Gg+bX2kMOMNnVJODxduguzsd5zMHX
        thGCD2ch0Fbq18J74UVXr1mgzA3uUN/uzY+DoK+1DVnGQG+GgWl7fofNUNRSgvFjEahzxDz0
        gPLlCD4IcLGmf80hhZu5AQVoZ9mGW8o23FL2v7UcYRrkxKZwCQqW81WyaV6cPIFLUSq8ohIT
        tMj8zbp/d31vRYt9p3WIppDEVtTQsTtSTMhTufQEHQIKkziKjmT5R4pF0fL0DFaVeFKVEs9y
        OrSNwiVOokyrzxFiWiFPZuNYNolVravWlNA5C9mq4wfDSEPAZP/RxZAxU3pOXezKvcqorQo2
        XF3v8FZUWPNkOlhmFXhM5rY4kd0Z55M57+qxZ1AXZT9q59bbdElHXa7KMH084H9mX1ruDdu5
        E7sOj40vxVITfopmujCgdCVkS2NF6C2qaDwj3K/MYTjMxGVKZuzOqa1K3I8XBJskOBcj9/XA
        VJz8LzM4s0RiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7odv81iDa5vZrM4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrq1
        z1kKPnJXXP2/l7mBcRFnFyMnh4SAicSHE9tYuxi5OIQEljJKHO0+wwqRkJD4uP4GlC0s8eda
        FxtE0SdGiT8bb7KAJNgEPCV6Ju4A6xYROMUosXX5ObAqZoFNjBJ3j09kB6kSFoiQWDHhCxuI
        zSKgKrHqxjdGEJtXwFHi7rzVjBAr5CVWbzjADGJzCjhJdB1tB6sXAqrZtv01VL2gxMmZT4A2
        cwAtUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgnG479nPzDsZLG4MPMQpwMCrx8G7YYxorxJpYVlyZe4hRgoNZSYQ3sMEsVog3JbGy
        KrUoP76oNCe1+BCjKdBrE5mlRJPzgSkkryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QD40J270zhP5F3Ih6rqEmlTFN+d1r/W96jebfNpZyPf/45l2neRx67t76H
        2fIez09cE9IVFKHiPvHtC9MJJV9snt+Oy/TfwHaozmzy7C0bLybzf2Ao+fayZvGGORzamXkT
        r08K1XsZ93Vmw/vAeCs9rb7sjOvf7kyfJvl6U+Y2g1ua70Uuh76/FaLEUpyRaKjFXFScCACJ
        jdHh6QIAAA==
X-CMS-MailID: 20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch improves code readability by changing the following construct:

>    if (cond)
>        goto passive;
>    foo();
>    goto out;
>passive:
>    bar();
>out:

into this:

>    if (cond)
>        bar();
>    else
>        foo();

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index cf6f6cbd0f55..4bb83b945bf7 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -505,25 +505,19 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	node = of_parse_phandle(dev->of_node, "devfreq", 0);
 	if (node) {
 		of_node_put(node);
-		goto passive;
+		ret = exynos_bus_profile_init_passive(bus, profile);
+		if (ret < 0)
+			goto err;
 	} else {
 		ret = exynos_bus_parent_parse_of(np, bus);
+		if (ret < 0)
+			goto err;
+
+		ret = exynos_bus_profile_init(bus, profile);
+		if (ret < 0)
+			goto err;
 	}
 
-	if (ret < 0)
-		goto err;
-
-	ret = exynos_bus_profile_init(bus, profile);
-	if (ret < 0)
-		goto err;
-
-	goto out;
-passive:
-	ret = exynos_bus_profile_init_passive(bus, profile);
-	if (ret < 0)
-		goto err;
-
-out:
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

