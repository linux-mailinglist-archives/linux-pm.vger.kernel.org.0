Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9C78700
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfG2IIE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 04:08:04 -0400
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:5354
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbfG2IIE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 04:08:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ANBgB3qD5d/1/rO8tmghmDVSESFxO?=
 =?us-ascii?q?NGogaAYJDAYNZhVORGgkBAQEBAQEBAQEbHAEBhDoEgwo3Bg4BAwEBAQQBAQE?=
 =?us-ascii?q?BBQFthGVFhXgvcnASgyKBdxOsVjOEBgGEcoFIgTSHCYRugUA/g3VshAMNGIV?=
 =?us-ascii?q?/BIwbCokUbZRRCYEld5QWGYIuizKKLotjgViZZCKBWE0fGYMngk4XFI1WRDU?=
 =?us-ascii?q?wjk4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2ANBgB3qD5d/1/rO8tmghmDVSESFxONGogaAYJDAYNZh?=
 =?us-ascii?q?VORGgkBAQEBAQEBAQEbHAEBhDoEgwo3Bg4BAwEBAQQBAQEBBQFthGVFhXgvc?=
 =?us-ascii?q?nASgyKBdxOsVjOEBgGEcoFIgTSHCYRugUA/g3VshAMNGIV/BIwbCokUbZRRC?=
 =?us-ascii?q?YEld5QWGYIuizKKLotjgViZZCKBWE0fGYMngk4XFI1WRDUwjk4BAQ?=
X-IronPort-AV: E=Sophos;i="5.64,322,1559491200"; 
   d="scan'208";a="178664786"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 29 Jul 2019 16:07:59 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, enric.balletbo@collabora.com, ncrews@chromium.org,
        andrew.smirnov@gmail.com, groeck@chromium.org,
        david@lechnology.com, rtresidd@electromag.com.au,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        allison@lohutok.net, baolin.wang@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] power/supply/sbs-battery: Fix confusing battery status when idle or empty
Date:   Mon, 29 Jul 2019 16:07:39 +0800
Message-Id: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a battery or batteries in a system are in parallel then one or more
may not be providing any current to the system.
This fixes an incorrect status indication of FULL for the battery simply
because it wasn't discharging at that point in time.
The battery will now be flagged as NOT CHARGING.
Have also added the additional check for the battery FULL DISCHARGED flag
which will now flag a status of EMPTY.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    power/supply/sbs-battery: Fix confusing battery status when idle or empty
    
    When a battery or batteries in a system are in parallel then one or more
    may not be providing any current to the system.
    This fixes an incorrect status indication of FULL for the battery simply
    because it wasn't discharging at that point in time.
    The battery will now be flagged as NOT CHARGING.
    Have also added the additional check for the battery FULL DISCHARGED flag
    which will now flag a status of EMPTY.
    
    v2: Missed a later merge that should have been included in original patch
    v3: Refactor the sbs_status_correct function to capture all the states for
        normal operation rather than being spread across multile functions.

 drivers/power/supply/power_supply_sysfs.c |  2 +-
 drivers/power/supply/sbs-battery.c        | 44 +++++++++++--------------------
 include/linux/power_supply.h              |  1 +
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4e..305e833 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -51,7 +51,7 @@
 };
 
 static const char * const power_supply_status_text[] = {
-	"Unknown", "Charging", "Discharging", "Not charging", "Full"
+	"Unknown", "Charging", "Discharging", "Not charging", "Full", "Empty"
 };
 
 static const char * const power_supply_charge_type_text[] = {
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205..b28402d 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -293,16 +293,18 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 
 	ret = (s16)ret;
 
-	/* Not drawing current means full (cannot be not charging) */
-	if (ret == 0)
-		*intval = POWER_SUPPLY_STATUS_FULL;
-
-	if (*intval == POWER_SUPPLY_STATUS_FULL) {
-		/* Drawing or providing current when full */
-		if (ret > 0)
-			*intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (ret < 0)
-			*intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	if (ret > 0)
+		*intval = POWER_SUPPLY_STATUS_CHARGING;
+	else if (ret < 0)
+		*intval = POWER_SUPPLY_STATUS_DISCHARGING;
+	else {
+		/* Current is 0, so how full is the battery? */
+		if (*intval & BATTERY_FULL_CHARGED)
+			*intval = POWER_SUPPLY_STATUS_FULL;
+		else if (*intval & BATTERY_FULL_DISCHARGED)
+			*intval = POWER_SUPPLY_STATUS_EMPTY;
+		else
+			*intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	}
 
 	return 0;
@@ -421,14 +423,9 @@ static int sbs_get_battery_property(struct i2c_client *client,
 			return 0;
 		}
 
-		if (ret & BATTERY_FULL_CHARGED)
-			val->intval = POWER_SUPPLY_STATUS_FULL;
-		else if (ret & BATTERY_DISCHARGING)
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-
-		sbs_status_correct(client, &val->intval);
+		ret = sbs_status_correct(client, &val->intval);
+		if (ret < 0)
+			return ret;
 
 		if (chip->poll_time == 0)
 			chip->last_state = val->intval;
@@ -773,20 +770,11 @@ static void sbs_delayed_work(struct work_struct *work)
 
 	ret = sbs_read_word_data(chip->client, sbs_data[REG_STATUS].addr);
 	/* if the read failed, give up on this work */
-	if (ret < 0) {
+	if ((ret < 0) || (sbs_status_correct(chip->client, &ret) < 0)) {
 		chip->poll_time = 0;
 		return;
 	}
 
-	if (ret & BATTERY_FULL_CHARGED)
-		ret = POWER_SUPPLY_STATUS_FULL;
-	else if (ret & BATTERY_DISCHARGING)
-		ret = POWER_SUPPLY_STATUS_DISCHARGING;
-	else
-		ret = POWER_SUPPLY_STATUS_CHARGING;
-
-	sbs_status_correct(chip->client, &ret);
-
 	if (chip->last_state != ret) {
 		chip->poll_time = 0;
 		power_supply_changed(chip->power_supply);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f7..8fb10ec 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -37,6 +37,7 @@ enum {
 	POWER_SUPPLY_STATUS_DISCHARGING,
 	POWER_SUPPLY_STATUS_NOT_CHARGING,
 	POWER_SUPPLY_STATUS_FULL,
+	POWER_SUPPLY_STATUS_EMPTY,
 };
 
 /* What algorithm is the charger using? */
-- 
1.8.3.1

