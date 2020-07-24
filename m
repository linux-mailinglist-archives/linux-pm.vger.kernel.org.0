Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07522CDA8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGXSZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGXSZG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:06 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE86206F6;
        Fri, 24 Jul 2020 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615105;
        bh=C/qOx+8Seou1xRGI/yWmrKDFNoVsbSUhhh7rZI0SE3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nK7h17DelJWWIsSA23hXW49INBhCI7OdQA9kozCWsi4HPyhRW8mHE3Gl/wS9FJ+a/
         rsbJztmTCAvkRNJ7m+VqX0iflkMyXlPZ4PpVsspK2iTvaCQztfTJDt3RYzpKiR4Fzi
         XMgwjoIdxnvNtDIqyF/rAgI+dz+ZPxcBK3kvO2PU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFT 12/16] memory: brcmstb_dpfe: Add separate entry for compile test
Date:   Fri, 24 Jul 2020 20:23:24 +0200
Message-Id: <20200724182328.3348-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add separate entry for Broadcom STB DPFE driver, selected by platforms
by default.  This allows further customization and compile testing.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

I have other changes around drivers/memory/Kconfig pending. Sending them
together would avoid conflicts.

---
 arch/arm/mach-bcm/Kconfig    |  1 +
 arch/arm64/Kconfig.platforms |  1 +
 drivers/memory/Kconfig       | 11 +++++++++++
 drivers/memory/Makefile      |  2 +-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 1df0ee01ee02..b0c45238e69b 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -208,6 +208,7 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
+	select BRCMSTB_DPFE
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index ddc3bf75257f..f7791ed0ed6d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -68,6 +68,7 @@ config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
 	select ARCH_HAS_RESET_CONTROLLER
 	select BCM7038_L1_IRQ
+	select BRCMSTB_DPFE
 	select BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index cd4fc93b50df..fef6f0873fda 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -54,6 +54,17 @@ config ATMEL_EBI
 	  tree is used. This bus supports NANDs, external ethernet controller,
 	  SRAMs, ATA devices, etc.
 
+config BRCMSTB_DPFE
+	bool "Broadcom STB DPFE driver" if COMPILE_TEST
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	help
+	  This driver provides access to the DPFE interface of Broadcom
+	  STB SoCs. The firmware running on the DCPU inside the DDR PHY can
+	  provide current information about the system's RAM, for instance
+	  the DRAM refresh rate. This can be used as an indirect indicator
+	  for the DRAM's temperature. Slower refresh rate means cooler RAM,
+	  higher refresh rate means hotter RAM.
+
 config BT1_L2_CTL
 	bool "Baikal-T1 CM2 L2-RAM Cache Control Block"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index b4533ffff2bc..e71cf7b99641 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -10,7 +10,7 @@ endif
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
-obj-$(CONFIG_ARCH_BRCMSTB)	+= brcmstb_dpfe.o
+obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
 obj-$(CONFIG_BT1_L2_CTL)	+= bt1-l2-ctl.o
 obj-$(CONFIG_TI_AEMIF)		+= ti-aemif.o
 obj-$(CONFIG_TI_EMIF)		+= emif.o
-- 
2.17.1

