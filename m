Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8540E34F0A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFDRgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 13:36:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfFDRgt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 13:36:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 901AFAE03;
        Tue,  4 Jun 2019 17:36:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 2/4] clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
Date:   Tue,  4 Jun 2019 19:32:22 +0200
Message-Id: <20190604173223.4229-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604173223.4229-1-nsaenzjulienne@suse.de>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Raspberry Pi's firmware offers and interface though which update it's
clock's frequencies. This is specially useful in order to change the CPU
clock (pllb_arm) which is 'owned' by the firmware and we're unable to
scale using the register interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since RFC:
  - Moved firmware interface into own driver
  - Use of_find_compatible_node()
  - Remove error message on rpi_firmware_get() failure
  - Ratelimit messages on set_rate() failure
  - Use __le32 on firmware interface definition

 drivers/clk/bcm/Makefile          |   1 +
 drivers/clk/bcm/clk-raspberrypi.c | 316 ++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-raspberrypi.c

diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 002661d39128..07abe92df9d1 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835-aux.o
+obj-$(CONFIG_ARCH_BCM2835)	+= clk-raspberrypi.o
 obj-$(CONFIG_ARCH_BCM_53573)	+= clk-bcm53573-ilp.o
 obj-$(CONFIG_CLK_BCM_CYGNUS)	+= clk-cygnus.o
 obj-$(CONFIG_CLK_BCM_HR2)	+= clk-hr2.o
diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
new file mode 100644
index 000000000000..485c00288414
--- /dev/null
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Nicolas Saenz Julienne
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define RPI_FIRMWARE_ARM_CLK_ID		0x000000003
+
+#define RPI_FIRMWARE_STATE_ENABLE_BIT	0x1
+#define RPI_FIRMWARE_STATE_WAIT_BIT	0x2
+
+/*
+ * Even though the firmware interface alters 'pllb' the frequencies are
+ * provided as per 'pllb_arm'. We need to scale before passing them trough.
+ */
+#define RPI_FIRMWARE_PLLB_ARM_DIV_RATE	2
+
+#define A2W_PLL_FRAC_BITS		20
+
+struct raspberrypi_clk {
+	struct device *dev;
+	struct rpi_firmware *firmware;
+
+	unsigned long min_rate;
+	unsigned long max_rate;
+
+	struct clk_hw pllb;
+	struct clk_hw *pllb_arm;
+	struct clk_lookup *pllb_arm_lookup;
+};
+
+/*
+ * Structure of the message passed to Raspberry Pi's firmware in order to
+ * change clock rates. The 'disable_turbo' option is only available to the ARM
+ * clock (pllb) which we enable by default as turbo mode will alter multiple
+ * clocks at once.
+ *
+ * Even though we're able to access the clock registers directly we're bound to
+ * use the firmware interface as the firmware ultimately takes care of
+ * mitigating overheating/undervoltage situations and we would be changing
+ * frequencies behind his back.
+ *
+ * For more information on the firmware interface check:
+ * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
+ */
+struct raspberrypi_firmware_prop {
+	__le32 id;
+	__le32 val;
+	__le32 disable_turbo;
+} __packed;
+
+static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
+				      u32 clk, u32 *val)
+{
+	struct raspberrypi_firmware_prop msg = {
+		.id = clk,
+		.val = *val,
+		.disable_turbo = 1,
+	};
+	int ret;
+
+	ret = rpi_firmware_property(firmware, tag, &msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	*val = msg.val;
+
+	return 0;
+}
+
+static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u32 val = 0;
+	int ret;
+
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_GET_CLOCK_STATE,
+					 RPI_FIRMWARE_ARM_CLK_ID, &val);
+	if (ret)
+		return 0;
+
+	return !!(val & RPI_FIRMWARE_STATE_ENABLE_BIT);
+}
+
+
+static unsigned long raspberrypi_fw_pll_get_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u32 val = 0;
+	int ret;
+
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_GET_CLOCK_RATE,
+					 RPI_FIRMWARE_ARM_CLK_ID,
+					 &val);
+	if (ret)
+		return ret;
+
+	return val * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+}
+
+static int raspberrypi_fw_pll_on(struct clk_hw *hw)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u32 val;
+	int ret;
+
+	val = RPI_FIRMWARE_STATE_ENABLE_BIT | RPI_FIRMWARE_STATE_WAIT_BIT;
+
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_SET_CLOCK_STATE,
+					 RPI_FIRMWARE_ARM_CLK_ID, &val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int raspberrypi_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u32 new_rate = rate / RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	int ret;
+
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_SET_CLOCK_RATE,
+					 RPI_FIRMWARE_ARM_CLK_ID,
+					 &new_rate);
+	if (ret)
+		dev_err_ratelimited(rpi->dev, "Failed to change %s frequency: %d",
+				    clk_hw_get_name(hw), ret);
+
+	return ret;
+}
+
+/*
+ * Sadly there is no firmware rate rounding interface. We borred it from
+ * clk-bcm2835.
+ */
+static long raspberrypi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *parent_rate)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u64 div, final_rate;
+	u32 ndiv, fdiv;
+
+	rate = clamp(rate, rpi->min_rate, rpi->max_rate);
+
+	div = (u64)rate << A2W_PLL_FRAC_BITS;
+	do_div(div, *parent_rate);
+
+	ndiv = div >> A2W_PLL_FRAC_BITS;
+	fdiv = div & ((1 << A2W_PLL_FRAC_BITS) - 1);
+
+	/* We can't use rate directly as it would overflow */
+	final_rate = ((u64)*parent_rate * ((ndiv << A2W_PLL_FRAC_BITS) + fdiv));
+
+	return final_rate >> A2W_PLL_FRAC_BITS;
+}
+
+static void raspberrypi_fw_pll_off(struct clk_hw *hw)
+{
+	struct raspberrypi_clk *rpi = container_of(hw, struct raspberrypi_clk,
+						   pllb);
+	u32 val = RPI_FIRMWARE_STATE_WAIT_BIT;
+
+	raspberrypi_clock_property(rpi->firmware,
+				   RPI_FIRMWARE_SET_CLOCK_STATE,
+				   RPI_FIRMWARE_ARM_CLK_ID, &val);
+}
+
+static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
+	.is_prepared = raspberrypi_fw_pll_is_on,
+	.prepare = raspberrypi_fw_pll_on,
+	.unprepare = raspberrypi_fw_pll_off,
+	.recalc_rate = raspberrypi_fw_pll_get_rate,
+	.set_rate = raspberrypi_fw_pll_set_rate,
+	.round_rate = raspberrypi_pll_round_rate,
+};
+
+static int raspberrypi_register_pllb(struct raspberrypi_clk *rpi)
+{
+	u32 min_rate = 0, max_rate = 0;
+	struct clk_init_data init;
+	int ret;
+
+	/* Get min & max rates set by the firmware */
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
+					 RPI_FIRMWARE_ARM_CLK_ID,
+					 &min_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get %s min freq: %d\n",
+			init.name, ret);
+		return ret;
+	}
+
+	ret = raspberrypi_clock_property(rpi->firmware,
+					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
+					 RPI_FIRMWARE_ARM_CLK_ID,
+					 &max_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get %s max freq: %d\n",
+			init.name, ret);
+		return ret;
+	}
+
+	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
+		 min_rate, max_rate);
+
+	rpi->min_rate = min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+	rpi->max_rate = max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
+
+	memset(&init, 0, sizeof(init));
+
+	/* All of the PLLs derive from the external oscillator. */
+	init.parent_names = (const char *[]){ "osc" };
+	init.num_parents = 1;
+	init.name = "pllb";
+	init.ops = &raspberrypi_firmware_pll_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED;
+
+	rpi->pllb.init = &init;
+
+	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
+}
+
+static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
+{
+	rpi->pllb_arm = clk_hw_register_fixed_factor(rpi->dev,
+				"pllb_arm", "pllb",
+				CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+				1, 2);
+	if (IS_ERR(rpi->pllb_arm)) {
+		dev_err(rpi->dev, "Failed to initialize pllb_arm\n");
+		return PTR_ERR(rpi->pllb_arm);
+	}
+
+	rpi->pllb_arm_lookup = clkdev_hw_create(rpi->pllb_arm, NULL, "cpu0");
+	if (!rpi->pllb_arm_lookup) {
+		dev_err(rpi->dev, "Failed to initialize pllb_arm_lookup\n");
+		clk_hw_unregister_fixed_factor(rpi->pllb_arm);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int raspberrypi_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *firmware_node;
+	struct device *dev = &pdev->dev;
+	struct rpi_firmware *firmware;
+	struct raspberrypi_clk *rpi;
+	int ret;
+
+	firmware_node = of_find_compatible_node(NULL, NULL,
+					"raspberrypi,bcm2835-firmware");
+	if (!firmware_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	firmware = rpi_firmware_get(firmware_node);
+	of_node_put(firmware_node);
+	if (!firmware)
+		return -EPROBE_DEFER;
+
+	rpi = devm_kzalloc(dev, sizeof(*rpi), GFP_KERNEL);
+	if (!rpi)
+		return -ENOMEM;
+
+	rpi->dev = dev;
+	rpi->firmware = firmware;
+
+	ret = raspberrypi_register_pllb(rpi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize pllb, %d\n", ret);
+		return ret;
+	}
+
+	ret = raspberrypi_register_pllb_arm(rpi);
+	if (ret) {
+		dev_err(dev, "Failed to initialize pllb_arm, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver raspberrypi_clk_driver = {
+	.driver = {
+		.name = "raspberrypi-clk",
+	},
+	.probe          = raspberrypi_clk_probe,
+};
+builtin_platform_driver(raspberrypi_clk_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Raspberry Pi firmware clock driver");
+MODULE_LICENSE("GPLv2");
-- 
2.21.0

