Return-Path: <linux-pm+bounces-13998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE57974D4E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1112C1C251E9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3818C930;
	Wed, 11 Sep 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKUMZs9c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FD18BBA8;
	Wed, 11 Sep 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044481; cv=none; b=i9uaHL3N9Xl3WlGDwUrGb1pgMcM+4YbZThAKienRArHF0GCzsk38cMSy3a927hC6TA14JFZgMw3NgeQOdWtPEdSoeNDrayM3PUaO5qmxb1WpTAc5Er0+H19O0097CKFEIOPt0wmewiIaZORkw7A2lG7fbfxOQ9OusGzO+qnX75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044481; c=relaxed/simple;
	bh=okgKPtFZUp4gKzTGJP+LnW0sMxf+fIfRCxPNlz2Kaqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRODr4Hxm8R2QXagV3CLQ/c/3+OhXpcZ5P1UPQto72773KmO4ESbIv4SUBCr/gLsyqNs5+Y8uCy31Xelxetj3+6PGElGq9qc2bZ6EhgSxiP7eEASxwCroQs+aS+lpcBZmMBi/mgcNzzgcn3vrLPdON40Ohw+yfbHMIP/XWsn2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKUMZs9c; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d50a42ce97so785134a12.0;
        Wed, 11 Sep 2024 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044479; x=1726649279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZAP3lPiMNUTmbYMZYfeFAX+IAjbYEnzidSla+NMtqs=;
        b=UKUMZs9csPxgAU/CQwM2w7E6dAxXE2P8jHYJbS4muVOGYLCERxSG2PqNqHJIcD5DMT
         /xCYaHta87ZgnQcCg99iZYN0439l9vl5RSiiNpTDdOPG41bWp89Mka4FLalhhkcQ57C5
         3xpkdM6ND0Dhhjqovj7XU80PUtbByIvSP3kqRv/8UfJceYDF9dohzVKGLLyxCYAEJvuV
         Obkx0gdhtgkenMeM+0wCup5ZNb33jiHnLFsn1hG/yVT1/qGofXUwj+gawhCJxZmP4aKj
         lSPm1HKCqkhOZBYI1fBFBbEmGrWO2bd+lekXpfGbdBLMIRu7hJEE9evpZy93XZ2BGRdf
         UZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044479; x=1726649279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZAP3lPiMNUTmbYMZYfeFAX+IAjbYEnzidSla+NMtqs=;
        b=ODe1qfVf6xsuJEDG5VVSkHRVeGqduCpL6oNJN1ikJZRFNZQ+15Et/W+XtzlWSHP5Mk
         L7I87IrxFQWDhlOBad1KF8ArHT8lVP/U9R2/PCAbhyiTsT8X3mXp5meW7b30NFpul+Bs
         G3Pe116SfxCGhwljJgGfq7xsFYFkyhlvtT/lBu7y+iUzD1WJm7t2GdxbqAFX2hgzd/ck
         UtYbMeiD+Vpk/PiblFRwpAn1CxgHXvB40rSewH9m0QnV+ZShl9uFscgqL7K3MD9Iw6g1
         V3c94EwI+nJg9J5DPsJW+fmX3eLxUbzQjaxzUXbIn9hvmANcYqYo9gFVwm+6L5s/Qvzt
         8S6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGomQWodwP9QFHHqs6OaGbsfQOjS9r6oDKU6tp14Wd60FU3caCCDOUNtzFHOUXVUBOzm3ifFoHW+XE@vger.kernel.org, AJvYcCUYMnBFRRf/DTy/1affgzzB1HwBteTRpEI057VkpDEYcPWAnKRBpX1ZuAy1h59Fk3Qk96VuB+vV2Q1XiciyUL4=@vger.kernel.org, AJvYcCUuHxGY0Rs6+MaVkyv96BoOmibEX/GPobPS7meFxTqQDBoSSrjzGcHWo4oDjfaE6c0aM1TXMk0hA/I=@vger.kernel.org, AJvYcCXDfrx1vATFWBzfdQNHDJFqx/5RhCrXyfmJWghSEOykgVbsdXSvcDG8XqKP+TQwhI3K84mGpphBiDm7WTJ3@vger.kernel.org, AJvYcCXuQJW8peZ+wwqbxUAKD0z9//CIUvc6z986S0D2YxOkt1iPp1mauGlsj7NRTCRNxSNyXHf0qyUGB7aAjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0HruuLrCTYIgqA2ygB5q3qWBT6EUHsxQRioYBXd9yM7jm+I7
	vMWqUEq2QD3ZN3/hJtw2Al+BjUpc7XfHKc00AAxiSATvPT2UUamK
X-Google-Smtp-Source: AGHT+IGb89HL0C3ohs6NxwONCIs6cyxJOZ4pZK0PzHC6Ibl7Q9ub2uMI11gaVFkkojHNZUPZSio2AA==
X-Received: by 2002:a05:6a21:4581:b0:1cf:5155:cb5c with SMTP id adf61e73a8af0-1cf62d5ca33mr3803475637.34.1726044478788;
        Wed, 11 Sep 2024 01:47:58 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:58 -0700 (PDT)
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
Subject: [PATCH 14/22] arm64: dts: apple: Add A8 devices
Date: Wed, 11 Sep 2024 16:41:04 +0800
Message-ID: <20240911084353.28888-16-towinchenmi@gmail.com>
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

Add DTS files for the A8 SoC and the following devices based on it:

 - iPhone 6
 - iPhone 6 Plus
 - iPad Mini 4
 - iPod Touch 6
 - Apple TV HD

The remaining HomePod is not supported as part of this patch.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Nick: SMP and m1n1 support, gpio-keys additions]
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/Makefile         |   6 +
 arch/arm64/boot/dts/apple/t7000-6.dtsi     |  50 +++++++
 arch/arm64/boot/dts/apple/t7000-j42d.dts   |  18 +++
 arch/arm64/boot/dts/apple/t7000-j96.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-j97.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi |  51 +++++++
 arch/arm64/boot/dts/apple/t7000-n102.dts   |  49 +++++++
 arch/arm64/boot/dts/apple/t7000-n56.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000-n61.dts    |  14 ++
 arch/arm64/boot/dts/apple/t7000.dtsi       | 147 +++++++++++++++++++++
 10 files changed, 377 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index e1ee803f72a7..d5dd1e2e4f4c 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -10,6 +10,12 @@ dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j85.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j86.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-j87.dtb
 dtb-$(CONFIG_ARCH_APPLE) += s5l8960x-n51.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j42d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j96.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-j97.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n102.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n56.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t7000-n61.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j274.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j293.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8103-j313.dtb
diff --git a/arch/arm64/boot/dts/apple/t7000-6.dtsi b/arch/arm64/boot/dts/apple/t7000-6.dtsi
new file mode 100644
index 000000000000..8aa3ad8ac0e2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-6.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6 / 6 Plus common device tree
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include <dt-bindings/input/input.h>
+#include "t7000.dtsi"
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl 131 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j42d.dts b/arch/arm64/boot/dts/apple/t7000-j42d.dts
new file mode 100644
index 000000000000..222e0bf7dd96
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j42d.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple TV HD, J42d, AppleTV5,3 (A1625)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000.dtsi"
+
+/ {
+	compatible = "apple,j42d", "apple,t7000", "apple,arm-platform";
+	model = "Apple TV HD";
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j96.dts b/arch/arm64/boot/dts/apple/t7000-j96.dts
new file mode 100644
index 000000000000..98d5b8437e0d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j96.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Mini 4 (Wi-Fi), J96, iPad5,1 (A1538)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-mini4.dtsi"
+
+/ {
+	compatible = "apple,j96", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPad Mini 4 (Wi-Fi)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j97.dts b/arch/arm64/boot/dts/apple/t7000-j97.dts
new file mode 100644
index 000000000000..7cae598b7428
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-j97.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Mini 4 (Cellular), J97, iPad5,2 (A1550)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-mini4.dtsi"
+
+/ {
+	compatible = "apple,j97", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPad Mini 4 (Cellular)";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
new file mode 100644
index 000000000000..f987e5f6116e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Mini 4 common device tree
+ *
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+#include "t7000.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		switch-mute {
+			label = "Mute Switch";
+			gpios = <&pinctrl 36 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MUTE>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n102.dts b/arch/arm64/boot/dts/apple/t7000-n102.dts
new file mode 100644
index 000000000000..1b88cf4c3cdc
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n102.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod Touch 6, N102, iPod7,1 (A1574)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "t7000.dtsi"
+
+/ {
+	compatible = "apple,n102", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPod Touch 6";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-home {
+			label = "Home Button";
+			gpios = <&pinctrl 32 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "Power Button";
+			gpios = <&pinctrl 33 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-voldown {
+			label = "Volume Down";
+			gpios = <&pinctrl 46 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volup {
+			label = "Volume Up";
+			gpios = <&pinctrl 45 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n56.dts b/arch/arm64/boot/dts/apple/t7000-n56.dts
new file mode 100644
index 000000000000..2c358df14458
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n56.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6 Plus, N56, iPhone7,2 (A1549/A1586/A1589)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-6.dtsi"
+
+/ {
+	compatible = "apple,n56", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPhone 6 Plus";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n61.dts b/arch/arm64/boot/dts/apple/t7000-n61.dts
new file mode 100644
index 000000000000..10b4ca8babf7
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-n61.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPhone 6, N61, iPhone7,2 (A1549/A1586/A1589)
+ * Copyright (c) 2022, Konrad Dybcio <konradybcio@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "t7000-6.dtsi"
+
+/ {
+	compatible = "apple,n61", "apple,t7000", "apple,arm-platform";
+	model = "Apple iPhone 6";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
new file mode 100644
index 000000000000..055a878f78d3
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T7000 "A8" SoC
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
+			compatible = "apple,typhoon";
+			reg = <0x0 0x0>;
+			cpu-release-addr = <0 0>; /* To be filled in by loader */
+			enable-method = "spin-table";
+			device_type = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "apple,typhoon";
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
+			interrupts = <AIC_IRQ 158 IRQ_TYPE_LEVEL_HIGH>;
+			/* Use the bootloader-enabled clocks for now. */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		wdt: watchdog@20e027000 {
+			compatible = "apple,t7000-wdt", "apple,wdt";
+			reg = <0x2 0x0e027000 0x0 0x1000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		aic: interrupt-controller@20e100000 {
+			compatible = "apple,t7000-aic", "apple,aic";
+			reg = <0x2 0x0e100000 0x0 0x100000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl: pinctrl@20e300000 {
+			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x0e300000 0x0 0x100000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 208>;
+			apple,npins = <208>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 68 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt";
+		/* Note that A8 doesn't actually have a hypervisor (EL2 is not implemented). */
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.46.0


