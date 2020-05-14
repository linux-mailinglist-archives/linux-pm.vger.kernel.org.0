Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504981D4173
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgENXFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:20 -0400
Received: from mail-mw2nam12olkn2037.outbound.protection.outlook.com ([40.92.23.37]:4257
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729097AbgENXFR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4MpOj4au/avLdApsNguau3ugkyL6Mlye71dySCybN5CcM7di9jv6YWthIe/uJ24IvqJOJYFVq4MHPnJwavQgMwXyaD9tLt4SeG87Q0bbppm1k3W+OPLAzu6ni56yJAi/HRsWN7rX4HhR559Cb9ZhRn8YYOBU+WM3oY28kBpMvWPWGtA2W5K0sKhoVtVSu/oyfwMn2KtYUp6IYHp2k95p5Z9YIbNSzftwtElwRHVcCsbBlT7DO2jcLVZ+L2cNVbvuSDDbxFCdWCYMGY50kYUN6JBD9b0XJekSrTQJkdtO4Zsu0605AA8u/AdojBEvdZgWDgTiIqnmLWLvLu/F++UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45eF6F9wzmrdPsALF3gGVxx5rQQ0x4YDjUHCdPPTock=;
 b=FIHt9haHy6aPwoL/cMXDcw2r4UkFDXivGzO8BodjERohUMR9Snp2dAePpqjuopM6ECUZwwSo/hR975EJ0wwjunyiwR908HpKsDxE7hEzOjdsm6MGYwdQ1WsyexX54RB3ewh5s7XJPKO4FkHmS21Zt2vmN9hnPypdYls3NcqUT5Z/Z9K9gF5ADBZmeIW2mAGI0aV7b+TxALyeafAtH66FN6YbAOtmD7Ug0u2Z+dcbRhQWcyRDD5NLxr7QCmBhZ/ADoo/kn7wff7dfva9zOc108FWC5d0AxMgxvhAXtNCG5t+Xrst/D8K8A3yXAZm1Hb3pthlJRD1IE1mZOvTxDAIrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::4b) by
 MW2NAM12HT059.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::127)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:16 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:59C9CA188537F6D8ACB66AA95174C9996E8EC3B61AF5541208BCF15FD54490A6;UpperCasedChecksum:3A0E72812C5B62A88117DAA944A2C93A79071114E0CC5730143DC55CAA5C8860;SizeAsReceived:7953;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:16 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 07/10] power: supply: charger-manager: Don't start charging in cable nofitication
Date:   Thu, 14 May 2020 16:04:32 -0700
Message-ID: <BN6PR04MB06607D3D078B9B42E56D396DA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514230435.11798-1-xc-racer2@live.ca>
References: <20200514230435.11798-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-8-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:14 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-8-xc-racer2@live.ca>
X-TMN:  [aNGJO5wpZ50jdg5D+islHvQLmbJJGmWldJiA9HVPAayVA/DH3rynnFz9hUR9HbLo]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1473ed6f-4026-4dd1-4529-08d7f85b43a5
X-MS-TrafficTypeDiagnostic: MW2NAM12HT059:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWi6i5AovQqQtbxC7fpKBzF8VcHW/WZl++i3bc2BDETI+ZXxvVOQ4nrynnntAJiS8ze3JnuaEmhOG4hsp9FhvMWzkxWm2jxd/kraG+f06NkhSHotEW7oVIguth9i6J96fZTcbuVaFVUDDErwOCsAS9hhjACNtbLVQbZ0gak318+gOEyHJZg85zCNoExQSPJD77EhXw5BQboaI335/dTEzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: NyTR2HioZWucfyXU/6P6Gp3E23roTCaDZJ7s0hzWWivoeUsRTrgvNxGxSnalwsol1K9+xpEH0aZxtLE/84AojOL+YaKD3ZJxWFifwY54xvDNVWsNUqlDt/EfkpaQqzPUcY0TIhfRv9zdNVurQXcHZtk8I3pcnIG9Nd5U5N59HiNEkC/TJA6Igip8YxGRI+EeeUPKhbqMH+slJBjnxmwiqQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1473ed6f-4026-4dd1-4529-08d7f85b43a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:16.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT059
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonghwa Lee <jonghwa3.lee@samsung.com>

Prevents direct charging control in cable notification and only set the
input current limit according to cable type.  Leave the enabling of
charing to cm_monitor() where charging management proceeds.  We may lose
a few ms to enable charging compared to before, but it's more important
that charging is enabled always in safe context.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/charger-manager.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 9e4a7d368b08..27064a46a365 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -907,7 +907,8 @@ static void charger_extcon_work(struct work_struct *work)
 			cable->min_uA, cable->max_uA);
 	}
 
-	try_charger_enable(cable->cm, cable->attached);
+	cancel_delayed_work(&cm_monitor_work);
+	queue_delayed_work(cm_wq, &cm_monitor_work, 0);
 }
 
 /**
@@ -930,15 +931,6 @@ static int charger_extcon_notifier(struct notifier_block *self,
 	 */
 	cable->attached = event;
 
-	/*
-	 * Setup monitoring to check battery state
-	 * when charger cable is attached.
-	 */
-	if (cable->attached && is_polling_required(cable->cm)) {
-		cancel_work_sync(&setup_polling);
-		schedule_work(&setup_polling);
-	}
-
 	/*
 	 * Setup work for controlling charger(regulator)
 	 * according to charger cable.
-- 
2.20.1

