Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26B260F60
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIHKNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:13:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28566 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgIHKMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:12:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200908101235epoutp0227b33087180057b879d4c5c99c864590~yx04DU_Ty0048600486epoutp02C
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 10:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200908101235epoutp0227b33087180057b879d4c5c99c864590~yx04DU_Ty0048600486epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599559955;
        bh=J/Dt3B5epxM2hfl2xSuuQL+o/kFO8VBmHsh0AA6NAv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAZEZSc02t00u0GNIy9jtsUimxQ0iOXA+7AMthZyvozKVFLrnJlVjsCe7+7NJL/Bp
         f/BsIYn/+XpyPvp2pvO+Dm/WTwH2HRRsiaIlEMM/5GwftZpLuJdvl3ksVB9/7FqtPZ
         t2nG8UIAHga3vyPavMIe5CPRMd2Ujv1BComv5MlY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200908101235epcas1p4e665b4bd0dc7ee631a31d9be8c14de24~yx03wozhq1793617936epcas1p4m;
        Tue,  8 Sep 2020 10:12:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Bm1DH5tFZzMqYlv; Tue,  8 Sep
        2020 10:12:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.C9.18978.F09575F5; Tue,  8 Sep 2020 19:12:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955~yx0z5w8121795917959epcas1p4b;
        Tue,  8 Sep 2020 10:12:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200908101231epsmtrp19a55fde1eb3c2658931f53fc9c6b87b2~yx0z5FRHu1887518875epsmtrp1c;
        Tue,  8 Sep 2020 10:12:31 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-e2-5f57590fda38
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.99.08382.E09575F5; Tue,  8 Sep 2020 19:12:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200908101230epsmtip2282421ce7b62a585df96a94121857b21~yx0zqf2h81256012560epsmtip2k;
        Tue,  8 Sep 2020 10:12:30 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] PM / devfreq: event: Change prototype of
 devfreq_event_get_edev_by_phandle function
Date:   Tue,  8 Sep 2020 19:24:47 +0900
Message-Id: <20200908102447.15097-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908102447.15097-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmni5/ZHi8QdcJXYvrX56zWpw/v4Hd
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGixnn9zFZLGxqYbe43biCzYHTY828NYwem1Z1snlsXlLv
        0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QPcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Iz1nX/Zy54aFbx7fZu1gbG/bpdjJwcEgImEouPbGMHsYUEdjBK7Jpo0MXI
        BWR/YpQ4f+ElM0TiG6PEnUMOMA2zfv1lhyjayyjRuXAbM4TzhVFi9ukeJpAqNgEtif0vbrCB
        2CICZRK3v1wFK2IWaGWUuPf8GliRsECuxNr+02C7WQRUJZqnrQGL8wpYSdw4/JgVYp28xOoN
        B8DO4BSwlti+aiEbyCAJgWvsEv9ffIAqcpE42XaLEcIWlnh1fAs7hC0l8bK/Dcqullh58ghU
        cwejxJb9F6CajSX2L50MtJkD6DxNifW79CHCihI7f88Fm8kswCfx7msPK0iJhACvREebEESJ
        ssTlB3eZIGxJicXtnWwQtofEhy/zGCGh0scosfz+V6YJjHKzEDYsYGRcxSiWWlCcm55abFhg
        iBxlmxjBCU7LdAfjxLcf9A4xMnEwHmKU4GBWEuHtOhQaL8SbklhZlVqUH19UmpNafIjRFBh6
        E5mlRJPzgSk2ryTe0NTI2NjYwsTQzNTQUEmc9+EthXghgfTEktTs1NSC1CKYPiYOTqkGJplF
        q+YfPn2Jfa5x9IxXXhYZbu//bOxWOHvoUffO1RfX9y5mrwxi4BFPrdysuvGp/6Xcsv9sm8+0
        COhKXTxg8WT73Lqnqit77CpZ4lyDH0k+SexY8lj9jdxH7XBLX/5dE8Oydj1d2ZEgahq480Pp
        XZPWv4x7kjxOJn681WtqIXTjZ9Vc77LnJxf/XC8S2ubn01Hk0+4Zn5PB7OEydcZpa1OTM9+Y
        nC6rPi9+PHFLuHHHteANUxknnWZf467V5lPc6+9U8KBd/GCjcfe3RQfkeFYkmRxh0pNWOXx4
        x7YbObX/G3/5n+faIvHNmM1T04w5UZknUSTsh8ca5lXq8yS2fFu8VlKgzW6LlvJOE+1SJZbi
        jERDLeai4kQA66q/UfkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSvC5fZHi8wapflhbXvzxntTh/fgO7
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWNjUwm5xu3EFmwOnx5p5axg9Nq3qZPPYvKTe
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDLWdf9nLnhoVvHt9m7WBsb9ul2MnBwSAiYSs379
        Ze9i5OIQEtjNKPHkzllmiISkxLSLR4FsDiBbWOLw4WKImk+MEkv+7WADqWET0JLY/+IGmC0i
        UCOxbO4eNpAiZoFORomT016CJYQFsiWW/u1nAbFZBFQlmqetYQKxeQWsJG4cfswKsUxeYvWG
        A2CLOQWsJbavWgjWKwRUc23JDsYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEB6KW5g7G7as+6B1iZOJgPMQowcGsJMLbdSg0Xog3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        jcKFcUIC6YklqdmpqQWpRTBZJg5OqQam+ZsURflqjy1vO672PpJj79ZbCjl3RGdF1d8sP6I4
        xTx4r3NNJPfEikmzJwX63JW4fLZxV9C6fvFjK8SX9AsX5W5W/bN/hcD5lSLzch9kax3p2pVX
        1ZpzkH9X5OGDnCuMmyKLZDjzjzF/T3xeYfG/YZvr0i2CB86eXsB0RkyUn//XOq+LzV1e33d2
        /va/W6RZ9Tyz6TufGYvHA631WiqGLsv23rtRm3HoUFrZrx2NgROqdibeu7e16PGMRx3qy/0W
        G5f1MLf/Oa5n5nJ0nurs7mkXZ598oyz55VzRsXcFn77kKf3fbigUYnHI6uO/7ItrApilQhg/
        +n/lTL1e3iN6i9/08bGMZxdKri6S9rRNUmIpzkg01GIuKk4EALtnlsyzAgAA
X-CMS-MailID: 20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955
References: <20200908102447.15097-1-cw00.choi@samsung.com>
        <CGME20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, devfreq core support 'devfreq-events' property in order to get
the devfreq-event device by phandle. But, 'devfreq-events' property name is
not proper on devicetree binding because this name doesn't mean
the any h/w attribute.

The devfreq-event core hand over the rights to decide the property name
for getting the devfreq-event device on devicetree. Each devfreq-event driver
will decide the property name on devicetree binding and then pass
the their own property name to devfreq_event_get_edev_by_phandle function.

And change the prototype of devfreq_event_get_edev_count function
because of used deprecated 'devfreq-events' property.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c         | 14 ++++++++------
 drivers/devfreq/exynos-bus.c            |  5 +++--
 drivers/devfreq/rk3399_dmc.c            |  2 +-
 drivers/memory/samsung/exynos5422-dmc.c |  6 ++++--
 include/linux/devfreq-event.h           | 14 ++++++++++----
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 56efbeb7851e..6765c03334bc 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -213,20 +213,21 @@ EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
  * devfreq_event_get_edev_by_phandle() - Get the devfreq-event dev from
  *					 devicetree.
  * @dev		: the pointer to the given device
+ * @phandle_name: name of property holding a phandle value
  * @index	: the index into list of devfreq-event device
  *
  * Note that this function return the pointer of devfreq-event device.
  */
 struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
-						      int index)
+					const char *phandle_name, int index)
 {
 	struct device_node *node;
 	struct devfreq_event_dev *edev;
 
-	if (!dev->of_node)
+	if (!dev->of_node || !phandle_name)
 		return ERR_PTR(-EINVAL);
 
-	node = of_parse_phandle(dev->of_node, "devfreq-events", index);
+	node = of_parse_phandle(dev->of_node, phandle_name, index);
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
@@ -258,19 +259,20 @@ EXPORT_SYMBOL_GPL(devfreq_event_get_edev_by_phandle);
 /**
  * devfreq_event_get_edev_count() - Get the count of devfreq-event dev
  * @dev		: the pointer to the given device
+ * @phandle_name: name of property holding a phandle value
  *
  * Note that this function return the count of devfreq-event devices.
  */
-int devfreq_event_get_edev_count(struct device *dev)
+int devfreq_event_get_edev_count(struct device *dev, const char *phandle_name)
 {
 	int count;
 
-	if (!dev->of_node) {
+	if (!dev->of_node || !phandle_name) {
 		dev_err(dev, "device does not have a device node entry\n");
 		return -EINVAL;
 	}
 
-	count = of_property_count_elems_of_size(dev->of_node, "devfreq-events",
+	count = of_property_count_elems_of_size(dev->of_node, phandle_name,
 						sizeof(u32));
 	if (count < 0) {
 		dev_err(dev,
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 58dbf51f0983..1e684a448c9e 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -193,7 +193,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	 * Get the devfreq-event devices to get the current utilization of
 	 * buses. This raw data will be used in devfreq ondemand governor.
 	 */
-	count = devfreq_event_get_edev_count(dev);
+	count = devfreq_event_get_edev_count(dev, "devfreq-events");
 	if (count < 0) {
 		dev_err(dev, "failed to get the count of devfreq-event dev\n");
 		ret = count;
@@ -209,7 +209,8 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	}
 
 	for (i = 0; i < count; i++) {
-		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
+		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev,
+							"devfreq-events", i);
 		if (IS_ERR(bus->edev[i])) {
 			ret = -EPROBE_DEFER;
 			goto err_regulator;
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 027769e39f9b..2e912166a993 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -341,7 +341,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(data->dmc_clk);
 	}
 
-	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
+	data->edev = devfreq_event_get_edev_by_phandle(dev, "devfreq-events", 0);
 	if (IS_ERR(data->edev))
 		return -EPROBE_DEFER;
 
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index b9c7956e5031..714d1f6f077c 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1293,7 +1293,8 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 	int counters_size;
 	int ret, i;
 
-	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
+	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev,
+							"devfreq-events");
 	if (dmc->num_counters < 0) {
 		dev_err(dmc->dev, "could not get devfreq-event counters\n");
 		return dmc->num_counters;
@@ -1306,7 +1307,8 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 
 	for (i = 0; i < dmc->num_counters; i++) {
 		dmc->counter[i] =
-			devfreq_event_get_edev_by_phandle(dmc->dev, i);
+			devfreq_event_get_edev_by_phandle(dmc->dev,
+						"devfreq-events", i);
 		if (IS_ERR_OR_NULL(dmc->counter[i]))
 			return -EPROBE_DEFER;
 	}
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index f14f17f8cb7f..4a50a5c71a5f 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -106,8 +106,11 @@ extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
 				struct devfreq_event_data *edata);
 extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
 extern struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
-				struct device *dev, int index);
-extern int devfreq_event_get_edev_count(struct device *dev);
+				struct device *dev,
+				const char *phandle_name,
+				int index);
+extern int devfreq_event_get_edev_count(struct device *dev,
+				const char *phandle_name);
 extern struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 				struct devfreq_event_desc *desc);
 extern int devfreq_event_remove_edev(struct devfreq_event_dev *edev);
@@ -152,12 +155,15 @@ static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
 }
 
 static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
-					struct device *dev, int index)
+					struct device *dev,
+					const char *phandle_name,
+					int index)
 {
 	return ERR_PTR(-EINVAL);
 }
 
-static inline int devfreq_event_get_edev_count(struct device *dev)
+static inline int devfreq_event_get_edev_count(struct device *dev,
+					const char *phandle_name)
 {
 	return -EINVAL;
 }
-- 
2.17.1

