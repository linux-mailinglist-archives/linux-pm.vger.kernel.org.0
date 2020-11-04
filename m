Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849212A61E0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgKDKhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:37:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47598 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgKDKhd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:37:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104103721euoutp01fd21b216be313f30be4624da7ea81492~ER7xeDe9o0672206722euoutp01t
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:37:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104103721euoutp01fd21b216be313f30be4624da7ea81492~ER7xeDe9o0672206722euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604486241;
        bh=GkqmnWRueLbCNn+fnyxHBWnGznUabFDMe8Pbo74DYlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slnqbfiJL0D5OtjrMBTIBWQaHvmSX6rTO/Q3vMSjQDZvs0tpPqKwK/DPvndfO+MLt
         WjfK0WZzriFSxcgpy9lXBW+Vz5NyQdeFATb+zXyhCLRjEB4PUf/rupR4DSdiwvFh4k
         DoTj0kvoT5hLp1ggDqhQh+JaH0CF42G29rsPwldI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104103721eucas1p1a6e6799b72cea8b605b9994040cc43fe~ER7xJBzml3079730797eucas1p1t;
        Wed,  4 Nov 2020 10:37:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E9.8F.05997.16482AF5; Wed,  4
        Nov 2020 10:37:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201104103720eucas1p1014217e751a681796ed508af22c6bb12~ER7wsMqqw1564115641eucas1p1s;
        Wed,  4 Nov 2020 10:37:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104103720eusmtrp1386e554c3c709f85f943fc973465fe86~ER7wrfWxM0575105751eusmtrp1Q;
        Wed,  4 Nov 2020 10:37:20 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-76-5fa28461b829
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.75.06314.06482AF5; Wed,  4
        Nov 2020 10:37:20 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104103720eusmtip21023e65e4a625a929256fb7f525f18cf~ER7wAajNI1401714017eusmtip2G;
        Wed,  4 Nov 2020 10:37:20 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v8 2/7] interconnect: Add generic interconnect driver for
 Exynos SoCs
Date:   Wed,  4 Nov 2020 11:36:52 +0100
Message-Id: <20201104103657.18007-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104103657.18007-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjl3XfZp7n6XIYPswsNJYzSrKiXtJtIrFIyfxRFpZ/5pZZabZrZ
        jzLULupCLNjyngTaIlyrplia6Mx05LJiFioSabXKxDZH6+72Lerfec5zDuc8Ly9DSK2UjEnP
        yuaVWVyGnPYljY9cluVcYX3iir4Xfni0pgjh29omCg863lG41tRP4RfTkzTWtBloXD5aRmKL
        RS/GhjdWCj9vraKxXW1CWGtpF+FbphExHjrbSOOiNpMYd306T2HtZRu9yV9h0F2kFcPWB7Ri
        tKRHpLhz/Yzi0l0dUtgNC+Ppvb5RKXxG+gleGb4hyTdtonCcPPZ650mj00rko+GYYuTDALsa
        bNOFdDHyZaRsI4LPWptIGBwIbrQ99A52BHbrpOivpfdKFSEsGhCYS97/s7x9+MijotkIUHdf
        Qm4cwMbAufEa0i0i2AsEGFvKCfdiLrsb9I6BmXSGIdkQuGef46YlbCR8sTxGQtoiuKnv8Mh9
        2CgYsBeIBY0/9F4dI92YmNEU3Kv0NALWJQZ95TgpmGOgsaufEvBc+NBzVyzg+WC+XEoKhgIE
        pfeHxMJQhmC0p84bHQnD/d887Qg2FJpawwV6M3x/9ZRw08DOhpcT/kKJ2VBu1HhpCVw4JxXU
        wfBdp/G+nAxKxn57qylgTKcVlaHFFf+dU/HfORX/cusQoUOBfI4qM5VXrczic8NUXKYqJys1
        7ODRTAOa+W3mXz2OFtT6I7kTsQyS+0k6jNcSpRR3QpWX2YmAIeQBkugn5gNSSQqXd4pXHk1U
        5mTwqk4UxJDyQMmqett+KZvKZfNHeP4Yr/y7FTE+snyUULEvtJoI2vMsQj3lbO6KdZb6h8Ws
        27U76fRaZ37slo1xLYPqj7MOGX5z6u3q9o8uWUgQtXdK09cSP39Nqf117TJpfbLLcabaluDi
        47pdSx5Pf27f+jPA/ANta5gXLdKErcltOlzZn7EgWDai/Rp8pzmhOOp4+o6U6CHqysj6I0Vy
        UpXGRSwllCruD1EGprppAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7oJLYviDQ6e1LG4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7G25anLAUPAyu2fbvG3MB4x6WLkZNDQsBE4uSUOcxdjFwcQgJLGSW+n9vM1MXIAZSQkpjf
        ogRRIyzx51oXG4gtJPCJUeLeLk8Qm03AUKL3aB8jiC0i4CFxqnUtK4jNLDCDWeL0LFMQW1gg
        VOLGqsVsICNZBFQltn7mBwnzClhLfDp/ghFivLzE6g0HmEFsTgEbiYufm9khVllLLH5+jgmi
        XlDi5MwnLCBjmAXUJdbPE4LYJC/RvHU28wRGwVlIqmYhVM1CUrWAkXkVo0hqaXFuem6xoV5x
        Ym5xaV66XnJ+7iZGYJxuO/Zz8w7GSxuDDzEKcDAq8fAe2LYwXog1say4MvcQowQHs5IIr9PZ
        03FCvCmJlVWpRfnxRaU5qcWHGE2BPpvILCWanA9MIXkl8YamhuYWlobmxubGZhZK4rwdAgdj
        hATSE0tSs1NTC1KLYPqYODilGhizNpVXzBfTcaj5fSb6imm5vwN3cZz5W9YHH4L5Jmkv5DLI
        ulJ4jscv2HOb1KQOEd9J/X83eLaEz99xsd16acUtnvgA48ipsx6viFfNjtpsvSfP98Ob9Ej+
        7yefmNzZ/IJ1yvwpEd/O5u2qnD4lco09x4e0T823Tj791xvYa35rxYrlU3KvFtorsRRnJBpq
        MRcVJwIAb4JxA+kCAAA=
X-CMS-MailID: 20201104103720eucas1p1014217e751a681796ed508af22c6bb12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103720eucas1p1014217e751a681796ed508af22c6bb12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103720eucas1p1014217e751a681796ed508af22c6bb12
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103720eucas1p1014217e751a681796ed508af22c6bb12@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a generic interconnect driver for Exynos SoCs in order
to provide interconnect functionality for each "samsung,exynos-bus"
compatible device.

The SoC topology is a graph (or more specifically, a tree) and its
edges are described by specifying in the 'interconnects' property
the interconnect consumer path for each interconnect provider DT node.

Each bus is now an interconnect provider and an interconnect node as
well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
registers itself as a node. Node IDs are not hard coded but rather
assigned dynamically at runtime. This approach allows for using this
driver with various Exynos SoCs.

Frequencies requested via the interconnect API for a given node are
propagated to devfreq using dev_pm_qos_update_request(). Please note
that it is not an error when CONFIG_INTERCONNECT is 'n', in which
case all interconnect API functions are no-op.

The samsung,data-clk-ratio DT property is used to specify the ratio
of the interconect bandwidth to the minimum data clock frequency
for each bus.

Due to unspecified relative probing order, -EPROBE_DEFER may be
propagated to ensure that the parent is probed before its children.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v8:
 - renamed drivers/interconnect/exynos to drivers/interconnect/samsung,
 - added missing driver sync_state callback assignment.

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
 drivers/interconnect/Kconfig          |   1 +
 drivers/interconnect/Makefile         |   1 +
 drivers/interconnect/samsung/Kconfig  |  13 +++
 drivers/interconnect/samsung/Makefile |   4 +
 drivers/interconnect/samsung/exynos.c | 199 ++++++++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 drivers/interconnect/samsung/Kconfig
 create mode 100644 drivers/interconnect/samsung/Makefile
 create mode 100644 drivers/interconnect/samsung/exynos.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 5b7204e..d637a89 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -13,5 +13,6 @@ if INTERCONNECT
 
 source "drivers/interconnect/imx/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/samsung/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index d203520..c2f9e9d 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
\ No newline at end of file
diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
new file mode 100644
index 0000000..508ed64
--- /dev/null
+++ b/drivers/interconnect/samsung/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_SAMSUNG
+	bool "Samsung interconnect drivers"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Interconnect drivers for Samsung SoCs.
+
+
+config INTERCONNECT_EXYNOS
+	tristate "Exynos generic interconnect driver"
+	depends on INTERCONNECT_SAMSUNG
+	help
+	  Generic interconnect driver for Exynos SoCs.
diff --git a/drivers/interconnect/samsung/Makefile b/drivers/interconnect/samsung/Makefile
new file mode 100644
index 0000000..e19d1df
--- /dev/null
+++ b/drivers/interconnect/samsung/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+exynos-interconnect-objs		:= exynos.o
+
+obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
new file mode 100644
index 0000000..6559d8c
--- /dev/null
+++ b/drivers/interconnect/samsung/exynos.c
@@ -0,0 +1,199 @@
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
+		.sync_state = icc_sync_state,
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

