Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9A1569B5
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgBIIji (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 03:39:38 -0500
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:38916
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgBIIjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Feb 2020 03:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abpWR4+4l/ocWzrxY+yYNFuktM+QVVEtnSOCf4JWXapojkXDmbZT7EUMrX2kyUA0MRp5+HsUdbyHG1Lv83haybckw5nmVcgja8jWHzogsX9PlCfHf/fHAcdvRKt8wfh2MlgtavcRlJIhQEaCJnksdgcYpb8/HKd26W9r01hxLqqzudEqVC4DhrjPkYNB3UsKHntDDdggQ2m9JOdhpeTxvEU+iywTIrwmPURB1WSO7tzmtC5VyNqBawuZ9TfrzeOhZUZGkv6EyqDSWGxflRChUaDZLFR2Y0XNuCBSVP3XtKD07OF7ddrMxH7YRdEWFzuA63vpykDaZaSzxW6JUlKokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fbckbzuiY7BtX7zdakPgi5nSMuE/BIXO5TlDJk9AIw=;
 b=VTNSDZ44sgH005tmjXH7wi8ufjbAugbiyC/oUMgiufsSOlB0KyiRaEigdsfow8SdJGNrRo4swv8flHzNgJj8MgRNJuPGykODU4U4DljYcyLX9I+SRpZc+eT/8VmTiC3eELmN6EtETBPJeFeslMEbhDNVF2Yczl83Jap2wHzlx24rCocMygASy/BgdtVXY/0NTVPz4hZwMVS0kAzUEqU0X9CRzuB1UUZ43UgmZ6BBh6bG0Xe9ZhFUXcJI5aMF26+Fi/CK2eJw9uYZhFWGnU9CVlG4EUXI2RqI3JPTsPD6E6F+jo5JgeTMpiJAfSY6aQTx79ww3VkiMxpBw6P6e6DBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fbckbzuiY7BtX7zdakPgi5nSMuE/BIXO5TlDJk9AIw=;
 b=RM/08qFIWYJdFemK0o1dCNwhK1k10BoEjG0KmV+CBusnhVTXouAmNHRRMllUYe9A6Qixm9HzKfNUfuUSQ87/mH24p/MR50klj61abQ44pVSZVj+tQPf5kXcFwrL/mombOfeYNjNyNVbSWgbjRzsv10Tmn1fmhzSqS3xng0aX0zs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5843.eurprd04.prod.outlook.com (20.178.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Sun, 9 Feb 2020 08:39:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 08:39:34 +0000
From:   peng.fan@nxp.com
To:     rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] PM: replace S_IRUGO with octal numbers
Date:   Sun,  9 Feb 2020 16:34:09 +0800
Message-Id: <1581237249-29608-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Sun, 9 Feb 2020 08:39:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18d47e3b-182b-460c-1cbb-08d7ad3b96d1
X-MS-TrafficTypeDiagnostic: AM0PR04MB5843:|AM0PR04MB5843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB58437D3D35FC2D6053541EF0881E0@AM0PR04MB5843.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 0308EE423E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(81156014)(52116002)(16526019)(2906002)(8676002)(81166006)(8936002)(4326008)(186003)(956004)(2616005)(26005)(478600001)(6666004)(69590400006)(6486002)(6506007)(66946007)(316002)(36756003)(86362001)(5660300002)(66556008)(6512007)(9686003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5843;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fe8nycmxqyhX7fY3b18ozPRw5E6yDoiV1nZ9subDi//I8BUiAEaXnBGnPWgPB44XfuET4KOtmp8CFVqCR4qBt15zQLIM+KUU6QA8FuF+4eXWXANkmlWSLakEb1+vltjX96h2K0v1W3zALVhRB/rYFAZ3/4ZTeYpndrzpGUGlB67ythw4fsm+1W2CMZLEeBRP+PTMSKYvx2i8vYagU3fSLl7gci0CvQM1TaTCsFJOIrx843rA5jNFF2IA5++3uqgq+//qSBvEvKMr/6UNBtEI8jHp7OU4kIMOmSNp48G+8p0s9VjY6VL8zIK96OW6J9nRPfzpp7TbcZ/D4pvJ9mWm4YrbnRp6U6+N3DlCwoJwmyoUhMB0dwCH4/al5JZsmVgMzsN2isF20kBR/GPHxktETzQ12xjX0nN007sITGzE4h7kJJdHoOTXDMQN9mETvOY/qfMsnFpMeg9nhbrEuMVLZfK2FI5zTH6foHe8x9IlSsED7Xj26MOj52hPHxmFKS6Y9sMi3fxch3Ab5ACN9boAXq6bQSUsMn3KgJQpRO4PQZc=
X-MS-Exchange-AntiSpam-MessageData: kgYNzVaE7PUQ0mbJCsFObsVB0x5rxH6m8oBriJL94MxnkxFOihKcBrVH9Ge0ZETcYF35saTg32/TlwLgfCdXc9izCm71pegmoGSqTpgAU6e2JEaSVsOGaYyfgjEzrco7Uo4bSVb69xAtqC1f9GctWg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d47e3b-182b-460c-1cbb-08d7ad3b96d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2020 08:39:34.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5CZkzCGOtmkf1uVh3pWa1v69Qj/bwbFOrx4WZ8n/n3pLX7exsgcaLHt6jf8xv8ZgmIAibbH3dTlI/aPh6DN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5843
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per commit f90774e1fd27 ("checkpatch: look for symbolic permissions
and suggest octal instead"), octal numbers is preferred, so replace
S_IRUGO with octal numbers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/domain.c | 2 +-
 drivers/base/power/wakeup.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 959d6d5eb000..0a2d0360c014 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3054,7 +3054,7 @@ static int __init genpd_debug_init(void)
 
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
-	debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
+	debugfs_create_file("pm_genpd_summary", 0444, genpd_debugfs_dir,
 			    NULL, &summary_fops);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 27f3e60608e5..7970797ad8f6 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1174,7 +1174,7 @@ static const struct file_operations wakeup_sources_stats_fops = {
 
 static int __init wakeup_sources_debugfs_init(void)
 {
-	debugfs_create_file("wakeup_sources", S_IRUGO, NULL, NULL,
+	debugfs_create_file("wakeup_sources", 0444, NULL, NULL,
 			    &wakeup_sources_stats_fops);
 	return 0;
 }
-- 
2.16.4

