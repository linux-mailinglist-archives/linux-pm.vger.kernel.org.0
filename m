Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859E72A05E4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJ3MxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:53:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60770 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJ3MxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 08:53:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201030125303euoutp02f28f47b5fece767ecd16839dfcd2e2ee~Cxj1FlDA20138901389euoutp02c
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 12:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201030125303euoutp02f28f47b5fece767ecd16839dfcd2e2ee~Cxj1FlDA20138901389euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604062383;
        bh=sISRntGgeJoODePIjA0nVY+OmdkNif3EW71I9zc9014=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmvIr2bgkY3h4ul1qC1SUIvylnIJvJc+Fi8U+zhAsJW/DVZ8n9VJRfBAdlqbVAVDK
         14yP7MfFcEhCxHyIp0H4x/o0Hqvz9Uln/8LDXqrPUHmK8tEkh4k6JqDVDjoUcCpl2r
         arWwIqwfa3dBv64OFZbsMbmZBiDbGzc3o4QiZ58M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201030125301eucas1p1a8332ffcc51766196730ec0ca9973281~CxjzE5k0m1801418014eucas1p1_;
        Fri, 30 Oct 2020 12:53:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E0.3F.05997.DAC0C9F5; Fri, 30
        Oct 2020 12:53:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9~Cxjylt3IJ1112311123eucas1p2T;
        Fri, 30 Oct 2020 12:53:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201030125301eusmtrp16e7b27ba0d52d92d0ae1a3dc94ed11a1~Cxjykr0p90319303193eusmtrp1q;
        Fri, 30 Oct 2020 12:53:01 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-f6-5f9c0cad1d79
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.3A.06314.CAC0C9F5; Fri, 30
        Oct 2020 12:53:01 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201030125300eusmtip2c9bfcd9af737a08ec01c63891364e13d~Cxjx6W2yN1609116091eusmtip2E;
        Fri, 30 Oct 2020 12:53:00 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        s.nawrocki@samsung.com
Subject: [PATCH v7 2/6] interconnect: Add generic interconnect driver for
 Exynos SoCs
Date:   Fri, 30 Oct 2020 13:51:45 +0100
Message-Id: <20201030125149.8227-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030125149.8227-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3uPhQn12l40EhaRVb4yqCLSmn4x/6q0CASSm95U0mnbD4y
        +kMbs5wPxIkzFRUplJloalIrrebUdKlkPhZqSzN8oBVtGmov51Xyv8855/s9DzgUJu7HPagE
        WSonl7GJEsJR2N6zNujT6FQZ7d9okjCWKhViHpc14cy4bQ5nqo2DODOy8o1gtB0tBFNsKRIy
        Q0PNJPNeX0kw1gIjYsqGOgVMo3GKZCay6wlG1WEkma6luzhTplkgQmlpiy6XkE6OvSCklrxe
        gbSwTYek1pZ95/Eox5BYLjEhnZP7nYpxjP9ap8dSOs/efDduE2ShjTA1cqCAPgEV2lpSjRwp
        MV2PoG/0DWkviGkbgqWVi3zBimD+40N8x6FU/dx21CHInhsW8MGmo2kgd0tF0AFQ0F2I7OxG
        h0POlyqhnTF6RgDKakyNKMqVvggDg6w9LaQPwQ9b95ZERAfB6KwG44d5QUPzqy12oINBnWsW
        8BoX6Ls/u93SC5RPKjD7DkDPkPDh7eK2ORwGPrdvsyss9raRPO8FkyZfyBuUCPKfT5B8UITA
        0luDeFUwTA6uE/ZNMfoINOn97Ah0GAwbvXl0BvOyC7+DMxS3azE+LYJ7OWK+x0HY0GkFPHtA
        3uxfIc9SsK5mE0Vof/mua8p3XVP+f2wNwnTInUtTJMVxiuMyLsNXwSYp0mRxvteSk1rQ5oeZ
        /vTaniL9r6sGRFNI4iQK9aqIFuNsuiIzyYCAwiRuojMDpitiUSybeYuTJ0fL0xI5hQF5UkKJ
        uyiwduGymI5jU7kbHJfCyXeqAsrBIwtlmIPG/IBYH5XZVAdu2z5FBi7NJXga9EHTPePa7rYH
        MQEhJTG+lu+P/K35NREeky9LjsHSaTasqzVyQRQFyoLrOvH4s6Yu1aV1vOq3dERTanZLnT9n
        Tkg3LdYaLkS0LpwMuDM92z+153DGyOsITXTkasNyWLir2mfdm1ybLpUIFfFswFFMrmD/AcMh
        8d1dAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7preebEG5w1srg/r5XRYuOM9awW
        1788Z7WYf+Qcq8WVr+/ZLKbv3cRmMen+BBaL8+c3sFtc3jWHzeJz7xFGixnn9zFZrD1yl93i
        duMKNovWvUfYLQ6/aWe1mDH5JZuDgMemVZ1sHneu7WHzuN99nMmjb8sqRo/Pm+QCWKP0bIry
        S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mt4t38VcsM+v
        4uL1L0wNjL8duxg5OSQETCSaW7+zdzFycQgJLGWUaPqwkqmLkQMoISUxv0UJokZY4s+1LjYQ
        W0jgE6PEmh+uIDabgKFE79E+RhBbRMBD4lTrWlaQOcwCH5gk1j7oBUsIC4RKtN9dCWazCKhK
        fPpylAXE5hWwkrj6ZDIzxAJ5idUbDoDZnALWEl2dN8BuEAKqeXugCqJcUOLkzCcsIGFmAXWJ
        9fOEQMLMQJ3NW2czT2AUnIWkahZC1SwkVQsYmVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIE
        RuW2Yz8372C8tDH4EKMAB6MSD6+D/Ox4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccX
        leakFh9iNAX6bCKzlGhyPjBh5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C
        6WPi4JRqYMxasLI2wS/LVSzo56WKp3M0QqqWNd7WsVjBvXOy5FGhUw/CXc5Fp5/3vliv+U7n
        8QXtlp0N8wLnLdxaoLjYQVo4p5m/YWaEjMEN12//g1UuxnJKKvL8+XTgj09YfO7B2pRpRw03
        Nv+tfyv4O2nhKu1fC86LHp1S07+SvTQ7/O2GuicaTyN5o5RYijMSDbWYi4oTAQ1xiYfgAgAA
X-CMS-MailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a generic interconnect driver for Exynos SoCs in order
to provide interconnect functionality for each "samsung,exynos-bus"
compatible device.

The SoC topology is a graph (or more specifically, a tree) and its
edges are specified using the 'samsung,interconnect-parent' in the
DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
propagated to ensure that the parent is probed before its children.

Each bus is now an interconnect provider and an interconnect node as
well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
registers itself as a node. Node IDs are not hardcoded but rather
assigned dynamically at runtime. This approach allows for using this
driver with various Exynos SoCs.

Frequencies requested via the interconnect API for a given node are
propagated to devfreq using dev_pm_qos_update_request(). Please note
that it is not an error when CONFIG_INTERCONNECT is 'n', in which
case all interconnect API functions are no-op.

The bus-width DT property is to determine the interconnect data
width and traslate requested bandwidth to clock frequency for each
bus.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v7:
 - adjusted to the DT property changes: "interconnects" instead
   of "samsung,interconnect-parent", "samsung,data-clk-ratio"
   instead of "bus-width",
 - adaptation to of_icc_get_from_provider() function changes
   in v5.10-rc1.

Changes for v6:
 - corrected of_node dereferencing in exynos_icc_get_parent()
   function,
 - corrected initialization of icc_node->name so as to avoid
   direct of_node->name dereferencing,
 - added parsing of bus-width DT property.

Changes for v5:
 - adjust to renamed exynos,interconnect-parent-node property,
 - use automatically generated platform device id as the interconect
   node id instead of a now unavailable devfreq->id field,
 - add icc_ prefix to some variables to make the code more self-commenting,
 - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
 - adjust to exynos,interconnect-parent-node property rename to
   samsung,interconnect-parent,
 - converted to a separate platform driver in drivers/interconnect.

---
 drivers/interconnect/Kconfig         |   1 +
 drivers/interconnect/Makefile        |   1 +
 drivers/interconnect/exynos/Kconfig  |   6 ++
 drivers/interconnect/exynos/Makefile |   4 +
 drivers/interconnect/exynos/exynos.c | 198 +++++++++++++++++++++++++++++++++++
 5 files changed, 210 insertions(+)
 create mode 100644 drivers/interconnect/exynos/Kconfig
 create mode 100644 drivers/interconnect/exynos/Makefile
 create mode 100644 drivers/interconnect/exynos/exynos.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 5b7204e..eca6eda 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -11,6 +11,7 @@ menuconfig INTERCONNECT
 
 if INTERCONNECT
 
+source "drivers/interconnect/exynos/Kconfig"
 source "drivers/interconnect/imx/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
 
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index d203520..665538d 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,5 +4,6 @@ CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o bulk.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
+obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos/
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/exynos/Kconfig
new file mode 100644
index 0000000..e51e52e
--- /dev/null
+++ b/drivers/interconnect/exynos/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_EXYNOS
+	tristate "Exynos generic interconnect driver"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Generic interconnect driver for Exynos SoCs.
diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/exynos/Makefile
new file mode 100644
index 0000000..e19d1df
--- /dev/null
+++ b/drivers/interconnect/exynos/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+exynos-interconnect-objs		:= exynos.o
+
+obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/exynos/exynos.c
new file mode 100644
index 0000000..772d1fc
--- /dev/null
+++ b/drivers/interconnect/exynos/exynos.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Exynos generic interconnect provider driver
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *
+ * Authors: Artur Świgoń <a.swigon@samsung.com>
+ *          Sylwester Nawrocki <s.nawrocki@samsung.com>
+ */
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+
+#define EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO	8
+
+struct exynos_icc_priv {
+	struct device *dev;
+
+	/* One interconnect node per provider */
+	struct icc_provider provider;
+	struct icc_node *node;
+
+	struct dev_pm_qos_request qos_req;
+	u32 bus_clk_ratio;
+};
+
+static struct icc_node *exynos_icc_get_parent(struct device_node *np)
+{
+	struct of_phandle_args args;
+	struct icc_node_data *icc_node_data;
+	struct icc_node *icc_node;
+	int num, ret;
+
+	num = of_count_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells");
+	if (num < 1)
+		return NULL; /* parent nodes are optional */
+
+	/* Get the interconnect target node */
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					"#interconnect-cells", 0, &args);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	icc_node_data = of_icc_get_from_provider(&args);
+	of_node_put(args.np);
+
+	if (IS_ERR(icc_node_data))
+		return ERR_CAST(icc_node_data);
+
+	icc_node = icc_node_data->node;
+	kfree(icc_node_data);
+
+	return icc_node;
+}
+
+static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_icc_priv *src_priv = src->data, *dst_priv = dst->data;
+	s32 src_freq = max(src->avg_bw, src->peak_bw) / src_priv->bus_clk_ratio;
+	s32 dst_freq = max(dst->avg_bw, dst->peak_bw) / dst_priv->bus_clk_ratio;
+	int ret;
+
+	ret = dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
+	if (ret < 0) {
+		dev_err(src_priv->dev, "failed to update PM QoS of %s (src)\n",
+			src->name);
+		return ret;
+	}
+
+	ret = dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
+	if (ret < 0) {
+		dev_err(dst_priv->dev, "failed to update PM QoS of %s (dst)\n",
+			dst->name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
+						 void *data)
+{
+	struct exynos_icc_priv *priv = data;
+
+	if (spec->np != priv->dev->parent->of_node)
+		return ERR_PTR(-EINVAL);
+
+	return priv->node;
+}
+
+static int exynos_generic_icc_remove(struct platform_device *pdev)
+{
+	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
+	struct icc_node *parent_node, *node = priv->node;
+
+	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
+	if (parent_node && !IS_ERR(parent_node))
+		icc_link_destroy(node, parent_node);
+
+	icc_nodes_remove(&priv->provider);
+	icc_provider_del(&priv->provider);
+
+	return 0;
+}
+
+static int exynos_generic_icc_probe(struct platform_device *pdev)
+{
+	struct device *bus_dev = pdev->dev.parent;
+	struct exynos_icc_priv *priv;
+	struct icc_provider *provider;
+	struct icc_node *icc_node, *icc_parent_node;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	provider = &priv->provider;
+
+	provider->set = exynos_generic_icc_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = exynos_generic_icc_xlate;
+	provider->dev = bus_dev;
+	provider->inter_set = true;
+	provider->data = priv;
+
+	ret = icc_provider_add(provider);
+	if (ret < 0)
+		return ret;
+
+	icc_node = icc_node_create(pdev->id);
+	if (IS_ERR(icc_node)) {
+		ret = PTR_ERR(icc_node);
+		goto err_prov_del;
+	}
+
+	priv->node = icc_node;
+	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
+					bus_dev->of_node);
+	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
+				 &priv->bus_clk_ratio))
+		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
+
+	/*
+	 * Register a PM QoS request for the parent (devfreq) device.
+	 */
+	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (ret < 0)
+		goto err_node_del;
+
+	icc_node->data = priv;
+	icc_node_add(icc_node, provider);
+
+	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
+	if (IS_ERR(icc_parent_node)) {
+		ret = PTR_ERR(icc_parent_node);
+		goto err_pmqos_del;
+	}
+	if (icc_parent_node) {
+		ret = icc_link_create(icc_node, icc_parent_node->id);
+		if (ret < 0)
+			goto err_pmqos_del;
+	}
+
+	return 0;
+
+err_pmqos_del:
+	dev_pm_qos_remove_request(&priv->qos_req);
+err_node_del:
+	icc_nodes_remove(provider);
+err_prov_del:
+	icc_provider_del(provider);
+	return ret;
+}
+
+static struct platform_driver exynos_generic_icc_driver = {
+	.driver = {
+		.name = "exynos-generic-icc",
+	},
+	.probe = exynos_generic_icc_probe,
+	.remove = exynos_generic_icc_remove,
+};
+module_platform_driver(exynos_generic_icc_driver);
+
+MODULE_DESCRIPTION("Exynos generic interconnect driver");
+MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
+MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:exynos-generic-icc");
-- 
2.7.4

