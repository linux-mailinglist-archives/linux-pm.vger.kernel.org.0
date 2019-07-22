Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C070A20
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfGVTxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40110 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbfGVTxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so40654272wrl.7;
        Mon, 22 Jul 2019 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IX8qAPZ5ga7jjpfsQbccNQpSlMQzcP4rHdYTapv0mIc=;
        b=M+YlBCa7A8B8GaqJ4NYdHnOtuHzpjNo4WuNL/EroG4kVslfTkKmaCoovF0W1jCCIt4
         BS3W+NkIjcdwIbrMYSyCfBjZ1+hv6PgwvELhEakF8b0GwUTIILmaEutRD1MKxAX7du1v
         rLq4fouat5b53q8AaX/AEcZAl5Ey4nYxk3XdXQJ4RQLOlaaOBgObgFiJIk41XdOuS+at
         jLcQ6U+HpvIvZvUSq5MdHH9Sp5qSJ5UShDqKM13Dnruq4qj2sRjpEs0mWBAycbVjVB9D
         caOIo5wA/OCVJAfE9lMBZMRpE2SxeVTEc05aIe0W4ibcwZekzfasyXg8AuG9lQDcitbT
         aEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IX8qAPZ5ga7jjpfsQbccNQpSlMQzcP4rHdYTapv0mIc=;
        b=dTf42ZwG0BG9h0Js6ZpkxJt3H96mYozQchK/LJastb4sVVlkl6VVEmAgMLvNWD9QBe
         H8iecRyrlB7qTWkuc8r7qpBf5V4Qj0p6kO3GiZ0Q07DFpsYuKNc4vTOZ/W0Mw3oJSZPU
         Au5Z/WTCnTxsiJV02Wj7M/011PPGurt9CKUZrOW2qYUtRdZ8V0S+zOYIPrS6ArR8nNU+
         2LjJihSPmB21g67KYKBai1ds0x9MLjAQ+rp1EyChr5eMsxyYcBYhHkWA9WNAjaMcoF57
         JoYY4H69PiYKXgyCQuf2KlCIx9E1gMVufrPCwH0GsVMj3jsN7nhLGIG7lbJEa8DxGBRn
         kuiw==
X-Gm-Message-State: APjAAAVlWlaMAQ1sNP+oFGDC0woFoVtnH8WNYxUwgvoVKfqPdfCP/ZyT
        dPPvZVDoAqHSIhzq07RCv7s=
X-Google-Smtp-Source: APXvYqykdwrFiIPBMnWje+j85w+VcW3cLfV+djpTPk/RQoTUSiLvLyiyGnJYWtnDT9ipOdxoP5qfvA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr63805568wrm.55.1563825211750;
        Mon, 22 Jul 2019 12:53:31 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:31 -0700 (PDT)
From:   Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Evgeny Kolesnikov <evgenyz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: dts: armada385-wd-mcex2u: Add DTS file for WD My Cloud EX2 Ultra
Date:   Mon, 22 Jul 2019 21:53:05 +0200
Message-Id: <fd2a97d627c21a7e92a9a1aa15cf26c608d1e383.1563822216.git.evgenyz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the DTS file to describe the Western Digital My Cloud EX2 Ultra NAS.

Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
---
 arch/arm/boot/dts/armada-385-wd-mcex2u.dts | 313 +++++++++++++++++++++
 1 file changed, 313 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-wd-mcex2u.dts

diff --git a/arch/arm/boot/dts/armada-385-wd-mcex2u.dts b/arch/arm/boot/dts/armada-385-wd-mcex2u.dts
new file mode 100644
index 000000000000..018e66adbb93
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-wd-mcex2u.dts
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for Western Digital My Cloud EX2 Ultra
+ * (BVBZ/Ranger Peak)
+ *
+ * Copyright (C) 2019 Evgeny Kolesnikov <evgenyz@gmail.com>
+ *
+ * Based on the code from:
+ *
+ * Copyright (C) 2016 Martin Mueller <mm@sig21.net>
+ * Copyright (C) 2013 Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Copyright (C) 2013 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-385.dtsi"
+
+/ {
+	model = "WD My Cloud EX2 Ultra (BVBZ/Ranger Peak)";
+	compatible = "wd,mcex2u", "marvell,armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>; /* 1024 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
+
+		internal-regs {
+			timer@c200 {
+				status = "disabled";
+			};
+
+			i2c0: i2c@11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			i2c1: i2c@11100 {
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			serial@12000 {
+				status = "okay";
+			};
+
+			/* Connected to Welltrend 6703F-OG240WT MCU
+			 * which controls power, fan and other things
+			 */
+			serial@12100 {
+				status = "okay";
+			};
+
+			poweroff@12100 {
+				compatible = "uart-poweroff";
+				reg = <0x12100 0x100>;
+				clocks = <&coreclk 0>;
+				baud = <19200>;
+				cmd = [fa 03 03 01 00 00 fb];
+				status = "okay";
+			};
+
+			restart@12100 {
+				compatible = "uart-restart";
+				reg = <0x12100 0x100>;
+				clocks = <&coreclk 0>;
+				baud = <19200>;
+				cmd = [fa 03 03 02 00 00 fb];
+				override;
+				status = "okay";
+			};
+
+			pinctrl@18000 {
+				uart1_pins: uart-pins-1 {
+					marvell,pins = "mpp19";
+					marvell,function = "ua1";
+				};
+
+				xhci0_vbus_pins: xhci0-vbus-pins {
+					marvell,pins = "mpp26";
+					marvell,function = "gpio";
+				};
+
+				xhci1_vbus_pins: xhci1-vbus-pins {
+					marvell,pins = "mpp27";
+					marvell,function = "gpio";
+				};
+
+				sata0_pins: sata-pins-0 {
+					marvell,pins = "mpp55";
+					marvell,function = "sata0";
+				};
+
+				sata1_pins: sata-pins-1 {
+					marvell,pins = "mpp56";
+					marvell,function = "sata1";
+				};
+
+				sata_leds: sata-leds {
+					marvell,pins = "mpp43", "mpp52",
+						       "mpp53", "mpp54";
+					marvell,function = "gpio";
+				};
+
+				btn_pins: btn-pins {
+					marvell,pins = "mpp50";
+					marvell,function = "gpio";
+				};
+			};
+
+			ethernet@34000 {
+				phy = <&phy0>;
+				phy-mode = "sgmii";
+				buffer-manager = <&bm>;
+				bm,pool-long = <0>;
+				bm,pool-short = <1>;
+				status = "okay";
+			};
+
+			usb@58000 {
+				status = "okay";
+			};
+
+			mdio@72004 {
+				phy0: ethernet-phy@0 {
+					/* Init ETH LEDs */
+					marvell,reg-init = <3 16 0 0x101e>;
+					reg = <0>;
+				};
+			};
+
+			crypto@9d000 {
+				status = "okay";
+			};
+
+			rtc@a3800 {
+				status = "okay";
+			};
+
+			sata@a8000 {
+				status = "okay";
+			};
+
+			bm@c8000 {
+				status = "okay";
+			};
+
+			nand-controller@d0000 {
+				status = "okay";
+
+				nand: nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					marvell,nand-keep-config;
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+					nand-ecc-strength = <4>;
+					nand-ecc-step-size = <512>;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0000000 {
+							label = "U-Boot";
+							reg = <0x00000000 0x00500000>;
+							read-only;
+						};
+						partition@0500000 {
+							label = "kernel";
+							reg = <0x00500000 0x00500000>;
+						};
+						partition@0a00000 {
+							label = "uRamdisk";
+							reg = <0x00a00000 0x00500000>;
+							read-only;
+						};
+						partition@0f00000 {
+							label = "ubi";
+							reg = <0x00f00000 0x0b900000>;
+						};
+						partition@c800000 {
+							label = "Recovery";
+							reg = <0x0c800000 0x00f00000>;
+							read-only;
+						};
+						partition@d700000 {
+							label = "config";
+							reg = <0x0d700000 0x01400000>;
+						};
+						partition@eb00000 {
+							label = "reserve1";
+							reg = <0x0eb00000 0x00a00000>;
+							read-only;
+						};
+						partition@f500000 {
+							label = "reserve2";
+							reg = <0x0f500000 0x00a00000>;
+							read-only;
+						};
+					};
+				};
+			};
+
+			sdhci@d8000 {
+				status = "disabled";
+			};
+
+			usb3@f0000 {
+				usb-phy = <&usb3_0_phy>;
+				status = "okay";
+			};
+
+			usb3@f8000 {
+				usb-phy = <&usb3_1_phy>;
+				status = "okay";
+			};
+		};
+
+		bm-bppi {
+			status = "okay";
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sata_leds>;
+
+		sata1-red-led {
+			label = "wdmcex2u:red:hdd1";
+			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+		sata2-red-led {
+			label = "wdmcex2u:red:hdd2";
+			gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+		};
+		sata1-blue-led {
+			label = "wdmcex2u:blue:hdd1";
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+		sata2-blue-led {
+			label = "wdmcex2u:blue:hdd2";
+			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&btn_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
+			debounce-interval = <60>;
+			wakeup-source;
+		};
+	};
+
+	usb3_0_phy: usb3_0_phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_usb3_0_vbus>;
+	};
+
+	usb3_1_phy: usb3_1_phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_usb3_1_vbus>;
+	};
+
+	reg_usb3_0_vbus: usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus0";
+		pinctrl-names = "default";
+		pinctrl-0 = <&xhci0_vbus_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_usb3_1_vbus: usb3-vbus1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus1";
+		pinctrl-names = "default";
+		pinctrl-0 = <&xhci1_vbus_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpio0 27 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.21.0

