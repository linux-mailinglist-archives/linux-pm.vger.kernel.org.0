Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAB71815
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbfGWMVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:21:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38681 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389688AbfGWMU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122027euoutp0168afed8eb9523c8ea26be1608cc222b9~0CJnttfEd2865228652euoutp01e
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122027euoutp0168afed8eb9523c8ea26be1608cc222b9~0CJnttfEd2865228652euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884427;
        bh=zWW1b2/PIBAroYQDAGRfN0QElK9yhnrQqfnDmdwgYB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXxrR4HLmaBv3AYFL0vv+6CAQtXmk8MNizb1Gq9Aty/rG26dNINmzIapvbeO0SV6G
         LMJlHfWrPdAT+Tvxpmyty4aT6dYmUKJde2RYK4VK2HhT7CEbiFHzeGGO5zn8o7ENdA
         9G0qQhbroR9Cc5stzHrFeDv9kc326uIs2HuFnXIE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723122027eucas1p21409f43eaeb7b5a1d63972aca1a6fdd0~0CJnJTm171005510055eucas1p2W;
        Tue, 23 Jul 2019 12:20:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.5B.04298.A8BF63D5; Tue, 23
        Jul 2019 13:20:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122026eucas1p2acf705de2a47ba54f383d916f5383144~0CJmfDE3K1104811048eucas1p2Z;
        Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122026eusmtrp175c94b91714185ab48d0a353c2736375~0CJmUTcr02491824918eusmtrp1i;
        Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-82-5d36fb8ab9c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.D8.04140.A8BF63D5; Tue, 23
        Jul 2019 13:20:26 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122025eusmtip2472d7ca264b169f99c872f4d08623443~0CJlnMgmE1852218522eusmtip2B;
        Tue, 23 Jul 2019 12:20:25 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 06/11] icc: Relax requirement in
 of_icc_get_from_provider()
Date:   Tue, 23 Jul 2019 14:20:11 +0200
Message-Id: <20190723122016.30279-7-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2t7t7dx3NrtPwpFI5kshSU1IuKJHRH7eIzAr/SESnXlScD3Z9
        ZAUtK1MzNRf5yFTCV5v5WCpmFqnLIVbDt1Q+wsSK0kzFypDmrpb/fd855/u+c+CQmNSI25PR
        cYmsMk6ukBFiYUv3L6Nr1op38AFtiS/d2d0sohsL63F6ZHEGp8v0b3B6cGmOoAue6Qg6fyJP
        SBuNDSJaNzWM0wNtJQS9cEuP6ELjcwH9SD8mot9dqSHoQvVn4vBWRqfJJJj3w+0EM3HTIGAe
        V1xmOmbbBUxOkwYxC7odp0TnxL4RrCI6mVW6HwoVR2lLmwUJM8T56tcjuAqN41nIkgTqIAzV
        laMsJCalVA0C7Z9MnCeLCCaXvhM8WUBQ9ukO2pBMff0p5BvVCDoeNqN/kpLqftHaFEEdg+zb
        rWYvW0qPQF0+Z5ZglMZEllvMXjZUABQWTJpXEVLO0Fg1j61hCeUHc9PjGJ+3E7QNL8zYkjoC
        WS9vEPyMNfQUfRSuYcw0c7X5HrYWANS8CH5XakxEZCJH4e76pTbwxdAk4rEj9KqzhTzmYPrJ
        BM5LVQh0Vfr1XB/oMvSZGqTJfy/Ut7nzZT8w1M2Yy0BZweg3a34DK8hvKcD4sgQy0qU8dIHy
        lSBeCJCmHV73ZqCsSoXnIafiTacUbzql+H9sOcI0yI5N4mIjWc4jjk1x4+SxXFJcpFt4fKwO
        md6sd9XwoxUt9Yd1IopEsi2ShnavYCkuT+ZSYzsRkJjMVhKg8g6WSiLkqRdYZXyIMknBcp3I
        gRTK7CQXLSaDpFSkPJGNYdkEVrnRFZCW9ipk57qU45pWVOn/yic3PGMwxdNv+wcndVfQ8fse
        4TIH+4yxWdzzelitv3XpKSbQoSDK+e2efV0KZVNiUVu+yrrjWozAYi5q91TFCcWyV7uTu9eu
        PLvA/HSP0ydzw0NsXLb5Djx1RA9GnWt7+s4MVchXy0iBRH0pNNVdjJ8NoKf2B8iEXJTcwwVT
        cvK/gh+yHGIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7pdv81iDZb/5LU4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexup5
        W5kKnrNVLD97nbWB8R5rFyMnh4SAicTjNz9Yuhi5OIQEljJKXD7ayQKRkJD4uP4GVJGwxJ9r
        XWwQRZ8YJc7MecwEkmAT8JTombiDFSQhInCKUWLr8nNgVcwCmxgl7h6fyA5SJSzgL/HjxG2w
        sSwCqhIbl31kBrF5BRwl3j+9xwyxQl5i9YYDYDangJNE19F2NhBbCKhm2/bXjBD1ghInZz4B
        msMBtEBdYv08IZAwM1Br89bZzBMYBWchqZqFUDULSdUCRuZVjCKppcW56bnFRnrFibnFpXnp
        esn5uZsYgXG67djPLTsYu94FH2IU4GBU4uHdsMc0Vog1say4MvcQowQHs5IIb2CDWawQb0pi
        ZVVqUX58UWlOavEhRlOg1yYyS4km5wNTSF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU
        7NTUgtQimD4mDk6pBsbiuo33mbmqM/nc2J0eTVtxrufVjEkL9sSlCmqVTLKr4TGYK/jVX0Kz
        3DVH02diitQM44Xuv7/EfJc6+WnpxJzcPed/3Tp2P/KIWbbnwxUb99Uvck/ee7DU7J+F/p22
        Q59rnp1dZs4lqOopISr7YStPn7DS2Z9q8dX7Nd0zsh74rMvSsWfbJ6bEUpyRaKjFXFScCADU
        5vqx6QIAAA==
X-CMS-MailID: 20190723122026eucas1p2acf705de2a47ba54f383d916f5383144
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122026eucas1p2acf705de2a47ba54f383d916f5383144
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122026eucas1p2acf705de2a47ba54f383d916f5383144
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122026eucas1p2acf705de2a47ba54f383d916f5383144@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch relaxes the condition in of_icc_get_from_provider() so that it
is no longer required to set #interconnect-cells = <1> in the DT. In case
of the devfreq driver for exynos-bus, #interconnect-cells is always zero.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index d566ae0b66c0..2556fd6d1863 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -279,7 +279,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
 
-	if (!spec || spec->args_count != 1)
+	if (!spec)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&icc_lock);
-- 
2.17.1

