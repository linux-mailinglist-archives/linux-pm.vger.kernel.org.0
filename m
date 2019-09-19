Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F1B7C59
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbfISOYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:24:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46455 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390477AbfISOXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142323euoutp01f32eff2aad982638f9f666c1ec141bb0~F3Pguut242256022560euoutp01V
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142323euoutp01f32eff2aad982638f9f666c1ec141bb0~F3Pguut242256022560euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903003;
        bh=AfthMmM6EgHw5o7aJ+tOGSYwkpSBVAIvY47THmRlg88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUfGFo9QIDKkubnSJ5/YQMuqyznHJ0n2dRX/MpysB1HAGdhN3OKccdnTnPzSW9fSZ
         J5fPYC2ZcGw7ZI64nfB9qI8jSm3P2GAaP7jp36X9AS8qDPF7pTBcLclVExcA4JCo0N
         e8IxiOhUBw/Jb4QzH73svIjcl6ty2FYF/QGKl2gE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142323eucas1p2137d5fd4ba615c27d374c78200548f67~F3PgKgjez2883328833eucas1p2u;
        Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.0C.04469.A5F838D5; Thu, 19
        Sep 2019 15:23:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d~F3PfLq4zH3081130811eucas1p2n;
        Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142321eusmtrp19477a6779bcf10be72c5ec00a5f107ab~F3Pe881yZ0555105551eusmtrp1K;
        Thu, 19 Sep 2019 14:23:21 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-f8-5d838f5a4ad8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.55.04117.95F838D5; Thu, 19
        Sep 2019 15:23:21 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142320eusmtip13d096101d63cf3d7c53334a2bda52896~F3PeLg9Oy3274232742eusmtip1o;
        Thu, 19 Sep 2019 14:23:20 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
Date:   Thu, 19 Sep 2019 16:22:26 +0200
Message-Id: <20190919142236.4071-2-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO7cdV7PjFHqzMlv4o8gbZHxRSULUiUAUoh+G1CkPJs0LO9r1
        R1MzvKSWVs5LKhVeE+fU0OWl1nJY5LJsKWmrLCKxrNQuUNLmMerf87zP5f1e+FhS/ZL2ZROS
        UkVdkqDVMErqVt9Pe2BMYWZsyP3fgdjS167AzsoshFsMzTR+PvOexlXWARoPzU4xuKTbxOAi
        5wUK2+1GBa4b+0Jj07iDxk/NFQyezrcibLD3ELjJOqbAL9LrGGwo/sBs9+JNDTkMP+roYnhn
        no3gW2+c4Vs+dRD83U9dBF/Q1oD4aZNfFBuj3BonahOOibrg8IPKI/2frUzKo1UnMh7r9Cgf
        cpEHC9xGuDL3hMhFSlbN1SG4NFFDy2QGwfD1MiSTaQQj7U3M30hvr3EhUoug+Gbpv0i/YWze
        xXARUHT5lcIt+HBWl6t6inITkrtBQEG5nXS7vLl9MGgw0m5McQFQP3ptfq7iMLTrnbS8bzU0
        Gu/Mzz24zTDTU0XJHi/oL307j0mXJ7O9nHQvAC6dhecVJS6BdZEdMNm4W+7xhglbm0LGK+Fh
        8XlKxhK863TSclaPwFRjJWVhC9yzDdLuHpJbB83mYHkcAfVvvhByvScMf/SSn+AJRbdKSHms
        guxzahlqwFzqKQcBMhodC908jNuq0QW0puy/W8r+u6Xs39pqRDagZWKalBgvSqFJ4vEgSUiU
        0pLigw4nJ5qQ69c9nLN97UCzTw5ZEMcizRKV//HMWDUtHJNOJloQsKTGR1URlhGrVsUJJ0+J
        uuQDujStKFnQCpbSLFOdXvRqv5qLF1LFo6KYIur+qgTr4atHV43Sxe87zel6bWQ/M5K/rng2
        fqjxm+CXTBwOCCycSvP3Pvt6r35XF+lYqqVjo2tTl4TXjyjDzSds+h95+XHdCW2LN1DCwJ6s
        fYzfoWcdYWF5m46G3c6OyjDltHoH11RmT26rddzf+yiqs3Dn9cgND6q/ra16aghZXjERbVjx
        q8GhoaQjQuh6UicJfwCR5LDPcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7qR/c2xBvcn61kcOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL+PkhyNsBWdlK5ouFDUw9kp0MXJySAiYSOzfv4Gpi5GLQ0hgKaPE5AtX
        2SESEhIf199ghbCFJf5c62IDsYUEPjFKvH0rC2KzCThKTJr6gB2kWUTgFKPE1uXn2EAcZoEN
        TBLLn74E6xYWCJHoWvKYGcRmEVCVWHlnEZjNK2AhsbXhPtQGeYnVGw6AxTkFLCW+7JvPArHN
        QmLu47mMEPWCEidnPgGKcwAtUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZgBG879nPLDsaud8GHGAU4GJV4eBXKm2OFWBPLiitzDzFK
        cDArifDOMW2KFeJNSaysSi3Kjy8qzUktPsRoCvTaRGYp0eR8YHLJK4k3NDU0t7A0NDc2Nzaz
        UBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKDU1pS1X2W9/TrVQ08wHC3fc6pab5hYQuFj3
        Wp1Z86sfj0Prn4SfWa+7/LFjjT2PSdnsdl7luSvf7Go+8zPDl+cB/8ff15+6vQqbMdHjVCHX
        jcSkkpdTexarclbvzJ30S/GD8Y8qG7+0X9MXmj36rBfwjvWuy7aHiZ3cd/88al84ZUrc9rNH
        xJRYijMSDbWYi4oTAbT4Bh32AgAA
X-CMS-MailID: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142322eucas1p24bc477ee6e1bcd65546c305d55af097d@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds a new static function, exynos_bus_profile_init(), extracted
from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 92 +++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 29f422469960..78f38b7fb596 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -287,12 +287,62 @@ static int exynos_bus_parse_of(struct device_node *np,
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
@@ -334,45 +384,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
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

