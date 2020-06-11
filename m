Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25941F6EBB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFKU3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFKU3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 16:29:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146FC08C5C1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2020 13:29:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so6308362wmi.4
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2020 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lSqyIRu/yzup7X+TlnHDuB0ZLzW3TaybvlPsImWpmN4=;
        b=Z6TDsIuw41U+9143x0cdZhMb+oNEUWHgLHbUwvta0HU09Zdu8MNS+5iC98vahdVNev
         zg+txdTzP6yiuovQzzh6Uk/vzn/LfZCGvxGH4/59UoKlnvGXEvqnH5lhwn5AQb0PjrBE
         nWtkN0n6tjYRtyQVEYHBiNrjfq+OAO+D4xwlXvbONyuvpF7bbWvL++hC5k1/dqBrL+jw
         PbJ7D8oDDVwOpDW9acaOTV1pc6qsHqWEBUqh2ZhyGoY3R/lt6nZMKYgYUlnfxCKEsZSr
         EwMQB3VWW68aGYylBKo+HqydyRNTsXt776JogAw682NCmUb7B+vOW9xD5URzct6yewhK
         sbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lSqyIRu/yzup7X+TlnHDuB0ZLzW3TaybvlPsImWpmN4=;
        b=hOgwhNBTlwB8vOQUYgJhkfsmpf/dm2MIXRXnkU0HDvM7Zcesb6HreGsJE7SNs0Cq5J
         voaWYC6MD30JbkI7K4jmAv6MUqvHhixT2W+R73gcu/58nF7arpr7+X0VOvIdK3Vghmxv
         4uJfDBwWggP8ckkckMINrWoxBh0mVKd/TKDx0w1ibj7zfXdKV48z6uIcWLcGffSr/Evo
         awkLq82G3lszgNg+GDTm8QJAHs2UshGAunUm/IgiMX4bGCw5/UJdoEdl/oRQ6VemHV0d
         9DzqnVhokl3Vq79tG/y+EYIi2YF2q+x7QUgpBq24LKxM5phEZdmU1No9SbL3207rHfZK
         y6uQ==
X-Gm-Message-State: AOAM530SaJFY7+Coz4SAejkAM/7leASvMSKupRpYIVIT6uRXGJ/ORjzV
        IPl5VnBfwK4HjQ9CdHUf9wZS7eAm
X-Google-Smtp-Source: ABdhPJxiWZrcMgc+HHbQ87deUdr6zNraLLM546s/xYQHr/VYmtb/RmqmxerseL8i8NjXn1pBRZAsxw==
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr9701234wme.27.1591907350257;
        Thu, 11 Jun 2020 13:29:10 -0700 (PDT)
Received: from tool.localnet ([213.177.199.127])
        by smtp.googlemail.com with ESMTPSA id d17sm7028538wrg.75.2020.06.11.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 13:29:09 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org
Subject: [PATCH 1/2 v2] power: reset: add driver for LinkStation power off
Date:   Thu, 11 Jun 2020 22:28:47 +0200
Message-ID: <2646704.3vELSAkA81@tool>
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
Changes in v2:
  - The driver is now compatible with the WoL function, the LED2 pin output
    is now used as INTn. Added the required code to make INTn work properly.
  - Code for PHY autodectection deleted, "phy-handle,intn" is now mandatory.
  - Replace a dev_info with a dev_dbg.
  - Use phy_device_free in the driver remove.
  - Cosmetic changes.
=20
 drivers/power/reset/Kconfig                |  11 ++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/linkstation-poweroff.c | 140 +++++++++++++++++++++
 3 files changed, 152 insertions(+)
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
index 0000000000..208318ccc3
=2D-- /dev/null
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -0,0 +1,140 @@
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
+	struct device_node *dn;
+
+	dn =3D of_parse_phandle(pdev->dev.of_node, "phy-handle,intn", 0);
+	if (!dn)
+		return -ENODEV;
+
+	phydev =3D of_phy_find_device(dn);
+	of_node_put(dn);
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
+	phy_device_free(phydev);
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




