Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AE1D6486
	for <lists+linux-pm@lfdr.de>; Sun, 17 May 2020 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgEPWgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 May 2020 18:36:05 -0400
Received: from mail-dm6nam10olkn2089.outbound.protection.outlook.com ([40.92.41.89]:34038
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbgEPWgD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 May 2020 18:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEFcmMvoi0+X//KKLxDYx+lT8RGmtve9v1r/lj3YM0svlmJwO4Byj0+cOOOEoFk6ExKVwwn00yxoAz151pZp6AJTUT7dD8kqTGeZkZDpR1yLsHSntrcgX7vFc1X/k0RkOjuU710jA62OGcA+zdiqcvPdRbulFG1H1NWd/IFXIBlImvN0xBH4O9K0el9mEesZaOunf4Hh1XVTghZe9MlCJ+PPJ/d4XaMQkk17dFMSNQQXSOAhgjh3HSDAW7blC3v41o7hnT2yTIykE1pY+S/W7360/VOLhbRgwEpn4I8QPwc6OVbeGazVJA05yAroUzoyGIDbYWFR4vBfpnIiXNYKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w2NdsFWO9dxURL+eBDtpIWyjF5ZwMbJuybxim8zOUM=;
 b=PuZfgRBm623VSAuzlDAdm6u8Pn3CXst+NRDluJjoICSx5pnePIO/1hZaBlhv4xF5uU8ucU3sTntV06foBbQHeM5a9QvL36yTrP+/FF1dH8EINSU5I4JIO5rzZCy9YhABPjmRBQzxMywrBjT4LI4YDdgA35IkgRX4Lhe5R9RR/H76oNbk3MkvLecO+4ixaPucjKNI20t7NWkF8gMNIfDEDQG71kgS1pg/4Lt/0Jf6PZaPNDS29pBAEDScihMFbB/bF0EGvW9YeNObc4/QTLjs16A+lVrf7Ko/mi67Y8rtgUOwu5yHrsTSdqIFcV+q/CETQKlH/+G3hvqYsTkAxJyFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM10FT010.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e87::41) by
 MW2NAM10HT074.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e87::372)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 22:35:59 +0000
Received: from CY4PR04MB0663.namprd04.prod.outlook.com
 (2a01:111:e400:7e87::50) by MW2NAM10FT010.mail.protection.outlook.com
 (2a01:111:e400:7e87::391) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 22:35:59 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E908FD672C884836BEC4D2E66C549F265B10443298CDB22BE6F53C1CA1324404;UpperCasedChecksum:947BA66BA0FFD97303CF89542FFF17A80342B30594B188069F9BBD47A7308158;SizeAsReceived:7577;Count:48
Received: from CY4PR04MB0663.namprd04.prod.outlook.com
 ([fe80::45b1:12b6:ebd4:932b]) by CY4PR04MB0663.namprd04.prod.outlook.com
 ([fe80::45b1:12b6:ebd4:932b%10]) with mapi id 15.20.3000.022; Sat, 16 May
 2020 22:35:59 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] power: supply: max8998_charger: Correct ONLINE and add STATUS props
Date:   Sat, 16 May 2020 15:35:44 -0700
Message-ID: <CY4PR04MB066382CE428A87AD131DB96CA3BA0@CY4PR04MB0663.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:104:1::16) To CY4PR04MB0663.namprd04.prod.outlook.com
 (2603:10b6:903:e1::20)
X-Microsoft-Original-Message-ID: <20200516223544.27224-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR05CA0090.namprd05.prod.outlook.com (2603:10b6:104:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend Transport; Sat, 16 May 2020 22:35:58 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516223544.27224-1-xc-racer2@live.ca>
X-TMN:  [fZ6K0RDu+2t+p/Zg7VUbcblh8N9yubajkHzNd785I2WPKmesrj9zdP9SZj9cEhYu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 25348896-0683-4dd6-a210-08d7f9e98136
X-MS-TrafficTypeDiagnostic: MW2NAM10HT074:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1M4pRaxye3AXlEzX16Db8QrpTcXKFO1riLHTym8IFZHyPgBzaydGp8T5KZEYFzrxb5qHUJKkmmc4VPagG4Vk22TVZvQbYBdXcLpuWhTNtb6zDMd2KUERv173qOlUm5JNgzb1Amwirl1qDj2IzcdJcexdIaCN9Vs/KguDe4KHQeO6brdJCNBv7MMynDhBN6IKTsvXloYm6OlPTe3yBiIDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB0663.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: rRWotvU7sry4FIN4FEkqDRx7kO0AS25ADvQSW32YthG8+go07j8WW1PzVYcQdN7uO+7G6vl3L577zfPUP22AM6SGbbL7F1pverr/TVj8yhunyz+CkTIkvAl9tPG/XYTY7PjnHBDiy5wiWhsmIM0JOlGYvZBFgsVrryKKutA7btm/35tSSrlN2h8imcpyvwLNYjWmeMrm/uwI+cECK2u4yA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25348896-0683-4dd6-a210-08d7f9e98136
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 22:35:59.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM10HT074
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ONLINE prop should be when the charger is present (ie able to
charge), however, it was for when it was actually charging or not.
Instead, add the STATUS prop to show whether charging is actually
going on or not.

The magic numbers have been ported from a downstream kernel for the
SGH-T959V.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max8998_charger.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 9a926c7c0f22..c26023b19f26 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -23,6 +23,7 @@ struct max8998_battery_data {
 static enum power_supply_property max8998_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT, /* the presence of battery */
 	POWER_SUPPLY_PROP_ONLINE, /* charger is active or not */
+	POWER_SUPPLY_PROP_STATUS, /* charger is charging/discharging/full */
 };
 
 /* Note that the charger control is done by a current regulator "CHARGER" */
@@ -49,10 +50,28 @@ static int max8998_battery_get_property(struct power_supply *psy,
 		ret = max8998_read_reg(i2c, MAX8998_REG_STATUS2, &reg);
 		if (ret)
 			return ret;
-		if (reg & (1 << 3))
-			val->intval = 0;
-		else
+
+		if (reg & (1 << 5))
 			val->intval = 1;
+		else
+			val->intval = 0;
+
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = max8998_read_reg(i2c, MAX8998_REG_STATUS2, &reg);
+		if (ret)
+			return ret;
+
+		if (!(reg & (1 << 5))) {
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else {
+			if (reg & (1 << 6))
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else if (reg & (1 << 3))
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

