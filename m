Return-Path: <linux-pm+bounces-14000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED06974D5A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B1288CF6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2892F1714CF;
	Wed, 11 Sep 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9uKH1SQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C81192B88;
	Wed, 11 Sep 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044491; cv=none; b=X18HqYJkIpdplNozXPFm+2XtfT/jzCqGNPPh0943OFgNIMjsUay21umcORfB6EIWCfFKTY7iHXA7o0+fD6gvgAqU4Z1mWJdYS82Zo6kBtz2pqHIsqCWM49a1qMqbs3arnCo5d1wzVWXFDDk84G+sUQagRU2NfKiT8wsB7yw4ODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044491; c=relaxed/simple;
	bh=+0BJMZ1uGydNCD3sRiYxKFetbM31dqKhrk3C2RsWZ3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJVv6/J3Qwp7eg1xHEmY7+YCd8FFeMic355yqI5uU9mY7JqVLlMgryHhOgIPYZjWMG18cuLadXektjB5dQmOsVrdeZ9Eu9dQRUYAdHiZhi30VVRxSbf/IE7B5CZrwiZo1m9FQu+Yb9FZrp4+is1JyKL8PF19WZ4XinUbjBqbOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9uKH1SQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e1ce7e84so3311218b3a.1;
        Wed, 11 Sep 2024 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044488; x=1726649288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWI7D8Vpr+QQ0FflEt9NhJTvs3StoVLvCEBO1MwMECM=;
        b=b9uKH1SQk7/cKnX48+twBevv8tvFI8NXviJYQdbnE0ewB5LqTGZtzHVW6FSrXAuSR7
         QPJoLmGgQrCdlCraNg0lXcYoHOYgZ12TmH2vICRG8a6FKl5NEQl/S8fLlVsasqnD+Qkn
         T6rJeM6WACdivqHw2t9kmwM8UfhHsE5mbeNCYcuZgleqxCyJ57RH6vmjVlwNIB07LDof
         BP3jCdW6sb7CPGLOVoJKAdNH2LoIshPGwc15nPVbHVV3s0Puritrxo8k6AnwJSwHyayu
         JMalRJWbHND76gTJ71aU0ypk108gDsuVRPm4Ffr7mIkH3A6hijNrxuthvJDu3X2Cs9Ci
         nGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044488; x=1726649288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWI7D8Vpr+QQ0FflEt9NhJTvs3StoVLvCEBO1MwMECM=;
        b=B41HyTjr63TNuRHtlyic9iP+ezGJQXMzrcXk6k/0h8fu5xnuJF52FttwNm3+wm7tLT
         /PDyFCnHh60jLGdiTuAz8D0n7KmpYQjS7IZpjRaKFqqbr4xvBKCy7bJlkS0d7TOGbaR4
         XvDYxF97d3X67R7WuZY6eZvWpuhf+U4buvpS91USGrZKwDQ1HYuV0nIZLRd1MJxHGj+w
         4yf0UNzq7aIQqaEsdcCGhcoDwNG+rsiUUIitopA6KTIo2z4B3QepLajyzFFh45YEL3EI
         Rc7Sktf6ktaqc22A1w87hvD0oJwFemaSGGdU0pJfCZ8Vp4dCERJCDWJgLMgD25bGE6DO
         pyYw==
X-Forwarded-Encrypted: i=1; AJvYcCUqpTN+Suff1XT4z3LN0CR8OIRZlucFsj4GRWS+9aYHJiHsHpHb/PhFqwjeYULkqgP37USy0lSSvesC@vger.kernel.org, AJvYcCVrYseRI+cfftr/HtSF6b+JrglRnktkSLaMABrqybwoeqpJjQt9iaBhPZHrL4kF3UqC1pLtpk8ro9GtqQ==@vger.kernel.org, AJvYcCWxHThokKBYn9N/MXP5apacg4cr9HvGzD6ak0IND2yCAVtpeZlAOCBBLI7pwYcRGGhNZb7Ij3DFMIZUob0W8OU=@vger.kernel.org, AJvYcCXEaIuhIAca5Nw4j1lodq+p0D2XFTlNKuB4UnExarNDmWpq55yQPWdZLFLEyvztuCcnN6+EST+yWAdbz3eW@vger.kernel.org, AJvYcCXiNyiRTG7ydlhbyMYsF8rCWmRwWVkdFvRo3cuscxbMjcjccfkj6J2oqiPMTtteyEmugZ6d7kxG7Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3F2xh6dXGLIuHOMYEJTrti3Q142ATxnwdIhYvwc1ij/5795o
	nimdx2eoNzxOUXY2xkW3JeruzsqetS98GMyaR1E8JQWfi9ILTZcx
X-Google-Smtp-Source: AGHT+IHpGCK+fZ7obM5mdFCtxva/aycoiiCJvZnxyab9hAr8Dyt6zMIDktlVai5NhCnYn06IIgt5ZQ==
X-Received: by 2002:a05:6300:668c:b0:1cf:38b0:57ff with SMTP id adf61e73a8af0-1cf5e198435mr4678238637.48.1726044488258;
        Wed, 11 Sep 2024 01:48:08 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:07 -0700 (PDT)
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
Subject: [PATCH 16/22] arm64: dts: apple: Add A9 devices
Date: Wed, 11 Sep 2024 16:41:06 +0800
Message-ID: <20240911084353.28888-18-towinchenmi@gmail.com>
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

Add DTS files for the A9 SoC and the following devices based on it:
- iPhone 6S
- iPhone 6S Plus
- iPhone SE (2016)
- iPad 5

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP, m1n1 and AOP pinctrl support]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |  10 ++
 arch/arm64/boot/dts/apple/s8000-j71s.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-j72s.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-n66.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8000-n69u.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8000-n71.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8000.dtsi       | 179 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/s8003-j71t.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-j72t.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-n66m.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003-n69.dts    |  15 ++
 arch/arm64/boot/dts/apple/s8003-n71m.dts   |  15 ++
 arch/arm64/boot/dts/apple/s8003.dtsi       |  19 +++
 arch/arm64/boot/dts/apple/s800x-6s.dtsi    |  50 ++++++
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi |  44 +++++
 arch/arm64/boot/dts/apple/s800x-se.dtsi    |  50 ++++++
 16 files changed, 502 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index adda522ea490..cbb7e409b7e3 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -18,6 +18,16 @@ dtb-$(CONFIG_ARCH_APPLE) += t7000-n56.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7000-n61.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7001-j81.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t7001-j82.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-j71s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-j72s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n66.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n69u.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8000-n71.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-j71t.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-j72t.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n66m.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n69.dtb
+dtb-$(CONFIG_ARCH_APPLE) += s8003-n71m.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/s8000-j71s.dts b/arch/arm64/boot/dts/apple/s8000-j71s.dts
new file mode 100644
index 000000000000..b5a2dfa1121e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-j71s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Wi-Fi) (Samsung), J71s, iPad6,11 (A1822)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j71s", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPad 5 (Wi-Fi) (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-j72s.dts b/arch/arm64/boot/dts/apple/s8000-j72s.dts
new file mode 100644
index 000000000000..8f3dea5adb09
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-j72s.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Cellular) (Samsung), J72s, iPad6,12 (A1823)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j72s", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPad 5 (Cellular) (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n66.dts b/arch/arm64/boot/dts/apple/s8000-n66.dts
new file mode 100644
index 000000000000..834bf702b009
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n66.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6S Plus (Samsung), N66, iPhone8,2 (A1634/A1687/A1690/A1699)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n66", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone 6S Plus (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n69u.dts b/arch/arm64/boot/dts/apple/s8000-n69u.dts
new file mode 100644
index 000000000000..e63bc2e7f7c1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n69u.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE (Samsung), N69u, iPhone8,4 (A1662/A1723/A1724)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-se.dtsi"
+
+/ {
+	compatible = "apple,n69u", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone SE (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000-n71.dts b/arch/arm64/boot/dts/apple/s8000-n71.dts
new file mode 100644
index 000000000000..784d29c55374
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000-n71.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6S (Samsung), N71, iPhone8,1 (A1633/A1688/A1691/A1700)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8000.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n71", "apple,s8000", "apple,arm-platform";
+	model = "Apple iPhone 6S (Samsung)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8000.dtsi b/arch/arm64/boot/dts/apple/s8000.dtsi
new file mode 100644
index 000000000000..19629ae8af2b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8000.dtsi
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8000 "A9 (Samsung)" SoC
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
+		/* To be filled in by the bootloader (based on XNU BootArgs). */
+		reg = <0x8 0 0 0>;
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
+			interrupts = <AIC_IRQ 192 IRQ_TYPE_LEVEL_HIGH>;
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
+			gpio-ranges = <&pinctrl_ap 0 0 208>;
+			apple,npins = <208>;
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
+			gpio-ranges = <&pinctrl_aop 0 0 42>;
+			apple,npins = <42>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 119 IRQ_TYPE_LEVEL_HIGH>;
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
+		/* Note that A9 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+/*
+ * The A9 was made by two separate fabs on two different process
+ * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
+ * the S8003 (APL1022) on 16nm. While they are seemingly the same,
+ * they do have distinct part numbers and devices using them have
+ * distinct model names. There are currently no known differences
+ * between these as far as Linux is concerned, but let's keep things
+ * structured properly to make it easier to alter the behaviour of
+ * one of the chips if need be.
+ */
diff --git a/arch/arm64/boot/dts/apple/s8003-j71t.dts b/arch/arm64/boot/dts/apple/s8003-j71t.dts
new file mode 100644
index 000000000000..0d906ae80b07
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-j71t.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Wi-Fi) (TSMC), J71t, iPad6,11 (A1822)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j71t", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPad 5 (Wi-Fi) (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-j72t.dts b/arch/arm64/boot/dts/apple/s8003-j72t.dts
new file mode 100644
index 000000000000..0cd7d88e9dfb
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-j72t.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 (Cellular) (TSMC), J72t, iPad6,12 (A1823)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-ipad5.dtsi"
+
+/ {
+	compatible = "apple,j72t", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPad 5 (Cellular) (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n66m.dts b/arch/arm64/boot/dts/apple/s8003-n66m.dts
new file mode 100644
index 000000000000..99eee8531da3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n66m.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6S Plus (TSMC), N66m, iPhone8,2 (A1634/A1687/A1690/A1699)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n66m", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone 6S Plus (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n69.dts b/arch/arm64/boot/dts/apple/s8003-n69.dts
new file mode 100644
index 000000000000..8eed879b155e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n69.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE (TSMC), N69, iPhone8,4 (A1662/A1723/A1724)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-se.dtsi"
+
+/ {
+	compatible = "apple,n69", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone SE (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003-n71m.dts b/arch/arm64/boot/dts/apple/s8003-n71m.dts
new file mode 100644
index 000000000000..b841fe4433d1
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003-n71m.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6S (TSMC), N71m, iPhone8,1 (A1633/A1688/A1691/A1700)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "s8003.dtsi"
+#include "s800x-6s.dtsi"
+
+/ {
+	compatible = "apple,n71m", "apple,s8003", "apple,arm-platform";
+	model = "Apple iPhone 6S (TSMC)";
+};
diff --git a/arch/arm64/boot/dts/apple/s8003.dtsi b/arch/arm64/boot/dts/apple/s8003.dtsi
new file mode 100644
index 000000000000..52094a634678
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8003.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple S8003 "A9 (TSMC)" SoC
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "s8000.dtsi"
+
+/*
+ * The A9 was made by two separate fabs on two different process
+ * nodes: Samsung made the S8000 (APL0898) on 14nm and TSMC made
+ * the S8003 (APL1022) on 16nm. While they are seemingly the same,
+ * they do have distinct part numbers and devices using them have
+ * distinct model names. There are currently no known differences
+ * between these as far as Linux is concerned, but let's keep things
+ * structured properly to make it easier to alter the behaviour of
+ * one of the chips if need be.
+ */
diff --git a/arch/arm64/boot/dts/apple/s800x-6s.dtsi b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
new file mode 100644
index 000000000000..7b217fca8aff
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-6s.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6S / 6S Plus common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 67 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 66 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl_ap 149 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
new file mode 100644
index 000000000000..1a921e9d77c3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 5 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 143 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 144 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/s800x-se.dtsi b/arch/arm64/boot/dts/apple/s800x-se.dtsi
new file mode 100644
index 000000000000..c2b9ad90e88f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s800x-se.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone SE common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 96 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 67 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 66 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl_ap 149 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
-- 
2.46.0


