Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060AA1AFC58
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDSRIW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32817 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDSRIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so5980694ots.0;
        Sun, 19 Apr 2020 10:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dfjp1gZuZ5vkk5hbQ7tBLiYF+WukIQyW6RLLpGIIUfY=;
        b=MYyYf8f5dqDnsQwkuWfkfzjYlQqeTD9AY1ZT8yzIDX2LxD1ENgHfNahyIZm13zobJ0
         kyElrfE591p0OKFphmE7D1lhoXrLWzabQuswyr17HhAz06ZqeXkqkDaqCYZydaF4qCm2
         fG4SlqX6jGH9Avfx4qhy/h0x+aYQaSNsiCrKOZ+pdo9sa/Vir0sjRmWnNNxumDCXHqxp
         D64/mQiCri2mPnicgJ2oteYAcSnHls+NRiy8qlM08AgeVtC941LpbSsSknb/EG7/m/hh
         ClnO+UZeAF5V2Ye240ovs3vbnuix5rnSjikaeAPDQkUyLIQkHLgHYz3nP0opPWoZr4aH
         +1sQ==
X-Gm-Message-State: AGi0PuZ2iTMjGX/twhwvAfMSr+lD3dLF86g44cL3R2UYMhVr51lzujtn
        oUwwW+vZ2EOoFXQpFslV4w==
X-Google-Smtp-Source: APiQypIPS0+XDNzclSv4AnGvJhw/FAlVfJCrCq8sLXv1l6bDtJmCpkeDjmWLFW1j0V9Ur0kffusBUQ==
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr6856344otk.232.1587316099983;
        Sun, 19 Apr 2020 10:08:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 05/17] clk: versatile: Kill CONFIG_COMMON_CLK_VERSATILE
Date:   Sun, 19 Apr 2020 12:07:58 -0500
Message-Id: <20200419170810.5738-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_COMMON_CLK_VERSATILE doesn't really do anything other than hiding
Arm Ltd reference platform clock drivers. It is both selected by the
platforms that need it and has a 'depends on' for those platforms. It
selects REGMAP_MMIO, but really CONFIG_ICST should do that. Also,
CONFIG_ICST can't be enabled for COMPILE_TEST unless something else
selected it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-integrator/Kconfig |  1 -
 arch/arm/mach-realview/Kconfig   |  1 -
 arch/arm/mach-versatile/Kconfig  |  1 -
 arch/arm/mach-vexpress/Kconfig   |  1 -
 arch/arm64/Kconfig.platforms     |  1 -
 drivers/clk/Makefile             |  2 +-
 drivers/clk/versatile/Kconfig    | 13 ++-----------
 7 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 982eabc36163..d59ba15a6b69 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -3,7 +3,6 @@ menuconfig ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
 	select ARM_AMBA
-	select COMMON_CLK_VERSATILE
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index e7633c0aaae7..83ec9eeb3e5f 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -6,7 +6,6 @@ menuconfig ARCH_REALVIEW
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select CLK_SP810
-	select COMMON_CLK_VERSATILE
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index f5c275434d6c..d88e7725bf99 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -6,7 +6,6 @@ config ARCH_VERSATILE
 	select ARM_TIMER_SP804
 	select ARM_VIC
 	select CLKSRC_VERSATILE
-	select COMMON_CLK_VERSATILE
 	select CPU_ARM926T
 	select ICST
 	select MFD_SYSCON
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 18951cd20d9d..2d1fdec4c230 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -7,7 +7,6 @@ menuconfig ARCH_VEXPRESS
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
-	select COMMON_CLK_VERSATILE
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 5c38dc56b808..25cbb556d863 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,7 +274,6 @@ config ARCH_UNIPHIER
 
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
-	select COMMON_CLK_VERSATILE
 	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc2fd31..fb30c16e1596 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -114,7 +114,7 @@ obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
-obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
+obj-y					+= versatile/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_X86)			+= x86/
 endif
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index c2618f1477a2..3465fb291998 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,22 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ICST
-	bool
-
-config COMMON_CLK_VERSATILE
-	bool "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
-		ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
-		COMPILE_TEST
+	bool "Clock driver for ARM Reference designs ICST" if COMPILE_TEST
 	select REGMAP_MMIO
 	---help---
 	  Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
 	  - RealView PB1176, EB, PB11MP and PBX
-	  - Versatile Express
 
 config CLK_SP810
 	bool "Clock driver for ARM SP810 System Controller"
-	depends on COMMON_CLK_VERSATILE
 	default y if ARCH_VEXPRESS
 	---help---
 	  Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
@@ -24,8 +16,7 @@ config CLK_SP810
 
 config CLK_VEXPRESS_OSC
 	bool "Clock driver for Versatile Express OSC clock generators"
-	depends on COMMON_CLK_VERSATILE
-	depends on VEXPRESS_CONFIG
+	depends on VEXPRESS_CONFIG || COMPILE_TEST
 	default y if ARCH_VEXPRESS
 	---help---
 	  Simple regmap-based driver driving clock generators on Versatile
-- 
2.20.1

