Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF614FA8
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEFPNM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:13:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50010 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfEFPMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151219euoutp02c7e624e6f8c3df3bb2c7a32ac39eabb0~cILaM_7on3103031030euoutp02D
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151219euoutp02c7e624e6f8c3df3bb2c7a32ac39eabb0~cILaM_7on3103031030euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155539;
        bh=ZYADg2dL+NQeaO3jY1kJ1t8mduIa1Ayf21OKAkoyL3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsiFargvfWWOn8ahJUziHcueFoqOA8F3KJAwsE/RGrR2J9cIMMxQ7/NL26FmT6EKj
         alc12Lrm766SGdpWIgzjXmHiI6sDORGLIvS7oX6B1i+P/MpeqD+GYNJFhSIseWQQok
         4qZuu8D0lOY2ycwxWjZ6VVPCHB7RsXWuK92g2H0E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151218eucas1p20a92bece3de994a2709f6957b102fc9b~cILZCBIsV1252112521eucas1p29;
        Mon,  6 May 2019 15:12:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.02.04298.1DE40DC5; Mon,  6
        May 2019 16:12:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151217eucas1p2c9348f2766870e7c22c2dabaab5d57a1~cILYR35-U0846408464eucas1p2d;
        Mon,  6 May 2019 15:12:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151217eusmtrp2aabc6673e341cbf53a470b5e31536b4f~cILYDm8_K0409004090eusmtrp2f;
        Mon,  6 May 2019 15:12:17 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-3f-5cd04ed17a7c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.6D.04146.1DE40DC5; Mon,  6
        May 2019 16:12:17 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151216eusmtip198c9c097189ca947b1a5a6b20f3bea16~cILXP1k4O0071300713eusmtip1Q;
        Mon,  6 May 2019 15:12:16 +0000 (GMT)
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
Subject: [PATCH v7 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
Date:   Mon,  6 May 2019 17:11:57 +0200
Message-Id: <1557155521-30949-10-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjuO+fs7Exanabmp4bBQkjBmVD5RSEVBqei258ClWzlSS03dcdL
        ZsFSNK8pJWqWXbR0mGFNGyqWOkdW5ryVd0MaapdlpGZ20zydWf+e97m8z8vHR+Eyk8iFClfH
        sBq1MkJO2hGGp987vLr3dwZtKDVi6GFhlQj1zUyI0E2TWYTufbEAdOVFMYZeZqpQjuUjjjo6
        HohRe5JVjAa1a1BP/XUSTWebACrseIKh+6YRMRq6oCNRi/WiCDW+2oOGfq5As8/egu32zOzX
        ywRzTdtFMHVFI2JGX5FOMtnJkyTTPNmAMZdqKgBT3ZbITOvdDkoC7LaFsBHhcazG2++YXdj8
        8AIRNUme+VRWALTgsygDSChIb4Stj6axDGBHyWgdgJnphUAYZgAculZtG6YBvHM3S7wUyezt
        IgWhHMCy1BTyX2S+LG/RRVEkrYC1FdF8wIFOhMN9jTjvwWkrBtt/zBG8YE8fhOaGFoL3E7Q7
        bCsK56GU3gtz3wChyw0OmNNxHksW6d9pxr8HQXpQDAcmrIRg8oeljaO4gO3hh9Ya26Fr4ELd
        TUzAHNRm37YtPQctOcU2z1bY0tol4ntx2gNW1XsL9A7YO5YDeBrSK2D/p1U8jS/Cy4YCXKCl
        MC1VJrjXw5qsTlvRalhemW9bzsCJhnHbE94AsOnXNzIXrC36X3YLgArgxMZyqlCW81Gz8QpO
        qeJi1aGKE5EqPVj8W23zrVO14Gv3cSOgKSBfLn3n3xkkEynjuASVEUAKlztIlePmIJk0RJlw
        ltVEBmtiI1jOCFwpQu4kTVw2GiijQ5Ux7GmWjWI1SypGSVy0wNC8rN+5RDfz2rFZ1+R26bah
        qZY54ksf6svDkDPlHVkSMoVOer/fvO/qqRzXwvzGqDLTat8d6mT2sV+BZee4u2N80lGN8/Dz
        LSaJR/LYFBMdrNvgdeDwXEpM5JBPcWBq+I+AdWddnlYO6nv8dhHnd9OWTZ3qIk9JlKu5VMGW
        r5QTXJjSxxPXcMo/hn8dJFcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7oX/S7EGOyYx2uxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexr87/1kK3rFVvF02nbGB8T1rFyMnh4SAiUT3tYts
        XYxcHEICSxklvk7+BJUQk5i0bzs7hC0s8edaF1TRJ0aJzZfWAiU4ONgE9CR2rCoEqRERqJfo
        f3MJrIZZoIFZYs32q2CDhAX8JO72TmIBqWcRUJU4PSsTxOQV8JaYcI8RYrycxM1zncwgNidQ
        +G/HIbC4kICXxL6Pv1kmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhH24793LyD
        8dLG4EOMAhyMSjy8D2wvxAixJpYVV+YeYpTgYFYS4U18di5GiDclsbIqtSg/vqg0J7X4EKMp
        0EkTmaVEk/OBMZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGR
        y0zkFLvC8dVPnScmTD4ZPflwldTfTrNfK1MlQ0o2eyj9fSUivL70R6bYtheNi7MWqa5uXrB4
        6T2DEMOPRdvuhzd+mqpnlb8mab9kVWTFHS3jwDg5haJ6Y6PKQ9MnsAvFTWKa/9lG7321+0+O
        6GNFa6cdcboRsU7npSHTxrg9n3ZyN02uNzmkxFKckWioxVxUnAgAdPENpbkCAAA=
X-CMS-MailID: 20190506151217eucas1p2c9348f2766870e7c22c2dabaab5d57a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151217eucas1p2c9348f2766870e7c22c2dabaab5d57a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151217eucas1p2c9348f2766870e7c22c2dabaab5d57a1
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151217eucas1p2c9348f2766870e7c22c2dabaab5d57a1@eucas1p2.samsung.com>
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
index 7ebe4d4..81361ea 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -96,6 +96,12 @@ static struct __exynos_ppmu_events {
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
2.7.4

