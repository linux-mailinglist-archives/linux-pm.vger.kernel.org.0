Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1FF122434
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 06:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfLQFv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 00:51:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:41307 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfLQFvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 00:51:16 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191217055110epoutp02e62ff211b0d50ed776deb06ebc64a51d~hEqsf_RGm1006510065epoutp02Q
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 05:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191217055110epoutp02e62ff211b0d50ed776deb06ebc64a51d~hEqsf_RGm1006510065epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576561870;
        bh=2bbyo/D4agyBVRk4w5VoxvwKgriIshYuWPi9ABCf4v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ln1IShqrAYDGdXeqhV77AqFsG8FmAku6o+V9Vcdko0wzKzMvl7OE9zApyOipfibsz
         /XVByDrHUJfDuHcRz7MjWdAU2NnSDU6enmltoMwdXp1pkw0fLIjDNIE7IaBZwXMM81
         oB5k2mtON+5vllZd++xIoizZzgs8uPauEcNMqLA4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191217055110epcas1p2ef0816534f5ca0a15b3cce35896ba896~hEqr7IEc31489014890epcas1p2W;
        Tue, 17 Dec 2019 05:51:10 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47cS1Q40rBzMqYl1; Tue, 17 Dec
        2019 05:51:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.C7.48498.ACC68FD5; Tue, 17 Dec 2019 14:51:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191217055106epcas1p3e77268d200006921dfa736b2c7550a04~hEqoFYsMg1353513535epcas1p31;
        Tue, 17 Dec 2019 05:51:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217055105epsmtrp216b61251e956b3ba380c839a49f2f4c0~hEqoEYw3v1947419474epsmtrp2D;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-52-5df86cca8005
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.5D.10238.9CC68FD5; Tue, 17 Dec 2019 14:51:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217055105epsmtip193897c407df2ecc9ed20520167d4b444~hEqnxE8n30093400934epsmtip1g;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     a.swigon@samsung.com, m.szyprowski@samsung.com, kgene@kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 3/9] PM / devfreq: event: Add devfreq_event_get_edev_by_node
 function
Date:   Tue, 17 Dec 2019 14:57:32 +0900
Message-Id: <20191217055738.28445-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217055738.28445-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmvu6pnB+xBlP/ylvcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOA3lBSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX
        5qXrJefnWhkaGBiZAhUmZGd8v7CQsWCHe8X75xdZGxjPWHcxcnJICJhInDtzlbWLkYtDSGAH
        o8T1CX/YIZxPjBIzWvZCZb4xSrQtmcQM07JxxRFGiMReRokXnxZAtXxhlLi8fzs7SBWbgJbE
        /hc32EBsEYE6ifmHdzCBFDEL3GSS2HPpFitIQlggXGLugyWMIDaLgKrEvm+9LCA2r4CVxJOW
        14wQ6+QlVm84ALaaU8Ba4vm212CDJAT+s0n82/2JFaLIReLcuWaoBmGJV8e3sEPYUhKf3+1l
        g7CrJVaePMIG0dzBKLFl/wWoZmOJ/UsnA03lADpPU2L9Ln2IsKLEzt9zwWYyC/BJvPvawwpS
        IiHAK9HRJgRRoixx+cFdJghbUmJxeyfUKg+JnrMN0LDrY5RYcKeVcQKj3CyEDQsYGVcxiqUW
        FOempxYbFhghR9omRnBK1TLbwbjonM8hRgEORiUe3oKy77FCrIllxZW5hxglOJiVRHh3KACF
        eFMSK6tSi/Lji0pzUosPMZoCg3Iis5Rocj4w3eeVxBuaGhkbG1uYGJqZGhoqifNy/LgYKySQ
        nliSmp2aWpBaBNPHxMEp1cA4uWU381XZq78ZH+sGdZx7+1fCZtffUHvNm+ldhYvCvfbfU/mu
        7sumt23G5RqGiTJJJZfux+om6b98M7lkLofatSfLp+wzEsjoVuGqu+JVOmnKFLW1uvP9Tj/K
        OSF/wFxsCuPrQ0wKWbM7kkM3GkxrleraM4F/zWF1vw3tDgql1YU79wk3zvyixFKckWioxVxU
        nAgARUzekr8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO7JnB+xBvvvmljcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4Mr5fWMhYsMO94v3zi6wNjGesuxg5OSQE
        TCQ2rjjCCGILCexmlPh+VQsiLikx7eJR5i5GDiBbWOLw4eIuRi6gkk+MEgv3nWQDqWET0JLY
        /+IGmC0i0MYoseS7HIjNLPCcSWJflxmILSwQKjFhfQcriM0ioCqx71svC4jNK2Al8aTlNSPE
        LnmJ1RsOMIPYnALWEs+3vWaCuMdK4ufUZ6wTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIDnktzR2Ml5fEH2IU4GBU4uGVKPkeK8SaWFZcmXuIUYKDWUmEd4cCUIg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGGV8K15b6rzDau/jF
        1fKdUp1vXp/Vu/s49wpzdN6+FYZ+86Vn+my7Oc1sX9+ZC99zOVKjvptzFHPtkpC9/vCOwzUJ
        lbdb5jwMEo1WMpZmOH8rMSxJli9SnDv14UXtI8celLWlOkolbnl7Vc8yymG3c1LEth2MaVa3
        7t9h1xFp1RTzCUxavvCYEktxRqKhFnNRcSIAo8/spHUCAAA=
X-CMS-MailID: 20191217055106epcas1p3e77268d200006921dfa736b2c7550a04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055106epcas1p3e77268d200006921dfa736b2c7550a04
References: <20191217055738.28445-1-cw00.choi@samsung.com>
        <CGME20191217055106epcas1p3e77268d200006921dfa736b2c7550a04@epcas1p3.samsung.com>
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
index 9aac2db956d5..7893c3b99e60 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -156,6 +156,17 @@ static struct devfreq *get_parent_devfreq_by_node(struct device_node *np)
 	return devfreq_get_devfreq_by_node(node);
 }
 
+static struct devfreq_event_dev *get_edev_by_node(struct device_node *np,
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
 static void exynos_bus_exit(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
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
+		bus->edev[i] = get_edev_by_node(dev->of_node, i);
 		if (IS_ERR(bus->edev[i])) {
 			ret = -EPROBE_DEFER;
 			goto err_regulator;
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2f1027c5b647..796272a208a8 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -303,6 +303,17 @@ static int of_get_ddr_timings(struct dram_timing *timing,
 	return ret;
 }
 
+static struct devfreq_event_dev *get_edev_by_node(struct device_node *np,
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
+	data->edev = get_edev_by_node(dev->of_node, 0);
 	if (IS_ERR(data->edev))
 		return -EPROBE_DEFER;
 
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 47dbf6d1789f..c3195111d646 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1267,6 +1267,16 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 	return 0;
 }
 
+static struct devfreq_event_dev *get_edev_by_node(struct device_node *np,
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
+		dmc->counter[i] = get_edev_by_node(dmc->dev->of_node, i);
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

