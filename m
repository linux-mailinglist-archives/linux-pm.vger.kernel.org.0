Return-Path: <linux-pm+bounces-23691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA69A5839E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D592D7A27B9
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26911C861A;
	Sun,  9 Mar 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aIPfWTaa"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22E1A840D;
	Sun,  9 Mar 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519291; cv=none; b=L70VcqL8GPVilZW1aXJ3cjsY3TYCM0SIM7rE12T8Bxli9C8h7gkr6p2EMl6fpHz0Gz5LmeuWF0W/UKSIQTowhoBkQ/FHh4LA+KjBp75lI5/C/+S8WbMZ1yU6v0fk1oF1zLGbYu7jEnPUmBdf3CPrADhvwP0bnmtVFF4sNatA+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519291; c=relaxed/simple;
	bh=hwbg85IHRmzac4MOiU1b/r7yBMLHOMIeHyC8YX0maYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPJbBzQKb6uBg/XY8f2mnLCnmd2d7jwW2y1H+AH6FWIJ+lh+qSBEtOBRQPypjOlvthVflJ5l/u3r+ikJdE97DwfWzJ1kPQJydt9VycFzlRcsPXZ5OZLcDtIuFP3KJFckEXU+q4E9DytKI9/+XoiWAGBj0hqIVcXbbHmSRsNHQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aIPfWTaa; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 1D4C82E05696;
	Sun,  9 Mar 2025 13:21:25 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519286;
	bh=EbAW66MOShp+FMmH6+3P02El1Ie30xboAe3WC3/AJMs=; h=From:To:Subject;
	b=aIPfWTaaI9j9+VH4LI9SytI3dhe7ae9XHW2mPNom8G+1FtOiBnU/bgZvaAomOlJyq
	 fDRQq8gONGUDOFw9vsSgj6b8NdO0bKQ1STqEbOny1CrzuGrZhlOcBP3MRcRbFJdgAi
	 dfm8Q/HihadmQ06WKwtskwcnBZ06V3pxTwORwZps=
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
Subject: [PATCH v3 04/12] ABI: testing: add tt_toggle and tt_led entries
Date: Sun,  9 Mar 2025 12:21:05 +0100
Message-ID: <20250309112114.1177361-5-lkml@antheas.dev>
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
 <174151928638.28801.5989227754740765426@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

When tt_toggle was introduced, it was not added to the platform sysfs.
Add it, then add documentation for tt_led. Remove the documentation
from the hwmon entry, then update its readme to be current.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-platform-oxp | 29 +++++++++
 Documentation/hwmon/oxpec.rst                | 62 +++++++-------------
 2 files changed, 49 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp

diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
new file mode 100644
index 000000000000..8727d5ecaab5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-oxp
@@ -0,0 +1,29 @@
+What:		/sys/devices/platform/<platform>/tt_toggle
+Date:		Jun 2023
+KernelVersion:	6.5
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Takeover TDP controls from the device. OneXPlayer devices have a
+        turbo button that can be used to switch between two TDP modes
+        (usually 15W and 25W). By setting this attribute to 1, this
+        functionality is disabled, handing TDP control over to (Windows)
+        userspace software and the Turbo button turns into a keyboard
+        shortcut over the AT keyboard of the device. In addition,
+        using this setting is a prerequisite for PWM control for most
+        devices (otherwise it NOOPs).
+
+        This attribute was originally introduced in 6.5, without a
+        corresponding documentation entry.
+
+What:		/sys/devices/platform/<platform>/tt_led
+Date:		Feb 2025
+KernelVersion:	6.15
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Some OneXPlayer devices (e.g., X1 series) feature a little LED
+        nested in the Turbo button. This LED is illuminated when the
+        device is in the higher TDP mode (e.g., 25W). Once tt_toggle
+        is engaged, this LED is left dangling to its last state. This
+        attribute allows userspace to control the LED state manually
+        (either with 1 or 0). Only a subset of devices contain this LED.
+
diff --git a/Documentation/hwmon/oxpec.rst b/Documentation/hwmon/oxpec.rst
index 581c4dafbfa1..0a0a7c5d0263 100644
--- a/Documentation/hwmon/oxpec.rst
+++ b/Documentation/hwmon/oxpec.rst
@@ -1,35 +1,41 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-Kernel driver oxp-sensors
+Kernel driver oxpec
 =========================
 
 Authors:
     - Derek John Clark <derekjohn.clark@gmail.com>
     - Joaquín Ignacio Aramendía <samsagax@gmail.com>
+    - Antheas Kapenekakis <lkml@antheas.dev>
 
 Description:
 ------------
 
-Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide fan
-readings and fan control through their embedded controllers.
+Handheld devices from OneXPlayer and AOKZOE provide fan readings and fan
+control through their embedded controllers, which can be accessed via this
+module. If the device has the platform `tt_toggle` attribute (see
+Documentation/ABI/testing/sysfs-platform-oxp), controlling these attributes
+without having it engaged is undefined behavior.
 
-Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
-handheld devices. AYANEO devices preceding the AIR and OneXPlayer devices
-preceding the Mini A07 are not supportable as the EC model is different
-and do not have manual control capabilities.
-
-Some OneXPlayer and AOKZOE models have a toggle for changing the behaviour
-of the "Turbo/Silent" button of the device. It will change the key event
-that it triggers with a flip of the `tt_toggle` attribute. See below for
-boards that support this function.
+In addition, for legacy reasons, this driver provides hwmon functionality
+to Ayaneo devices, and the OrangePi Neo (AOKZOE is a sister company of
+OneXPlayer and uses the same EC).
 
 Supported devices
 -----------------
 
 Currently the driver supports the following handhelds:
-
  - AOKZOE A1
  - AOKZOE A1 PRO
+ - OneXPlayer 2/2 Pro
+ - OneXPlayer AMD
+ - OneXPlayer mini AMD
+ - OneXPlayer mini AMD PRO
+ - OneXPlayer OneXFly variants
+ - OneXPlayer X1 variants
+
+In addition, until a driver is upstreamed for the following, the driver
+also supports controlling them:
  - AYANEO 2
  - AYANEO 2S
  - AYANEO AIR
@@ -41,29 +47,8 @@ Currently the driver supports the following handhelds:
  - AYANEO Geek
  - AYANEO Geek 1S
  - AYANEO KUN
- - OneXPlayer 2
- - OneXPlayer 2 Pro
- - OneXPlayer AMD
- - OneXPlayer mini AMD
- - OneXPlayer mini AMD PRO
- - OneXPlayer OneXFly
- - OneXPlayer X1 A
- - OneXPlayer X1 i
- - OneXPlayer X1 mini
  - OrangePi NEO-01
 
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
 Sysfs entries
 -------------
 
@@ -79,11 +64,4 @@ pwm1_enable
 pwm1
   Read Write. Read this attribute to see current duty cycle in the range [0-255].
   When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
-  to set fan speed.
-
-tt_toggle
-  Read Write. Read this attribute to check the status of the turbo/silent
-  button behaviour function. Write "1" to activate the switch and "0" to
-  deactivate it. The specific keycodes and behaviour is specific to the device
-  both with this function on and off. This attribute is attached to the platform
-  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform/tt_toggle)
+  to set fan speed.
\ No newline at end of file
-- 
2.48.1


