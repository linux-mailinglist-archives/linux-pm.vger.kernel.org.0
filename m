Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BDA146BDA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAWOxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:53:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50645 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAWOxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200123145332euoutp0128d02161b48aa150c636e019c8ba3ef2~si7zJj1SB2779027790euoutp01X
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200123145332euoutp0128d02161b48aa150c636e019c8ba3ef2~si7zJj1SB2779027790euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579791212;
        bh=gUt0xdJYsjZMQC8Hykq0BgkZD7XebHRDKl7WMh5ImJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JI3RP/gVkaD9dJ5vvzp3vwzH2hWE7OgIkkFQISse6n+pYfzH05A764Xe7zbk4TSNM
         2TvKwddGOvIYQzpfcJMmCCfZfHxOs+A6js6wMHTy9euICWmsTU8nR67oXL2zw5Fuzo
         iB6HGFRl2d/WrzOwRwi3vYsq39MSJXJ3dVeiaRro=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200123145331eucas1p102fdaf977d34988fb2e95a98d113170b~si7y6Co_j2151721517eucas1p10;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.8B.61286.B63B92E5; Thu, 23
        Jan 2020 14:53:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145331eucas1p2aaf6eccd724af9edc25a547b6fde7961~si7yKabuE3021030210eucas1p2J;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200123145331eusmtrp1a63db195c5616fa163544891c9764d3a~si7yJxBfb2757227572eusmtrp1P;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-1e-5e29b36b5107
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.43.07950.B63B92E5; Thu, 23
        Jan 2020 14:53:31 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145330eusmtip2f4c1ce251dd8ada3925cc44767e7f33a~si7xlJ5TV1862618626eusmtip2M;
        Thu, 23 Jan 2020 14:53:30 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 1/3] PM / devfreq: exynos-nocp: fix debug print type
Date:   Thu, 23 Jan 2020 15:53:11 +0100
Message-Id: <20200123145313.27539-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123145313.27539-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87rZmzXjDO7sMbXYOGM9q8WCTzNY
        Lfofv2a2OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRXDYpqTmZZalF+nYJXBkLGg6zF/SxV5yfvJGlgbGTrYuRk0NCwERi8arrrF2MXBxCAisY
        JRpvzmOBcL4wSsxs7WKGcD4zSmw4087UxcgB1nJnbjpEfDmjxLwle5nhOia+/MACMpdNQF/i
        4NmTYLaIgLRE56KJTCBFzAL7mSQ2XXrDDJIQFnCROPF0LTuIzSKgKvFi32FGEJtXwEbi8dvH
        rBAHykvMbjwNdiyngK3E1AcL2SBqBCVOznwCtoAZqKZ562ywKyQE+tkles88hGp2kVjU3cwI
        YQtLvDq+hR3ClpE4PbmHBcIul3i6sI8dormFUeJB+0eohLXEnXO/2EB+ZhbQlFi/Sx8i7Cgx
        f/VqFkhQ8EnceCsIcQOfxKRt05khwrwSHW1CENWqEs9P9TBB2NISXf/XQV3mIfGt6zrjBEbF
        WUi+mYXkm1kIexcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITDan/x3/tIPx66Wk
        Q4wCHIxKPLwSvZpxQqyJZcWVuYcYJTiYlUR4GcOAQrwpiZVVqUX58UWlOanFhxilOViUxHmN
        F72MFRJITyxJzU5NLUgtgskycXBKNTDu3qoxcU/whzuK14s23nvHfkf4cMjbgm2qJ0syS61Z
        u3MqHyy4aDN93jIW7gULjGd1VH0/97ImorXl6OW36ufPLO/KvvHOLuuOsbx38eeDM1qvbHlm
        rCxRl2H/obTim2LwEVFhQcXNtu4OG0pj49fMt3gu1cJ6eyH7geAr/dOvSBQ4WV5b9N9ciaU4
        I9FQi7moOBEAE89eFzIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd3szZpxBt/es1psnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTz6NuyitHj8ya5
        AOYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwF
        DYfZC/rYK85P3sjSwNjJ1sXIwSEhYCJxZ256FyMXh5DAUkaJR28+s3QxcgLFpSUaT69mgrCF
        Jf5c62KDKPrEKHGy4QA7SIJNQF/i4NmTYA0iQA2diyYygRQxCxxlklhy5ARYQljAReLE07Vg
        DSwCqhIv9h1mBLF5BWwkHr99zAqxQV5iduNpNhCbU8BWYuqDhWC2EFDN513HWSHqBSVOznwC
        NpMZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYFduO/dyy
        g7HrXfAhRgEORiUeXolezTgh1sSy4srcQ4wSHMxKIryMYUAh3pTEyqrUovz4otKc1OJDjKZA
        T0xklhJNzgdGbF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsae
        8h6GmRJ8q22El2frzxe4/DustvD977Nyxt9Sjs35yyZw6uJGzhsPDmw+9LH7XNhz3RlrF7PP
        NK+NMu9rXTFvkh33u/LcsqPyis3bcptY+zT2qLrwsJ2TiyprlZroyqxVv+9oe9oXp9C5uSdC
        rlRuvMpoKMNyT/rotb7Py6buyd7a8Uz+iokSS3FGoqEWc1FxIgA/ZYrKoAIAAA==
X-CMS-MailID: 20200123145331eucas1p2aaf6eccd724af9edc25a547b6fde7961
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200123145331eucas1p2aaf6eccd724af9edc25a547b6fde7961
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200123145331eucas1p2aaf6eccd724af9edc25a547b6fde7961
References: <20200123145313.27539-1-k.konieczny@samsung.com>
        <CGME20200123145331eucas1p2aaf6eccd724af9edc25a547b6fde7961@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Values printed in dev_dbg are both unsigned long, but were
printed as signed decimals. Change this to unsigned long.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/event/exynos-nocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index ccc531ee6938..ebe9cdf94f54 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -167,7 +167,7 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 	edata->load_count = ((counter[1] << 16) | counter[0]);
 	edata->total_count = ((counter[3] << 16) | counter[2]);
 
-	dev_dbg(&edev->dev, "%s (event: %ld/%ld)\n", edev->desc->name,
+	dev_dbg(&edev->dev, "%s (event: %lu/%lu)\n", edev->desc->name,
 					edata->load_count, edata->total_count);
 
 	return 0;
-- 
2.25.0

