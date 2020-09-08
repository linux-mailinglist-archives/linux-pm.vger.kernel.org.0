Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37816260F61
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIHKNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:13:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41937 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgIHKMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:12:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200908101235epoutp0302357f12eff91d92005d729f5e3dbc32~yx03y9eL40358803588epoutp03-
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 10:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200908101235epoutp0302357f12eff91d92005d729f5e3dbc32~yx03y9eL40358803588epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599559955;
        bh=uI09m4rEErR3++Jvp7IJlofxtUSCl4SrKX/A6hkpczo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owLSs17em1pKu96QDjm4+F1iDw4IjZ76ls/gUsScDAcjyCeDb1wvnDbSOEiVkd/+0
         HbibgJxfcYHjDB1+0edqFaq2uEv46XJOZG0F605elI471zGgYwA3ArUqGL9cCOVpvV
         cqWmRfDwaydWNgFJs3zLwD+zIEWu6EPQoP9YUhrk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200908101234epcas1p49442d07d33998406b761fe5afa7d7c55~yx0232-uv1796017960epcas1p4W;
        Tue,  8 Sep 2020 10:12:34 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bm1DH2klxzMqYkk; Tue,  8 Sep
        2020 10:12:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.DE.20696.F09575F5; Tue,  8 Sep 2020 19:12:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epcas1p3d1fc20eb523c4bccf043ada808611e96~yx0zyAHI02954229542epcas1p3m;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908101230epsmtrp29ec50113b5870fbdbe4160e4be046aef~yx0zxazSS2650426504epsmtrp2D;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
X-AuditID: b6c32a39-eebff700000050d8-bd-5f57590f3497
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.99.08382.E09575F5; Tue,  8 Sep 2020 19:12:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epsmtip2faef9f14462d0f7f64b1ef8d2bd90b69~yx0zl7kDf1358513585epsmtip2q;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] PM / devfreq: Change prototype of
 devfreq_get_devfreq_by_phandle function
Date:   Tue,  8 Sep 2020 19:24:46 +0900
Message-Id: <20200908102447.15097-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908102447.15097-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmni5/ZHi8wcc2AYvrX56zWpw/v4Hd
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGixnn9zFZLGxqYbe43biCzYHTY828NYwem1Z1snlsXlLv
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Iz5h7ZyFjwWabi276prA2M0yW6GDk5JARMJP4vWczSxcjFISSwg1Hi3fYO
        VgjnE6NEx/IvjBDON0aJ08+/AGU4wFpaW9kg4nsZJRZ/XgnV8YVRYsPLE6wgc9kEtCT2v7jB
        BmKLCJRJ3P5ylRmkiFmglVHi3vNrTCAJYYFkiW+XpoHZLAKqEj8mbmcE2cArYCXxaCMPxH3y
        Eqs3HGAGsTkFrCW2r1oItllC4Bq7xMdPR5kgilwk5j1vYYGwhSVeHd/CDmFLSXx+t5cNwq6W
        WHnyCFRzB6PElv0XWCESxhL7l05mAlnMLKApsX6XPkRYUWLn77mMIDazAJ/Eu689UN/zSnS0
        CUGUKEtcfnAX6gRJicXtnVCrPCQOXDgMDbk+RomVd9cyTWCUm4WwYQEj4ypGsdSC4tz01GLD
        AlPkKNvECE5wWpY7GKe//aB3iJGJg/EQowQHs5IIb9eh0Hgh3pTEyqrUovz4otKc1OJDjKbA
        wJvILCWanA9MsXkl8YamRsbGxhYmhmamhoZK4rwPbynECwmkJ5akZqemFqQWwfQxcXBKNTAl
        VPmqe1yYKrxs0YwdrbMN5tQxrNJjSpv47phgq7XCE16f9gqF6YKn16jbX5viOUXP6efqDU+Y
        2xb+Sm6Zcehf1w6/iICJ9bfzOdd8uskccl3cVer4PXG1mqwbv2ZLHtFYV+hZsrnLcsbnqelX
        1xrW7ri1JCdcYGIiQ2jDsjeX4hN8C1yDebeUJe2ZaTPhqGyEfaCR496PT6wPb0w70v2QrXVN
        RavbIqddB2IaJcVWnAq/udxIm3ERU+Rq9mSzhwovXkpNX5JqJ57TsmWJ9OGnuvHKuw/MErfZ
        zVu1KUvllP7KySdMr1nrv9v89vZ81s3cN1iTuevfrHyupSv07+qjjY/PFz+yqq/1sf36JOaY
        EktxRqKhFnNRcSIAp4gZRvkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvC5fZHi8wYmXphbXvzxntTh/fgO7
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWNjUwm5xu3EFmwOnx5p5axg9Nq3qZPPYvKTe
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDLmHtnIWPBZpuLbvqmsDYzTJboYOTgkBEwkWlvZ
        uhi5OIQEdjNKdM89w9TFyAkUl5SYdvEoM0SNsMThw8UQNZ8YJT40PQCrYRPQktj/4gYbiC0i
        UCOxbO4esEHMAp2MEienvQRLCAskSvRtPghmswioSvyYuJ0RZCivgJXEo408ELvkJVZvOMAM
        YnMKWEtsX7UQrFwIqOTakh2MExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93E
        CA5CLc0djNtXfdA7xMjEwXiIUYKDWUmEt+tQaLwQb0piZVVqUX58UWlOavEhRmkOFiVx3huF
        C+OEBNITS1KzU1MLUotgskwcnFINTOpO84/IFr20nN79+Hfsec0zoUfzOTYeVZGWnd8t8oUn
        d1FA97qnB0rNj05XfFp/rbr9oKd7y9r3OT8D19cf2MK9peyP98t6K55PZ/5rzGo1lumML87w
        8PpXwi+9PzxD4tVJx40r9m1eeOiwimdfd79++Qu1x6aM9+7/TFrT+myex7Lwj393Plihd+LE
        hylBOfciF//p/7tmivb/Q1GX1fe371OTNvjrPf1oleqfW/91pj/eq21jdlil8fGmV/eEUldz
        H/s3NXVCqLjYQfnr3o+3L/+SderUnJXzT6z4pxX95FVYqEbVZVEPr6bPnCZnThRWM/uyT7z4
        Qk5Q1mvm+X1bbGbPZuFi7UjZb8HasXaSEktxRqKhFnNRcSIAvVob2LECAAA=
X-CMS-MailID: 20200908101230epcas1p3d1fc20eb523c4bccf043ada808611e96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908101230epcas1p3d1fc20eb523c4bccf043ada808611e96
References: <20200908102447.15097-1-cw00.choi@samsung.com>
        <CGME20200908101230epcas1p3d1fc20eb523c4bccf043ada808611e96@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, devfreq core support 'devfreq' property in order to get
the devfreq device by phandle. But, 'devfreq' property name is not proper
on devicetree binding because this name doesn't mean the any h/w attribute.

The devfreq core hand over the right to decide the property name
for getting the devfreq device on devicetree. Each devfreq driver
will decide the property name on devicetree binding and pass
the their own property name to devfreq_get_devfreq_by_phandle function.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c    | 11 +++++++----
 drivers/devfreq/exynos-bus.c |  2 +-
 include/linux/devfreq.h      |  5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b9b27fb3291e..d22bf3ce0404 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1012,22 +1012,24 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 /*
  * devfreq_get_devfreq_by_phandle - Get the devfreq device from devicetree
  * @dev - instance to the given device
+ * @phandle_name - name of property holding a phandle value
  * @index - index into list of devfreq
  *
  * return the instance of devfreq device
  */
-struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+					const char *phandle_name, int index)
 {
 	struct device_node *node;
 	struct devfreq *devfreq;
 
-	if (!dev)
+	if (!dev || !phandle_name)
 		return ERR_PTR(-EINVAL);
 
 	if (!dev->of_node)
 		return ERR_PTR(-EINVAL);
 
-	node = of_parse_phandle(dev->of_node, "devfreq", index);
+	node = of_parse_phandle(dev->of_node, phandle_name, index);
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
@@ -1043,7 +1045,8 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 	return ERR_PTR(-ENODEV);
 }
 
-struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+					const char *phandle_name, int index)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 8fa8eb541373..58dbf51f0983 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -360,7 +360,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
 	profile->exit = exynos_bus_passive_exit;
 
 	/* Get the instance of parent devfreq device */
-	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
+	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, "devfreq", 0);
 	if (IS_ERR(parent_devfreq))
 		return -EPROBE_DEFER;
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index eb971b8e5051..2f4a74efa6be 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -262,7 +262,8 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 				struct notifier_block *nb,
 				unsigned int list);
 struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
-struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
+				const char *phandle_name, int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -421,7 +422,7 @@ static inline struct devfreq *devfreq_get_devfreq_by_node(struct device_node *no
 }
 
 static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
-					int index)
+					const char *phandle_name, int index)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.17.1

