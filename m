Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308A7E74E9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfJ1PVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:21:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54811 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfJ1PVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:21:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191028152058euoutp0177edac70faaec21ff0c36846d6b9d4a2~R2L6fNUlX2060820608euoutp01T
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:20:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191028152058euoutp0177edac70faaec21ff0c36846d6b9d4a2~R2L6fNUlX2060820608euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572276058;
        bh=8u5xWoYyD4lV76XSA5qxTTtYppeum6IaxfhGkN5SqO4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mABeSdYmgZDqQ10eeUKq2eI853KJ8qfg7sCh4LB1Fi8aVdGEZgCoRbksTPyS1o7vC
         D8DSGhCOXL56jdxW7FRr7d+bzxbbKrKJDLcG+r6Qhlnxtm236QK1yhwAOXiX9nnzMe
         3DdRy4X89Vaun7rbMNZjJx0RnEr2msi9jqAACP/s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191028152057eucas1p2c7813263b58ddb6d236696ad5865d7d9~R2L58WHo31162311623eucas1p2p;
        Mon, 28 Oct 2019 15:20:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B0.A6.04469.95707BD5; Mon, 28
        Oct 2019 15:20:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be~R2L5dF5mK0794107941eucas1p16;
        Mon, 28 Oct 2019 15:20:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191028152057eusmtrp1d8ff536809f9372284701f9d668df060~R2L5cbd7H1762917629eusmtrp1e;
        Mon, 28 Oct 2019 15:20:57 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-56-5db70759c392
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.E7.04117.85707BD5; Mon, 28
        Oct 2019 15:20:57 +0000 (GMT)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028152056eusmtip100260ab716b3016cf82f84f9fa5f1862~R2L5ApcUk2332823328eusmtip1R;
        Mon, 28 Oct 2019 15:20:56 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/3] soc: samsung: Drop "syscon" compatible requirement from
 the chipid driver
Date:   Mon, 28 Oct 2019 16:20:48 +0100
Message-Id: <20191028152050.10220-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87qR7NtjDWb2yVpsnLGe1WL+kXOs
        FufPb2C32PT4GqvF594jjBYzzu9jslh75C67ReveI+wWh9+0s1psfnCMzYHLY9OqTjaPzUvq
        Pfq2rGL0+LxJLoAlissmJTUnsyy1SN8ugSvj3cRfbAVLOCs+fP7C2sD4hr2LkZNDQsBE4veS
        fcxdjFwcQgIrGCXW995ihXC+MEocPtoMlfnMKHH+7EUmmJbrk54xQSSWM0p8PDaBEa5l5/11
        YIPZBAwleo/2MYLYIgLqEt17prCDFDEL/GGUaN0ygRkkISyQILH+6ixWEJtFQFXi1JWNYHFe
        AWuJaXN7oS6Ul1i94QAzhP2YTeL9bAEI20Vi4qp7bBC2sMSr41ug6mUkTk/uYQFZJiHQzCjR
        s/s2O4QzgVHi/vEFjBBV1hKHj18E2swBdJKmxPpd+hBhR4lz29Yxg4QlBPgkbrwVBAkzA5mT
        tk2HCvNKdLQJQVSrSPxeNR0aKlIS3U/+s0DYHhIft74Fs4UEYiVed69jm8AoNwth1wJGxlWM
        4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBCeL0v+OfdjB+vZR0iFGAg1GJh3fC5W2xQqyJ
        ZcWVuYcYJTiYlUR4L54BCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBa
        BJNl4uCUamAM/dy9+u2bptWnWAUYti7ddnPTN/9LWTZPmHMrVatmnNMP2nNv1+ZoL0W+JwvE
        JMMyfhYtVlQ/N+nBk0Bxi/NT5OUcZ39I11gQUqJr2qy5W8avvo5nvz/Pl2mzXaTvqJ7Z7MiQ
        2aAfNOvkv4e8imodIp3Gdnt//+Xv21VVc4nnvTzDNJPXm5uVWIozEg21mIuKEwG2wRfeDAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xu7qR7NtjDe6qW2ycsZ7VYv6Rc6wW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyWHvkLrtF694j7BaH37SzWmx+cIzNgctj06pONo/NS+o9
        +rasYvT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+PdxF9sBUs4Kz58/sLawPiGvYuRk0NCwETi+qRnTF2MXBxCAksZJV7/fczcxcgB
        lJCSmN+iBFEjLPHnWhcbRM0nRom5xycwgiTYBAwleo/2MYLUiwhoSpxbaAYSZhZoYZJYd9QR
        JCwsECfx5FwFSJhFQFXi1JWNzCA2r4C1xLS5vVAnyEus3nCAeQIjzwJGhlWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiB4bjt2M8tOxi73gUfYhTgYFTi4X1xdVusEGtiWXFl7iFGCQ5mJRHe
        i2eAQrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4HxkpeSbyhqaG5haWhubG5sZmFkjhvh8DB
        GCGB9MSS1OzU1ILUIpg+Jg5OqQbGcqZPn0/tXhC8S3n5RcPbmyzZPRd0+E7aeefdk2jBR0t+
        WgdOc6+K2N6bdK5OTZ7vfWOaxqqDGxR4wp8+Z2veGRiy59jUS3elfIS3nL0QP+/uC377148W
        KhQUbDm2eBNzWJX0zz9RviXVu/42S09xcLVZw7q8dVeR1/x5ke7vfqjI56RGMBwOVGIpzkg0
        1GIuKk4EANitH+RdAgAA
X-CMS-MailID: 20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be
References: <CGME20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As we dropped the requirement of "syscon" compatible in the chipid
nodes rework code acquiring the regmap to use device_node_to_regmap()
rather than syscon_node_to_regmap().

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 25562dd0b206..b89c26a71c6e 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -50,12 +50,20 @@ static int __init exynos_chipid_early_init(void)
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device_node *root;
+	struct device_node *syscon;
 	struct regmap *regmap;
 	u32 product_id;
 	u32 revision;
 	int ret;
 
-	regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
+	syscon = of_find_compatible_node(NULL, NULL,
+					 "samsung,exynos4210-chipid");
+	if (!syscon)
+		return ENODEV;
+
+	regmap = device_node_to_regmap(syscon);
+	of_node_put(syscon);
+
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.17.1

