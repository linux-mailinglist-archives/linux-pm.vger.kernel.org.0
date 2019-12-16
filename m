Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128A51202EA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLPKsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 05:48:20 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53936 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 05:48:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191216104817euoutp01a77b64d1575925894f1fb4b11a195244~g1E0f7jHt1733917339euoutp01H
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 10:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191216104817euoutp01a77b64d1575925894f1fb4b11a195244~g1E0f7jHt1733917339euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576493297;
        bh=O6pcI0nl3cOacuyyeqkh+QDKkG1plk0wyzWw1uJR2cE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g5VB92M6Z/Gb0NzDoxraG1SidA2yRFf6Z13SC4rK9w/JX8I/lJkw+1R9n7dGDNrjt
         pZkek2PjXcTrpwA56TCD9tKGMggwkHKZQ43RqO+CdMY+EJRi0o8car0nfgJMgOKwaB
         UlFJ9mb35RFQvSheB4N81/i0JDToq35rtR+9lCbg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191216104817eucas1p13ae3217a6d97b3a7d1cab1c2fe4cb125~g1E0Qi9FP2735027350eucas1p1S;
        Mon, 16 Dec 2019 10:48:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 51.A3.60679.0F067FD5; Mon, 16
        Dec 2019 10:48:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216~g1Ez4YgmL1561015610eucas1p19;
        Mon, 16 Dec 2019 10:48:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216104816eusmtrp11c9a18d77c49ef7645a8040290858ebc~g1Ez3laSb1051110511eusmtrp1f;
        Mon, 16 Dec 2019 10:48:16 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-86-5df760f096b7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.EF.08375.0F067FD5; Mon, 16
        Dec 2019 10:48:16 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191216104815eusmtip167d0578b820b91814462f43866d8600d~g1EzJV3692559025590eusmtip1H;
        Mon, 16 Dec 2019 10:48:15 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com
Subject: [PATCH v2] PM / devfreq: exynos-bus: Reduce the numer of goto
 statements and remove unused headers
Date:   Mon, 16 Dec 2019 11:47:48 +0100
Message-Id: <20191216104748.18877-1-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87ofEr7HGixaZGNxf14ro8XGGetZ
        La5/ec5qMen+BBaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZvFjMkv2Rz4PDat6mTz2Lyk3qNvyypGj8+b5AJYorhsUlJzMstSi/TtErgyvrXnFJxU
        rti48QhjA+MmmS5GTg4JAROJAzf2s4LYQgIrGCUuPFPuYuQCsr8wSnz/95QRwvnMKLHgzDZ2
        mI7l35pYIRLLGSW6W1qY4Vp6H99jBKliE3CUmDT1AViHiEAro8TMJnUQm1lgGpPExt0OILaw
        QK7Eg57FTCA2i4CqxIHbc1lAbF4BS4lZM6ayQWyTl1i94QAzRFxQ4uTMJywQc+QlmrfOBlss
        IbCNXeJnazsLRIOLxKRlL6CahSVeHd8CdbaMxOnJPVA1xRJPd95nhWhuYJTYtOwIM0TCWuLw
        8YtACQ6gDZoS63fpQ4QdJbb1dICFJQT4JG68FYS4gU9i0rbpzBBhXomONiEIU0li10w+iEYJ
        iabV16Bme0jc3zcPGtKxEme2vGeewKgwC8ljs5A8NgvhhAWMzKsYxVNLi3PTU4uN8lLL9YoT
        c4tL89L1kvNzNzECE9Tpf8e/7GDc9SfpEKMAB6MSD69D9rdYIdbEsuLK3EOMEhzMSiK8OxS+
        xwrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAGG5tIFFh
        f0RSJOK/x/U4C7fYTXy71sgH9i87N1cl/vr6pf4Tj/wO1tnxaZPBm4IFXyeqsxn93d3zamvr
        9raV8583Jp5wX6WeeVgt12W5EWd+wbqJfcvttMPFU1i9dq7SiF39PHQnx8/nd5122fKz1dwx
        n9/0UPecWbeIu7N1W6dv0bfmpt97lViKMxINtZiLihMBYDVeFkwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xu7ofEr7HGqw9rWhxf14ro8XGGetZ
        La5/ec5qMen+BBaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZvFjMkv2Rz4PDat6mTz2Lyk3qNvyypGj8+b5AJYovRsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyvrXnFJxUrti48QhjA+MmmS5GTg4JAROJ
        5d+aWLsYuTiEBJYySsz/fY8RIiEh8XH9DVYIW1jiz7UuNoiiT4wSn44fACtiE3CUmDT1ATtI
        QkSgk1Gia/M5JhCHWWARk0TDxydMIFXCAtkSh74dYgGxWQRUJQ7cngtm8wpYSsyaMZUNYoW8
        xOoNB5gh4oISJ2c+AarhABqkLrF+nhBImBmopHnrbOYJjPyzkFTNQqiahaRqASPzKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMBo2nbs5+YdjJc2Bh9iFOBgVOLhdcj+FivEmlhWXJl7iFGC
        g1lJhHeHwvdYId6UxMqq1KL8+KLSnNTiQ4ymQC9MZJYSTc4HRnpeSbyhqaG5haWhubG5sZmF
        kjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGllyW4if8za/PhBYvMzMLOSy1Lk9pL0tCh+mm
        D8/+26qrn+T5fDUp4KQmW7F0/J4JjXNnaOa2LZvEcfvTu187lI0CtQ9YGZfFz7wYcsAlXKn8
        ggTL3oIeGUGj/OS5HB95dWddndkmdaA871vx1K+nQ4/MrFo6VcHvmbC+qhePlfMf9y6RY3eU
        WIozEg21mIuKEwGyNPL6vAIAAA==
X-CMS-MailID: 20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216
References: <CGME20191216104816eucas1p1775a0dac98f507e10ee2fa15dccdc216@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch improves code readability by changing the following construct:

    if (cond)
        goto passive;
    foo();
    goto out;
passive:
    bar();
out:

into this:

    if (cond)
        bar();
    else
        foo();

as well as eliminating a few more goto statements (related to return
paths).

Moreover, this patch removes unused header file includes and adds a missing
include <linux/of.h>.

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

