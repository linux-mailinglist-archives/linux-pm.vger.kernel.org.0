Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C341D417D
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgENXF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:27 -0400
Received: from mail-dm6nam12olkn2018.outbound.protection.outlook.com ([40.92.22.18]:32128
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729145AbgENXFW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMKeYpli/g4HaT9v/UVXn11AlAzmxZeapvStl6V8lOwxuHjenUeGtSWmPPoLBfA558hlqV3Wiak0rbEHpWHN2k0l6e+UY3AyRQv5e9V9xOy+aWNQknaWRt1KPbsQaIfxxtxE+WJD3qIOQxoBGnPTag78zabKedc/77G+FyTPKRhOJjZQvHU5gopNjEcAQvw1Ll0okpgTsuVtWx6bnUjnW5+/EzuN4zErN6rBv0V4HHTrx3Y0cmoHvGhsUdzqNRvJUbaFsOJJhKNO21JothfDLyzK8JiZyUxHz4uJbnbebcj3yk6nIDK7wyJ/m1gG030UwUOqM5iP09FiXDsaIW0I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frjjLVPAF4ZuhXoCL/krqbQKU4CEv1ZHlJsmkJDyOAk=;
 b=kKfzxz8P1rXJRos3keXShy/VxanDUR1UUvtwOTVP4Cn1rAr40BeHrdktfOVA4aLGBwEUBXF8nT+3PLClJ1ku0V2qYjdoKzpBPvH89qLkHl/p3IGUDPA2MAaslfsSDYsh487s1QM/xJo+8/GN7npBxMpNOr6iHM9dSTFncHdYqqVJ22w7azqA3uboKS4IIu6WvuW1e45V4Ja4DGiVrwPBNimlR9hByIy7N4PmgAPqa4peFYoyZ5ZQIBHp31JLC3hS2Cg8f0UfO/8k+B98D7iVdDlZYLeTSQmRcHV05/TX01e7OPmJaShyxBCKPDFwi3MbIPt3dkqPsp5aC2YBC0Wdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::41) by
 MW2NAM12HT132.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::484)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Thu, 14 May
 2020 23:05:19 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:19 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:74862B13F85791B1DEA666493F20868B73C6CDBCF68E78AB8A00B9EAED5B6DC7;UpperCasedChecksum:00EE86BF9418EED3CF25276A5E25B1D90AA9C5C451A54C98D07631ABF8140D81;SizeAsReceived:7869;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:19 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 09/10] power: supply: charger-manager: Count cm-chargers property directly
Date:   Thu, 14 May 2020 16:04:34 -0700
Message-ID: <BN6PR04MB06607ABEE082DF0A20E102ACA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-10-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:17 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-10-xc-racer2@live.ca>
X-TMN:  [EpCpjepnmk2cjalAvX2YBosdIDPdzGZTlvQoEZxd5csTAj9x2S6pPEJtc8Ppjy9u]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ece23963-be24-4f3a-9782-08d7f85b45a5
X-MS-TrafficTypeDiagnostic: MW2NAM12HT132:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LYQwITxRiGsdQAQeQwKhOVcATtt6FfqJhh95tPGiyKITaMFb04krSNQERKHKtLJ9PRXNui69KEd2Ftrhdc83bwP3FDQJyNhCHP3jkriAWGuUl3FQ2KT4s43alM5+WEqp8A49Zs/H3PndiNKd7ibqt7mGPkmjt8kja+RirliWXlrD+ItsbB7CAk0+rQ/IeN2GxLPTFmjFaSuzVOCqKKd3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: ticopCGDOfT5aqgJnzaVJu9MdZIa1+ST7R79Red8Ufk/fzzemgWI246Gn9c2AARx6PNBhbGVyMcyU4NcuKMvaXrSts3CSq5jq8bOKNbml4qutB8Yb+Ay+4U5h/969HsWitg+l40zZ5Y9p426vlHTu77vPSrIxzPAqfasqlRZ1sMLTiajHfeZ63GAtDHemSrQYvhFan+m6HVCc5wBiTAVcg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece23963-be24-4f3a-9782-08d7f85b45a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:19.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT132
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rather than having a cm-chargers and a separate cm-num-chargers
property, simply count the entries in cm-chargers.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 4ad3dd754abf..f0ef8a10891c 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1311,8 +1311,8 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	desc->battery_present = battery_stat;
 
 	/* chargers */
-	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
-	if (num_chgs) {
+	num_chgs = of_property_count_strings(np, "cm-chargers");
+	if (num_chgs > 0) {
 		int i;
 
 		/* Allocate empty bin at the tail of array */
-- 
2.20.1

