Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF51B82F3
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 03:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgDYBAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDYBAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 21:00:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC998C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 18:00:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so11205395wme.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zm2y20pux0HBQzidL4UY4mhjjf+ysfTwr1Wf1GSZ1Mg=;
        b=KzgWzskIOgonNN+pLen6LXM+Ie56hNIq4dkkPk+TRPnRAJRsMnPUDqLMGecM3I5kdt
         0hDpuPZnydLz6MjPAp/JJu7KBJ4zuPDSmkA0qzI/K2xZxGN6N+uDPTBueo++1epUEL/N
         HQC3LykXqzFtVUHvwcg5fdOTGWFbhKuUHklts+/G/hwd3I53dmI32UO4KjYvjZLN0mte
         6AeyCzKyQ/h4CIosBvdcLL7OUEazgvazHE7XIAQlGkI9HiZENaJm5BWTWhYAnWSy5Z0X
         5a3e8T+sxXGdjjYRJMwSKVIE9r1Yy0UuYq0CldENCdrWOUg5uYS9rM2NSTHeyuJRboQA
         CeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zm2y20pux0HBQzidL4UY4mhjjf+ysfTwr1Wf1GSZ1Mg=;
        b=rtRjc7vp93myugtRQuvk9aEJvi7e4335HvoLKig2MKQFtxO1bpam5AJBDyrtij1UVs
         RTy4YGMqCrWcx44ax9on/ptk6009ffKv0ZvwYaD/ls5mlkl+nZGsCgE1jM1eaEpEUt/Q
         B/vrjc0yWwvT40JcnAat5MokkoH3UWUvUM8toIY+M+c+DYPk59spxbhuyIFeOG69b6gW
         +5a6WLpzIyTXIoQ+DydPcI4Kt7KKSx4UX9GHEK1EqxaQ3uqxTzMsS68YxDfvNxrFzWM2
         maf1RYNgWn63Ygrzc+8CfKN/QP1GS/1voa3FtH/zHDqCsPHpxNkivluIxAlIW/WT5pXr
         l7Aw==
X-Gm-Message-State: AGi0PuZgvUwgFCzpC0C5b4ddd5t/2Hyymbayb9KRyGvE0SEoC5xA8wcn
        dl5X0RklPrrPw3sfGRc9cmM2gGYM
X-Google-Smtp-Source: APiQypKxmwHf/AYb19VpSxGDG2GaJK+69wcxnCnhgGp1BOEDiy/dDJJaTf7UVEf0klT5kd1+WuDRUw==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr13205996wma.138.1587776448353;
        Fri, 24 Apr 2020 18:00:48 -0700 (PDT)
Received: from tool.localnet ([213.177.195.242])
        by smtp.googlemail.com with ESMTPSA id i19sm11189938wrb.16.2020.04.24.18.00.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 18:00:47 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power:reset: add driver for LinkStation power off
Date:   Sat, 25 Apr 2020 03:00:43 +0200
Message-ID: <8730960.DhLy2TFWpf@tool>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some Buffalo LinkStations perform the power off operation, at restart
time, depending on the state of an output pin (LED) at the ethernet PHY.

The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
and other models. Without it, the board remains forever halted if a=20
power off command is executed, unless the PSU is disconnected and
connected again.

Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
Reviewed-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
=2D--
 drivers/power/reset/Kconfig                |  10 ++
 drivers/power/reset/Makefile               |   1 +
 drivers/power/reset/linkstation-poweroff.c | 117 +++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/power/reset/linkstation-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8903803020..de948835f8 100644
=2D-- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -203,6 +203,16 @@ config POWER_RESET_KEYSTONE
 	help
 	  Reboot support for the KEYSTONE SoCs.
=20
+config POWER_RESET_LINKSTATION
+	tristate "Buffalo LinkStation power-off driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF_MDIO && PHYLIB
+	help
+	  Some Buffalo LinkStations use a LED output at the ethernet PHY
+	  to inform the board that a power off operation must be performed=20
+	  after restarting. This driver sets the LED to the proper state
+	  for restarting or powering off.
+
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index da37f8b851..a8c83d2470 100644
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
 obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/res=
et/linkstation-poweroff.c
new file mode 100644
index 0000000000..b5a4cc2c2b
=2D-- /dev/null
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -0,0 +1,117 @@
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
+#define MII_MARVELL_LED_PAGE	3
+#define MII_PHY_LED_CTRL	16
+
+#define LED2_OFF		(0x8 << 8)
+#define LED2_ON			(0x9 << 8)
+#define LEDMASK			GENMASK(11,8)
+
+static struct phy_device *phydev;
+
+static void mvphy_reg_led(u16 data)
+{
+	int rc;
+	rc =3D phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
+			      MII_PHY_LED_CTRL, LEDMASK, data);
+	if (rc < 0)
+		dev_err(&phydev->mdio.dev,
+			"LED2 write register failed, %d\n", rc);
+}
+
+static int linkstation_reboot_notifier(struct notifier_block *nb,
+				       unsigned long action, void *unused)
+{
+	if (action =3D=3D SYS_RESTART)
+		mvphy_reg_led(LED2_ON);
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
+	mvphy_reg_led(LED2_OFF);
+
+	kernel_restart("Power off");
+}
+
+static int linkstation_poweroff_probe(struct platform_device *pdev)
+{
+	struct mii_bus *bus;
+	struct device_node *dn;
+
+	dn =3D of_parse_phandle(pdev->dev.of_node, "phy-handle,led", 0);
+
+	if (dn) {
+		phydev =3D of_phy_find_device(dn);
+		of_node_put(dn);
+	} else {
+		dn =3D of_find_node_by_name(NULL, "mdio");
+		if (!dn)
+			return -ENODEV;
+
+		bus =3D of_mdio_find_bus(dn);
+		of_node_put(dn);
+		if (!bus)
+			return -EPROBE_DEFER;
+
+		phydev =3D phy_find_first(bus);
+	}
+
+	if (!phydev)
+		return -ENODEV;
+
+	register_reboot_notifier(&linkstation_reboot_nb);
+	pm_power_off =3D linkstation_poweroff;
+
+	dev_info(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
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
2.26.2




