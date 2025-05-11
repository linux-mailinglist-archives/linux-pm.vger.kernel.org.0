Return-Path: <linux-pm+bounces-27001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDBAB2742
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462EA189A21D
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714001D88D0;
	Sun, 11 May 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MysOPQG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF921B6D01;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951550; cv=none; b=sRSdA8Q25qGJ2t4R30DPwsFbrX6e2aDMKxmyjZyyQdyhLotkItQyNwf6rd4pMEZyZpMz+IYRxl9P/ZNKrs1YTcxkQkq1muSBJMxRnV9D6Uezx0/JyCfokNVq8EPERpl2MjiDt2nNoCnnQMlmD5XY8+2UB7Gf6XWW0SDFlIFnfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951550; c=relaxed/simple;
	bh=Pde8b0AHikflNsdX/nIk2C1vyv9Q8zDNVunpttOhc0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTpsW9MjYkdqIILbm+MZ2gSUfzpskLbm+cgjaU/0hxmNr93j4p8lrYM7Q5s3mSeIWhyReOjBYKAoorI8qBG+qFDO9wgZPDaSOKNMp4DvobJInDJofdjKuOkKgHxPtHtAEJJYfSMam70t3jvdc8AtHWmviRURqYkv6eb2L8f3Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MysOPQG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E31EC4CEF7;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746951549;
	bh=Pde8b0AHikflNsdX/nIk2C1vyv9Q8zDNVunpttOhc0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MysOPQG47y7BFAMD0z2pUn9g60qNS1FSjaFpjQ5dJ8u1pW5o6Yd945vYVVvfflQBx
	 41LBycX8oDYjMi9A94WSuttAxhIC/NXZpvm+1u3/vJkCjarb1mhNvVqxLLJNvfftvV
	 dgOcE8SFgcMxEjur6bgPZLCYin/gIG6eSK6wW4e17Hue3GdnfoRH6e+hdxUMD9saAP
	 ftLbCt3H88+2AGVQpXgviiXdRwH3v1UrM2R3M7W/gYdTlqp6Pt7unpYSXc6MGsxn3V
	 3CxGiczcFqB0uuqbON/t4NmytWObQzPM8A0TY6lc0WuiONz/nq2Uu284U1GfKwtGyU
	 k+YZImD+bFyzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4FC3ABCB;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 11 May 2025 08:18:40 +0000
Subject: [PATCH v5 05/10] mfd: Add Apple Silicon System Management
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250511-smc-6-15-v5-5-f5980bdb18bd@svenpeter.dev>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
In-Reply-To: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27912;
 i=sven@svenpeter.dev; h=from:subject:message-id;
 bh=dTEd4oo/BC4qEM5L//1eCmXZNRKJ8I8+5BBIyUDrxCg=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZCbOm9g1VRktYPrm5ZLe0S5G6c/VpQM/PGBenbjYLmN
 bkzH3h1lLIwiHEwyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACZyYALDX4kj2rIu1Yfzda8v
 /5pUllH7Iu3ckQnzInYod3WfeZNifZiRYc8B2eJZ1dLp2tsORHG8yjopbPx81Vv7ux4Rlh/vn93
 lxAkA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

The System Management Controller (SMC) on Apple Silicon machines is a
piece of hardware that exposes various functionalities such as
temperature sensors, voltage/power meters, shutdown/reboot handling,
GPIOs and more.

Communication happens via a shared mailbox using the RTKit protocol
which is also used for other co-processors. The SMC protocol then allows
reading and writing many different keys which implement the various
features. The MFD core device handles this protocol and exposes it
to the sub-devices.

Some of the sub-devices are potentially also useful on pre-M1 Apple
machines and support for SMCs on these machines can be added at a later
time.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                |   2 +
 drivers/mfd/Kconfig        |  15 ++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/macsmc.c       | 506 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/macsmc.h | 277 +++++++++++++++++++++++++
 5 files changed, 801 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27caedc40262ee9b9fdb6478f7624422517375a7..dfaca531600c22d487fb17a25294686611dd4513 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2298,6 +2298,7 @@ F:	drivers/input/touchscreen/apple_z2.c
 F:	drivers/iommu/apple-dart.c
 F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
+F:	drivers/mfd/macsmc.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
@@ -2308,6 +2309,7 @@ F:	drivers/video/backlight/apple_dwi_bl.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
+F:	include/linux/mfd/macsmc.h
 F:	include/linux/soc/apple/*
 
 ARM/ARTPEC MACHINE SUPPORT
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b93631003943c393d9fe704748bc23f1905397..da56fc4f05b7b7e0a521fcd97bee087424ec4d5b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -285,6 +285,21 @@ config MFD_CS42L43_SDW
 	  Select this to support the Cirrus Logic CS42L43 PC CODEC with
 	  headphone and class D speaker drivers over SoundWire.
 
+config MFD_MACSMC
+	tristate "Apple Silicon System Management Controller (SMC)"
+	select MFD_CORE
+	help
+	  The System Management Controller (SMC) on Apple Silicon machines is a
+	  piece of hardware that exposes various functionalities such as
+	  temperature sensors, voltage/power meters, shutdown/reboot handling,
+	  GPIOs and more.
+
+	  Communication happens via a shared mailbox using the RTKit protocol
+	  which is also used for other co-processors. The SMC protocol then
+	  allows reading and writing many different keys which implement the
+	  various features. The MFD core device handles this protocol and
+	  exposes it to the sub-devices.
+
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42a18b22a826f0b17fb8d5796a7ec8ba6..e9e2403d961a631d9d63a274e0e4f6457ae9e0f2 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MFD_CS42L43_SDW)	+= cs42l43-sdw.o
 obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
+obj-$(CONFIG_MFD_MACSMC)	+= macsmc.o
 
 obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
new file mode 100644
index 0000000000000000000000000000000000000000..908c0cc3d0b19a170d558f6c662998d5e3d7374c
--- /dev/null
+++ b/drivers/mfd/macsmc.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SMC (System Management Controller) MFD driver
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/math.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/soc/apple/rtkit.h>
+#include <linux/unaligned.h>
+
+#define SMC_ENDPOINT			0x20
+
+/* We don't actually know the true size here but this seem reasonable */
+#define SMC_SHMEM_SIZE			0x1000
+#define SMC_MAX_SIZE			255
+
+#define SMC_MSG_READ_KEY		0x10
+#define SMC_MSG_WRITE_KEY		0x11
+#define SMC_MSG_GET_KEY_BY_INDEX	0x12
+#define SMC_MSG_GET_KEY_INFO		0x13
+#define SMC_MSG_INITIALIZE		0x17
+#define SMC_MSG_NOTIFICATION		0x18
+#define SMC_MSG_RW_KEY			0x20
+
+#define SMC_DATA			GENMASK_ULL(63, 32)
+#define SMC_WSIZE			GENMASK_ULL(31, 24)
+#define SMC_SIZE			GENMASK_ULL(23, 16)
+#define SMC_ID				GENMASK_ULL(15, 12)
+#define SMC_MSG				GENMASK_ULL(7, 0)
+#define SMC_RESULT			SMC_MSG
+
+#define SMC_TIMEOUT_MS		500
+
+static const struct mfd_cell apple_smc_devs[] = {
+	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
+	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
+};
+
+static int apple_smc_cmd_locked(struct apple_smc *smc, u64 cmd, u64 arg,
+				  u64 size, u64 wsize, u32 *ret_data)
+{
+	u8 result;
+	int ret;
+	u64 msg;
+
+	lockdep_assert_held(&smc->mutex);
+
+	if (smc->boot_stage != APPLE_SMC_INITIALIZED)
+		return -EIO;
+	if (smc->atomic_mode)
+		return -EIO;
+
+	reinit_completion(&smc->cmd_done);
+
+	smc->msg_id = (smc->msg_id + 1) & 0xf;
+	msg = (FIELD_PREP(SMC_MSG, cmd) |
+	       FIELD_PREP(SMC_SIZE, size) |
+	       FIELD_PREP(SMC_WSIZE, wsize) |
+	       FIELD_PREP(SMC_ID, smc->msg_id) |
+	       FIELD_PREP(SMC_DATA, arg));
+
+	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, false);
+	if (ret) {
+		dev_err(smc->dev, "Failed to send command\n");
+		return ret;
+	}
+
+	if (wait_for_completion_timeout(&smc->cmd_done, msecs_to_jiffies(SMC_TIMEOUT_MS)) <= 0) {
+		dev_err(smc->dev, "Command timed out (%llx)", msg);
+		return -ETIMEDOUT;
+	}
+
+	if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
+		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
+			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
+		return -EIO;
+	}
+
+	result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
+	if (result)
+		return -EIO;
+
+	if (ret_data)
+		*ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
+
+	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
+}
+
+static int apple_smc_cmd(struct apple_smc *smc, u64 cmd, u64 arg,
+			 u64 size, u64 wsize, u32 *ret_data)
+{
+	guard(mutex)(&smc->mutex);
+
+	return apple_smc_cmd_locked(smc, cmd, arg, size, wsize, ret_data);
+}
+
+static int apple_smc_rw_locked(struct apple_smc *smc, smc_key key,
+				const void *wbuf, size_t wsize,
+				void *rbuf, size_t rsize)
+{
+	u64 smc_size, smc_wsize;
+	u32 rdata;
+	int ret;
+	u64 cmd;
+
+	lockdep_assert_held(&smc->mutex);
+
+	if (rsize > SMC_MAX_SIZE)
+		return -EINVAL;
+	if (wsize > SMC_MAX_SIZE)
+		return -EINVAL;
+
+	if (rsize && wsize) {
+		cmd = SMC_MSG_RW_KEY;
+		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
+		smc_size = rsize;
+		smc_wsize = wsize;
+	} else if (wsize && !rsize) {
+		cmd = SMC_MSG_WRITE_KEY;
+		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
+		/*
+		 * Setting size to the length we want to write and wsize to 0
+		 * looks silly but that's how the SMC protocol works ¯\_(ツ)_/¯
+		 */
+		smc_size = wsize;
+		smc_wsize = 0;
+	} else if (!wsize && rsize) {
+		cmd = SMC_MSG_READ_KEY;
+		smc_size = rsize;
+		smc_wsize = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = apple_smc_cmd_locked(smc, cmd, key, smc_size, smc_wsize, &rdata);
+	if (ret < 0)
+		return ret;
+
+	if (rsize) {
+		/*
+		 * Small data <= 4 bytes is returned as part of the reply
+		 * message which is sent over the mailbox FIFO. Everything
+		 * bigger has to be copied from SRAM which is mapped as
+		 * Device memory.
+		 */
+		if (rsize <= 4)
+			memcpy(rbuf, &rdata, rsize);
+		else
+			memcpy_fromio(rbuf, smc->shmem.iomem, rsize);
+	}
+
+	return ret;
+}
+
+int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size)
+{
+	guard(mutex)(&smc->mutex);
+
+	return apple_smc_rw_locked(smc, key, NULL, 0, buf, size);
+}
+EXPORT_SYMBOL(apple_smc_read);
+
+int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size)
+{
+	guard(mutex)(&smc->mutex);
+
+	return apple_smc_rw_locked(smc, key, buf, size, NULL, 0);
+}
+EXPORT_SYMBOL(apple_smc_write);
+
+int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
+		 void *rbuf, size_t rsize)
+{
+	guard(mutex)(&smc->mutex);
+
+	return apple_smc_rw_locked(smc, key, wbuf, wsize, rbuf, rsize);
+}
+EXPORT_SYMBOL(apple_smc_rw);
+
+int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc_key *key)
+{
+	int ret;
+
+	ret = apple_smc_cmd(smc, SMC_MSG_GET_KEY_BY_INDEX, index, 0, 0, key);
+
+	*key = swab32(*key);
+	return ret;
+}
+EXPORT_SYMBOL(apple_smc_get_key_by_index);
+
+int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struct apple_smc_key_info *info)
+{
+	u8 key_info[6];
+	int ret;
+
+	ret = apple_smc_cmd(smc, SMC_MSG_GET_KEY_INFO, key, 0, 0, NULL);
+	if (ret >= 0 && info) {
+		memcpy_fromio(key_info, smc->shmem.iomem, sizeof(key_info));
+		info->size = key_info[0];
+		info->type_code = get_unaligned_be32(&key_info[1]);
+		info->flags = key_info[5];
+	}
+	return ret;
+}
+EXPORT_SYMBOL(apple_smc_get_key_info);
+
+int apple_smc_enter_atomic(struct apple_smc *smc)
+{
+	guard(mutex)(&smc->mutex);
+
+	/*
+	 * Disable notifications since this is called before shutdown and no
+	 * notification handler will be able to handle the notification
+	 * using atomic operations only. Also ignore any failure here
+	 * because we're about to shut down or reboot anyway.
+	 * We can't use apple_smc_write_flag here since that would try to lock
+	 * smc->mutex again.
+	 */
+	const u8 flag = 0;
+
+	apple_smc_rw_locked(smc, SMC_KEY(NTAP), &flag, sizeof(flag), NULL, 0);
+
+	smc->atomic_mode = true;
+
+	return 0;
+}
+EXPORT_SYMBOL(apple_smc_enter_atomic);
+
+int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size)
+{
+	guard(spinlock_irqsave)(&smc->lock);
+	u8 result;
+	int ret;
+	u64 msg;
+
+	if (size > SMC_MAX_SIZE || size == 0)
+		return -EINVAL;
+
+	if (smc->boot_stage != APPLE_SMC_INITIALIZED)
+		return -EIO;
+	if (!smc->atomic_mode)
+		return -EIO;
+
+	memcpy_toio(smc->shmem.iomem, buf, size);
+	smc->msg_id = (smc->msg_id + 1) & 0xf;
+	msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
+	       FIELD_PREP(SMC_SIZE, size) |
+	       FIELD_PREP(SMC_ID, smc->msg_id) |
+	       FIELD_PREP(SMC_DATA, key));
+	smc->atomic_pending = true;
+
+	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, true);
+	if (ret < 0) {
+		dev_err(smc->dev, "Failed to send command (%d)\n", ret);
+		return ret;
+	}
+
+	while (smc->atomic_pending) {
+		ret = apple_rtkit_poll(smc->rtk);
+		if (ret < 0) {
+			dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
+			return ret;
+		}
+		udelay(100);
+	}
+
+	if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
+		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
+			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
+		return -EIO;
+	}
+
+	result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
+	if (result)
+		return -EIO;
+
+	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
+}
+EXPORT_SYMBOL(apple_smc_write_atomic);
+
+static void apple_smc_rtkit_crashed(void *cookie, const void *bfr, size_t bfr_len)
+{
+	struct apple_smc *smc = cookie;
+
+	smc->boot_stage = APPLE_SMC_ERROR_CRASHED;
+	dev_err(smc->dev, "SMC crashed! Your system will reboot in a few seconds...\n");
+}
+
+static int apple_smc_rtkit_shmem_setup(void *cookie, struct apple_rtkit_shmem *bfr)
+{
+	struct apple_smc *smc = cookie;
+	size_t bfr_end;
+
+	if (!bfr->iova) {
+		dev_err(smc->dev, "RTKit wants a RAM buffer\n");
+		return -EIO;
+	}
+
+	if (check_add_overflow(bfr->iova, bfr->size - 1, &bfr_end))
+		return -EFAULT;
+
+	if (bfr->iova < smc->sram->start || bfr->iova > smc->sram->end ||
+	    bfr_end > smc->sram->end) {
+		dev_err(smc->dev, "RTKit buffer request outside SRAM region: [0x%llx, 0x%llx]\n",
+			(unsigned long long)bfr->iova,
+			(unsigned long long)bfr_end);
+		return -EFAULT;
+	}
+
+	bfr->iomem = smc->sram_base + (bfr->iova - smc->sram->start);
+	bfr->is_mapped = true;
+
+	return 0;
+}
+
+static bool apple_smc_rtkit_recv_early(void *cookie, u8 endpoint, u64 message)
+{
+	struct apple_smc *smc = cookie;
+
+	if (endpoint != SMC_ENDPOINT) {
+		dev_warn(smc->dev, "Received message for unknown endpoint 0x%x\n", endpoint);
+		return false;
+	}
+
+	if (smc->boot_stage == APPLE_SMC_BOOTING) {
+		int ret;
+
+		smc->shmem.iova = message;
+		smc->shmem.size = SMC_SHMEM_SIZE;
+		ret = apple_smc_rtkit_shmem_setup(smc, &smc->shmem);
+		if (ret < 0) {
+			smc->boot_stage = APPLE_SMC_ERROR_NO_SHMEM;
+			dev_err(smc->dev, "Failed to initialize shared memory (%d)\n", ret);
+		} else {
+			smc->boot_stage = APPLE_SMC_INITIALIZED;
+		}
+		complete(&smc->init_done);
+	} else if (FIELD_GET(SMC_MSG, message) == SMC_MSG_NOTIFICATION) {
+		/* Handle these in the RTKit worker thread */
+		return false;
+	} else {
+		smc->cmd_ret = message;
+		if (smc->atomic_pending)
+			smc->atomic_pending = false;
+		else
+			complete(&smc->cmd_done);
+	}
+
+	return true;
+}
+
+static void apple_smc_rtkit_recv(void *cookie, u8 endpoint, u64 message)
+{
+	struct apple_smc *smc = cookie;
+
+	if (endpoint != SMC_ENDPOINT) {
+		dev_warn(smc->dev, "Received message for unknown endpoint 0x%x\n", endpoint);
+		return;
+	}
+
+	if (FIELD_GET(SMC_MSG, message) != SMC_MSG_NOTIFICATION) {
+		dev_warn(smc->dev, "Received unknown message from worker: 0x%llx\n", message);
+		return;
+	}
+
+	blocking_notifier_call_chain(&smc->event_handlers, FIELD_GET(SMC_DATA, message), NULL);
+}
+
+static const struct apple_rtkit_ops apple_smc_rtkit_ops = {
+	.crashed = apple_smc_rtkit_crashed,
+	.recv_message = apple_smc_rtkit_recv,
+	.recv_message_early = apple_smc_rtkit_recv_early,
+	.shmem_setup = apple_smc_rtkit_shmem_setup,
+};
+
+static int apple_smc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct apple_smc *smc;
+	u32 count;
+	int ret;
+
+	smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
+	if (!smc)
+		return -ENOMEM;
+
+	smc->dev = &pdev->dev;
+	smc->sram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &smc->sram);
+	if (IS_ERR(smc->sram_base))
+		return dev_err_probe(dev, PTR_ERR(smc->sram_base), "Failed to map SRAM region");
+
+	smc->rtk = devm_apple_rtkit_init(dev, smc, NULL, 0, &apple_smc_rtkit_ops);
+	if (IS_ERR(smc->rtk))
+		return dev_err_probe(dev, PTR_ERR(smc->rtk), "Failed to initialize RTKit");
+
+	smc->boot_stage = APPLE_SMC_BOOTING;
+	ret = apple_rtkit_wake(smc->rtk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to wake up SMC");
+
+	ret = apple_rtkit_start_ep(smc->rtk, SMC_ENDPOINT);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to start SMC endpoint");
+		goto cleanup;
+	}
+
+	init_completion(&smc->init_done);
+	init_completion(&smc->cmd_done);
+
+	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT,
+				       FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE), NULL, false);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to send init message");
+		goto cleanup;
+	}
+
+	if (wait_for_completion_timeout(&smc->init_done, msecs_to_jiffies(SMC_TIMEOUT_MS)) == 0) {
+		ret = -ETIMEDOUT;
+		dev_err(dev, "Timed out initializing SMC");
+		goto cleanup;
+	}
+
+	if (smc->boot_stage != APPLE_SMC_INITIALIZED) {
+		ret = -EIO;
+		dev_err(dev, "SMC failed to boot successfully, boot stage=%d\n", smc->boot_stage);
+		goto cleanup;
+	}
+
+	dev_set_drvdata(&pdev->dev, smc);
+	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
+
+	ret = apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
+	if (ret) {
+		ret = dev_err_probe(smc->dev, ret, "Failed to get key count");
+		goto cleanup;
+	}
+	smc->key_count = be32_to_cpu(count);
+
+	/* Enable notifications */
+	apple_smc_write_flag(smc, SMC_KEY(NTAP), true);
+
+	ret = mfd_add_devices(smc->dev, PLATFORM_DEVID_NONE,
+			      apple_smc_devs, ARRAY_SIZE(apple_smc_devs),
+			      NULL, 0, NULL);
+	if (ret) {
+		ret = dev_err_probe(smc->dev, ret, "Failed to register sub-devices");
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	/* Try to shut down RTKit, if it's not completely wedged */
+	if (apple_rtkit_is_running(smc->rtk))
+		apple_rtkit_quiesce(smc->rtk);
+
+	return ret;
+}
+
+static void apple_smc_remove(struct platform_device *pdev)
+{
+	struct apple_smc *smc = platform_get_drvdata(pdev);
+
+	mfd_remove_devices(smc->dev);
+
+	/* Disable notifications */
+	apple_smc_write_flag(smc, SMC_KEY(NTAP), false);
+
+	/* Shut down SMC firmware */
+	if (apple_rtkit_is_running(smc->rtk))
+		apple_rtkit_quiesce(smc->rtk);
+}
+
+static const struct of_device_id apple_smc_of_match[] = {
+	{ .compatible = "apple,smc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apple_smc_of_match);
+
+static struct platform_driver apple_smc_driver = {
+	.driver = {
+		.name = "mfd-macsmc",
+		.of_match_table = apple_smc_of_match,
+	},
+	.probe = apple_smc_probe,
+	.remove = apple_smc_remove,
+};
+module_platform_driver(apple_smc_driver);
+
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC driver");
diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
new file mode 100644
index 0000000000000000000000000000000000000000..19b6f14eb2f5dab0f1e03f679dad769716f7a0ff
--- /dev/null
+++ b/include/linux/mfd/macsmc.h
@@ -0,0 +1,277 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Apple SMC (System Management Controller) core definitions
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#ifndef _LINUX_MFD_MACSMC_H
+#define _LINUX_MFD_MACSMC_H
+
+#include <linux/soc/apple/rtkit.h>
+
+/**
+ * typedef smc_key - Alias for u32 to be used for SMC keys
+ *
+ * SMC keys are 32bit integers containing packed ASCII characters in natural
+ * integer order, i.e. 0xAABBCCDD, which represent the FourCC ABCD.
+ * The SMC driver is designed with this assumption and ensures the right
+ * endianness is used when these are stored to memory and sent to or received
+ * from the actual SMC firmware (which can be done in either shared memory or
+ * as 64bit mailbox message on Apple Silicon).
+ * Internally, SMC stores these keys in a table sorted lexicographically and
+ * allows resolving an index into this table to the corresponding SMC key.
+ * Thus, storing keys as u32 is very convenient as it allows to e.g. use
+ * normal comparison operators which directly map to the natural order used
+ * by SMC firmware.
+ *
+ * This simple type alias is introduced to allow easy recognition of SMC key
+ * variables and arguments.
+ */
+typedef u32 smc_key;
+
+/**
+ * SMC_KEY - Convert FourCC SMC keys in source code to smc_key
+ *
+ * This macro can be used to easily define FourCC SMC keys in source code
+ * and convert these to u32 / smc_key, e.g. SMC_KEY(NTAP) will expand to
+ * 0x4e544150.
+ *
+ * @s: FourCC SMC key to be converted
+ */
+#define SMC_KEY(s) (smc_key)(_SMC_KEY(#s))
+#define _SMC_KEY(s) (((s)[0] << 24) | ((s)[1] << 16) | ((s)[2] << 8) | (s)[3])
+
+#define APPLE_SMC_READABLE BIT(7)
+#define APPLE_SMC_WRITABLE BIT(6)
+#define APPLE_SMC_FUNCTION BIT(4)
+
+/**
+ * struct apple_smc_key_info - information for a SMC key as returned by SMC
+ * @size: size of the buffer associated with this key
+ * @type_code: FourCC code indicating the type for this key.
+ *             Known types:
+ *              ch8*: ASCII string
+ *              flag: boolean, 1 or 0
+ *              flt: 32-bit single-precision IEEE 754 float
+ *              hex: binary data
+ *              ioft: 64bit unsigned fixed-point intger (48.16)
+ *              {si,ui}{8,16,32,64}: signed/unsigned 8-/16-/32-/64-bit integer
+ * @flags: bitfield encoding flags (APPLE_SMC_{READABLE,WRITABLE,FUNCTION})
+ */
+struct apple_smc_key_info {
+	u8 size;
+	u32 type_code;
+	u8 flags;
+};
+
+/**
+ * enum apple_smc_boot_stage - SMC boot stage
+ * @APPLE_SMC_BOOTING: SMC is booting
+ * @APPLE_SMC_INITIALIZED: SMC is initialized and ready to use
+ * @APPLE_SMC_ERROR_NO_SHMEM: shared memory could not be initialized during boot
+ * @APPLE_SMC_ERROR_CRASHED: SMC has crashed
+ */
+enum apple_smc_boot_stage {
+	APPLE_SMC_BOOTING,
+	APPLE_SMC_INITIALIZED,
+	APPLE_SMC_ERROR_NO_SHMEM,
+	APPLE_SMC_ERROR_CRASHED
+};
+
+/**
+ * struct apple_smc
+ * @dev: underlying device struct for the physical backend device
+ * @key_count: number of available SMC keys
+ * @first_key: first valid SMC key
+ * @last_key: last valid SMC key
+ * @event_handlers: notifier call chain for events received from SMC
+ * @rtk: pointer to Apple RTKit instance
+ * @init_done: completion for initialization
+ * @boot_stage: current boot stage of SMC
+ * @sram: pointer to SRAM resource
+ * @sram_base: SRAM base address
+ * @shmem: RTKit shared memory structure for SRAM
+ * @msg_id: current message id for commands, will be incremented for each command
+ * @atomic_mode: flag set when atomic mode is entered
+ * @atomic_pending: flag indicating pending atomic command
+ * @cmd_done: completion for command execution in non-atomic mode
+ * @cmd_ret: return value from SMC for last command
+ * @mutex: mutex for non-atomic mode
+ * @lock: spinlock for atomic mode
+ */
+struct apple_smc {
+	struct device *dev;
+
+	u32 key_count;
+	smc_key first_key;
+	smc_key last_key;
+
+	struct blocking_notifier_head event_handlers;
+
+	struct apple_rtkit *rtk;
+
+	struct completion init_done;
+	enum apple_smc_boot_stage boot_stage;
+
+	struct resource *sram;
+	void __iomem *sram_base;
+	struct apple_rtkit_shmem shmem;
+
+	unsigned int msg_id;
+
+	bool atomic_mode;
+	bool atomic_pending;
+	struct completion cmd_done;
+	u64 cmd_ret;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+
+/**
+ * apple_smc_read - read size bytes from given SMC key into buf
+ * @smc: pointer to apple_smc struct
+ * @key: smc_key to be read
+ * @buf: buffer into which size bytes of data will be read from SMC
+ * @size: number of bytes to be read into buf
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size);
+
+/**
+ * apple_smc_write - write size bytes into given SMC key from buf
+ * @smc: pointer to apple_smc struct
+ * @key: smc_key data will be written to
+ * @buf: buffer from which size bytes of data will be written to SMC
+ * @size: number of bytes to be written
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size);
+
+/**
+ * apple_smc_enter_atomic - enter atomic mode to be able to use apple_smc_write_atomic
+ * @smc: pointer to apple_smc struct
+ *
+ * This function switches the SMC backend to atomic mode which allows the
+ * use of apple_smc_write_atomic while disabling *all* other functions.
+ * This is only used for shutdown/reboot which requires writing to a SMC
+ * key from atomic context.
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_enter_atomic(struct apple_smc *smc);
+
+/**
+ * apple_smc_write_atomic - write size bytes into given SMC key from buf without sleeping
+ * @smc: pointer to apple_smc struct
+ * @key: smc_key data will be written to
+ * @buf: buffer from which size bytes of data will be written to SMC
+ * @size: number of bytes to be written
+ *
+ * Note that this function will fail if apple_smc_enter_atomic hasn't been
+ * called before.
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size);
+
+/**
+ * apple_smc_rw - write and then read using the given SMC key
+ * @smc: pointer to apple_smc struct
+ * @key: smc_key data will be written to
+ * @wbuf: buffer from which size bytes of data will be written to SMC
+ * @wsize: number of bytes to be written
+ * @rbuf: buffer to which size bytes of data will be read from SMC
+ * @rsize: number of bytes to be read
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
+		 void *rbuf, size_t rsize);
+
+/**
+ * apple_smc_get_key_by_index - given an index return the corresponding SMC key
+ * @smc: pointer to apple_smc struct
+ * @index: index to be resolved
+ * @key: buffer for SMC key to be returned
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc_key *key);
+
+/**
+ * apple_smc_get_key_info - get key information from SMC
+ * @smc: pointer to apple_smc struct
+ * @key: key to acquire information for
+ * @info: pointer to struct apple_smc_key_info which will be filled
+ *
+ * Return: Zero on success, negative errno on error
+ */
+int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struct apple_smc_key_info *info);
+
+/**
+ * apple_smc_key_exists - check if the given SMC key exists
+ * @smc: pointer to apple_smc struct
+ * @key: smc_key to be checked
+ */
+static inline bool apple_smc_key_exists(struct apple_smc *smc, smc_key key)
+{
+	return apple_smc_get_key_info(smc, key, NULL) >= 0;
+}
+
+#define APPLE_SMC_TYPE_OPS(type) \
+	static inline int apple_smc_read_##type(struct apple_smc *smc, smc_key key, type *p) \
+	{ \
+		int ret = apple_smc_read(smc, key, p, sizeof(*p)); \
+		return (ret < 0) ? ret : ((ret != sizeof(*p)) ? -EINVAL : 0); \
+	} \
+	static inline int apple_smc_write_##type(struct apple_smc *smc, smc_key key, type p) \
+	{ \
+		return apple_smc_write(smc, key, &p, sizeof(p)); \
+	} \
+	static inline int apple_smc_write_##type##_atomic(struct apple_smc *smc, smc_key key, type p) \
+	{ \
+		return apple_smc_write_atomic(smc, key, &p, sizeof(p)); \
+	} \
+	static inline int apple_smc_rw_##type(struct apple_smc *smc, smc_key key, \
+					      type w, type *r) \
+	{ \
+		int ret = apple_smc_rw(smc, key, &w, sizeof(w), r, sizeof(*r)); \
+		return (ret < 0) ? ret : ((ret != sizeof(*r)) ? -EINVAL : 0); \
+	}
+
+APPLE_SMC_TYPE_OPS(u64)
+APPLE_SMC_TYPE_OPS(u32)
+APPLE_SMC_TYPE_OPS(u16)
+APPLE_SMC_TYPE_OPS(u8)
+APPLE_SMC_TYPE_OPS(s64)
+APPLE_SMC_TYPE_OPS(s32)
+APPLE_SMC_TYPE_OPS(s16)
+APPLE_SMC_TYPE_OPS(s8)
+
+static inline int apple_smc_read_flag(struct apple_smc *smc, smc_key key, bool *flag)
+{
+	u8 val;
+	int ret = apple_smc_read_u8(smc, key, &val);
+
+	if (ret < 0)
+		return ret;
+
+	*flag = val ? true : false;
+	return ret;
+}
+
+static inline int apple_smc_write_flag(struct apple_smc *smc, smc_key key, bool state)
+{
+	return apple_smc_write_u8(smc, key, state ? 1 : 0);
+}
+
+static inline int apple_smc_write_flag_atomic(struct apple_smc *smc, smc_key key, bool state)
+{
+	return apple_smc_write_u8_atomic(smc, key, state ? 1 : 0);
+}
+
+#endif

-- 
2.34.1



