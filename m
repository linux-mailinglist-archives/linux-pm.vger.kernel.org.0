Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6112129D7
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 18:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGBQi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 12:38:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55064 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGBQh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 12:37:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702163754euoutp01fb43f5e3a5e6fb2c9889a477dca85bae~d-N4gjqn71595115951euoutp01u
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 16:37:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702163754euoutp01fb43f5e3a5e6fb2c9889a477dca85bae~d-N4gjqn71595115951euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593707874;
        bh=dBlYTlntBB+W2qVnMSs4lpqwYh6MzComRDngya2e+po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixNP0TLhQHM80Cvt8wV7y35Esyiqjj8H1WTYz6yA+cFfUf09kv7p8OW2iVaMhbyxx
         ysXWKfl7U7WLUJAeRYDVxvTdE3OfqM9LBOf0/cSY5hAJOgu5l3mFLszvK2290vhBMh
         7VGTr5n9Cgw3vakdRUpVJja6im9skL9Ij3T7LCRA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702163753eucas1p2bbf849a4dcd6ff66d850ad042a1eb262~d-N4N349b2218422184eucas1p22;
        Thu,  2 Jul 2020 16:37:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C4.89.05997.16D0EFE5; Thu,  2
        Jul 2020 17:37:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702163753eucas1p16fbd5d59d05fb8e4fdcde9df839cb71e~d-N3wnYnE1855718557eucas1p12;
        Thu,  2 Jul 2020 16:37:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702163753eusmtrp1051d1457f51ff8311964e088a22cd7b2~d-N3v8Fun1333013330eusmtrp10;
        Thu,  2 Jul 2020 16:37:53 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-b3-5efe0d6183b3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.F9.06017.16D0EFE5; Thu,  2
        Jul 2020 17:37:53 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702163752eusmtip233bcd86f7e7ba751c48a902a6a5e9f86~d-N3DNPvU2919929199eusmtip2A;
        Thu,  2 Jul 2020 16:37:52 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH RFC v6 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
Date:   Thu,  2 Jul 2020 18:37:20 +0200
Message-Id: <20200702163724.2218-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702163724.2218-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87qJvP/iDM481ba4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABbFJdNSmpOZllqkb5dAlfGvp+32QsWeFd8f72CrYFxvn0XIyeHhICJxIyHsxm7GLk4
        hARWMEosmfWAGcL5wigx5doRdgjnM6PE4skv2WFaXje9ZYFILGeU2H5xCRtcy9Stp9lAqtgE
        DCV6j/YxgtgiAi4SbU/ngXUwC3QwS2zbMYkZJCEsEC2xdOlWsLEsAqoSJ4+eYwKxeQWsJObu
        XscMsU5eYvWGA0A2BwengLXE4c+8ECWCEidnPmEBsZmBSpq3zga7W0LgK7vEn0u7mSB6XSQW
        32iDOltY4tXxLVC2jMTpyT0sEA3NjBI9u2+zQzgTGCXuH1/ACFFlLXHn3C82kM3MApoS63fp
        Q4QdJf4v7QYLSwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1SoSv1dNhzpHSqL7yX8WCNtDYvGv
        dsYJjIqzkLwzC8k7sxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY2k7/O/5l
        B+OuP0mHGAU4GJV4eCcc/xsnxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYc3S/1p7re+hnsJWDoelC1NdTP5pYHues
        UN77UVFQtm/yoT1XP+n/u88e8twuN5S7XmqlnVXngpxZT3Iyd/efiRfex6P1NWPZp0csJkun
        ftlVyPT/zqL4wFN8c4M9FYNcWywMt2RdtKu7eEDxVqUDR9y+VdF8jqt2NPCvf/ZbR3d/9ETT
        k1+ZlViKMxINtZiLihMBQaqzhGkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qJvP/iDP794bW4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7Gvp+32QsWeFd8f72CrYFxvn0XIyeHhICJxOumtyxdjFwcQgJLGSWu3FzH1MXIAZSQkpjf
        ogRRIyzx51oXG0TNJ0aJdRuaGEESbAKGEr1H+8BsEQEPiVOta1lBbGaBGcwSp2eZgtjCApES
        b37tYAKxWQRUJU4ePQdm8wpYSczdvY4ZYoG8xOoNB5hB9nIKWEsc/swLEhYCKjnWv4AdolxQ
        4uTMJywgJcwC6hLr5wlBbJKXaN46m3kCo+AsJFWzEKpmIalawMi8ilEktbQ4Nz232EivODG3
        uDQvXS85P3cTIzBStx37uWUHY9e74EOMAhyMSjy8E47/jRNiTSwrrsw9xCjBwawkwut09nSc
        EG9KYmVValF+fFFpTmrxIUZToM8mMkuJJucDk0heSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQbGhXmZ8T1FZ8usA4oUZ6VOudlztPFKRdnFkLect9ndE5y6LoX+
        9V3xbPbcVVwKPnuPJTNmVHcv+3rY4k/mB32zFsEzsc1cB234TPtaFiglSb6Ne2bani70fcnj
        p8ui5YpjTRVeq5csdDw/cevrqwsOu93dKmXvdCHsWmcOS5PYM32Tky6V5ZJKLMUZiYZazEXF
        iQClnxQ56gIAAA==
X-CMS-MailID: 20200702163753eucas1p16fbd5d59d05fb8e4fdcde9df839cb71e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163753eucas1p16fbd5d59d05fb8e4fdcde9df839cb71e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163753eucas1p16fbd5d59d05fb8e4fdcde9df839cb71e
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163753eucas1p16fbd5d59d05fb8e4fdcde9df839cb71e@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
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
Changes for v6:
 - corrected of_node dereferencing in exynos_icc_get_parent()
   function,
 - corrected initialization of icc_node->name so as to avoid
   direct of_node->name dereferencing,
 - added parsing of bus-width DT property,
 - use IS_ERR_OR_NULL in exynos_icc_genberic_remove().

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
 drivers/interconnect/exynos/exynos.c | 192 +++++++++++++++++++++++++++++++++++
 5 files changed, 204 insertions(+)
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
index 4825c28..2ba1de6 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,5 +4,6 @@ CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o
 
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
index 0000000..6c47a62
--- /dev/null
+++ b/drivers/interconnect/exynos/exynos.c
@@ -0,0 +1,192 @@
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
+
+#define EXYNOS_ICC_DEFAULT_BUS_WIDTH	8
+
+struct exynos_icc_priv {
+	struct device *dev;
+
+	/* One interconnect node per provider */
+	struct icc_provider provider;
+	struct icc_node *node;
+
+	struct dev_pm_qos_request qos_req;
+	u32 bus_width;
+};
+
+static struct icc_node *exynos_icc_get_parent(struct device_node *np)
+{
+	struct of_phandle_args args;
+	struct icc_node *icc_np;
+	int num, ret;
+
+	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
+					"#interconnect-cells");
+	if (num != 1)
+		return NULL; /* parent nodes are optional */
+
+	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
+					"#interconnect-cells", 0, &args);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	icc_np = of_icc_get_from_provider(&args);
+	of_node_put(args.np);
+
+	return icc_np;
+}
+
+static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_icc_priv *src_priv = src->data, *dst_priv = dst->data;
+	s32 src_freq = max(src->avg_bw, src->peak_bw) / src_priv->bus_width;
+	s32 dst_freq = max(dst->avg_bw, dst->peak_bw) / dst_priv->bus_width;
+	int ret;
+
+	ret = dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
+	if (ret < 0) {
+		dev_err(src_priv->dev, "failed to update PM QoS of %s\n",
+			src->name);
+		return ret;
+	}
+
+	ret = dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
+	if (ret < 0) {
+		dev_err(dst_priv->dev, "failed to update PM QoS of %s\n",
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
+	if (!IS_ERR_OR_NULL(parent_node))
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
+	if (of_property_read_u32(bus_dev->of_node, "bus-width",
+				 &priv->bus_width))
+		priv->bus_width = EXYNOS_ICC_DEFAULT_BUS_WIDTH;
+
+	icc_node->data = priv;
+	icc_node_add(icc_node, provider);
+
+	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
+	if (IS_ERR(icc_parent_node)) {
+		ret = PTR_ERR(icc_parent_node);
+		goto err_node_del;
+	}
+	if (icc_parent_node) {
+		ret = icc_link_create(icc_node, icc_parent_node->id);
+		if (ret < 0)
+			goto err_node_del;
+	}
+
+	/*
+	 * Register a PM QoS request for the bus device for which also devfreq
+	 * functionality is registered.
+	 */
+	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (ret < 0)
+		goto err_link_destroy;
+
+	return 0;
+
+err_link_destroy:
+	if (icc_parent_node)
+		icc_link_destroy(icc_node, icc_parent_node);
+err_node_del:
+	icc_nodes_remove(provider);
+err_prov_del:
+	icc_provider_del(provider);
+
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

