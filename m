Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820BE116B66
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLIKuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46119 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfLIKug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209105035euoutp025a98ac95e1b9f474ecb81035e3a3f896~erl082ixA3098630986euoutp02d
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 10:50:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209105035euoutp025a98ac95e1b9f474ecb81035e3a3f896~erl082ixA3098630986euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575888635;
        bh=Ja3gxgbWiIno/jQbE71t1xooMh1ElJexvm3uTQFKFYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGRnQ+Nb6s/Co/D7UnNQSntRcKIKCK9TnER9jju2tVmDAqW6GjLrqduOfiCjwAAxn
         r48RUacudmSlFOv+eD4BONjENT5m4PI5AQ67hxtFkYQbxobPYhWtsXuDXxzdDjnTRR
         3jr8CUNOfs7jrJdXpQqnkr2WHSIbCpLS0tLxNXUk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209105034eucas1p2ee909cef6b7239aa10fb33712f87b19e~erl0uA_SW1399213992eucas1p2N;
        Mon,  9 Dec 2019 10:50:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AE.34.60698.AF62EED5; Mon,  9
        Dec 2019 10:50:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2~erl0O_90z1387713877eucas1p2u;
        Mon,  9 Dec 2019 10:50:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209105034eusmtrp1674e6c1a4c4875d11f1bf7f66b9aab5b~erl0OQCyX2135321353eusmtrp1g;
        Mon,  9 Dec 2019 10:50:34 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-8b-5dee26fadb03
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.D6.08375.AF62EED5; Mon,  9
        Dec 2019 10:50:34 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105033eusmtip143f04464169d159795fb3db34fe9e493~erlzZqZz53014230142eusmtip1M;
        Mon,  9 Dec 2019 10:50:33 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        k.konieczny@samsung.com, leonard.crestez@nxp.com
Subject: [PATCH v3 4/4] devfreq: exynos-bus: Clean up code
Date:   Mon,  9 Dec 2019 11:49:02 +0100
Message-Id: <20191209104902.11904-5-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209104902.11904-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTlm/fezFMae46CV4vMIY0WtbAfXxqV5Y+BCvJXlGiN+XIkN+a5
        pGVuKOWWjphLIeKI2pioo4kLSOqU2SCTSC6IaWpuqamjoRKW47Py37n3nHPvPR8fTUj0lB0d
        FBrBKkPlwVKhOdn4fsPgvOm06Huq6+tJPFqcgnBdQQ2FB1anKawazSZxyUoBhZ9NfCewwVAr
        wj1J8yJcObJMYe1EP4X7Wl4KsTFTh3CBoU2Aq3UjIjycWCnEBbmzwouMTKt5KpTVl8XL6hab
        BLKsBg2SGbWHrlO3zM8FsMFBUazS9fwdc8Wcvp4Kzzr6QJWupRLQJ/s0ZEYDcwYMSw2CNGRO
        S5hKBI2bKRRfrCIoLtbsMkYErXnzZBqidywZOWK+X4Egt38c/XMM5Nci01wh4wmqvDGRibBm
        UhD0GoYIU0EwHwUwk5pEmVRWjDvMbHwmTZhkHMHYObaDxcxZWPzxWshfaA9VtW8JEzbb1i+X
        94h4jSV0F07u6IltTfKbFzsLgJkVgW7og4A3e8HvicxdbAVzXQ0iHh8EfW4GyWMOvjWPUrw5
        AYG2XEfwhAd0dvVSptAEcwxqWlz5tidol9Z338ICBhcs+RssQNWYT/BtMTxJlfBQCi2FFrwR
        IKmqf3e2DArV78hs5FC0J0zRnjBF/9eWIEKDbNhILiSQ5dxC2WgXTh7CRYYGutwNC9Gi7S+m
        3+paa0Jtv/w7EEMj6T7xYfcFXwklj+JiQjoQ0ITUWlyWM+crEQfIY2JZZdhtZWQwy3WgAzQp
        tRG7lc76SphAeQR7n2XDWeVfVkCb2SWgmBOzV9b3O9k+OjLVuuXtfIOITnX3613UxE6qjNZ+
        rgrv58ZL431SSbXPtZ816vStDrJCrVgJUG5MSscX1prTp+Orki3dL+commeuOiQ+NN6L+3Kh
        D7cPPSaH2wem/buDWrkM9ZTXNDi3F8/orVs9fDZtV9WvkGPAzdLBOJ1BSnIK+enjhJKT/wG0
        xutGXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7q/1N7FGmz/yW9xf14ro8XGGetZ
        La5/ec5qMen+BBaLBZ9msFr0P37NbHH+/AZ2i7NNb9gtVtz9yGqx6fE1VovLu+awWXzuPcJo
        MeP8PiaLtUfuslvcblzBZjFj8ks2BwGPTas62Tw2L6n32PhuB5NH35ZVjB6fN8kFsEbp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbw6vZm1oE+9
        YlL3JtYGxgvyXYwcHBICJhI9E3m7GLk4hASWMko0bPnN1sXICRSXkPi4/gYrhC0s8edaFxtE
        0SdGiUVbvjOCJNgEHCUmTX3ADpIQEehklFi/bDoTiMMscINJomnLOxaQKmEBK4kXP6+C2SwC
        qhKfDz8As3kFLCXevV8DtU5eYvWGA8wgNidQ/cdlZ9lBbCGgmrkLV0PVC0qcnPmEBeRsZgF1
        ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525i
        BMbmtmM/N+9gvLQx+BCjAAejEg9vhc3bWCHWxLLiytxDjBIczEoivEsmvooV4k1JrKxKLcqP
        LyrNSS0+xGgK9NpEZinR5Hxg2sgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBa
        BNPHxMEp1cDoyXbx5a3PjC+WM26sC9/yver75HdTZU41W77UVREq659xY2rmp1uBwuefmKd4
        vG1K6L/WuHqCe7WrDpNg0dUdFbuWbKoI6+sOvHXoumpxwJkltpfD4yyE5y/pnM7uwWZesu71
        uq+Mq0//fxLeOeuWg66K/q9bZx7/+/N101mOu9obptU7yjLvVmIpzkg01GIuKk4EAEuOt0Dj
        AgAA
X-CMS-MailID: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds minor improvements to the exynos-bus driver, including
cleaning up header includes, variables, and return paths.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 56 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 0b557df63666..3eb6a043284a 100644
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
 
@@ -178,7 +177,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	struct device *dev = bus->dev;
 	struct opp_table *opp_table;
 	const char *vdd = "vdd";
-	int i, ret, count, size;
+	int i, ret, count;
 
 	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
 	if (IS_ERR(opp_table)) {
@@ -201,8 +200,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	}
 	bus->edev_count = count;
 
-	size = sizeof(*bus->edev) * count;
-	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
+	bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);
 	if (!bus->edev) {
 		ret = -ENOMEM;
 		goto err_regulator;
@@ -301,10 +299,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
 
@@ -314,15 +311,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
@@ -332,17 +328,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
@@ -351,7 +346,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	struct device *dev = bus->dev;
 	struct devfreq_passive_data *passive_data;
 	struct devfreq *parent_devfreq;
-	int ret = 0;
 
 	/* Initialize the struct profile and governor data for passive device */
 	profile->target = exynos_bus_target;
@@ -359,30 +353,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 
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
-	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
+	bus->devfreq = devm_devfreq_add_device(dev, profile,
+						DEVFREQ_GOV_PASSIVE,
 						passive_data);
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
@@ -400,18 +390,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
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
 
 	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
 	if (!profile)
 		return -ENOMEM;
 
-	node = of_parse_phandle(dev->of_node, "devfreq", 0);
+	node = of_parse_phandle(np, "devfreq", 0);
 	if (node) {
 		of_node_put(node);
 		passive = true;
-- 
2.17.1

