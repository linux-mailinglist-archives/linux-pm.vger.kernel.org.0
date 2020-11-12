Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F22B075B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 15:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgKLOLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 09:11:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54998 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgKLOLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 09:11:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112141104euoutp0143382f4fce3ab18dd6b2758791e2d791~GyApyfZ6I1532515325euoutp01O
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 14:11:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112141104euoutp0143382f4fce3ab18dd6b2758791e2d791~GyApyfZ6I1532515325euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605190264;
        bh=8FAfU6BCkgvgjJdMmzUzX4KRpyPprgS4czs4hFuFKFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kR+AKuBRvjAA2OjtddsqMbOQ6XNWQwAYPjsrvJEO4tbZzw/bsOPFnliRG7puh8Bxs
         li5DTh2LHb8UfcacXzUuyse5XF2rtp6+JoVATaH5ay5vyqhh/qArDCod6fGYmtpnZp
         3X4pMIFJYdQeGSZNGn5ZmJX21EWNYG9UZnvpHZu8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112141050eucas1p1d1e59396140fd85dd242a396a05c7601~GyAdJRPjk2413224132eucas1p1s;
        Thu, 12 Nov 2020 14:10:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.B9.44805.A624DAF5; Thu, 12
        Nov 2020 14:10:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201112141050eucas1p250f62d09adf38b97c521ef67b4b540f0~GyAcf3gsG0207802078eucas1p2u;
        Thu, 12 Nov 2020 14:10:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201112141050eusmtrp2d0b31be7d84f9c38df7f625982557052~GyAceJ01R1054310543eusmtrp2X;
        Thu, 12 Nov 2020 14:10:50 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-60-5fad426a7beb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.0F.16282.9624DAF5; Thu, 12
        Nov 2020 14:10:49 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201112141049eusmtip2a60c36a4c3acd15056f7ea83e788a079~GyAbtIaiE3001030010eusmtip28;
        Thu, 12 Nov 2020 14:10:49 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v9 2/5] interconnect: Add generic interconnect driver for
 Exynos SoCs
Date:   Thu, 12 Nov 2020 15:09:28 +0100
Message-Id: <20201112140931.31139-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112140931.31139-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87pZTmvjDQ5M1LG4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFm07j3CbnH4TTurxYzJL9kcBD02repk87hzbQ+bx/3u40wem5fUe/RtWcXo
        8XmTXABbFJdNSmpOZllqkb5dAlfGqqWNTAXbgivmH77M2sA4w62LkZNDQsBE4vGcpSxdjFwc
        QgIrGCVe/L/FCuF8YZT4uOgtE0iVkMBnRok/27xhOqavbGeHKFrOKHHh/m8WuI7WrxcZQarY
        BAwleo/2AdkcHCICnhInG/RBapgFmpklGpo3gdUIC4RLPD4+hw3EZhFQlTj2ZhU7iM0rYC3R
        tP4wG8Q2eYnVGw4wg9icAjYSc5+2skHUCEqcnPmEBcRmBqpp3jqbGWSBhMB8Tonue9dZIJpd
        JGZ9WgU1SFji1fEt7BC2jMT/nfOZIBqaGSV6dt9mh3AmMErcP76AEaLKWuLOuV9sIC8wC2hK
        rN+lDxF2lJhx4AwTSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWkfi9ajoThC0l0f3kP9Rp
        HhJLP7xnnsCoOAvJO7OQvDMLYe8CRuZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgYnt
        9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFeZYc18UK8KYmVValF+fFFpTmpxYcYpTlYlMR5k7YA
        pQTSE0tSs1NTC1KLYLJMHJxSDUxu3aHNy3jcze979nhf6ZCtYFT3uptdFbub29rO6OTsV0uy
        jFxra6265X44vVbLUTPfau2Y7pl0KDR5ncMbJv1LFxK/bronYVih3tWze8cpvfkNHTnmKh37
        esLnn21Mu6D31lzzjPQE6w1zXWVz9K+dZz7vUx4z62Gq7ZSDPyJ/TzkXp3zD2CMjqF7m+6rj
        +04s/Naq9sOlIK3XTXfvgQ9v3xx6V/2tWyY59+dr3uenXznrfJM8wvNxT93OCB3Tf3buM7sP
        nX3XumXPiYnp2w53d0pK76/oWugdpjpbWPflrF8lxq+dJcO7F+k5NE948vD68zIZPhMWnSjd
        v3stTytWrnyTraKgtc1fzrUrUYmlOCPRUIu5qDgRAMNmdCXbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7pZTmvjDTodLO7Pa2W02DhjPavF
        9S/PWS3mHznHanHl63s2i+l7N7FZTLo/gcXi/PkN7BabHl9jtbi8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFq17j7BbHH7TzmoxY/JLNgdBj02rOtk87lzbw+Zxv/s4k8fmJfUefVtWMXp8
        3iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l7FqaSNTwbbgivmHL7M2MM5w62Lk5JAQMJGYvrKdvYuRi0NIYCmjxMELu9i6GDmAElIS81uU
        IGqEJf5c62KDqPnEKDFp8XEWkASbgKFE79E+RhBbRMBXYvXJSSwgRcwCk5klHt1uYQNJCAuE
        Sty9+40dxGYRUJU49mYVmM0rYC3RtP4wG8QGeYnVGw4wg9icAjYSc5+2gsWFgGr2d7cxQdQL
        Spyc+YQF5DhmAXWJ9fOEQMLMQK3NW2czT2AUnIWkahZC1SwkVQsYmVcxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIExuq2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzKDmvihXhTEiurUovy44tK
        c1KLDzGaAn0zkVlKNDkfmCzySuINzQxMDU3MLA1MLc2MlcR5TY4ANQmkJ5akZqemFqQWwfQx
        cXBKNTDFZL4pvmlZv0LF/3HAvNWbLjzdY37i8vXdBQW7+XoD18y9udfEfNXul28ObOLZPUPy
        XvCCCpE4facDLuVTd+/wFVBf/W7tb5a5sbE+9347CmrLp235fFRG6/bO1qjOG8HWrL76rziO
        inV/iZS+cmr2WcvbywLPpfEW7jslep57uzG75/rmS6t/FOl7rtu/d/HZY5ZcBs6v7R4qpfyY
        ZTH/ts+UgCUVar4hJ85NCn0S7HElL8c+vuLltBy7ZWavPKfeiPe8so3116OZ88T7TKZ3S1dF
        hi0R3sbxwPDqEhul4qkfgndbPO5bzSWwbu/vLZ3ZnfX1GTW3kwM5wkLFLid7zL+rxzhRoPxm
        9nKpFJt0JZbijERDLeai4kQAd6HGqF4DAAA=
X-CMS-MailID: 20201112141050eucas1p250f62d09adf38b97c521ef67b4b540f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112141050eucas1p250f62d09adf38b97c521ef67b4b540f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112141050eucas1p250f62d09adf38b97c521ef67b4b540f0
References: <20201112140931.31139-1-s.nawrocki@samsung.com>
        <CGME20201112141050eucas1p250f62d09adf38b97c521ef67b4b540f0@eucas1p2.samsung.com>
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v9:
 - Makefile and Kconfig fixes/improvements.

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
index d203520..97d393f 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
new file mode 100644
index 0000000..6820e4f
--- /dev/null
+++ b/drivers/interconnect/samsung/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_SAMSUNG
+	bool "Samsung SoC interconnect drivers"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Interconnect drivers for Samsung SoCs.
+
+config INTERCONNECT_EXYNOS
+	tristate "Exynos generic interconnect driver"
+	depends on INTERCONNECT_SAMSUNG
+	default y if ARCH_EXYNOS
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

