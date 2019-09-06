Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E262CAB58D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbfIFKOI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 06:14:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35043 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390279AbfIFKOI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 06:14:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190906101407euoutp02944055c3ba2f3739219704becd6420f2~B0dKFxA8R1083310833euoutp028
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 10:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190906101407euoutp02944055c3ba2f3739219704becd6420f2~B0dKFxA8R1083310833euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567764847;
        bh=WuzwCUYV2cdfl7qLbkBAHqDKsnTlIX0yAhB2QMQqk30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A63medX+1JY83V1tg7q6yFeeXbxIlZKFMsLu9c/5GHwI+hJbNYkMrPfisXmXdXgMO
         k1uP6jOsvoydbvHJu0YwzIqujjcd9IDja1mfMLINtiFIU/JB+bBn77n1i+ydqbVCuq
         AxyAFez+HHxhWnLlNbE1vYkA0RpUTO0HWwsoJfWI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190906101406eucas1p2dab289502ae4d19bca00c58b64cbb50a~B0dJP-wP_1006510065eucas1p2u;
        Fri,  6 Sep 2019 10:14:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.C7.04469.E61327D5; Fri,  6
        Sep 2019 11:14:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486~B0dIkS26A1006510065eucas1p2r;
        Fri,  6 Sep 2019 10:14:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190906101405eusmtrp1c640308e8ab83c4ae2f8dfd9cdeeaae3~B0dIQh6Mn1272412724eusmtrp1a;
        Fri,  6 Sep 2019 10:14:05 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-e4-5d72316e83a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.9E.04166.D61327D5; Fri,  6
        Sep 2019 11:14:05 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190906101404eusmtip1d71620cc9f795288ce2881dd16b7cf9e~B0dHYdujW3027130271eusmtip1a;
        Fri,  6 Sep 2019 10:14:04 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 1/3]  memory: Exynos5422: minor fixes in DMC
Date:   Fri,  6 Sep 2019 12:13:42 +0200
Message-Id: <20190906101344.3535-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906101344.3535-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229nZOY5mxyn5oiNjEZSgZkR8kJmRwf5U0g8rQ2rpybxN3fHS
        labZTdPZIjOzi3TRprI5dai0Sp3NCpsWalpmKmSaKXijoiLnmfXveZ73eb734eWjCWkt6U3H
        qdJYtUqZKBeJhebnP+z+qiB11PrmqeW4pthA4t7ZURLfsb4msXbkK4HtdiOFO7InKNyvkWHT
        SA+J3zaVivBMvhXhYvsTAa62DlD4QW+XAL/PqhDhcxYrhVsnLpB4vn0Yhborqm5XIUVjyQCl
        MOkviRS1988omicfCxQFdXqkmDGtDKcixcExbGJcBqsODDkkPjpZ8hSlzFPHCrM3aFC/KBe5
        0sBshLzOUioXiWkpU4Hgxth3IU9mEfzWF4h4MoPAZLQIlyJll0adg3IEmiu1gn+RvvryBULT
        IiYAGvSpjoAncw/BfGukAxOMWQD5czIH9mCCwWCqXuwhZNbA2GzjIpYwITD6sw7xy3yh0viM
        cGBXZivoDNcW6wHTQkFp95yAN4VBt83iDHjAuK2O4rEMXl297GzNgSa/zOk5BSPaW07PZmi1
        dZGOzgSzDgxNgby8DUqGvlMOGRg3ePfNna/vBjrzdYKXJXDxvJR3r4W6y53OMiugvKrI+bgC
        pjVZBH8dHQK7pYksRL4l/5fdRUiPvNh0LimW5YJUbGYAp0zi0lWxAdHJSSa08JVe/bFNN6C5
        N4dbEEMj+TIJM5sSJSWVGdzxpBYENCH3lBhqFiRJjPL4CVadfFCdnshyLciHFsq9JCddPh2Q
        MrHKNDaBZVNY9dJUQLt6a5BlOjft9NzJ8cCEs7LB6D0Roaf7I7Q+w7lDsgj5keJViT47U/Cj
        l0Vx+z8Ock1j2g5x6kCl2djdVpmz62ann9vni5kz2/O+vKD7Vv+q39tmn0irmWx2GYn03/Jw
        y6ae9qkz7rqXYTut8bHxuz8ovVy9pzvP7tCF29Yb4ISW9MnZVykXckeVQX6EmlP+BWlBwcJG
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7q5hkWxBkveilhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0s1p8O/GI0UHQY828NYweO2fdZffYtKqTzWPzknqPg+/2MHn0
        bVnF6PF5k1wAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexrtZ+xkLvrFXTGgyamC8xdbFyMkhIWAisbDzOZDNxSEksJRRovVjE1RCTGLSvu3s
        ELawxJ9rXVBFnxglbszsBHI4ONgE9CR2rCoEiYsILGeUOLbqLTOIwyxwhEmif9c8VpBuYQEb
        ifWb1oJNZRFQlXj5ZSeYzStgJ/H81xZGiA3yEqs3HGAGsTkF7CUmrZ/KAmILAdXsmtLJMoGR
        bwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzASNl27OfmHYyXNgYfYhTgYFTi4RX4UhAr
        xJpYVlyZe4hRgoNZSYR3/UagEG9KYmVValF+fFFpTmrxIUZToKMmMkuJJucDozivJN7Q1NDc
        wtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjUxqPbcb1uFe5h15mNOlzFa8P
        Trm+c0mv0NmlPr8Pqk8N1vLt0XRTvj6nL9REZ5L9pf6YbMusYJ+9/4Nv/Gmb3ZGZWVEp/YE5
        NOPtqh88Jjf5JF9HiIQtfmN2cNW39q9xPZNXBqeEnj7CYbLsgOql4JLmww9bftxYODsvdPtO
        0YWsalsu1W9UYinOSDTUYi4qTgQAk7C8yaoCAAA=
X-CMS-MailID: 20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486
References: <20190906101344.3535-1-l.luba@partner.samsung.com>
        <CGME20190906101405eucas1p2e3da7b461810a3a520e76c636a06e486@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Small fixes captured by static analyzes.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 8c2ec29a7d57..a809fa997c03 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -269,7 +269,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 	return 0;
 
 err_free_tables:
-	kfree(dmc->opp);
+	devm_kfree(dmc->dev, dmc->opp);
 err_opp:
 	dev_pm_opp_of_remove_table(dmc->dev);
 
@@ -732,7 +732,7 @@ static struct devfreq_dev_profile exynos5_dmc_df_profile = {
  * statistics engine which supports only registered values. Thus, some alignment
  * must be made.
  */
-unsigned long
+static unsigned long
 exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
 			    unsigned long bootloader_init_freq)
 {
-- 
2.17.1

