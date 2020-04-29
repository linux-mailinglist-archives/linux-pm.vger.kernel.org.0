Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCC1BE94B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD2U6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35421 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id e26so3006313otr.2;
        Wed, 29 Apr 2020 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycrzTsN2UDt80PFGBLFquCxPRdusJ6s2yOMWOscpSM4=;
        b=EtjarPHuadfV1NbMBXYMoHbqWbIbcn3Swqbi+WnC26ajPHYcaYWVICl9zXEQ8a947J
         Sq2+0Dyfj7EbIQ+GfdAFTmPUUitqKoyPyb35bPvQwqfuP5XedtIQdYE9ICzX3KRDA9n5
         tmjlRdy4YQz5xZ99uWjdQ69wF8oyfJ2zM3o58qWSPEDG5kmiIqdy5slx5kg+P6ImPGOS
         1zJsHto9imFmJpKe7KpCRnKfREkOGYx7jaVPcZC7lzG59eGVFqun2NxmOrgKb5keX2vD
         jQ1U03k/6K4xF0w+5yCS9tEfDcSAQwQfbTgETcWFrZ8KWUp49CRPU8pRlkPzbLqyOEcZ
         LmcQ==
X-Gm-Message-State: AGi0PuY3ZLi408o8TD4VtcqLpa2NRvZC4hOJBewj2bIiDktAu2u5ISl1
        oaK7B8fJCe4RkOznzSoonQ==
X-Google-Smtp-Source: APiQypL4VnrXGZPah4Civ+Lm3BOCjh2M68S53+iKXITJryVzyn0lRjk1cF+ARDOewyDNk8HX1VAE3Q==
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr26756333otc.221.1588193914163;
        Wed, 29 Apr 2020 13:58:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:33 -0700 (PDT)
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
Subject: [PATCH v2 04/16] clk: versatile: Rework kconfig structure
Date:   Wed, 29 Apr 2020 15:58:13 -0500
Message-Id: <20200429205825.10604-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_COMMON_CLK_VERSATILE doesn't really do anything other than hiding
Arm Ltd reference platform clock drivers. It is both selected by the
platforms that need it and has a 'depends on' for those platforms. Let's
drop the selects and convert CONFIG_COMMON_CLK_VERSATILE into a
menuconfig entry. With this make CONFIG_ICST visible.

Move the 'select REGMAP_MMIO' to the drivers that require it (SP810 did
not).

This also has the side effect of enabling CONFIG_ICST for COMPILE_TEST
as it was not visible before.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Correct erroneous COMPILE_TEST added and then removed later in the
   series.
 - Bring back COMMON_CLK_VERSATILE making it a menuconfig and separate
   it from CONFIG_ICST
---
 arch/arm/mach-integrator/Kconfig |  1 -
 arch/arm/mach-realview/Kconfig   |  1 -
 arch/arm/mach-versatile/Kconfig  |  1 -
 arch/arm/mach-vexpress/Kconfig   |  1 -
 arch/arm64/Kconfig.platforms     |  1 -
 drivers/clk/Makefile             |  2 +-
 drivers/clk/versatile/Kconfig    | 22 ++++++++++++----------
 7 files changed, 13 insertions(+), 16 deletions(-)

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
index 44ebbf9ec673..002404fafc14 100644
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
index c2618f1477a2..df0d50bb846c 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,22 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config ICST
-	bool
 
-config COMMON_CLK_VERSATILE
-	bool "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
-		ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
-		COMPILE_TEST
+menuconfig COMMON_CLK_VERSATILE
+	bool "Clock driver for ARM Reference designs" if COMPILE_TEST
+	default y if ARCH_INTEGRATOR || ARCH_REALVIEW || \
+		ARCH_VERSATILE || ARCH_VEXPRESS
+
+if COMMON_CLK_VERSATILE
+
+config ICST
+	bool "Clock driver for ARM Reference designs ICST"
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
@@ -24,10 +24,12 @@ config CLK_SP810
 
 config CLK_VEXPRESS_OSC
 	bool "Clock driver for Versatile Express OSC clock generators"
-	depends on COMMON_CLK_VERSATILE
 	depends on VEXPRESS_CONFIG
+	select REGMAP_MMIO
 	default y if ARCH_VEXPRESS
 	---help---
 	  Simple regmap-based driver driving clock generators on Versatile
 	  Express platforms hidden behind its configuration infrastructure,
 	  commonly known as OSCs.
+
+endif
-- 
2.20.1

