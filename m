Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ADF1C497A
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 00:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgEDWNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 18:13:34 -0400
Received: from mail-bn8nam11olkn2023.outbound.protection.outlook.com ([40.92.20.23]:11744
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbgEDWNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 18:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7KJxVNphkxGpLTH/XU1bCG4MmBFuUo+YCk4WD51UrqPzVsxTAqCpbX0PVs4Sq4U6Kbc/bVDQIr16YkfyquhkhGnSQsYDgFDv8EP2Pi1TYUE0GoUDz23W3PWCE1waWFj6+jNbTaBMgT1cIJKgz8Da5/oJxsoQroiLJ9suD0MhaPOrKwQxkwegCUxutVcvNE5GIYLEdeEtkNfAM6+AhkTpKibOB7kjBnLEUWfYwM7KtozVRCz64TNwHxvaxGsH+DaR6Des+/ZcANJ6uWCr5vmmFGQe0YSkOBrpFkB5NHMmo2tlgRyavRds/WKIYR/dYpHJMVGgvzI0NfvVNVV3wyscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQlQFEkFCJP5s3LXh0PpwXlPhoi+wfKHEygXgJ+LySc=;
 b=Xs+Oikki7xASG13zGdQUJ7wcpDMsqcG9Qld02DL2AKrmQgZRVeEgK/jk1/vvLBAeM0mSLnI7W4QI27pUsuEbmmQUh1EMn2z+XrG1A7vReigb34ZW3Eyp8XUY9kqegWuMiRzlG6yDhC3MFdtjRDYXjeKY0naisOQchsIDSkgiKq1JfAIs74gXg/eOU248CwjLGKgOMY1rych+aPJlrSv+jygFW8w7OHqGfU89+yhf/gZQQ2k0PNfO4x8b/Y0kRgDsxD5L2zNdoQ02WFPGH8nNJ5eKpOoJTvKFu5KcyPWtYxkrYqReBWotcRxqESk/g9LtOJFWPrxS7N2bmsFSE4GpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::4b) by
 BN8NAM11HT173.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::385)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 22:13:30 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::4d) by BN8NAM11FT010.mail.protection.outlook.com
 (2a01:111:e400:fc4b::309) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 22:13:30 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E3D82FCFBB480C77A928FC454D34593C1A7BDC516AEAEC1E884C2FC111877AA0;UpperCasedChecksum:E0146A7F0D2AECC0D278F856D9BC41B9739485A62C1581A349D7FCB67CE2BF0A;SizeAsReceived:7786;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 22:13:30 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/3] dt-bindings: power: supply: Document maxim,rcomp-value for max17040
Date:   Mon,  4 May 2020 15:12:59 -0700
Message-ID: <BN6PR04MB0660F4D09451AE8F1DB284D3A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504221300.3153-1-xc-racer2@live.ca>
References: <20200504221300.3153-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200504221300.3153-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2201CA0053.namprd22.prod.outlook.com (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 22:13:29 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200504221300.3153-3-xc-racer2@live.ca>
X-TMN:  [WfGrgOUezFu0vC/W30ev1tWlInh3FoVZJ91iGfU0xFXxzpVcrC12z2QEsvNAYwPB]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: fc416014-dec5-43da-5c94-08d7f078603a
X-MS-TrafficTypeDiagnostic: BN8NAM11HT173:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/c+YeRTZ8DNcMHtecsCCrHyRiHs07igOUWEblDdQYqJ4Myrhe3lEOOk+NsNekfKlmyJTC0B44YxNAA/ivqzNnRsAhYg41rDp14HGaDvrCg3x2VqQlbL/mDg/TAhmbQePHDu7tpUz73d0q67E1g3KilQEN6IIZV21Y60xZgQChyuttp5PP66YrVPxhOg7iFI7SQbvkgJrn0guEx9LRsL7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 9GFcBm5oAq1K5MFL55SVtPcCgEx7WYTg1j4ni2/0jH0j2bHWhlTQywWofqn+XPNx/2J9ffc74S0ZDKTZiTlO+JCxufvWZoXAnhMDuleO8ifYcLTUXipAinCe+hvzXFP5BixLurBxsgq2UPKqV4dQmMGVG6sDTAWEyCBzQtop6B3JfvyWtQx4A6QH5FcsLPVBV1DaZhHDmVgiP9c6pW5Fug==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc416014-dec5-43da-5c94-08d7f078603a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 22:13:30.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT173
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The rcomp value is a device-specific value for configuration based
on specific chemistries.  There is no public documentation on how
to tune it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../devicetree/bindings/power/supply/max17040_battery.txt      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 4e0186b8380f..14097b3ed278 100644
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -11,6 +11,9 @@ Optional properties :
 				generated. Can be configured from 1 up to 32
 				(%). If skipped the power up default value of
 				4 (%) will be used.
+- maxim,rcomp-value :		The value for specific lithium chemistry.  If
+				not present, the default value of 0x97 will be
+				used.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
-- 
2.20.1

