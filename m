Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0D6E7B7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfGSPGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 11:06:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40846 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbfGSPF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 11:05:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719150556euoutp02d722d87f445ae930165025a91d3aeb28~y109NUWiI1348913489euoutp02I
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 15:05:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719150556euoutp02d722d87f445ae930165025a91d3aeb28~y109NUWiI1348913489euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563548756;
        bh=fyMjmMfn0l5YKJT+fwoM+wRhNOzWEgN0K8LCOsydPBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCOdOpkUS61qeGPaOY8eAP6q2D3FrZS0SFz9+ufhnogEbEPEUgr1Sv7Yd2RiVBGwJ
         Jp2ajg4PM98iKIUaMOrid1vRGzWcsU5oetQl+dvJgpK221wIcRF/k8Wi9nBkjD130u
         gSgXNin0ECWCFEOWb8DjbIZu7t+IdnV5ur29pHYM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719150555eucas1p28cbfa8368a5be7629cb64230ecbd5e8c~y108ZNCQW2516125161eucas1p2G;
        Fri, 19 Jul 2019 15:05:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.48.04298.25CD13D5; Fri, 19
        Jul 2019 16:05:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719150554eucas1p2f4c9e4d2767ab740d419c42d4aeed6d5~y107nNPr10285302853eucas1p2P;
        Fri, 19 Jul 2019 15:05:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719150554eusmtrp214c1713e1d8f608c07de267448907369~y107ZEnlG3123131231eusmtrp2N;
        Fri, 19 Jul 2019 15:05:54 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-2d-5d31dc52f6d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.9F.04146.25CD13D5; Fri, 19
        Jul 2019 16:05:54 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719150553eusmtip122f37ac3414ae02ecf0d215111cbebb2~y106pNxfz2871228712eusmtip15;
        Fri, 19 Jul 2019 15:05:53 +0000 (GMT)
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
Subject: [PATCH v3 2/5] opp: core: add regulators enable and disable
Date:   Fri, 19 Jul 2019 17:05:32 +0200
Message-Id: <20190719150535.15501-3-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87rBdwxjDc79ZbTYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlbF/xwr2gjV8FXeObmNtYHzD3cXIySEh
        YCKx+etnpi5GLg4hgRWMEstWfGKGcL4wSsyYdI4dwvnMKHG/9TMrTMu+t7OhqpYzSjy6vhuh
        ZfmOC+wgVWwCqhJbZrwEs0UElCUm35sOVsQs8JNFYsPljWAJYQEXiRVdq5lBbBaghu4pnYwg
        Ni9QfOqpeWwQ6+QlOnfsZgGxOQVcJb4cfM8OUSMocXLmE7A4M1BN89bZzBD1b9klPv5O62Lk
        ALJdJF5OqIQIC0u8Or6FHcKWkfi/cz4ThF0u8XRhH9ibEgItjBIP2j+yQCSsJQ4fv8gKModZ
        QFNi/S59iLCjxNufrcwQ4/kkbrwVhLiAT2LStulQYV6JjjYhiGpdiXn/z0DDTVqi6/86KNtD
        4tuRo4wTGBVnIfllFpJfZiHsXcDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw1Z3+
        d/zTDsavl5IOMQpwMCrx8H64ZRgrxJpYVlyZe4hRgoNZSYT39kv9WCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2M2Ud9Ww9d3iz9WyiO7+7Kr7E985Ru
        SgXoyS74E+KXvFWQbeaXN9lapW1f3umq7JI0fs1zc79t3+NWHkezq0xn5kZULApPuKwo5pCc
        Wby3hn2dVsdlHkffS6aXohn43lcsPa69Mag57p7mmkSvmc4V9R6HXp4VdLCy/OoV/8E67qiz
        hLC7t74SS3FGoqEWc1FxIgDBTZlwcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pBdwxjDa7f47XYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7F/xwr2gjV8FXeObmNtYHzD3cXIySEhYCKx7+1s5i5GLg4hgaWMEo+e
        b2GDSEhLNJ5ezQRhC0v8udbFBlH0iVFiyeJPYEVsAqoSW2a8ZAexRQSUJSbfmw42iVmgk1Vi
        xZMjYEXCAi4SK7pWM4PYLEAN3VM6GUFsXqD41FPzoLbJS3Tu2M0CYnMKuEp8OfgebKgQUM2O
        lfOYIeoFJU7OfAJWwwxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vO
        z93ECIzLbcd+bt7BeGlj8CFGAQ5GJR7eD7cMY4VYE8uKK3MPMUpwMCuJ8N5+qR8rxJuSWFmV
        WpQfX1Sak1p8iNEU6ImJzFKiyfnAlJFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1
        tSC1CKaPiYNTqoEx5sqHwhfXXr2Um+mavkxx+yomVm3L1HUZglWWPeaHLttsOVxRHColtpLX
        /8dvBy9FrzV/Enh3N1668/3Wi5OnnD5xr33WdeLmWl3Jk+nJT3T2P2p6tExPXXc2Q2zyuhz3
        c4FxloFvF1s95zwrb//qsmWO5N2VfR53auf7e2et/L/u9/OFE5P6lViKMxINtZiLihMBRCT9
        VuECAAA=
X-CMS-MailID: 20190719150554eucas1p2f4c9e4d2767ab740d419c42d4aeed6d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150554eucas1p2f4c9e4d2767ab740d419c42d4aeed6d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150554eucas1p2f4c9e4d2767ab740d419c42d4aeed6d5
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150554eucas1p2f4c9e4d2767ab740d419c42d4aeed6d5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add enable regulators to dev_pm_opp_set_regulators() and disable
regulators to dev_pm_opp_put_regulators(). Even if bootloader
leaves regulators enabled, they should be enabled in kernel in
order to increase the reference count.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
Changes in v3:
- corrected error path in enable
- improved commit message
Changes in v2:
- move regulator enable and disable into loop
---
 drivers/opp/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..a8a480cdabab 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1570,6 +1570,12 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 			goto free_regulators;
 		}
 
+		ret = regulator_enable(reg);
+		if (ret < 0) {
+			regulator_put(reg);
+			goto free_regulators;
+		}
+
 		opp_table->regulators[i] = reg;
 	}
 
@@ -1583,8 +1589,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	return opp_table;
 
 free_regulators:
-	while (i != 0)
-		regulator_put(opp_table->regulators[--i]);
+	while (i--) {
+		regulator_disable(opp_table->regulators[i]);
+		regulator_put(opp_table->regulators[i]);
+	}
 
 	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
@@ -1610,8 +1618,10 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	for (i = opp_table->regulator_count - 1; i >= 0; i--)
+	for (i = opp_table->regulator_count - 1; i >= 0; i--) {
+		regulator_disable(opp_table->regulators[i]);
 		regulator_put(opp_table->regulators[i]);
+	}
 
 	_free_set_opp_data(opp_table);
 
-- 
2.22.0

