Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A6116B6D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfLIKue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46076 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfLIKud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209105032euoutp02da3643da101b8e3b66c6aaf3d8c7e9b2~erlysIaoW3039030390euoutp028
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 10:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209105032euoutp02da3643da101b8e3b66c6aaf3d8c7e9b2~erlysIaoW3039030390euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575888632;
        bh=bcPn7XbAqvxY5Dgi7VEkZejGI3WMO327V8bJhV6vE2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIrzvWlmMEJHO/0zVf8sxhCEvmA30igvL9d+QRtkKQeJL1JupwFWW0nZ+xoUwvxKe
         5Tj8bLwKnOW+4a3dlmEwNqvL+BkZZML+6cA3wPEDBPGcLlSzgAUhtyuHop73SG0vIh
         qj6Ra132Fr3cTmuqfBSNnJkw5vnU9j2+9+qV0qmQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191209105032eucas1p26a6cdbbd340fbd5ac30c54cd23687ff6~erlyYZSUi1375713757eucas1p2G;
        Mon,  9 Dec 2019 10:50:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.2E.60679.8F62EED5; Mon,  9
        Dec 2019 10:50:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277~erlx53plj0955109551eucas1p1d;
        Mon,  9 Dec 2019 10:50:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209105031eusmtrp134181cb24b58068e24635b8cb9bf67af~erlx5E9aV2135321353eusmtrp1Y;
        Mon,  9 Dec 2019 10:50:31 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4d-5dee26f8058a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.D6.08375.7F62EED5; Mon,  9
        Dec 2019 10:50:31 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105030eusmtip1acf41eadd0fd3b90e317d87f9f1abd40~erlxDdNg43004330043eusmtip1e;
        Mon,  9 Dec 2019 10:50:30 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        k.konieczny@samsung.com, leonard.crestez@nxp.com
Subject: [PATCH v3 1/4] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
Date:   Mon,  9 Dec 2019 11:48:59 +0100
Message-Id: <20191209104902.11904-2-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209104902.11904-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3d29u2qz27XoaYXZIikjrezH60f2QdGIIn8EgTBq5kUzXbWb
        pv3IqWyVldYqmhY2w+bYKG2WqT/KzJxltlTQldhiFc2PJL8gM6Jt16h/53nOOc95D7w0wb4i
        ZfQR9UlOo1ZlyalgcUP7jHPdj8gx5frrhSx2V+oQfmCsJXH/1FcSG9yXxdg0YSRx2acRAjud
        dRLcVTQqwZbBcRLbP/WRuLf5FoUnL7UhbHQ+EeF7bYMSPFBoobDx6hC1lVHYrecpRX11geLB
        WKNIUfrQihST9vBkMiU4MY3LOpLLaWKSDgVneL33xcdbI/I+VHVItKhWVoKCaGA2wXTlGFmC
        gmmWsSBw1HWL/ATLTCF4/D1OICYReEu7xX8dDWV3KYGoQVBvLhcJg8/x8aItYKeYbWC4/lHi
        JxYyOgTdzneEfyCYVyLw6otIvyqMSYaRIhPlx2JmFTQ5bIEMKRMHT723RULecrDVtRB+HMTE
        w7i5SyJoFsDL8s8BPeHTFD+6GQgAxiMBy0CPRDDvgDbjNUrAYTDseDi3XwadVy/OFeLhS5Ob
        FMxaBHZzGyEQCfDc0e0jaF/CGqhtjvFD8FVzV64UYCi4vi0QnhAKhoYbhLCWwjk9K0A5NJeH
        CucAimx9c6cV4Hk2QV5GKyr+61LxX5eKf6kmRFjRYi6Hz07n+I1q7lQ0r8rmc9Tp0YePZduR
        74d1/nZMNaLmX6mtiKGRfJ40Iv6bkiVVuXx+disCmpAvlFZfGVay0jRV/mlOc+ygJieL41vR
        UlosXyyNvTOkZJl01UnuKMcd5zR/WREdJNOiA9BrujCzMbKpSxbr6o86M3HJpd+83nOWnp1e
        s9N1gu8cah/PKwgZC1sie62XRWxRZO4eDU/Da+ePVL3eNZzQ07jvTHLxBsIc5VoUPZva4dmf
        +ihxdM/2+rcvdFPaNHuMIeXnaqtpd2bIOevgXkdGTQn9faDlTWmN7nCLLem9tl0u5jNUG6II
        Da/6A/X3Yk5dAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7rf1d7FGkzbqG1xf14ro8XGGetZ
        La5/ec5qMen+BBaLBZ9msFr0P37NbHH+/AZ2i7NNb9gtVtz9yGqx6fE1VovLu+awWXzuPcJo
        MeP8PiaLtUfuslvcblzBZjFj8ks2BwGPTas62Tw2L6n32PhuB5NH35ZVjB6fN8kFsEbp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbx4sY6l4JBC
        xb2FJ9gbGNdLdTFyckgImEhs61/KBmILCSxllGhYwwwRl5D4uP4GK4QtLPHnWhdQDRdQzSdG
        iZe979hBEmwCjhKTpj5gB0mICHQySqxfNp0JxGEWuMEk0bTlHQtIlbCAn8TJB+1go1gEVCV2
        Hl8NFucVsJTY/2I+E8QKeYnVGw6AreYUsJL4uOwsO8RJlhJzF8LUC0qcnPkEyOYAWqAusX6e
        EEiYGai1eets5gmMgrOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwNjc
        duzn5h2MlzYGH2IU4GBU4uGtsHkbK8SaWFZcmXuIUYKDWUmEd8nEV7FCvCmJlVWpRfnxRaU5
        qcWHGE2BXpvILCWanA9MG3kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqY
        ODilGhiz2ua9v7u2yeOkREH1yfJNz9b/mP46K7PoYfnpFQn/A//Jv5R6fpCb3fFwsLFu0M9S
        zhgRTe6iPy2xRcq6lm4Plni8V1qvs1/sZVbbxUplxZjZJ7cfOP9nWc56k+qXTMon+7PtPtzI
        8L+/puOdxF39F9YHD6SWt7zwuvzh5fXnzCxz7Y9PE7ymxFKckWioxVxUnAgArShV2uMCAAA=
X-CMS-MailID: 20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105031eucas1p137c3c5b0046570453e1ebed2dcd88277@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a new static function, exynos_bus_profile_init(), extracted
from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c832673273a2..b8ca6b9f4b82 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -287,12 +287,69 @@ static int exynos_bus_parse_of(struct device_node *np,
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
@@ -334,52 +391,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (passive)
 		goto passive;
 
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

