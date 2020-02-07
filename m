Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43CC1552B9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 08:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGHHE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 02:07:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58684 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGHHE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 02:07:04 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207070702euoutp02ae31de7e141bf9539374e90cad89335b~xDPxTxEhw3120531205euoutp02b
        for <linux-pm@vger.kernel.org>; Fri,  7 Feb 2020 07:07:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207070702euoutp02ae31de7e141bf9539374e90cad89335b~xDPxTxEhw3120531205euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581059222;
        bh=2XVmTi7MvAKEIBVHNlJKT2g1VeCyuBW7a1g9FJGZX/g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sEetgeKvvTbNXPegkuBTKIUjLy+jkh7g3+LHwiiwIz0b3wsSo6hosY2a7bz5CW82f
         ajEvl11wg/85PE3HifHFShzbZnGRKW1QHYVNfQqT/NIX7MPefdx6PmTBG33ZVX9TDt
         pIKF+1OMMHJtnYXez1G+9BX/jsGiqed60AB3Em8Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207070701eucas1p1bfe30ee84ce8d906804bae1ad61b09f0~xDPw9p8eE2945429454eucas1p1D;
        Fri,  7 Feb 2020 07:07:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.AB.60698.59C0D3E5; Fri,  7
        Feb 2020 07:07:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207070701eucas1p2d6422d731f031ee66737683b54085ac7~xDPwotC6_2965429654eucas1p28;
        Fri,  7 Feb 2020 07:07:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207070701eusmtrp2f8f8a9c82c9af838fe57937792831e0e~xDPwoIQhv3034730347eusmtrp2D;
        Fri,  7 Feb 2020 07:07:01 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ec-5e3d0c95d9d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 21.DD.08375.59C0D3E5; Fri,  7
        Feb 2020 07:07:01 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207070700eusmtip180c73adadb1b89532ec3db2bdeaf7af9~xDPwQtecO1760517605eusmtip1E;
        Fri,  7 Feb 2020 07:07:00 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] soc: samsung: chipid: Fix return value on non-Exynos
 platforms
Date:   Fri,  7 Feb 2020 08:05:52 +0100
Message-Id: <20200207070552.26986-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7djP87pTeWzjDH6sUbPYOGM9q8X58xvY
        LT73HmG0mHF+H5PF2iN32R1YPTat6mTz6NuyitHj8ya5AOYoLpuU1JzMstQifbsErozFJ3az
        FDxmrfjRntrA+Jmli5GTQ0LAROLhv3usXYxcHEICKxglGrp62SCcL4wS8+YuY4ZwPjNKnF+y
        jBGmpf/AMUaIxHJGiSeb3zPBtfxsncoKUsUmYCjR9baLDcQWEbCXuP1kGTtIEbNAH6PE9b1z
        mUESwgKBEn/2rAayOThYBFQlvu+XAgnzCthK9H75DnWgvMTqDQfAzpAQ2MEmcWfRM2aIhIvE
        nwNL2SBsYYlXx7ewQ9gyEv93zmeCaGhmlHh4bi07hNPDKHG5aQbUE9YSd879YgPZzCygKbF+
        lz5E2FHiZ0sPK0hYQoBP4sZbQZAwM5A5adt0Zogwr0RHmxBEtZrErOPr4NYevHAJ6jQPicOH
        l4DdLyQQK3Fn4Tn2CYxysxB2LWBkXMUonlpanJueWmycl1quV5yYW1yal66XnJ+7iREY5af/
        Hf+6g3Hfn6RDjAIcjEo8vAmONnFCrIllxZW5hxglOJiVRHjP61vGCfGmJFZWpRblxxeV5qQW
        H2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cAYcz3j5+pPSuuVbbZ5li58dG5971e1
        GYofY7SDj+2/KWJUEPEn+uCXvGPCT/j3bZC1ed2ScVdA2uCP5tbZKqcNJESMw/w3VNvmBJyw
        bPCZv7tXwnyCb5DsbBvzU1FHlgQXJfDfD2tlmPDjstvK3oSOzRectVSWLcrlcayQ5f7/1Ppu
        p8bCYwFKLMUZiYZazEXFiQD6gZa57gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsVy+t/xu7pTeWzjDHrXCFtsnLGe1eL8+Q3s
        Fp97jzBazDi/j8li7ZG77A6sHptWdbJ59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbiE7tZCh6zVvxoT21g/MzSxcjJISFg
        ItF/4BhjFyMXh5DAUkaJw0u+skEkZCROTmtghbCFJf5c62KDKPrEKPFs2iQmkASbgKFE19su
        sAYRAUeJFzs/s4MUMQtMYJQ43zkDLCEs4C+x8/5moEkcHCwCqhLf90uBhHkFbCV6v3yHukJe
        YvWGA8wTGHkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAytbcd+bt7BeGlj8CFGAQ5G
        JR7eBEebOCHWxLLiytxDjBIczEoivOf1LeOEeFMSK6tSi/Lji0pzUosPMZoC7Z7ILCWanA8M
        +7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxiXcoWdouN0uO4
        TgruefdG5GBi/fQzCn+PKG1+XKmzieMyz+b1p5V95ZJye3YEMYkfnK2h3sLkvbTzzavfvjdU
        RLad/7NtUtI8dxvBb/ZHWVwe/e15/drqZ9LJY394lyVvONj8wLJ4o6DbqeKXbPMFZ6tURfln
        cvzkLbnz9VFljhgDf73L7W9KLMUZiYZazEXFiQBiWM6IQwIAAA==
X-CMS-MailID: 20200207070701eucas1p2d6422d731f031ee66737683b54085ac7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207070701eucas1p2d6422d731f031ee66737683b54085ac7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207070701eucas1p2d6422d731f031ee66737683b54085ac7
References: <CGME20200207070701eucas1p2d6422d731f031ee66737683b54085ac7@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Correct the probe return value to -ENODEV on non-Exynos platforms.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 2dad4961a80b..8d4d05086906 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -59,7 +59,7 @@ static int __init exynos_chipid_early_init(void)
 	syscon = of_find_compatible_node(NULL, NULL,
 					 "samsung,exynos4210-chipid");
 	if (!syscon)
-		return ENODEV;
+		return -ENODEV;
 
 	regmap = device_node_to_regmap(syscon);
 	of_node_put(syscon);
-- 
2.17.1

