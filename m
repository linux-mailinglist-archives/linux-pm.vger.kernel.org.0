Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D5120233
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 11:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLPKUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 05:20:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42253 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLPKUG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 05:20:06 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191216102004euoutp0134a477379f30b811db1dad1036da6663~g0sMKa2ii2473624736euoutp01f
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 10:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191216102004euoutp0134a477379f30b811db1dad1036da6663~g0sMKa2ii2473624736euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576491604;
        bh=nYOnw7VM3AQaKXg0AwDk97XPBQ6saxFKGxNXr/emicY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eYHRni0uoMBWA/X1vsq4VNG/nZqULQ2XRnpoTF3+Knm+ORvTWrk9j1mHS9JlbVjvT
         HrI3jHsXbwpZ9sP0hBeci/GS6KJ4h6dNb5oWNwOQPxcMVlu0B7s9O2Qx5YXIGLnc7S
         Ea55FK4exGkgLKm40eF7BiOwlcxX8ip8vQu3vSGw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191216102004eucas1p175ff0eda6b41ee4262332d32b0f962ed~g0sLycfGg2772827728eucas1p1T;
        Mon, 16 Dec 2019 10:20:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.30.61286.45A57FD5; Mon, 16
        Dec 2019 10:20:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191216102003eucas1p280d2bb32bc439a52353536dca87246f0~g0sLan12Q0541205412eucas1p2e;
        Mon, 16 Dec 2019 10:20:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216102003eusmtrp16a1c99a4a2ca4667d022a438920f5bf0~g0sLZmPfB2660126601eusmtrp1C;
        Mon, 16 Dec 2019 10:20:03 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-1e-5df75a54ffd3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.7C.07950.35A57FD5; Mon, 16
        Dec 2019 10:20:03 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216102003eusmtip2c309d38f4ba35a8edcad52d2a6e88463~g0sKs93hs0560005600eusmtip2U;
        Mon, 16 Dec 2019 10:20:03 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com
Subject: [PATCH] devfreq: exynos-bus: Clean up code
Date:   Mon, 16 Dec 2019 11:19:48 +0100
Message-Id: <20191216101948.526-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSxVcRjH+91zzr2HdTkum8dL2N2sqeVl2jobNZpx/ZP+aNPYXQ7OsOtt
        96D4QyIqI0ZeK2tlsktzXdy4ouZa1sj1HmuGiZvUH15vlpTrUP77/J7n+31+3+e3H4lJOglH
        MiE5jVUmM4lSoSWufb9jOHctwiT37umzoefq8hHdWt1C0J82jQRdNleK0yWLqxhtMKhF9Mfc
        7yJaszhF0OO6J0J6o7gf0dWGXgH9qn9WRH++0yikq8tXhAFWMo3qgVDWVn9b9rBdhWQbGper
        eISlfyybmJDBKr0uRVnGm0ZFqWvSWxPGeiwHfXMqRBYkUOdBr3+LCpElKaEaETS8bsX4wyaC
        7oIRzKySUBsI/tSFHTlmt8cEvOglgpaqOuE/x/iaGplVQioQyirmRWa2o/IR1OSeNjNGVQqg
        tTvAzLaUL3Qb8vY1JIlT7jCpcjeXxdQFaGpsFPCXuUKT+h3G123gQ80XnB/jCnkdjw+SAqUV
        Qf1eD8EbgqC4fUjEsy18G2g/ZGcYLC/CeeZgqWuO4M05CDQN/Rjf8AP9wChhDoRRHtCi8+LL
        gTDzS3uQEygrmP5hw2ewgjJtFcaXxXC/QMKjFHQ1VrwRILdp6nC2DIYfVeL8c8qhbeGeqBS5
        1R5brPbYYrX/IzxDmArZs+lcUhzL+SSzNz05JolLT47zjElJ0qD9/zS4N7DeibbGovsQRSLp
        SXGAYlsuIZgMLjOpDwGJSe3EnW4muUQcy2RmscqUG8r0RJbrQ04kLrUX+z5fkUuoOCaNVbBs
        Kqs86gpIC8ccFLUcqrJWdsmcqqYvljHWXxeKfup3HYzEVna4TWhwebqw1FSykuHjGZQdkbpX
        c9kvzCXSOiT0hCO3rOuP+x096S1wHX+qvr4bM3n2yrAif3Urz7iz3D71omp+JJJqDsFsjRUZ
        Q/Onspil9bsegpk34l7thElh6HD2Z5sdgnXhUpyLZ3zOYEqO+Qu/1w7cSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7rBUd9jDb4uNbG4P6+V0WLjjPWs
        Fte/PGe1mHR/AotF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        uN24gs1ixuSXbA58HptWdbJ5bF5S79G3ZRWjx+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ3y+yF3xUqrjyfAlzA+Mr6S5GTg4JAROJ
        u98uMXUxcnEICSxllNjf+ZoVIiEh8XH9DShbWOLPtS42iKJPjBJXFm4FS7AJOEpMmvqAHSQh
        ItDJKNG1+RzYKGaBRUwSDR+fMIFUCQsYS+w+3wxUxcHBIqAqcXWVKkiYV8BcYvWKFUwQG+Ql
        Vm84wAwRF5Q4OfMJC0g5s4C6xPp5QiBhZqCS5q2zmScw8s9CUjULoWoWkqoFjMyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAmNp27GfW3Ywdr0LPsQowMGoxMPrkP0tVog1say4MvcQowQH
        s5II7w6F77FCvCmJlVWpRfnxRaU5qcWHGE2BPpjILCWanA+M87ySeENTQ3MLS0NzY3NjMwsl
        cd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYz75r49H/SsaGvczvwvWgIrLvxQ1/0b0r89IGJ/
        SJyfs9ovkTMnrE5Gz/JSvCfySb5NZ7/V7KpdEpm8Z490WcmtTV00c2WAOIcl7y1bM/fnB9Py
        VokXsL9cI8Rfx9vIwfYjy8Zv2s/v9iVsndtn7bAtcl7aIPio/lUf869H37sK38/b/jPxeo4S
        S3FGoqEWc1FxIgBq4pRUuwIAAA==
X-CMS-MailID: 20191216102003eucas1p280d2bb32bc439a52353536dca87246f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191216102003eucas1p280d2bb32bc439a52353536dca87246f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191216102003eucas1p280d2bb32bc439a52353536dca87246f0
References: <CGME20191216102003eucas1p280d2bb32bc439a52353536dca87246f0@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch improves code readability by changing the following construct:

>    if (cond)
>        goto passive;
>    foo();
>    goto out;
> passive:
>    bar();
> out:

into this:

>    if (cond)
>        bar();
>    else
>        foo();

as well as eliminating a few more goto statements and fixing header
includes.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 54 +++++++++++++-----------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 19d9f9f8ced2..7f5917d59072 100644
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
 
@@ -301,10 +300,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	profile->exit = exynos_bus_exit;
 
 	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
-	if (!ondemand_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!ondemand_data)
+		return -ENOMEM;
+
 	ondemand_data->upthreshold = 40;
 	ondemand_data->downdifferential = 5;
 
@@ -314,15 +312,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 						ondemand_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev, "failed to add devfreq device\n");
-		ret = PTR_ERR(bus->devfreq);
-		goto err;
+		return PTR_ERR(bus->devfreq);
 	}
 
 	/* Register opp_notifier to catch the change of OPP  */
 	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
 	if (ret < 0) {
 		dev_err(dev, "failed to register opp notifier\n");
-		goto err;
+		return ret;
 	}
 
 	/*
@@ -332,17 +329,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_enable_edev(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable devfreq-event devices\n");
-		goto err;
+		return ret;
 	}
 
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		goto err;
+		return ret;
 	}
 
-err:
-	return ret;
+	return 0;
 }
 
 static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
@@ -351,7 +347,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	struct device *dev = bus->dev;
 	struct devfreq_passive_data *passive_data;
 	struct devfreq *parent_devfreq;
-	int ret = 0;
 
 	/* Initialize the struct profile and governor data for passive device */
 	profile->target = exynos_bus_target;
@@ -359,16 +354,13 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 
 	/* Get the instance of parent devfreq device */
 	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
-	if (IS_ERR(parent_devfreq)) {
-		ret = -EPROBE_DEFER;
-		goto err;
-	}
+	if (IS_ERR(parent_devfreq))
+		return -EPROBE_DEFER;
 
 	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
-	if (!passive_data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!passive_data)
+		return -ENOMEM;
+
 	passive_data->parent = parent_devfreq;
 
 	/* Add devfreq device for exynos bus with passive governor */
@@ -377,12 +369,10 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev,
 			"failed to add devfreq dev with passive governor\n");
-		ret = PTR_ERR(bus->devfreq);
-		goto err;
+		return PTR_ERR(bus->devfreq);
 	}
 
-err:
-	return ret;
+	return 0;
 }
 
 static int exynos_bus_probe(struct platform_device *pdev)
@@ -427,19 +417,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err_reg;
 
 	if (passive)
-		goto passive;
-
-	ret = exynos_bus_profile_init(bus, profile);
-	if (ret < 0)
-		goto err;
+		ret = exynos_bus_profile_init_passive(bus, profile);
+	else
+		ret = exynos_bus_profile_init(bus, profile);
 
-	goto out;
-passive:
-	ret = exynos_bus_profile_init_passive(bus, profile);
 	if (ret < 0)
 		goto err;
 
-out:
 	max_state = bus->devfreq->profile->max_state;
 	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
 	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
-- 
2.17.1

