Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFDB57D5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfIQVxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:53:20 -0400
Received: from muru.com ([72.249.23.125]:33578 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfIQVxU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 17:53:20 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7987880F6;
        Tue, 17 Sep 2019 21:53:51 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/3] power: supply: cpcap-charger: Adjust current based on charger interrupts
Date:   Tue, 17 Sep 2019 14:52:53 -0700
Message-Id: <20190917215253.17880-4-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917215253.17880-1-tony@atomide.com>
References: <20190917215253.17880-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When debugging why higher than 500 mA charge current does not work, I
noticed that we start getting lots of chrgcurr1 interrupts if we attempt
to charge at rates higher than the charger can provide.

We can take advantage of the chrgcurr1 interrupts for charger detection,
and retry charging at a lower rate if charging fails. When an acceptable
charge rate is found, the chrgcurr1 interrupts stop.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -145,6 +145,12 @@ enum {
 	CPCAP_CHARGER_IIO_NR,
 };
 
+enum {
+	CPCAP_CHARGER_DISCONNECTED,
+	CPCAP_CHARGER_DETECTING,
+	CPCAP_CHARGER_CONNECTED,
+};
+
 struct cpcap_charger_ddata {
 	struct device *dev;
 	struct regmap *reg;
@@ -161,6 +167,9 @@ struct cpcap_charger_ddata {
 	unsigned int vbus_enabled:1;
 	unsigned int feeding_vbus:1;
 	int const_charge_voltage;
+	int state;
+	int last_current;
+	int last_current_retries;
 	atomic_t active;
 
 	int status;
@@ -551,6 +560,15 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (error)
 		return;
 
+	/* Just init the state if a charger is connected with no chrg_det set */
+	if (!ddata->feeding_vbus && !s.chrg_det && s.chrgcurr1 && s.vbusvld) {
+		ddata->state = CPCAP_CHARGER_DETECTING;
+		ddata->last_current = 0;
+
+		return;
+	}
+
+	/* Start charger on chrgcurr1, stop chrger otherwise */
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
 		int max_current;
@@ -561,6 +579,32 @@ static void cpcap_usb_detect(struct work_struct *work)
 		else
 			max_current = CPCAP_REG_CRM_ICHRG_0A532;
 
+		switch (ddata->state) {
+		case CPCAP_CHARGER_DETECTING:
+			ddata->state = CPCAP_CHARGER_CONNECTED;
+			ddata->last_current_retries = 0;
+			break;
+		case CPCAP_CHARGER_DISCONNECTED:
+			if (ddata->last_current > CPCAP_REG_CRM_ICHRG_0A532) {
+				/* Attempt current 3 times before lowering */
+				if (ddata->last_current_retries++ >= 3) {
+					ddata->last_current--;
+					ddata->last_current_retries = 0;
+					/* Wait a bit for voltage to ramp up */
+					usleep_range(40000, 50000);
+				}
+				max_current = ddata->last_current;
+			}
+			ddata->state = CPCAP_CHARGER_CONNECTED;
+			dev_info(ddata->dev, "enabling charger with current %i\n",
+				 max_current);
+			break;
+		default:
+			ddata->last_current_retries = 0;
+			break;
+		}
+
+		ddata->last_current = max_current;
 		cpcap_charger_match_voltage(ddata, ddata->const_charge_voltage,
 					    &vchrg);
 		error = cpcap_charger_set_state(ddata,
@@ -569,6 +613,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (error)
 			goto out_err;
 	} else {
+		ddata->state = CPCAP_CHARGER_DISCONNECTED;
 		error = cpcap_charger_set_state(ddata, 0, 0, 0);
 		if (error)
 			goto out_err;
-- 
2.23.0
