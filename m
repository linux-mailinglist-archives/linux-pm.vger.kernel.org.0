Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC585DB9
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfHHJC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 05:02:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59894 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbfHHJCz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 05:02:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808090254euoutp013f9acdb433fda173df6cb552e624dae6~45xsV_OkS1912219122euoutp01N
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 09:02:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808090254euoutp013f9acdb433fda173df6cb552e624dae6~45xsV_OkS1912219122euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565254974;
        bh=uK2H2CY5YVkbPXh3EKmhTQmAPpi5mTFt1H3u7NFbf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYPKv9CisR+UF202TRHf4jqXzAqQShDRULjROkz37kNF/mA2dGJteJUt3QoLBNbcz
         461B5SlCTqSpa5K3oZ/zJLDD5evvdpPWb4EzF3Ul4ZnSaD7wrvgrR6ajM3eGin87md
         wsXq7jG/pkVpoicUvGt3abzZI92BPGaFtMWEcA9c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808090253eucas1p1052985fcc9af22168ed4480c9a027637~45xrw0RSf1971519715eucas1p1B;
        Thu,  8 Aug 2019 09:02:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.9E.04469.D35EB4D5; Thu,  8
        Aug 2019 10:02:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808090252eucas1p1be186b7a34fa75073fddca120c292f04~45xq-4Wln0879608796eucas1p19;
        Thu,  8 Aug 2019 09:02:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808090252eusmtrp2ead827ae93f6a338cf8c2d2c4a3ecd55~45xq-Sb2T0889008890eusmtrp2C;
        Thu,  8 Aug 2019 09:02:52 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-46-5d4be53d1584
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.B1.04117.C35EB4D5; Thu,  8
        Aug 2019 10:02:52 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808090251eusmtip2c7bb3e0bb2f5f86d0937dc0a10dafa2d~45xqP_hYf3174031740eusmtip2K;
        Thu,  8 Aug 2019 09:02:51 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [RESEND PATCH v5 4/4] dt-bindings: devfreq: exynos-bus: remove
 unused property
Date:   Thu,  8 Aug 2019 11:02:34 +0200
Message-Id: <20190808090234.12577-5-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzM7O+PSyLgVHdQKN4JK8oGFF8ooerBqgV8zpFYdVHJ12VXT
        /JDZQ13IIvNZqFG2tqn5fuZa6+Km+UjFtEKz1ILSSk0pyczZMfTb7/zv/3/POZfLkPK3lCMT
        ERXDa6NUkQqpTFLb9rtnj8+Ef5BHxgCDK3KeUHjw52cKF1i6KZxuWkL4xthXEvf0lNO4K3mS
        xpVjrync33hXimevWxDO6TERuNQyTOOiwV4Cv7tULMWTv7oIfLXZQuO/ryskuGq0TXpIrizJ
        L0HKSmOaVFn14KLy+benhDK92oiU1qE6QjlbuTWADpQdCOUjI+J4rfvBs7LwsoYTmmEmPqu5
        gEpCrbQeMQxwe0HfEqNHMkbOFSN43JImFYufCDqyM0k9slsuZhG0TdsJLATu1b+lRd2AIMMC
        q4GucVtAynnDx7pOQuCN3HbIGMkmBRPJ/ZZAeX+FLb2BOwWmiikkjCHhdsCiyVWQWe4oXHtj
        lYjNtkFafZON7bhjUGpsl4geB2jPHbcxuey5XHPHdj9w0zQs3Hq/Ej4KA32LSOQN8MVaTYvs
        DEsNBYTI52HiXjothq8gGE2ZXgnvh1ZrLyUMR3K74Emjuygfhu6+fEJ8OnsYmnIQZ7CHW7XC
        joLMQuo1uejeA/lLnZTITqBfKqNEixLmmumbyCVvzTJ5a5bJW21biEgj2szH6tRhvM4zij/v
        plOpdbFRYW4h0epKtPzjXv61ztSjub5gM+IYpFjPal74B8kpVZwuQW1GwJCKjexInG+QnA1V
        JVzgtdFntLGRvM6MnBiJYjObuG70tJwLU8Xw53hew2v/nxKMnWMS8nZYSIy/sm9wr6EmcdLp
        q+/Aq9RNrhBfy1JNj+oWMhftfee3JKfLy263BpQlm0cLaowphn6XmvKdx19orCaPoqpc2Td1
        WshUofn+TS//H25vzupjDRNh8xrWL+TTiXlzp89A33BDlt+zP8FIn+Ls1dvx8Dt7MvCD15yf
        QXHEMKOQ6MJVnrtJrU71D5VwGedtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7o2T71jDSaclrfYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7Fup0/BXY6KaXvnszYwHmbvYuTkkBAwkVi44xaQzcUhJLCUUeL3gmeM
        EAlpicbTq5kgbGGJP9e62CCKPjFKPNq8kBkkwSZgLvFo+xmwIhEBZYnJ96YzgxQxC3SySqx4
        coQNJCEsEC7xuP8D0AoODhYBVYm/+7RBwrwCLhJtN4+zQCyQl+jcsRvM5hRwlVi76iSYLQRU
        s/H9dVaIekGJkzOfgMWZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJucWleel6
        yfm5mxiBMbnt2M8tOxi73gUfYhTgYFTi4S044R0rxJpYVlyZe4hRgoNZSYT3XplnrBBvSmJl
        VWpRfnxRaU5q8SFGU6AfJjJLiSbnA9NFXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs
        1NSC1CKYPiYOTqkGRrsW0eMyj04tnixwnuOEk12+8bzJiz2WKy46VhF0oMzvj9KGRe4Pj+Qu
        4Dh+4PWt8h7nH3yP+JRe7V9z9OnNmZ8/H6r01BCsPC9hXDT3nanPF64FXFIH4napsbXdaNIv
        2FoUv9Vn4+yOnotbtkrnGnrfOLP56aNPristQ+8t+f1O+spRt7SZjAeUWIozEg21mIuKEwGw
        5K803wIAAA==
X-CMS-MailID: 20190808090252eucas1p1be186b7a34fa75073fddca120c292f04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808090252eucas1p1be186b7a34fa75073fddca120c292f04
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808090252eucas1p1be186b7a34fa75073fddca120c292f04
References: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
        <CGME20190808090252eucas1p1be186b7a34fa75073fddca120c292f04@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unused DT property "exynos,voltage-tolerance".

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index f8e946471a58..e71f752cc18f 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -50,8 +50,6 @@ Required properties only for passive bus device:
 Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
-- exynos,voltage-tolerance: the percentage value for bus voltage tolerance
-			which is used to calculate the max voltage.
 
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
-- 
2.22.0

