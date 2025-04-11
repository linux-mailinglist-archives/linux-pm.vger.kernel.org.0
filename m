Return-Path: <linux-pm+bounces-25251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A08A85CF1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AE21BA748B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332A2BD5BC;
	Fri, 11 Apr 2025 12:18:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B652BD5B3
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373908; cv=none; b=iUDghfhsgpH7vGoxqyHWxiWYS7LZ6skYosjNasPFFXEe8gDIX5EZ+GN5CI7GsimgvL3efLzowAQwX6OBdt+VhpdYcjGO4OSxyBCINgj13m6GM/dI9v+9YeQdagWtJOaLh6vX001xE+5rrYajLyJ2Va17PF21m+An1hOHTdbADZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373908; c=relaxed/simple;
	bh=NUyfHXKDD6v3aWEOOVgewfAqWd9qq3kYppr+Q23ReSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVXMMIHfsP+R6lM17GuqY2liAxzHOdyOW66IsZl1IUwg7AdTIK/DjFSnCfNAlJZwYUisYd2+4AYmUuuXPcpdyDhewG4PSQW+odawe/0bg2IP+wabk0xFzdCvHoOclOCsnJri/M1Ds6Ezfp8xlOuQHbV+H5eIDqq6tH8+YOmRt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKZ-0006JX-Fu; Fri, 11 Apr 2025 14:17:59 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-004Qka-22;
	Fri, 11 Apr 2025 14:17:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u3DKY-002PCC-1g;
	Fri, 11 Apr 2025 14:17:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH v8 6/7] power: reset: add PSCR NVMEM Driver for Recording Power State Change Reasons
Date: Fri, 11 Apr 2025 14:17:56 +0200
Message-Id: <20250411121757.573419-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411121757.573419-1-o.rempel@pengutronix.de>
References: <20250411121757.573419-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

This driver utilizes the Power State Change Reasons Recording (PSCRR)
framework to store specific power state change information, such as
shutdown or reboot reasons, into a designated non-volatile memory
(NVMEM) cell.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- rename pscr_reason to psc_reason
changes v5:
- avoid a build against NVMEM=m
changes v4:
- remove devicetree dependencies
---
 drivers/power/reset/Kconfig       |  22 +++
 drivers/power/reset/Makefile      |   1 +
 drivers/power/reset/pscrr-nvmem.c | 254 ++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/power/reset/pscrr-nvmem.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 7e4c4f317938..33ccdecd6442 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -341,3 +341,25 @@ menuconfig PSCRR
 	  be recorded unless hardware provides the reset cause.
 
 	  If unsure, say N.
+
+if PSCRR
+
+config PSCRR_NVMEM
+	tristate "Generic NVMEM-based Power State Change Reason Recorder"
+	depends on NVMEM || !NVMEM
+	help
+	  This option enables support for storing power state change reasons
+	  (such as shutdown, reboot, or power failure events) into a designated
+	  NVMEM (Non-Volatile Memory) cell.
+
+	  This feature allows embedded systems to retain power transition
+	  history even after a full system restart or power loss. It is useful
+	  for post-mortem debugging, automated recovery strategies, and
+	  improving system reliability.
+
+	  The NVMEM cell used for storing these reasons can be dynamically
+	  configured via module parameters.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index dbd6ae6b26a4..532698552d40 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_PSCRR) += pscrr.o
+obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscrr-nvmem.c b/drivers/power/reset/pscrr-nvmem.c
new file mode 100644
index 000000000000..7d02d989893f
--- /dev/null
+++ b/drivers/power/reset/pscrr-nvmem.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr_nvmem.c - PSCRR backend for storing shutdown reasons in small NVMEM
+ *		   cells
+ *
+ * This backend provides a way to persist power state change reasons in a
+ * non-volatile memory (NVMEM) cell, ensuring that reboot causes can be
+ * analyzed post-mortem. Unlike traditional logging to eMMC or NAND, which
+ * may be unreliable during power failures, this approach allows storing
+ * reboot reasons in small, fast-access storage like RTC scratchpads, EEPROM,
+ * or FRAM.
+ *
+ * The module allows dynamic configuration of the NVMEM device and cell
+ * via module parameters:
+ *
+ * Example usage:
+ *   modprobe pscrr-nvmem nvmem_name=pcf85063_nvram0 cell_name=pscr@0,0
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/pscrr.h>
+#include <linux/slab.h>
+
+/*
+ * Module parameters:
+ *   nvmem_name: Name of the NVMEM device (e.g. "pcf85063_nvram0").
+ *   cell_name : Sysfs name of the cell on that device (e.g. "pscr@0,0").
+ */
+static char *nvmem_name;
+module_param(nvmem_name, charp, 0444);
+MODULE_PARM_DESC(nvmem_name, "Name of the NVMEM device (e.g. pcf85063_nvram0)");
+
+static char *cell_name;
+module_param(cell_name, charp, 0444);
+MODULE_PARM_DESC(cell_name, "Sysfs name of the NVMEM cell (e.g. pscr@0,0)");
+
+struct pscrr_nvmem_priv {
+	struct nvmem_device *nvmem;
+	struct nvmem_cell *cell;
+
+	size_t total_bits;
+	size_t max_val;
+};
+
+static struct pscrr_nvmem_priv *priv;
+
+static int pscrr_nvmem_write_reason(enum psc_reason reason)
+{
+	size_t required_bytes;
+	u32 val;
+	int ret;
+
+	if (!priv || !priv->cell)
+		return -ENODEV;
+
+	/* Ensure reason fits in the available storage */
+	if (reason > priv->max_val) {
+		pr_err("PSCRR-nvmem: Reason %d exceeds max storable value %zu for %zu-bit cell\n",
+		       reason, priv->max_val, priv->total_bits);
+		return -ERANGE;
+	}
+
+	val = reason;
+
+	/* Determine required bytes for storing total_bits */
+	required_bytes = (priv->total_bits + 7) / 8;
+
+	/* Write the reason to the NVMEM cell */
+	ret = nvmem_cell_write(priv->cell, &val, required_bytes);
+	if (ret < 0) {
+		pr_err("PSCRR-nvmem: Failed to write reason %d, err=%d (%pe)\n",
+		       reason, ret, ERR_PTR(ret));
+		return ret;
+	}
+
+	pr_debug("PSCRR-nvmem: Successfully wrote reason %d\n", reason);
+
+	return 0;
+}
+
+static int pscrr_nvmem_read_reason(enum psc_reason *reason)
+{
+	size_t required_bytes, len;
+	unsigned int val;
+	int ret = 0;
+	void *buf;
+
+	if (!priv || !priv->cell)
+		return -ENODEV;
+
+	buf = nvmem_cell_read(priv->cell, &len);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		pr_err("PSCRR-nvmem: Failed to read cell, err=%d (%pe)\n", ret,
+		       ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Calculate the required number of bytes */
+	required_bytes = (priv->total_bits + 7) / 8;
+
+	/* Validate that the returned length is large enough */
+	if (len < required_bytes) {
+		pr_err("PSCRR-nvmem: Read length %zu is too small (need at least %zu bytes)\n",
+		       len, required_bytes);
+		kfree(buf);
+		return -EIO;
+	}
+
+	/* Extract value safely with proper memory alignment handling */
+	val = 0;
+	memcpy(&val, buf, required_bytes);
+
+	/* Mask only the necessary bits to avoid garbage data */
+	val &= (1U << priv->total_bits) - 1;
+
+	kfree(buf);
+
+	*reason = (enum psc_reason)val;
+
+	pr_debug("PSCRR-nvmem: Read reason => %d (from %zu bytes, %zu bits used)\n",
+		 *reason, len, priv->total_bits);
+
+	return 0;
+}
+
+static const struct pscrr_backend_ops pscrr_nvmem_ops = {
+	.write_reason = pscrr_nvmem_write_reason,
+	.read_reason  = pscrr_nvmem_read_reason,
+};
+
+static int __init pscrr_nvmem_init(void)
+{
+	size_t bytes, bits;
+	int ret;
+
+	if (!nvmem_name || !cell_name) {
+		pr_err("PSCRR-nvmem: Must specify both nvmem_name and cell_name.\n");
+		return -EINVAL;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->nvmem = nvmem_device_get_by_name(nvmem_name);
+	if (IS_ERR(priv->nvmem)) {
+		ret = PTR_ERR(priv->nvmem);
+		pr_err("PSCRR-nvmem: nvmem_device_get_by_name(%s) failed: %d\n",
+		       nvmem_name, ret);
+		priv->nvmem = NULL;
+		goto err_free;
+	}
+
+	priv->cell = nvmem_cell_get_by_sysfs_name(priv->nvmem, cell_name);
+	if (IS_ERR(priv->cell)) {
+		ret = PTR_ERR(priv->cell);
+		pr_err("PSCRR-nvmem: nvmem_cell_get_by_sysfs_name(%s) failed, err=%pe\n",
+		       cell_name, ERR_PTR(ret));
+		priv->cell = NULL;
+		goto err_dev_put;
+	}
+
+	ret = nvmem_cell_get_size(priv->cell, &bytes, &bits);
+	if (ret < 0) {
+		pr_err("PSCRR-nvmem: Failed to get cell size, err=%pe\n",
+		       ERR_PTR(ret));
+		goto err_cell_put;
+	}
+
+	if (bits)
+		priv->total_bits = bits;
+	else
+		priv->total_bits = bytes * 8;
+
+	if (priv->total_bits > 31) {
+		pr_err("PSCRR-nvmem: total_bits=%zu is too large (max 31 allowed)\n",
+		       priv->total_bits);
+		return -EOVERFLOW;
+	}
+
+	priv->max_val = (1 << priv->total_bits) - 1;
+	pr_debug("PSCRR-nvmem: Cell size: %zu bytes + %zu bits => total_bits=%zu\n",
+		 bytes, bits, priv->total_bits);
+
+	/*
+	 * If we store reasons 0..PSCR_MAX_REASON, the largest needed is
+	 * 'PSCR_MAX_REASON'. That must fit within total_bits.
+	 * So the max storable integer is (1 << total_bits) - 1.
+	 */
+	if (priv->max_val < PSCR_MAX_REASON) {
+		pr_err("PSCRR-nvmem: Not enough bits (%zu) to store up to reason=%d\n",
+		       priv->total_bits, PSCR_MAX_REASON);
+		ret = -ENOSPC;
+		goto err_cell_put;
+	}
+
+	/* 4. Register with pscrr_core. */
+	ret = pscrr_core_init(&pscrr_nvmem_ops);
+	if (ret) {
+		pr_err("PSCRR-nvmem: pscrr_core_init() failed: %d\n", ret);
+		goto err_cell_put;
+	}
+
+	pr_info("PSCRR-nvmem: Loaded (nvmem=%s, cell=%s), can store 0..%zu\n",
+		nvmem_name, cell_name, priv->max_val);
+	return 0;
+
+err_cell_put:
+	if (priv->cell) {
+		nvmem_cell_put(priv->cell);
+		priv->cell = NULL;
+	}
+err_dev_put:
+	if (priv->nvmem) {
+		nvmem_device_put(priv->nvmem);
+		priv->nvmem = NULL;
+	}
+err_free:
+	kfree(priv);
+	priv = NULL;
+	return ret;
+}
+
+static void __exit pscrr_nvmem_exit(void)
+{
+	pscrr_core_exit();
+
+	if (priv) {
+		if (priv->cell) {
+			nvmem_cell_put(priv->cell);
+			priv->cell = NULL;
+		}
+		if (priv->nvmem) {
+			nvmem_device_put(priv->nvmem);
+			priv->nvmem = NULL;
+		}
+		kfree(priv);
+		priv = NULL;
+	}
+
+	pr_info("pscrr-nvmem: Unloaded\n");
+}
+
+module_init(pscrr_nvmem_init);
+module_exit(pscrr_nvmem_exit);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("PSCRR backend for storing reason code in NVMEM");
+MODULE_LICENSE("GPL");
-- 
2.39.5


