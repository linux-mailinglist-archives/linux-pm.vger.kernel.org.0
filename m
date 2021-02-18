Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5931F138
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhBRUmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhBRUk1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0DC06178A
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:45 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1E5t6WaSoGVgVtNizlMcpWttqFmYzc7lvEBPSy16sU=;
        b=rikZytqhTnObw3lr5u5/8NUgQpF2VCBvJRLfFCC5hzmnUJtpKa11veL0iu7IFkNPo0yjsZ
        oZB5gQr8yZyJBRSsNEGMhBgFFiuzw7pAh0x0BN0cBS3eABPEZGxwsDX/gkeZnFkUubUUmN
        IgRlK4Ho5K9SQ/TW86yOkAenUDi0BXIu+zwh8tdGrF4q1JNP3gKJMP+QCfNZNyIUJVTBj5
        4LO2zCdtD9CDr9FZSFosIy264FW3NGC4dEo30ppdfriTX0V0TS8T2NTpgm6IlNl6G7gUCb
        0eGQZ/As6PKgiaZKoqSbRs/FvIbzsSRqKSuVnToEMgsIhlcJ3kMUmTmAu+zK9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1E5t6WaSoGVgVtNizlMcpWttqFmYzc7lvEBPSy16sU=;
        b=CMdV0jSQ0SJN10lb+BRiFrtA8wOHLQsBIlMJ29/6it1OnLCHXxMZMlG/itTU9WPGadiq2a
        IfpzWol2fkJeBEDw==
From:   "thermal-bot for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: ti-soc-thermal: Fix stuck sensor
 with continuous mode for 4430
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
In-Reply-To: <20210205134534.49200-3-tony@atomide.com>
References: <20210205134534.49200-3-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161368078190.20312.8549936373551759936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     735c35352aa615026b3544a92ad203da2e551590
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//735c35352aa615026b3544a92ad203da2e551590
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 05 Feb 2021 15:45:32 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Feb 2021 21:19:15 +01:00

thermal: ti-soc-thermal: Fix stuck sensor with continuous mode for 4430

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
Tested-by: Adam Ford <aford173@gmail.com> #logicpd-torpedo-37xx-devkit
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210205134534.49200-3-tony@atomide.com
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c |  3 ++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 13 +++++++++---
 drivers/thermal/ti-soc-thermal/ti-bandgap.h         |  2 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index fdb8a49..80c051a 100644
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
index 8266181..6e92551 100644
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
index ed0ea4b..1f4bbaf 100644
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
 
