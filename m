Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C831D4175
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgENXFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:20 -0400
Received: from mail-mw2nam12olkn2105.outbound.protection.outlook.com ([40.92.23.105]:50784
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729057AbgENXFR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY/CjIXNxvW2K0W0VUBLOCjMHyII0PP+40VJW3JroG8v3Yg3Q6yy+eeyEtZtVcyOphr16VvhTp5MwxZdvteg/zYbcQlBCcHlgsbSWfG3Yvertm4/g4nhw7K3aEWEKEhuVan1IK/gk4MBQ3e+fXxyOOlKazsIgMRgk5JccYzai5pEc8UyQjbbWMgF3bncdIgl5tYFnYIet0pGIQxEqtHGxS0mIWjigfjwBpjEtBHtF/n4oiXbxopQN1k9LJ25kufp/gihfoirBIgfa3+SOKOC5lD8uQF+2J3gZQLvswSOoTzlG0c+wdsforAtNrBxh5x20ndo5LdM2E5tNB+VC5kF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRhZL1bZkietTQ0o2ZfyTfRCGzEekdpIMS2F/8N8EX8=;
 b=Kk7/uCKX6UXuR2Yilfpk0aFlk3I0uO2aNvRjptM4oNwG8MxiB2zO7FB3HwIFxvDK2ByfFQQEMk14z8SiHEuTennlGw7zwuV3GHt3lpHR5tHdgEuNgpkGvSH12hcfOIYzyb0RDau3DoBawZtxNc7Lk4iRbE9p69ZbQNN0TyIPNvqx2PMRrjy5CKtEDzUYSSzMJQz9p+suT29BxN4DMByqMd6+BFFCfgzfUXaTzP6YOw6smy1iRerazySbUcV057LDHUzT2BMa4ZOSZ3NlYLF+SanwjjIwrMBoMHYezLPQmfvnoz6Uoka0wtCGZRu9bu1oYuZLb5B61W8RnMJJPgfj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::43) by
 MW2NAM12HT105.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::139)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:14 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:14 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9935C6736AFA23F056AE7BE382B566E572D625F1F2009748A3E144141AD3F898;UpperCasedChecksum:6D0E67D090ED02E3B819CFF61B9DE0BFA133034D6629F592DE6D8A2998A2665A;SizeAsReceived:7953;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:14 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 06/10] power: supply: charger-manager: Make decisions focussed on battery status
Date:   Thu, 14 May 2020 16:04:31 -0700
Message-ID: <BN6PR04MB0660E0C3B38D73632FDA1D7FA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-7-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:12 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-7-xc-racer2@live.ca>
X-TMN:  [9qETSCHe94zv59gnv8EhDc5vAYzACONT9vzKhW+2B8HzcwZUXmP/dNYbmyL8Knl7]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 348835cb-4566-4a9e-5220-08d7f85b42a7
X-MS-TrafficTypeDiagnostic: MW2NAM12HT105:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B47m44DcrTLgpPgD8y5gA2vXyaRgX0TxHIFdsBYca7mv89W6FN8UBnZ68hanxRb92N79Jiu4QM5AGF4BtUZCHPTubXAxtyhE6aRQvwaDxcLBsJf0aTKt3Uvl+4uDWT4AKceiqEG/YJ+O7JJnXla5jj99NCU6fXvCjvmPcip9dkrLsfvl7VBlB2cyXPL9+L7JhinkWbynpB5RmeQm1AQMdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: b4xoJh5i7pZ2HjqlWbOYC+8CQ5mJ++5QCm3c5Ez68fLu/id/8u/3MUksYDpHEVu8J1o4MYr+Ebl84Q2ZErjeOHXlCb8UxQbOyC3CGFvQ32VMd429tmd4J0fUQK8xtUr243vALsXjTbNhVAsRzqj9e2zs/d6EQqail1njUg8Vtp/uPvxZlFj9boPj31/Hebt6A3XKRBkSGOCiagVEdzpVDQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348835cb-4566-4a9e-5220-08d7f85b42a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:14.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT105
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

cm_monitor(), where charging management starts, checks various charging
condition sequentially to decide next charging operation. However, as it
follows sequential process, cascaded if statements, it does some
jobs which have already done in the previous stage. This results in a
delay in decision making. Moreover, starting point of charging is spread
all around which makes maintain code and debugging difficult.

Both of the problems mentioned above become clean if it manages battery
charging focusing on battery status not following sequential condition
checking.  Now, cm_monitor() moves battery state diagram and does the
optimal operation for current state. As a result, it reduces whole
monitoring time almost in half.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 181 +++++++++----------------
 include/linux/power/charger-manager.h  |   3 +
 2 files changed, 64 insertions(+), 120 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index b2daab480eb3..9e4a7d368b08 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -271,6 +271,19 @@ static bool is_full_charged(struct charger_manager *cm)
 	if (!fuel_gauge)
 		return false;
 
+	/* Full, if it's over the fullbatt voltage */
+	if (desc->fullbatt_uV > 0) {
+		ret = get_batt_uV(cm, &uV);
+		if (!ret) {
+			/* Battery is already full, checks voltage drop. */
+			if (cm->battery_status == POWER_SUPPLY_STATUS_FULL
+					&& desc->fullbatt_vchkdrop_uV)
+				uV += desc->fullbatt_vchkdrop_uV;
+			if (uV >= desc->fullbatt_uV)
+				return true;
+		}
+	}
+
 	if (desc->fullbatt_full_capacity > 0) {
 		val.intval = 0;
 
@@ -283,15 +296,6 @@ static bool is_full_charged(struct charger_manager *cm)
 		}
 	}
 
-	/* Full, if it's over the fullbatt voltage */
-	if (desc->fullbatt_uV > 0) {
-		ret = get_batt_uV(cm, &uV);
-		if (!ret && uV >= desc->fullbatt_uV) {
-			is_full = true;
-			goto out;
-		}
-	}
-
 	/* Full, if the capacity is more than fullbatt_soc */
 	if (desc->fullbatt_soc > 0) {
 		val.intval = 0;
@@ -406,66 +410,12 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
-	if (!err) {
+	if (!err)
 		cm->charger_enabled = enable;
-		power_supply_changed(cm->charger_psy);
-	}
 
 	return err;
 }
 
-/**
- * try_charger_restart - Restart charging.
- * @cm: the Charger Manager representing the battery.
- *
- * Restart charging by turning off and on the charger.
- */
-static int try_charger_restart(struct charger_manager *cm)
-{
-	int err;
-
-	if (cm->emergency_stop)
-		return -EAGAIN;
-
-	err = try_charger_enable(cm, false);
-	if (err)
-		return err;
-
-	return try_charger_enable(cm, true);
-}
-
-/**
- * fullbatt_vchk - Check voltage drop some times after "FULL" event.
- *
- * If a user has designated "fullbatt_vchkdrop_uV" values with
- * charger_desc, Charger Manager checks voltage drop after the battery
- * "FULL" event. It checks whether the voltage has dropped more than
- * fullbatt_vchkdrop_uV by calling this function after fullbatt_vchkrop_ms.
- */
-static void fullbatt_vchk(struct charger_manager *cm)
-{
-	struct charger_desc *desc = cm->desc;
-	int batt_uV, err, diff;
-
-	if (!desc->fullbatt_vchkdrop_uV)
-		return;
-
-	err = get_batt_uV(cm, &batt_uV);
-	if (err) {
-		dev_err(cm->dev, "%s: get_batt_uV error(%d)\n", __func__, err);
-		return;
-	}
-
-	diff = desc->fullbatt_uV - batt_uV;
-	if (diff < 0)
-		return;
-
-	dev_info(cm->dev, "VBATT dropped %duV after full-batt\n", diff);
-
-	if (diff > desc->fullbatt_vchkdrop_uV)
-		try_charger_restart(cm);
-}
-
 /**
  * check_charging_duration - Monitor charging/discharging duration
  * @cm: the Charger Manager representing the battery.
@@ -493,17 +443,14 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			try_charger_enable(cm, false);
 			ret = true;
 		}
-	} else if (is_ext_pwr_online(cm) && !cm->charger_enabled) {
+	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
 		duration = curr - cm->charging_end_time;
 
-		if (duration > desc->discharging_max_duration_ms &&
-				is_ext_pwr_online(cm)) {
+		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			try_charger_enable(cm, true);
 			ret = true;
 		}
 	}
@@ -585,9 +532,46 @@ static int cm_check_thermal_status(struct charger_manager *cm)
 	else
 		ret = CM_BATT_OK;
 
+	cm->emergency_stop = ret;
+
 	return ret;
 }
 
+/**
+ * cm_get_target_status - Check current status and get next target status.
+ * @cm: the Charger Manager representing the battery.
+ */
+static int cm_get_target_status(struct charger_manager *cm)
+{
+	if (!is_ext_pwr_online(cm))
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	if (cm_check_thermal_status(cm)) {
+		/* Check if discharging duration exeeds limit. */
+		if (check_charging_duration(cm))
+			goto charging_ok;
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+
+	switch (cm->battery_status) {
+	case POWER_SUPPLY_STATUS_CHARGING:
+		/* Check if charging duration exeeds limit. */
+		if (check_charging_duration(cm))
+			return POWER_SUPPLY_STATUS_FULL;
+		fallthrough;
+	case POWER_SUPPLY_STATUS_FULL:
+		if (is_full_charged(cm))
+			return POWER_SUPPLY_STATUS_FULL;
+		fallthrough;
+	default:
+		break;
+	}
+
+charging_ok:
+	/* Charging is allowed. */
+	return POWER_SUPPLY_STATUS_CHARGING;
+}
+
 /**
  * _cm_monitor - Monitor the temperature and return true for exceptions.
  * @cm: the Charger Manager representing the battery.
@@ -597,56 +581,18 @@ static int cm_check_thermal_status(struct charger_manager *cm)
  */
 static bool _cm_monitor(struct charger_manager *cm)
 {
-	int temp_alrt;
+	int target;
 
-	temp_alrt = cm_check_thermal_status(cm);
+	target = cm_get_target_status(cm);
 
-	/* It has been stopped already */
-	if (temp_alrt && cm->emergency_stop)
-		return false;
-
-	/*
-	 * Check temperature whether overheat or cold.
-	 * If temperature is out of range normal state, stop charging.
-	 */
-	if (temp_alrt) {
-		cm->emergency_stop = temp_alrt;
-		try_charger_enable(cm, false);
-
-	/*
-	 * Check whole charging duration and discharging duration
-	 * after full-batt.
-	 */
-	} else if (!cm->emergency_stop && check_charging_duration(cm)) {
-		dev_dbg(cm->dev,
-			"Charging/Discharging duration is out of range\n");
-	/*
-	 * Check dropped voltage of battery. If battery voltage is more
-	 * dropped than fullbatt_vchkdrop_uV after fully charged state,
-	 * charger-manager have to recharge battery.
-	 */
-	} else if (!cm->emergency_stop && is_ext_pwr_online(cm) &&
-			!cm->charger_enabled) {
-		fullbatt_vchk(cm);
+	try_charger_enable(cm, (target == POWER_SUPPLY_STATUS_CHARGING));
 
-	/*
-	 * Check whether fully charged state to protect overcharge
-	 * if charger-manager is charging for battery.
-	 */
-	} else if (!cm->emergency_stop && is_full_charged(cm) &&
-			cm->charger_enabled) {
-		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		try_charger_enable(cm, false);
-
-		fullbatt_vchk(cm);
-	} else {
-		cm->emergency_stop = 0;
-		if (is_ext_pwr_online(cm)) {
-			try_charger_enable(cm, true);
-		}
+	if (cm->battery_status != target) {
+		cm->battery_status = target;
+		power_supply_changed(cm->charger_psy);
 	}
 
-	return true;
+	return (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING);
 }
 
 /**
@@ -751,12 +697,7 @@ static int charger_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (is_charging(cm))
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (is_ext_pwr_online(cm))
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		val->intval = cm->battery_status;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
 		if (cm->emergency_stop > 0)
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 3a98837684e3..c127dbe31e49 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -213,6 +213,7 @@ struct charger_desc {
  *	saved status of battery before entering suspend-to-RAM
  * @charging_start_time: saved start time of enabling charging
  * @charging_end_time: saved end time of disabling charging
+ * @battery_status: Current battery status
  */
 struct charger_manager {
 	struct list_head entry;
@@ -232,6 +233,8 @@ struct charger_manager {
 
 	u64 charging_start_time;
 	u64 charging_end_time;
+
+	int battery_status;
 };
 
 #endif /* _CHARGER_MANAGER_H */
-- 
2.20.1

