Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4C23EE42
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGNb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 09:31:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33593 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHGNb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 09:31:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200807133153euoutp019b56b985de4ab0ee397b3c871c65688c~o-5wbYskI0549405494euoutp01m
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 13:31:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200807133153euoutp019b56b985de4ab0ee397b3c871c65688c~o-5wbYskI0549405494euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596807113;
        bh=bwtmv0Y2Zgf+24ltl9ovYNhfcxyscJBNZ4JvyrYqNJ8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=W4cYbmDtBf+H9b9exgACWNrZSE1RcExJJAdMY9p0G9JxdPO3MQSi8AafLXo9W/8dh
         uVTZQ9XtlnHNmBkrG4Qhx3LS413v98VOKaSNLVPS3daCaLpGJyLRajshSPOfy5ArL7
         5xpjW1/CgUA70OkYkvbk3V8fzapGUbikyJxImYk4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200807133153eucas1p2580bd9d4a94f30e8b46de275189bb72b~o-5wBCzGQ1943519435eucas1p2P;
        Fri,  7 Aug 2020 13:31:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.16.06318.9C75D2F5; Fri,  7
        Aug 2020 14:31:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f~o-5viV7390989609896eucas1p1c;
        Fri,  7 Aug 2020 13:31:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200807133152eusmtrp291df7c879e5fe91a3d49c385b6d697da~o-5vhtKoj2793327933eusmtrp2C;
        Fri,  7 Aug 2020 13:31:52 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-2a-5f2d57c939e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F6.41.06314.8C75D2F5; Fri,  7
        Aug 2020 14:31:52 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200807133152eusmtip156850caddd730172b857bff4c6efdf91~o-5vCOG_F0331303313eusmtip1C;
        Fri,  7 Aug 2020 13:31:52 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
Date:   Fri,  7 Aug 2020 15:31:43 +0200
Message-Id: <20200807133143.22748-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87onw3XjDSZfE7bYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sli0P33J7MDlsWbeGkaPTas6
        2Tz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEro2f3BbaCb5wVj87NZ2pg3MLRxcjJISFgIrHz
        1hTGLkYuDiGBFYwSP64sg3K+MErs75nEBOF8ZpRoOP6fGaZl2vWDrBCJ5YwSGw51s8O13L23
        gAmkik3AUKLrbRcbiC0iECOx6/oRsFHMAiuZJF6cug9WJCzgKfF4WwcriM0ioCqxoWMtC4jN
        K2ArsevgXEaIdfISqzccYAZplhB4zCaxbdFfVoiEi8S0P4+gbhKWeHV8CzuELSPxf+d8JoiG
        ZkaJh+fWskM4PYwSl5tmQI21lrhz7hfQfRxAN2lKrN+lDxF2lJh+bzYTSFhCgE/ixltBkDAz
        kDlp23RmiDCvREebEES1msSs4+vg1h68cAnqHA+JvYfOgNlCArESS9uOMk1glJuFsGsBI+Mq
        RvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwCRx+t/xrzsY9/1JOsQowMGoxMP7w1c3Xog1
        say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0t
        SC2CyTJxcEo1MAq9qlr8aGuQkmaSRJnbm18/7jR1ZL/8OfWrAEez8h+DGIVAIWmRGoUkgUDW
        G4dDpBt35wr37zhi6iJXdf5c1fbgsya/1m7WVz3YGzX9w9QdfJbzZs7simNbGD7tqi7r7qOb
        mfsf3M3YuWuh3yR1D9dfhbLmKe/m/pwiznxUYdOmAtU1ocHtC5RYijMSDbWYi4oTAZts6goO
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xu7onwnXjDd78NbLYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sli0P33J7MDlsWbeGkaPTas6
        2Tz6tqxi9Pi8SS6AJUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1
        J7MstUjfLkEvo2f3BbaCb5wVj87NZ2pg3MLRxcjJISFgIjHt+kHWLkYuDiGBpYwSDecaWCAS
        MhInpzWwQtjCEn+udbGB2EICnxglNv5kBLHZBAwlut5CxEUE4iSedN9nArGZBdYySdy5JQ9i
        Cwt4Sjze1gE2h0VAVWJDx1qw+bwCthK7Ds5lhJgvL7F6wwHmCYw8CxgZVjGKpJYW56bnFhvq
        FSfmFpfmpesl5+duYgSG5bZjPzfvYLy0MfgQowAHoxIP7wJv3Xgh1sSy4srcQ4wSHMxKIrxO
        Z0/HCfGmJFZWpRblxxeV5qQWH2I0BVo+kVlKNDkfGDN5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYrSerfjH0DAnjjhN6tjHqr7nHfb15Ho6udvLdZ233VNaf
        iZ9vteXGNDf3mUZHXBVNHRKkXGxcFwccOGN36+RtVuN+zSmfmPLkLljYMpgzfQn2+yv0bZ6b
        r88Z07j62sap3DsUbC+uXXb2O8v/jETm/dJOZgZz427VtRkvdKh/qiEpP0NkmqESS3FGoqEW
        c1FxIgA7QsgTYQIAAA==
X-CMS-MailID: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BPLL clock must not be disabled because it is needed for proper DRAM
operation. This is normally handled by respective memory devfreq driver,
but when that driver is not yet probed or its probe has been deferred the
clock might got disabled what causes board hang. Fix this by calling
clk_prepare_enable() directly from the clock provider driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index fea33399a632..521cbbfc0987 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1655,6 +1655,11 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	 * main G3D clock enablement status.
 	 */
 	clk_prepare_enable(__clk_lookup("mout_sw_aclk_g3d"));
+	/*
+	 * Keep top BPLL mux enabled permanently to ensure that DRAM operates
+	 * properly.
+	 */
+	clk_prepare_enable(__clk_lookup("mout_bpll"));
 
 	samsung_clk_of_add_provider(np, ctx);
 }
-- 
2.17.1

