Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380B11DCCD7
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEUM24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:28:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57941 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgEUM24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:28:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200521122854euoutp022c44cf626b4b65d4792c0bae7d0c4188~RCuf44xkf0385503855euoutp02p
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 12:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200521122854euoutp022c44cf626b4b65d4792c0bae7d0c4188~RCuf44xkf0385503855euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590064134;
        bh=IZ7CS4NJbb36gBFM7iksoxNTIp+cLNBvatf2Qrqvda0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnCukAShjdWJnjNlsnxyhKu5xMYA7AcHcYs4gnw44FJSxAXrwhkhpaQqzeJKMjYhp
         lSZkefUgBpnrN0VxM8JuCkzIuHcwvDbWAMjuXdMoO3m6MzD49qyMOJO/RgLiU8EFB6
         Sqdn43ayrgt778dWlUl8q7gghVoi04mdgrv0iWJ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200521122854eucas1p13d58441e5d3560cf20fc7fd59a0da85e~RCufpeb3u2046020460eucas1p1r;
        Thu, 21 May 2020 12:28:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.28.60698.60476CE5; Thu, 21
        May 2020 13:28:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122854eucas1p2800cc56585f6f18512de270469cde59c~RCufLf5T_2575425754eucas1p2r;
        Thu, 21 May 2020 12:28:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200521122854eusmtrp1328491783e256f4b1fd7da9e24066663~RCufK3BiY2920829208eusmtrp1Z;
        Thu, 21 May 2020 12:28:54 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-19-5ec674061939
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.8F.08375.50476CE5; Thu, 21
        May 2020 13:28:54 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122853eusmtip26a086964120e0b4a5159e31bd4091706~RCuerkCOi1167511675eusmtip2i;
        Thu, 21 May 2020 12:28:53 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 1/3] interconnect: Export of_icc_get_from_provider()
Date:   Thu, 21 May 2020 14:28:39 +0200
Message-Id: <20200521122841.8867-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521122841.8867-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7psJcfiDE5NVrK4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujCUfZrIVTBKsWHm0gb2B8SZfFyMnh4SAicT5
        nhNsXYxcHEICKxglNm/sYYFwvjBKfJ18FCrzmVFi5/zljDAtVy58YIRILGeUeH2jlRmuZeW/
        a+wgVWwChhK9R/vAOkQEZCT2NE1iBSliFmhikri5eAPQEg4OYQF3iW/rokFMFgFViUnLk0DK
        eQWsJFbu62eBWCYvsXrDAWYQm1PAWmLbsSlMEDWCEidnPgGrYQaqad46G+wGCYFt7BLT/k1k
        g2h2kVj65y8zhC0s8er4FnYIW0bi9GSIPyUEmhklenbfZodwJjBK3D++AOpPa4k7536xgVzH
        LKApsX6XPkTYUeJr1y9mkLCEAJ/EjbeCEEfwSUzaNh0qzCvR0SYEUa0i8XvVdCYIW0qi+8l/
        FogSD4nN/dETGBVnIflmFpJvZiGsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw
        /Zz+d/zrDsZ9f5IOMQpwMCrx8FqkHYsTYk0sK67MPcQowcGsJMK7kP9onBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2Mfu3NvH6bbb9U3q4wm2K0jWUj
        81qF7i8sH+ZqlL/2r74ia3NcWzD+n/IxiW6L2G8BZ6aKRV1899Y6Tur1SS/vzVtdD3V4P9UU
        Foq2E2CzX7Ija9kKzY3utfaNHH3PbWd/Djl9RzvQine2+at91d6PjJa8YOXRPT8xWsndmfv8
        v9jERzUvdy1RYinOSDTUYi4qTgQAP4H41jsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7psJcfiDFbuYrK4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jCUfZrIVTBKsWHm0gb2B8SZfFyMnh4SAicSVCx8Yuxi5OIQEljJKtLU+Zepi
        5ABKSEnMb1GCqBGW+HOtiw2i5hOjxKbdv1lAEmwChhK9R/sYQWwRARmJPU2TWEGKmAV6mCTO
        fF7ADjJIWMBd4tu6aBCTRUBVYtLyJJByXgEriZX7+lkg5stLrN5wgBnE5hSwlth2bAoTiC0E
        VHPxwQF2iHpBiZMzn7CAjGEWUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgRG079nPzDsZLG4MPMQpwMCrx8D5IPhYnxJpYVlyZe4hR
        goNZSYR3If/ROCHelMTKqtSi/Pii0pzU4kOMpkCfTWSWEk3OB0Z7Xkm8oamhuYWlobmxubGZ
        hZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxulblTtOf/yUP92Jb07v3XmhVl/PHDl0nfnd
        jpdx0k9+pn9snfM0s3b+o24dj9trazPmrXJ7MHtmS8Z/r9uvWXRf66dX5ZWcU9zEkmfwyPee
        GbNHsnGQ2Km/7SH5wezzdn/fkLgu/biNuXnX9oufZfljfzJFXFp2iXFSgaFvN5Pna23tjAJl
        TiWW4oxEQy3mouJEAOJEL5O+AgAA
X-CMS-MailID: 20200521122854eucas1p2800cc56585f6f18512de270469cde59c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521122854eucas1p2800cc56585f6f18512de270469cde59c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521122854eucas1p2800cc56585f6f18512de270469cde59c
References: <20200521122841.8867-1-s.nawrocki@samsung.com>
        <CGME20200521122854eucas1p2800cc56585f6f18512de270469cde59c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@samsung.com>

This patch makes the above function public (for use in exynos-bus devfreq
driver).

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ece2a57..1b51e0c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
-static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
@@ -353,6 +353,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	return node;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
 static void devm_icc_release(struct device *dev, void *res)
 {
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 0c49453..c92be2a 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -103,6 +103,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -154,6 +155,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
 	return -ENOTSUPP;
 }
 
+static inline struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
-- 
2.7.4

