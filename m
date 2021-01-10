Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA52F0986
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbhAJTzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:36 -0500
Received: from muru.com ([72.249.23.125]:42510 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbhAJTzf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:35 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 66FE588E0;
        Sun, 10 Jan 2021 19:54:29 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 12/15] power: supply: cpcap-battery: Keep track of state for capacity reporting
Date:   Sun, 10 Jan 2021 21:54:00 +0200
Message-Id: <20210110195403.13758-13-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arthur Demchenkov <spinal.by@gmail.com>

Save the battery empty and full states so we can use those to estimate
the battery capacity in the following patches.

If the user provides us with charge_full value (which it could save in a
permanent storage between reboots), initialize low and high counter_uah
with calculated values.

If we hit battery low once, we should stick on reporting it until the
charger is connected. This way low->counter_uah will be updated
properly, and that will allow us to get more accurate charge_full value.

Based on an earlier patch by Tony Lindgren with charge_full usage and
other improvments done by Arthur Demchenkov.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Co-developed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
[tony@atomide.com: combined earlier patches, updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 56 +++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -111,6 +111,8 @@ struct cpcap_coulomb_counter_data {
 enum cpcap_battery_state {
 	CPCAP_BATTERY_STATE_PREVIOUS,
 	CPCAP_BATTERY_STATE_LATEST,
+	CPCAP_BATTERY_STATE_EMPTY,
+	CPCAP_BATTERY_STATE_FULL,
 	CPCAP_BATTERY_STATE_NR,
 };
 
@@ -166,6 +168,18 @@ cpcap_battery_previous(struct cpcap_battery_ddata *ddata)
 	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_PREVIOUS);
 }
 
+static struct cpcap_battery_state_data *
+cpcap_battery_get_empty(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_EMPTY);
+}
+
+static struct cpcap_battery_state_data *
+cpcap_battery_get_full(struct cpcap_battery_ddata *ddata)
+{
+	return cpcap_battery_get_state(ddata, CPCAP_BATTERY_STATE_FULL);
+}
+
 static int cpcap_charger_battery_temperature(struct cpcap_battery_ddata *ddata,
 					     int *value)
 {
@@ -431,9 +445,23 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 	return ddata->is_full;
 }
 
+static bool cpcap_battery_low(struct cpcap_battery_ddata *ddata)
+{
+	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
+	static bool is_low;
+
+	if (state->current_ua > 0 && (state->voltage <= 3350000 || is_low))
+		is_low = true;
+	else
+		is_low = false;
+
+	return is_low;
+}
+
 static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 {
-	struct cpcap_battery_state_data state, *latest, *previous;
+	struct cpcap_battery_state_data state, *latest, *previous,
+					*empty, *full;
 	ktime_t now;
 	int error;
 
@@ -462,6 +490,32 @@ static int cpcap_battery_update_status(struct cpcap_battery_ddata *ddata)
 	memcpy(previous, latest, sizeof(*previous));
 	memcpy(latest, &state, sizeof(*latest));
 
+	if (cpcap_battery_full(ddata)) {
+		full = cpcap_battery_get_full(ddata);
+		memcpy(full, latest, sizeof(*full));
+
+		empty = cpcap_battery_get_empty(ddata);
+		if (empty->voltage && empty->voltage != -1) {
+			empty->voltage = -1;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
+		} else if (ddata->charge_full) {
+			empty->voltage = -1;
+			empty->counter_uah =
+				full->counter_uah + ddata->charge_full;
+		}
+	} else if (cpcap_battery_low(ddata)) {
+		empty = cpcap_battery_get_empty(ddata);
+		memcpy(empty, latest, sizeof(*empty));
+
+		full = cpcap_battery_get_full(ddata);
+		if (full->voltage) {
+			full->voltage = 0;
+			ddata->charge_full =
+				empty->counter_uah - full->counter_uah;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.30.0
