Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD497BF77A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjJJJhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJhg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 05:37:36 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395193;
        Tue, 10 Oct 2023 02:37:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1724A1C0003;
        Tue, 10 Oct 2023 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696930652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPkINlL8/YAShL73uQq6KpZyCNMmhaNa5D5RvFmTRz4=;
        b=C5cvqBns28peKwrQxh+ogwR4P/9jGZyi9uhSqNgZLHq+Lf8+0hJRwxGytKn94+MCBUvIMo
        sTRvwHwlMoH+QMsVYKG2tq/oQ+i7gFzTzKHiv04OwZ4raAQeBA3V+Qv4riX5trdmE3+3zP
        SrxcLg1EjnnZ+tCpzIFUJCewV7TI7hS/6GbjXhxQO5P5FViFpFKbfRnyeZ7iI1VRQBfYxn
        JbDrBhxFNzCv4857rysqkLU+x+7D5Hnnw9VopKxjMwLNwJO/4Jy3Egp4lDGwrVBzPZ1Nzj
        ynUqmInJbcPle+nisIJpsD6M4aT8IlykD+kuiyrqy3jr+Hg62EBDeVwI6aA8MQ==
Message-ID: <a1756492-1caf-43d5-a64f-02b29512654d@bootlin.com>
Date:   Tue, 10 Oct 2023 11:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vignesh R <vigneshr@ti.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
 <20230920053828.GD5282@atomide.com>
 <a5bee830-07af-426b-94ac-3574cba34bec@bootlin.com>
 <20231010065145.GD27774@atomide.com>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20231010065145.GD27774@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/10/23 08:51, Tony Lindgren wrote:
> Hi,
> 
> * Thomas Richard <thomas.richard@bootlin.com> [231009 15:13]:
>>> The runtime PM usage count should keep the related power domain on though,
>>> sounds like this issue somewhere else if the power domains get force
>>> suspended with runtime PM usage count?
>>
>> If I understand correctly, there are 2 solutions to keep the power
>> domain on through.
>> The first one is to set the flag GENPD_FLAG_ALWAYS_ON for the power domain.
>> The second one is to set the wakup_path of the device (using
>> device_set_wakeup_path) and set the flag GENPD_FLAG_ACTIVE_WAKEUP to the
>> power domain.
>>
>> I didn't found any flag or option to say that the device is not
>> suspended, but it is not an error, so we don't want to poweroff the
>> power domain.
> 
> If no_console_suspend is set then GENPD_FLAG_ALWAYS_ON makes sense to
> me as we want to see the debug messages. This will also alter the SoCs
> suspend state though, so no_console_suspend is of limited use. Can you
> please send an updated patch against tty-next branch for this?

Please find below a proposal based on tty-next branch.
I had to add your patch 'serial: 8250_omap: Fix errors with
no_console_suspend' as it is not present in this branch.
And I need it to not have an error in omap8250_suspend.

> 
> It would be good to understand why the related power domain gets suspended
> with active runtime PM usage count though. To me it seems this might be
> an issue somewhere in the SoC related power domain code that just tries
> to force suspend everything.

I found nothing to say, there is a device in use (and not suspended) in
this power domain, so do not poweroff it.
Maybe I missed something.

Regards,

Thomas

> 
> Regards,
> 
> Tony

diff --git a/drivers/tty/serial/8250/8250_omap.c
b/drivers/tty/serial/8250/8250_omap.c
index 4b33f4529aed..2d42f485c987 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -28,6 +28,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
+#include <linux/pm_domain.h>

 #include "8250.h"

@@ -115,6 +116,12 @@
 /* RX FIFO occupancy indicator */
 #define UART_OMAP_RX_LVL		0x19

+/*
+ * Copy of the genpd flags for the console.
+ * Only used if console suspend is disabled
+ */
+static unsigned int genpd_flags_console;
+
 struct omap8250_priv {
 	void __iomem *membase;
 	int line;
@@ -1623,6 +1630,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err = 0;

 	serial8250_suspend_port(priv->line);
@@ -1633,8 +1641,19 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	if (uart_console(&up->port) && console_suspend_enabled)
-		err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port)) {
+		if (console_suspend_enabled)
+			err = pm_runtime_force_suspend(dev);
+		else {
+			/*
+			 * The pd shall not be powered-off (no console suspend).
+			 * Make copy of genpd flags before to set it always on.
+			 * The original value is restored during the resume.
+			 */
+			genpd_flags_console = genpd->flags;
+			genpd->flags |= GENPD_FLAG_ALWAYS_ON;
+		}
+	}
 	flush_work(&priv->qos_work);

 	return err;
@@ -1644,12 +1663,16 @@ static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	int err;

 	if (uart_console(&up->port) && console_suspend_enabled) {
-		err = pm_runtime_force_resume(dev);
-		if (err)
-			return err;
+		if (console_suspend_enabled) {
+			err = pm_runtime_force_resume(dev);
+			if (err)
+				return err;
+		} else
+			genpd->flags = genpd_flags_console;
 	}

 	serial8250_resume_port(priv->line);


-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

