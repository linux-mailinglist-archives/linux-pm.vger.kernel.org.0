Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18531F137
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhBRUmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhBRUk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:26 -0500
Date:   Thu, 18 Feb 2021 20:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQxa8DH6sDsExZ5+tXfTO9Uaj5cx92H5Sfey3KD0yLM=;
        b=TGDE4+gkioKyhjlz6bK/qxN+v1ElIhxDES3Kl7poBJ5VQPEa2ELndcKVvzvXGKZ25DnN8i
        ebYywSfesEQoDIy6um8Kc+Am1uyMLAPtWNwO6jWY2+lR9RPJEYRmor4M2B/Acj/I1bf5Cx
        2GOSx2LbkVCiSWcqH3TAf5dfO6RZ/s0wXRee5bTIDe5GUzk6nCFLMbFZ18j1NC2l/Wqtqg
        QL2r1NoN4XwJ7taoIZ4pSFZd28RR/BIxC5Iu8+nw5QugqhINL7MxlwHVAwWWaeHPOeb7FH
        CrKAKWzg+ZHniuJklNbxs55D4O9TdfBK81GH+7kpBGrBB7KavCTcun+E5Ul4bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQxa8DH6sDsExZ5+tXfTO9Uaj5cx92H5Sfey3KD0yLM=;
        b=e7iXSIKeFiCwNeZdJeXQ8gNE4BR3N88NT6xhVLn32hHR2ZOpZDfsRFNYBRSPJxW639OBhr
        kxdJIx3yX/4v64Aw==
From:   "thermal-bot for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: ti-soc-thermal: Simplify polling with iopoll
Cc:     Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Eduardo Valentin <edubezval@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210205134534.49200-4-tony@atomide.com>
References: <20210205134534.49200-4-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161368078166.20312.4958055839767865943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     514cbabb01422d501d533a6495b924e4c22d4822
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//514cbabb01422d501d533a6495b924e4c22d4822
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 05 Feb 2021 15:45:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Feb 2021 21:19:23 +01:00

thermal: ti-soc-thermal: Simplify polling with iopoll

We can use iopoll for checking the EOCZ (end of conversion) bit. And with
this we now also want to handle the timeout errors properly.

For omap3, we need about 1.2ms for the single mode sampling to wait for
EOCZ down, so let's use 1.5ms timeout there. Waiting for sampling to start
is faster and we can use 1ms timeout.

Cc: Adam Ford <aford173@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Adam Ford <aford173@gmail.com> #logicpd-torpedo-37xx-devkit
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210205134534.49200-4-tony@atomide.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 30 +++++++++-----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 6e92551..8a3646e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -27,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/cpu_pm.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
@@ -604,7 +604,9 @@ static int
 ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 {
 	struct temp_sensor_registers *tsr = bgp->conf->sensors[id].registers;
-	u32 counter;
+	void __iomem *temp_sensor_ctrl = bgp->base + tsr->temp_sensor_ctrl;
+	int error;
+	u32 val;
 
 	/* Select continuous or single conversion mode */
 	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
@@ -619,26 +621,22 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 		RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
 
 		/* Wait for EOCZ going up */
-		counter = 1000;
-		while (--counter) {
-			if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
-			    tsr->bgap_eocz_mask)
-				break;
-			udelay(1);
-		}
+		error = readl_poll_timeout_atomic(temp_sensor_ctrl, val,
+						  val & tsr->bgap_eocz_mask,
+						  1, 1000);
+		if (error)
+			dev_warn(bgp->dev, "eocz timed out waiting high\n");
 
 		/* Clear Start of Conversion if available */
 		RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
 	}
 
 	/* Wait for EOCZ going down, always needed even if no bgap_soc_mask */
-	counter = 1000;
-	while (--counter) {
-		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
-		      tsr->bgap_eocz_mask))
-			break;
-		udelay(1);
-	}
+	error = readl_poll_timeout_atomic(temp_sensor_ctrl, val,
+					  !(val & tsr->bgap_eocz_mask),
+					  1, 1500);
+	if (error)
+		dev_warn(bgp->dev, "eocz timed out waiting low\n");
 
 	return 0;
 }
