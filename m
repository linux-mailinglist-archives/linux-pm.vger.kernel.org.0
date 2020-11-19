Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86F2B903F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSKiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 05:38:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57331 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgKSKiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 05:38:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201119103759euoutp022542de3799eda3f6394f316a6324310b~I4nmwyDe82931129311euoutp02S
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 10:37:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201119103759euoutp022542de3799eda3f6394f316a6324310b~I4nmwyDe82931129311euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605782279;
        bh=KFD0Vzmbn9PS7ku6CjqnxCRamBD3MuZZvnmwByRjSP4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=F+SkgybMKLnCn0XyT7jK4/z3FNjct0NQKhdTrxg27a477pMHEMsQq4fo9PUinl1XS
         +0ijMYPJ+D5DLMvzvHx1LxDMVmV522FGq+nONSGh6HZFrDWSYL/kwkA7WQVJK7gjlc
         dtZKUCZelRp5anku5zHVVnJbOMZSRfm2/jHd+3pk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201119103754eucas1p14d45a929127de736b36c33aa24c93884~I4nh7QPX-0640606406eucas1p11;
        Thu, 19 Nov 2020 10:37:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.5C.44805.20B46BF5; Thu, 19
        Nov 2020 10:37:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16~I4nhjTFWe0640606406eucas1p10;
        Thu, 19 Nov 2020 10:37:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201119103753eusmtrp19e4eedb547f76bd6bca4eaf6de5a5409~I4nhipIb31120911209eusmtrp1c;
        Thu, 19 Nov 2020 10:37:53 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-af-5fb64b02b3db
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.61.21957.10B46BF5; Thu, 19
        Nov 2020 10:37:53 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201119103753eusmtip16a5caf50808dfaa470607f364b8b0f0e~I4nhB1_iS2587025870eusmtip1O;
        Thu, 19 Nov 2020 10:37:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] interconnect: fix memory trashing in
 of_count_icc_providers()
Date:   Thu, 19 Nov 2020 11:37:46 +0100
Message-Id: <20201119103746.32564-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7pM3tviDTra2S02zljPajF97yY2
        i02Pr7FaXN41h83ic+8RRou1R+6yWxx+085q0XXoL5sDh8eCTaUed67tYfPYvKTeo2/LKkaP
        z5vkAlijuGxSUnMyy1KL9O0SuDI23prMXHCKvWLD0i2MDYzb2LoYOTkkBEwkZiz/wdrFyMUh
        JLCCUWLv8mfsEM4XRomdr28yQzifGSX+377LCNNy+vA3JojEckaJj927mOBapq75xAxSxSZg
        KNH1tgtsiYjANkaJ90eSQYqYBaYAdfydxwqSEBYIkPjy6DHYWBYBVYlFE6aD2bwCthKnN1xn
        hlgnL7F6wwGwOyQEWjkkdu+Yyw6RcJG49+sKC4QtLPHq+BaouIzE6ck9LBANzYwSD8+tZYdw
        ehglLjfNgPrCWuLOuV9A93EA3aQpsX6XPkTYUeLk66usIGEJAT6JG28FQcLMQOakbdOZIcK8
        Eh1tQhDVahKzjq+DW3vwwiWomz0klr3dyQRiCwnEShzdv51xAqPcLIRdCxgZVzGKp5YW56an
        FhvlpZbrFSfmFpfmpesl5+duYgSmhdP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeNdqbo0X4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzpu0ZU28kEB6YklqdmpqQWoRTJaJg1OqgSnZQmni04y7B35U
        n1n/W/ry2jU39l2baLs/KccofknCh6fH3TstMyYIftymXR1SMo05h/9zwIVv62WY9mWHF65I
        EWYUZkpJaK97VPxBdHKDqUaw3NwOpY1vJhjNv7FfeOvqqUp+OnJtYb2n/t2cdzJnnZPew0cX
        wie1/pCcOLdo26VnfF5Kx32/nv2iX81uvPbUnt8/82o8uaM/p87a7bDk2Ufuq/LaHx9ublPT
        SUnNz1I7Hdwha/EzfH3ZzdxY90JXU8e5SxvDF/oc3rF5Zvn8IMcl5qkzNA/HhRay1R9eHH47
        1lrI7HVBR+OPxoDAHP5vJ8JVDR+vmfLi3fLKGcd39hYvPOO6P2LjhL4/BqJKLMUZiYZazEXF
        iQCKrvhvegMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t/xu7qM3tviDQ7u1LfYOGM9q8X0vZvY
        LDY9vsZqcXnXHDaLz71HGC3WHrnLbnH4TTurRdehv2wOHB4LNpV63Lm2h81j85J6j74tqxg9
        Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MvYeGsyc8Ep9ooNS7cwNjBuY+ti5OSQEDCROH34G1MXIxeHkMBSRonHy3exQiRkJE5Oa4Cy
        hSX+XOtigyj6xChx+V07WDebgKFE11uIhIjALkaJPQ2TmUEcZoFpjBKnni4GqxIW8JN4tv4O
        O4jNIqAqsWjCdEYQm1fAVuL0huvMECvkJVZvOMA8gZFnASPDKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMBw3Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEd63m1ngh3pTEyqrUovz4otKc1OJD
        jKZA+yYyS4km5wMjIq8k3tDMwNTQxMzSwNTSzFhJnHfr3DXxQgLpiSWp2ampBalFMH1MHJxS
        DUwuHRZqfYKvZ8Tfc3wZ5XFqj9mNl9kX2nev//mk/4vKy/9Te4y0+7glz7EtYZ4Vf3VrndLv
        CM3yTVt+rP/0fIvfy56X584K19cxH93Ix7++QyuvtVxt1aKLm5V3mPtUGv3s6nM7sfPRTeWT
        r622ejS+XvC5NUWgarZXUPy5c6eP9h1Rfdb9ZP4Z1iiLuOWt29cYf2a2vnMsd5Ps9oJd7Grn
        RQ1qnk5Y4prHz6QbzFy1XlI3PDz80N3ip9P3FB661CbSZDv9+6Pr+x4FcO3VLFVxFNJbuyW8
        vFlXsfZdeGboRL3DS5bIPJhoyOKym3OveUvYskj2ec5LmBu9753+Wu5+/t6145nf7nFv8Pz3
        d7e2EktxRqKhFnNRcSIAzXFpdNACAAA=
X-CMS-MailID: 20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16
References: <CGME20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

of_count_icc_providers() function uses for_each_available_child_of_node()
helper to recursively check all the available nodes. This helper already
properly handles child nodes' reference count, so there is no need to do
it explicitely. Remove the excessive call to of_node_put(). This fixes
memory trashing when CONFIG_OF_DYNAMIC is enabled (for example
arm/multi_v7_defconfig).

Fixes: b1d681d8d324 ("interconnect: Add sync state support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/interconnect/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 974a66725d09..5ad519c9f239 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1083,7 +1083,6 @@ static int of_count_icc_providers(struct device_node *np)
 			count++;
 		count += of_count_icc_providers(child);
 	}
-	of_node_put(np);
 
 	return count;
 }
-- 
2.17.1

