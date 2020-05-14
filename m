Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6261D416C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgENXFN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:13 -0400
Received: from mail-mw2nam12olkn2088.outbound.protection.outlook.com ([40.92.23.88]:20065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729057AbgENXFM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcfxD/lOGLTaRbGcyTw1aITMBWJyl8WT2b/aGvtv5QnCjfBdNPMTtUzk4Ilb3Fhcj2/j+lpLnKGLdpmtXFO8XdRueUxog2pRMNf1P9CgScUq1CIWBnX79xY+oCzlWrWHTWxW6FeqclwQbZRt3+h7oUJTjTd+Hj5iioED8QPTyECJi3X7Pq4pgOunqorMBoVVgcLKxk9lKxc/qPau0Cs9XWY8TUeJrak9r8XBGVXYtESEm+oD5oTXY/1LDJ0rTUkZaB8zxTVvm1lx4oEU4amqvkwSLzecRr2AgUge9tdIUrvyQAs92dqCcJivbqmO1cth06yDknJc6UkTnQtKeoLubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OffufdBNdxoO5LBkJSaKGrBgbpE2ZCwE5ssP6HjtlE=;
 b=j2kCWhy65eKP2vPJ1/8fcUP260p2FUw/58y0VE/VUmPDxojH3yB8rxVRlPdQMpA61X7TzBp8+vSdPT+H19pZQFBNBNolse8YavXVQ+xNj1aws0EC29K5uAnC3J0Lx2kOSC0+H1c4VboRgxAHnebLm3USka8PNaErKMD+raccHRHJcT6aewE1c3xNlh9dkDPwfhyjvT+kWaBLNKgzF5kGTlliaAlH85JA+nxIla2o+RKc9KPsWbbi65dIv9pHwVu8cs4SUJbNE3Sv2EC3SvjDt25hq5oYQ50ql5Ovd2E3ueWFTyrykD47mIGiqWBmMrGrL1fcAZ3MzH7jjXGpSkO7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::4d) by
 MW2NAM12HT035.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::113)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:10 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:10 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E8855A4EEBA158DCE1388606AFE8029E026DBD8F77496260270EF58ACF993A0A;UpperCasedChecksum:078FA253B621B01367A20960D3B92B4EFCD542541F80AC619F2BA83EAE804E2C;SizeAsReceived:7958;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:10 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 04/10] power: supply: charger-manager: Correct usage of CHARGE_NOW/FULL
Date:   Thu, 14 May 2020 16:04:29 -0700
Message-ID: <BN6PR04MB066021611208E93AD01DB6ADA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:09 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-5-xc-racer2@live.ca>
X-TMN:  [eynva0AuKMosR+KJZSVdTMPwqJEOBoLjVwGN3J8i66dDb+qFmSKFJ9xK5nCSIx7J]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2ea06532-6b08-4e0a-f8d2-08d7f85b4074
X-MS-TrafficTypeDiagnostic: MW2NAM12HT035:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MmEi1S8UgvawJHsBXbVTQBuQzF8bNaM2TkYmUnci8DVAiTsEhZmvskTkATC/us2B74Q/iXKkP6Ogx45EHpK9145KGEpnGXVDhyXhfXv0pLgJxt2ECZhv6+Hb9+CpBn4yuoWnimkJ7ApAUhPbzURvjCzrO5rlesucA9ACq/18krnG+nrnm2QNIqMWpZALdbPG47P3aiJmhgE6ZTc8TguSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: r5r3NRGMvAL0HX/31WoCDl31CiGM7WiIiKNuz0rHPO69vddRAoZb89NLGvmCfNLvU50lBUzDZCxEhaqj2HPq/T4e3oGQoHFZ7luJUTcMxgVmimhNA55UWGkdvHB6GTDHJAtf7yi8GDOXH75LYJQK0i1GU9VHx0mEKYOKib1FUnKaPaM6lDEbkEScgmTSe24OGZTTs08i93U7E6duCyfLKQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea06532-6b08-4e0a-f8d2-08d7f85b4074
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:10.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT035
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

The POWER_SUPPLY_CHARGE_NOW/FULL property reflects battery's charges
in uAh unit, but charger-manager has been used it wrongly as a
status field.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 40 ++++++++------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6a5ae1d0ef92..80d1699c938a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -846,35 +846,13 @@ static int charger_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		if (is_full_charged(cm))
-			val->intval = 1;
-		else
-			val->intval = 0;
-		ret = 0;
-		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		if (is_charging(cm)) {
-			fuel_gauge = power_supply_get_by_name(
-					cm->desc->psy_fuel_gauge);
-			if (!fuel_gauge) {
-				ret = -ENODEV;
-				break;
-			}
-
-			ret = power_supply_get_property(fuel_gauge,
-						POWER_SUPPLY_PROP_CHARGE_NOW,
-						val);
-			if (ret) {
-				val->intval = 1;
-				ret = 0;
-			} else {
-				/* If CHARGE_NOW is supplied, use it */
-				val->intval = (val->intval > 0) ?
-						val->intval : 1;
-			}
-		} else {
-			val->intval = 0;
+		fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
+		if (!fuel_gauge) {
+			ret = -ENODEV;
+			break;
 		}
+		ret = power_supply_get_property(fuel_gauge, psp, val);
 		break;
 	default:
 		return -EINVAL;
@@ -893,9 +871,9 @@ static enum power_supply_property default_charger_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
 	/*
 	 * Optional properties are:
+	 * POWER_SUPPLY_PROP_CHARGE_FULL,
 	 * POWER_SUPPLY_PROP_CHARGE_NOW,
 	 * POWER_SUPPLY_PROP_CURRENT_NOW,
 	 * POWER_SUPPLY_PROP_TEMP,
@@ -1583,6 +1561,12 @@ static int charger_manager_probe(struct platform_device *pdev)
 			desc->psy_fuel_gauge);
 		return -ENODEV;
 	}
+	if (!power_supply_get_property(fuel_gauge,
+					POWER_SUPPLY_PROP_CHARGE_FULL, &val)) {
+		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
+				POWER_SUPPLY_PROP_CHARGE_FULL;
+		cm->charger_psy_desc.num_properties++;
+	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
 		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
-- 
2.20.1

