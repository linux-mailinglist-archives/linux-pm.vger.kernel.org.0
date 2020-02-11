Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CC159D85
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBKXiq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55486 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgBKXiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:46 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 2edb94c55edb4572; Wed, 12 Feb 2020 00:38:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/28] drivers: tty: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:27:04 +0100
Message-ID: <2339403.frKpfgBVMR@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/update/remove_request() instead of
pm_qos_add/update/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 7 +++----
 drivers/tty/serial/omap-serial.c    | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 19f8d2f9e7ba..76fe72bfb8bb 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -569,7 +569,7 @@ static void omap8250_uart_qos_work(struct work_struct *work)
 	struct omap8250_priv *priv;
 
 	priv = container_of(work, struct omap8250_priv, qos_work);
-	pm_qos_update_request(&priv->pm_qos_request, priv->latency);
+	cpu_latency_qos_update_request(&priv->pm_qos_request, priv->latency);
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -1224,8 +1224,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
-	pm_qos_add_request(&priv->pm_qos_request, PM_QOS_CPU_DMA_LATENCY,
-			   priv->latency);
+	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
 	INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
 
 	spin_lock_init(&priv->rx_dma_lock);
@@ -1295,7 +1294,7 @@ static int omap8250_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	serial8250_unregister_port(priv->line);
-	pm_qos_remove_request(&priv->pm_qos_request);
+	cpu_latency_qos_remove_request(&priv->pm_qos_request);
 	device_init_wakeup(&pdev->dev, false);
 	return 0;
 }
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ce2558767eee..e0b720ac754b 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -831,7 +831,7 @@ static void serial_omap_uart_qos_work(struct work_struct *work)
 	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
 						qos_work);
 
-	pm_qos_update_request(&up->pm_qos_request, up->latency);
+	cpu_latency_qos_update_request(&up->pm_qos_request, up->latency);
 }
 
 static void
@@ -1724,8 +1724,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
-	pm_qos_add_request(&up->pm_qos_request,
-		PM_QOS_CPU_DMA_LATENCY, up->latency);
+	cpu_latency_qos_add_request(&up->pm_qos_request, up->latency);
 	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
 
 	platform_set_drvdata(pdev, up);
@@ -1759,7 +1758,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	pm_qos_remove_request(&up->pm_qos_request);
+	cpu_latency_qos_remove_request(&up->pm_qos_request);
 	device_init_wakeup(up->dev, false);
 err_rs485:
 err_port_line:
@@ -1777,7 +1776,7 @@ static int serial_omap_remove(struct platform_device *dev)
 	pm_runtime_dont_use_autosuspend(up->dev);
 	pm_runtime_put_sync(up->dev);
 	pm_runtime_disable(up->dev);
-	pm_qos_remove_request(&up->pm_qos_request);
+	cpu_latency_qos_remove_request(&up->pm_qos_request);
 	device_init_wakeup(&dev->dev, false);
 
 	return 0;
-- 
2.16.4





