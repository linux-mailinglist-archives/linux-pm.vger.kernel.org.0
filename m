Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEC7490B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 10:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbfGYIZL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 04:25:11 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:9413
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389507AbfGYIZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 04:25:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C7BgC1Zjld/1/rO8tmghmDdhIXE40?=
 =?us-ascii?q?ZiBcBgkMBg1mFU48egXsJAQEBAQEBAQEBGxwBAYQ6BIMBNgcOAQMBAQEEAQE?=
 =?us-ascii?q?BAQUBbYRlRYV4L3JwEoMigXcTrkMzhAYBhG+BSIE0hwmEboFAP4ERgmRshAM?=
 =?us-ascii?q?NGIV/BIwkiROVNQmBJXeUEhmYC4tggViZVAYrgVhNHxmDJ4JOFxSNVkQ1MI5?=
 =?us-ascii?q?KAQE?=
X-IPAS-Result: =?us-ascii?q?A2C7BgC1Zjld/1/rO8tmghmDdhIXE40ZiBcBgkMBg1mFU?=
 =?us-ascii?q?48egXsJAQEBAQEBAQEBGxwBAYQ6BIMBNgcOAQMBAQEEAQEBAQUBbYRlRYV4L?=
 =?us-ascii?q?3JwEoMigXcTrkMzhAYBhG+BSIE0hwmEboFAP4ERgmRshAMNGIV/BIwkiROVN?=
 =?us-ascii?q?QmBJXeUEhmYC4tggViZVAYrgVhNHxmDJ4JOFxSNVkQ1MI5KAQE?=
X-IronPort-AV: E=Sophos;i="5.64,306,1559491200"; 
   d="scan'208";a="228549107"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 25 Jul 2019 16:25:04 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, enric.balletbo@collabora.com, ncrews@chromium.org,
        andrew.smirnov@gmail.com, groeck@chromium.org,
        rtresidd@electromag.com.au, david@lechnology.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        allison@lohutok.net, baolin.wang@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power/supply/sbs-battery: Fix confusing battery status when idle or empty
Date:   Thu, 25 Jul 2019 16:25:02 +0800
Message-Id: <1564043102-25298-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When a battery or batteries in a system are in parallel then one or more
may not be providing any current to the system.
This fixes an incorrect
status indication of FULL for the battery simply because it wasn't
discharging at that point in time.
The battery will now be flagged as IDLE.
Have also added the additional check for the battery FULL DISCHARGED flag
which will now flag a status of EMPTY.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    power/supply/sbs-battery: Fix confusing battery status when idle or empty
    
    When a battery or batteries in a system are in parallel then one or more
    may not be providing any current to the system.
    This fixes an incorrect
    status indication of FULL for the battery simply because it wasn't
    discharging at that point in time.
    The battery will now be flagged as IDLE.
    Have also added the additional check for the battery FULL DISCHARGED flag
    which will now flag a status of EMPTY.

 drivers/power/supply/power_supply_sysfs.c |  3 ++-
 drivers/power/supply/sbs-battery.c        | 28 ++++++++++++++--------------
 include/linux/power_supply.h              |  2 ++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index ce6671c..68ec49d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -51,7 +51,8 @@
 };
 
 static const char * const power_supply_status_text[] = {
-	"Unknown", "Charging", "Discharging", "Not charging", "Full"
+	"Unknown", "Charging", "Discharging", "Not charging", "Full",
+	"Empty", "Idle"
 };
 
 static const char * const power_supply_charge_type_text[] = {
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index ea8ba3e..e6c636c 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -294,14 +294,10 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 
 	ret = (s16)ret;
 
-	/* Not drawing current means full (cannot be not charging) */
-	if (ret == 0)
-		*intval = POWER_SUPPLY_STATUS_FULL;
-
-	if (*intval == POWER_SUPPLY_STATUS_FULL) {
-		/* Drawing or providing current when full */
-		if (ret > 0)
-			*intval = POWER_SUPPLY_STATUS_CHARGING;
+	if (*intval == POWER_SUPPLY_STATUS_DISCHARGING) {
+		/* Charging indicator not set in battery */
+		if (ret == 0)
+			*intval = POWER_SUPPLY_STATUS_IDLE;
 		else if (ret < 0)
 			*intval = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
@@ -424,10 +420,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
 
 		if (ret & BATTERY_FULL_CHARGED)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
-		else if (ret & BATTERY_DISCHARGING)
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
+		else if (ret & BATTERY_FULL_DISCHARGED)
+			val->intval = POWER_SUPPLY_STATUS_EMPTY;
+		else if (!(ret & BATTERY_DISCHARGING))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 
 		sbs_status_correct(client, &val->intval);
 
@@ -781,10 +779,12 @@ static void sbs_delayed_work(struct work_struct *work)
 
 	if (ret & BATTERY_FULL_CHARGED)
 		ret = POWER_SUPPLY_STATUS_FULL;
-	else if (ret & BATTERY_DISCHARGING)
-		ret = POWER_SUPPLY_STATUS_DISCHARGING;
-	else
+	else if (ret & BATTERY_FULL_DISCHARGED)
+		ret = POWER_SUPPLY_STATUS_EMPTY;
+	else if (!(ret & BATTERY_DISCHARGING))
 		ret = POWER_SUPPLY_STATUS_CHARGING;
+	else
+		ret = POWER_SUPPLY_STATUS_DISCHARGING;
 
 	sbs_status_correct(chip->client, &ret);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f7..c9f3347 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -37,6 +37,8 @@ enum {
 	POWER_SUPPLY_STATUS_DISCHARGING,
 	POWER_SUPPLY_STATUS_NOT_CHARGING,
 	POWER_SUPPLY_STATUS_FULL,
+	POWER_SUPPLY_STATUS_EMPTY,
+	POWER_SUPPLY_STATUS_IDLE,
 };
 
 /* What algorithm is the charger using? */
-- 
1.8.3.1

