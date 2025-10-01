Return-Path: <linux-pm+bounces-35641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FDBB1223
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1E4A2687
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D727F195;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8VUiSsN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91727E7EB;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333362; cv=none; b=ZjG6CS54OVxOZ4C04U0Dvkl/cTNBmCMLcVxndjxDAsCSgcUu/DBKih9wPuDFz/sT8mpQBFWQRDIAVsvrIYLq0Ubc1URhAFAbxOblZExvnaX4ijsm4L6M3LT839r0U5TXIFRO29jZM1TWnecvazsbHUVaH/bQQuMX7ksyw6FTvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333362; c=relaxed/simple;
	bh=b5Sa6Vsjh++ka1Z1qGvYRrwFSI7ixOTo9OYBj9tUCAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHJYJjpmd8YVS85MbZQNVg26xcyMJLMGL+zC0VG44xRWA2lT1OIkwc9TlxvEbVNkLcUHldb3XaT9dZtPEHdiOhxVlHjV4d0UVyCwGPBXRB0Q5FSKLRqf8F231JN3ZOODBr5ObInU9iDNA4AId8xhjeH+PBKTZ062aYcYaXEuFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8VUiSsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF1CC4CEFB;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333361;
	bh=b5Sa6Vsjh++ka1Z1qGvYRrwFSI7ixOTo9OYBj9tUCAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X8VUiSsN8fuDVJoEuT76tyIErVHnFYhDgnir2muXg8q/wawLz5Da9nryZozUDia5C
	 bX2MSQMlynTW0c56kWO0h81sMT3uzueCr/3XHL1DdMVNpa9R07JRlFA1jRasIrQjnO
	 rYozTVMtE0coZLIxERDARoFZxp0z/G6CaFMOBDs5ITkIoQMU/ZdpYRDS/4Gc9NjBuE
	 nR1VfxQLQoWB9U6LiR3a2P4Kq/AZ1JEZsOhlGlS4JOAiaqAXT/5EVwU8phdmukA7MG
	 RERap1NxWo41L3UMraJnIGHbDmEJGlhG1T+n/3J5aUc+WW9KJd8778G9wDq5zbdWss
	 Itw5dijMEDNBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F534CCA474;
	Wed,  1 Oct 2025 15:42:41 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 01 Oct 2025 11:42:38 -0400
Subject: [PATCH v12 2/6] mfd: pf1550: add core driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-pf1550-v12-2-a3302aa41687@savoirfairelinux.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759333360; l=26007;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=99LsSX08cd3SVE/uCzfDMX6kqPY2bWW3H88ymxFHO1I=;
 b=bXE6juPA03lHohNsKy6fsYt5V4A7VxKOVcNSn62rlWfalRnoV2BCqrugeFVWJeUqYdX85uuxm
 gYa53s6Ez3qCUKCwATFqki6KGiWexoj2HRd+8rjhRGWdxFLiGWNHtaf
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add the core driver for pf1550 PMIC. There are 3 subdevices for which the
drivers will be added in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v11:
  - Add Tested-by tag from Sean
v10:
  - Address Lee's feedback:
    - Change dvsX_enb to dvsX_enable
    - Add new line where necessary
    - Can use 100 chars in a line
    - Begin comments with uppercase
    - Rearrange members of struct pf1550_ddata
  - Add support for disabling onkey shutting down system
v9:
 - Requested by Sean:
   - Add support for SW1 DVS enable/disable
 - Use consistent whitespace
 - Adjust commenting and log messages of the read_otp function
v8:
 - Address Lee's feedback:
   - Drop `mfd` from driver description and comments
   - Add module name in Kconfig
   - Fix license commenting
   - Drop filenames from comments
   - Drop unnecessary tabbing
   - Alphabetical ordering of includes
   - Remove magic numbers
   - Add comments for pf1550_read_otp function
   - Fix log error message in pf1550_read_otp
   - Drop pf1550_add_child_device function
   - Start comments with upper case
   - Rename pf1550_dev to pf1550_ddata
   - Drop i2c member in struct pf1550_ddata/pf1550_dev
   - Use more helpful log message when device id not recognized
   - Fix dvs_enb: when bit is set the DVS is disabled and when bit is clear the
     DVS is enabled
  - Verified the PM_OPS suspend and resume do act as expected
v7:
 - Address Frank's feedback:
   - Ensure reverse christmas tree order for local variable definitions
   - Drop unnecessary driver data definition in id table
v6:
 - Address Frank's feedback:
   - Ensure lowercase when defining register addresses
   - Use GENMASK macro for masking
   - Hardcode IRQ flags in pf1550_add_child_device
   - Add dvs_enb variable for SW2 regulator
   - Drop chip type variable
v5:
 - Use top level interrupt to manage interrupts for the sub-drivers as
   recommended by Mark Brown. The regmap_irq_sub_irq_map would have been used
   if not for the irregular charger irq address. For all children, the mask
   register is directly after the irq register (i.e., 0x08, 0x09) except
   for the charger: 0x80, 0x82. Meaning .mask_base would be applicable
   for all but the charger
 - Fix bad offset for temperature interrupts of regulator
v4:
 - Use struct resource to define irq so platform_get_irq can be used in
   children as suggested by Dmitry
 - Let mfd_add_devices create the mappings for the interrupts
 - ack_base and init_ack_masked defined for charger and regulator irq
   chips
 - No need to define driver_data in table id
v3:
 - Address Dmitry's feedback:
   - Place Table IDs next to each other
   - Drop of_match_ptr
   - Replace dev_err with dev_err_probe in probe method
   - Drop useless log in probe
 - Map all irqs instead of doing it in the sub-devices as recommended by
   Dmitry.
v2:
 - Address feedback from Enric Balletbo Serra
---
 drivers/mfd/Kconfig        |  16 ++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/pf1550.c       | 367 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pf1550.h | 273 +++++++++++++++++++++++++++++++++
 4 files changed, 658 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1e7848dcea05bd77c729a71d48e2c..e48c471f572cf4fbfe4de82eae6eeae5fa3bfbfc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -604,6 +604,22 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_PF1550
+	tristate "NXP PF1550 PMIC Support"
+	depends on I2C=y && OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for NXP PF1550. This is a companion Power
+	  Management IC with regulators, onkey, and charger control on chip.
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
+	  This driver can also be built as a module and if so will be called
+	  pf1550.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f7bdedd5a66d16bf8ccee0da1236a441e6f085b0..987e8c2ba5bf7b449ea636f62f103c933f0ac3d0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -121,6 +121,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
new file mode 100644
index 0000000000000000000000000000000000000000..c4f567c055640662cc2db742917cc87cf9cabb5f
--- /dev/null
+++ b/drivers/mfd/pf1550.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Core driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+ * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config pf1550_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF1550_PMIC_REG_END,
+};
+
+static const struct regmap_irq pf1550_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_IRQ_CHG, 0, IRQ_CHG),
+	REGMAP_IRQ_REG(PF1550_IRQ_REGULATOR, 0, IRQ_REGULATOR),
+	REGMAP_IRQ_REG(PF1550_IRQ_ONKEY, 0, IRQ_ONKEY),
+};
+
+static const struct regmap_irq_chip pf1550_irq_chip = {
+	.name = "pf1550",
+	.status_base = PF1550_PMIC_REG_INT_CATEGORY,
+	.init_ack_masked = 1,
+	.num_regs = 1,
+	.irqs = pf1550_irqs,
+	.num_irqs = ARRAY_SIZE(pf1550_irqs),
+};
+
+static const struct regmap_irq pf1550_regulator_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_LS, 0, PMIC_IRQ_SW1_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_LS, 0, PMIC_IRQ_SW2_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_LS, 0, PMIC_IRQ_SW3_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_HS, 3, PMIC_IRQ_SW1_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_HS, 3, PMIC_IRQ_SW2_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_HS, 3, PMIC_IRQ_SW3_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO1_FAULT, 16, PMIC_IRQ_LDO1_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO2_FAULT, 16, PMIC_IRQ_LDO2_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO3_FAULT, 16, PMIC_IRQ_LDO3_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_110, 24, PMIC_IRQ_TEMP_110),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_125, 24, PMIC_IRQ_TEMP_125),
+};
+
+static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
+	.name = "pf1550-regulator",
+	.status_base = PF1550_PMIC_REG_SW_INT_STAT0,
+	.ack_base = PF1550_PMIC_REG_SW_INT_STAT0,
+	.mask_base = PF1550_PMIC_REG_SW_INT_MASK0,
+	.use_ack = 1,
+	.init_ack_masked = 1,
+	.num_regs = 25,
+	.irqs = pf1550_regulator_irqs,
+	.num_irqs = ARRAY_SIZE(pf1550_regulator_irqs),
+};
+
+static const struct resource regulator_resources[] = {
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO1_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO2_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO3_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_110),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_125),
+};
+
+static const struct regmap_irq pf1550_onkey_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_PUSHI, 0, ONKEY_IRQ_PUSHI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_1SI, 0, ONKEY_IRQ_1SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_2SI, 0, ONKEY_IRQ_2SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_3SI, 0, ONKEY_IRQ_3SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_4SI, 0, ONKEY_IRQ_4SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_8SI, 0, ONKEY_IRQ_8SI),
+};
+
+static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
+	.name = "pf1550-onkey",
+	.status_base = PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.ack_base = PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.mask_base = PF1550_PMIC_REG_ONKEY_INT_MASK0,
+	.use_ack = 1,
+	.init_ack_masked = 1,
+	.num_regs = 1,
+	.irqs = pf1550_onkey_irqs,
+	.num_irqs = ARRAY_SIZE(pf1550_onkey_irqs),
+};
+
+static const struct resource onkey_resources[] = {
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_PUSHI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_1SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_2SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_3SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_4SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_8SI),
+};
+
+static const struct regmap_irq pf1550_charger_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BAT2SOCI, 0, CHARG_IRQ_BAT2SOCI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BATI, 0, CHARG_IRQ_BATI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_CHGI, 0, CHARG_IRQ_CHGI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_VBUSI, 0, CHARG_IRQ_VBUSI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_THMI, 0, CHARG_IRQ_THMI),
+};
+
+static const struct regmap_irq_chip pf1550_charger_irq_chip = {
+	.name = "pf1550-charger",
+	.status_base = PF1550_CHARG_REG_CHG_INT,
+	.ack_base = PF1550_CHARG_REG_CHG_INT,
+	.mask_base = PF1550_CHARG_REG_CHG_INT_MASK,
+	.use_ack = 1,
+	.init_ack_masked = 1,
+	.num_regs = 1,
+	.irqs = pf1550_charger_irqs,
+	.num_irqs = ARRAY_SIZE(pf1550_charger_irqs),
+};
+
+static const struct resource charger_resources[] = {
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BAT2SOCI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BATI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_CHGI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_VBUSI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_THMI),
+};
+
+static const struct mfd_cell pf1550_regulator_cell = {
+	.name = "pf1550-regulator",
+	.num_resources = ARRAY_SIZE(regulator_resources),
+	.resources = regulator_resources,
+};
+
+static const struct mfd_cell pf1550_onkey_cell = {
+	.name = "pf1550-onkey",
+	.num_resources = ARRAY_SIZE(onkey_resources),
+	.resources = onkey_resources,
+};
+
+static const struct mfd_cell pf1550_charger_cell = {
+	.name = "pf1550-charger",
+	.num_resources = ARRAY_SIZE(charger_resources),
+	.resources = charger_resources,
+};
+
+/*
+ * The PF1550 is shipped in variants of A0, A1,...A9. Each variant defines a
+ * configuration of the PMIC in a One-Time Programmable (OTP) memory.
+ * This memory is accessed indirectly by writing valid keys to specific
+ * registers of the PMIC. To read the OTP memory after writing the valid keys,
+ * the OTP register address to be read is written to pf1550 register 0xc4 and
+ * its value read from pf1550 register 0xc5.
+ */
+static int pf1550_read_otp(const struct pf1550_ddata *pf1550, unsigned int index,
+			   unsigned int *val)
+{
+	int ret = 0;
+
+	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, PF1550_OTP_PMIC_KEY);
+	if (ret)
+		goto read_err;
+
+	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, PF1550_OTP_CHGR_KEY);
+	if (ret)
+		goto read_err;
+
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, PF1550_OTP_TEST_KEY);
+	if (ret)
+		goto read_err;
+
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
+	if (ret)
+		goto read_err;
+
+	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
+	if (ret)
+		goto read_err;
+
+	return 0;
+
+read_err:
+	return dev_err_probe(pf1550->dev, ret, "OTP reg %x not found!\n", index);
+}
+
+static int pf1550_i2c_probe(struct i2c_client *i2c)
+{
+	const struct mfd_cell *regulator = &pf1550_regulator_cell;
+	const struct mfd_cell *charger = &pf1550_charger_cell;
+	const struct mfd_cell *onkey = &pf1550_onkey_cell;
+	unsigned int reg_data = 0, otp_data = 0;
+	struct pf1550_ddata *pf1550;
+	struct irq_domain *domain;
+	int irq, ret = 0;
+
+	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
+	if (!pf1550)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, pf1550);
+	pf1550->dev = &i2c->dev;
+	pf1550->irq = i2c->irq;
+
+	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
+	if (IS_ERR(pf1550->regmap))
+		return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
+				     "failed to allocate register map\n");
+
+	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
+	if (ret < 0)
+		return dev_err_probe(pf1550->dev, ret, "cannot read chip ID\n");
+	if (reg_data != PF1550_DEVICE_ID)
+		return dev_err_probe(pf1550->dev, -ENODEV, "invalid device ID: 0x%02x\n", reg_data);
+
+	/* Regulator DVS for SW2 */
+	ret = pf1550_read_otp(pf1550, PF1550_OTP_SW2_SW3, &otp_data);
+	if (ret)
+		return ret;
+
+	/* When clear, DVS should be enabled */
+	if (!(otp_data & OTP_SW2_DVS_ENB))
+		pf1550->dvs2_enable = true;
+
+	/* Regulator DVS for SW1 */
+	ret = pf1550_read_otp(pf1550, PF1550_OTP_SW1_SW2, &otp_data);
+	if (ret)
+		return ret;
+
+	if (!(otp_data & OTP_SW1_DVS_ENB))
+		pf1550->dvs1_enable = true;
+
+	/* Add top level interrupts */
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING,
+				       0, &pf1550_irq_chip,
+				       &pf1550->irq_data);
+	if (ret)
+		return ret;
+
+	/* Add regulator */
+	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_REGULATOR);
+	if (irq < 0)
+		return dev_err_probe(pf1550->dev, irq,
+				     "Failed to get parent vIRQ(%d) for chip %s\n",
+				     PF1550_IRQ_REGULATOR, pf1550_irq_chip.name);
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_regulator_irq_chip,
+				       &pf1550->irq_data_regulator);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret, "Failed to add %s IRQ chip\n",
+				     pf1550_regulator_irq_chip.name);
+
+	domain = regmap_irq_get_domain(pf1550->irq_data_regulator);
+
+	ret = devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, regulator, 1, NULL, 0, domain);
+	if (ret)
+		return ret;
+
+	/* Add onkey */
+	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_ONKEY);
+	if (irq < 0)
+		return dev_err_probe(pf1550->dev, irq,
+				     "Failed to get parent vIRQ(%d) for chip %s\n",
+				     PF1550_IRQ_ONKEY, pf1550_irq_chip.name);
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_onkey_irq_chip,
+				       &pf1550->irq_data_onkey);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret, "Failed to add %s IRQ chip\n",
+				     pf1550_onkey_irq_chip.name);
+
+	domain = regmap_irq_get_domain(pf1550->irq_data_onkey);
+
+	ret = devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, onkey, 1, NULL, 0, domain);
+	if (ret)
+		return ret;
+
+	/* Add battery charger */
+	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_CHG);
+	if (irq < 0)
+		return dev_err_probe(pf1550->dev, irq,
+				     "Failed to get parent vIRQ(%d) for chip %s\n",
+				     PF1550_IRQ_CHG, pf1550_irq_chip.name);
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_charger_irq_chip,
+				       &pf1550->irq_data_charger);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret, "Failed to add %s IRQ chip\n",
+				     pf1550_charger_irq_chip.name);
+
+	domain = regmap_irq_get_domain(pf1550->irq_data_charger);
+
+	return devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, charger, 1, NULL, 0, domain);
+}
+
+static int pf1550_suspend(struct device *dev)
+{
+	struct pf1550_ddata *pf1550 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(pf1550->irq);
+		disable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static int pf1550_resume(struct device *dev)
+{
+	struct pf1550_ddata *pf1550 = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(pf1550->irq);
+		enable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
+
+static const struct i2c_device_id pf1550_i2c_id[] = {
+	{ "pf1550" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
+
+static const struct of_device_id pf1550_dt_match[] = {
+	{ .compatible = "nxp,pf1550" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pf1550_dt_match);
+
+static struct i2c_driver pf1550_i2c_driver = {
+	.driver = {
+		   .name = "pf1550",
+		   .pm = pm_sleep_ptr(&pf1550_pm),
+		   .of_match_table = pf1550_dt_match,
+	},
+	.probe = pf1550_i2c_probe,
+	.id_table = pf1550_i2c_id,
+};
+module_i2c_driver(pf1550_i2c_driver);
+
+MODULE_DESCRIPTION("NXP PF1550 core driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
new file mode 100644
index 0000000000000000000000000000000000000000..7cb2340ff2bd92883a709806da58601daaf98a88
--- /dev/null
+++ b/include/linux/mfd/pf1550.h
@@ -0,0 +1,273 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Declarations for the PF1550 PMIC
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+ * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+ */
+
+#ifndef __LINUX_MFD_PF1550_H
+#define __LINUX_MFD_PF1550_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+enum pf1550_pmic_reg {
+	/* PMIC regulator part */
+	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
+	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
+	PF1550_PMIC_REG_SILICON_REV		= 0x02,
+
+	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
+	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
+	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
+	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0a,
+	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0b,
+	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0c,
+	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0d,
+	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0e,
+	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0f,
+	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
+	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
+	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
+	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1a,
+	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
+	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
+	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
+	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
+	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
+	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
+	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
+	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
+	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2a,
+
+	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
+
+	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
+	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
+	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
+	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
+	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
+	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
+	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
+	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3a,
+	PF1550_PMIC_REG_SW2_CTRL		= 0x3b,
+	PF1550_PMIC_REG_SW2_CTRL1		= 0x3c,
+	PF1550_PMIC_REG_SW3_VOLT		= 0x3e,
+	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3f,
+	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
+	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
+	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
+	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
+	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4a,
+	PF1550_PMIC_REG_LDO1_VOLT		= 0x4c,
+	PF1550_PMIC_REG_LDO1_CTRL		= 0x4d,
+	PF1550_PMIC_REG_LDO2_VOLT		= 0x4f,
+	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
+	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
+	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
+	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
+	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
+	PF1550_PMIC_REG_PWRCTRL2		= 0x5a,
+	PF1550_PMIC_REG_PWRCTRL3		= 0x5b,
+	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5f,
+	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
+	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
+	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
+	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
+	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
+	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
+
+	PF1550_PMIC_REG_STATE_INFO		= 0x67,
+	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
+	PF1550_PMIC_REG_IO_DRV0			= 0x69,
+	PF1550_PMIC_REG_IO_DRV1			= 0x6a,
+	PF1550_PMIC_REG_RC_16MHZ		= 0x6b,
+	PF1550_PMIC_REG_KEY			= 0x6f,
+
+	/* Charger part */
+	PF1550_CHARG_REG_CHG_INT		= 0x80,
+	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
+	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
+	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
+	PF1550_CHARG_REG_CHG_SNS		= 0x87,
+	PF1550_CHARG_REG_BATT_SNS		= 0x88,
+	PF1550_CHARG_REG_CHG_OPER		= 0x89,
+	PF1550_CHARG_REG_CHG_TMR		= 0x8a,
+	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8d,
+	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8e,
+	PF1550_CHARG_REG_BATT_REG		= 0x8f,
+	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
+	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
+	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
+	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
+	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
+	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
+	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
+	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9a,
+	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9b,
+	PF1550_CHARG_REG_LED_PWM		= 0x9c,
+	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9d,
+	PF1550_CHARG_REG_LED_CNFG		= 0x9e,
+	PF1550_CHARG_REG_CHGR_KEY2		= 0x9f,
+
+	PF1550_TEST_REG_FMRADDR			= 0xc4,
+	PF1550_TEST_REG_FMRDATA			= 0xc5,
+	PF1550_TEST_REG_KEY3			= 0xdf,
+
+	PF1550_PMIC_REG_END			= 0xff,
+};
+
+/* One-Time Programmable(OTP) memory */
+enum pf1550_otp_reg {
+	PF1550_OTP_SW1_SW2			= 0x1e,
+	PF1550_OTP_SW2_SW3			= 0x1f,
+};
+
+#define PF1550_DEVICE_ID		0x7c
+
+/* Keys for reading OTP */
+#define PF1550_OTP_PMIC_KEY		0x15
+#define PF1550_OTP_CHGR_KEY		0x50
+#define PF1550_OTP_TEST_KEY		0xab
+
+/* Supported charger modes */
+#define PF1550_CHG_BAT_OFF		1
+#define PF1550_CHG_BAT_ON		2
+
+#define PF1550_CHG_PRECHARGE		0
+#define PF1550_CHG_CONSTANT_CURRENT	1
+#define PF1550_CHG_CONSTANT_VOL		2
+#define PF1550_CHG_EOC			3
+#define PF1550_CHG_DONE			4
+#define PF1550_CHG_TIMER_FAULT		6
+#define PF1550_CHG_SUSPEND		7
+#define PF1550_CHG_OFF_INV		8
+#define PF1550_CHG_BAT_OVER		9
+#define PF1550_CHG_OFF_TEMP		10
+#define PF1550_CHG_LINEAR_ONLY		12
+#define PF1550_CHG_SNS_MASK		0xf
+#define PF1550_CHG_INT_MASK		0x51
+
+#define PF1550_BAT_NO_VBUS		0
+#define PF1550_BAT_LOW_THAN_PRECHARG	1
+#define PF1550_BAT_CHARG_FAIL		2
+#define PF1550_BAT_HIGH_THAN_PRECHARG	4
+#define PF1550_BAT_OVER_VOL		5
+#define PF1550_BAT_NO_DETECT		6
+#define PF1550_BAT_SNS_MASK		0x7
+
+#define PF1550_VBUS_UVLO		BIT(2)
+#define PF1550_VBUS_IN2SYS		BIT(3)
+#define PF1550_VBUS_OVLO		BIT(4)
+#define PF1550_VBUS_VALID		BIT(5)
+
+#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		GENMASK(7, 6)
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	GENMASK(3, 2)
+
+#define PF1550_ONKEY_RST_EN		BIT(7)
+
+/* DVS enable masks */
+#define OTP_SW1_DVS_ENB		BIT(1)
+#define OTP_SW2_DVS_ENB		BIT(3)
+
+/* Top level interrupt masks */
+#define IRQ_REGULATOR		(BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(6))
+#define IRQ_ONKEY		BIT(5)
+#define IRQ_CHG			BIT(0)
+
+/* Regulator interrupt masks */
+#define PMIC_IRQ_SW1_LS		BIT(0)
+#define PMIC_IRQ_SW2_LS		BIT(1)
+#define PMIC_IRQ_SW3_LS		BIT(2)
+#define PMIC_IRQ_SW1_HS		BIT(0)
+#define PMIC_IRQ_SW2_HS		BIT(1)
+#define PMIC_IRQ_SW3_HS		BIT(2)
+#define PMIC_IRQ_LDO1_FAULT	BIT(0)
+#define PMIC_IRQ_LDO2_FAULT	BIT(1)
+#define PMIC_IRQ_LDO3_FAULT	BIT(2)
+#define PMIC_IRQ_TEMP_110	BIT(0)
+#define PMIC_IRQ_TEMP_125	BIT(1)
+
+/* Onkey interrupt masks */
+#define ONKEY_IRQ_PUSHI		BIT(0)
+#define ONKEY_IRQ_1SI		BIT(1)
+#define ONKEY_IRQ_2SI		BIT(2)
+#define ONKEY_IRQ_3SI		BIT(3)
+#define ONKEY_IRQ_4SI		BIT(4)
+#define ONKEY_IRQ_8SI		BIT(5)
+
+/* Charger interrupt masks */
+#define CHARG_IRQ_BAT2SOCI	BIT(1)
+#define CHARG_IRQ_BATI		BIT(2)
+#define CHARG_IRQ_CHGI		BIT(3)
+#define CHARG_IRQ_VBUSI		BIT(5)
+#define CHARG_IRQ_DPMI		BIT(6)
+#define CHARG_IRQ_THMI		BIT(7)
+
+enum pf1550_irq {
+	PF1550_IRQ_CHG,
+	PF1550_IRQ_REGULATOR,
+	PF1550_IRQ_ONKEY,
+};
+
+enum pf1550_pmic_irq {
+	PF1550_PMIC_IRQ_SW1_LS,
+	PF1550_PMIC_IRQ_SW2_LS,
+	PF1550_PMIC_IRQ_SW3_LS,
+	PF1550_PMIC_IRQ_SW1_HS,
+	PF1550_PMIC_IRQ_SW2_HS,
+	PF1550_PMIC_IRQ_SW3_HS,
+	PF1550_PMIC_IRQ_LDO1_FAULT,
+	PF1550_PMIC_IRQ_LDO2_FAULT,
+	PF1550_PMIC_IRQ_LDO3_FAULT,
+	PF1550_PMIC_IRQ_TEMP_110,
+	PF1550_PMIC_IRQ_TEMP_125,
+};
+
+enum pf1550_onkey_irq {
+	PF1550_ONKEY_IRQ_PUSHI,
+	PF1550_ONKEY_IRQ_1SI,
+	PF1550_ONKEY_IRQ_2SI,
+	PF1550_ONKEY_IRQ_3SI,
+	PF1550_ONKEY_IRQ_4SI,
+	PF1550_ONKEY_IRQ_8SI,
+};
+
+enum pf1550_charg_irq {
+	PF1550_CHARG_IRQ_BAT2SOCI,
+	PF1550_CHARG_IRQ_BATI,
+	PF1550_CHARG_IRQ_CHGI,
+	PF1550_CHARG_IRQ_VBUSI,
+	PF1550_CHARG_IRQ_THMI,
+};
+
+enum pf1550_regulators {
+	PF1550_SW1,
+	PF1550_SW2,
+	PF1550_SW3,
+	PF1550_VREFDDR,
+	PF1550_LDO1,
+	PF1550_LDO2,
+	PF1550_LDO3,
+};
+
+struct pf1550_ddata {
+	struct regmap_irq_chip_data *irq_data_regulator;
+	struct regmap_irq_chip_data *irq_data_charger;
+	struct regmap_irq_chip_data *irq_data_onkey;
+	struct regmap_irq_chip_data *irq_data;
+	struct regmap *regmap;
+	struct device *dev;
+	bool dvs1_enable;
+	bool dvs2_enable;
+	int irq;
+};
+
+#endif /* __LINUX_MFD_PF1550_H */

-- 
2.50.1



