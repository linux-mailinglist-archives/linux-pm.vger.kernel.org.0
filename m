Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C36717F8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbfGWMU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57708 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbfGWMU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122026euoutp0296c82526831bb572ffe9208b08185a58~0CJmnQr0d3179531795euoutp02U
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723122026euoutp0296c82526831bb572ffe9208b08185a58~0CJmnQr0d3179531795euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884426;
        bh=mB6tpYvVSphzP6A9Pn9b/zTWKGneiQ3HT+TMiqcj+Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zfcl13mcfhl4DkWxNKL9IxrK35MS46FUmKWJFRcKpuyz1v5Z5rqSxnnlwCSE/DCaX
         lbNe8luIiA6gkWMM57wZVdBuUyrjcvMqTdNSLYzrqMRPlnc2/SykW4P+O/D5BBnrw4
         q+wseNgX/G5EU8wQC3xz4U557c+ihT/SUfC3LjnM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723122025eucas1p1d47c9b6838304eb0f9bbe1d7b4db9a7a~0CJl_YmjL0316803168eucas1p1Y;
        Tue, 23 Jul 2019 12:20:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.0C.04377.98BF63D5; Tue, 23
        Jul 2019 13:20:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22~0CJlDr9J02753327533eucas1p2N;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122024eusmtrp18e1c2b5fc07da399501cd94295ab0ccd~0CJk5GeSX2491824918eusmtrp1X;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ab-5d36fb89f5e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.D8.04140.88BF63D5; Tue, 23
        Jul 2019 13:20:24 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122024eusmtip2b8e737d5f88e4f720f9c1534dba52c25~0CJkSC1HV1668716687eusmtip27;
        Tue, 23 Jul 2019 12:20:24 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 04/11] devfreq: exynos-bus: Clean up code
Date:   Tue, 23 Jul 2019 14:20:09 +0200
Message-Id: <20190723122016.30279-5-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7qdv81iDfpe61gcOraV3WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3HwXd7mDz6tqxi9Pi8SS6A
        PYrLJiU1J7MstUjfLoErY/qfNqaCJ2oVcz5tYGxg/CjXxcjJISFgInHk/CG2LkYuDiGBFYwS
        M/7sZIRwvjBK3Gw6zQrhfGaUODh1OxtMy4KWFqiW5YwSHV0tLHAtL+7dZwepYhPwlOiZuAOs
        XUTgCKPE5AXvwaqYBVYBOd+3MYJUCQvYSsw+exusg0VAVaJ36mOwOK+Ao8StD3MYIfbJS6ze
        cIAZxOYUcJLoOtrOBlEjKHFy5hMWEJsZqKZ562xmkAUSAi/ZJRbP6WCHaHaRuL7sETOELSzx
        6vgWqLiMxOnJPSwQdrHE0533WSGaGxglNi07AtVgLXH4+EWgBAfQBk2J9bv0IcKOEv2rloCF
        JQT4JG68FYS4gU9i0rbpzBBhXomONiEIU0tiwe9oiEYJiabV16Bme0jM67jNOIFRcRaSZ2Yh
        eWYWwtoFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPa6X/Hv+xg3PUn6RCjAAej
        Eg/vhj2msUKsiWXFlbmHGCU4mJVEeAMbzGKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgW
        EkhPLEnNTk0tSC2CyTJxcEo1MBa0Tjv4dtljnyWuHbOiIj81z3Z9va3N+Jdd/k8er9nr7aZ8
        cvZ8VbWd57dpIm+ZZXdWzgQ32aAupcmivHqdsn0SadVMh84IhDi92jx/k+xZLe6Tc/oPGyu1
        fT7QX/t2bpmwnYhLTtqjKhtN01fZ27adW1T4+0+SwclcnsK9TQc+p+zTUy+bqcRSnJFoqMVc
        VJwIAL+PyC5kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7odv81iDfr361kcOraV3WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3HwXd7mDz6tqxi9Pi8SS6A
        PUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/qf
        NqaCJ2oVcz5tYGxg/CjXxcjJISFgIrGgpYWti5GLQ0hgKaPEhJbXLBAJCYmP62+wQtjCEn+u
        dUEVfWKUON5wkBkkwSbgKdEzcQcrSEJE4BSjxNbl58CqmAU2MUrcPT6RHaRKWMBWYvbZ22A2
        i4CqRO/Ux4wgNq+Ao8StD3MYIVbIS6zecABsKqeAk0TX0XY2EFsIqGbb9tdQ9YISJ2c+ATqP
        A2iBusT6eUIgYWag1uats5knMArOQlI1C6FqFpKqBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS
        83M3MQLjdNuxn1t2MHa9Cz7EKMDBqMTDu2GPaawQa2JZcWXuIUYJDmYlEd7ABrNYId6UxMqq
        1KL8+KLSnNTiQ4ymQK9NZJYSTc4HppC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Yklqdmp
        qQWpRTB9TBycUg2Ml9iFergsQ6T35vznkKq8xfk9WfSkSKaM7a+DKzJ/1MTZuunqxhwo1/Cv
        fpYdKV1YvenZhNM7fsUtKM2KzbrwT5H72wTzYy4P+DRy9W5WyquF221qa3i8U+LK5V8bXoio
        V3OrHqwt7sj1XKWU55K4+Av/QxY5xvshfVUClcYi/js1+OVzNZVYijMSDbWYi4oTAe17qm/p
        AgAA
X-CMS-MailID: 20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds minor improvements to the exynos-bus driver.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 49 ++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 4bb83b945bf7..412511ca7703 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -15,11 +15,10 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 
 #define DEFAULT_SATURATION_RATIO	40
 #define DEFAULT_VOLTAGE_TOLERANCE	2
@@ -256,7 +255,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 					struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
-	int i, ret, count, size;
+	int i, ret, count;
 
 	/* Get the regulator to provide each bus with the power */
 	bus->regulator = devm_regulator_get(dev, "vdd");
@@ -283,8 +282,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	}
 	bus->edev_count = count;
 
-	size = sizeof(*bus->edev) * count;
-	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
+	bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);
 	if (!bus->edev) {
 		ret = -ENOMEM;
 		goto err_regulator;
@@ -388,7 +386,7 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
 	if (!ondemand_data) {
 		ret = -ENOMEM;
-		goto err;
+		goto out;
 	}
 	ondemand_data->upthreshold = 40;
 	ondemand_data->downdifferential = 5;
@@ -400,14 +398,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev, "failed to add devfreq device\n");
 		ret = PTR_ERR(bus->devfreq);
-		goto err;
+		goto out;
 	}
 
 	/* Register opp_notifier to catch the change of OPP  */
 	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
 	if (ret < 0) {
 		dev_err(dev, "failed to register opp notifier\n");
-		goto err;
+		goto out;
 	}
 
 	/*
@@ -417,16 +415,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_enable_edev(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable devfreq-event devices\n");
-		goto err;
+		goto out;
 	}
 
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		goto err;
+		goto out;
 	}
 
-err:
+out:
 	return ret;
 }
 
@@ -446,27 +444,28 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
 	if (IS_ERR(parent_devfreq)) {
 		ret = -EPROBE_DEFER;
-		goto err;
+		goto out;
 	}
 
 	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
 	if (!passive_data) {
 		ret = -ENOMEM;
-		goto err;
+		goto out;
 	}
 	passive_data->parent = parent_devfreq;
 
 	/* Add devfreq device for exynos bus with passive governor */
-	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
+	bus->devfreq = devm_devfreq_add_device(dev, profile,
+						DEVFREQ_GOV_PASSIVE,
 						passive_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev,
 			"failed to add devfreq dev with passive governor\n");
 		ret = PTR_ERR(bus->devfreq);
-		goto err;
+		goto out;
 	}
 
-err:
+out:
 	return ret;
 }
 
@@ -484,11 +483,11 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
 		return -ENOMEM;
 	mutex_init(&bus->lock);
-	bus->dev = &pdev->dev;
+	bus->dev = dev;
 	platform_set_drvdata(pdev, bus);
 
 	/* Parse the device-tree to get the resource information */
@@ -502,7 +501,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	node = of_parse_phandle(np, "devfreq", 0);
 	if (node) {
 		of_node_put(node);
 		ret = exynos_bus_profile_init_passive(bus, profile);
@@ -547,12 +546,10 @@ static int exynos_bus_resume(struct device *dev)
 	int ret;
 
 	ret = exynos_bus_enable_edev(bus);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to enable the devfreq-event devices\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int exynos_bus_suspend(struct device *dev)
@@ -561,12 +558,10 @@ static int exynos_bus_suspend(struct device *dev)
 	int ret;
 
 	ret = exynos_bus_disable_edev(bus);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to disable the devfreq-event devices\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.17.1

