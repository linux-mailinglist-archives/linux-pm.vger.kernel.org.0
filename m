Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47F023B4DD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgHDGM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:12:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59388 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgHDGM1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 02:12:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200804061226euoutp01a38b7042f74481f284f19bf422653131~n__M4vAOp0732707327euoutp01N
        for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2020 06:12:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200804061226euoutp01a38b7042f74481f284f19bf422653131~n__M4vAOp0732707327euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596521546;
        bh=h1MIe7+guqaF7sFDMh4fJlyTfxy7EDF7dzFmjh9wV8w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vEY7jUoQk+C2zGaMinQgVPU2BqGZzJwHWP9GUir948hqICNKmj6yCVOeNNn7OzFTW
         WDDxWqXWLQTkln5gj5FNiMdrn0VgWy71yFZ7W5P8QugBIVzeiRESOsBOTlddFhDLcT
         G/2v/LO7rh5LFGhw5Vst3xtMzHlj9W64apsG1Jw4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200804061226eucas1p1f69e5befcc49f7fe6b4db4dddd841b2f~n__Mu4wO82756627566eucas1p1S;
        Tue,  4 Aug 2020 06:12:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.8F.06318.94CF82F5; Tue,  4
        Aug 2020 07:12:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d~n__MBUbYS2676826768eucas1p2q;
        Tue,  4 Aug 2020 06:12:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200804061225eusmtrp12c203f5ad76b778325fddfedf6fc66e1~n__MAqmPJ0612206122eusmtrp10;
        Tue,  4 Aug 2020 06:12:25 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-0a-5f28fc4960f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.DB.06314.94CF82F5; Tue,  4
        Aug 2020 07:12:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200804061224eusmtip26b15d686a10db96dc73b8ed4fb28abd7~n__Lh-wUq0707607076eusmtip2Q;
        Tue,  4 Aug 2020 06:12:24 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
Date:   Tue,  4 Aug 2020 08:12:10 +0200
Message-Id: <20200804061210.5415-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87pefzTiDd69Z7TYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLz71HGC1mnN/HZLGwqYXdYu2Ru+wOHB5r5q1h9Ni0qpPNo2/LKkaPz5vk
        AliiuGxSUnMyy1KL9O0SuDJ6V01mKpjDUbF882/mBsaXbF2MnBwSAiYSrateM3UxcnEICaxg
        lHi4fBsLhPOFUeL8v6nMEM5nRolDa14ww7Qcn3IbqmU5o0R/Vw8LSAKsZfcFCRCbTcBQoutt
        F9gOEYF4ia0/u5lAbGaBm4wSS84adTFycAgDxfsPloOEWQRUJQ4e+c0KYvMK2EgcXneIBWKX
        vMTqDQfAjpAQuM4mseXMaUaIhIvEtneLmSBsYYlXx7ewQ9gyEqcn97BANDQD/XNuLTuE08Mo
        cblpBlS3tcSdc7/YQK5gFtCUWL9LHyLsKNF/6AczSFhCgE/ixltBiJv5JCZtmw4V5pXoaBOC
        qFaTmHV8HdzagxcuQZV4SNy4VQQJkViJhQueM09glJuFsGoBI+MqRvHU0uLc9NRi47zUcr3i
        xNzi0rx0veT83E2MwERw+t/xrzsY9/1JOsQowMGoxMO7gFUjXog1say4MvcQowQHs5IIr9PZ
        03FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MMZynPs1
        efLf3uT9903n9C9ucSoryj6sKF/w+rItW/ieu5YPtj+s1v3Au9Sk6+vCyr79pVtN811XLW6N
        nF8yqdnllu3rut01G7n9hGborw7Qmc/Bvid05iej+ktPov7/D/5Tk+tc9FVBaL/jIXXhg9kb
        5l2pXXrj33vNO5kv7RZaFM2fcuxP5jYlluKMREMt5qLiRADPZ3xDAAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xe7qefzTiDRZu5LXYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLz71HGC1mnN/HZLGwqYXdYu2Ru+wOHB5r5q1h9Ni0qpPNo2/LKkaPz5vk
        Alii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ6
        V01mKpjDUbF882/mBsaXbF2MnBwSAiYSx6fcZupi5OIQEljKKHHv5WtmiISMxMlpDawQtrDE
        n2tdYA1CAp8YJXZs4QSx2QQMJbreQsRFBBIlvm1cyAgyiFngLqPElH0tLCAJYYFYifcHpzCB
        2CwCqhIHj/wGG8orYCNxeN0hFogF8hKrNxxgnsDIs4CRYRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgEG479nPzDsZLG4MPMQpwMCrx8C5g1YgXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJl
        VWpRfnxRaU5q8SFGU6DlE5mlRJPzgRGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBMfOcrVnDlrsLny7UO8BgxZ/8jeNDI6tA2t+5R1W+FPRb+T/sM3u+IDnl
        icSqm65cB+LPXvZYpse5qU+SdcblqZMafYwONzGob8mVv75J+fgffjkdxtzE63MM5xQLnfJL
        cvmpvjJM8JyCofOBj/K7mqzP3ug8VrLnXfEtHs1LhZVX2Ro5hSSFlFiKMxINtZiLihMBA8M6
        TVgCAAA=
X-CMS-MailID: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

exynos5_counters_get() might fail with -EPROBE_DEFER if the driver for
devfreq event counter is not yet probed. Propagate that error value to
the caller to ensure that the exynos5422-dmc driver will be probed again
when devfreq event contuner is available.

This fixes boot hang if both exynos5422-dmc and exynos-ppmu drivers are
compiled as modules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index b9c7956e5031..639811a3eecb 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -914,7 +914,7 @@ static int exynos5_dmc_get_status(struct device *dev,
 	} else {
 		ret = exynos5_counters_get(dmc, &load, &total);
 		if (ret < 0)
-			return -EINVAL;
+			return ret;
 
 		/* To protect from overflow, divide by 1024 */
 		stat->busy_time = load >> 10;
-- 
2.17.1

