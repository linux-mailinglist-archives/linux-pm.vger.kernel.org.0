Return-Path: <linux-pm+bounces-29277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59803AE3E4C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B6F7A3427
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF32459D2;
	Mon, 23 Jun 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VgHprvwv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4A244678
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679075; cv=none; b=dO925sw7HZgVii4l10jeAropr8O7aDdBBjq8X1poLzNyrUPw5ntaCdL7a9Ih7lvXY42odG196XP/Md14mk3mlV6HrDrO3Z3PJLZEnx1futeTzetW5y9nUQcqrc4oJVbrMMrQG5HBZ8PQcZ2u7Y9UhIeex3gim1w0cGZ/Tn5XCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679075; c=relaxed/simple;
	bh=pVNLhqNDvIhCiYJPkL2G2BS6yViAr7qWLnWYCbwdFlk=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Vaf1NZ59HVKAduBwoiGgSQnNs5TPfZ/ygzsZ3mL24uci8fZEKRxSF7zfmbBXgxQZuSKMgKKEfDQ8K7sDWkCq64YDRa4sh2DUTF4/E14gqrIvFhJIU3K9l7mk9fzA6bWFeqhAXVY107Q9wp10sOUomM3/+p174sDgCqBjsSQZZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VgHprvwv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250623114431euoutp02a80a3947a351575aa82d73c3f4a56982~LqVbwDQPn1537015370euoutp02G
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 11:44:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250623114431euoutp02a80a3947a351575aa82d73c3f4a56982~LqVbwDQPn1537015370euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750679071;
	bh=CHY7JtLCmM9WXe/qJzMYeRnA6r8urLtqusF0buZM0dc=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=VgHprvwvUDhSQBMgHxstXpxErqV9cOO5dlMK0PfyVUdfwH2khz1CYuvqU6ahEogEg
	 OmrihZJJ5IQcITC0hrQPbQkB1a0TN36Wa4gajXhlBeUeUQhbXvOg8X+u976q55OtjH
	 QCH53cFweum60UP0as/ZFW5oLK2qoZcB9LP9wmkw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2~LqVbMzqXV1758917589eucas1p27;
	Mon, 23 Jun 2025 11:44:30 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623114429eusmtip16bdb8d6c8ca58da83b3797f79dc5402d~LqVaIJBsY1396413964eusmtip1G;
	Mon, 23 Jun 2025 11:44:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 13:42:39 +0200
Subject: [PATCH v6 1/8] power: sequencing: Add T-HEAD TH1520 GPU power
 sequencer driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-apr_14_for_sending-v6-1-6583ce0f6c25@samsung.com>
In-Reply-To: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2
X-EPHeader: CA
X-CMS-RootMailID: 20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2
References: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
	<CGME20250623114430eucas1p2a5bb2bbc0049186ff25e1b3e1a131ca2@eucas1p2.samsung.com>

Introduce the pwrseq-thead-gpu driver, a power sequencer provider for
the Imagination BXM-4-64 GPU on the T-HEAD TH1520 SoC. This driver
controls an auxiliary device instantiated by the AON power domain.

The TH1520 GPU requires a specific sequence to correctly initialize and
power down its resources:
 - Enable GPU clocks (core and sys).
 - De-assert the GPU clock generator reset (clkgen_reset).
 - Introduce a short hardware-required delay.
 - De-assert the GPU core reset. The power-down sequence performs these
   steps in reverse.

Implement this sequence via the pwrseq_power_on and pwrseq_power_off
callbacks.

Crucially, the driver's match function is called when a consumer (the
Imagination GPU driver) requests the "gpu-power" target. During this
match, the sequencer uses clk_bulk_get() and
reset_control_get_exclusive() on the consumer's device to obtain handles
to the GPU's "core" and "sys" clocks, and the GPU core reset.  These,
along with clkgen_reset obtained from parent aon node, allow it to
perform the complete sequence.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                 |   1 +
 drivers/power/sequencing/Kconfig            |   8 +
 drivers/power/sequencing/Makefile           |   1 +
 drivers/power/sequencing/pwrseq-thead-gpu.c | 247 ++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0183c028fa18c397d30ec82fd419894f1f50a448..3283ff592215249bcf702dbb4ab710477243477e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21395,6 +21395,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/power/sequencing/pwrseq-thead-gpu.c
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ddcc42a984921c55667c46ac586d259625e1f1a7..0f118d57c1ceddc03954c006f99b5990acf546d4 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -27,4 +27,12 @@ config POWER_SEQUENCING_QCOM_WCN
 	  this driver is needed for correct power control or else we'd risk not
 	  respecting the required delays between enabling Bluetooth and WLAN.
 
+config POWER_SEQUENCING_TH1520_GPU
+	tristate "T-HEAD TH1520 GPU power sequencing driver"
+	depends on ARCH_THEAD && AUXILIARY_BUS
+	help
+	  Say Y here to enable the power sequencing driver for the TH1520 SoC
+	  GPU. This driver handles the complex clock and reset sequence
+	  required to power on the Imagination BXM GPU on this platform.
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 2eec2df7912d11827f9ba914177dd2c882e44bce..96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
+obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
diff --git a/drivers/power/sequencing/pwrseq-thead-gpu.c b/drivers/power/sequencing/pwrseq-thead-gpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..f267f95b5d0468b21eba15e633ef39fce2cc503f
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-thead-gpu.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD TH1520 GPU Power Sequencer Driver
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * This driver implements the power sequence for the Imagination BXM-4-64
+ * GPU on the T-HEAD TH1520 SoC. The sequence requires coordinating resources
+ * from both the sequencer's parent device node (clkgen_reset) and the GPU's
+ * device node (clocks and core reset).
+ *
+ * The `match` function is used to acquire the GPU's resources when the
+ * GPU driver requests the "gpu-power" sequence target.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/reset.h>
+
+#include <dt-bindings/power/thead,th1520-power.h>
+
+struct pwrseq_thead_gpu_ctx {
+	struct pwrseq_device *pwrseq;
+	struct reset_control *clkgen_reset;
+	struct device_node *aon_node;
+
+	/* Consumer resources */
+	struct device_node *consumer_node;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *gpu_reset;
+};
+
+static int pwrseq_thead_gpu_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	if (!ctx->clks || !ctx->gpu_reset)
+		return -ENODEV;
+
+	ret = clk_bulk_prepare_enable(ctx->num_clks, ctx->clks);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(ctx->clkgen_reset);
+	if (ret)
+		goto err_disable_clks;
+
+	/*
+	 * According to the hardware manual, a delay of at least 32 clock
+	 * cycles is required between de-asserting the clkgen reset and
+	 * de-asserting the GPU reset. Assuming a worst-case scenario with
+	 * a very high GPU clock frequency, a delay of 1 microsecond is
+	 * sufficient to ensure this requirement is met across all
+	 * feasible GPU clock speeds.
+	 */
+	udelay(1);
+
+	ret = reset_control_deassert(ctx->gpu_reset);
+	if (ret)
+		goto err_assert_clkgen;
+
+	return 0;
+
+err_assert_clkgen:
+	reset_control_assert(ctx->clkgen_reset);
+err_disable_clks:
+	clk_bulk_disable_unprepare(ctx->num_clks, ctx->clks);
+	return ret;
+}
+
+static int pwrseq_thead_gpu_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret = 0, err;
+
+	if (!ctx->clks || !ctx->gpu_reset)
+		return -ENODEV;
+
+	err = reset_control_assert(ctx->gpu_reset);
+	if (err)
+		ret = err;
+
+	err = reset_control_assert(ctx->clkgen_reset);
+	if (err && !ret)
+		ret = err;
+
+	clk_bulk_disable_unprepare(ctx->num_clks, ctx->clks);
+
+	/* ret stores values of the first error code */
+	return ret;
+}
+
+static const struct pwrseq_unit_data pwrseq_thead_gpu_unit = {
+	.name = "gpu-power-sequence",
+	.enable = pwrseq_thead_gpu_enable,
+	.disable = pwrseq_thead_gpu_disable,
+};
+
+static const struct pwrseq_target_data pwrseq_thead_gpu_target = {
+	.name = "gpu-power",
+	.unit = &pwrseq_thead_gpu_unit,
+};
+
+static const struct pwrseq_target_data *pwrseq_thead_gpu_targets[] = {
+	&pwrseq_thead_gpu_target,
+	NULL
+};
+
+static int pwrseq_thead_gpu_match(struct pwrseq_device *pwrseq,
+				  struct device *dev)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	static const char *const clk_names[] = { "core", "sys" };
+	struct of_phandle_args pwr_spec;
+	int i, ret;
+
+	/* We only match the specific T-HEAD TH1520 GPU compatible */
+	if (!of_device_is_compatible(dev->of_node, "thead,th1520-gpu"))
+		return 0;
+
+	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
+					 "#power-domain-cells", 0, &pwr_spec);
+	if (ret)
+		return 0;
+
+	/* Additionally verify consumer device has AON as power-domain */
+	if (pwr_spec.np != ctx->aon_node || pwr_spec.args[0] != TH1520_GPU_PD) {
+		of_node_put(pwr_spec.np);
+		return 0;
+	}
+
+	of_node_put(pwr_spec.np);
+
+	/* If a consumer is already bound, only allow a re-match from it */
+	if (ctx->consumer_node)
+		return ctx->consumer_node == dev->of_node;
+
+	ctx->num_clks = ARRAY_SIZE(clk_names);
+	ctx->clks = kcalloc(ctx->num_clks, sizeof(*ctx->clks), GFP_KERNEL);
+	if (!ctx->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < ctx->num_clks; i++)
+		ctx->clks[i].id = clk_names[i];
+
+	ret = clk_bulk_get(dev, ctx->num_clks, ctx->clks);
+	if (ret)
+		goto err_free_clks;
+
+	ctx->gpu_reset = reset_control_get_shared(dev, NULL);
+	if (IS_ERR(ctx->gpu_reset)) {
+		ret = PTR_ERR(ctx->gpu_reset);
+		goto err_put_clks;
+	}
+
+	ctx->consumer_node = of_node_get(dev->of_node);
+
+	return 1;
+
+err_put_clks:
+	clk_bulk_put(ctx->num_clks, ctx->clks);
+err_free_clks:
+	kfree(ctx->clks);
+	ctx->clks = NULL;
+
+	return ret;
+}
+
+static int pwrseq_thead_gpu_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct device *parent_dev = dev->parent;
+	struct pwrseq_thead_gpu_ctx *ctx;
+	struct pwrseq_config config = {};
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->aon_node = parent_dev->of_node;
+
+	ctx->clkgen_reset =
+		devm_reset_control_get_exclusive(parent_dev, "gpu-clkgen");
+	if (IS_ERR(ctx->clkgen_reset))
+		return dev_err_probe(
+			dev, PTR_ERR(ctx->clkgen_reset),
+			"Failed to get GPU clkgen reset from parent\n");
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_thead_gpu_match;
+	config.targets = pwrseq_thead_gpu_targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register power sequencer\n");
+
+	auxiliary_set_drvdata(adev, ctx);
+
+	return 0;
+}
+
+static void pwrseq_thead_gpu_remove(struct auxiliary_device *adev)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = auxiliary_get_drvdata(adev);
+
+	if (ctx->gpu_reset)
+		reset_control_put(ctx->gpu_reset);
+
+	if (ctx->clks) {
+		clk_bulk_put(ctx->num_clks, ctx->clks);
+		kfree(ctx->clks);
+	}
+
+	if (ctx->consumer_node)
+		of_node_put(ctx->consumer_node);
+}
+
+static const struct auxiliary_device_id pwrseq_thead_gpu_id_table[] = {
+	{ .name = "th1520_pm_domains.pwrseq-gpu" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pwrseq_thead_gpu_id_table);
+
+static struct auxiliary_driver pwrseq_thead_gpu_driver = {
+	.driver = {
+		.name = "pwrseq-thead-gpu",
+	},
+	.probe = pwrseq_thead_gpu_probe,
+	.remove = pwrseq_thead_gpu_remove,
+	.id_table = pwrseq_thead_gpu_id_table,
+};
+module_auxiliary_driver(pwrseq_thead_gpu_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 GPU power sequencer driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


