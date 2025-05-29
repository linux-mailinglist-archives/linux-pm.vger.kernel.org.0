Return-Path: <linux-pm+bounces-27823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A583AC8438
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8B616B93A
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67F230BFF;
	Thu, 29 May 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B+3UP7tZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA921D011
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557457; cv=none; b=kx5uKubvfuML+4J4HZhhhazgfKZIhjeHh5984oVmfWe5v8RBFcAIjfUduePcBt4JHH9CU06TxhTxib3hV2utJM4HSpAPS9nFNWqSKrhBIs3050jE2ZKs63G5BOp3KqhFc4PK69Viv6jkM/EwfZX+IDIn/KpHjqVP3loiKVORVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557457; c=relaxed/simple;
	bh=XYPnSniSl5TQ1Kilk0vMYbPbVUZoTWkdcRno4GekXmw=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Dzw5IBqbxFoLZwv1RDh2a6CC+9aw72SHdqXyR3qNT10diOupK00M25OCHUfcqEBAeGeqrZeCRWG6WCnAXSrxccIRCosBW/0qxowc0zTARNW9eXlSj0zOWbpXwMivoXvHZCrUqiK3EhU4qUPxRMYsezgrPzo2fn29N1arQIkYJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B+3UP7tZ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222406euoutp01d2aeb11f171f880fb851a9c95026c4db~EH7u2A-Iq2316423164euoutp01w
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250529222406euoutp01d2aeb11f171f880fb851a9c95026c4db~EH7u2A-Iq2316423164euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557446;
	bh=UObq1t0kD6KfUVwCQSJxpDszWtGDpqoeR5CqwEksnG0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=B+3UP7tZxIyAyROXbo/GXzWdx73wYbI+jMPYPNrJYNb4XZ6gy7Hzk0Y1IUW/F1j5G
	 LnxUoJiiYCxDWuE9Ur6+TAipeJoV+M+gItouO7dPd6o41kpWospJE2XjNf54LQY3K/
	 GdiRoN+J1Nc0iE0WkUE/SlisoCSKYDDJzJFyNovk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222404eucas1p2856b44ad410171edfc2190127dafee0c~EH7tVu98u0077600776eucas1p27;
	Thu, 29 May 2025 22:24:04 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222403eusmtip20eae166d9772e97e6f93490f4880dff2~EH7sasbSi2867928679eusmtip2T;
	Thu, 29 May 2025 22:24:03 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 30 May 2025 00:23:49 +0200
Subject: [PATCH v3 2/8] power: sequencing: Add T-HEAD TH1520 GPU power
 sequencer driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-apr_14_for_sending-v3-2-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
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
X-CMS-MailID: 20250529222404eucas1p2856b44ad410171edfc2190127dafee0c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222404eucas1p2856b44ad410171edfc2190127dafee0c
X-EPHeader: CA
X-CMS-RootMailID: 20250529222404eucas1p2856b44ad410171edfc2190127dafee0c
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222404eucas1p2856b44ad410171edfc2190127dafee0c@eucas1p2.samsung.com>

Introduce the pwrseq-thead-gpu driver, a power sequencer provider for
the Imagination BXM-4-64 GPU on the T-HEAD TH1520 SoC.

The TH1520 GPU requires a specific sequence to correctly initialize and
power down its resources:
 - Enable GPU clocks (core and sys).
 - De-assert the GPU clock generator reset (clkgen_reset).
 - Introduce a short hardware-required delay.
 - De-assert the GPU core reset. The power-down sequence performs these
   steps in reverse.

Implement this sequence via the pwrseq_power_on and pwrseq_power_off
callbacks. It binds to the "thead,th1520-gpu-pwrseq" device tree node,
from which it acquires the clkgen_reset.

Crucially, the driver's match function is called when a consumer
(the Imagination GPU driver) requests the "gpu-power" target. During
this match, the sequencer uses devm_clk_bulk_get() and
devm_reset_control_get_exclusive() on the consumer's device to
obtain handles to the GPU's "core" and "sys" clocks, and the GPU core
reset. These, along with its own clkgen_reset, allow it to perform
the complete sequence.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                                 |   1 +
 drivers/power/sequencing/Kconfig            |   8 ++
 drivers/power/sequencing/Makefile           |   1 +
 drivers/power/sequencing/pwrseq-thead-gpu.c | 183 ++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78e3067df1152929de638244b03264733d08556e..237b37a3f6296a72323657419789dc6fdad1b5d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21364,6 +21364,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/power/sequencing/pwrseq-thead-gpu.c
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ddcc42a984921c55667c46ac586d259625e1f1a7..935428ce8cf44794b7eb943f722ace5021237af2 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -27,4 +27,12 @@ config POWER_SEQUENCING_QCOM_WCN
 	  this driver is needed for correct power control or else we'd risk not
 	  respecting the required delays between enabling Bluetooth and WLAN.
 
+config POWER_SEQUENCING_THEAD_GPU
+	tristate "T-HEAD TH1520 GPU power sequencing driver"
+	depends on ARCH_THEAD
+	help
+	  Say Y here to enable the power sequencing driver for the TH1520 SoC
+	  GPU. This driver handles the complex clock and reset sequence
+	  required to power on the Imagination BXM GPU on this platform.
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 2eec2df7912d11827f9ba914177dd2c882e44bce..647f81f4013ab825630f069d2e0f6d22159f1f56 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
+obj-$(CONFIG_POWER_SEQUENCING_THEAD_GPU) += pwrseq-thead-gpu.o
diff --git a/drivers/power/sequencing/pwrseq-thead-gpu.c b/drivers/power/sequencing/pwrseq-thead-gpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..e4c15c3d62eee0c088710c4d134ac2c4b16e2b06
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-thead-gpu.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD TH1520 GPU Power Sequencer Driver
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * This driver implements the power sequence for the Imagination BXM GPU
+ * on the T-HEAD TH1520 SoC. The sequence requires coordinating resources
+ * from both the sequencer's device node (clkgen_reset) and the GPU's
+ * device node (clocks and core reset).
+ *
+ * The `match` function is used to acquire the GPU's resources when the
+ * GPU driver requests the "gpu-power" sequence target.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/reset.h>
+
+struct pwrseq_thead_gpu_ctx {
+	struct pwrseq_device *pwrseq;
+	struct reset_control *clkgen_reset;
+
+	/* Consumer resources */
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *gpu_reset;
+};
+
+static int pwrseq_thead_gpu_power_on(struct pwrseq_device *pwrseq)
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
+static int pwrseq_thead_gpu_power_off(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (!ctx->clks || !ctx->gpu_reset)
+		return -ENODEV;
+
+	reset_control_assert(ctx->gpu_reset);
+	reset_control_assert(ctx->clkgen_reset);
+	clk_bulk_disable_unprepare(ctx->num_clks, ctx->clks);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_thead_gpu_unit = {
+	.name = "gpu-power-sequence",
+	.enable = pwrseq_thead_gpu_power_on,
+	.disable = pwrseq_thead_gpu_power_off,
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
+static int pwrseq_thead_gpu_match(struct pwrseq_device *pwrseq, struct device *dev)
+{
+	struct pwrseq_thead_gpu_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	static const char *const clk_names[] = { "core", "sys" };
+	int i, ret;
+
+	/* We only match the specific T-HEAD TH1520 GPU compatible */
+	if (!of_device_is_compatible(dev->of_node, "thead,th1520-gpu"))
+		return 0;
+
+	/* Prevent multiple consumers from attaching */
+	if (ctx->gpu_reset || ctx->clks)
+		return -EBUSY;
+
+	ctx->num_clks = ARRAY_SIZE(clk_names);
+	ctx->clks = devm_kcalloc(dev, ctx->num_clks, sizeof(*ctx->clks), GFP_KERNEL);
+	if (!ctx->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < ctx->num_clks; i++)
+		ctx->clks[i].id = clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, ctx->num_clks, ctx->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get GPU clocks\n");
+
+	ctx->gpu_reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(ctx->gpu_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->gpu_reset), "Failed to get GPU reset\n");
+
+	return 1;
+}
+
+static int pwrseq_thead_gpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_thead_gpu_ctx *ctx;
+	struct pwrseq_config config = {};
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->clkgen_reset = devm_reset_control_get_exclusive(dev, "gpu-clkgen");
+	if (IS_ERR(ctx->clkgen_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->clkgen_reset),
+				     "Failed to get GPU clkgen reset\n");
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
+	return 0;
+}
+
+static const struct of_device_id pwrseq_thead_gpu_of_match[] = {
+	{ .compatible = "thead,th1520-gpu-pwrseq" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_thead_gpu_of_match);
+
+static struct platform_driver pwrseq_thead_gpu_driver = {
+	.driver = {
+		.name = "pwrseq-thead-gpu",
+		.of_match_table = pwrseq_thead_gpu_of_match,
+	},
+	.probe = pwrseq_thead_gpu_probe,
+};
+module_platform_driver(pwrseq_thead_gpu_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("T-HEAD TH1520 GPU power sequencer driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


