Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A621D416A
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgENXFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:11 -0400
Received: from mail-mw2nam12olkn2106.outbound.protection.outlook.com ([40.92.23.106]:25648
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbgENXFK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLVLYC9nvW8X8/JMbhT6M1UnikqLvDY6Lb/fR474DHDEffIdrZa/J/tuQXIKvnABI328ZuxtDryUGqMUJDzmGr55rNNQX7AUTgZns3L0ngdgFOYTbblUl9+0u1Bp7pzobOUQOVyb1anO1EDUxKuciSoD2p8fsZ2xGc6gAsIlw3u/6RiA2rFnaVllrf/k64+rfO5e5s2emAz7fKNReI8Nm2CcHEbblszv9LYsy7+64l3gWjtIPD0cFMR+1I2jqkHX9Ljoe5uLkFB2ZQEd5s7mKgXG+Xfpd94vxVZrgx4LDDxICo8SySrke35mHqS+0PJcosjgUAJ41w2WFOHUiC59qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLomBpgXv/TDUtX34CbzmZ3HlSD3S1fzXXzPwtYsxso=;
 b=HOFuGOVDECtZtLX5cAAnj314JCyAfo3a78mNEYlti1u6uNonMjqlxRAzKFsXqSH0MfgpJ4DfwZ/ua5AHxuHT+1jiIOpcadCc7QHLzvyf3KOcriCp3skyGFoaKeW76bpzBkT1vD4sGvOuG8L608wQoKy7iZuSNfSIxV5hKaDmFBDnNIp4sN4zlTkKUscd3OqkImIsbYeJzk0M+CXkidmqx7dUyRsEy1KZ2gnzRyFvTLfoc0rOwW+AEXIexh3Rba6U3iRfdh4woGftWDLH7YDXR3/5b5Aut5I8XTrzJKengJlG4dMIQ3fuMcf8eeaAuOheGS/bVmsgrU4nZkxeGq70ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::40) by
 MW2NAM12HT204.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::250)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:09 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:09 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:64CBFC3109C95C9FCBD57A6799AA931C810E773B695283F3A3641466A59781AC;UpperCasedChecksum:17975E63A85A75CD90A3DDC234C1FBC63FC781E611BF75CB3B850DE16DE0F16E;SizeAsReceived:7865;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:08 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 03/10] power: supply: charger-manager: Always use POWER_SUPPLY_PROP_TEMP
Date:   Thu, 14 May 2020 16:04:28 -0700
Message-ID: <BN6PR04MB06600CBDDBE7C28E49B4A88AA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:07 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-4-xc-racer2@live.ca>
X-TMN:  [yDx9y3RCGQmBAsPKlcjBN6IkC4h43GEhmkQKsM/wuvmI7hcTOrSOrrQj5QjGHG5+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d49610f8-b4d8-4617-06bc-08d7f85b3f5c
X-MS-TrafficTypeDiagnostic: MW2NAM12HT204:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2A6/MF1kAHsYuwQs/+VUj94zUE9CLuXQTeyuocBo6UCsYw0GxPcKq9ELw4y+HD0w44xUc6YnjPE5X0P9tO63J1sHhtCWC+BwXcEqYAWB89yHpMtlTDMvvuYFPWpn0tXL7xfemoClYIJDMi2QjlIEnrPTHt3wPsD5qWARa9Rh+3SotU9/z4RcREmVfbMwxi1+cRmVDIoP9IZANED/NOb4hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: aJ1pJZ5qNMvJfvKEVhwsdzUUBrdMYSPBGK1DWKQBi5IuyHgueMALySGQ3I32i2hJDnXrw7dIkqAXHRWx2SsWXrLgxPP/fPpdKRcJd2X5f2YB1yUD2Jeow+gQElc8MxonZ7jGDWSdC6Cafcea8fZtqbQpM6rO10TgnWls79b2jxLaA/kQmTQ2nn2pElHDRxvTiJr9MbIVWlokQrgvbcCw8A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49610f8-b4d8-4617-06bc-08d7f85b3f5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:08.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT204
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We were using POWER_SUPPLY_PROP_TEMP if the temperature was coming
via the fuel gauge and POWER_SUPPLY_PROP_TEMP_AMBIENT if it was
coming via the thermal framework.  Since they're mutually
exclusive in the driver and we don't know if the thermal framework
 is ambient or not, unify them both to use POWER_SUPPLY_PROP_TEMP.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 413f291fda5f..6a5ae1d0ef92 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -791,7 +791,6 @@ static int charger_get_property(struct power_supply *psy,
 				POWER_SUPPLY_PROP_CURRENT_NOW, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		return cm_get_battery_temperature(cm, &val->intval);
 	case POWER_SUPPLY_PROP_CAPACITY:
 		if (!is_batt_present(cm)) {
@@ -899,8 +898,7 @@ static enum power_supply_property default_charger_props[] = {
 	 * Optional properties are:
 	 * POWER_SUPPLY_PROP_CHARGE_NOW,
 	 * POWER_SUPPLY_PROP_CURRENT_NOW,
-	 * POWER_SUPPLY_PROP_TEMP, and
-	 * POWER_SUPPLY_PROP_TEMP_AMBIENT,
+	 * POWER_SUPPLY_PROP_TEMP,
 	 */
 };
 
@@ -1298,7 +1296,7 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 
 		/* Use external thermometer */
 		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
-				POWER_SUPPLY_PROP_TEMP_AMBIENT;
+				POWER_SUPPLY_PROP_TEMP;
 		cm->charger_psy_desc.num_properties++;
 		cm->desc->measure_battery_temp = true;
 		ret = 0;
-- 
2.20.1

