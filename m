Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5237B7C58
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbfISOYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46487 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390495AbfISOX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142325euoutp018ebf43ea6529e58fac0524eb62d8a63d~F3PiUGxjQ2320923209euoutp01B
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142325euoutp018ebf43ea6529e58fac0524eb62d8a63d~F3PiUGxjQ2320923209euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903005;
        bh=9vBjzZ8WEuvpoJoW1P0oRATI3VJ/Xiwt0zbgAf9dLLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otKnG8UDxVe3aVHAwOIivSEkiKqULW6U8Tsh8VzfzDcuu9j5ZR5EqwubCZ0SOz0mF
         deGwxb0BMfEe14kPkAYgI9UK4uAeQWYH+TSoSF1J9zKKy4xAu0j992L7W4K5KWyxX+
         4Q0wyoE7/ELJfjja2IXbPVWASXg+BJiPpyVPovjs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142324eucas1p2c6dcf28205c412e8ae407490ef04a781~F3Phm-q8v2469924699eucas1p2I;
        Thu, 19 Sep 2019 14:23:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.59.04374.C5F838D5; Thu, 19
        Sep 2019 15:23:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142323eucas1p2fc73a765389432f880fa28945fd28975~F3Pgz1CDa3081730817eucas1p2n;
        Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190919142323eusmtrp20894d9aa07c91aa87c9b5ad91c68b53b~F3Pglrtp-3074530745eusmtrp2c;
        Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-f9-5d838f5c29a2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.0F.04166.B5F838D5; Thu, 19
        Sep 2019 15:23:23 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142322eusmtip13d904712bb324cac14c4bb82ec7db1dc~F3PfwIqp63226332263eusmtip1A;
        Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 03/11] devfreq: exynos-bus: Change goto-based logic
 to if-else logic
Date:   Thu, 19 Sep 2019 16:22:28 +0200
Message-Id: <20190919142236.4071-4-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3OdGgsGQqEAxKXRh5Ewd1clBiJmkzkxcSEB7WRKiOgbOmw
        iIaILC6oqKCBFhAkFRBEsSyBimxWNpHaICgBhARU1AhRqEZDQMoU5e079/z/OedPLk3Ih0g3
        OjQimlNHqMIUlFRc0/rb5HX0RrJyU1OKM25prZbg4bupCD/Jfkzit9OfSJxv7CbxG8skhbOe
        6SmcMXxTjE2mCgkuGfpOYv1oH4l7DLkUnrpuRDjb1CDC5cYhCR64UELh7MzP1B4HVl96hWIH
        ++opdvhqm4it1J1nn0zUitjmiXoRm15Vitgp/cqD9GGpbxAXFhrLqTfuDpSGdGrLJFFF0jON
        pm6UiLLoNGRHA7MNxscqqTQkpeVMCYKp1lkkFNMIbnXVkEIxhSD/dz9atMxYLDZLMYJL1wqp
        f5bRvFSxVUUxfpBxZ0RibTgxRgSZBZNia0EwOhGk55iINETTjowSfnb5WA1ixgNul3aRVpYx
        GJLeVxDCulVQVtG0wHaMD0w35IsFjQN0aMYWmJjXJFfn2PQXaHhR6CXwPsi72i4R2BG+tFXZ
        2B3m6vJFAvPwoW54IScwiQj0RUbboF3wvM1MWu8kmHXw2LDRijAf7Gmuq4D28O6bg3CBPWTU
        ZBHCswwuX5QLqACDxl4YB5BU1mcbzULt7JzoJlqjXRJFuySK9v/WAkSUIhcuhg8P5vitEVyc
        N68K52Migr1PRIbr0fyneznbZqlFDTPHWxBDI8Vy2eq4ZKWcVMXy8eEtCGhC4STL3Z6klMuC
        VPFnOXXkMXVMGMe3oBW0WOEiO7ds5IicCVZFc6c5LopTL3ZFtJ1bIqJ7B3Z4uE7Xmfzu6xpN
        /YExG/b9ijRs+xq/PzWnRLO2xlP9+mFcwM6qP+ZM7zFds/+gx8iWHz33nIoOgLuyOC9hN5Ej
        7+jVDPicSjA/CKA/9poVFz1dk503nVzvbma7tSv93wbpyhvHr1mCojW876v2Q+mxf/ZG2T3S
        J6V0higNCjEfotrsSah51V+ntUHJcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7rR/c2xBr2z5SwOHdvKbnF/Xiuj
        xcYZ61ktrn95zmox/8g5VosrX9+zWUzfu4nNYtL9CSwW589vYLdYcfcjq8Wmx9dYLS7vmsNm
        8bn3CKPFjPP7mCzWHrnLbnG7cQWbxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe2x8t4PJ
        4+C7PUwefVtWMXp83iQXwBGlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl3Fq1mr2gmVcFfvPn2NsYJzO0cXIySEhYCLx5+tXti5GLg4hgaWMEl//
        3GSDSEhIfFx/gxXCFpb4c60LqugTo8T3zXMZQRJsAo4Sk6Y+YAdJiAicYpTYuvwcWBWzwAYm
        ieVPX4K1CwtES3Sd/8sCYrMIqEpMWXUGLM4rYCHRdG8DM8QKeYnVGw6A2ZwClhJf9s0HqxcC
        qpn7GGIbr4CgxMmZT4DiHEAL1CXWzxMCCTMDtTZvnc08gVFwFpKqWQhVs5BULWBkXsUoklpa
        nJueW2yoV5yYW1yal66XnJ+7iREYxduO/dy8g/HSxuBDjAIcjEo8vArlzbFCrIllxZW5hxgl
        OJiVRHjnmDbFCvGmJFZWpRblxxeV5qQWH2I0BXptIrOUaHI+MMHklcQbmhqaW1gamhubG5tZ
        KInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg1LssfnWhUoz5Q8sc08aHz4Q7ZYvNjl2VOXis
        18VmearqjTVZ7UVhNVvVXprd7AtvcqrozdljVfVX7kvXWvPOU/Hvt32XL/OXE3E3+LwpIlzA
        frmTq4iGviavT7Fesv/GhUGuPywNJnYImvFVFR+/4LLq/udJ6/TX7vy/mHFmQuJrJtX5R9mV
        WIozEg21mIuKEwEVJ1JQ+AIAAA==
X-CMS-MailID: 20190919142323eucas1p2fc73a765389432f880fa28945fd28975
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142323eucas1p2fc73a765389432f880fa28945fd28975
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142323eucas1p2fc73a765389432f880fa28945fd28975
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142323eucas1p2fc73a765389432f880fa28945fd28975@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch improves code readability by changing the following construct:

>    if (cond)
>        goto passive;
>    foo();
>    goto out;
>passive:
>    bar();
>out:

into this:

>    if (cond)
>        bar();
>    else
>        foo();

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index f85bed241631..60ad4319fd80 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -420,19 +420,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err_reg;
 
 	if (passive)
-		goto passive;
+		ret = exynos_bus_profile_init_passive(bus, profile);
+	else
+		ret = exynos_bus_profile_init(bus, profile);
 
-	ret = exynos_bus_profile_init(bus, profile);
 	if (ret < 0)
 		goto err;
 
-	goto out;
-passive:
-	ret = exynos_bus_profile_init_passive(bus, profile);
-	if (ret < 0)
-		goto err;
-
-out:
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

