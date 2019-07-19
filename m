Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AA6E7AC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfGSPGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:06:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51692 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfGSPF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 11:05:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190719150558euoutp011371bf781fbf23fd0fbadec5a6bd2280~y10-LlKs21874018740euoutp01F
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 15:05:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190719150558euoutp011371bf781fbf23fd0fbadec5a6bd2280~y10-LlKs21874018740euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563548758;
        bh=uK2H2CY5YVkbPXh3EKmhTQmAPpi5mTFt1H3u7NFbf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv4tnf/AnT0cnBAVTYhsnwdjULtrEcwhihAwb6cftM4K/SYNaSUOK9FRLT4cX3XNE
         SuOZHyUCI4RJdmQbZxnZy+yes3F3iV3EzNLnkGl1FnfRH+UA6KjEaSG5yXidmVtyI9
         buYpQC1MciosWsMQ5MVkumLT8zHK6/dg2CgHKZgo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719150557eucas1p2266c376b4f71c2df9f0d45e273004c64~y10_f-qVu2491724917eucas1p2I;
        Fri, 19 Jul 2019 15:05:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.19.04377.55CD13D5; Fri, 19
        Jul 2019 16:05:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719150556eucas1p2bc6f133c48ec1be9b36119a414887969~y1092WE_s1668816688eucas1p2D;
        Fri, 19 Jul 2019 15:05:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719150556eusmtrp2e4660feafb9c13e5be61d014a8ff74d1~y109oQf353114831148eusmtrp2C;
        Fri, 19 Jul 2019 15:05:56 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-7b-5d31dc553c0b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.9F.04146.45CD13D5; Fri, 19
        Jul 2019 16:05:56 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150555eusmtip1ce8f0fdb626b0b71e4a3c68029e11ac2~y108yjwBz2871128711eusmtip10;
        Fri, 19 Jul 2019 15:05:55 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
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
Subject: [PATCH v3 5/5] dt-bindings: devfreq: exynos-bus: remove unused
 property
Date:   Fri, 19 Jul 2019 17:05:35 +0200
Message-Id: <20190719150535.15501-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRz1u4/d62pynYYfKoaLpILyQcEXRlQYLQgqe0APyZUXlZzKbvNV
        kT00N2iZVtoKNdIU89HmMh8pvtp6+Egis3QiuShNLdtIjXK5Xa3+O7/zO+c7vwMfjYuHSG86
        Nv4Uq4iXxUkEQqLWONu99sBgcETQz4teSJdfTaK3tk8kKuzoJpGm2Q7Q1ZEvOOrpeUihrgvj
        FNKP9JHodcMdAbJe6QAov6cZQ5UdZgqVvO3F0MD5MgEan+nCUEZTB4Xm+nQEqhk2CraIpRUF
        FUCqL1cJpDXF56Stk08wqcZQDqSm/seY1Kr320MdFm6KYuNik1hF4OZIYUxV/a5EM51ys6mQ
        TAftlBq40pBZDzV53QI1ENJipgzAG9ctFD/YAFQNTBL8YAXQ1DBGLFpaB9UYvygFsKqij/hr
        sVt7cYdKwKyEhvxRZ4gnswLmDuXhDhHOzBLw4Wudc+HBhEOtxQgcmJg3vMmsdZpFTBj88evR
        woXLoaqu0RntymyHttavFK9xh89vWZw8Pq+5+Og2zusnKJj7zpPHYdCWVYjx2AOOmQwLb/pC
        e/0inww/3tU4S0PmEoDDl6cWeobCdlMvqQb0fMBqWN0QyNNb4efvc4SDhowb7J9w509wgzm1
        jo4OWgSzMsW8ei0ssHeSPPaBanvVApbCqQktyAb+2v/KaP8ro/2XWwTwcuDFKjl5NMuFxLPJ
        6ziZnFPGR687kSDXg/lf93LOZKsDDb+OtwGGBpKlom/vgyPEpCyJS5W3AUjjEk/RwGhghFgU
        JUtNYxUJxxTKOJZrAz40IfESnXYZPiJmomWn2JMsm8gqFrcY7eqdDiJXcTOV7O8XAeZlFuWZ
        a/5+yGSrMUeGgfqxtJYdatWd4o1n65ZseHrvS+Y5TO2mS6qbdTl09GzOtmfGEItQHbCv12d/
        0VB2askDfaPZPTzZ6LL3YP80JZ4yHP8Qm2caVmrcU0Jf7XaxGqdLN7QZwu936nxb5Bk9zGR/
        0PROVbiE4GJkwWtwBSf7A16+BApxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7ohdwxjDZZ9VbbYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7Fup0/BXY6KaXvnszYwHmbvYuTkkBAwkTh4p4upi5GLQ0hgKaPEqr+r
        2CAS0hKNp1czQdjCEn+udbFBFH1ilLj5expYgk1AVWLLjJdgk0QElCUm35vODFLELNDJKrHi
        yRGwScICARL/L/5kBbFZgBqutm1jBrF5BVwkvv3ZCnWGvETnjt0sIDangKvEl4PvweJCQDU7
        Vs6DqheUODnzCVgNM1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/
        dxMjMCq3Hfu5eQfjpY3BhxgFOBiVeHg/3DKMFWJNLCuuzD3EKMHBrCTCe/ulfqwQb0piZVVq
        UX58UWlOavEhRlOgJyYyS4km5wMTRl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTU
        gtQimD4mDk6pBkbbbu/i7r5Vzu7Ob8+U790f9rBE/s/ShhvV7sXu//fm9emkBG5hf31zasVf
        r0kOetdOOnHtuntpmpzI4ZRrpg/3rTjmX73yqsHe1WrP/L9dPXauWCA/v4Ypzfd1sxaLNuPM
        J27vI7ZJTvzTr23Cd+DY7LNFIXe/ZU79YR8prH6J23jNGe1XK6SUWIozEg21mIuKEwGyGisE
        4AIAAA==
X-CMS-MailID: 20190719150556eucas1p2bc6f133c48ec1be9b36119a414887969
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150556eucas1p2bc6f133c48ec1be9b36119a414887969
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150556eucas1p2bc6f133c48ec1be9b36119a414887969
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150556eucas1p2bc6f133c48ec1be9b36119a414887969@eucas1p2.samsung.com>
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

