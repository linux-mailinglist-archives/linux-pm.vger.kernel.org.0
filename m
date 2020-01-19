Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1409141FE6
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgASULe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 15:11:34 -0500
Received: from muru.com ([72.249.23.125]:51790 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASULe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Jan 2020 15:11:34 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A0DDC80F6;
        Sun, 19 Jan 2020 20:12:16 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/3] RFC: power: supply: cpcap-battery: Save high and low states
Date:   Sun, 19 Jan 2020 12:11:23 -0800
Message-Id: <20200119201124.29620-2-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119201124.29620-1-tony@atomide.com>
References: <20200119201124.29620-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we save the battery high and low states, we can use those to estimate
the battery capacity in the following patch.

Note that this too should probably use ocv-capacity-table as AFAIK that
has already similar data structures needed.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Not-yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 38 +++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -110,6 +110,8 @@ struct cpcap_coulomb_counter_data {
 enum cpcap_battery_state {
 	CPCAP_BATTERY_STATE_PREVIOUS,
 	CPCAP_BATTERY_STATE_LATEST,
+	CPCAP_BATTERY_STATE_LOW,
+	CPCAP_BATTERY_STATE_HIGH,
 	CPCAP_BATTERY_STATE_NR,
 };
 
@@ -183,6 +185,18 @@ cpcap_battery_previous(struct cpcap_battery_ddata *ddata)
 	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_PREVIOUS);
 }
 
+static struct cpcap_battery_state_data *
+cpcap_battery_get_lowest(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_LOW);
+}
+
+static struct cpcap_battery_state_data *
+cpcap_battery_get_highest(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_HIGH);
+}
+
 static int cpcap_charger_battery_temperature(struct cpcap_battery_ddata *ddata,
 					     int *value)
 {
@@ -400,9 +414,19 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 	return false;
 }
 
+static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
+{
+	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+
+	if (state->current_ua && state->voltage <= 3300000)
+		return true;
+
+	return false;
+}
+
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 {
-	struct cpcap_battery_state_data state, *latest, *previous;
+	struct cpcap_battery_state_data state, *latest, *previous, *tmp;
 	ktime_t now;
 	int error;
 
@@ -431,6 +455,18 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	memcpy(previous, latest, sizeof(*previous));
 	memcpy(latest, &state, sizeof(*latest));
 
+	if (cpcap_battery_full(ddata)) {
+		tmp = cpcap_battery_get_highest(ddata);
+		/* Update highest charge seen? */
+		if (latest->counter_uah <= tmp->counter_uah)
+			memcpy(tmp, latest, sizeof(*tmp));
+	} else if (cpcap_battery_low(ddata)) {
+		tmp = cpcap_battery_get_lowest(ddata);
+		/* Update lowest charge seen? */
+		if (latest->counter_uah >= tmp->counter_uah)
+			memcpy(tmp, latest, sizeof(*tmp));
+	}
+
 	return 0;
 }
 
-- 
2.24.1
