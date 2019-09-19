Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BBAB7C4F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403766AbfISOY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53438 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390512AbfISOX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142326euoutp02a57e5c30d08fc9dd0fac5241f8744fd7~F3PjQr-n_1740117401euoutp02V
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190919142326euoutp02a57e5c30d08fc9dd0fac5241f8744fd7~F3PjQr-n_1740117401euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903006;
        bh=oOfZ6+laMOXh5GfXFPnoq8LTAumrs8RYsN9+Zezp3sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLyi5bDJQ+walUmvREtb0wAd3C6w1I7EMJePoPhlP1/qIs/GayV1YVJVNoI8R3AWM
         VBG53qrz6LkGiUTd6YbRhHMfwD1Yan6OkfkS/LXyFoLZvyOuKG9CM+4efnho2pwfDC
         Js6iiMv9OT4Q+4cs1KVOgZWALy3OCnJNNIiQPmmE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142325eucas1p28da7adeb9a17d92b68ff117af505bb7d~F3Pid87qa3077830778eucas1p22;
        Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 37.1B.04309.D5F838D5; Thu, 19
        Sep 2019 15:23:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a~F3PhpKc5N0293102931eucas1p1R;
        Thu, 19 Sep 2019 14:23:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142324eusmtrp11cbda700507d309e234a9e67168d05e2~F3PhXOw7W0555105551eusmtrp1V;
        Thu, 19 Sep 2019 14:23:24 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-4f-5d838f5d03ee
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.65.04117.C5F838D5; Thu, 19
        Sep 2019 15:23:24 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142323eusmtip118431cc5357ffe0dbc83832c0e4d758f~F3PgiCxp_3039930399eusmtip1e;
        Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 04/11] devfreq: exynos-bus: Clean up code
Date:   Thu, 19 Sep 2019 16:22:29 +0200
Message-Id: <20190919142236.4071-5-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29m5KB05HgVfNCoHQRe8FAlfV5L6cSKKgkgwhq08XtBN2VHL
        IlNHZuYllEpdmZKablk6L9kwsbkmYThCMTHNqEQqVGKzC1jWPOvy73mf93me930/PobgJ8lg
        JlmXIep1mlQV5avscnwfClOXGdSRebM8tjk6aTxVcxHhtsoHJH7pniHxbfsQiUcW5il847GF
        wuVTV5XY6WylcdPkZxJb3o2SeNh6k8KuEjvClc5eBW6xT9L4VV4ThSsrPlB7/AWL6TIlTIz2
        UMLUlQGF0F5/QWib61YIT+Z6FEJphwkJLsvqw0ys7854MTU5S9RH7D7hm9Qya0fpXzacsQzG
        5qLJ0CLkwwC3FV4V/1QWIV+G55oQtLcuegs3AvOzW6RcuBDU2T5SRYhZtvQtaGT+LoKZ1uuK
        vw6Dow55cikuGsqvvaE9jUDOjqCidn45l+DqFVBqdBIeVQC3B9xDbtoTq+TWgWHwgIdmOQzX
        Lt+h5QXXgLm1b1nuw20Dd+9tpazxh2dV75cx8Vtj6DQSnnzgLjJQavpByuZ98GKpxhsUAB8H
        Orx4FQxWFCtlLMH0oylSNucisDTaCbmxA/oHXpCe5QhuAzywRsh0NIyMVXufwg/GZv3lHfyg
        vOsGIdMsFBbwMlSBtcpPNgLkm0e92QKUDQ/RV1Fo9X/HVP93TPW/sbWIMKEgMVPSJorSFp14
        OlzSaKVMXWL4qTStBf3+dIM/B9zdyLp40oY4BqlWsmtPG9Q8qcmSsrU2BAyhCmRvRuWreTZe
        k31W1KfF6TNTRcmGQhilKog9t+LNcZ5L1GSIKaKYLur/dBWMT3AuCuloNLiilnadt+tiTAnT
        E0tHnK/pvq0b128aN/P9/k8jChbb7o7npG1v8HOrwhvesfe7Jo4FGC+whWeev/4UY1wsiAmw
        muMKDx2913IwlO0NnOfDmhdqxtd1Zn37EH/JkuN2jAa+bRb3qlNyH+6KpF1fE4xZVVJOzf6C
        lbaSkXqVUkrSbN5I6CXNL+XYu0BwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7ox/c2xBn/mC1ocOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2Pt2yOMBd80KzadjmpgvKvYxcjBISFgInHga2IXIxeHkMBSRonT666z
        dDFyAsUlJD6uv8EKYQtL/LnWxQZR9IlR4sybZ2BFbAKOEpOmPmAHSYgInGKU2Lr8HFgVs8AG
        JonlT1+CtQsLOEh8OfeFHWQdi4CqRPNpb5Awr4CFxNTOxewQG+QlVm84wAxicwpYSnzZNx9s
        gRBQzdzHcxkh6gUlTs58wgIyhllAXWL9PCGQMDNQa/PW2cwTGAVnIamahVA1C0nVAkbmVYwi
        qaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxu+3Yzy07GLveBR9iFOBgVOLhVShvjhViTSwrrsw9
        xCjBwawkwjvHtClWiDclsbIqtSg/vqg0J7X4EKMp0GcTmaVEk/OBqSWvJN7Q1NDcwtLQ3Njc
        2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPjhnNZTNuXh+enLzm47Z7i+Yc1Rw++YH23
        Y7Ox5tmchvenxZ+zvKhkvK91ulBq9TaxPrX+AwsufBSyu1S+RG/nNHWOE97Gx9r0lk5zNAuK
        +iF4tuG+Tu43Rf6JTB8elH0QNr3nqSB5Z8Ga+o0xN3acv6Xd6/IkR2bvVKlNtpEexzenNPN3
        BXSYK7EUZyQaajEXFScCABrO2lX1AgAA
X-CMS-MailID: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142324eucas1p1638cec2aafbfcaf03cfdfa7d0189143a@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds minor improvements to the exynos-bus driver.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/exynos-bus.c | 66 ++++++++++++++----------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 60ad4319fd80..8d44810cac69 100644
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
 
@@ -314,8 +311,7 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 						ondemand_data);
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev, "failed to add devfreq device\n");
-		ret = PTR_ERR(bus->devfreq);
-		goto err;
+		return PTR_ERR(bus->devfreq);
 	}
 
 	/*
@@ -325,16 +321,13 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_enable_edev(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable devfreq-event devices\n");
-		goto err;
+		return ret;
 	}
 
 	ret = exynos_bus_set_event(bus);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		goto err;
-	}
 
-err:
 	return ret;
 }
 
@@ -344,7 +337,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	struct device *dev = bus->dev;
 	struct devfreq_passive_data *passive_data;
 	struct devfreq *parent_devfreq;
-	int ret = 0;
 
 	/* Initialize the struct profile and governor data for passive device */
 	profile->target = exynos_bus_target;
@@ -352,30 +344,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 
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
@@ -393,18 +381,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
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
@@ -461,12 +449,10 @@ static int exynos_bus_resume(struct device *dev)
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
@@ -475,12 +461,10 @@ static int exynos_bus_suspend(struct device *dev)
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

