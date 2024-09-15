Return-Path: <linux-pm+bounces-14308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C8597959E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186001F21327
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CB14D2A0;
	Sun, 15 Sep 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1J3uyH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BC56458;
	Sun, 15 Sep 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387770; cv=none; b=njysVKHCXkTjNjRZJwIo00bOxmbGLFa5UzVm6Cx7Qg3kdEjWC3kBgTah01Nj7oKogi4LHKcefUGX76+EtN1jpKAd4+XYInZKogEQFdu8aGK0CPEu0Ax7QXkEd24ir41K6YeVlrwLdunVU7UMDAZOqxFQcPib3ddqyKdm36Eebq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387770; c=relaxed/simple;
	bh=TAT79Xnzl1oNNV5FROigdgNXLb2Cybp4CLgUCT939cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1YlhPwZhfqd73lV6njFeNYenCGgfrzQBeIBtD6XVtQJ58eK05au7PE7L2bwxJONioiXDX7hG17NU1BwiHLXB6spJZ5Spe+JEMvwMHPqmcUYqmDqqdXgsmIiIANDrRmMEJ2eGfLyAUsEgRoPi3ZmUEWuQA+tiPZYk6/2wksV7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1J3uyH7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20570b42f24so36535775ad.1;
        Sun, 15 Sep 2024 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387767; x=1726992567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyWUpX9SDl0pBa3ZzU7qUw9/ZE6s9qUhKf2MUIrA7EE=;
        b=W1J3uyH7DNDhZ3nFBBfamv0Gx+YapYyrW9y0DVtWvmTSV+chlzns4k0Ici3ENlTw3c
         zAJzF9bSBFV913UKWXEoNo+pMapNyc9LGWYR3lBsDCjy+q75QNM5pPVvV8XhtziVSLfn
         G1AgRnx5h3PpO0oaT5/CaH8Y3WdRlnZxGJbfc6zLHEUmKvB0cDDE0opWZUjOmmrosc0t
         1UrRgh0iqQSTowEH65LQGo2PGA7muvE3gLRwDwE4g11Puj4uFFAnXite0/ZGrqkvCR8F
         A1qyPbjaGpjhAr59hST+NwxCFKIJaSu3nNjnf7KF3zWRIsi2xLKOCkwp2H4jMTFNMGa6
         1GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387767; x=1726992567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyWUpX9SDl0pBa3ZzU7qUw9/ZE6s9qUhKf2MUIrA7EE=;
        b=oP/6A04DC6fh5Kr+Sudo78iECADiGVfi1o4Iw41RQk6RD9rxx5VesUgDTpn5NqOIZi
         KRCE0e4AbBAWUMeY8dJrghvN9FxgHBm49Bpy1XvqmlUPcU5MNdCHejK7wbo3yf6DnYoq
         5+GHm+EWavJCqL5FG3uNP8JnYCtSplRQ9P/yzD3nvPIJyTwWpyNLVDV63VlBTmgaM6jC
         kme/0K1BWGA32DTXPJS6Ptyc1mEcvHg3mAJiXPtpwxUxm47tS4adsPmFZ+0je6FYTrJt
         7IfXGmVw7kLDRr3NaMWBuGx2+yO7DsxOvIQ8JxleFWvQdbNmUi9oe9R9Cd7VWsXzwFce
         tYog==
X-Forwarded-Encrypted: i=1; AJvYcCUUiWpMSknXv4UR4/wYXhc5xuTn5PO4XtadZl0dUN09J57efN7wGCtrnAhX7JpzFVSEBVvUz+II59HOeUQrEo8=@vger.kernel.org, AJvYcCVBmkUYrz1pldBuFfoNp/pwM3b1PfD2ANShTpV0hI/Yk7gRVbqy/kUgxtOFf2JGk20BLGDGdQ8BPOs=@vger.kernel.org, AJvYcCVGEt8TyC/6ZNLRW5IZfCyUa5NZAG/AHFK5t4zyoRgHUGipDwGaOBhc6ypzxiwNzGQXBh/IiT6drvKkhA==@vger.kernel.org, AJvYcCVzkTQDzq79Dqvj2uR2UrzQJIfR33bWCOephG947ObgMH3PmLdV6FHOqpfYOpBFxDhVHP9BSw07lDFyoHGQ@vger.kernel.org, AJvYcCWQa3Ia0JFKSr222/TAz95jEXII1+JMPGL/BNu/uDOWPj4uHQ5JIQPtg+/KRdH5y4xCjfO1bCmo+ot5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9owAaOi+2PqFmUOQBVYJaNEOz7fTNSa1/CMu3lNvvsNcuXrjK
	HyHIPSHWhF1LGLsVhlOFTuMYb9lPScmqE6fz7kaR3DDomnCCcOYP
X-Google-Smtp-Source: AGHT+IHrhRV0R7dXF1+Czt3OJ9XROPCr2kymKG5HLSFYUxUTv4kTuJKyS3RNd53oQvgPBXrwjr1T+A==
X-Received: by 2002:a17:902:d503:b0:206:8f21:284e with SMTP id d9443c01a7336-2076e3f8533mr176826345ad.42.1726387767470;
        Sun, 15 Sep 2024 01:09:27 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:09:27 -0700 (PDT)
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
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 16/20] arm64: dts: apple: Add A9X devices
Date: Sun, 15 Sep 2024 15:59:01 +0800
Message-ID: <20240915080733.3565-17-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
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
 arch/arm64/boot/dts/apple/s8001-pro.dtsi |  47 +++++++
 arch/arm64/boot/dts/apple/s8001.dtsi     | 167 +++++++++++++++++++++++
 7 files changed, 274 insertions(+)
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
index 000000000000..214fbbcf66fd
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-pro.dtsi
@@ -0,0 +1,47 @@
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
+	chassis-type = "tablet";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 122 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
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


