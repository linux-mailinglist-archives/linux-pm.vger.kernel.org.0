Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E6813C2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHEH6i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:58:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEH6h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 03:58:37 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLAF0-1hcKXl0u5i-00IAXS; Mon, 05 Aug 2019 09:58:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nandor Han <nandor.han@vaisala.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: make reboot-mode user selectable
Date:   Mon,  5 Aug 2019 09:57:15 +0200
Message-Id: <20190805075812.1056069-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eB6KAa6NN+juzvqJXgzHBfsfG/scGuoWUNe/iXcQ4WsqcfrIT4c
 abT1fGHqLKnDU5AgeZfPXwiEpachq2sxcC1bcghQEJVDXahbDdkuKpdlceGWMvv2oLT517f
 1AhDr+hSSSGpK5xTRq7TXJuaN+Af28kshLMnVtDBs+9CuaXJTVrcVo3pFjPnS0NokZ11J0a
 YJROpXnDR2Y39WdDhBsHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNJ49rDmRec=:vWYI6b80lwQs6h4UnOE/YK
 Y+ceupVhOpprNmKpqD8SEcdR/9rX4DtZrdgekpLYIKV1PrgXJn9mmmOzSdWlNhujkTCFvmPu4
 msJpr9EICT9JyMGOwBRfVZQEK+OiGDYli9CF9X8mzSnXFU1Zdm0Lbfr5nfEi1RlUVBqIhhign
 qSJKFtNuZIqzS+J3NwRiyhFmHPdNNlHAS1TngkYd4rOaPlPN9udRhkeSVQYcbZ5UOKUhM8zRw
 CiNRAiASlTJhkdf3SD7dd8HHY4qi9TgUaHuGZ162ELSL3lBKP9pIAXAHnagZRX+A5UZQJZPjp
 WGFcOhF8GAAo0wEWeKqTTNXj19b7f2iBprSaYwBjZDMlSPBTHDsaU1G1NuoYS+hl+G74CJc7U
 einXiunzhprAU95Wi9wfLGmwuDLE4/t8Bqu46aAvnlfamSutlpy4ZbyQFoIiFCvpQbt0vdrDZ
 tvsI1B5pDfz3o98w8Asv3sz7jycXvKevk7ExEMoRJJ/SIPgLYaCtCuMPAXncFGOJrKdMFU/gs
 +6U9imBonMlivUCizLAreqCKA19lO/5tgmnK+feOjUCRvpUd23Wb1dTm6LW1UMl337Sj5hny0
 47fZdXMq6R+xvWXWv42BuSynTY4t8fjcqVpeD1b4BC7kFS1UMOdRCajQQzG8Sb7cPnPxtflZU
 wXqrbyMaCNr4KzcVSlfohsZjbzKxV8KfYmADtDpZG+Wm+wuxA64nGgsCO+S7EFYdHwZPAUZN7
 Vp2SauL0pj1f9+4pN9CX/IGuSoCFB0ALAHu0SQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nandor Han points out that there might be drivers that can use
the reboot-mode interfaces but might also be usable on configurations
without device tree.

Move the 'depends on OF' dependency into CONFIG_REBOOT_MODE since
that is the only thing that truely has a compile-time dependency
on CONFIG_OF, and make it user visible to make it possible to
disable it.

The drivers that used to 'select REBOOT_MODE' of course now have to
use 'depends on REBOOT_MODE instead'. With this, we can soften the
dependency and allow compile-testing the three front-end drivers
on non-OF platforms.

Note: anyone who was using a reboot mode driver in their kernel
configuration now has to enable CONFIG_REBOOT_MODE as well.

Suggested-by: Nandor Han <nandor.han@vaisala.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Nandor, this is so far untested, could you make sure this
works in all configurations and forward it along with the
bugfix?

Sebastian, I'm not convinced this is a good idea, just sending
it as Nandor requested. Please decide for yourself.
---
 arch/arm/configs/davinci_all_defconfig |  1 +
 arch/arm64/configs/defconfig           |  1 +
 drivers/power/reset/Kconfig            | 22 +++++++++++++---------
 include/linux/reboot-mode.h            | 20 ++++++++++++++++++++
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b34970ce6b31..ebf506c01899 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -139,6 +139,7 @@ CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_RESET_CONTROLLER=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_REBOOT_MODE=m
 CONFIG_SYSCON_REBOOT_MODE=m
 CONFIG_BATTERY_LEGO_EV3=m
 CONFIG_WATCHDOG=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..bb7d7bec1413 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -419,6 +419,7 @@ CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_REBOOT_MODE=y
 CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_SBS=m
 CONFIG_BATTERY_BQ27XXX=y
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a564237278ff..997323d443f5 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -9,6 +9,13 @@ menuconfig POWER_RESET
 
 if POWER_RESET
 
+config REBOOT_MODE
+	tristate "Pass reboot-mode to firmware"
+	depends on OF
+	help
+	  Some drivers allow setting the reboot mode through a platform
+	  interface that the boot firmware can read.
+
 config POWER_RESET_AS3722
 	bool "ams AS3722 power-off driver"
 	depends on MFD_AS3722
@@ -107,9 +114,9 @@ config POWER_RESET_MSM
 
 config POWER_RESET_QCOM_PON
 	tristate "Qualcomm power-on driver"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on MFD_SPMI_PMIC
-	select REBOOT_MODE
+	depends on REBOOT_MODE || !REBOOT_MODE
 	help
 	  Power On support for Qualcomm boards.
 	  If you have a Qualcomm platform and need support for
@@ -223,14 +230,11 @@ config POWER_RESET_ZX
 	help
 	  Reboot support for ZTE SoCs.
 
-config REBOOT_MODE
-	tristate
-
 config SYSCON_REBOOT_MODE
 	tristate "Generic SYSCON regmap reboot mode driver"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on MFD_SYSCON
-	select REBOOT_MODE
+	depends on REBOOT_MODE || !REBOOT_MODE
 	help
 	  Say y here will enable reboot mode driver. This will
 	  get reboot mode arguments and store it in SYSCON mapped
@@ -248,8 +252,8 @@ config POWER_RESET_SC27XX
 
 config NVMEM_REBOOT_MODE
 	tristate "Generic NVMEM reboot mode driver"
-	depends on OF
-	select REBOOT_MODE
+	depends on OF || COMPILE_TEST
+	depends on REBOOT_MODE || !REBOOT_MODE
 	help
 	  Say y here will enable reboot mode driver. This will
 	  get reboot mode arguments and store it in a NVMEM cell,
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d6..bd002060e3d0 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -9,11 +9,31 @@ struct reboot_mode_driver {
 	struct notifier_block reboot_notifier;
 };
 
+#if IS_ENABLED(CONFIG_REBOOT_MODE)
 int reboot_mode_register(struct reboot_mode_driver *reboot);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);
 void devm_reboot_mode_unregister(struct device *dev,
 				 struct reboot_mode_driver *reboot);
+#else
+static inline int reboot_mode_register(struct reboot_mode_driver *reboot)
+{
+	return 0;
+}
+static inline int reboot_mode_unregister(struct reboot_mode_driver *reboot)
+{
+	return 0;
+}
+static inline int devm_reboot_mode_register(struct device *dev,
+			      struct reboot_mode_driver *reboot)
+{
+	return 0;
+}
+static inline void devm_reboot_mode_unregister(struct device *dev,
+				 struct reboot_mode_driver *reboot)
+{
+}
+#endif
 
 #endif
-- 
2.20.0

