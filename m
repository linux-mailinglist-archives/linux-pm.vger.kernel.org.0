Return-Path: <linux-pm+bounces-24294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00AA696EF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E8E7ABDC6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9C020B1F4;
	Wed, 19 Mar 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Rj7kLLLJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C81DDC0F;
	Wed, 19 Mar 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406933; cv=none; b=WmzMpScB3lh/wIQi4lQTYZz0ZWvELX2EAKmHoEPWc4wvINdpknNU3+9P2qsGg46Cgb3FBGKRRVGRp+h4d0HlRMbE5bcGc2BjyfVntidDj9g4pJURtHomC0FXYU9ypZ37djllsRNoXYSH03ueEEB6S9pEv0tZkt4LdnH7GtiFcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406933; c=relaxed/simple;
	bh=OhVEUcEzjbQVZ0w91N9nYEWsSxN9XG5JPoAdXtg3MfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlalkuHeNS6T5ivJEAQOfVwOJnR9O8o4wRi6HjvhFjzacxqW0muC/2o11NBJIxQB8D15DS/aXuK3r6qg8NBeSudfjQaryg1efttjEKyVaCCKzK3Mg+asSNxN6Yb6qx8XftXV+bsAoA282FCPRpiBn/o/uTtAxbrX34Fp+GbhuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Rj7kLLLJ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 79D2D2E09316;
	Wed, 19 Mar 2025 19:55:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406924;
	bh=UQJDxs1mtnDumBb2isG/FnxXPecbW6NXnOagBKtZQ44=; h=From:To:Subject;
	b=Rj7kLLLJZLxF8L2jPb2KFn13bhp30piKFL2XYeatkUJtEYr4JDHDwqzpBf7jEjclw
	 uKQl7fA7wM2iJLbDX7BiPu4QS+4BXR8O7IlM68OYwzZdl2PoZIm0PHLGsInmqLktYk
	 w8XAwf9ZbBqFoTxP7eK6F0DNYBbd2tOj40jhrsGo=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v6 03/14] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
Date: Wed, 19 Mar 2025 18:54:58 +0100
Message-ID: <20250319175512.27059-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319175512.27059-1-lkml@antheas.dev>
References: <20250319175512.27059-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240692411.24490.10363077083874685269@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The EC of OneXPlayer devices used to only control the fan.
This is no longer the case, with the EC of OneXPlayer gaining
additional functionality (turbo button, turbo led, battery controls).

As it will be beneficial from a complexity perspective
to retain this driver as a single unit, move it out
of hwmon, and into platform/x86. Also, remove the
hwmon documentation to avoid it becoming stale.

While at it, add myself to the maintainer's file.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/hwmon/index.rst                 |  2 +-
 Documentation/hwmon/oxp-sensors.rst           | 89 -------------------
 MAINTAINERS                                   |  7 +-
 drivers/hwmon/Kconfig                         | 11 ---
 drivers/hwmon/Makefile                        |  1 -
 drivers/platform/x86/Kconfig                  | 12 +++
 drivers/platform/x86/Makefile                 |  3 +
 .../oxp-sensors.c => platform/x86/oxpec.c}    | 10 +--
 8 files changed, 24 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/hwmon/oxp-sensors.rst
 rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (98%)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 874f8fd263252..dd7a54d5f2816 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -186,7 +186,7 @@ Hardware Monitoring Kernel Drivers
    nzxt-kraken3
    nzxt-smart2
    occ
-   oxp-sensors
+   oxpec
    pc87360
    pc87427
    pcf8591
diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
deleted file mode 100644
index 581c4dafbfa13..0000000000000
--- a/Documentation/hwmon/oxp-sensors.rst
+++ /dev/null
@@ -1,89 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-
-Kernel driver oxp-sensors
-=========================
-
-Authors:
-    - Derek John Clark <derekjohn.clark@gmail.com>
-    - Joaquín Ignacio Aramendía <samsagax@gmail.com>
-
-Description:
-------------
-
-Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide fan
-readings and fan control through their embedded controllers.
-
-Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
-handheld devices. AYANEO devices preceding the AIR and OneXPlayer devices
-preceding the Mini A07 are not supportable as the EC model is different
-and do not have manual control capabilities.
-
-Some OneXPlayer and AOKZOE models have a toggle for changing the behaviour
-of the "Turbo/Silent" button of the device. It will change the key event
-that it triggers with a flip of the `tt_toggle` attribute. See below for
-boards that support this function.
-
-Supported devices
------------------
-
-Currently the driver supports the following handhelds:
-
- - AOKZOE A1
- - AOKZOE A1 PRO
- - AYANEO 2
- - AYANEO 2S
- - AYANEO AIR
- - AYANEO AIR 1S
- - AYANEO AIR Plus (Mendocino)
- - AYANEO AIR Pro
- - AYANEO Flip DS
- - AYANEO Flip KB
- - AYANEO Geek
- - AYANEO Geek 1S
- - AYANEO KUN
- - OneXPlayer 2
- - OneXPlayer 2 Pro
- - OneXPlayer AMD
- - OneXPlayer mini AMD
- - OneXPlayer mini AMD PRO
- - OneXPlayer OneXFly
- - OneXPlayer X1 A
- - OneXPlayer X1 i
- - OneXPlayer X1 mini
- - OrangePi NEO-01
-
-"Turbo/Silent" button behaviour toggle is only supported on:
- - AOK ZOE A1
- - AOK ZOE A1 PRO
- - OneXPlayer 2
- - OneXPlayer 2 Pro
- - OneXPlayer mini AMD (only with updated alpha BIOS)
- - OneXPlayer mini AMD PRO
- - OneXPlayer OneXFly
- - OneXPlayer X1 A
- - OneXPlayer X1 i
- - OneXPlayer X1 mini
-
-Sysfs entries
--------------
-
-The following attributes are supported:
-
-fan1_input
-  Read Only. Reads current fan RPM.
-
-pwm1_enable
-  Read Write. Enable manual fan control. Write "1" to set to manual, write "0"
-  to let the EC control de fan speed. Read this attribute to see current status.
-
-pwm1
-  Read Write. Read this attribute to see current duty cycle in the range [0-255].
-  When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
-  to set fan speed.
-
-tt_toggle
-  Read Write. Read this attribute to check the status of the turbo/silent
-  button behaviour function. Write "1" to activate the switch and "0" to
-  deactivate it. The specific keycodes and behaviour is specific to the device
-  both with this function on and off. This attribute is attached to the platform
-  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform/tt_toggle)
diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a5089..20720f92e4a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17656,12 +17656,13 @@ S:	Maintained
 F:	drivers/mtd/nand/onenand/
 F:	include/linux/mtd/onenand*.h
 
-ONEXPLAYER FAN DRIVER
+ONEXPLAYER PLATFORM EC DRIVER
+M:	Antheas Kapenekakis <lkml@antheas.dev>
 M:	Derek John Clark <derekjohn.clark@gmail.com>
 M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
-L:	linux-hwmon@vger.kernel.org
+L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/hwmon/oxp-sensors.c
+F:	drivers/platform/x86/oxpec.c
 
 ONIE TLV NVMEM LAYOUT DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4cbaba15d86ef..09f7aed96d15e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
 
 source "drivers/hwmon/occ/Kconfig"
 
-config SENSORS_OXP
-	tristate "OneXPlayer EC fan control"
-	depends on ACPI_EC
-	depends on X86
-	help
-		If you say yes here you get support for fan readings and control over
-		OneXPlayer handheld devices. Only OneXPlayer mini AMD handheld variant
-		boards are supported.
-
-		Can also be built as a module. In that case it will be called oxp-sensors.
-
 config SENSORS_PCF8591
 	tristate "Philips PCF8591 ADC/DAC"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b7ef0f0562d37..0edb08824b178 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) += nzxt-kraken2.o
 obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) += nzxt-kraken3.o
 obj-$(CONFIG_SENSORS_NZXT_SMART2) += nzxt-smart2.o
-obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0258dd879d64b..82cfc76bc5c9f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1186,6 +1186,18 @@ config SEL3350_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called sel3350-platform.
 
+config OXP_EC
+	tristate "OneXPlayer EC platform control"
+	depends on ACPI_EC
+	depends on HWMON
+	depends on X86
+	help
+		Enables support for the platform EC of OneXPlayer and AOKZOE
+		handheld devices. This includes fan speed, fan controls, and
+		disabling the default TDP behavior of the device. Due to legacy
+		reasons, this driver also provides hwmon functionality to Ayaneo
+		devices and the OrangePi Neo.
+
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b1429470674..f64a191c1162e 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
 
 # SEL
 obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
+
+# OneXPlayer
+obj-$(CONFIG_OXP_EC)		+= oxpec.o
\ No newline at end of file
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
similarity index 98%
rename from drivers/hwmon/oxp-sensors.c
rename to drivers/platform/x86/oxpec.c
index f7a64fbc8f33e..dc3a0871809cd 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/platform/x86/oxpec.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handhelds
- * that expose fan reading and control via hwmon sysfs.
- *
- * Old OXP boards have the same DMI strings and they are told apart by
- * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
- * supported.
+ * Platform driver for OneXPlayer and AOKZOE devices. For the time being,
+ * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
+ * hwmon sysfs.
  *
  * Fan control is provided via pwm interface in the range [0-255].
  * Old AMD boards use [0-100] as range in the EC, the written value is
@@ -16,6 +13,7 @@
  *
  * Copyright (C) 2022 Joaquín I. Aramendía <samsagax@gmail.com>
  * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
+ * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
  */
 
 #include <linux/acpi.h>
-- 
2.48.1


