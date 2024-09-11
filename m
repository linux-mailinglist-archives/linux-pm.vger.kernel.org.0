Return-Path: <linux-pm+bounces-14001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E748974D5E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722A11C2193D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158A19992A;
	Wed, 11 Sep 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCjAHsHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58731940B2;
	Wed, 11 Sep 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044496; cv=none; b=V4usxdAewn4Vrq2JuhdjfesMUnLgAuTSKnpp8fNXranGVNjWc5vbcVho305lC0IAb8/jFJf1WgYJ/FNB6wMiJKzCY9U51/U6rdRt2rzqN2muKNENH/NlHa2nrMMUKEnG/oYu/cy9/4PkkbamxHUtDB5hUepTdPwxKrCmUPqwmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044496; c=relaxed/simple;
	bh=8O/XoPvWoydFU1PTjWLWHDAhJrjBsRfANY7F9REjAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBKCvfSirtFDk8ssRAIPt4PCoA5MPjSvJR7VZflAK4thT1ynmqAU61Hh3FB6lNooyF0T9MsutM6UnhbaFfKFwYrA33IMp5WLwnjpQyPLeDZSN11ocS0Fh/natQwJ/SEdYuLCgm5BYWZEb7lUIChDii64C1GRU04E0ushM+DmTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCjAHsHX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso3117154b3a.0;
        Wed, 11 Sep 2024 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044493; x=1726649293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMtpADdbemAuUpT2j0MQj51id5IUiRoW+OsN0001l80=;
        b=kCjAHsHX5rUnRn0PEfy3PkZfwfGnYk7OdJBi1132tCx6zby4gKdW4IslyBVqD4RtfZ
         F/nhEe8bXKIT6yGWyY9YwpcJkLFFGuh4W46bs04thMdccsE+Q8cbc0dwmxVcxP6FLGQz
         AzPyRGfTKsy9S4/b37C2lBoF1mm5mFTeAVMhzrtkxlqlCITWkdXZwczt7j0Ul2zuXd+P
         jJp9B+cB2mgkR3aMGiPT3Aj7v5CSGDDXR0CcI8r66FKkME7y5E3KZd2L39LA2eW6L09p
         x4zyNI2ZfDNmS7y6ei2vJGv8aRjqAmJuU1THsAhgPcrlZpMMON0XSphw6AHoxFJrfd55
         /sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044493; x=1726649293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMtpADdbemAuUpT2j0MQj51id5IUiRoW+OsN0001l80=;
        b=EUL/eAmnXVLUKV5x9F2NYIZj9Td30kByN3eVteQeOUM5SHZy+MrngJwfiNOMVk2BPC
         f3HFiBJfpKPiYjPWq+W1AMvAxJow+Lf+GU0vr4ZYsGKdLQLXr3e4Rx/9vtKQ+GYr9btB
         6woQI0RyRLkla8i6qYfE4DmPHPsihNlXOsxZYngZUe0U2jsffMFezOp1j2Btzq0mgv1a
         espuk03HPQMWlV8dRKizEH02auF5ALpw+sUPEEErCwQheT0NQZssnpM0lwOM7UHFWTSM
         nEu76roKMT9YYZ2jvGgqUxzLbf7fgIyV4uO+YwCGNnvz1iC3lIM+CF57QlkO6+1cTj3H
         HQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUEYnidiXIuzwiY52hWm4V5fV5hFCwllHUAus69fr7vhtmOyyGt+w2DI4Di/scO22vVz+uU9wSHZ9CgWg==@vger.kernel.org, AJvYcCUtcx1bMKnQN666Su+BUPgrlUx+8O+/9MyzHXzIDDU/5DmWnAcQmZR8fnNlQNJwp9PIH5+sXII1wgU=@vger.kernel.org, AJvYcCUzAoO4iT/E14R8TPm6Vv4Y5Z5w8HXkAG2ajX3KconzqtsQNVEhR61wsK4hwxMWTZ6kMpsM9cF51bhZWk6LFWc=@vger.kernel.org, AJvYcCV8sKSrjUH4/iaHCLGDQtkvf8sYxmtvxWb33P5NcVayaGI+LfCQxypANkDVbhUINN8DzI9qXf/3vIWejAHM@vger.kernel.org, AJvYcCWvniMY8VR7Js52txh2DIacv49Se7DjAFyzEyL2cuYPyuNCEcYdWOWyIgYTTUnws0b8rtdWU5IJSc0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGrmlVgbvmQM0L7OMKTk2R8cXD2f78geP55KMac+ezbLybqvd
	pHiRX/nT415EuJyOIcMbOysrjT/5SVxUcNGwYifhaKlYyZ9jAap2PeZAemJ6uRA=
X-Google-Smtp-Source: AGHT+IE+Oa+OiHUdRRdIusuC79t0MIA8HBL0VI5bTvNMSjL4+ULRWcQpTC9clJgufq5zJBwLXcVGXA==
X-Received: by 2002:a05:6a00:181e:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-718d5ee032emr19622450b3a.22.1726044492979;
        Wed, 11 Sep 2024 01:48:12 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:12 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 17/22] arm64: dts: apple: Add A9X devices
Date: Wed, 11 Sep 2024 16:41:07 +0800
Message-ID: <20240911084353.28888-19-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add the device tree for the A9X SoC and the devices based on it:

- iPad Pro (9.7 Inch)
- iPad Pro (12.9 Inch) (1st generation)

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP and m1n1 support, uart interrupt and pinctrl fixes]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile       |   4 +
 arch/arm64/boot/dts/apple/s8001-j127.dts |  14 ++
 arch/arm64/boot/dts/apple/s8001-j128.dts |  14 ++
 arch/arm64/boot/dts/apple/s8001-j98a.dts |  14 ++
 arch/arm64/boot/dts/apple/s8001-j99a.dts |  14 ++
 arch/arm64/boot/dts/apple/s8001-pro.dtsi |  45 ++++++
 arch/arm64/boot/dts/apple/s8001.dtsi     | 167 +++++++++++++++++++++++
 7 files changed, 272 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index cbb7e409b7e3..f8cd10889d9f 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -28,6 +28,10 @@ dtb-$(CONFIG_ARCH_APPLE) += s8003-j72t.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8003-n66m.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8003-n69.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8003-n71m.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8001-j127.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8001-j128.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8001-j98a.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8001-j99a.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/s8001-j127.dts b/arch/arm64/boot/dts/apple/s8001-j127.dts
new file mode 100644
index 000000000000..8b522085cb3e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-j127.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (9.7-inch) (Wi-Fi), J127, iPad6,3 (A1673)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8001-pro.dtsi"
+
+/ {
+	compatible = "apple,j127", "apple,s8001", "apple,arm-platform";
+	model = "Apple iPad Pro (9.7-inch) (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8001-j128.dts b/arch/arm64/boot/dts/apple/s8001-j128.dts
new file mode 100644
index 000000000000..cdd3d06dcbf1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-j128.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (9.7-inch) (Cellular), J128, iPad6,4 (A1674/A1675)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8001-pro.dtsi"
+
+/ {
+	compatible = "apple,j128", "apple,s8001", "apple,arm-platform";
+	model = "Apple iPad Pro (9.7-inch) (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8001-j98a.dts b/arch/arm64/boot/dts/apple/s8001-j98a.dts
new file mode 100644
index 000000000000..6d6b841e7ab0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-j98a.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (12.9-inch) (Wi-Fi), J98a, iPad6,7 (A1584)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8001-pro.dtsi"
+
+/ {
+	compatible = "apple,j98a", "apple,s8001", "apple,arm-platform";
+	model = "Apple iPad Pro (12.9-inch) (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8001-j99a.dts b/arch/arm64/boot/dts/apple/s8001-j99a.dts
new file mode 100644
index 000000000000..d20194b1cae7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-j99a.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (12.9-inch) (Cellular), J99a, iPad6,8 (A1652)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8001-pro.dtsi"
+
+/ {
+	compatible = "apple,j99a", "apple,s8001", "apple,arm-platform";
+	model = "Apple iPad Pro (12.9-inch) (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8001-pro.dtsi b/arch/arm64/boot/dts/apple/s8001-pro.dtsi
new file mode 100644
index 000000000000..3bd0e12d6196
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-pro.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (1st generation) common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "s8001.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 122 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 123 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
new file mode 100644
index 000000000000..ab22d7948f62
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8001 "A9X" SoC
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ * Based on Asahi Linux's M1 (t8103.dtsi) and Corellium's A10 efforts.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	interrupt-parent = <&aic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+		};
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "apple,twister";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,twister";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0 0>; /* To be filled in by loader */
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * The bootloader reserves a region for the (varying-address, depending
+		 * on what FW your device runs AND model) framebuffer under this node.
+		 */
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		nonposted-mmio;
+		ranges;
+
+		serial0: serial@20a0c0000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x0a0c0000 0x0 0x4000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 218 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,s8000-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@20f100000 {
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0f100000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 219>;
+			apple,npins = <219>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 48 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2100f0000 {
+			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x100f0000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 28>;
+			apple,npins = <28>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 134 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt: watchdog@2102b0000 {
+			compatible = "apple,s8000-wdt", "apple,wdt";
+			reg = <0x2 0x102b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A9X doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


