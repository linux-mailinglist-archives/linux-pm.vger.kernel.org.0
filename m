Return-Path: <linux-pm+bounces-23689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF5A58394
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0461896073
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9021C6FE7;
	Sun,  9 Mar 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="d7scwS4L"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26797199949;
	Sun,  9 Mar 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519291; cv=none; b=bsnqyti/hsVzqvlZFXd7WRV8xz4yLHDCEMKqWE1y3uYlntqQ+P46xZjE7I4Pdkf4UyIA9VByvxFHwhL+whUU69UJTW3pEX0VSRIHH9jbIXd1cbglhru1R88oTWr8BRyhkZY4kn52Fkm76jPQbguKHKHeTSm0u5nQEs6QRdgYwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519291; c=relaxed/simple;
	bh=DN4lPGzRvJ5WNcNqzi6UYhqtxe0UJP4nUvlWxCQtf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr0Zimw9LwtWWgPglJPbUbx4hcvWqylHXt8lCSInUjKNgikZlxb5YiXzz7Wfx0szgZF+xhLwucewO4QvqQb9FjTpPH8w/l64lQtPVC9YeAjLNEs8QSNc+2HQRLrukPOVcyrz1xQnfQ4cNsOpmsnHVVnyAuKnFSmu+3RhA1q//6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=d7scwS4L; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 36E062E02CAB;
	Sun,  9 Mar 2025 13:21:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519284;
	bh=RYIh6+vPCJzjj/Auw7QFSfgfIxTo9QzItGSvqYtET6k=; h=From:To:Subject;
	b=d7scwS4LNmjcEsobsVgI87jZPSFPg3SGtmt/l9jpPi2maikF5dzUywJEgxgvjoazU
	 n0NyzwtHcauR9o938tTSQ3ax5k0RZ3ZFSxfq1s1qIeYbEIIW0Phrsi1CWjkgWcAAE/
	 j9a8GOcmt9CdBQUEUYphAK04sUFTWdm9w+H7Mfg8=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 03/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
Date: Sun,  9 Mar 2025 12:21:04 +0100
Message-ID: <20250309112114.1177361-4-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309112114.1177361-1-lkml@antheas.dev>
References: <20250309112114.1177361-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151928355.28721.4095908493012173453@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The EC of OneXPlayer devices used to only control the fan.
This is no longer the case, with the EC of OneXPlayer gaining
additional functionality (turbo button, turbo led, battery controls).

As it will be beneficial from a complexity perspective
to retain this driver as a single unit, move it out
of hwmon, and into platform/x86.

While at it, add myself to the maintainer's file.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/hwmon/index.rst                         |  2 +-
 Documentation/hwmon/{oxp-sensors.rst => oxpec.rst}    |  0
 MAINTAINERS                                           |  7 ++++---
 drivers/hwmon/Kconfig                                 | 11 -----------
 drivers/hwmon/Makefile                                |  1 -
 drivers/platform/x86/Kconfig                          | 11 +++++++++++
 drivers/platform/x86/Makefile                         |  3 +++
 drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} | 10 ++++------
 8 files changed, 23 insertions(+), 22 deletions(-)
 rename Documentation/hwmon/{oxp-sensors.rst => oxpec.rst} (100%)
 rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (98%)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 874f8fd26325..dd7a54d5f281 100644
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
diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxpec.rst
similarity index 100%
rename from Documentation/hwmon/oxp-sensors.rst
rename to Documentation/hwmon/oxpec.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 0248c9eb39d6..a11d346a458b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17641,12 +17641,13 @@ S:	Maintained
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
index 4cbaba15d86e..09f7aed96d15 100644
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
index b7ef0f0562d3..0edb08824b17 100644
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
index 0258dd879d64..4531b20c6b30 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1186,6 +1186,17 @@ config SEL3350_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called sel3350-platform.
 
+config OXP_EC
+	tristate "OneXPlayer EC platform control"
+	depends on ACPI_EC
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
index e1b142947067..f64a191c1162 100644
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
index f7a64fbc8f33..dc3a0871809c 100644
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


