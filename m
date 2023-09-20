Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7547A7233
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjITFip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 01:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjITFil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 01:38:41 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0B11F3;
        Tue, 19 Sep 2023 22:38:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DCA9B80A0;
        Wed, 20 Sep 2023 05:38:29 +0000 (UTC)
Date:   Wed, 20 Sep 2023 08:38:28 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Message-ID: <20230920053828.GD5282@atomide.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

* Thomas Richard <thomas.richard@bootlin.com> [230915 09:57]:
> The regression was introduced in commit 20a41a62618d "serial: 8250_omap:
> Use force_suspend and resume for system suspend"
...

> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1630,7 +1630,7 @@ static int omap8250_suspend(struct device *dev)
>         err = pm_runtime_force_suspend(dev);
>         flush_work(&priv->qos_work);
> 
> -       return err;
> +       return 0;
>  }

Maybe we can now just simplify things a bit here with the patch below.
Care to give it a try, it's compile tested only so far.

> Once the omap8250_suspend doesn't return an error, the suspend sequence
> can continue, but I get an other issue.
> This issue is not related to commit 20a41a62618d, it has already been
> present.
> The power domain of the console is powered-off, so no more messages are
> printed, and the SoC is stucked.
> As the uart port is used as console, we don't want to power-off it.
> My workaround is to set the corresponding power domain to
> GENPD_FLAG_ALWAYS_ON, so the uart port is not powered-off.

The runtime PM usage count should keep the related power domain on though,
sounds like this issue somewhere else if the power domains get force
suspended with runtime PM usage count?

Regards,

Tony

8< ------------------------------
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (up && uart_console(&up->port))
-			return -EBUSY;
-	}
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
-- 
2.42.0
