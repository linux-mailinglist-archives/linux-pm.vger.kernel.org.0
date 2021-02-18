Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5F31F139
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBRUmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhBRUk1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240DC06178B
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:47 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3FW5votuI8j+x/gnqCYpIIwGiM3TDWKX15Epdtn1/8=;
        b=VaKaB6KWDtmQKykCPxXTjgZtlxQXnu8Q9Tm09qQq9PsBZlQB0uRrV+JL3Rbldh18UbmaFM
        7n8HeyT3MTuiF0kCF8F+u9xnOpZwyrRd0DGxDez3ZHQZtcEVsogYeI4bBIwS7SMwDansxY
        avPvf2aGF3C7mtStHtFOWsdeTEYd+98dH+J5/OhVU3EiiPHwk30Y4bBqckpBMo6lOpGTH8
        faLg1f842PczIIkJtY7c/MQEG6HaGYlGTHBeRSForBQ0m+FyKMdSjc1KVx2oKRCpVR0MSh
        y5wUAfTx+iHr4SpQGF67NESs1TG69hH5oq0Z4KFp7c1RUQUPAJymfDmOHsYh6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3FW5votuI8j+x/gnqCYpIIwGiM3TDWKX15Epdtn1/8=;
        b=MYK8I5eX3iIMoFx5pVZcE9P9Phgqa9TKqMSB2I7sBKs8BuWLJ9E1bXEkMWfSZUd4/oXbig
        ha3Fovhhkc3MlGAA==
From:   "thermal-bot for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: ti-soc-thermal: Skip pointless
 register access for dra7
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
In-Reply-To: <20210205134534.49200-2-tony@atomide.com>
References: <20210205134534.49200-2-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161368078213.20312.13241259202350305802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     b57b4b4d4ef9c2ecb169775815bebab0890cda50
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//b57b4b4d4ef9c2ecb169775815bebab0890cda50
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 05 Feb 2021 15:45:31 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Feb 2021 21:18:32 +01:00

thermal: ti-soc-thermal: Skip pointless register access for dra7

On dra7, there is no Start of Conversion (SOC) register bit and we have an
empty bgap_soc_mask in the configuration for the thermal driver. Let's not
do pointless reads and writes with the empty mask.

There's also no point waiting for End of Conversion bit (EOCZ) to go high
on dra7. We only care about it going down, and are now mostly timing out
waiting for EOCZ high while it has already gone down.

When we add checking for the timeout errors in a later patch, waiting for
EOCZ high would cause bogus time out errors.

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
Link: https://lore.kernel.org/r/20210205134534.49200-2-tony@atomide.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 29 ++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index dcac99f..8266181 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -602,29 +602,30 @@ void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id)
 static int
 ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 {
-	u32 counter = 1000;
-	struct temp_sensor_registers *tsr;
+	struct temp_sensor_registers *tsr = bgp->conf->sensors[id].registers;
+	u32 counter;
 
 	/* Select single conversion mode */
 	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
 		RMW_BITS(bgp, id, bgap_mode_ctrl, mode_ctrl_mask, 0);
 
-	/* Start of Conversion = 1 */
-	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
+	/* Set Start of Conversion if available */
+	if (tsr->bgap_soc_mask) {
+		RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
 
-	/* Wait for EOCZ going up */
-	tsr = bgp->conf->sensors[id].registers;
+		/* Wait for EOCZ going up */
+		counter = 1000;
+		while (--counter) {
+			if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
+			    tsr->bgap_eocz_mask)
+				break;
+		}
 
-	while (--counter) {
-		if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
-		    tsr->bgap_eocz_mask)
-			break;
+		/* Clear Start of Conversion if available */
+		RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
 	}
 
-	/* Start of Conversion = 0 */
-	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
-
-	/* Wait for EOCZ going down */
+	/* Wait for EOCZ going down, always needed even if no bgap_soc_mask */
 	counter = 1000;
 	while (--counter) {
 		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
