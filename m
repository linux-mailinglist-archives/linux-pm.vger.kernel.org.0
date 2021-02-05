Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E183310C29
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBENsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 08:48:33 -0500
Received: from muru.com ([72.249.23.125]:57646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhBENq0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 08:46:26 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 17B7F81A7;
        Fri,  5 Feb 2021 13:45:55 +0000 (UTC)
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
Subject: [PATCH 2/4] thermal: ti-soc-thermal: Fix stuck sensor with continuous mode for 4430
Date:   Fri,  5 Feb 2021 15:45:32 +0200
Message-Id: <20210205134534.49200-3-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205134534.49200-1-tony@atomide.com>
References: <20210205134534.49200-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At least for 4430, trying to use the single conversion mode eventually
hangs the thermal sensor. This can be quite easily seen with errors:

thermal thermal_zone0: failed to read out thermal zone (-5)

Also, trying to read the temperature shows a stuck value with:

$ while true; do cat /sys/class/thermal/thermal_zone0/temp; done

Where the temperature is not rising at all with the busy loop.

Additionally, the EOCZ (end of conversion) bit is not rising on 4430 in
single conversion mode while it works fine in continuous conversion mode.
It is also possible that the hung temperature sensor can affect the
thermal shutdown alert too.

Let's fix the issue by adding TI_BANDGAP_FEATURE_CONT_MODE_ONLY flag and
use it for 4430.

Note that we also need to add udelay to for the EOCZ (end of conversion)
bit polling as otherwise we have it time out too early on 4430. We'll be
changing the loop to use iopoll in the following clean-up patch.

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
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c |  3 ++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 13 ++++++++++---
 drivers/thermal/ti-soc-thermal/ti-bandgap.h         |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -58,7 +58,8 @@ omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
 const struct ti_bandgap_data omap4430_data = {
 	.features = TI_BANDGAP_FEATURE_MODE_CONFIG |
 			TI_BANDGAP_FEATURE_CLK_CTRL |
-			TI_BANDGAP_FEATURE_POWER_SWITCH,
+			TI_BANDGAP_FEATURE_POWER_SWITCH |
+			TI_BANDGAP_FEATURE_CONT_MODE_ONLY,
 	.fclock_name = "bandgap_fclk",
 	.div_ck_name = "bandgap_fclk",
 	.conv_table = omap4430_adc_to_temp,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -605,9 +606,13 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 	struct temp_sensor_registers *tsr = bgp->conf->sensors[id].registers;
 	u32 counter;
 
-	/* Select single conversion mode */
-	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
-		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
+	/* Select continuous or single conversion mode */
+	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
+		if (TI_BANDGAP_HAS(bgp, CONT_MODE_ONLY))
+			RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 1);
+		else
+			RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
+	}
 
 	/* Set Start of Conversion if available */
 	if (tsr->bgap_soc_mask) {
@@ -619,6 +624,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 			if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
 			    tsr->bgap_eocz_mask)
 				break;
+			udelay(1);
 		}
 
 		/* Clear Start of Conversion if available */
@@ -631,6 +637,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
 		      tsr->bgap_eocz_mask))
 			break;
+		udelay(1);
 	}
 
 	return 0;
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -280,6 +280,7 @@ struct ti_temp_sensor {
  *	has Errata 814
  * TI_BANDGAP_FEATURE_UNRELIABLE - used when the sensor readings are too
  *	inaccurate.
+ * TI_BANDGAP_FEATURE_CONT_MODE_ONLY - used when single mode hangs the sensor
  * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
  *      specific feature (above) or not. Return non-zero, if yes.
  */
@@ -295,6 +296,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
 #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
 #define TI_BANDGAP_FEATURE_UNRELIABLE		BIT(11)
+#define TI_BANDGAP_FEATURE_CONT_MODE_ONLY	BIT(12)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
 
-- 
2.30.0
