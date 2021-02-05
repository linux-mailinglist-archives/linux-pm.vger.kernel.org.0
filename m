Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353633115CC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 23:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBEWmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 17:42:02 -0500
Received: from muru.com ([72.249.23.125]:57664 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhBENq2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 08:46:28 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 364CB81BC;
        Fri,  5 Feb 2021 13:45:59 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/4] thermal: ti-soc-thermal: Simplify polling with iopoll
Date:   Fri,  5 Feb 2021 15:45:33 +0200
Message-Id: <20210205134534.49200-4-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205134534.49200-1-tony@atomide.com>
References: <20210205134534.49200-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 30 ++++++++++-----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
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
-- 
2.30.0
