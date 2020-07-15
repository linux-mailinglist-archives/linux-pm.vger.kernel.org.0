Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D987220E45
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgGONgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbgGONgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:36:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1CC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 06:36:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so5898714wmf.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TptDAznf4LAdO/qJbZmITZHyExHcasD1HK6k8a7L6rM=;
        b=cbKZGkVN0yH3yYe+hYZpnM6r1wBD80kyvEs9GY41iaDnn2vJxE+FqgsxuVUKWNuWCT
         +nsvauL3YYe315ec2U3XqaaICDsOfCItlqWDARA77FO98N1WLyH6p2/amEdQJ2v2HfJY
         6AMpEfDdKjIS1Q3ybDjtPhcEM69W2lBfwBKB3v5NH2Jlx4cGvKivyE3CZaYlp2GrsY2A
         OVe76+p6U9NomBZv0N1keCo3OuUn7vustUefq4YgsFGBU9e11BGQ+ochdgLvvMNme+tf
         kjLiDjMS/2hDJnkJGLowpD/yeSwFujWMyyw54XHY3SgeXUuwxC7wohw8BbT1IQHDPwpp
         FWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TptDAznf4LAdO/qJbZmITZHyExHcasD1HK6k8a7L6rM=;
        b=LfwxqVpmtBvZkQ1j6LAzEX24fC5lHuJKzkqxMhjX1AkIYDR5zXh6jA0Kq/MZNlamz1
         dEZ3Q5MMiwcEuxKZLeIc18+SHUIctA3e1vfLrjEaJ0bUzuuCp98vTu/8TZsEaDnH6LOm
         ODDcbI1L+V5YHTB29yyshVlHYiTPw5nbEgR3vow4DmrKv5EhI1AYxL5gXFXwjDn+wFho
         +h0SWkHptgRHtF3mncaklke3UPONKe3vGKyvQKmKjQPcgo0s2q+1ID5wChlXkAO9q9JQ
         0w7P5+y7R+JwrwT//jRj6jR7pchYFVlH9q7S6M3sD+tiiMe5/ntls48jv8BL/lLOODBp
         hgUQ==
X-Gm-Message-State: AOAM532JTwfbunamfwvaZDxcxWJfnaGfbTImhL3McRL4h17PKZr3vO1q
        fGUa/FNjaoDr/RQ4nElGadZEPzic
X-Google-Smtp-Source: ABdhPJx+ofcFTaO4oz6ixDGX7mlWm2bhZrclEJcporXpulbfnGlo+W8gZ4yajCeoPfN0FHquPkYxSg==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr9145053wmk.171.1594820173667;
        Wed, 15 Jul 2020 06:36:13 -0700 (PDT)
Received: from tool.localnet ([213.177.199.139])
        by smtp.googlemail.com with ESMTPSA id d81sm12308699wmc.0.2020.07.15.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:36:12 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org
Subject: [PATCH v4] power: reset: add driver for LinkStation power off
Date:   Wed, 15 Jul 2020 15:35:14 +0200
Message-ID: <2534992.hIiKHhy4eC@tool>
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
Changes in v4:
  - Deleted the power-off binding as suggested by Rob Herring. Therefore
    the binding patch isn't required. Now the device detection is made
    using the root node compatible string.
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
 drivers/power/reset/linkstation-poweroff.c | 136 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/power/reset/linkstation-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f07b982c8d..0a1fb5c74f 100644
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
+	  Say Y here if you have a Buffalo LinkStation LS421D/E.
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
index 0000000000..1d1113d98c
=2D-- /dev/null
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -0,0 +1,136 @@
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
+static const struct of_device_id ls_poweroff_of_match[] =3D {
+	{ .compatible =3D "buffalo,ls421d" },
+	{ .compatible =3D "buffalo,ls421de" },
+	{ },
+};
+
+static int __init linkstation_poweroff_init(void)
+{
+	struct mii_bus *bus;
+	struct device_node *dn;
+
+	dn =3D of_find_matching_node(NULL, ls_poweroff_of_match);
+	if (!dn)
+		return -ENODEV;
+	of_node_put(dn);
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
+	return 0;
+}
+
+static void __exit linkstation_poweroff_exit(void)
+{
+	pm_power_off =3D NULL;
+	unregister_reboot_notifier(&linkstation_reboot_nb);
+}
+
+module_init(linkstation_poweroff_init);
+module_exit(linkstation_poweroff_exit);
+
+MODULE_AUTHOR("Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>");
+MODULE_DESCRIPTION("LinkStation power off driver");
+MODULE_LICENSE("GPL v2");
=2D-=20
2.27.0




