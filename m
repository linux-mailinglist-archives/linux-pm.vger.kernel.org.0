Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEF7180D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGWMUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38689 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389725AbfGWMUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122028euoutp01e8cb50ca277be86959a75991fadbb801~0CJoeDgoE2875828758euoutp01X
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122028euoutp01e8cb50ca277be86959a75991fadbb801~0CJoeDgoE2875828758euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884428;
        bh=xYHVjPEnK2SWP+r3hWe6spsBX3CeKCFK+Qz1Ihn5wCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaVI1mOA+sPLf1x+tBVZqOIsO0hdEUIxRoLjdlxJAecyTZrERi9tsQomF32JhLFNu
         4l1zkq3ZQVT9sMC222pC2VhV6f47Tnw3pa0n+bdvjqQclo/XKRKy2RgXTbWmE0D65v
         2PciSDB308POH+dP6UM+9BY1TSHl/zL8dO40xeLI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122028eucas1p13eee0cf56f89df64afa3d2ce3ff472ae~0CJn56LWQ0096400964eucas1p1T;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.75.04325.B8BF63D5; Tue, 23
        Jul 2019 13:20:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190723122027eucas1p124f44370a63b16dcb765585761d661a3~0CJnOVHTg0311803118eucas1p1H;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122027eusmtrp1e5dec855e09799ace7a70bf659773740~0CJnDXiFz2543625436eusmtrp1B;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-aa-5d36fb8b99fa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.41.04146.A8BF63D5; Tue, 23
        Jul 2019 13:20:26 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122026eusmtip2d645baf0e12dafb33d7dc0bd57036851~0CJmQ0Lac1668716687eusmtip2-;
        Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 07/11] icc: Relax condition in apply_constraints()
Date:   Tue, 23 Jul 2019 14:20:12 +0200
Message-Id: <20190723122016.30279-8-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3euWqvjpviUUTQwSPASlh0wIu3C6ZtGQWRSKw9L1Ck7arcP
        rXt5w7SL6ciBYjYn6przkkqtpZjVikILC60p2WLZmq1CjZxnXb79/s/7/J8bL43JnhHL6HR1
        Lq9RKzMVZCBu6f1pjyycjkuN+WGMYa29rRTbUtFEsENTHwi22vaUYF9+myTZ690mki0bKcVZ
        u72ZYk2OQYJ90akjWU+xDbEV9h4J22h7S7HDp+pJtqL8I7l5CWcyXCK5N4NdJDdS2Cfh7tSe
        5O5/7pJwJWYD4jymFUnU3sCNaXxmej6vid50IPBwjX2MyLHSRy3Xxikt8pIFKIAGZh10m92S
        AhRIy5h6BCVtLkIUUwg83k+UKDwIXG01WAGi5y2tZk6M30LwteUW+dfR7B4ifHVJZgcUXW6f
        LxXM2BCU6ydxn8AYw5z4bkG+LDmzHWqfOCU+xplw0HcYKR9LmQSoGnZh4oQroaH53jwHMIlQ
        8PACKeYEQf+NMdzH2FzOmdYqzNcAGDcFj5ra/Oat8EZr97McnH1mSuTlMFBehIsswHjHCCGa
        tQhMdTa/IR4e9D0nfEtjzBpo6owWwwnQaHRT4i0WwytXkDjDYiizXPefSAoXz8tEjAD9dIpo
        BDjdMOivzUGV0YiVolWV/y1T+d8ylf/a6hFmQKF8npCl4oVYNX8kSlBmCXlqVdSh7CwTmvtn
        A7/6vrWjnpmDVsTQSLFI2ty1PlVGKPOFY1lWBDSmCJYma+NSZdI05bHjvCZ7vyYvkxesKIzG
        FaHSEwtGU2SMSpnLZ/B8Dq/58yqhA5ZpUdjFL7t6k89uoc5FjMa76RutqqkJw+4Qb+RE+OoN
        T/eUPdfZEp0rk0ardy6N3invn0msdlwZGt501QlbQurinLfpBwtXpb03JRYvj62/rTNKC2cz
        MrMJecfNhKKMfe+8NR8evw3L0HtSX6/4Or1NuZbHZx1PvLqJu9uxydLvVyYcClw4rFwbgWkE
        5W+53JN5YwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pdv81iDd6ctbA4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuLz
        T1gLDnFUbJv2lL2B8RtbFyMHh4SAicTWLR5djJwcQgJLGSXezQkEsSUEJCQ+rr/BCmELS/y5
        1gVUzgVU84lRYurp14wgCTYBT4meiTtYQRIiAqcYJbYuPwdWxSywiVHi7vGJ7CBVwgJuEkvO
        vmICsVkEVCUW7FwDFucVcJSYffstM8QKeYnVGw6A2ZwCThJdR9vZIE5ylNi2HWIbr4CgxMmZ
        T1hArmYWUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgjG479nPzDsZLG4MPMQpwMCrx8G7YYxorxJpYVlyZe4hRgoNZSYQ3sMEsVog3
        JbGyKrUoP76oNCe1+BCjKdBrE5mlRJPzgekjryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QDo4dnYqTYIYeDK76yqeUHr0kSYdAN1zhyIHDJqiydlUoHD9t/7pR5
        xbRBIHRdDs/a+NKZP4WfinkEp5k8MprIyGjjl2mucuHnU4bdthnTr//wNaoSL/P9Mbs78dCl
        3cbyn03r5Xi4Tv1qkMk2/xvna7V6WeW7f/19S+qUqqx6dRTsHjEFumcrsRRnJBpqMRcVJwIA
        IsA9K+cCAAA=
X-CMS-MailID: 20190723122027eucas1p124f44370a63b16dcb765585761d661a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122027eucas1p124f44370a63b16dcb765585761d661a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122027eucas1p124f44370a63b16dcb765585761d661a3
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122027eucas1p124f44370a63b16dcb765585761d661a3@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The exynos-bus devfreq driver is extended with interconnect functionality
by a subsequent patch. This patch removes a check from the interconnect
framework that prevents interconnect from working on exynos-bus, in which
every bus is a separate interconnect provider.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/interconnect/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2556fd6d1863..bb55565d190c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -219,11 +219,8 @@ static int apply_constraints(struct icc_path *path)
 	for (i = 0; i < path->num_nodes; i++) {
 		next = path->reqs[i].node;
 
-		/*
-		 * Both endpoints should be valid master-slave pairs of the
-		 * same interconnect provider that will be configured.
-		 */
-		if (!prev || next->provider != prev->provider) {
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev) {
 			prev = next;
 			continue;
 		}
-- 
2.17.1

