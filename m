Return-Path: <linux-pm+bounces-14004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D4974D6D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B884C2882F0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537119CC2C;
	Wed, 11 Sep 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffe7larh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C619CC08;
	Wed, 11 Sep 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044509; cv=none; b=tjS4Bk+oeWBo8wg4n9i+veXn5Yx1MsQ8wYpHCMtSFKTuFbgNexeHy2yEED1taUEo1te1fVaZVclv8JTE2g2RiLSaS+vP7a+93xNDAZt9RFTgpAQnv6UCexfPJIU+aYSJYX+TYXydLPCO1LbQhlAe5bxW9K3BcSf4bC+f2O/R+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044509; c=relaxed/simple;
	bh=B5Rs88tU8EnF5fpe+yMqVLcyRcTyleD03Mz6tAWkX14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/s2Z81KG0rH6mrAHElC/Iu86U3tQhfJ/7A5EUN2Rg5KVHhr81jEFR5KpxUpp14ZwT/PpUS4LGGsT/eRJHApPBm6l01VEh7Pn7uBh3bUQWABNf0BSUBExzKb5DKjEvDdbKRv//hck8Wm9WtKQa2jwitOl5VNnl7igeKD14gb4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffe7larh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so544989a12.1;
        Wed, 11 Sep 2024 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044507; x=1726649307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzQYWuEaVXYhnBc3uDFgcoEPC/fjWazsHzRttihTb6E=;
        b=Ffe7larhre5cYgljaz3av+qUPv9wDRXS6qm9XW5a22QqrPUx6T/ySHrVxg6qg1ovvR
         bAQ3bFXPC9V7o+ln62mkE7ex4QKsecusgcs494kyE9CO63jzg1g78eUWH5hBFCQzmCwr
         MaP2Lza/FgQ7ZdlM9oKZ2btyIkgunc1usVY4HSDL52nidlIrMbaNQqr20DdT+FB8vmU0
         hczG/msHaUGbOgpltjS9dcyHKFjCbpp7ec4z4HXb47FnW0KXL6Am5DPFC0EJ99v5KNcz
         AV4YcQgKbxeEjLkGeTNkwcmktSes4xOiDXGJZG02ztnLR3u3Pi3OQutoHoGkVBbexZAY
         mK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044507; x=1726649307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzQYWuEaVXYhnBc3uDFgcoEPC/fjWazsHzRttihTb6E=;
        b=C/RNvHThOqL1BTBZuzauKxtppLTvg7f6PMda0m0vRjs4qBoQHgLEmolHSkZV5V3VJl
         6cYgS2qfC7NyVLPI7r3qFffluzesRprrBTwfHca4lYAWcr4tZi1irzsD1+keFgzVFond
         5daqMmSjYDQXHHW9uv5B5XzRRYpxxyW8wjtYLSa2ojt0YjHyvwY3ANRjz6LiFuwokFAL
         3Cz6/ui5Zx7PsDJIlWDFOv8hbu33ETI56ufqPEDeXInj4pDdROj0SXvSNKLtLg6CcbE4
         cY7syY7negrTBLayCgpPiEIfF5TuNBxvqTQ/MgTcEW4r/bGMQP3REsnc87s9o6LVFlFG
         x1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQK+AXRQKpgNMlPR9KdPdzmlWABb+vpm1zBJqAO+K/EWfvkikpEha2lVu/ho4yT2uxDKOun6v3K4o=@vger.kernel.org, AJvYcCUpr/9nUr1dR/BtSH+UhmBme9/h3TrTYiKhQkiSO22azSvI++Qm+wfkn1oyQMMoQIkCvMXflJ5hAy5aZUJ1@vger.kernel.org, AJvYcCVjxBBZR/dWeO7KVnF8T+xdKhKFtNerOMAxOU1ZJ4KWoX8Dp5lSEasarnxfHv748KkbT6fhk67zQRja@vger.kernel.org, AJvYcCXl3WyzEx5OgnPx8YY5jJM12PGJRTviANDBa0I18iwnH0csRzBZShMyvqlEOLE1AuwHc+q+XtJlk8p4fw==@vger.kernel.org, AJvYcCXuV+woRkyggRAn3skDragDORdqPbX0xc2qdHnN97MLNd1UZIx4NH69nxfwCPRsvwZ3naNzDl/HXXvJYsP4DDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1o7mFu5LjHWMnTkCpNsSDIPr0GZyYuPkMN5c4EZQ30nKdUcb
	aowUTYJw92wBYd2gnOp0qY7ppfGsZhXekuPC4amT3woRXCCWVoo0
X-Google-Smtp-Source: AGHT+IFuk9AU2EuuGx68oOM/W45WtyFCBEguIut2gccXf/8V0MbFOmGITpMa+Nd6QC81zsz2nPII8g==
X-Received: by 2002:a05:6a21:398d:b0:1cf:3816:d104 with SMTP id adf61e73a8af0-1cf5e3cf5d6mr6640419637.3.1726044507091;
        Wed, 11 Sep 2024 01:48:27 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:26 -0700 (PDT)
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
Subject: [PATCH 20/22] arm64: dts: apple: Add A11 devices
Date: Wed, 11 Sep 2024 16:41:10 +0800
Message-ID: <20240911084353.28888-22-towinchenmi@gmail.com>
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

Add DTS files for the A11 SoC and the following devices based on it:

- iPhone 8
- iPhone 8 Plus
- iPhone X

On A11, Apple has introduced independent performance and efficiency core
clusters, so indicate it in the device tree as well.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP and m1n1 support, disabled SMC pinctrl]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |   6 +
 arch/arm64/boot/dts/apple/t8015-8.dtsi     |  12 +
 arch/arm64/boot/dts/apple/t8015-8plus.dtsi |   9 +
 arch/arm64/boot/dts/apple/t8015-d20.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d201.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-d21.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d211.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-d22.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8015-d221.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8015-x.dtsi     |  15 ++
 arch/arm64/boot/dts/apple/t8015.dtsi       | 269 +++++++++++++++++++++
 11 files changed, 395 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index be66624aa6e0..e125c0d6b479 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -45,6 +45,12 @@ dtb-$(CONFIG_ARCH_APPLE) += t8011-j120.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j121.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j207.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8011-j208.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d201.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d20.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d211.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d21.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d221.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8015-d22.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t8015-8.dtsi b/arch/arm64/boot/dts/apple/t8015-8.dtsi
new file mode 100644
index 000000000000..b3cd96d343ed
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-8.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8015.dtsi"
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-8plus.dtsi b/arch/arm64/boot/dts/apple/t8015-8plus.dtsi
new file mode 100644
index 000000000000..ea291a95f028
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-8plus.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/* The 8 Plus has minor differences like 1 more camera, 1 GiB of RAM more and a bigger display. */
+#include "t8015-8.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8015-d20.dts b/arch/arm64/boot/dts/apple/t8015-d20.dts
new file mode 100644
index 000000000000..35d79e2ceebc
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d20.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 (Global), D20 iPhone10,1 (A1863/A1906/A1907)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8.dtsi"
+
+/ {
+	compatible = "apple,d20", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d201.dts b/arch/arm64/boot/dts/apple/t8015-d201.dts
new file mode 100644
index 000000000000..31e0947fee70
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d201.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 (GSM), D20 iPhone10,4 (A1905)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8.dtsi"
+
+/ {
+	compatible = "apple,d201", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d21.dts b/arch/arm64/boot/dts/apple/t8015-d21.dts
new file mode 100644
index 000000000000..a902ba7f1133
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d21.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus (Global), D21 iPhone10,2 (A1864/A1897/A1898)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8plus.dtsi"
+
+/ {
+	compatible = "apple,d21", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 Plus (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d211.dts b/arch/arm64/boot/dts/apple/t8015-d211.dts
new file mode 100644
index 000000000000..3b3f886c0c09
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d211.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 8 Plus (GSM), D211 iPhone10,5 (A1899)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-8plus.dtsi"
+
+/ {
+	compatible = "apple,d211", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone 8 Plus (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d22.dts b/arch/arm64/boot/dts/apple/t8015-d22.dts
new file mode 100644
index 000000000000..5a7a6092c2d0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d22.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X (Global), D22, iPhone10,3 (A1865)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-x.dtsi"
+
+/ {
+	compatible = "apple,d22", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone X (Global)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-d221.dts b/arch/arm64/boot/dts/apple/t8015-d221.dts
new file mode 100644
index 000000000000..dd920c945bd6
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-d221.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X (GSM), D221, iPhone10,6 (A1901)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8015-x.dtsi"
+
+/ {
+	compatible = "apple,d221", "apple,t8015", "apple,arm-platform";
+	model = "Apple iPhone X (GSM)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015-x.dtsi b/arch/arm64/boot/dts/apple/t8015-x.dtsi
new file mode 100644
index 000000000000..655cd89848a3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-x.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone X common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8015.dtsi"
+
+/ {
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
new file mode 100644
index 000000000000..aa0e948c9ed8
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T8015 "A11" SoC
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
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e0>;
+				};
+				core1 {
+					cpu = <&cpu_e1>;
+				};
+				core2 {
+					cpu = <&cpu_e2>;
+				};
+				core3 {
+					cpu = <&cpu_e3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p0>;
+				};
+				core1 {
+					cpu = <&cpu_p1>;
+				};
+			};
+		};
+
+		cpu_e0: cpu@0 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e1: cpu@1 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e2: cpu@2 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x2>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_e3: cpu@3 {
+			compatible = "apple,mistral";
+			reg = <0x0 0x3>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_p0: cpu@10004 {
+			compatible = "apple,monsoon";
+			reg = <0x0 0x10004>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu_p1: cpu@10005 {
+			compatible = "apple,monsoon";
+			reg = <0x0 0x10005>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
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
+		serial0: serial@22e600000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x2e600000 0x0 0x4000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 282 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		aic: interrupt-controller@232100000 {
+			compatible = "apple,t8015-aic", "apple,aic";
+			reg = <0x2 0x32100000 0x0 0x8000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@233100000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x33100000 0x0 0x1000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 223>;
+			apple,npins = <223>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 56 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@2340f0000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x340f0000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 49>;
+			apple,npins = <49>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 139 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 141 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_nub: pinctrl@2351f0000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x351f0000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_nub 0 0 8>;
+			apple,npins = <8>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 170 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdt: watchdog@2352b0000 {
+			compatible = "apple,t8015-wdt", "apple,wdt";
+			reg = <0x2 0x352b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 172 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@236024000 {
+			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x36024000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 6>;
+			apple,npins = <6>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 205 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * SMC is not yet supported and accessing this pinctrl while SMC is
+			 * off results in a hang. (To be enabled by SMC-aware loader)
+			 */
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A11 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


