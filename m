Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50D717F6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbfGWMU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38679 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbfGWMU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122024euoutp0131e7fe69522c1a4c5f08165cc3f1e0db~0CJlEbebG2876628766euoutp01T
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122024euoutp0131e7fe69522c1a4c5f08165cc3f1e0db~0CJlEbebG2876628766euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884425;
        bh=ieJ7cuOWHzOtHekeljdAL3BGbRF46aE7ZAyxlKgDJqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V81lm8cVQFRmCMtXVFiAmtQ9y6R9GSnjgBof17Bid0J9Dmv6yf+zP3z8aZyTYeSSv
         qKaxE4vM+oTD4UCKawAxR4jR3SR9imlM/OfYHcxJ8QAw2ANP781Ls4dm7BWHuZLw7F
         8rYQRVX4B7W5HPDKneI4fvTinEcydtArBL/ojUzU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723122024eucas1p282b69e229491fbeada5acc07ff4068e9~0CJkbaCUk1893418934eucas1p2A;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.75.04325.88BF63D5; Tue, 23
        Jul 2019 13:20:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2~0CJj2Uwtv2749027490eucas1p2X;
        Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122023eusmtrp1a85f16e721c2f79a22b5fda4a3a16896~0CJjrpwnJ2487524875eusmtrp1k;
        Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-a0-5d36fb887713
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.D8.04140.78BF63D5; Tue, 23
        Jul 2019 13:20:23 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122022eusmtip29c0f995471815170717c96f9c66fea05~0CJjCobRV1668716687eusmtip25;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 02/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init_passive()
Date:   Tue, 23 Jul 2019 14:20:07 +0200
Message-Id: <20190723122016.30279-3-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRz23nPPuYd1dRziRWPdaisrkujdakalTps1/JlZ3XJ85at7ULLW
        pQ/ckI8aXRVNPrqS6/o2rK4bu4w7ahQZlWb6slxmppLraPnv+T3P73l+v9+7l8ToAdyBjIxN
        YGWx0mgJYSFs6l4y7M1Y9grZVzeGI213owjVFdXiaGR+GkclugEcvVmYJVBhh4ZA+RO5QmQw
        qEVI82kYR6/bHhDImK0DqMjQKUA1unERGkutIlBRwQzhs5nRqDIJ5v1wO8FM3O4RMPVPrjEv
        f7QLmJwGFWCMGqcA0WmLw6FsdGQSK3PzPmsRUZk3Koovsr881bxCyMEHGwUwJyF1AGoHDAIF
        sCBpqgpAxc1H68U8gHM1S0K+MAKoHyoBCkCuWTpSo3i+EsDWzP4NDvVvkSmXoE7CrLwW3CTY
        UDoAC0pn16IwSrVaLDatRVlTwVAx42iCQmonLNTTJq+Y8oX3jNlCfj9nWK1+gZmwOXUEKl6l
        E3yPFdTfn1rrwVZ7rjcWY6Z4SP0UQbVqUcSbj8FyfQXOY2v4padhnd8K+wqy1gdw8HPrBM6b
        5QBqKnQYLxyCXT2DuGk5jNoNa9vceNoXDi5OCvmXsIRvv1vxO1jC/KZCjKfFMOMWzUMXWLoc
        zBshTKseXs9moHLpDpELtik3HKPccIzy/9hSgKmAHZvIxYSznEcse8mVk8ZwibHhrufjYjRg
        9Zf1/elZaAGdv85pAUUCySaxut0zhMalSVxyjBZAEpPYiAPlXiG0OFSafIWVxZ2RJUaznBY4
        kkKJnTjFbDKYpsKlCewFlo1nZf9UAWnuIAfc1FH2Xc20scQ/zKmx4nGGeeCpGwcDdlx9NpNV
        +XDZgykLMiseLHf3NcvJKo4IGnL2ueiXGL1gO4L0c8+37AnrvFs2vr2Lvvvxm/dKSbP/cYTX
        2kdmPu1v/NrffcIjJUgcZTtcXr+flaf1ZlcQozUu6Zm7nBk/q/gViWOyJ91rKxFyEVJ3F0zG
        Sf8CScqCbGEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rtv81iDWZukbI4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvKJ
        t9gLZkhWPNn+n62B8aFIFyMHh4SAicTexqwuRi4OIYGljBIdOzaydzFyAsUlJD6uv8EKYQtL
        /LnWxQZR9IlR4uHFHkaQBJuAp0TPxB2sIAkRgVOMEluXnwOrYhbYxChx9/hEsFHCApESMy8e
        ZgRZxyKgKjH9pBBImFfAUWLq514WiA3yEqs3HGAGsTkFnCS6jrazgdhCQDXbtr9mhKgXlDg5
        8wkLyBhmAXWJ9fPAxjADtTZvnc08gVFwFpKqWQhVs5BULWBkXsUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREYo9uO/dyyg7HrXfAhRgEORiUe3g17TGOFWBPLiitzDzFKcDArifAGNpjFCvGm
        JFZWpRblxxeV5qQWH2I0BfpsIrOUaHI+MH3klcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpgXP6de/MWeV8l5/3BjmK+geLinNt/efyuS2I32rMlQfizDfc1jUMt
        j468N+hsrdli+/DL5I7iFfGWlQ9mZz32uXQ0d+33qu+K8etz9Tf1rcjp6avev9bZKaCgqzbq
        a94UEa/nSXd2h3/55Jcm7zuF/z2T4dt1Iet0eCMOXVuhaGKyuqYq+UyvEktxRqKhFnNRcSIA
        oyAzYecCAAA=
X-CMS-MailID: 20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122023eucas1p2ff56c00b60a676ed85d9fe159a1839f2@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a new static function, exynos_bus_profile_init_passive(),
extracted from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index d8f1efaf2d49..cf6f6cbd0f55 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -430,13 +430,51 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	return ret;
 }
 
+static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
+					   struct devfreq_dev_profile *profile)
+{
+	struct device *dev = bus->dev;
+	struct devfreq *parent_devfreq;
+	struct devfreq_passive_data *passive_data;
+	int ret = 0;
+
+	/* Initialize the struct profile and governor data for passive device */
+	profile->target = exynos_bus_passive_target;
+	profile->exit = exynos_bus_passive_exit;
+
+	/* Get the instance of parent devfreq device */
+	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (IS_ERR(parent_devfreq)) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+
+	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
+	if (!passive_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	passive_data->parent = parent_devfreq;
+
+	/* Add devfreq device for exynos bus with passive governor */
+	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
+						passive_data);
+	if (IS_ERR(bus->devfreq)) {
+		dev_err(dev,
+			"failed to add devfreq dev with passive governor\n");
+		ret = PTR_ERR(bus->devfreq);
+		goto err;
+	}
+
+err:
+	return ret;
+}
+
 static int exynos_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node, *node;
 	struct devfreq_dev_profile *profile;
-	struct devfreq_passive_data *passive_data;
-	struct devfreq *parent_devfreq;
 	struct exynos_bus *bus;
 	int ret, max_state;
 	unsigned long min_freq, max_freq;
@@ -481,33 +519,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 	goto out;
 passive:
-	/* Initialize the struct profile and governor data for passive device */
-	profile->target = exynos_bus_passive_target;
-	profile->exit = exynos_bus_passive_exit;
-
-	/* Get the instance of parent devfreq device */
-	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
-	if (IS_ERR(parent_devfreq)) {
-		ret = -EPROBE_DEFER;
+	ret = exynos_bus_profile_init_passive(bus, profile);
+	if (ret < 0)
 		goto err;
-	}
-
-	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
-	if (!passive_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
-	passive_data->parent = parent_devfreq;
-
-	/* Add devfreq device for exynos bus with passive governor */
-	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
-						passive_data);
-	if (IS_ERR(bus->devfreq)) {
-		dev_err(dev,
-			"failed to add devfreq dev with passive governor\n");
-		ret = PTR_ERR(bus->devfreq);
-		goto err;
-	}
 
 out:
 	max_state = bus->devfreq->profile->max_state;
-- 
2.17.1

