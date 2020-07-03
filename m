Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2F2133F0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGCGPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 02:15:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46150 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGCGPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 02:15:14 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200703061512epoutp011c86f45e6c16b18d12a580f6b0e2bd05~eKXewYxej2413124131epoutp01S
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 06:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200703061512epoutp011c86f45e6c16b18d12a580f6b0e2bd05~eKXewYxej2413124131epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593756912;
        bh=XJm1fvNg9hfO3m0YYoOYKOBAaLBb4q2pn0V9WebzjhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojBGQECtum48ZmiHKzs6r+FXAKGHcJNkpGpzA3770s2ccinAe/FE8umVBy0sPDoJR
         a/m0SKBhaE09vwITVVb7dGv7lRt42UMnUKZSSsAuow8ZFAhYW0i53+Gleu+ng3cORy
         zdXTD/dsQa2mye1TA+L4ONxCWtBCukyCF/FtW1uk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200703061511epcas1p48cedd9b23ad7b2716b9dda6471c5a8e0~eKXePvMT-0635706357epcas1p4X;
        Fri,  3 Jul 2020 06:15:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49yl7K4b5czMqYkq; Fri,  3 Jul
        2020 06:15:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.78.19033.DECCEFE5; Fri,  3 Jul 2020 15:15:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb~eKXcA4eB91020410204epcas1p3o;
        Fri,  3 Jul 2020 06:15:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703061509epsmtrp27b712376909a68c1a4df3959e41f8efc~eKXb-N3Yk2442524425epsmtrp2V;
        Fri,  3 Jul 2020 06:15:09 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-4a-5efeccedb9e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.2E.08382.DECCEFE5; Fri,  3 Jul 2020 15:15:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703061508epsmtip1ef6c2bd15f987b32a2859214dbf8aad0~eKXbvzxJf1305313053epsmtip1j;
        Fri,  3 Jul 2020 06:15:08 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/2] memory: samsung: exynos5422-dmc: Use delayed timer
 as default
Date:   Fri,  3 Jul 2020 15:26:22 +0900
Message-Id: <20200703062622.11773-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703062622.11773-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTQPftmX9xBp8OKFtsnLGe1WLijSss
        Fte/PGe1WPBpBqtF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgt
        bjeuYLM4/Kad1eLbiUeMDvwea+atYfTYOesuu8emVZ1sHpuX1Hv0bVnF6PF5k1wAW1S2TUZq
        YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QyUoKZYk5pUCh
        gMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Ix/Bw+w
        FfSzV9w7epK9gbGHrYuRg0NCwERixs6CLkYuDiGBHYwSh1ZNZINwPjFK7Hy9gQnC+cYocbHr
        KlCGE6zj4JQGZojEXkaJzu5FUM4XRolj194yg1SxCWhJ7H9xA6xDRCBUYva9qWBFzAK7mCS+
        TJsJViQsECFxb815VpBDWARUJY69DAIJ8wpYSSx7t4gJYpu8xOoNB8DKOQWsJe703AO7T0Kg
        l0Oi98s0ZogiF4lpN/ayQNjCEq+Ob2GHsKUkPr/bC3V2tcTKk0egmjsYJbbsv8AKkTCW2L90
        MhPIEcwCmhLrd+lDhBUldv6eywhiMwvwSbz72sMKCTBeiY42IYgSZYnLD+5C3Skpsbi9E2qV
        h8SKs4+hQdfHKLHk3BamCYxysxA2LGBkXMUollpQnJueWmxYYIQcZZsYwWlSy2wH46S3H/QO
        MTJxMB5ilOBgVhLhTVD9FyfEm5JYWZValB9fVJqTWnyI0RQYeBOZpUST84GJOq8k3tDUyNjY
        2MLE0MzU0FBJnFdN5kKckEB6YklqdmpqQWoRTB8TB6dUA9OE+VX7Tp3onXnHlMezXNbkCn8o
        5035kycZ+JXPKMk+PrfVfdF9t8TFafZ7K7xEcjn6QjeejzAsSZL1W/K54Vzjk5Nr9U+IcM3t
        ufuyhvmYUpl/+bEfLwqmyrVdtvXeP/n5XSHPR5c8Xh0Q3KW2NbH98awOnzrlvHt7CoSSVm9r
        euR/84Cr7DS2ky6f3tkq5m9f+JWzpF7Q1Dx/TenCw6/0eozUtxWdn7eb+2HHhh1Ld0Zkhf5s
        jLj37ZrQhomZ98QOT21ymOC+bxJ30BfhbqXX4Vu7+/nn254qmxV+XaN+1xZhe5FLXxS8RXZx
        RF+4u6lrwhWHW/p501o9DVZ9b3W6Vzl/wdOMo5OTZnKoybspsRRnJBpqMRcVJwIAbNmxzxwE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnO7bM//iDNqvc1psnLGe1WLijSss
        Fte/PGe1WPBpBqtF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgt
        bjeuYLM4/Kad1eLbiUeMDvwea+atYfTYOesuu8emVZ1sHpuX1Hv0bVnF6PF5k1wAWxSXTUpq
        TmZZapG+XQJXxr+DB9gK+tkr7h09yd7A2MPWxcjJISFgInFwSgNzFyMXh5DAbkaJM63zWCAS
        khLTLh4FSnAA2cIShw8XQ9R8YpRY1vKREaSGTUBLYv+LG2CDRAQiJc43HGUDKWIWOMYksfxt
        O9ggYYEwiU8nNrGCDGIRUJU49jIIJMwrYCWx7N0iJohd8hKrNxxgBrE5Bawl7vTcA5spBFTz
        pvM64wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKDWUtzB+P2VR/0DjEy
        cTAeYpTgYFYS4U1Q/RcnxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdG4cI4IYH0xJLU7NTUgtQi
        mCwTB6dUA5MMN2/jfXMVs+WHono74559P7XrfuGR0B0+vKuY/By79s82F16dNcPu0YMdC3Pu
        W8+y/juDs4DNb2M8d5HCvMW7m57lfkqKOVos+/HQgXuz79pcLl3FUGO//8EDtqVfWzadnr7H
        c552dZzCfQuP53a7jD9tzrFuDFtelaZod2t78tQ5nNttVk8NeDHJYZZUTzdzfVtWaF75hGnn
        eRXP7Oc+qMR7zLGAf73YXdkJ4XU8B3iOCL8ScMjreB0v2b7+2j02gdLYa9nrS1i2Vy5kyY9c
        acKZbJzH9HTlhYaZNhFKeq9/fBZ3Kc3ad09x3Q6uLR84ls2N4mjwTTvwaorH/l+X1mz2flVd
        pDfvXviv8JNKLMUZiYZazEXFiQByK+lw1QIAAA==
X-CMS-MailID: 20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb
References: <20200703062622.11773-1-cw00.choi@samsung.com>
        <CGME20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use delayed timer as default instead of deferrable timer
in order to monitor the DMC status regardless of CPU idle.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 25196d6268e2..93e9c2429c0d 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -945,6 +945,7 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
  * It provides to the devfreq framework needed functions and polling period.
  */
 static struct devfreq_dev_profile exynos5_dmc_df_profile = {
+	.timer = DEVFREQ_TIMER_DELAYED,
 	.target = exynos5_dmc_target,
 	.get_dev_status = exynos5_dmc_get_status,
 	.get_cur_freq = exynos5_dmc_get_cur_freq,
-- 
2.17.1

