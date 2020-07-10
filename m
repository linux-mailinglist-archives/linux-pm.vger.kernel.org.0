Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992D021BD6E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGJTLr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:11:47 -0400
Received: from foss.arm.com ([217.140.110.172]:35440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2172F31B;
        Fri, 10 Jul 2020 12:11:46 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AECD3FA00;
        Fri, 10 Jul 2020 12:11:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     lukasz.luba@arm.com, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param to control IRQ mode
Date:   Fri, 10 Jul 2020 20:11:22 +0100
Message-Id: <20200710191122.11029-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710191122.11029-1-lukasz.luba@arm.com>
References: <20200710191122.11029-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can operate in two modes relaying on devfreq monitoring
mechanism which periodically checks the device status or it can use
interrupts when they are provided by loaded Device Tree. The newly
introduced module parameter can be used to choose between devfreq
monitoring and internal interrupts without modifying the Device Tree.
It also sets devfreq monitoring as default when the parameter is not set
(also the case for default when the driver is not built as a module).

Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index e03ee35f0ab5..53bfe6b7b703 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/of_device.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
@@ -21,6 +22,10 @@
 #include "../jedec_ddr.h"
 #include "../of_memory.h"
 
+static int irqmode;
+module_param(irqmode, int, 0644);
+MODULE_PARM_DESC(irqmode, "Enable IRQ mode (0=off [default], 1=on)");
+
 #define EXYNOS5_DREXI_TIMINGAREF		(0x0030)
 #define EXYNOS5_DREXI_TIMINGROW0		(0x0034)
 #define EXYNOS5_DREXI_TIMINGDATA0		(0x0038)
@@ -1428,7 +1433,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	/* There is two modes in which the driver works: polling or IRQ */
 	irq[0] = platform_get_irq_byname(pdev, "drex_0");
 	irq[1] = platform_get_irq_byname(pdev, "drex_1");
-	if (irq[0] > 0 && irq[1] > 0) {
+	if (irq[0] > 0 && irq[1] > 0 && irqmode) {
 		ret = devm_request_threaded_irq(dev, irq[0], NULL,
 						dmc_irq_thread, IRQF_ONESHOT,
 						dev_name(dev), dmc);
@@ -1485,7 +1490,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	if (dmc->in_irq_mode)
 		exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
 
-	dev_info(dev, "DMC initialized\n");
+	dev_info(dev, "DMC initialized, in irq mode: %d\n", dmc->in_irq_mode);
 
 	return 0;
 
-- 
2.17.1

