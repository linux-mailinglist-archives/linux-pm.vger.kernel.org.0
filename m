Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD3127231
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 01:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLTASW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 19:18:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:50865 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLTASJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 19:18:09 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191220001804epoutp016f1d9f98f1e65fa2ce8c69eb8df11b15~h7Dtw6ntQ2163421634epoutp01S
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 00:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191220001804epoutp016f1d9f98f1e65fa2ce8c69eb8df11b15~h7Dtw6ntQ2163421634epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576801084;
        bh=FthgohP5usrQGRR1x0ruph/6eykA1sFddMA2lyrvL9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKn+1R9PzoTWs04WY8zeIQVh39RlLGdxFoemdxPJIfhSf5Pw3Xx/xowJ7WZqp9ItI
         gEZP4vFauktsj/B0RtzwiQ8FL4LzeIjt6LR+rB+u/xbKZJQVpiV6wW4+hqtO5+ptQ9
         Bip/mWoKQWROhXph9ybFlUg6g8DM+r4xlTuzIzbk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220001803epcas1p493ed22c7ba4fae3b0a4739e2ac9f5c83~h7DtIOJEH2970029700epcas1p48;
        Fri, 20 Dec 2019 00:18:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47f8Th25zMzMqYkq; Fri, 20 Dec
        2019 00:18:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.7D.52419.8331CFD5; Fri, 20 Dec 2019 09:18:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epcas1p1fc0e5019514f7c99606347432d66bfd0~h7DpKJ2xQ2819628196epcas1p1n;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220001759epsmtrp1b51908df8b1f9f8ff8867c9fc9bd074d~h7DpJKDJ61705617056epsmtrp1R;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-12-5dfc1338083f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.6C.06569.7331CFD5; Fri, 20 Dec 2019 09:17:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220001759epsmtip1dc61565a113c9a4ce9e7eb00800b33ca~h7Do8q4kK2050220502epsmtip1y;
        Fri, 20 Dec 2019 00:17:59 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     mark.rutland@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 03/11] PM / devfreq: event: Add
 devfreq_event_get_edev_by_node function
Date:   Fri, 20 Dec 2019 09:24:22 +0900
Message-Id: <20191220002430.11995-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002430.11995-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmrq6F8J9Yg8ZZ3Bb357UyWlz/8pzV
        Yv6Rc6wW/x+9ZrXof/ya2eL8+Q3sFmeb3rBbrLj7kdVi0+NrrBaXd81hs/jce4TR4tOD/8wW
        M87vY7JY2NTCbrH2yF12i6XXLzJZ3G5cwWbRuvcIu4OQx5p5axg9Nq3qZPPYvKTeY+O7HUwe
        fVtWMXpsvzaP2ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygN5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWl
        eel6yfm5VoYGBkamQIUJ2Rlnfs9jK1jiXrGj/xdjA+N26y5GTg4JAROJTf9XMHYxcnEICexg
        lFj89ScrhPOJUaLvzkEWCOcbo8Se/81MMC2X93YxQyT2Mkos+bKQCcL5wiix/ddLdpAqNgEt
        if0vbrCB2CICGRIzX18Gm8ss8JFJomvbXaAEB4ewQIzEzlnqICaLgKrErS9xICavgJXEpXnm
        ELvkJVZvOMAMYnMKWEtsefaQHWSKhMB/NomDs4+wQxS5SHy+vwnKFpZ4dXwLlC0l8bK/Dcqu
        llh58ggbRHMHo8SW/RdYIRLGEvuXTmYCWcwsoCmxfpc+RFhRYufvuYwgNrMAn8S7rz2sICUS
        ArwSHW1CECXKEpcf3IWGiaTE4vZONgjbQ2LupxfQIOljlJj06zn7BEa5WQgbFjAyrmIUSy0o
        zk1PLTYsMEaOsU2M4GSqZb6DccM5n0OMAhyMSjy8Dmm/Y4VYE8uKK3MPMUpwMCuJ8N7u+Bkr
        xJuSWFmVWpQfX1Sak1p8iNEUGJATmaVEk/OBiT6vJN7Q1MjY2NjCxNDM1NBQSZyX48fFWCGB
        9MSS1OzU1ILUIpg+Jg5OqQbGooWC14Ps+TYGtCfzSAnVWt1q+eAoe+lKpufW9rd8mxaW7dsZ
        enopz3+uuwUSP6bLpa3qDlXwuftUvbio5irz+dhDh19MFLq5vWdS9IqCtfOUyx3rfW6lH9vR
        cle0o08xWcxkzbfW3y9ZigIufNjE9tnmR0gi0zkL3oS0qbxaKhXpq3MvLO5TYinOSDTUYi4q
        TgQAdJdMe7wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnK658J9Yg083lC3uz2tltLj+5Tmr
        xfwj51gt/j96zWrR//g1s8X58xvYLc42vWG3WHH3I6vFpsfXWC0u75rDZvG59wijxacH/5kt
        Zpzfx2SxsKmF3WLtkbvsFkuvX2SyuN24gs2ide8RdgchjzXz1jB6bFrVyeaxeUm9x8Z3O5g8
        +rasYvTYfm0es8fnTXIB7FFcNimpOZllqUX6dglcGWd+z2MrWOJesaP/F2MD43brLkZODgkB
        E4nLe7uYQWwhgd2MEnP3BkLEJSWmXTwKFOcAsoUlDh8u7mLkAir5xCix8nc7K0gNm4CWxP4X
        N9hAbBGBPIlNG78ygxQxC/xnkvh+8gEjSEJYIEpi5rHjTCCDWARUJW59iQMxeQWsJC7NM4dY
        JS+xesMBsBM4Bawltjx7yA5xjpXEy/MXWCcw8i1gZFjFKJlaUJybnltsWGCUl1quV5yYW1ya
        l66XnJ+7iREc8FpaOxhPnIg/xCjAwajEw+uQ9jtWiDWxrLgy9xCjBAezkgjv7Y6fsUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYIxYlGpyTDljUeoIx
        QM18LgePt/qG4LozZlKM6hNnHnJsk18QYyzzd5GJ5rqkd7PfrWnaGTKDZfqOUvfqv1FXClzz
        PV6f4np3qjv1dESQ8Oyoj0pTOyexi57525zyinn3IfHHbfmbdRz/zD/yMu2Xim5fHl/6MXPZ
        e6ftD0zawli3MmtJX5imEktxRqKhFnNRcSIAFj5L7HQCAAA=
X-CMS-MailID: 20191220001759epcas1p1fc0e5019514f7c99606347432d66bfd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220001759epcas1p1fc0e5019514f7c99606347432d66bfd0
References: <20191220002430.11995-1-cw00.choi@samsung.com>
        <CGME20191220001759epcas1p1fc0e5019514f7c99606347432d66bfd0@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, devfreq-event core supports 'devfreq-events' property
in order to get the devfreq_event_dev device by phandle.
But, 'devfreq-events' property name is not proper on devicetree binding
because this name doesn't mean the any h/w attribute.

The devfreq-event core hands over the rights of which decide the property name
for getting the devfreq device on devicetree, to each devfreq device driver.
Each devfreq driver will decide the property name on devicetree binding
and then get the devfreq device by using devfreq_event_get_edev_by_node().

And Remove devfreq_event_get_edev_count() function used 'devfreq-events'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c         | 53 ++++---------------------
 drivers/devfreq/exynos-bus.c            | 16 +++++++-
 drivers/devfreq/rk3399_dmc.c            | 13 +++++-
 drivers/memory/samsung/exynos5422-dmc.c | 16 ++++++--
 include/linux/devfreq-event.h           | 14 ++-----
 5 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 8c31b0f2e28f..d0c989acbf93 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -210,25 +210,18 @@ int devfreq_event_reset_event(struct devfreq_event_dev *edev)
 EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
 
 /**
- * devfreq_event_get_edev_by_phandle() - Get the devfreq-event dev from
- *					 devicetree.
- * @dev		: the pointer to the given device
- * @index	: the index into list of devfreq-event device
+ * devfreq_event_get_edev_by_node() - Get the devfreq-event dev from devicetree
+ * @node	: the pointer to device_node
  *
  * Note that this function return the pointer of devfreq-event device.
  */
-struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
-						      int index)
+struct devfreq_event_dev *devfreq_event_get_edev_by_node(
+					struct device_node *node)
 {
-	struct device_node *node;
 	struct devfreq_event_dev *edev;
 
-	if (!dev->of_node)
-		return ERR_PTR(-EINVAL);
-
-	node = of_parse_phandle(dev->of_node, "devfreq-events", index);
 	if (!node)
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&devfreq_event_list_lock);
 	list_for_each_entry(edev, &devfreq_event_list, node) {
@@ -244,44 +237,12 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 out:
 	mutex_unlock(&devfreq_event_list_lock);
 
-	if (!edev) {
-		of_node_put(node);
+	if (!edev)
 		return ERR_PTR(-ENODEV);
-	}
-
-	of_node_put(node);
 
 	return edev;
 }
-EXPORT_SYMBOL_GPL(devfreq_event_get_edev_by_phandle);
-
-/**
- * devfreq_event_get_edev_count() - Get the count of devfreq-event dev
- * @dev		: the pointer to the given device
- *
- * Note that this function return the count of devfreq-event devices.
- */
-int devfreq_event_get_edev_count(struct device *dev)
-{
-	int count;
-
-	if (!dev->of_node) {
-		dev_err(dev, "device does not have a device node entry\n");
-		return -EINVAL;
-	}
-
-	count = of_property_count_elems_of_size(dev->of_node, "devfreq-events",
-						sizeof(u32));
-	if (count < 0) {
-		dev_err(dev,
-			"failed to get the count of devfreq-event in %pOF node\n",
-			dev->of_node);
-		return count;
-	}
-
-	return count;
-}
-EXPORT_SYMBOL_GPL(devfreq_event_get_edev_count);
+EXPORT_SYMBOL_GPL(devfreq_event_get_edev_by_node);
 
 static void devfreq_event_release_edev(struct device *dev)
 {
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 1bc4e3c81115..c4931ef53f15 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -96,6 +96,17 @@ static struct devfreq *exynos_bus_get_parent_devfreq(struct device_node *np)
 	return devfreq_get_devfreq_by_node(node);
 }
 
+static struct devfreq_event_dev *exynos_bus_get_edev(struct device_node *np,
+							int index)
+{
+	struct device_node *node = of_parse_phandle(np, "devfreq-events",
+							index);
+
+	if (!node)
+		return ERR_PTR(-ENODEV);
+	return devfreq_event_get_edev_by_node(node);
+}
+
 /*
  * devfreq function for both simple-ondemand and passive governor
  */
@@ -202,7 +213,8 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	 * Get the devfreq-event devices to get the current utilization of
 	 * buses. This raw data will be used in devfreq ondemand governor.
 	 */
-	count = devfreq_event_get_edev_count(dev);
+	count = of_property_count_elems_of_size(dev->of_node,
+					"devfreq-events", sizeof(u32));
 	if (count < 0) {
 		dev_err(dev, "failed to get the count of devfreq-event dev\n");
 		ret = count;
@@ -218,7 +230,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	}
 
 	for (i = 0; i < count; i++) {
-		bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
+		bus->edev[i] = exynos_bus_get_edev(dev->of_node, i);
 		if (IS_ERR(bus->edev[i])) {
 			ret = -EPROBE_DEFER;
 			goto err_regulator;
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2f1027c5b647..e712c8662d2f 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -303,6 +303,17 @@ static int of_get_ddr_timings(struct dram_timing *timing,
 	return ret;
 }
 
+static struct devfreq_event_dev *of_get_edev(struct device_node *np,
+							int index)
+{
+	struct device_node *node = of_parse_phandle(np, "devfreq-events",
+							index);
+
+	if (!node)
+		return ERR_PTR(-ENODEV);
+	return devfreq_event_get_edev_by_node(node);
+}
+
 static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res;
@@ -339,7 +350,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(data->dmc_clk);
 	}
 
-	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
+	data->edev = of_get_edev(dev->of_node, 0);
 	if (IS_ERR(data->edev))
 		return -EPROBE_DEFER;
 
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 47dbf6d1789f..f11fe29a69fc 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1267,6 +1267,16 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 	return 0;
 }
 
+static struct devfreq_event_dev *exynos5_dmc_get_edev(struct device_node *np,
+							int index)
+{
+	struct device_node *node = of_parse_phandle(np, "devfreq-events",
+							index);
+	if (!node)
+		return ERR_PTR(-ENODEV);
+	return devfreq_event_get_edev_by_node(node);
+}
+
 /**
  * exynos5_performance_counters_init() - Initializes performance DMC's counters
  * @dmc:	DMC for which it does the setup
@@ -1281,7 +1291,8 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 	int counters_size;
 	int ret, i;
 
-	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
+	dmc->num_counters = of_property_count_elems_of_size(dmc->dev->of_node,
+					"devfreq-events", sizeof(u32));
 	if (dmc->num_counters < 0) {
 		dev_err(dmc->dev, "could not get devfreq-event counters\n");
 		return dmc->num_counters;
@@ -1293,8 +1304,7 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 		return -ENOMEM;
 
 	for (i = 0; i < dmc->num_counters; i++) {
-		dmc->counter[i] =
-			devfreq_event_get_edev_by_phandle(dmc->dev, i);
+		dmc->counter[i] = exynos5_dmc_get_edev(dmc->dev->of_node, i);
 		if (IS_ERR_OR_NULL(dmc->counter[i]))
 			return -EPROBE_DEFER;
 	}
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index f14f17f8cb7f..967414ac6f7c 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -105,9 +105,8 @@ extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
 extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
 				struct devfreq_event_data *edata);
 extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
-extern struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
-				struct device *dev, int index);
-extern int devfreq_event_get_edev_count(struct device *dev);
+extern struct devfreq_event_dev *devfreq_event_get_edev_by_node(
+				struct device_node *node);
 extern struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 				struct devfreq_event_desc *desc);
 extern int devfreq_event_remove_edev(struct devfreq_event_dev *edev);
@@ -151,17 +150,12 @@ static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
 	return -EINVAL;
 }
 
-static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
-					struct device *dev, int index)
+static inline struct devfreq_event_dev *devfreq_event_get_edev_by_node(
+					struct device_node *node)
 {
 	return ERR_PTR(-EINVAL);
 }
 
-static inline int devfreq_event_get_edev_count(struct device *dev)
-{
-	return -EINVAL;
-}
-
 static inline struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 					struct devfreq_event_desc *desc)
 {
-- 
2.17.1

