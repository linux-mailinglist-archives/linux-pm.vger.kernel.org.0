Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F0B7C1F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfISOX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53411 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfISOXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142324euoutp0270e062cf13569d5571d731ec6db3613a~F3PhiOaSW1748917489euoutp02C
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190919142324euoutp0270e062cf13569d5571d731ec6db3613a~F3PhiOaSW1748917489euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903004;
        bh=g5BuchGjulmMrqHu7UnNWSPjw3PX42w6jYwlR2z1Rfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6T3JoXrmDr315AUzTCkwRr7TLrJk/JzHE+8ZjeINxyUxVi2O3ZZ/XdmhsTqX8rNd
         /fmKEK8gLqTdUqzVIGBIl4F+bdYD62cdJhcJ6BjlPXP+qFaYDEvD/tZMSIRqz++CCs
         db6LidNrZM+h7Mcai8dEX++P5K4TggX6kGGw8JTA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190919142323eucas1p19985294982f8a206d190447d9d111ac6~F3Pgvj2m30292702927eucas1p17;
        Thu, 19 Sep 2019 14:23:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.0C.04469.B5F838D5; Thu, 19
        Sep 2019 15:23:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142322eucas1p1949ad95468af26698c4c5addc060ce00~F3Pf9116O1888018880eucas1p18;
        Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142322eusmtrp1d6241a1800bd62d08a28d8a886482408~F3Pfuxx9k0555105551eusmtrp1N;
        Thu, 19 Sep 2019 14:23:22 +0000 (GMT)
X-AuditID: cbfec7f2-994db9c000001175-fe-5d838f5b4888
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.55.04117.A5F838D5; Thu, 19
        Sep 2019 15:23:22 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142321eusmtip1ddb6ff07278fac49544b852180531b8e~F3Pe9szH-3161631616eusmtip1b;
        Thu, 19 Sep 2019 14:23:21 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 02/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init_passive()
Date:   Thu, 19 Sep 2019 16:22:27 +0200
Message-Id: <20190919142236.4071-3-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeyyVYRjv/W7nI0efo+aJppytNjZKsd6GRqv1ra3Lam2NoVO+0XLrfC6V
        LbdpkVRouYWW5TbDQSFUpxM144RSQsdWVsllrslWy/FR/vu9v8vze57tZUnFJ9qaPRcaIahD
        VcFKxpR61PpL7+hzM9F3x1QhYG1rnQwb8pMQrs6qpPH7ma80LtB10vjt7ASD7zZrGJxuuEVh
        vb5KhksGJ2ms+dxL457GPAZP39AhnKVvIXCFblCG++NLGJyV8Z3xtOA1ZckMP9DbxPCG620E
        X1MUy1eP1xP88/Emgk+rLUP8tMb2GOtt6h4gBJ+LEtTb9542DfrWMUKGP914MX7qFRGH4jek
        IBMWOBcY+FNBGrGCK0HQ0rM2BZku4hkET2pGGekxjeBFwzy1kpjrf0pLQjGCx8WV1L/Iz/xy
        xuhiOC9IvzMkMwrrOR2CjMKJJRfJFRGQlqtfarTk/GD2Rx+RgliW4rZCwjs7Iy3nMJSPliKp
        bjOUVz1bsptwe2CmpYCSPBbwOvvLEiYXPYl1uaRxPnBJLMw96yCl8H54PpFJSNgSRtpqZRLe
        BO0Zqcv3iDDcYKClcBwCzUPdctgNXrR10cblSM4eKhu3S7QX5Ob2UEYaOHP4MGYh7WAO6Y/u
        khIth2tXFRJUQmO2uRQESCjvXZ7NQ2njbeYWsstZdUzOqmNy/tcWIrIMWQmRYkigIDqHCtFO
        oipEjAwNdDobFqJBi7+u/U/bVD2a7T6jRRyLlGbyLdGJvgpaFSVeCtEiYEnlenmea4KvQh6g
        unRZUIf5qyODBVGLbFhKaSWPWTPko+ACVRHCeUEIF9QrKsGaWMehhrqjI9ormR3NJzyPnI7x
        6Gw6m3rK+eVvb7/hB9MHzWz3drvKdyksttTYJQlpB7y2DTlMjt6zHfZQOzq/uRx7yPrAPlm2
        wx37N81d4Yn2Fw8r1J+PZyfX9q+j/dm5lkMLvgvBGupCa9d5K5eondW775/82DdmEz1xuDdr
        vqDU4O4W7aWkxCCVswOpFlV/AfT9tq9xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7pR/c2xBsueqFgcOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL+PF2VfMBfslKxo/nWBqYGwU7WLk5JAQMJH4dns/K4gtJLCUUeLeUxWI
        uITEx/U3WCFsYYk/17rYuhi5gGo+MUpMmjGDBSTBJuAoMWnqA3aQhIjAKUaJrcvPgVUxC2xg
        klj+9CVYu7BAjMSSjTeZuhg5OFgEVCWariqChHkFLCRWv1nJCLFBXmL1hgPMIDangKXEl33z
        WSAuspCY+3guI0S9oMTJmU9YQMYwC6hLrJ8nBBJmBmpt3jqbeQKj4CwkVbMQqmYhqVrAyLyK
        USS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMIK3Hfu5ZQdj17vgQ4wCHIxKPLwK5c2xQqyJZcWV
        uYcYJTiYlUR455g2xQrxpiRWVqUW5ccXleakFh9iNAX6bCKzlGhyPjC55JXEG5oamltYGpob
        mxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYFQQ3u1sNGGxUdVs5eNLNj8Wrwn++TTk
        ztZJsl3VRzPeFNxm9f1xOvy4vlRqa94erpXiiftLN0ds27b8yIP2K4727O5pWW1/rvxPnSs8
        49ICKx/VOyrHJrAIpnNbiv/5KHArllGX/bPfPc1+Obbgqqs+3//lfPhbysPncXk7w3Rvb6fH
        O5N1m5VYijMSDbWYi4oTATIk7Rz2AgAA
X-CMS-MailID: 20190919142322eucas1p1949ad95468af26698c4c5addc060ce00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142322eucas1p1949ad95468af26698c4c5addc060ce00
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142322eucas1p1949ad95468af26698c4c5addc060ce00
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142322eucas1p1949ad95468af26698c4c5addc060ce00@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

This patch adds a new static function, exynos_bus_profile_init_passive(),
extracted from exynos_bus_probe().

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/devfreq/exynos-bus.c | 70 +++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 78f38b7fb596..f85bed241631 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -338,13 +338,51 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
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
@@ -390,33 +428,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
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

