Return-Path: <linux-pm+bounces-43818-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DjID8HaqmkZXwEAu9opvQ
	(envelope-from <linux-pm+bounces-43818-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:46:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2522204D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB36431B3244
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAF230FF21;
	Fri,  6 Mar 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FELEcyyd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AB30CDA2
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804064; cv=none; b=Yf11bnn4SYRuNaMO28BtcLQRG3c78eyUSOFuY0o8r3LeGhirsObqNN6Wl+XA44LABYhWEyUzkchclOEsAdcD4gE0+Ebhr0SXMXR2ILsIxjzgzTQxL7TgHBkw+1WfROnNDmIkYZI964PJV9QV3mJAjLUwSCv1zlqL4zEbKolYza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804064; c=relaxed/simple;
	bh=Jm6xkgQkhTauY/6huIfAGL5IdmRvIUPY0QMbo1MQuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du8wwGRFf9WUIVhdfT3dCCT0YTovS5XzneOlXYps0XYyWq+RVjCF57fUv0/ghwZBirCMzqVMQxHTdnIyyLj80oodisFIBf1poctG34v8uXzxpdokHcADyVTMd3p3/Esjxh4Yi4UdOXOMIydQ/nuXmInWA5fUsHZpewe9b0+08eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FELEcyyd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480706554beso100655395e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772804060; x=1773408860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4R+Kz/zRwSGSikjk1m7gnjz9E1LkKFiNKgW8Ej6ySs=;
        b=FELEcyydz708d+ZiM6Xuych8ukXM32xzqtII1uz3knNMeTFICU0DzIqiZRK6z7geXM
         8tBnkmkOa9x9tvQoiaFD+qawOYalqDaz+zbvN6CfhaNsR/zztyQnWUtaa46yqOg7IPRk
         1WMsH3D6N4lFlsC+fFGmUupadngUIkjOsQcoEQF2t8MImBt2I2XVLFbie2ur5txz4XUH
         DoDi6emvg+iYbXsARWsqqN8fiUhNKsMNkvhL4rwm6VvcjcIOSJrWEy1nce7WfSgDyiFP
         9827n7LIxLSAXSI/6LVIQXocN7UyPp7Mhqb7n9+nJ6Ioxmcm1PVHRhPOCuo0KocHgA0Y
         satg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804060; x=1773408860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4R+Kz/zRwSGSikjk1m7gnjz9E1LkKFiNKgW8Ej6ySs=;
        b=rmBIGSdW8EjvprrcL8Hc0QlF1ySfVnvC4urf+Sf8XjTMDv3H1PA3lQPimYfR3wXvwF
         b9nUUGySjzooy9mpfgICK5TQ5zVimcI5yMraabovq8xLw9prskngWcH4bjcdJoMrkqV5
         hsV0CjcCKFUlHO+tGew0KAY6JqKJKWzhPYbIVIk9K4l26j0Mtlc69HxU8MfjlOatqDID
         O3QoDZ2cP3IxIoXyIbeRWWO3qyO6Wt822x/sC3mjopf2XSkogJo7aNC1yD5bUeuTI9d2
         Lvk6+06IUW6txP9cywLX4z7bHKGwXwZhiF1iTkRA2+HQ30FBkX/g3Y9dlzqKXyW6ee3m
         GaQw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2MGkhnX0yq2NGbd3q59rdhfPGT15GgJh3d8ucbq98CF8KnlD7XO0HXA3hdu0u9DPJOOTlHPryQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0jNmp3y65XsVRo9he7+c4SJXeMh/JBKt9YGfz6zmDVs2GWsa
	B8a4iZj2CHDc+5oi23c0fFMSzSqrAizgVuKfOP4GT5wSewX+nKtiDlUTRhH6gQ==
X-Gm-Gg: ATEYQzzoYuGJVIJhy9vd0pY9FCzcY9WF35Ny3AqH6XCf0MK5q9gJSj9OUM/LRbiIu1q
	RLRa2vENbtTTPDLIq3arZfvFmiBC1kIwamxBBBwC228o3UO9qkp/6H/s/7sldPwYdM1apvygXTN
	WTvpEnnPLcpAMZ7QKk3FMXi0zH+v86a3Mkla+Ka6VRLwy1W0BuqJi3Z6LjG4nOk3eOX07sOP0it
	p+q9Ve5RNFmHxjkM9AfdjSJHxizNRMawrTYkyjoX9EphI+rtdTL/GYw1Tl5ZzDkFbyWe1FBHBJ7
	ox2bOUeEfzBh0IV6jx6YO7/hLVK+jBxhZPJJ8pxBjY7OXmRSK67vHrLY6soCY2rfzY6mFvLmMcl
	fGoAeaBtgtk3ZN05MBenCEMB9fg2t4/20DRKpE7G9XCFh20FK1x8AlJa0GFqTm5Skisj7FZWEUV
	dnlV6I0OYYKpMJ
X-Received: by 2002:a05:600c:1411:b0:485:2b50:ef0e with SMTP id 5b1f17b1804b1-4852b50f403mr303765e9.22.1772804059909;
        Fri, 06 Mar 2026 05:34:19 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm80856735e9.4.2026.03.06.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:34:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 4/6] dt-bindings: mfd: max77620: convert to DT schema
Date: Fri,  6 Mar 2026 15:33:49 +0200
Message-ID: <20260306133351.31589-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306133351.31589-1-clamor95@gmail.com>
References: <20260306133351.31589-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ADB2522204D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43818-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,3c:email,7000d000:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert max77620 devicetree bindings from TXT to YAML format. This patch
does not change any functionality; the bindings remain the same. The
thermal bindings are incorporated into the binding.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/mfd/max77620.txt      | 162 -------
 .../bindings/mfd/maxim,max77620.yaml          | 422 ++++++++++++++++++
 .../bindings/thermal/max77620_thermal.txt     |  70 ---
 3 files changed, 422 insertions(+), 232 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
deleted file mode 100644
index 5a642a51d58e..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-MAX77620 Power management IC from Maxim Semiconductor.
-
-Required properties:
--------------------
-- compatible: Must be one of
-		"maxim,max77620"
-		"maxim,max20024"
-		"maxim,max77663"
-- reg: I2C device address.
-
-Optional properties:
--------------------
-- interrupts:		The interrupt on the parent the controller is
-			connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells:	is <2> and their usage is compliant to the 2 cells
-			variant of <../interrupt-controller/interrupts.txt>
-			IRQ numbers for different interrupt source of MAX77620
-			are defined at dt-bindings/mfd/max77620.h.
-
-- system-power-controller: Indicates that this PMIC is controlling the
-			   system power, see [1] for more details.
-
-[1] Documentation/devicetree/bindings/power/power-controller.txt
-
-Optional subnodes and their properties:
-=======================================
-
-Flexible power sequence configurations:
---------------------------------------
-The Flexible Power Sequencer (FPS) allows each regulator to power up under
-hardware or software control. Additionally, each regulator can power on
-independently or among a group of other regulators with an adjustable power-up
-and power-down delays (sequencing). GPIO1, GPIO2, and GPIO3 can be programmed
-to be part of a sequence allowing external regulators to be sequenced along
-with internal regulators. 32KHz clock can be programmed to be part of a
-sequence.
-
-The flexible sequencing structure consists of two hardware enable inputs
-(EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
-Each master sequencing timer is programmable through its configuration
-register to have a hardware enable source (EN1 or EN2) or a software enable
-source (SW). When enabled/disabled, the master sequencing timer generates
-eight sequencing events on different time periods called slots. The time
-period between each event is programmable within the configuration register.
-Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
-sequence slave register which allows its enable source to be specified as
-a flexible power sequencer timer or a software bit. When a FPS source of
-regulators, GPIOs and clocks specifies the enable source to be a flexible
-power sequencer, the power up and power down delays can be specified in
-the regulators, GPIOs and clocks flexible power sequencer configuration
-registers.
-
-When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz
-clock are set into following state at the sequencing event that
-corresponds to its flexible sequencer configuration register.
-	Sleep state: 			In this state, regulators, GPIOs
-					and 32KHz clock get disabled at
-					the sequencing event.
-	Global Low Power Mode (GLPM):	In this state, regulators are set in
-					low power mode at the sequencing event.
-
-The configuration parameters of FPS is provided through sub-node "fps"
-and their child for FPS specific. The child node name for FPS are "fps0",
-"fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
-
-The FPS configurations like FPS source, power up and power down slots for
-regulators, GPIOs and 32kHz clocks are provided in their respective
-configuration nodes which is explained in respective sub-system DT
-binding document.
-
-There is need for different FPS configuration parameters based on system
-state like when system state changed from active to suspend or active to
-power off (shutdown).
-
-Optional properties:
--------------------
--maxim,fps-event-source:		u32, FPS event source like external
-					hardware input to PMIC i.e. EN0, EN1 or
-					software (SW).
-					The macros are defined on
-						dt-bindings/mfd/max77620.h
-					for different control source.
-					- MAX77620_FPS_EVENT_SRC_EN0
-						for hardware input pin EN0.
-					- MAX77620_FPS_EVENT_SRC_EN1
-						for hardware input pin EN1.
-					- MAX77620_FPS_EVENT_SRC_SW
-						for software control.
-
--maxim,shutdown-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to shutdown
-					state.
-
--maxim,suspend-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to suspend state.
-
--maxim,device-state-on-disabled-event:	u32, describe the PMIC state when FPS
-					event cleared (set to LOW) whether it
-					should go to sleep state or low-power
-					state. Following are valid values:
-					- MAX77620_FPS_INACTIVE_STATE_SLEEP
-						to set the PMIC state to sleep.
-					- MAX77620_FPS_INACTIVE_STATE_LOW_POWER
-						to set the PMIC state to low
-						power.
-					Absence of this property or other value
-					will not change device state when FPS
-					event get cleared.
-
-Here supported time periods by device in microseconds are as follows:
-MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
-MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-MAX77663 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-
--maxim,power-ok-control: configure map power ok bit
-			1: Enables POK(Power OK) to control nRST_IO and GPIO1
-			POK function.
-			0: Disables POK control.
-			if property missing, do not configure MPOK bit.
-			If POK mapping is enabled for GPIO1/nRST_IO then,
-			GPIO1/nRST_IO pins are HIGH only if all rails
-			that have POK control enabled are HIGH.
-			If any of the rails goes down(which are enabled for POK
-			control) then, GPIO1/nRST_IO goes LOW.
-			this property is valid for max20024 only.
-
-For DT binding details of different sub modules like GPIO, pincontrol,
-regulator, power, please refer respective device-tree binding document
-under their respective sub-system directories.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-
-max77620@3c {
-	compatible = "maxim,max77620";
-	reg = <0x3c>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <0 86 IRQ_TYPE_NONE>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	fps {
-		fps0 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
-		};
-
-		fps1 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
-		};
-
-		fps2 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
new file mode 100644
index 000000000000..42cbad56595f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
@@ -0,0 +1,422 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77620 Power management IC from Maxim Semiconductor
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max20024
+      - maxim,max77620
+      - maxim,max77663
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      Device has 8 GPIO pins which can be configured as GPIO as well as
+      the special IO functions. The first cell is the pin number, and the
+      second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+      GPIO_ACTIVE_LOW).
+
+  system-power-controller: true
+
+  "#thermal-sensor-cells":
+    const: 0
+    description:
+      Maxim Semiconductor MAX77620 supports alarm interrupts when its
+      die temperature crosses 120C and 140C. These threshold temperatures
+      are not configurable. Device does not provide the real temperature
+      of die other than just indicating whether temperature is above or
+      below threshold level.
+
+  fps:
+    type: object
+    additionalProperties: false
+    description: |
+      The Flexible Power Sequencer (FPS) allows each regulator to power up
+      under hardware or software control. Additionally, each regulator can
+      power on independently or among a group of other regulators with an
+      adjustable power-up and power-down delays (sequencing). GPIO1, GPIO2,
+      and GPIO3 can be programmed to be part of a sequence allowing external
+      regulators to be sequenced along with internal regulators. 32KHz clock
+      can be programmed to be part of a sequence.
+
+      The flexible sequencing structure consists of two hardware enable inputs
+      (EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
+      Each master sequencing timer is programmable through its configuration
+      register to have a hardware enable source (EN1 or EN2) or a software enable
+      source (SW). When enabled/disabled, the master sequencing timer generates
+      eight sequencing events on different time periods called slots. The time
+      period between each event is programmable within the configuration register.
+      Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
+      sequence slave register which allows its enable source to be specified as
+      a flexible power sequencer timer or a software bit. When a FPS source of
+      regulators, GPIOs and clocks specifies the enable source to be a flexible
+      power sequencer, the power up and power down delays can be specified in
+      the regulators, GPIOs and clocks flexible power sequencer configuration
+      registers.
+
+      When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz clock
+      are set into following state at the sequencing event that corresponds
+      to its flexible sequencer configuration register.
+
+      Sleep state: In this state, regulators, GPIOs and 32KHz clock get disabled
+                   at the sequencing event.
+      Global Low Power Mode (GLPM): In this state, regulators are set in low
+                                    power mode at the sequencing event.
+
+      The configuration parameters of FPS is provided through sub-node "fps"
+      and their child for FPS specific. The child node name for FPS are "fps0",
+      "fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
+
+      The FPS configurations like FPS source, power up and power down slots for
+      regulators, GPIOs and 32kHz clocks are provided in their respective
+      configuration nodes which is explained in respective sub-system DT
+      binding document.
+
+      There is need for different FPS configuration parameters based on system
+      state like when system state changed from active to suspend or active to
+      power off (shutdown).
+
+    patternProperties:
+      "^fps[0-2]$":
+        type: object
+        additionalProperties: false
+
+        properties:
+          maxim,fps-event-source:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              FPS event source like external hardware input to PMIC i.e. EN0, EN1
+              or software (SW).
+
+              The macros are defined on dt-bindings/mfd/max77620.h for different
+              control source.
+                - MAX77620_FPS_EVENT_SRC_EN0 for hardware input pin EN0.
+                - MAX77620_FPS_EVENT_SRC_EN1 for hardware input pin EN1.
+                - MAX77620_FPS_EVENT_SRC_SW for software control.
+
+          maxim,shutdown-fps-time-period-us:
+            description:
+              FPS time period in microseconds when system enters in to shutdown state.
+
+          maxim,suspend-fps-time-period-us:
+            description:
+              FPS time period in microseconds when system enters in to suspend state.
+
+          maxim,device-state-on-disabled-event:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Describe the PMIC state when FPS event cleared (set to LOW) whether it
+              should go to sleep state or low-power state. Following are valid values:
+                - MAX77620_FPS_INACTIVE_STATE_SLEEP to set the PMIC state to sleep.
+                - MAX77620_FPS_INACTIVE_STATE_LOW_POWER to set the PMIC state to low
+                  power.
+              Absence of this property or other value will not change device state
+              when FPS event get cleared.
+
+          maxim,power-ok-control:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Configure map power ok bit
+
+              1: Enables POK(Power OK) to control nRST_IO and GPIO1 POK function.
+              0: Disables POK control.
+
+              If property missing, do not configure MPOK bit. If POK mapping is
+              enabled for GPIO1/nRST_IO then, GPIO1/nRST_IO pins are HIGH only if
+              all rails that have POK control enabled are HIGH. If any of the rails
+              goes down (which are enabled for POK control) then, GPIO1/nRST_IO
+              goes LOW.
+            enum: [0, 1]
+
+  pinmux:
+    $ref: /schemas/pinctrl/maxim,max77620-pinctrl.yaml
+
+  regulators:
+    $ref: /schemas/regulator/maxim,max77620-regulator.yaml
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max20024
+              - maxim,max77663
+    then:
+      properties:
+        "#thermal-sensor-cells": false
+        fps:
+          patternProperties:
+            "^fps[0-2]$":
+              properties:
+                maxim,shutdown-fps-time-period-us:
+                  enum: [20, 40, 80, 160, 320, 640, 1280, 2540]
+                maxim,suspend-fps-time-period-us:
+                  enum: [20, 40, 80, 160, 320, 640, 1280, 2540]
+                maxim,power-ok-control: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max77620
+    then:
+      properties:
+        fps:
+          patternProperties:
+            "^fps[0-2]$":
+              properties:
+                maxim,shutdown-fps-time-period-us:
+                  enum: [40, 80, 160, 320, 640, 1280, 2560, 5120]
+                maxim,suspend-fps-time-period-us:
+                  enum: [40, 80, 160, 320, 640, 1280, 2560, 5120]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mfd/max77620.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3c {
+            compatible = "maxim,max77620";
+            reg = <0x3c>;
+
+            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+            #interrupt-cells = <2>;
+            interrupt-controller;
+
+            #gpio-cells = <2>;
+            gpio-controller;
+
+            #thermal-sensor-cells = <0>;
+
+            system-power-controller;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&max77620_default>;
+
+            max77620_default: pinmux {
+                gpio0 {
+                    pins = "gpio0";
+                    function = "gpio";
+                };
+
+                gpio1 {
+                    pins = "gpio1";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+        };
+
+                gpio2 {
+                    pins = "gpio2";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                gpio3 {
+                    pins = "gpio3";
+                    function = "gpio";
+                };
+
+                gpio4 {
+                    pins = "gpio4";
+                    function = "32k-out1";
+                };
+
+                gpio5_6 {
+                    pins = "gpio5", "gpio6";
+                    function = "gpio";
+                    drive-push-pull = <1>;
+                };
+
+                gpio7 {
+                    pins = "gpio7";
+                    function = "gpio";
+                };
+            };
+
+            fps {
+                fps0 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+                };
+
+                fps1 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+                };
+
+                fps2 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
+                };
+            };
+
+            regulators {
+                in-sd0-supply = <&vdd_5v0_vbus>;
+                in-sd1-supply = <&vdd_5v0_vbus>;
+                in-sd2-supply = <&vdd_5v0_vbus>;
+                in-sd3-supply = <&vdd_5v0_vbus>;
+
+                in-ldo0-1-supply = <&vdd_1v8_vio>;
+                in-ldo2-supply   = <&vdd_3v3_vbat>;
+                in-ldo3-5-supply = <&vdd_3v3_vbat>;
+                in-ldo4-6-supply = <&vdd_3v3_vbat>;
+                in-ldo7-8-supply = <&vdd_1v8_vio>;
+
+                sd0 {
+                    regulator-name = "vdd_cpu";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                sd1 {
+                    regulator-name = "vdd_core";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                vdd_1v8_vio: sd2 {
+                    regulator-name = "vdd_1v8_gen";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                sd3 {
+                    regulator-name = "vddio_ddr";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo0 {
+                    regulator-name = "avdd_pll";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                ldo1 {
+                    regulator-name = "vdd_ddr_hs";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo2 {
+                    regulator-name = "avdd_usb";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo3 {
+                    regulator-name = "vdd_sdmmc3";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-always-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo4 {
+                    regulator-name = "vdd_rtc";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                ldo5 {
+                    regulator-name = "vdd_ddr_rx";
+                    regulator-min-microvolt = <2850000>;
+                    regulator-max-microvolt = <2850000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                ldo6 {
+                    regulator-name = "avdd_osc";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo7 {
+                    regulator-name = "vdd_1v2_mhl";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1250000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+
+                ldo8 {
+                    regulator-name = "avdd_dsi_csi";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
deleted file mode 100644
index 82ed5d487966..000000000000
--- a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Thermal driver for MAX77620 Power management IC from Maxim Semiconductor.
-
-Maxim Semiconductor MAX77620 supports alarm interrupts when its
-die temperature crosses 120C and 140C. These threshold temperatures
-are not configurable. Device does not provide the real temperature
-of die other than just indicating whether temperature is above or
-below threshold level.
-
-Required properties:
--------------------
-#thermal-sensor-cells:	For more details, please refer to
-			<devicetree/bindings/thermal/thermal-sensor.yaml>
-			The value must be 0.
-
-For more details, please refer generic thermal DT binding document
-<devicetree/bindings/thermal/thermal*.yaml>.
-
-Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
-document for the MAX77620.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-#include <dt-bindings/thermal/thermal.h>
-...
-
-i2c@7000d000 {
-	spmic: max77620@3c {
-		compatible = "maxim,max77620";
-		:::::
-		#thermal-sensor-cells = <0>;
-		:::
-	};
-};
-
-cool_dev: cool-dev {
-	compatible = "cooling-dev";
-	#cooling-cells = <2>;
-};
-
-thermal-zones {
-	PMIC-Die {
-		polling-delay = <0>;
-		polling-delay-passive = <0>;
-		thermal-sensors = <&spmic>;
-
-		trips {
-			pmic_die_warn_temp_thresh: hot-die {
-				temperature = <120000>;
-				type = "hot";
-				hysteresis = <0>;
-			};
-
-			pmic_die_cirt_temp_thresh: cirtical-die {
-				temperature = <140000>;
-				type = "critical";
-				hysteresis = <0>;
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&pmic_die_warn_temp_thresh>;
-				cooling-device = <&cool_dev THERMAL_NO_LIMIT
-						  THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-		};
-	};
-};
-- 
2.51.0


