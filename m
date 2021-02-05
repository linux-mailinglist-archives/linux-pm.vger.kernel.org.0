Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492493115CA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 23:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBEWl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 17:41:56 -0500
Received: from muru.com ([72.249.23.125]:57620 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhBENqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 08:46:23 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 281BD80F1;
        Fri,  5 Feb 2021 13:45:53 +0000 (UTC)
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
Subject: [PATCH 1/4] thermal: ti-soc-thermal: Skip pointless register access for dra7
Date:   Fri,  5 Feb 2021 15:45:31 +0200
Message-Id: <20210205134534.49200-2-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205134534.49200-1-tony@atomide.com>
References: <20210205134534.49200-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 29 +++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
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
-- 
2.30.0
