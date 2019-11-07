Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0888DF3A7C
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 22:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKGVYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 16:24:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKGVYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bXnbbmeL5QmbnMDYQ+2SbRekVVWKQx3tUlSEnD2pnrw=; b=T9WRZYqyAEeKow6conFXchMbeb
        lmseCwm+iL1RcRGcmNpIYR7EtNEeRE1qov9WQykG5ueazQI2B8qZkP660mUBv+0gPp+St0UT/2OUm
        NNTYKI4y/TdyKk1RLwLNG5I0YVRRMJ6OH4TerT8wF0jRUmEWcJVaUhpnJl6FagwB59UplE968QrLD
        JTtPNEfnyANtWGdjtg1F2/dNxt9iM2iWiU0MOBp+6T89PxzZqacniTjvRteCklsKuhd/osWv7TkCE
        K7OpVoaYuJhPV7t5wGt56maLxIoXW6HIMs9xeBONQEU+DSMtz1v06fKVxTjopIdwS+PPe5XgC+V7y
        JQXm/oqg==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSpGM-0007Hi-Dr; Thu, 07 Nov 2019 21:24:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] power: reset: add a QEMU RISC-V virt machine poweroff driver
Date:   Thu,  7 Nov 2019 22:24:08 +0100
Message-Id: <20191107212408.11857-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107212408.11857-1-hch@lst.de>
References: <20191107212408.11857-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a trivial poweroff driver for the qemu-virt test device that
allows an oderly shutdown of the VM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/configs/defconfig                  |  2 +
 drivers/power/reset/Kconfig                   |  8 ++++
 drivers/power/reset/Makefile                  |  1 +
 .../power/reset/qemu-riscv-virt-poweroff.c    | 47 +++++++++++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 drivers/power/reset/qemu-riscv-virt-poweroff.c

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 420a0dbef386..47da87725b5e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -63,6 +63,8 @@ CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
+CONFIG_POWER_RESET=y
+CONFIG_QEMU_RISCV_VIRT_POWEROFF=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_VIRTIO_GPU=y
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a564237278ff..56cb18520850 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -256,5 +256,13 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config QEMU_RISCV_VIRT_POWEROFF
+	tristate "QEMU RISC-V virt machine poweroff driver"
+	depends on OF
+	depends on RISCV || COMPILE_TEST
+	help
+	  Say y here to allow RISC-V Qemu VMs to be shut down by
+	  the kernel.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 85da3198e4e0..b3094016b634 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_QEMU_RISCV_VIRT_POWEROFF) += qemu-riscv-virt-poweroff.o
diff --git a/drivers/power/reset/qemu-riscv-virt-poweroff.c b/drivers/power/reset/qemu-riscv-virt-poweroff.c
new file mode 100644
index 000000000000..5b9a12dd853b
--- /dev/null
+++ b/drivers/power/reset/qemu-riscv-virt-poweroff.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Christoph Hellwig.
+ */
+
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+
+#define VIRT_TEST_FINISHER_PASS         0x5555
+
+static u16 __iomem *test_addr;
+
+static void qemu_virt_power_off(void)
+{
+	writew(VIRT_TEST_FINISHER_PASS, test_addr);
+}
+
+static int sifive_test_probe(struct platform_device *pdev)
+{
+	/* there can only be a single instance */
+	if (WARN_ON_ONCE(test_addr))
+		return -EINVAL;
+
+	test_addr = of_iomap(pdev->dev.of_node, 0);
+	if (!test_addr)
+		return -EINVAL;
+	pm_power_off = qemu_virt_power_off;
+	return 0;
+}
+
+static const struct of_device_id sifive_test_of_match[] = {
+	{ .compatible = "sifive,test0", },
+	{},
+};
+
+static struct platform_driver sifive_test_driver = {
+	.probe			= sifive_test_probe,
+	.driver = {
+		.name		= "sifive_test",
+		.of_match_table = sifive_test_of_match,
+	},
+};
+module_platform_driver(sifive_test_driver);
-- 
2.20.1

