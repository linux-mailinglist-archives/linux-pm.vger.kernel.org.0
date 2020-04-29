Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04891BE943
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2U6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41450 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgD2U6a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so2977995otp.8;
        Wed, 29 Apr 2020 13:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+TgxwbB2Dl7ZPjDzyWggOx4otMnZDta1bvf94cBc94=;
        b=Y01huYEL+lfO6cY8suwckndlLyrQY0WelTlCXwolbAounNqfP/4ky3j0l8zyW5OlrK
         4JlRM6gS+kCimvmbZ+JnSyaqgdcnBJJYikGuamI4RHPhFovoIrqpB3Z0cnMmu1hAE6oc
         RkepiiTHpNcsVy3gbnjQCiEF5u4Cn/xL33zmnrIUM5jkhzsmqkM1rWOiv/Ep+T1E/phP
         ioBdKEt9Lv5x+x6jo3rSQoZ51tXvlHHJs7veU2hLkxY+0Kmk+H9ZsWL1Sk0dl/2t4DLb
         CJugZiqiJ1IJT4zBg3csPn3YvbjWbFwW2RnrH7n+6sSwD5OKjB96eS8W9gNgmof3yR3M
         D1og==
X-Gm-Message-State: AGi0PuZTYy4UnrDuzlbuMAp3DnN0d7+8tk7G0Z5MWbARJgH7Fn/ghC9z
        3//KgBvi7R+F2S0yJhVJkA==
X-Google-Smtp-Source: APiQypJBRfyZPy1x2+wmhpnE8ByJYQPJyS6MhU4mFvIB5u0UOWmSacZq2fGsL82wlHmlRmCQ0Y+0Tw==
X-Received: by 2002:a9d:6754:: with SMTP id w20mr26876095otm.10.1588193909174;
        Wed, 29 Apr 2020 13:58:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 01/16] ARM: vexpress: Move vexpress_flags_set() into arch code
Date:   Wed, 29 Apr 2020 15:58:10 -0500
Message-Id: <20200429205825.10604-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

vexpress_flags_set() is only used by the platform SMP related code and
has nothing to do with the vexpress-sysreg MFD driver other than both
access the same h/w block. It's also only needed for 32-bit systems and
must be built-in for them. Let's move vexpress_flags_set() closer to
where it is being used. This will allow for vexpress-sysreg to be built
as a module.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-vexpress/Kconfig |  1 -
 arch/arm/mach-vexpress/core.h  |  1 +
 arch/arm/mach-vexpress/dcscb.c |  1 +
 arch/arm/mach-vexpress/v2m.c   | 23 +++++++++++++++++++++++
 drivers/mfd/vexpress-sysreg.c  | 19 -------------------
 include/linux/vexpress.h       |  4 ----
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 726a68085c3b..18951cd20d9d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -22,7 +22,6 @@ menuconfig ARCH_VEXPRESS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
 	select VEXPRESS_SYSCFG
-	select MFD_VEXPRESS_SYSREG
 	help
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index f4a7519084f1..bda78675c55d 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -1,3 +1,4 @@
 bool vexpress_smp_init_ops(void);
+void vexpress_flags_set(u32 data);
 
 extern const struct smp_operations vexpress_smp_dt_ops;
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 46a903c88c6a..a0554d7d04f7 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -20,6 +20,7 @@
 #include <asm/cputype.h>
 #include <asm/cp15.h>
 
+#include "core.h"
 
 #define RST_HOLD0	0x0
 #define RST_HOLD1	0x4
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 95886b3bb9dd..ffe7c7a85ae9 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -1,8 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <asm/mach/arch.h>
 
 #include "core.h"
 
+#define SYS_FLAGSSET		0x030
+#define SYS_FLAGSCLR		0x034
+
+void vexpress_flags_set(u32 data)
+{
+	static void __iomem *base;
+
+	if (!base) {
+		struct device_node *node = of_find_compatible_node(NULL, NULL,
+				"arm,vexpress-sysreg");
+
+		base = of_iomap(node, 0);
+	}
+
+	if (WARN_ON(!base))
+		return;
+
+	writel(~0, base + SYS_FLAGSCLR);
+	writel(data, base + SYS_FLAGSSET);
+}
+
 static const char * const v2m_dt_match[] __initconst = {
 	"arm,vexpress",
 	NULL,
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index c68ff56dbdb1..0b9cc67706c7 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -8,7 +8,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
@@ -42,24 +41,6 @@
 
 #define SYS_MISC_MASTERSITE	(1 << 14)
 
-void vexpress_flags_set(u32 data)
-{
-	static void __iomem *base;
-
-	if (!base) {
-		struct device_node *node = of_find_compatible_node(NULL, NULL,
-				"arm,vexpress-sysreg");
-
-		base = of_iomap(node, 0);
-	}
-
-	if (WARN_ON(!base))
-		return;
-
-	writel(~0, base + SYS_FLAGSCLR);
-	writel(data, base + SYS_FLAGSSET);
-}
-
 /* The sysreg block is just a random collection of various functions... */
 
 static struct syscon_platform_data vexpress_sysreg_sys_id_pdata = {
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 0e130b5077a5..2ec7992b054c 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -40,8 +40,4 @@ struct device *vexpress_config_bridge_register(struct device *parent,
 
 struct regmap *devm_regmap_init_vexpress_config(struct device *dev);
 
-/* Platform control */
-
-void vexpress_flags_set(u32 data);
-
 #endif
-- 
2.20.1

