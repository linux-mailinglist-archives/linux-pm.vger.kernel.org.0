Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E21D4167
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgENXFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:09 -0400
Received: from mail-mw2nam12olkn2084.outbound.protection.outlook.com ([40.92.23.84]:28621
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbgENXFJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO0cFOQofIEESAc5fRVOhz9srlEMKK7fB8+sWxF9dG1U0GKfmsu7PBcQ5s5ktFZtC9dd0KxHS4W4PbpLIIUK9NB1ygTgq7LyfXf+B1calMyMpg6Lq+mCBn28qURHNpRmOlr7C/bxom4QQq9WS+SO2nycVL4vtLd97FMxr3bAtVSXCaJCELJFsPH8IYbgRn9z1YwBwf/oP6wxu9QJKRZbtvBQIUzmGtTMdcRz3JztsUBVihP9vYAb6rajxpLP6D/LQnGM3Fo7FezqWKK5amiiWtYoULSBvUk9TQY7/Shr5ECU729553FyTbEMigo67qcrncazAyYxzC+ss7aV3HTGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUCcqPZF46q0Hh6KXEjruQjzv4fka78JltJ4rJy8xpM=;
 b=Y1pr3MzfYnZhlNksrKmMtW7HzPr0LuHoRGww63ohv5Zab8JtLOnsuIF4Nalk+INIRYTK7A+kUlRiZTklWWK3f1sizZIgAePz4S+LEwORuq7RsJdNGUkHZnGImjQpugvxHDqQGKsfwPelOFfVeQpNGywwenKItBog24fsvU6n4oo2iJ9CZgwd/u8hxmGDcyhxbTxbeVmkkCey6+05BTmm8oo+MmZ/WCvZVH1T+A0Xgu5LOwgNRrpqduKUT+IYkzFf4RavlUD4Vn4HPp9L0PNIeo1NJFcn5rXu7BcxuFKRIvlbPIPbaG8TKAgtaxjutmC0PA4dF7alv1JvStg2+6+CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::42) by
 MW2NAM12HT256.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::347)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Thu, 14 May
 2020 23:05:05 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:05 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:96457069B7C8ECE2B32989EFB7E1F5D4DADFFD3A441ED28AA851DA2F7CED0FB9;UpperCasedChecksum:0278B8E250466512A3B55EE2741B6A3930D3A4C203E92490CD07E1149D2789B6;SizeAsReceived:7954;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:05 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 01/10] power: supply: charger-manager: Swap private uevent for power_supply_changed
Date:   Thu, 14 May 2020 16:04:26 -0700
Message-ID: <BN6PR04MB0660089AC6741DF0318C2949A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:04 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-2-xc-racer2@live.ca>
X-TMN:  [mPWESInzjCLz92pIXHfqiXC1ByhNVvhz3CPcz0+OaSZ94j1MlwaNEzaqt3PaUjLe]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: eeb8004d-7710-4412-fe06-08d7f85b3d5d
X-MS-TrafficTypeDiagnostic: MW2NAM12HT256:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3TyidNTycMoHuwCqjQxwoUlVk2ivaMpaJzGqs2P6nFiNhFuCQKYYqQ9K4Ie/z0U7IqDPaDQCVhCJMCvG52QjnN2JmsPJnJfRgfoU0SJ8YVFXULdXOK6BUvEk+4iBYExmTh518nD2XlNuQvEW9daEo2dliB0FRJPAGPa+b9Eepq6PkWmww0uoLnlAIxW2ZFGTXT8ETEwKEjxDQB6nsoUhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: wx8almPHaP0Jq9rE26RA5ylTygMxvedEN8J0H/QT6rQSDzit4sgCmBQpP11nrP1ft9QxWtXWtZD1E0oHbJJgxrPw5gIebSDSXsfPmgupvQKHfJYUwoeVT003jGDRy1bjyDY0bti+upFkQ8lbvID57LRNJEQzTieLQMATNJJGzVOeVBWbJR5A71QScbMa7jV5tcmf270E1c224CmmYZXiSQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb8004d-7710-4412-fe06-08d7f85b3d5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:05.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

Whenever the battery status is changed, charger manager triggers a uevent
through a private interface. Modify it to use power_supply_changed()
since it belongs to the power supply subsystem.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 91 ++++----------------------
 1 file changed, 11 insertions(+), 80 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a21e1a2673f8..330185b960a5 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -33,18 +33,6 @@
 #define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
 #define CM_DEFAULT_CHARGE_TEMP_MAX	500
 
-static const char * const default_event_names[] = {
-	[CM_EVENT_UNKNOWN] = "Unknown",
-	[CM_EVENT_BATT_FULL] = "Battery Full",
-	[CM_EVENT_BATT_IN] = "Battery Inserted",
-	[CM_EVENT_BATT_OUT] = "Battery Pulled Out",
-	[CM_EVENT_BATT_OVERHEAT] = "Battery Overheat",
-	[CM_EVENT_BATT_COLD] = "Battery Cold",
-	[CM_EVENT_EXT_PWR_IN_OUT] = "External Power Attach/Detach",
-	[CM_EVENT_CHG_START_STOP] = "Charging Start/Stop",
-	[CM_EVENT_OTHERS] = "Other battery events"
-};
-
 /*
  * Regard CM_JIFFIES_SMALL jiffies is small enough to ignore for
  * delayed works so that we can run delayed works with CM_JIFFIES_SMALL
@@ -61,8 +49,6 @@ static const char * const default_event_names[] = {
  */
 #define CM_RTC_SMALL		(2)
 
-#define UEVENT_BUF_SIZE		32
-
 static LIST_HEAD(cm_list);
 static DEFINE_MUTEX(cm_list_mtx);
 
@@ -446,61 +432,6 @@ static int try_charger_restart(struct charger_manager *cm)
 	return try_charger_enable(cm, true);
 }
 
-/**
- * uevent_notify - Let users know something has changed.
- * @cm: the Charger Manager representing the battery.
- * @event: the event string.
- *
- * If @event is null, it implies that uevent_notify is called
- * by resume function. When called in the resume function, cm_suspended
- * should be already reset to false in order to let uevent_notify
- * notify the recent event during the suspend to users. While
- * suspended, uevent_notify does not notify users, but tracks
- * events so that uevent_notify can notify users later after resumed.
- */
-static void uevent_notify(struct charger_manager *cm, const char *event)
-{
-	static char env_str[UEVENT_BUF_SIZE + 1] = "";
-	static char env_str_save[UEVENT_BUF_SIZE + 1] = "";
-
-	if (cm_suspended) {
-		/* Nothing in suspended-event buffer */
-		if (env_str_save[0] == 0) {
-			if (!strncmp(env_str, event, UEVENT_BUF_SIZE))
-				return; /* status not changed */
-			strncpy(env_str_save, event, UEVENT_BUF_SIZE);
-			return;
-		}
-
-		if (!strncmp(env_str_save, event, UEVENT_BUF_SIZE))
-			return; /* Duplicated. */
-		strncpy(env_str_save, event, UEVENT_BUF_SIZE);
-		return;
-	}
-
-	if (event == NULL) {
-		/* No messages pending */
-		if (!env_str_save[0])
-			return;
-
-		strncpy(env_str, env_str_save, UEVENT_BUF_SIZE);
-		kobject_uevent(&cm->dev->kobj, KOBJ_CHANGE);
-		env_str_save[0] = 0;
-
-		return;
-	}
-
-	/* status not changed */
-	if (!strncmp(env_str, event, UEVENT_BUF_SIZE))
-		return;
-
-	/* save the status and notify the update */
-	strncpy(env_str, event, UEVENT_BUF_SIZE);
-	kobject_uevent(&cm->dev->kobj, KOBJ_CHANGE);
-
-	dev_info(cm->dev, "%s\n", event);
-}
-
 /**
  * fullbatt_vchk - Check voltage drop some times after "FULL" event.
  * @work: the work_struct appointing the function
@@ -538,7 +469,7 @@ static void fullbatt_vchk(struct work_struct *work)
 
 	if (diff > desc->fullbatt_vchkdrop_uV) {
 		try_charger_restart(cm);
-		uevent_notify(cm, "Recharging");
+		power_supply_changed(cm->charger_psy);
 	}
 }
 
@@ -569,7 +500,7 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			uevent_notify(cm, "Discharging");
+			power_supply_changed(cm->charger_psy);
 			try_charger_enable(cm, false);
 			ret = true;
 		}
@@ -580,7 +511,7 @@ static int check_charging_duration(struct charger_manager *cm)
 				is_ext_pwr_online(cm)) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			uevent_notify(cm, "Recharging");
+			power_supply_changed(cm->charger_psy);
 			try_charger_enable(cm, true);
 			ret = true;
 		}
@@ -688,7 +619,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	if (temp_alrt) {
 		cm->emergency_stop = temp_alrt;
 		if (!try_charger_enable(cm, false))
-			uevent_notify(cm, default_event_names[temp_alrt]);
+			power_supply_changed(cm->charger_psy);
 
 	/*
 	 * Check whole charging duration and discharging duration
@@ -713,7 +644,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	} else if (!cm->emergency_stop && is_full_charged(cm) &&
 			cm->charger_enabled) {
 		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		uevent_notify(cm, default_event_names[CM_EVENT_BATT_FULL]);
+		power_supply_changed(cm->charger_psy);
 
 		try_charger_enable(cm, false);
 
@@ -722,7 +653,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 		cm->emergency_stop = 0;
 		if (is_ext_pwr_online(cm)) {
 			if (!try_charger_enable(cm, true))
-				uevent_notify(cm, "CHARGING");
+				power_supply_changed(cm->charger_psy);
 		}
 	}
 
@@ -843,7 +774,7 @@ static void fullbatt_handler(struct charger_manager *cm)
 
 out:
 	dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-	uevent_notify(cm, default_event_names[CM_EVENT_BATT_FULL]);
+	power_supply_changed(cm->charger_psy);
 }
 
 /**
@@ -857,9 +788,9 @@ static void battout_handler(struct charger_manager *cm)
 
 	if (!is_batt_present(cm)) {
 		dev_emerg(cm->dev, "Battery Pulled Out!\n");
-		uevent_notify(cm, default_event_names[CM_EVENT_BATT_OUT]);
+		power_supply_changed(cm->charger_psy);
 	} else {
-		uevent_notify(cm, "Battery Reinserted?");
+		power_supply_changed(cm->charger_psy);
 	}
 }
 
@@ -876,7 +807,7 @@ static void misc_event_handler(struct charger_manager *cm,
 
 	if (is_polling_required(cm) && cm->desc->polling_interval_ms)
 		schedule_work(&setup_polling);
-	uevent_notify(cm, default_event_names[type]);
+	power_supply_changed(cm->charger_psy);
 }
 
 static int charger_get_property(struct power_supply *psy,
@@ -2044,7 +1975,7 @@ void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
 		break;
 	case CM_EVENT_UNKNOWN:
 	case CM_EVENT_OTHERS:
-		uevent_notify(cm, msg ? msg : default_event_names[type]);
+		power_supply_changed(cm->charger_psy);
 		break;
 	default:
 		dev_err(cm->dev, "%s: type not specified\n", __func__);
-- 
2.20.1

