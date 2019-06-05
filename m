Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75F3361D1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfFEQzG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:55:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32974 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfFEQyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165438euoutp017cb91c0f6ac84be08cd8172e89c9852d~lW7TkXo0z0150701507euoutp01M
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165438euoutp017cb91c0f6ac84be08cd8172e89c9852d~lW7TkXo0z0150701507euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753678;
        bh=UBJ3ezgLAW9CV2O9TqzTmKdZoxg8g/WoDRJ0caW6E6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orl6mIT45ABIQRBfw8/DNZ1YmJUttO3tCbpkedgxfUnozt4JC27v6NiTUbaWzYkoB
         MTAXgaotaoxskCVUZObo9KM9C0sIBJItHYA8E8dR3iISl/0pux50Wl5R5DnhnvYXN0
         fIbVyYTMsIlF6Vq2a8Kpy2f6AvpdeD+ngncR3YvA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165437eucas1p113ec140a7f6a75bae6372334d6fa5888~lW7S5nDya0348203482eucas1p1c;
        Wed,  5 Jun 2019 16:54:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 70.5E.04377.DC3F7FC5; Wed,  5
        Jun 2019 17:54:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605165436eucas1p2219af7e72feef428639ea70f496e3a9c~lW7SMpkxl0085900859eucas1p2e;
        Wed,  5 Jun 2019 16:54:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165436eusmtrp20c027b642e722d30944467311405c212~lW7R8yB5s2868028680eusmtrp2Y;
        Wed,  5 Jun 2019 16:54:36 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-fb-5cf7f3cd1eea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.4D.04140.CC3F7FC5; Wed,  5
        Jun 2019 17:54:36 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165435eusmtip1479bd6fcac96b266c542ac341d4fa4a8~lW7Q9nUEB0165501655eusmtip15;
        Wed,  5 Jun 2019 16:54:35 +0000 (GMT)
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
Subject: [PATCH v8 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
Date:   Wed,  5 Jun 2019 18:54:06 +0200
Message-Id: <20190605165410.14606-10-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0iTURjGO/t2+baafE7JFxONQWAXp93gQBKGBh9FYRBEJtTMzwu6Ofe5
        yuwyNc2m01Axc5X1Rzhcok7JS5Z5y0hNzcTSClMySZPU6fJC5tzE/37neZ/nfQ6HQxKSFp47
        Ga1MYNRKeayUL+I+f7PQ7dM1aw31K0p3x5WF5Tw8YPnJw8Wt73nYND2KcN67hxzcmanAOaMT
        BO7urhDgrpRJAR7UeuC++gd8PKtvRbiw+xUHl7V+FeChZCMft0ze5uHGj8fw0JITnn87ggJc
        6Pm5XC5t0PZy6bqirwLaXHqHT+tTp/h001QDh86uLkV0VUcSPWv2DBaGiPzDmdjoS4za9/AF
        UdRLXYRqgX+lrTNToEWLPB0iSaAOwEqaQodEpIQyIhiuykD2gwXB/YlJx2EWQYFhbDUhXEt8
        NugdgxIEbcZbG5G+kaW1vXxKBrWl8baAK5UEXwYaCZuHoCY50LX4l2sbuFDB0GAxIxtzqR2Q
        2zTOsbGYCoDKQqujzQtMFa8JGwtX9YL2Kq5tEVDfBGAyGAm7KQisWZ8dARf41V4tsLMHrNQV
        c+zMglb/BNn5GozmPHR4DkFLe+/apQlqJ5TX+9rlIzD+6B5hfyMn+PTb2SYTq5j7fF0WQ0a6
        xO72huqsHkfRVih5VuBYToOuvGGtVELlIZj+c/Mu8ira6HqMUClyYzSsIpJh9ymZyzJWrmA1
        ykjZxTiFGa1+rY5/7ZZaVL8c1owoEkm3iKHSGirhyS+xiYpmBCQhdRXLhyyhEnG4PPEqo447
        r9bEMmwz2kZypW7ipE3D5yRUpDyBiWEYFaNen3JIobsW1Z30zDbCDDmYkpFvbrI4LQRa3VU/
        XqQWxE91ynRl38tO5YcvB3zaM7K7o9IwuKz8wXBuzJ3xDsy/rorp/1AzWjgXkXj8qMbkEdS2
        fyysL0WVl0xHnz6bBSfE24WLgwk9WXG1PpudQ9Kezqzo84KuULLIAP8Ik99YjSbV2L/noJTL
        Rsn37iLUrPw/iyl7+VYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pnPn+PMbi4XM1i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jL1daQU/2SqOnulmb2D8xdrFyMkhIWAicXN2L2MX
        IxeHkMBSRokru46wQyTEJCbt2w5lC0v8udbFBmILCXxilJhyTL2LkYODTUBPYseqQpCwiEC9
        RP+bS2wgc5gFGpgl1my/CrZAWMBP4t2nX2BzWARUJSYdfMEEYvMKOEhsnPEd6gh5idUbDjCD
        2JxA8WnHN7NA7LKXuHT9N/MERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNo27Gf
        W3Ywdr0LPsQowMGoxMMrsfF7jBBrYllxZe4hRgkOZiUR3sTbX2KEeFMSK6tSi/Lji0pzUosP
        MZoCHTWRWUo0OR8Y43kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODil
        GhjdWRgW1zDdmTDZUetb/MLY2VPOOxx9fnfru+O6PnFbDf6xLNnzqkd5Ytv+sCvK664G1l7l
        eGxq8tzcvJvNIO5lj2fywh3xq69qr+X/qDPjvP/6vR5ubk76Cd75mzcm7Ch6ettMY3PbIqWf
        3Id+cayYOnHnowt9CiwZEeHsG1ffOP56ypFrp39PUmIpzkg01GIuKk4EADccwNy5AgAA
X-CMS-MailID: 20190605165436eucas1p2219af7e72feef428639ea70f496e3a9c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165436eucas1p2219af7e72feef428639ea70f496e3a9c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165436eucas1p2219af7e72feef428639ea70f496e3a9c
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165436eucas1p2219af7e72feef428639ea70f496e3a9c@eucas1p2.samsung.com>
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

