Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF20512C986
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2019 19:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfL2SJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 13:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731365AbfL2SJ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Dec 2019 13:09:27 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70560222C2;
        Sun, 29 Dec 2019 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642966;
        bh=+YBS7n7jqJ53S6HvX93BfgZRfoAttIJ+SIElGBLSgqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMgwPoibTPvXMuBnLasQwLeJludmN8WbGDEYxBWxxnh0U6rfIf1l/FTZyhAcMB23c
         kDdi/LXORjlV7nRi8wYZhjc3QkRJzJn2u5rEXoEN3hGw07unFOx4hpQDUtK56XXsnb
         B+2XHtCEwb47/eSsX21hJrZ+L/Q0LdGjKxpIZxh8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] cpuidle: arm: Enable compile testing for some of drivers
Date:   Sun, 29 Dec 2019 19:09:12 +0100
Message-Id: <20191229180912.17100-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229180912.17100-1-krzk@kernel.org>
References: <20191229180912.17100-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some of cpuidle drivers for ARMv7 can be compile tested on this
architecture because they do not depend on mach-specific bits.  Enable
compile testing for big.LITTLE, Kirkwood, Zynq, AT91, Exynos and mvebu
cpuidle drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpuidle/Kconfig.arm | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a224d33dda7f..62272ecfa771 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -25,7 +25,7 @@ config ARM_PSCI_CPUIDLE
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
-	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
+	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || COMPILE_TEST
 	depends on MCPM && !ARM64
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
@@ -51,13 +51,13 @@ config ARM_HIGHBANK_CPUIDLE
 
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
-	depends on MACH_KIRKWOOD && !ARM64
+	depends on (MACH_KIRKWOOD || COMPILE_TEST) && !ARM64
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
 config ARM_ZYNQ_CPUIDLE
 	bool "CPU Idle Driver for Xilinx Zynq processors"
-	depends on ARCH_ZYNQ && !ARM64
+	depends on (ARCH_ZYNQ || COMPILE_TEST) && !ARM64
 	help
 	  Select this to enable cpuidle on Xilinx Zynq processors.
 
@@ -70,19 +70,19 @@ config ARM_U8500_CPUIDLE
 config ARM_AT91_CPUIDLE
 	bool "Cpu Idle Driver for the AT91 processors"
 	default y
-	depends on ARCH_AT91 && !ARM64
+	depends on (ARCH_AT91 || COMPILE_TEST) && !ARM64
 	help
 	  Select this to enable cpuidle for AT91 processors.
 
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
-	depends on ARCH_EXYNOS && !ARM64
+	depends on (ARCH_EXYNOS || COMPILE_TEST) && !ARM64
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	help
 	  Select this to enable cpuidle for Exynos processors.
 
 config ARM_MVEBU_V7_CPUIDLE
 	bool "CPU Idle Driver for mvebu v7 family processors"
-	depends on ARCH_MVEBU && !ARM64
+	depends on (ARCH_MVEBU || COMPILE_TEST) && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
-- 
2.17.1

