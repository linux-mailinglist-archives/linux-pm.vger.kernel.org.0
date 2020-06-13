Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8151F82F6
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jun 2020 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgFMK3O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jun 2020 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgFMK2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jun 2020 06:28:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29AAC08C5C2
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2020 03:28:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so10198641wmi.2
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2020 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roEol/nTFYZ5xZzwvlQenXs1w+jmJbk2YKEI6lkb47o=;
        b=MZdWRSCbX1vaGo91qYRn125MNnFrrtLIZQMFpnGoohpTZeHC6Bfpk1kl8xgPtBuNPX
         +HIPtXDpfBHf7VkU3+/xu29zOu9z1WMkJeBrAwcAkAiXo8IR1SNP4AyIFcWArDu3TaEK
         Rx0X8bNn+sXURsYubE6DwsHsbqKK8j+4xJ+UXwb0U3cDZ1H59K8Eo2YlBAFu/pi51ymp
         VhKdN+de/Fvg69SGc4tzmST/3siM0KjF6jxuQeHAdL366NNIfmqA2OS1kAb+sT6JHfUa
         jlUwhu3nnwvMGObckuVqCaUUyukKfITo07IrEYnnGqsOz1+mwSzYocV9fjnaztY5iChL
         s7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=roEol/nTFYZ5xZzwvlQenXs1w+jmJbk2YKEI6lkb47o=;
        b=CAeO7iuJqOnsTh5QjW6q2JnT6kZyRah9UyDwfLybFpIUE9/pdK2okrd2DRjcR/lHQJ
         kh23ouw82iNnROK3Jphs5Wk00ccDkC/+AnF2Yxjn0uLOUthFeXiK1snmLkrwlwaEmsky
         qmY53cOF1aLIdEtmO0DQXlioIJFtKaLbJpIvpFD5mcsGpNdoqlEdFmlQFYVrEQFLRw2/
         xsMyEb1p+HdWjpg/7o/VBDntkyQi8LPEmZKQGZm6LqHNWtMnRfWqYSAupXrJeJpkqSQ9
         UQtR4eChsvSnBLLvwz51T5DGoLo+7ms6hFIIQGNRDkE71JTYqHuATZLFbUm5vadzrp8u
         7+EA==
X-Gm-Message-State: AOAM5325EnUiPsPDIbE3VYa56Nun2PT0FyDrHs03oJ2FCkCfZA/XmssX
        qV4812Onw3iAzkE1In+qshcmwiZ1t90=
X-Google-Smtp-Source: ABdhPJxwJO912Fmxx5Ct2lRsQ3Nf4OFuV3iJabf/P802dIrcTjsEN9jJvaR5M7L6OyEp9IZpyKra5Q==
X-Received: by 2002:a1c:5fd4:: with SMTP id t203mr3142268wmb.184.1592044103219;
        Sat, 13 Jun 2020 03:28:23 -0700 (PDT)
Received: from tool.localnet ([213.177.199.127])
        by smtp.googlemail.com with ESMTPSA id y14sm12519090wma.25.2020.06.13.03.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 03:28:22 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org
Subject: [PATCH v3 1/2 ] power: reset: add driver for LinkStation power off
Date:   Sat, 13 Jun 2020 12:26:52 +0200
Message-ID: <3315137.NY7H5Hu6o1@tool>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some Buffalo LinkStations perform the power off operation, at restart
time, depending on the state of an output pin (LED2/INTn) at the ethernet
PHY. This pin is also used to wake the machine when a WoL packet is=20
received by the PHY.

The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
and other models. Without it, the board remains forever halted if a=20
power off command is executed, unless the PSU is disconnected and
connected again.

Add the driver to provide the power off function and also make the WoL
feature to be available.

Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
=2D--
Changes in v3:
  - Code for PHY autodectection added, "phy-handle,intn" deleted.
Changes in v2:
  - The driver is now compatible with the WoL function, the LED2 pin output
    is now used as INTn. Added the required code to make INTn work properly.
  - Code for PHY autodectection deleted, "phy-handle,intn" is now mandatory.
  - Replace a dev_info with a dev_dbg.
  - Use phy_device_free in the driver remove.
  - Cosmetic changes.

 drivers/power/reset/Kconfig                |  11 ++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/linkstation-poweroff.c | 144 +++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/power/reset/linkstation-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f07b982c8d..431cd9f201 100644
=2D-- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -99,6 +99,17 @@ config POWER_RESET_HISI
 	help
 	  Reboot support for Hisilicon boards.
=20
+config POWER_RESET_LINKSTATION
+	tristate "Buffalo LinkStation power-off driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF_MDIO && PHYLIB
+	help
+	  This driver supports turning off some Buffalo LinkStations by
+	  setting an output pin at the ethernet PHY to the correct state.
+	  It also makes the device compatible with the WoL function.
+
+	  Say Y here if you have Buffalo LinkStation LS421D/E.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 5710ca4695..c51eceba9e 100644
=2D-- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini-pow=
eroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
+obj-${CONFIG_POWER_RESET_LINKSTATION} +=3D linkstation-poweroff.o
 obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/res=
et/linkstation-poweroff.c
new file mode 100644
index 0000000000..688af0a962
=2D-- /dev/null
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LinkStation power off restart driver
+ * Copyright (C) 2020 Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_platform.h>
+#include <linux/reboot.h>
+#include <linux/phy.h>
+
+/* Defines from the eth phy Marvell driver */
+#define MII_MARVELL_COPPER_PAGE		0
+#define MII_MARVELL_LED_PAGE		3
+#define MII_MARVELL_WOL_PAGE		17
+#define MII_MARVELL_PHY_PAGE		22
+
+#define MII_PHY_LED_CTRL		16
+#define MII_88E1318S_PHY_LED_TCR	18
+#define MII_88E1318S_PHY_WOL_CTRL	16
+#define MII_M1011_IEVENT		19
+
+#define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE		BIT(7)
+#define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
+#define MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS	BIT(12)
+#define LED2_FORCE_ON					(0x8 << 8)
+#define LEDMASK						GENMASK(11,8)
+
+static struct phy_device *phydev;
+
+static void mvphy_reg_intn(u16 data)
+{
+	int rc =3D 0, saved_page;
+
+	saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
+	if (saved_page < 0)
+		goto err;
+
+	/* Force manual LED2 control to let INTn work */
+	__phy_modify(phydev, MII_PHY_LED_CTRL, LEDMASK, LED2_FORCE_ON);
+
+	/* Set the LED[2]/INTn pin to the required state */
+	__phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
+		     MII_88E1318S_PHY_LED_TCR_FORCE_INT,
+		     MII_88E1318S_PHY_LED_TCR_INTn_ENABLE | data);
+
+	if (!data) {
+		/* Clear interrupts to ensure INTn won't be holded in high state */
+		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_COPPER_PAGE);
+		__phy_read(phydev, MII_M1011_IEVENT);
+
+		/* If WOL was enabled and a magic packet was received before powering
+		 * off, we won't be able to wake up by sending another magic packet.=20
+		 * Clear WOL status.
+		 */
+		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_WOL_PAGE);
+		__phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
+			       MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS);
+	}
+err:
+	rc =3D phy_restore_page(phydev, saved_page, rc);
+	if (rc < 0)
+		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
+}
+
+static int linkstation_reboot_notifier(struct notifier_block *nb,
+				       unsigned long action, void *unused)
+{
+	if (action =3D=3D SYS_RESTART)
+		mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block linkstation_reboot_nb =3D {
+	.notifier_call =3D linkstation_reboot_notifier,
+};
+
+static void linkstation_poweroff(void)
+{
+	unregister_reboot_notifier(&linkstation_reboot_nb);
+	mvphy_reg_intn(0);
+
+	kernel_restart("Power off");
+}
+
+static int linkstation_poweroff_probe(struct platform_device *pdev)
+{
+	struct mii_bus *bus;
+	struct device_node *dn;
+
+	dn =3D of_find_node_by_name(NULL, "mdio");
+	if (!dn)
+		return -ENODEV;
+
+	bus =3D of_mdio_find_bus(dn);
+	of_node_put(dn);
+	if (!bus)
+		return -EPROBE_DEFER;
+
+	phydev =3D phy_find_first(bus);
+	if (!phydev)
+		return -EPROBE_DEFER;
+
+	register_reboot_notifier(&linkstation_reboot_nb);
+	pm_power_off =3D linkstation_poweroff;
+
+	dev_dbg(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
+
+	return 0;
+}
+
+static int linkstation_poweroff_remove(struct platform_device *pdev)
+{
+	pm_power_off =3D NULL;
+	unregister_reboot_notifier(&linkstation_reboot_nb);
+
+	return 0;
+}
+
+static const struct of_device_id ls_poweroff_of_match[] =3D {
+	{ .compatible =3D "linkstation,power-off", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ls_poweroff_of_match);
+
+static struct platform_driver linkstation_poweroff_driver =3D {
+	.probe =3D linkstation_poweroff_probe,
+	.remove =3D linkstation_poweroff_remove,
+	.driver =3D {
+		.name =3D "linkstation_power_off",
+		.of_match_table =3D ls_poweroff_of_match,
+	},
+};
+
+module_platform_driver(linkstation_poweroff_driver);
+
+MODULE_AUTHOR("Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>");
+MODULE_DESCRIPTION("LinkStation power off driver");
+MODULE_LICENSE("GPL v2");
=2D-=20
2.27.0




