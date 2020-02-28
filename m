Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59991733CD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB1JXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 04:23:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40045 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1JXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 04:23:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200228092343euoutp02ea5e60fbc7219b14d0e9f4c7573245cd~3hqG0PlHl0778507785euoutp02I
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 09:23:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200228092343euoutp02ea5e60fbc7219b14d0e9f4c7573245cd~3hqG0PlHl0778507785euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582881823;
        bh=mKzpMeAp9k7qMNfb/JhHEyT05ufTa/4eWYBup8idP8E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=m+jZK/WQm2lWUvHz71ZzgfgEP0EHmdWvXRNv14GpC0tbVUg9UVl/b9qMrpKZXhnyB
         BuhDgXgdfhLKudh+AYhPRAc1NhJA9UjaCXO/yulyxmO0D34GPLFyj/KRBHJjuo92wT
         qsiuR8mj5w5YXHfW0wjtp1BqmHL5vQQxeUMWSFuM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200228092342eucas1p16cfcf02e932b6eaeda64f4d5e855df9b~3hqGnSELS2847428474eucas1p1v;
        Fri, 28 Feb 2020 09:23:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.65.60698.E1CD85E5; Fri, 28
        Feb 2020 09:23:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a~3hqGKDl2L0372003720eucas1p18;
        Fri, 28 Feb 2020 09:23:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228092342eusmtrp1cfa4e89469513ec259038bcd8a4bfb6b~3hqGJSES-2090420904eusmtrp1C;
        Fri, 28 Feb 2020 09:23:42 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-7a-5e58dc1eccff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.4D.07950.E1CD85E5; Fri, 28
        Feb 2020 09:23:42 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200228092341eusmtip1e31105333563b63bb3c430b4e852edcb~3hqFo4tH90081900819eusmtip1H;
        Fri, 28 Feb 2020 09:23:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: exynos: Silence warning during deferred probe
Date:   Fri, 28 Feb 2020 10:23:31 +0100
Message-Id: <20200228092331.21548-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7djPc7pydyLiDNYdNLb4fu4nk8XGGetZ
        LeZ9lrU4f34Du8Xn3iOMFjPO72OyWHvkLrvFk4d9bA4cHov3vGTy2LSqk83jzrU9bB59W1Yx
        enQcr/T4vEkugC2KyyYlNSezLLVI3y6BK2PShbnsBR/YKhYfvcvSwHibtYuRk0NCwETiTW8X
        excjF4eQwApGifdblrFAOF8YJWbcPc0E4XxmlGh7v4QRpmXR3kvMEInljBJTupoRWo4f+cIO
        UsUmYCjR9baLDcQWEbCXmLttMtgoZoEeJokJf3+xgCSEBdwl9s3dBXYJi4CqxI2WDWBxXgFb
        ibOtN6AulJdYveEA2DoJgcdsEv29T5khEi4S6zfcY4OwhSVeHd/CDmHLSJye3MMC0dDMKPHw
        3Fp2CKeHUeJy0wyoL6wl7pz7BdTNAXSTpsT6XfoQYUeJ70vOs4KEJQT4JG68FQQJMwOZk7ZN
        Z4YI80p0tAlBVKtJzDq+Dm7twQuXoEo8JBo/eoGEhQRiJX6/m880gVFuFsKqBYyMqxjFU0uL
        c9NTi43zUsv1ihNzi0vz0vWS83M3MQLTw+l/x7/uYNz3J+kQowAHoxIP74Id4XFCrIllxZW5
        hxglOJiVRHg3fg2NE+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyW
        iYNTqoFRp0U1Y8r8v84ymSW/RT3mukq1+D/c7L2Spz/3TtYGl70u+1e2W6gz8of8ej/3iPmh
        a8anT7UEM29keNct8FL1mP3vJOOK7bz9krZ2jU7XX734tvXMOrv48qTM8GMvPUznu6l8VPp8
        Qrb7hFJJbkNHZs+l8AmCHR28m3p8b1nNXBh00sP3KZ8SS3FGoqEWc1FxIgDMFaWwCwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xu7pydyLiDI6+FbH4fu4nk8XGGetZ
        LeZ9lrU4f34Du8Xn3iOMFjPO72OyWHvkLrvFk4d9bA4cHov3vGTy2LSqk83jzrU9bB59W1Yx
        enQcr/T4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL2PShbnsBR/YKhYfvcvSwHibtYuRk0NCwERi0d5LzF2MXBxCAksZJZ68WscIkZCR
        ODmtAapIWOLPtS42iKJPjBLPu5cwgSTYBAwlut6CJDg5RAQcJdr2/AebxCwwgUni1tM9YAlh
        AXeJfXN3gU1iEVCVuNGygQXE5hWwlTjbegNqg7zE6g0HmCcw8ixgZFjFKJJaWpybnltspFec
        mFtcmpeul5yfu4kRGJbbjv3csoOx613wIUYBDkYlHl6PbeFxQqyJZcWVuYcYJTiYlUR4N34N
        jRPiTUmsrEotyo8vKs1JLT7EaAq0fCKzlGhyPjBm8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYI
        CaQnlqRmp6YWpBbB9DFxcEo1MLbuWrii88ergBMi+37dP9yf02tzpPKlkPXxf4sOub1eo724
        zVvSXcO/JMbj3d6Vq3WlYzcznJ8y+23El2Sp2E23P589/GVhb1yNZ9qK65PeXPgVv3pmIcNM
        8Z1McsxK67fxV8vu19lWOtdoQ/Y8S58ps/ea3l6zf6Nt9qntRXtuBfjdv7svT8xfiaU4I9FQ
        i7moOBEAu0y58WECAAA=
X-CMS-MailID: 20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a
References: <CGME20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't confuse user with meaningless warning about the failure of
registering sensors in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fd4a17812f33..e9a90bc23b11 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1094,7 +1094,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 						    &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
 		ret = PTR_ERR(data->tzd);
-		dev_err(&pdev->dev, "Failed to register sensor: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to register sensor: %d\n",
+				ret);
 		goto err_sclk;
 	}
 
-- 
2.17.1

