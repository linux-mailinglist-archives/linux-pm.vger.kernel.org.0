Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0123B1D4170
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgENXFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:17 -0400
Received: from mail-bn8nam12olkn2054.outbound.protection.outlook.com ([40.92.21.54]:33120
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729089AbgENXFQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo5KZty/6gstHOjihVNK848jIxJMpRRl3Ka/k4iX6SPIog1/Z/ZEWpNNq+RwsO7ISLtTaM4f7ENMJOa14TJLhrL7Dk1vBUJto0Uj57kcUz510nh6ysNboGIykeuAXYbwugnomgXya+r7tkPQDjHrLUUd7vBeLQmCWsedOo7deOxCjmpAU2N355hWgpU5Q93gh+ZyCV88P+SdGLdrWtpB6y16pBK5r6VCgXLBi6v88NmLmgDvZ61SLYHsDD8ZRYk+sG9P2KqBEuby1kBpHHcp2/YnPqdA1vHCKgFDD510L0wjXKYiuThac98nhDoEjf7hnsQLX3fnVGlC54+iZRPvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ojXOnyhyTbuZiHTpPWJRaeNoPwnXBkbesBz+CUR+s=;
 b=aivYGt5FnOSnbbjYzSV3dag1LR4ViqfWh56OQ9I66pJi+VY4BFhWfnkRqRqus+YdO4MW4MeDXGRLF1TfOxdmeH4CzsvOKAIb72C7tEBl1bzLPNIBuZ+Jo5LmrLoSOz4ASowORAp7Q8dBh6nIJjHy9X7EJwvhjTmnm1NWwaAxG8VLMDYV22ut0ouYURi7uJvRTSqAXhguVNOb6xWIfqj6fIvq4ZVOCmZA7YXQgaWyjLnHIyKf376b2fuj1qP0StNQoTlZOIwL6jTPWdITQR5X2ahmxWjQSnZ8dwPIj7s6lKJyvZuHUdA0iIuIwq6pdPiZHkef5UYVY7loMVj6XpKmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::49) by
 MW2NAM12HT003.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::97)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:12 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:12 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:46D2674C3E3ACD975D3F292E58B620A0DFF44ACFE61B0D6D3E7BFFFBB5F1250C;UpperCasedChecksum:CC5D7174DD7BE7353E7D8A0DFDD4DF185588120DBCAF1662CB3119E7018BCC9C;SizeAsReceived:7952;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:12 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 05/10] power: supply: charger-manager:  Collect all power_supply_changed() calls
Date:   Thu, 14 May 2020 16:04:30 -0700
Message-ID: <BN6PR04MB0660E53EFF098B66C32D9ACBA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:11 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-6-xc-racer2@live.ca>
X-TMN:  [a2GnsS8BAg4aEnisxadQPAzfNz981r4B+n1d7Cac3tGaRxO8nVYlJAX2Ymkl2WGn]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d7e296ba-7962-4981-9451-08d7f85b4188
X-MS-TrafficTypeDiagnostic: MW2NAM12HT003:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA9ltyohT4tcbduNjZHwR0KrKwhx6KeUb1hbM28N7/I1KohAukyHmxXSmc+D99u6YS4Ar7WtkD0LJmv6zaXjSItai2gUjgKxNf4tF1Lb1HYqAwXpYb1Y3VMt5jfJJtpxL7UkI8lNcr+jF/mSMa0zMi8MNwnDeHeKjqCxKmznMoKQmT++flyITU5APhBtBgLdv3v/eKJOu+47SWxcITSh2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: KVTmawHR+GpGWX62638HNetTw/tjxWPAuiFavgD/1Sy3YVktgI3fivD7u4aQasC6vYPIcxJ0en33x2jpy+DIoeuQY6BE3ktfDmNBUvjSZKWN6jkBbMOpultHHDQZkSHudbpz9qd9gORqFVMJqYE6ZIJq5+UAQTgjT5hhTbKDflavXY8KlFMtpbOMqKv3dlTP8sRtEzeAJvE67tungfTtkg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e296ba-7962-4981-9451-08d7f85b4188
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:12.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT003
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

Current charger-manager calls power_supply_changed() whenever charging
status is changed. Remove the separated power_supply_changed() calls
and let it be called at end of try_charger_enable() function which
is called to set charging/discharging.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 80d1699c938a..b2daab480eb3 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -406,8 +406,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
-	if (!err)
+	if (!err) {
 		cm->charger_enabled = enable;
+		power_supply_changed(cm->charger_psy);
+	}
 
 	return err;
 }
@@ -460,10 +462,8 @@ static void fullbatt_vchk(struct charger_manager *cm)
 
 	dev_info(cm->dev, "VBATT dropped %duV after full-batt\n", diff);
 
-	if (diff > desc->fullbatt_vchkdrop_uV) {
+	if (diff > desc->fullbatt_vchkdrop_uV)
 		try_charger_restart(cm);
-		power_supply_changed(cm->charger_psy);
-	}
 }
 
 /**
@@ -493,7 +493,6 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			power_supply_changed(cm->charger_psy);
 			try_charger_enable(cm, false);
 			ret = true;
 		}
@@ -504,7 +503,6 @@ static int check_charging_duration(struct charger_manager *cm)
 				is_ext_pwr_online(cm)) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			power_supply_changed(cm->charger_psy);
 			try_charger_enable(cm, true);
 			ret = true;
 		}
@@ -613,8 +611,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	 */
 	if (temp_alrt) {
 		cm->emergency_stop = temp_alrt;
-		if (!try_charger_enable(cm, false))
-			power_supply_changed(cm->charger_psy);
+		try_charger_enable(cm, false);
 
 	/*
 	 * Check whole charging duration and discharging duration
@@ -639,16 +636,13 @@ static bool _cm_monitor(struct charger_manager *cm)
 	} else if (!cm->emergency_stop && is_full_charged(cm) &&
 			cm->charger_enabled) {
 		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		power_supply_changed(cm->charger_psy);
-
 		try_charger_enable(cm, false);
 
 		fullbatt_vchk(cm);
 	} else {
 		cm->emergency_stop = 0;
 		if (is_ext_pwr_online(cm)) {
-			if (!try_charger_enable(cm, true))
-				power_supply_changed(cm->charger_psy);
+			try_charger_enable(cm, true);
 		}
 	}
 
-- 
2.20.1

