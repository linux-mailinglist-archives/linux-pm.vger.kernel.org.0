Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10CA116B6B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfLIKue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46086 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfLIKue (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209105033euoutp0286f0f7f9af252a93f1609927f0b375da~erlzWcpyu3074430744euoutp02x
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 10:50:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209105033euoutp0286f0f7f9af252a93f1609927f0b375da~erlzWcpyu3074430744euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575888633;
        bh=bQfaK3H9O2avQYC2R28z2VtVDLkeXfgJH5IcB1mxqe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYLJ8a3hTe/OOoTe9JbniNjFuPGeqCDInx4ulNCXQskG8JPUZhidChrlGvVvHItRH
         X6y/jgZe/IbCvZa7Buog2RzLUnI0hVijeDUBrTEcUojHmcp5s1IuT4Gz/JOeQHtshx
         VRu1DwU93/nf9Q+x5kv1Dmci3vWwV6EgGDsI9low=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209105033eucas1p1dfa9ba65a240fe8b871e8e8727ddba22~erlzCvAJH0954309543eucas1p1k;
        Mon,  9 Dec 2019 10:50:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2B.34.60698.8F62EED5; Mon,  9
        Dec 2019 10:50:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f~erlypQkhy0955109551eucas1p1f;
        Mon,  9 Dec 2019 10:50:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209105032eusmtrp16fb547a39e6f6d1b5dd5f8f55890489b~erlyokVPQ2125621256eusmtrp1X;
        Mon,  9 Dec 2019 10:50:32 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-87-5dee26f8fddd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.D7.07950.8F62EED5; Mon,  9
        Dec 2019 10:50:32 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209105031eusmtip185d18721653d060ac1dedd6a86189480~erlx1udGa2957929579eusmtip1n;
        Mon,  9 Dec 2019 10:50:31 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        k.konieczny@samsung.com, leonard.crestez@nxp.com
Subject: [PATCH v3 2/4] devfreq: exynos-bus: Extract
 exynos_bus_profile_init_passive()
Date:   Mon,  9 Dec 2019 11:49:00 +0100
Message-Id: <20191209104902.11904-3-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209104902.11904-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229nZjquN41R8s1AbZCWklUVfGpERtiJIoigsqZkHFa/tqGV/
        Mk0xb3nB3CxNTJdpeZkXVEhjWt6SYYYZpossvOXEdJUSlvNo+e95n8v7fC98FCHtIe2p4PAo
        RhmuCJUJRPyG1wv6XQvORr/dxZ7YUJiIcI2qisTv58dInG3I5OOi7yoS3xudIrBeXy3EvfHf
        hLhseJbE2tEBEvc3PxTgufR2hFX6Fh5+3j4sxEO3ywRYlTMhOELLteV3BfLaklvyGmMjT55R
        V47kc1oHH9JXdCiACQ2OYZRuh6+IgipHpgWRcZtuLKVX8+NQl00KsqSA3gemcQ1KQSJKSpch
        yNclkNwwj2BCl8vjhjkEyWU6Yi2S+uLdauQJgvqcFt6/yLNFAzK7BLQXZOd+EpoFGzoRQZ/+
        A2EeCLqbB+NJ8aTZZU1fgM7WSZ4Z8+ltYDLOrXSI6YNQOvRWyPU5QkX1yxXekvaAWU2vkPNY
        QZf6C9+MiWVPQv2DlQKgJ4Qw83gYceFjUFs4RnLYGiY76laXboGenDQ+h1n42mQguXAcAq2m
        ffVST2jr6FsWqOWGnVDV7MbRXjDYkYXMNNASGJy24t4ggeyGPIKjxZCcJOWgDJrVEi4IEF8x
        sLpbDsaCAiITbc1fd0z+umPy/9cWIaIc2THRbFggw7qHM9ddWUUYGx0e6Ho1IkyLlr9Yz1KH
        qRG1/PbXIZpCso1iJ49pPympiGFjw3QIKEJmIy7JmvSTigMUsTcZZcRlZXQow+rQZoovsxO7
        F0/4SelARRQTwjCRjHJN5VGW9nEolcB/ks/Z1ZVGJgRYRNk692obkx45Nu2wkMSqCk+aND62
        p5ReRYuakdnjLg3y+wm5ToyoPz4lVVytvSTqlj0ddTrftn9pw9m9hEuM90W1RCT59SojpDNw
        5gSv0lv5+dpQlr86cXvrgTtHsdF3yeFNmvuPMz/ztKd9Kp0/To0PZMr4bJBijwuhZBV/AfBy
        b5VeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7o/1N7FGvQsVLS4P6+V0WLjjPWs
        Fte/PGe1mHR/AovFgk8zWC36H79mtjh/fgO7xdmmN+wWK+5+ZLXY9Pgaq8XlXXPYLD73HmG0
        mHF+H5PF2iN32S1uN65gs5gx+SWbg4DHplWdbB6bl9R7bHy3g8mjb8sqRo/Pm+QCWKP0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mtbde8tW0CBZ
        8a93A0sD40mRLkZODgkBE4nuvVcYQWwhgaWMEg3zCyHiEhIf199ghbCFJf5c62LrYuQCqvnE
        KHF00nwmkASbgKPEpKkP2EESIgKdjBLrl01nAnGYBW4wSTRtecfSxcjBISwQJnF3nw9IA4uA
        qsTXd5+ZQWxeAUuJpbcvsUNskJdYveEAWJxTwEri47Kz7BAXWUrMXbiaBaJeUOLkzCdgI5kF
        1CXWzxMCCTMDtTZvnc08gVFwFpKqWQhVs5BULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7
        iREYmduO/dyyg7HrXfAhRgEORiUeXgWrt7FCrIllxZW5hxglOJiVRHiXTHwVK8SbklhZlVqU
        H19UmpNafIjRFOi1icxSosn5wKSRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUg
        tQimj4mDU6qB8eCxv2fCVuqu5T5WK6gglbzh5NHihW5l/8w5jn1cYhs88+r2DJmSC9q/Pnpm
        nT+Yeni1Y7XoDkOZliSBEJnGs6f3zY64nVDr9FK6oXmdhEpt4XTbF0xP67affxY1+5gI19Yj
        PeoqnT+bPuhpzd22NLIyqCR8uUigyUZl9T6+qV7iR2YK2zy+p8RSnJFoqMVcVJwIADIpCafi
        AgAA
X-CMS-MailID: 20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105032eucas1p13fa6c46a1e80cdda68ab4bac3e008b8f@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a new static function, exynos_bus_profile_init_passive(),
extracted from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index b8ca6b9f4b82..19d9f9f8ced2 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -345,13 +345,51 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	return ret;
 }
 
+static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
+					   struct devfreq_dev_profile *profile)
+{
+	struct device *dev = bus->dev;
+	struct devfreq_passive_data *passive_data;
+	struct devfreq *parent_devfreq;
+	int ret = 0;
+
+	/* Initialize the struct profile and governor data for passive device */
+	profile->target = exynos_bus_target;
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
@@ -397,33 +435,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 	goto out;
 passive:
-	/* Initialize the struct profile and governor data for passive device */
-	profile->target = exynos_bus_target;
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

