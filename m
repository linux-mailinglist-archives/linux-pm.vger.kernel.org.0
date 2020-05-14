Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773491D4181
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgENXFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:39 -0400
Received: from mail-bn8nam12olkn2108.outbound.protection.outlook.com ([40.92.21.108]:20142
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728508AbgENXFL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+oD2qsV3IsjlI2vZ66rpKeZ7LBWeLwjDqPGsKoOo7ZhKEo53M+FMxK2ywa0cNChWzISLEVUf/A+cXKkBU081aRVG6xBxoNMa2W0DUX9CSe6VXHnV3KancyCrKYjN/8VByzAGOZDpJpnzRXglqhdj4UqoqcCFOLeIAZ+J+DZLMM+US6iEFOQJiI+srMPx4FNBdEYju4Fqzs6rb8EOY4KaWmkPnaZ7oON2iOo5bLUOWCGO0iu92PHa4Y2NMwcYNQCrJQX8fWhXa0QQHqAvFbqENfUnwO1aOBOe4t9zsJw3msIt1V4RrKAAlHv+oNkqWuABUo3h3vDzwjbeUywYBVYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyjKg82RDXOCg9HNE8hwuthY+JJZ6CRJdrgIFzS+iNo=;
 b=RbnFLpQZeIDa1Q1Ov+j3FgFtvu2MLKK/YThLyRGh/4QS4IaRtOcM3GfJciBQ2DJSszt+mXXM5P0zUSNXnEQLXQxBNCEG1NO7/FiY5zekj2Mt0cvv6/FfdKNwUPUPPtwgafRaNW9eie8vlKdbcWiRQqeT6sw6EHojR5rtUzkyz51cm9E3DwbFnmpMBbxRWsjtssZ7eNqP58NhE/BXw9mm/GJzXeAmv03eIbU+r57IhbkhtwX6ieTMPuYoNoAxeQC5MJE8FAOBD5z6gAQwwYs5UKRNkFsHsQIn92BOLBkYMFtbwIArybwI6GQy4WvxOwNgGQDEX+3K2VfuflzUhHTI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::48) by
 MW2NAM12HT165.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::320)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Thu, 14 May
 2020 23:05:07 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:07 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:2016BDC7D35C5A6C359D7E9001B4EDC8631378461CFA9E445D7FF99FCAA2B433;UpperCasedChecksum:6018D499545EF9CA234DD02394934E579641570A08EE1F3EA4A34A0726C73216;SizeAsReceived:7957;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:07 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 02/10] power: supply: charger-manager: Remove cm_notify_event function
Date:   Thu, 14 May 2020 16:04:27 -0700
Message-ID: <BN6PR04MB06604875336EFFBA725E02BCA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:05 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-3-xc-racer2@live.ca>
X-TMN:  [xV0L5Z9tMl1BQBrVnn0IYO2sSh5535YaB7QpL7I3vEApBrFNhWEMqDXDGOUhWZo1]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 91cd1ee8-1f5e-4fb2-2468-08d7f85b3e71
X-MS-TrafficTypeDiagnostic: MW2NAM12HT165:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/8jDoMB5T4IH3FjWgOgHjkbRzf2TWk6hDoXQ+7oghldWYXs3sYbVYS8/jvo9h70ezrUk4TCqRd+utC3/51P+eJrNyu8aW+lgq6GpB2i7Y0JiKrPVf4rmlmJXJNp0tJiw/W+qzRdPU8tY8mX7W3Ukae7lddrLBN9bdHYitzr/KELzdfhl1UBP+I5Gqkl3kJrVPdf5CZL+5BKhQdeMSm07Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: vNj+264zHEsFFjpQ7zvYkxF83FqUXm76HPVebLT5vPxfNlp46U8biAIrvnH7NqryeBl15DMwQLhShcv6KIbDUq9E87fSTueqFLmMFyp/QKwWIGkcXez3iFMPwtn+/DjAFJho1/N93iwPR1npNKUF/SukHa+FWLFGSJz1VWhNgMoe4WuPLnlwszSoIUXQvhjBP8RomHInIFKAk3KRAWyImw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cd1ee8-1f5e-4fb2-2468-08d7f85b3e71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:07.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT165
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

cm_notify_event() was introduced to get an event associated with the
battery status externally (ie in board files), but no one ever used it.
Moreover it makes charger manager driver more complicated. Drop the
function and all data related to it to simplify the driver.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 183 ++-----------------------
 include/linux/power/charger-manager.h  |  33 +----
 2 files changed, 16 insertions(+), 200 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 330185b960a5..413f291fda5f 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -434,25 +434,18 @@ static int try_charger_restart(struct charger_manager *cm)
 
 /**
  * fullbatt_vchk - Check voltage drop some times after "FULL" event.
- * @work: the work_struct appointing the function
  *
- * If a user has designated "fullbatt_vchkdrop_ms/uV" values with
+ * If a user has designated "fullbatt_vchkdrop_uV" values with
  * charger_desc, Charger Manager checks voltage drop after the battery
  * "FULL" event. It checks whether the voltage has dropped more than
  * fullbatt_vchkdrop_uV by calling this function after fullbatt_vchkrop_ms.
  */
-static void fullbatt_vchk(struct work_struct *work)
+static void fullbatt_vchk(struct charger_manager *cm)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct charger_manager *cm = container_of(dwork,
-			struct charger_manager, fullbatt_vchk_work);
 	struct charger_desc *desc = cm->desc;
 	int batt_uV, err, diff;
 
-	/* remove the appointment for fullbatt_vchk */
-	cm->fullbatt_vchk_jiffies_at = 0;
-
-	if (!desc->fullbatt_vchkdrop_uV || !desc->fullbatt_vchkdrop_ms)
+	if (!desc->fullbatt_vchkdrop_uV)
 		return;
 
 	err = get_batt_uV(cm, &batt_uV);
@@ -588,9 +581,11 @@ static int cm_check_thermal_status(struct charger_manager *cm)
 	}
 
 	if (temp > upper_limit)
-		ret = CM_EVENT_BATT_OVERHEAT;
+		ret = CM_BATT_OVERHEAT;
 	else if (temp < lower_limit)
-		ret = CM_EVENT_BATT_COLD;
+		ret = CM_BATT_COLD;
+	else
+		ret = CM_BATT_OK;
 
 	return ret;
 }
@@ -635,7 +630,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	 */
 	} else if (!cm->emergency_stop && is_ext_pwr_online(cm) &&
 			!cm->charger_enabled) {
-		fullbatt_vchk(&cm->fullbatt_vchk_work.work);
+		fullbatt_vchk(cm);
 
 	/*
 	 * Check whether fully charged state to protect overcharge
@@ -648,7 +643,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 
 		try_charger_enable(cm, false);
 
-		fullbatt_vchk(&cm->fullbatt_vchk_work.work);
+		fullbatt_vchk(cm);
 	} else {
 		cm->emergency_stop = 0;
 		if (is_ext_pwr_online(cm)) {
@@ -750,66 +745,6 @@ static void cm_monitor_poller(struct work_struct *work)
 	schedule_work(&setup_polling);
 }
 
-/**
- * fullbatt_handler - Event handler for CM_EVENT_BATT_FULL
- * @cm: the Charger Manager representing the battery.
- */
-static void fullbatt_handler(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-
-	if (!desc->fullbatt_vchkdrop_uV || !desc->fullbatt_vchkdrop_ms)
-		goto out;
-
-	if (cm_suspended)
-		device_set_wakeup_capable(cm->dev, true);
-
-	mod_delayed_work(cm_wq, &cm->fullbatt_vchk_work,
-			 msecs_to_jiffies(desc->fullbatt_vchkdrop_ms));
-	cm->fullbatt_vchk_jiffies_at = jiffies + msecs_to_jiffies(
-				       desc->fullbatt_vchkdrop_ms);
-
-	if (cm->fullbatt_vchk_jiffies_at == 0)
-		cm->fullbatt_vchk_jiffies_at = 1;
-
-out:
-	dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-	power_supply_changed(cm->charger_psy);
-}
-
-/**
- * battout_handler - Event handler for CM_EVENT_BATT_OUT
- * @cm: the Charger Manager representing the battery.
- */
-static void battout_handler(struct charger_manager *cm)
-{
-	if (cm_suspended)
-		device_set_wakeup_capable(cm->dev, true);
-
-	if (!is_batt_present(cm)) {
-		dev_emerg(cm->dev, "Battery Pulled Out!\n");
-		power_supply_changed(cm->charger_psy);
-	} else {
-		power_supply_changed(cm->charger_psy);
-	}
-}
-
-/**
- * misc_event_handler - Handler for other events
- * @cm: the Charger Manager representing the battery.
- * @type: the Charger Manager representing the battery.
- */
-static void misc_event_handler(struct charger_manager *cm,
-			enum cm_event_types type)
-{
-	if (cm_suspended)
-		device_set_wakeup_capable(cm->dev, true);
-
-	if (is_polling_required(cm) && cm->desc->polling_interval_ms)
-		schedule_work(&setup_polling);
-	power_supply_changed(cm->charger_psy);
-}
-
 static int charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp,
 		union power_supply_propval *val)
@@ -1000,21 +935,6 @@ static bool cm_setup_timer(void)
 
 	mutex_lock(&cm_list_mtx);
 	list_for_each_entry(cm, &cm_list, entry) {
-		unsigned int fbchk_ms = 0;
-
-		/* fullbatt_vchk is required. setup timer for that */
-		if (cm->fullbatt_vchk_jiffies_at) {
-			fbchk_ms = jiffies_to_msecs(cm->fullbatt_vchk_jiffies_at
-						    - jiffies);
-			if (time_is_before_eq_jiffies(
-				cm->fullbatt_vchk_jiffies_at) ||
-				msecs_to_jiffies(fbchk_ms) < CM_JIFFIES_SMALL) {
-				fullbatt_vchk(&cm->fullbatt_vchk_work.work);
-				fbchk_ms = 0;
-			}
-		}
-		CM_MIN_VALID(wakeup_ms, fbchk_ms);
-
 		/* Skip if polling is not required for this CM */
 		if (!is_polling_required(cm) && !cm->emergency_stop)
 			continue;
@@ -1422,8 +1342,6 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	of_property_read_u32(np, "cm-poll-interval",
 				&desc->polling_interval_ms);
 
-	of_property_read_u32(np, "cm-fullbatt-vchkdrop-ms",
-					&desc->fullbatt_vchkdrop_ms);
 	of_property_read_u32(np, "cm-fullbatt-vchkdrop-volt",
 					&desc->fullbatt_vchkdrop_uV);
 	of_property_read_u32(np, "cm-fullbatt-voltage", &desc->fullbatt_uV);
@@ -1583,9 +1501,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	if (desc->fullbatt_uV == 0) {
 		dev_info(&pdev->dev, "Ignoring full-battery voltage threshold as it is not supplied\n");
 	}
-	if (!desc->fullbatt_vchkdrop_ms || !desc->fullbatt_vchkdrop_uV) {
+	if (!desc->fullbatt_vchkdrop_uV) {
 		dev_info(&pdev->dev, "Disabling full-battery voltage drop checking mechanism as it is not supplied\n");
-		desc->fullbatt_vchkdrop_ms = 0;
 		desc->fullbatt_vchkdrop_uV = 0;
 	}
 	if (desc->fullbatt_soc == 0) {
@@ -1689,8 +1606,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	power_supply_put(fuel_gauge);
 
-	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
-
 	/* Register sysfs entry for charger(regulator) */
 	ret = charger_manager_prepare_sysfs(cm);
 	if (ret < 0) {
@@ -1830,8 +1745,6 @@ static bool cm_need_to_awake(void)
 
 static int cm_suspend_prepare(struct device *dev)
 {
-	struct charger_manager *cm = dev_get_drvdata(dev);
-
 	if (cm_need_to_awake())
 		return -EBUSY;
 
@@ -1843,7 +1756,6 @@ static int cm_suspend_prepare(struct device *dev)
 	if (cm_timer_set) {
 		cancel_work_sync(&setup_polling);
 		cancel_delayed_work_sync(&cm_monitor_work);
-		cancel_delayed_work(&cm->fullbatt_vchk_work);
 	}
 
 	return 0;
@@ -1868,31 +1780,6 @@ static void cm_suspend_complete(struct device *dev)
 
 	_cm_monitor(cm);
 
-	/* Re-enqueue delayed work (fullbatt_vchk_work) */
-	if (cm->fullbatt_vchk_jiffies_at) {
-		unsigned long delay = 0;
-		unsigned long now = jiffies + CM_JIFFIES_SMALL;
-
-		if (time_after_eq(now, cm->fullbatt_vchk_jiffies_at)) {
-			delay = (unsigned long)((long)now
-				- (long)(cm->fullbatt_vchk_jiffies_at));
-			delay = jiffies_to_msecs(delay);
-		} else {
-			delay = 0;
-		}
-
-		/*
-		 * Account for cm_suspend_duration_ms with assuming that
-		 * timer stops in suspend.
-		 */
-		if (delay > cm_suspend_duration_ms)
-			delay -= cm_suspend_duration_ms;
-		else
-			delay = 0;
-
-		queue_delayed_work(cm_wq, &cm->fullbatt_vchk_work,
-				   msecs_to_jiffies(delay));
-	}
 	device_set_wakeup_capable(cm->dev, false);
 }
 
@@ -1934,56 +1821,6 @@ static void __exit charger_manager_cleanup(void)
 }
 module_exit(charger_manager_cleanup);
 
-/**
- * cm_notify_event - charger driver notify Charger Manager of charger event
- * @psy: pointer to instance of charger's power_supply
- * @type: type of charger event
- * @msg: optional message passed to uevent_notify function
- */
-void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
-		     char *msg)
-{
-	struct charger_manager *cm;
-	bool found_power_supply = false;
-
-	if (psy == NULL)
-		return;
-
-	mutex_lock(&cm_list_mtx);
-	list_for_each_entry(cm, &cm_list, entry) {
-		if (match_string(cm->desc->psy_charger_stat, -1,
-				 psy->desc->name) >= 0) {
-			found_power_supply = true;
-			break;
-		}
-	}
-	mutex_unlock(&cm_list_mtx);
-
-	if (!found_power_supply)
-		return;
-
-	switch (type) {
-	case CM_EVENT_BATT_FULL:
-		fullbatt_handler(cm);
-		break;
-	case CM_EVENT_BATT_OUT:
-		battout_handler(cm);
-		break;
-	case CM_EVENT_BATT_IN:
-	case CM_EVENT_EXT_PWR_IN_OUT ... CM_EVENT_CHG_START_STOP:
-		misc_event_handler(cm, type);
-		break;
-	case CM_EVENT_UNKNOWN:
-	case CM_EVENT_OTHERS:
-		power_supply_changed(cm->charger_psy);
-		break;
-	default:
-		dev_err(cm->dev, "%s: type not specified\n", __func__);
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(cm_notify_event);
-
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("Charger Manager");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index ae94dcebd936..3a98837684e3 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -31,16 +31,10 @@ enum polling_modes {
 	CM_POLL_CHARGING_ONLY,
 };
 
-enum cm_event_types {
-	CM_EVENT_UNKNOWN = 0,
-	CM_EVENT_BATT_FULL,
-	CM_EVENT_BATT_IN,
-	CM_EVENT_BATT_OUT,
-	CM_EVENT_BATT_OVERHEAT,
-	CM_EVENT_BATT_COLD,
-	CM_EVENT_EXT_PWR_IN_OUT,
-	CM_EVENT_CHG_START_STOP,
-	CM_EVENT_OTHERS,
+enum cm_batt_temp {
+	CM_BATT_OK = 0,
+	CM_BATT_OVERHEAT,
+	CM_BATT_COLD,
 };
 
 /**
@@ -131,11 +125,10 @@ struct charger_regulator {
  * @psy_name: the name of power-supply-class for charger manager
  * @polling_mode:
  *	Determine which polling mode will be used
- * @fullbatt_vchkdrop_ms:
  * @fullbatt_vchkdrop_uV:
  *	Check voltage drop after the battery is fully charged.
- *	If it has dropped more than fullbatt_vchkdrop_uV after
- *	fullbatt_vchkdrop_ms, CM will restart charging.
+ *	If it has dropped more than fullbatt_vchkdrop_uV
+ *	CM will restart charging.
  * @fullbatt_uV: voltage in microvolt
  *	If VBATT >= fullbatt_uV, it is assumed to be full.
  * @fullbatt_soc: state of Charge in %
@@ -172,7 +165,6 @@ struct charger_desc {
 	enum polling_modes polling_mode;
 	unsigned int polling_interval_ms;
 
-	unsigned int fullbatt_vchkdrop_ms;
 	unsigned int fullbatt_vchkdrop_uV;
 	unsigned int fullbatt_uV;
 	unsigned int fullbatt_soc;
@@ -211,9 +203,6 @@ struct charger_desc {
  * @charger_stat: array of power_supply for chargers
  * @tzd_batt : thermal zone device for battery
  * @charger_enabled: the state of charger
- * @fullbatt_vchk_jiffies_at:
- *	jiffies at the time full battery check will occur.
- * @fullbatt_vchk_work: work queue for full battery check
  * @emergency_stop:
  *	When setting true, stop charging
  * @psy_name_buf: the name of power-supply-class for charger manager
@@ -235,9 +224,6 @@ struct charger_manager {
 #endif
 	bool charger_enabled;
 
-	unsigned long fullbatt_vchk_jiffies_at;
-	struct delayed_work fullbatt_vchk_work;
-
 	int emergency_stop;
 
 	char psy_name_buf[PSY_NAME_MAX + 1];
@@ -248,11 +234,4 @@ struct charger_manager {
 	u64 charging_end_time;
 };
 
-#if IS_ENABLED(CONFIG_CHARGER_MANAGER)
-extern void cm_notify_event(struct power_supply *psy,
-				enum cm_event_types type, char *msg);
-#else
-static inline void cm_notify_event(struct power_supply *psy,
-				enum cm_event_types type, char *msg) { }
-#endif
 #endif /* _CHARGER_MANAGER_H */
-- 
2.20.1

