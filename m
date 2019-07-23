Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32627181D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbfGWMVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:21:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38681 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389697AbfGWMU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122024euoutp01ae727793e0893a8e4f8da620f01b340a~0CJkhGLmR2876628766euoutp01S
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122024euoutp01ae727793e0893a8e4f8da620f01b340a~0CJkhGLmR2876628766euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884424;
        bh=kmVmqQ7vBBuymdBigbk1kLjY1bQshXiULeywhK0hfzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zi03pn1AzwwhW4BYdzv1xAgCm7paXtAcqjPRH91bX8pd6NnKUEWY3R6t+LR1nEYun
         TA+wTw+1Zkfpt9J5zF/1vpGRvZQIKdu7IPJfmZSJVBTauH3KGBMEwjRnD/ujDsiHoB
         1eUSsld7JdIWkWc/w/YauvfKVROIkYfRBJ+BWAvg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122023eucas1p17500dad051b1f22442f84c7b36ef48a3~0CJjtjSBw0311003110eucas1p1Q;
        Tue, 23 Jul 2019 12:20:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.75.04325.78BF63D5; Tue, 23
        Jul 2019 13:20:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190723122022eucas1p1266d90873d564894bd852c20140f8474~0CJjCbjWC3150731507eucas1p1p;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122022eusmtrp1f00b961ea151a2b89ee920602225ff41~0CJjB1jlQ2487524875eusmtrp1i;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-9d-5d36fb87d3eb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.D8.04140.68BF63D5; Tue, 23
        Jul 2019 13:20:22 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122022eusmtip2474dd9922db572afb0b7c0650f28954d~0CJibJLMJ1668716687eusmtip24;
        Tue, 23 Jul 2019 12:20:22 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
Date:   Tue, 23 Jul 2019 14:20:06 +0200
Message-Id: <20190723122016.30279-2-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87rtv81iDfb+ErA4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        exSXTUpqTmZZapG+XQJXxsGDi9gKjilUdK/azdzAuFGqi5GTQ0LARGL73eVsXYxcHEICKxgl
        juy8xgrhfGGU+Nx/kRWkSkjgM6PEnHuSMB3Xl29hgogvZ5S4c1INruHYh51sIAk2AU+Jnok7
        wCaJCBxhlJi84D0LiMMssArI+b6NEaRKWCBYYsmx80A2BweLgKrEmV1iIGFeAUeJeztaWCG2
        yUus3nCAGcTmFHCS6DrazgZRIyhxcuYTFhCbGaimeetsZpD5EgIf2SVOvpjFDtHsIrHsVwML
        hC0s8er4Fqi4jMTpyT1Q8WKJpzvvs0I0NzBKbFp2hBkiYS1x+DjI/xxAGzQl1u/Shwg7Shz5
        fYoZJCwhwCdx460gxA18EpO2TYcK80p0tAlBmFoSC35HQzRKSDStvgY120Ni/751TBMYFWch
        eWYWkmdmIaxdwMi8ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCVnf53/OsOxn1/kg4x
        CnAwKvHwbthjGivEmlhWXJl7iFGCg1lJhDewwSxWiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81
        w4NoIYH0xJLU7NTUgtQimCwTB6dUA2Owd/XaNpfO74FXGW7wmLZU/+DKT+v62Rzydlu8U16m
        973fwjFpi3ef8eQ8eT9F88HmIoU9pc+/19/neGN2qI7p6MqPmdeVv/+o3hZi/khw5po9QjxO
        3+RkX+iJzJRakxIupyDH3aSQXHn7q+7Kazpmjtvci7RuvtDawdR90itOUPDophnmmUosxRmJ
        hlrMRcWJAIGyLPdhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7ptv81iDfY80LM4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsGD
        i9gKjilUdK/azdzAuFGqi5GTQ0LAROL68i1MXYxcHEICSxklHky6xQSRkJD4uP4GK4QtLPHn
        WhcbRNEnRok9u1oZQRJsAp4SPRN3sIIkRAROMUpsXX4OrIpZYBOjxN3jE9lBqoQFAiUWbpoG
        lODgYBFQlTizSwwkzCvgKHFvRwvUBnmJ1RsOMIPYnAJOEl1H29lAbCGgmm3bXzNC1AtKnJz5
        hAVkDLOAusT6eUIgYWag1uats5knMArOQlI1C6FqFpKqBYzMqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQKjdNuxn1t2MHa9Cz7EKMDBqMTDu2GPaawQa2JZcWXuIUYJDmYlEd7ABrNYId6U
        xMqq1KL8+KLSnNTiQ4ymQJ9NZJYSTc4HJpC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2MMz+Xt7Oqlb00ZkyWrZ65dt2ftWKpM5hOfNgdt2nh87xEDuZpbIwh
        0tPlglfFLvn9skuyzE+h/dbs2DVSnZ0eVdF8O0ykP4v/YPzXdPevbMkjcaknTGXB+hVCD+o8
        FKPunmWwNZ+VVeS45fXRtaFMP7uCvYVZfZyev2fl/zWtW0rvfZu60EQlluKMREMt5qLiRACS
        1DSG6AIAAA==
X-CMS-MailID: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a new static function, exynos_bus_profile_init(), extracted
from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index d9f377912c10..d8f1efaf2d49 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node *np,
 	return ret;
 }
 
+static int exynos_bus_profile_init(struct exynos_bus *bus,
+				   struct devfreq_dev_profile *profile)
+{
+	struct device *dev = bus->dev;
+	struct devfreq_simple_ondemand_data *ondemand_data;
+	int ret;
+
+	/* Initialize the struct profile and governor data for parent device */
+	profile->polling_ms = 50;
+	profile->target = exynos_bus_target;
+	profile->get_dev_status = exynos_bus_get_dev_status;
+	profile->exit = exynos_bus_exit;
+
+	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
+	if (!ondemand_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	ondemand_data->upthreshold = 40;
+	ondemand_data->downdifferential = 5;
+
+	/* Add devfreq device to monitor and handle the exynos bus */
+	bus->devfreq = devm_devfreq_add_device(dev, profile,
+						DEVFREQ_GOV_SIMPLE_ONDEMAND,
+						ondemand_data);
+	if (IS_ERR(bus->devfreq)) {
+		dev_err(dev, "failed to add devfreq device\n");
+		ret = PTR_ERR(bus->devfreq);
+		goto err;
+	}
+
+	/* Register opp_notifier to catch the change of OPP  */
+	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
+	if (ret < 0) {
+		dev_err(dev, "failed to register opp notifier\n");
+		goto err;
+	}
+
+	/*
+	 * Enable devfreq-event to get raw data which is used to determine
+	 * current bus load.
+	 */
+	ret = exynos_bus_enable_edev(bus);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable devfreq-event devices\n");
+		goto err;
+	}
+
+	ret = exynos_bus_set_event(bus);
+	if (ret < 0) {
+		dev_err(dev, "failed to set event to devfreq-event devices\n");
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
-	struct devfreq_simple_ondemand_data *ondemand_data;
 	struct devfreq_passive_data *passive_data;
 	struct devfreq *parent_devfreq;
 	struct exynos_bus *bus;
@@ -418,52 +475,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
-	/* Initialize the struct profile and governor data for parent device */
-	profile->polling_ms = 50;
-	profile->target = exynos_bus_target;
-	profile->get_dev_status = exynos_bus_get_dev_status;
-	profile->exit = exynos_bus_exit;
-
-	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
-	if (!ondemand_data) {
-		ret = -ENOMEM;
+	ret = exynos_bus_profile_init(bus, profile);
+	if (ret < 0)
 		goto err;
-	}
-	ondemand_data->upthreshold = 40;
-	ondemand_data->downdifferential = 5;
-
-	/* Add devfreq device to monitor and handle the exynos bus */
-	bus->devfreq = devm_devfreq_add_device(dev, profile,
-						DEVFREQ_GOV_SIMPLE_ONDEMAND,
-						ondemand_data);
-	if (IS_ERR(bus->devfreq)) {
-		dev_err(dev, "failed to add devfreq device\n");
-		ret = PTR_ERR(bus->devfreq);
-		goto err;
-	}
-
-	/* Register opp_notifier to catch the change of OPP  */
-	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
-	if (ret < 0) {
-		dev_err(dev, "failed to register opp notifier\n");
-		goto err;
-	}
-
-	/*
-	 * Enable devfreq-event to get raw data which is used to determine
-	 * current bus load.
-	 */
-	ret = exynos_bus_enable_edev(bus);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable devfreq-event devices\n");
-		goto err;
-	}
-
-	ret = exynos_bus_set_event(bus);
-	if (ret < 0) {
-		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		goto err;
-	}
 
 	goto out;
 passive:
-- 
2.17.1

