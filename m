Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446B4422D7A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhJEQLS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhJEQLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:11:17 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D09C061749;
        Tue,  5 Oct 2021 09:09:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8840642481;
        Tue,  5 Oct 2021 16:00:11 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
Date:   Wed,  6 Oct 2021 00:59:22 +0900
Message-Id: <20211005155923.173399-7-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005155923.173399-1-marcan@marcan.st>
References: <20211005155923.173399-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allows idle UART devices to be suspended using the standard
runtime-PM framework. The logic is modeled after stm32-usart.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 88 ++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e2f49863e9c2..d68e3341adc6 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -40,6 +40,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <asm/irq.h>
 
 /* UART name and device definitions */
@@ -1381,31 +1382,49 @@ static void exynos_usi_init(struct uart_port *port)
 
 /* power power management control */
 
-static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
-			      unsigned int old)
+static int __maybe_unused s3c24xx_serial_runtime_suspend(struct device *dev)
 {
+	struct uart_port *port = dev_get_drvdata(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int timeout = 10000;
 
-	ourport->pm_level = level;
+	while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
+		udelay(100);
 
-	switch (level) {
-	case 3:
-		while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
-			udelay(100);
+	if (!IS_ERR(ourport->baudclk))
+		clk_disable_unprepare(ourport->baudclk);
 
-		if (!IS_ERR(ourport->baudclk))
-			clk_disable_unprepare(ourport->baudclk);
+	clk_disable_unprepare(ourport->clk);
+	return 0;
+};
 
-		clk_disable_unprepare(ourport->clk);
-		break;
+static int __maybe_unused s3c24xx_serial_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	case 0:
-		clk_prepare_enable(ourport->clk);
+	clk_prepare_enable(ourport->clk);
 
-		if (!IS_ERR(ourport->baudclk))
-			clk_prepare_enable(ourport->baudclk);
+	if (!IS_ERR(ourport->baudclk))
+		clk_prepare_enable(ourport->baudclk);
+	return 0;
+};
+
+static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
+			      unsigned int old)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+
+	ourport->pm_level = level;
 
+	switch (level) {
+	case UART_PM_STATE_OFF:
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_sync(port->dev);
+		break;
+
+	case UART_PM_STATE_ON:
+		pm_runtime_get_sync(port->dev);
 		exynos_usi_init(port);
 		break;
 	default:
@@ -2282,18 +2301,15 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
 	platform_set_drvdata(pdev, &ourport->port);
 
-	/*
-	 * Deactivate the clock enabled in s3c24xx_serial_init_port here,
-	 * so that a potential re-enablement through the pm-callback overlaps
-	 * and keeps the clock enabled in this case.
-	 */
-	clk_disable_unprepare(ourport->clk);
-	if (!IS_ERR(ourport->baudclk))
-		clk_disable_unprepare(ourport->baudclk);
+	pm_runtime_put_sync(&pdev->dev);
 
 	ret = s3c24xx_serial_cpufreq_register(ourport);
 	if (ret < 0)
@@ -2309,8 +2325,14 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
 	if (port) {
+		pm_runtime_get_sync(&dev->dev);
+
 		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
+
+		pm_runtime_disable(&dev->dev);
+		pm_runtime_set_suspended(&dev->dev);
+		pm_runtime_put_noidle(&dev->dev);
 	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
@@ -2319,8 +2341,8 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
 }
 
 /* UART power management code */
-#ifdef CONFIG_PM_SLEEP
-static int s3c24xx_serial_suspend(struct device *dev)
+
+static int __maybe_unused s3c24xx_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 
@@ -2330,7 +2352,7 @@ static int s3c24xx_serial_suspend(struct device *dev)
 	return 0;
 }
 
-static int s3c24xx_serial_resume(struct device *dev)
+static int __maybe_unused s3c24xx_serial_resume(struct device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -2350,7 +2372,7 @@ static int s3c24xx_serial_resume(struct device *dev)
 	return 0;
 }
 
-static int s3c24xx_serial_resume_noirq(struct device *dev)
+static int __maybe_unused s3c24xx_serial_resume_noirq(struct device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -2420,16 +2442,14 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops s3c24xx_serial_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
 	.suspend = s3c24xx_serial_suspend,
 	.resume = s3c24xx_serial_resume,
 	.resume_noirq = s3c24xx_serial_resume_noirq,
+#endif
+	SET_RUNTIME_PM_OPS(s3c24xx_serial_runtime_suspend,
+			   s3c24xx_serial_runtime_resume, NULL)
 };
-#define SERIAL_SAMSUNG_PM_OPS	(&s3c24xx_serial_pm_ops)
-
-#else /* !CONFIG_PM_SLEEP */
-
-#define SERIAL_SAMSUNG_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
 
 /* Console code */
 
@@ -2924,7 +2944,7 @@ static struct platform_driver samsung_serial_driver = {
 	.id_table	= s3c24xx_serial_driver_ids,
 	.driver		= {
 		.name	= "samsung-uart",
-		.pm	= SERIAL_SAMSUNG_PM_OPS,
+		.pm	= &s3c24xx_serial_pm_ops,
 		.of_match_table	= of_match_ptr(s3c24xx_uart_dt_match),
 	},
 };
-- 
2.33.0

