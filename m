Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468811D417C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgENXF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:26 -0400
Received: from mail-bn8nam12olkn2108.outbound.protection.outlook.com ([40.92.21.108]:52132
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729164AbgENXFY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzXng47NL8FcgWy1gQ9W7tlLb3tw/GA9M48/LyWy6VGTt/xv16NIagwvxz3UF/K18avxwezAYlRHNO6TvmIEBwrq2iT0rlsnLo3pRCQAfYBixnf0rGDnsQ5A4vytKoZf0JoiUsSYQjwR5Za6F1MsmnTXoNFe+nFcoGKrXI4PdVLwQe6w5ULB0wSYduZgoD8GZB+vlwhBeo2dmDh/3843ujcKZEpOM8DLowEpPZLMkXSRiEqNUtbt1Kn1PqkKxtvJ82kEAkpFcYvArwL/xzQW1U718h0euoS7c2jNXHvg9WevnjpBCVNBFoViu93shkzqJEL6GxOQVncnXzi8C2CcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe8FbzbVdPyeGBc4pRx8iEkk18QIkWBbq67esAEoc/U=;
 b=fHFSnkBDByckvhL9LeCRU2pxEb61ffTNjPbUbvq6gAomLFEMV5WYtGPOFkBuatqoyIY+G3qfarluH3yT1wSouIwP7p+K9CtZLWZKpVIYDvXFIiHmqirqQcYh8nkFVP6ynb7FD5RsSpqdYacnS60byTD3e8zN5SCZyQdBKqpuMxE4QezHyhGWX73n78cKHAVONQuLykJWS2V0gvQaAW/dxRtNyZhlfEHdVuAekeG4fsIPEmJWxh/nmomoE8YiDNU9U82qxTZoC5tsquB6f9qtxThtIKuizFbvq1IIe30yylAwtWGU5NLikbQLePLI1bfhZGU3KDm8RavKPiuX38C+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::44) by
 MW2NAM12HT209.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::472)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Thu, 14 May
 2020 23:05:21 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8FE46E5D22477DA16827A93781B410B0D8719A47343C2F81C8D0CD8B7CC14DCE;UpperCasedChecksum:DE063B2EF7B2E3193A6A4BF53F51B43C4F701699C70C528B78C3F7B85453DA6E;SizeAsReceived:7862;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:21 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 10/10] dt-bindings: power: supply: Cleanup charger-manager bindings
Date:   Thu, 14 May 2020 16:04:35 -0700
Message-ID: <BN6PR04MB0660E57423994D19C84370A3A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-11-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:19 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-11-xc-racer2@live.ca>
X-TMN:  [MWEiQQrJbor6Eb/d0JZR+Ax6cMEWlvDwFRLGKClVWSx7rfMDU/Cel/S3miHFtqaz]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 58a531cf-2e75-4aba-7847-08d7f85b46bd
X-MS-TrafficTypeDiagnostic: MW2NAM12HT209:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jhOcp/k0IL0FyU8mDfcfHrTPPl3dPoIJYAQ5VkiRpV3OC2VH1D6O0woOX52ZYBcLOTAmgPpMZy24Y+gyfq7U6t+p2eJAyLw5Pc9zX86mE2pw/5FuFYcNVaPpMn5QjPrvZdhv0kb/9w+LTXQFtxPBOjeQbXjvrUTpZMYAGpDPOHIhQX9TEPxI6nQdoZCTj1ji8OSESUt9BysMA1LYCJs5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: gk7JFDJ7j+wwMIWEXjrZr+7d9Lf32O521nshvEFRBDrIt+D2ZM0BIqjRDw53VUAUG1DmnDqq3no/S6pYoQUxkEGaXDDZ595vYHPVhEkS4dfusxCS7zXYNV/SnWTyN8eqGk80MZ0K1zrmnmTXjcN4LLugE+mMvcs81NpMOygs1B8Q83XXG321rGdIuYZr/YjVaM1XE96Wfq3GkeD0wSGfyA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a531cf-2e75-4aba-7847-08d7f85b46bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:21.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT209
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bindings for charger-manager were very unclear and didn't
specify allowable values in many cases.  Clean these up to show
what each value does and make sure all properties are documented
here rather than using wildcards.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../bindings/power/supply/charger-manager.txt | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
index ec4fe9de3137..b5ae9061b7a0 100644
--- a/Documentation/devicetree/bindings/power/supply/charger-manager.txt
+++ b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
@@ -3,24 +3,32 @@ charger-manager bindings
 
 Required properties :
  - compatible : "charger-manager"
- - <>-supply : for regulator consumer
- - cm-num-chargers : number of chargers
+ - <>-supply : for regulator consumer, named according to cm-regulator-name
  - cm-chargers : name of chargers
  - cm-fuel-gauge : name of battery fuel gauge
  - subnode <regulator> :
 	- cm-regulator-name : name of charger regulator
 	- subnode <cable> :
-		- cm-cable-name : name of charger cable
+		- cm-cable-name : name of charger cable - one of USB, USB-HOST,
+			SDP, DCP, CDP, ACA, FAST-CHARGER, SLOW-CHARGER, WPT,
+			PD, DOCK, JIG, or MECHANICAL
 		- cm-cable-extcon : name of extcon dev
 (optional)	- cm-cable-min : minimum current of cable
 (optional)	- cm-cable-max : maximum current of cable
 
 Optional properties :
  - cm-name : charger manager's name (default : "battery")
- - cm-poll-mode : polling mode (enum polling_modes)
- - cm-poll-interval : polling interval
- - cm-battery-stat : battery status (enum data_source)
- - cm-fullbatt-* : data for full battery checking
+ - cm-poll-mode : polling mode - 0 for disabled, 1 for always, 2 for when
+	external power is connected, or 3 for when charging.  If not present,
+	then polling is disabled
+ - cm-poll-interval : polling interval (in ms)
+ - cm-battery-stat : battery status - 0 for battery always present, 1 for no
+	battery, 2 to check presence via fuel gauge, or 3 to check presence
+	via charger
+ - cm-fullbatt-vchkdrop-volt : voltage drop (in uV) before restarting charging
+ - cm-fullbatt-voltage : voltage (in uV) of full battery
+ - cm-fullbatt-soc : state of charge to consider as full battery
+ - cm-fullbatt-capacity : capcity (in uAh) to consider as full battery
  - cm-thermal-zone : name of external thermometer's thermal zone
  - cm-battery-* : threshold battery temperature for charging
 	-cold : critical cold temperature of battery for charging
@@ -29,6 +37,10 @@ Optional properties :
 	-temp-diff : temperature difference to allow recharging
  - cm-dis/charging-max = limits of charging duration
 
+Deprecated properties:
+ - cm-num-chargers
+ - cm-fullbatt-vchkdrop-ms
+
 Example :
 	charger-manager@0 {
 		compatible = "charger-manager";
@@ -39,13 +51,11 @@ Example :
 		cm-poll-mode = <1>;
 		cm-poll-interval = <30000>;
 
-		cm-fullbatt-vchkdrop-ms = <30000>;
 		cm-fullbatt-vchkdrop-volt = <150000>;
 		cm-fullbatt-soc = <100>;
 
 		cm-battery-stat = <3>;
 
-		cm-num-chargers = <3>;
 		cm-chargers = "charger0", "charger1", "charger2";
 
 		cm-fuel-gauge = "fuelgauge0";
@@ -71,7 +81,7 @@ Example :
 				cm-cable-max = <500000>;
 			};
 			cable@1 {
-				cm-cable-name = "TA";
+				cm-cable-name = "SDP";
 				cm-cable-extcon = "extcon-dev.0";
 				cm-cable-min = <650000>;
 				cm-cable-max = <675000>;
-- 
2.20.1

