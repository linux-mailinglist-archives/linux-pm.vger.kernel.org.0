Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03EEB37C3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfIPKHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 06:07:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40139 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfIPKHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 06:07:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190916100719euoutp014e60059354654b220ffa185f52a79c72~E40EyH6gh2490524905euoutp01Z
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 10:07:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190916100719euoutp014e60059354654b220ffa185f52a79c72~E40EyH6gh2490524905euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568628439;
        bh=ZKaiWSmqXLW7DVvyiRQxVpgxuqi4JmNHQmIPrM7zpG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaQjexg304X+1nxmgwp7F8+nrAVq1g7DNko4kCtIGakV+SQJcQklrrFPA1O6c4/je
         Jz90fbSwgZldWFI7Vlsmg+Wy4+4GwwACxjN0uoj3n6vYhRVjVNEjC9xSEtQOy60PX8
         oGWecPN+vY7Lk3aCg4q28lbbjzvw8uXVmWDYdun4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190916100718eucas1p1aad84200fd91ed069b4d28e79b8bca55~E40EEeD850720607206eucas1p1S;
        Mon, 16 Sep 2019 10:07:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.DC.04309.6DE5F7D5; Mon, 16
        Sep 2019 11:07:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd~E40DPjyUN0447104471eucas1p1o;
        Mon, 16 Sep 2019 10:07:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190916100717eusmtrp2a2341e524e06682a4f45e7b04bd5b885~E40DBeMRs2883028830eusmtrp20;
        Mon, 16 Sep 2019 10:07:17 +0000 (GMT)
X-AuditID: cbfec7f4-f2e849c0000010d5-23-5d7f5ed6b7a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.48.04117.5DE5F7D5; Mon, 16
        Sep 2019 11:07:17 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190916100716eusmtip27dbb5ac2a4a788a86d3748e0b88fcf0d~E40CWSJIl3249232492eusmtip2C;
        Mon, 16 Sep 2019 10:07:16 +0000 (GMT)
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
Subject: [PATCH v2 1/3] memory: Exynos5422: minor fixes in DMC
Date:   Mon, 16 Sep 2019 12:07:02 +0200
Message-Id: <20190916100704.26692-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916100704.26692-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0yMYRz33Pu+9753vHk7qe9oNReGEZm1Z1iyMTf+0IzZIhy9/Zju4t4u
        JdOhX24qw1Dzo5J1u7tGJ5WTpC6h1SEq/ZrV5FcYFTEurjf893k+z+fXnj0MobBRM5hYbQKv
        06rjlFI5WXH/e8uith2pEUsahjxx2flrFG4ffk3hy44WCuf2vyew03mdxs1HB2ncafDFtv42
        CrfaL0jxULYD4fPOGgkudfTQ+Gr7EwnuOmKS4vQ7DhrXD2ZS+OuDPhTqqbJesiLVrfweWmUz
        H5eqbhSnqu59rJaocsrNSDVk8wujw+UrI/m42ERetzhklzzGMtBL7iucnNR1ep0BtcqMSMYA
        twy6LUbKiOSMgjMhuNpRisTDMIJjRS7CrVJwQwjeHPX96/hirCVFUQmCXJNL8s9xpq9TakQM
        I+UCocq8323w4q4g+Fof7sYEVyGB7JHxoGlcCPzMqqLcmOTmwLeOJtKNWW4VuOwvkVjmD5br
        teMjZFwojJoaCHcXcPdpyOrsJ0XRGrjZbaVEPA3eNZbTIvaFsVuXJSIWwJBdOBF6CPpzL05o
        VkB94xPKvZng5sM1+2KRXg05rlKJmwbOAzo+eIrzPeBUxTlCpFnIylCI6nlQfuLxRJE3lFjP
        ToSroODtgFR8ndMIHr9x0ieRf/7/sgKEzMiH1wuaaF5YquUPBApqjaDXRgfuidfY0J+f1ORq
        HK5C9p+76xDHIOUU1pB+OEJBqROFZE0dAoZQerFbs1IiFGykOvkgr4vfqdPH8UIdmsmQSh82
        ZdLLbQouWp3A7+X5fbzu762Ekc0woOAXdGmZc8OcQcf2zX6xxd5y9pFH1NrPaRk+ARXV2ldd
        LZqVO09k1kRpf/l2P92quzs99+Gmmv3+RY6BvCqnz0hrclp35dr36cmzmr3CZuc9X3hj6vrW
        T6i4fSNrGSOf/Zi1tzl++mhwr76pUhYQENTFLM9jk6imLZVzmbCC2wNlDiUpxKiDFhA6Qf0b
        p5Dlm0UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pX4+pjDV5Nk7XYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jNXP7rEULOSuuD3ZvYHxMmcXIyeHhICJxKeuAywgtpDAUkaJVSciIOJiEpP2bWeH
        sIUl/lzrYuti5AKq+cQoMefjD6AGDg42AT2JHasKQeIiAssZJY6tessM4jALHGGS6N81jxWk
        W1jATuJPxw4wm0VAVeL7jdNg23gF7CX+7XrACLFBXmL1hgPMIDangIPEjxVHmSEuspeYcv0H
        4wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC42TbsZ9bdjB2vQs+xCjAwajEw9vQ
        WhcrxJpYVlyZe4hRgoNZSYQ3vKM6Vog3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPzgTGcVxJv
        aGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB8dqa1vbfStMuOJp8OFBc
        0CQiwMCvF6jcf7aruDrbTWjl1zuul/7qbrz+7ubnFzlfz6TFTM/Yu2jbP5MPZflqjTdTe5pF
        ptVbJucF7V/xlSesWDNINfzBHL/5wo3nHBdtnTzpN5vBkdjJS1MKXi2qnKGpXbK65vQEt+dW
        nx5f2LSjVbNA70pJhBJLcUaioRZzUXEiADMC3mSpAgAA
X-CMS-MailID: 20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd
References: <20190916100704.26692-1-l.luba@partner.samsung.com>
        <CGME20190916100717eucas1p1b8d24c74c4d0bb385aa3455cf98c76bd@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Small fixes for issues captured by static analyzes:
used kfree() insead of devm_kfree() and missing 'static' in the private
function.
Checks which show the issues:
- drivers/memory/samsung/exynos5422-dmc.c:272 exynos5_init_freq_table()
warn: passing devm_ allocated variable to kfree. 'dmc->opp'
- drivers/memory/samsung/exynos5422-dmc.c:736:1: warning: symbol
'exynos5_dmc_align_init_freq' was not declared.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
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

