Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359C17A1B77
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjIOJ50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjIOJ5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 05:57:25 -0400
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79363423A;
        Fri, 15 Sep 2023 02:57:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDC9160004;
        Fri, 15 Sep 2023 09:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694771818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/c0tr3y404HpIQ/faRgXc639mkiuFGrv3IpU9W/CSE=;
        b=iRV3V4CvBR3mxz9HD0D7p6CSm42QI2ruaLqCBKhjLiWPnu42740I6OM0oEhCIfs6q2N4ji
        u4prMkgY3R8XsmboEBO+w1y7zm25xfN0NSfkaPDpcb/8Z11hjc88cCtBUanKM0NFrvNBN/
        NhnOaIyR53itexnJ6xpxBjjIe+L7C16IdOfMUFFrTVPilCZh+auhOL6kvwVC7TTkQxynfr
        JIj2EyzOcfrIaCKDaEdV+eDlM8MS412j2SaVxba+0GEOPvMaZdI945SxOh8Ky0841viUYh
        lddn/nYs05kWuBfENb+ExN6IrhiKvtNDhhg3Lz8TA71fXmwAtFFL2F+6XwP5Yg==
Message-ID: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
Date:   Fri, 15 Sep 2023 11:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
From:   Thomas Richard <thomas.richard@bootlin.com>
Subject: serial: 8250_omap: suspend issue with console_suspend disabled
To:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        tony@atomide.com
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I already sent a mail related to this topic to the linux-serial mailing
list
(https://lore.kernel.org/linux-serial/8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com)
But as I also noticed a power management issue, i create a new thread
including more people and more details.

After switching to Linux 6.6-rc1, I met an issue during suspend to idle
with 8250_omap driver (no_console_suspend is set).
It is also valid for suspend to ram.
The driver fails to suspend the uart port used for the serial console so
the suspend sequence is stopped.

My target is the K3 J7200 SoC.

[  114.629197] port 2800000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2800000.serial:0
[  114.639617] port 2800000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 2 usecs
[  114.648739] omap8250 2800000.serial: PM: calling
omap8250_suspend+0x0/0xf4 @ 114, parent: bus@100000
[  114.657861] omap8250 2800000.serial: PM: dpm_run_callback():
omap8250_suspend+0x0/0xf4 returns -16
[  114.666808] omap8250 2800000.serial: PM: omap8250_suspend+0x0/0xf4
returned -16 after 8951 usecs
[  114.675580] omap8250 2800000.serial: PM: failed to suspend: error -16
[  114.682011] PM: suspend of devices aborted after 675.644 msecs
[  114.687833] PM: start suspend of devices aborted after 681.777 msecs
[  114.694175] PM: Some devices failed to suspend, or early wake event
detected

The following sequence is used to suspend to idle:
$ echo 1 > /sys/power/pm_debug_messages
$ echo 1 > /sys/power/pm_print_times
$ echo 8 > /proc/sys/kernel/printk
$ echo 0 > /sys/module/printk/parameters/console_suspend
$ echo enabled >
/sys/devices/platform/bus@100000/2800000.serial/tty/ttyS2/power/wakeup
$ echo s2idle > /sys/power/mem_sleep
$ echo mem > /sys/power/state

The regression was introduced in commit 20a41a62618d "serial: 8250_omap:
Use force_suspend and resume for system suspend"

Before commit 20a41a62618d, omap8250_suspend returned 0.
Now pm_runtime_force_suspend is called and its return code is used by
omap8250_suspend.

static int omap8250_suspend(struct device *dev)
{
	struct omap8250_priv *priv = dev_get_drvdata(dev);
	struct uart_8250_port *up = serial8250_get_port(priv->line);
	int err;

	serial8250_suspend_port(priv->line);

	err = pm_runtime_resume_and_get(dev);
	if (err)
		return err;
	if (!device_may_wakeup(dev))
		priv->wer = 0;
	serial_out(up, UART_OMAP_WER, priv->wer);
	err = pm_runtime_force_suspend(dev);
	flush_work(&priv->qos_work);

	return err;
}

The pm_runtime_force_suspend function calls omap8250_runtime_suspend
which returns -EBUSY because console suspend was disabled (which is my
case), as explained in the code.

/*
 * When using 'no_console_suspend', the console UART must not be
 * suspended. Since driver suspend is managed by runtime suspend,
 * preventing runtime suspend (by returning error) will keep device
 * active during suspend.
 */
if (priv->is_suspending && !console_suspend_enabled) {
	if (up && uart_console(&up->port))
		return -EBUSY;
}

The port is used by the console, so we don't want to suspend it (console
suspend was disabled).
Of course, if console_suspend is enabled and messages are disabled there
is no issue.
For now my workaround is to always return 0 in omap8250_suspend.

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1630,7 +1630,7 @@ static int omap8250_suspend(struct device *dev)
        err = pm_runtime_force_suspend(dev);
        flush_work(&priv->qos_work);

-       return err;
+       return 0;
 }

Once the omap8250_suspend doesn't return an error, the suspend sequence
can continue, but I get an other issue.
This issue is not related to commit 20a41a62618d, it has already been
present.
The power domain of the console is powered-off, so no more messages are
printed, and the SoC is stucked.
As the uart port is used as console, we don't want to power-off it.
My workaround is to set the corresponding power domain to
GENPD_FLAG_ALWAYS_ON, so the uart port is not powered-off.

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -27,6 +27,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
+#include <linux/pm_domain.h>

 #include "8250.h"

@@ -1714,6 +1715,7 @@ static int omap8250_runtime_suspend(struct device
*dev)
 {
        struct omap8250_priv *priv = dev_get_drvdata(dev);
        struct uart_8250_port *up = NULL;
+       struct generic_pm_domain *pd = pd_to_genpd(dev->pm_domain);

        if (priv->line >= 0)
                up = serial8250_get_port(priv->line);
@@ -1724,8 +1726,10 @@ static int omap8250_runtime_suspend(struct device
*dev)
         * active during suspend.
         */
        if (priv->is_suspending && !console_suspend_enabled) {
-               if (up && uart_console(&up->port))
+               if (up && uart_console(&up->port)) {
+                       pd->flags |= GENPD_FLAG_ALWAYS_ON;
                        return -EBUSY;
+               }
        }

        if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {

For these two issues, I have workarounds but I don't know how to fix
them correctly.

Best Regards,
