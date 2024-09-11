Return-Path: <linux-pm+bounces-14002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F12974D63
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128D21F21AA0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71719C549;
	Wed, 11 Sep 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQJNQpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DC192B88;
	Wed, 11 Sep 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044500; cv=none; b=QpEdHj8A9ClvMtuU3zx1PP2H2gxySz1PX5eKDHwbo1YUbbDw3S0uxfthKfeazzURWf5qnPHQx19iFP3qt2fQPIFQiBWI/vsN0jwRkIHZ16UO2PVsLHiictEMkD1BO73G1iehqtgxV6b0PVk3B1OIfSSUinSuNWGgWtgATjZhbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044500; c=relaxed/simple;
	bh=3qP1HEIKf8L7Nmt5bLYlrNwL2wK+uRPpa+D36zpotVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd1ii89hr5cwO3+zHYa7+1pthcFMONnBewlg8EyvvXfrQUe4JCEPmoQjhqLFnmels0L1tFKhxFxCPjXKqfTp8kMx5EI3qgJPBYza5mfHj1TzJxXFV1snKbBBW/M/x/OQB2bo8KbKdOaDvPTajajalMnbWEFsshy+mwz+t1/zcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQJNQpe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718f28f77f4so1569681b3a.1;
        Wed, 11 Sep 2024 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044498; x=1726649298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o99/dcbaPQTxg45A+GuzWtK1lIPTqcfpcz1ky0uPQyc=;
        b=EhQJNQpeDbyR5P2LjX/1qB05YiRNHxizN0v0vq+f3TB1WADxVZbeEobbNALuOgrW2B
         9ffS3miLIj6iSI3zHzLYl2ELe7tdHjIZuf29HYbc6qqf+Pq7C/46m7cwQ47nc7i4f5GG
         zI6jjgvNAFvjz/VVkYjpmfXn2Yo2JTOsseiZRXcmI5vOtkQw1ZnYfXtS9envw70qvvzl
         Qs4hF/pW+o/kTCBCc+qjnyIkxyc7BKnXgdKi5WSar0k0oDF89CY1IdGgzub9NMpBd0j9
         Y5wjonCuhS94+EQpNY+khsa9gxz3Ej5/6ksShuz+PKzq4IERXzxPLmDUZi6wFEMshsva
         xohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044498; x=1726649298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o99/dcbaPQTxg45A+GuzWtK1lIPTqcfpcz1ky0uPQyc=;
        b=Brsv+SqETMIwHFXVte6GR3SBnB0it1ARRK6U/3kOZ2F4Bk4tWNn6Y1Ah8mR+LpAEJd
         G6ZZA7AHedGSRLLuw8aEj81QpkMOChNl98Ozz/obcqGnJxI+SBiQAU3enP5UcOZ9ZwZ4
         OtJMmn6g6PzDFck3X8fQqfiqyhqJ7PI1HURNhu7l4TkJQijI9m8lbuj3qyY7bLDbksrI
         kcfcd46RLqoIfsoH3q9piI9Ss0NdMhSfCZkt43JKhZbtOIu+pVGWOv3TZwjtF9N8XMtr
         FXEQsImyyz7L+LT7yFnBZtRwvurNKPiUOWs6N7VKesmLbMtWh5ksfPobD1s1RC66ftU1
         5f/g==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q2ozHVPgy9Wu87PvHUvjpk0YBo/Mn0Ir7/thXNZktbtr0BxBt/RqlrhOTBA+GeegM9Y7DPI094uZAQ==@vger.kernel.org, AJvYcCWGSQgHi1Ruyl803zb3rcvmESX+adYm1kFb34jraiOrBkKRSmZY0LxT/9U0KIfu6o9YCgJ/pTL3X1rl@vger.kernel.org, AJvYcCWJdTlXslN8zgEiAco7PpFYsB3iM83KBl7wsdu3DpD6Xmpd6oBJbzy3G9gPpNN5HcFImUHeNA2wmomk+fqb@vger.kernel.org, AJvYcCXCJ5tyQy1BDXZMc/rHaVvpxh3uqALaUBScSKx6n7TSuvircxU53s+EII2jk3zwYhWsbiGqj+yBiRs=@vger.kernel.org, AJvYcCXVbKHlJdxNherv2Td39l4tP/2Nn2FaCzoIJ0vxDh+3E87gH36G5+kygrJ/c2eHmt9ys74R3VmRy1JiEUPwQhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NPqxH4AwdNMPwVODXkRnK/lxg+ig84Uvk4dwxFwUj6TqtelE
	XGXTPXE7cw0JoJHmJre61onxnfQ2otaQUpMxPtgdMfS8BS7CEPeb
X-Google-Smtp-Source: AGHT+IGTEcDbBmwgiXnsPfjLB6fsnfRpWNiDJUrxS+t90AoLcJsDVRlKmqfREacadG9QvyMDCS+kBA==
X-Received: by 2002:a05:6a00:6f68:b0:718:ddd9:a8fa with SMTP id d2e1a72fcca58-71916df7070mr3022287b3a.16.1726044497513;
        Wed, 11 Sep 2024 01:48:17 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:17 -0700 (PDT)
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
Subject: [PATCH 18/22] arm64: dts: apple: Add A10 devices
Date: Wed, 11 Sep 2024 16:41:08 +0800
Message-ID: <20240911084353.28888-20-towinchenmi@gmail.com>
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

Add DTS files for the A10 SoC and the following devices based on it:

- iPhone 7
- iPhone 7 Plus
- iPod Touch 7
- iPad 6
- iPad 7

iPod Touch 7 only supports up to 1.64 GHz, so it includes t8010.dtsi
directly, and other devices will include t8010-fast.dtsi.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP, m1n1 and AOP pinctrl support]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |   9 ++
 arch/arm64/boot/dts/apple/t8010-7.dtsi     |  45 ++++++
 arch/arm64/boot/dts/apple/t8010-d10.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8010-d101.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-d11.dts    |  14 ++
 arch/arm64/boot/dts/apple/t8010-d111.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-fast.dtsi  |   8 +
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi |  45 ++++++
 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi |  15 ++
 arch/arm64/boot/dts/apple/t8010-j171.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-j172.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-j71b.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-j72b.dts   |  14 ++
 arch/arm64/boot/dts/apple/t8010-n112.dts   |  48 ++++++
 arch/arm64/boot/dts/apple/t8010.dtsi       | 167 +++++++++++++++++++++
 15 files changed, 449 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-fast.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index f8cd10889d9f..4a7002e289a0 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -32,6 +32,15 @@ dtb-$(CONFIG_ARCH_APPLE) += s8001-j127.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8001-j128.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8001-j98a.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s8001-j99a.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-d101.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-d10.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-d111.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-d11.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-j171.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-j172.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-j71b.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-j72b.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8010-n112.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t8010-7.dtsi b/arch/arm64/boot/dts/apple/t8010-7.dtsi
new file mode 100644
index 000000000000..a33b911a3b61
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-7.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 7 / 7 Plus common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8010-fast.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 179 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 180 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl_ap 86 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-d10.dts b/arch/arm64/boot/dts/apple/t8010-d10.dts
new file mode 100644
index 000000000000..39cdd12db6bf
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-d10.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 7 (Qualcomm), D10, iPhone9,1 (A1660/A1778/A1779/A1780)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-7.dtsi"
+
+/ {
+	compatible = "apple,d10", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPhone 7 (Qualcomm)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-d101.dts b/arch/arm64/boot/dts/apple/t8010-d101.dts
new file mode 100644
index 000000000000..6a9f0856f930
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-d101.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 7 (Intel), D101, iPhone9,3 (A1660/A1778/A1779/A1780)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-7.dtsi"
+
+/ {
+	compatible = "apple,d101", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPhone 7 (Intel)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-d11.dts b/arch/arm64/boot/dts/apple/t8010-d11.dts
new file mode 100644
index 000000000000..57e41c2cfbe2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-d11.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 7 Plus (Qualcomm), D11, iPhone9,2 (A1661/A1784/A1785/A1786)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-7.dtsi"
+
+/ {
+	compatible = "apple,d11", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPhone 7 Plus (Qualcomm)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-d111.dts b/arch/arm64/boot/dts/apple/t8010-d111.dts
new file mode 100644
index 000000000000..37e395a48c1d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-d111.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 7 Plus (Intel), D111, iPhone9,4 (A1661/A1784/A1785/A1786)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-7.dtsi"
+
+/ {
+	compatible = "apple,d111", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPhone 7 Plus (Intel)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-fast.dtsi b/arch/arm64/boot/dts/apple/t8010-fast.dtsi
new file mode 100644
index 000000000000..4bdf1c3eccfe
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-fast.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple T8010 "A10" common device tree for non-iPod touch 7 devices
+ *
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+
+#include "t8010.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8010-ipad6.dtsi b/arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
new file mode 100644
index 000000000000..516fa798cb6a
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 6 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8010-fast.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 180 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 179 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 89 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 90 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-ipad7.dtsi b/arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
new file mode 100644
index 000000000000..3ff93a2b5b37
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 7 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t8010-fast.dtsi"
+
+/*
+ * The iPad 7 seems to be only an iteration over the iPad 6 with some small changes, like the
+ * a bigger screen and 1 GiB of RAM more, hence there is little to no differentiation between
+ * these 2 generations for now.
+ */
+#include "t8010-ipad6.dtsi"
diff --git a/arch/arm64/boot/dts/apple/t8010-j171.dts b/arch/arm64/boot/dts/apple/t8010-j171.dts
new file mode 100644
index 000000000000..6751bf3a4afd
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-j171.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 7 (Wi-Fi), J171, iPad7,11 (A2197)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-ipad7.dtsi"
+
+/ {
+	compatible = "apple,j171", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPad 7 (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-j172.dts b/arch/arm64/boot/dts/apple/t8010-j172.dts
new file mode 100644
index 000000000000..51aaa950acd9
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-j172.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 7 (Cellular), J172, iPad7,12 (A2198/A2200)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-ipad7.dtsi"
+
+/ {
+	compatible = "apple,j172", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPad 7 (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-j71b.dts b/arch/arm64/boot/dts/apple/t8010-j71b.dts
new file mode 100644
index 000000000000..534eb8413e08
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-j71b.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 6 (Wi-Fi), J71b, iPad7,5 (A1893)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-ipad6.dtsi"
+
+/ {
+	compatible = "apple,j71b", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPad 6 (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-j72b.dts b/arch/arm64/boot/dts/apple/t8010-j72b.dts
new file mode 100644
index 000000000000..264924e41f42
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-j72b.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad 6 (Cellular), J72b, iPad7,6 (A1954)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010-ipad6.dtsi"
+
+/ {
+	compatible = "apple,j72b", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPad 6 (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010-n112.dts b/arch/arm64/boot/dts/apple/t8010-n112.dts
new file mode 100644
index 000000000000..25658d59709a
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010-n112.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod Touch 7, N112, iPod9,1 (A2178)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t8010.dtsi"
+
+/ {
+	compatible = "apple,n112", "apple,t8010", "apple,arm-platform";
+	model = "Apple iPod Touch 7";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl_ap 86 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl_ap 179 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl_ap 180 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl_ap 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
new file mode 100644
index 000000000000..926a0f501477
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple T8010 "A10" SoC
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
+			compatible = "apple,hurricane-zephyr";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,hurricane-zephyr";
+			reg = <0x0 0x1>;
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x8 0 0 0>; /* To be filled by loader */
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
+			compatible = "apple,t8010-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl_ap: pinctrl@20f100000 {
+			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
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
+			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
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
+			compatible = "apple,t8010-wdt", "apple,wdt";
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
+		/* Note that A10 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


