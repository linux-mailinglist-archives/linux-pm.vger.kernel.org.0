Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBE199A6E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgCaP4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 11:56:04 -0400
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:62883
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbgCaP4E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Mar 2020 11:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3FSqN9uQF/U63iCALqJeff91O4864L2c2i5gfLOw2HoD55NnILqMq5TCOl8mr155dbQz7H1pSfBgfPb3r1lwxflpkQJ8mB9AnXXLB8+nKXm96Z3QebodxLFv9jpto3BuOP2tBA8khJ+VNz+IDKnIyMbUtA5QqXxGoHJpkZ/t4yYfONPLp9llIUEN+bHuP3OpLTYP6u8oIkzDY2Y3Nyk40MaIvLGut2HNpyxKqyylQVPl2E8IC/VejfzCfE/2uQmXwA5FFkBuxWC4lc20/4QKKasig2JF3VCMdHkMA+xXQLE0a4AtSdkrkNwvCMd5ifM8nEufcM29ROtkNOGz5b0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtqx90ti8mvhcYFyuE/P7k0efM5dXkZmEu35f9mZt5k=;
 b=VOuPiWpJaiYK4C4BxcNN2TyV7ZkTXnDlZ/X/w0TUMvnNeboYZw0Dqkjrreh0UShc+GvPrfFym70njrG8FU3bPPt1x8xIfqj+3eQ8ihO9DbFdaJuXDSUVLZE0eOF6FJeXR0OSM/g2VfzoBKIjBEcvuMOChTbAMQZarxSW6250kpTsHp+AfzCemVTpmCo9eN4578c0ctBa5bxUQ5aZ4yy50AOE1klMgGf8lpoFcIdSYvrnRnSmCN/fLWRDQPjdX25e938xVax+UcwtGd8QZ5A7xC5L/qA9JK3z57Meo5ZJqlpiCXxnBkVpIZTnDmUpFj382Q+MrNj47VL7Yh2oXdDt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtqx90ti8mvhcYFyuE/P7k0efM5dXkZmEu35f9mZt5k=;
 b=ff3OArKV2vxwABCYe4/xDjKpLF6Z3r93JjnUIo4oOKgObqYGla5ozgl7DPLpYzdhdQFyJdSbw3waAea9/jflaY451rZWNtXf5bhOOhpCovEhQiq+RRiFrBM/gJc6s7bCl5JN4TmlaVKmo4oC6Zqe+XOrdAtWEs515uVoRu3yb2o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
 by BN8PR21MB1362.namprd21.prod.outlook.com (2603:10b6:408:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5; Tue, 31 Mar
 2020 15:56:00 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b5da:34dd:f205:560b]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b5da:34dd:f205:560b%5]) with mapi id 15.20.2878.013; Tue, 31 Mar 2020
 15:56:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com
Subject: [PATCH] PM: hibernate: Propagate the return value of hibernation_restore()
Date:   Tue, 31 Mar 2020 08:55:25 -0700
Message-Id: <1585670125-45987-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR21CA0072.namprd21.prod.outlook.com
 (2603:10b6:300:db::34) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR21CA0072.namprd21.prod.outlook.com (2603:10b6:300:db::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2 via Frontend Transport; Tue, 31 Mar 2020 15:55:59 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27619fe2-7030-47ea-37a5-08d7d58c01ba
X-MS-TrafficTypeDiagnostic: BN8PR21MB1362:|BN8PR21MB1362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1362DCB3067F7B7448A5B4E4BFC80@BN8PR21MB1362.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1139.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(86362001)(8676002)(36756003)(316002)(5660300002)(8936002)(66476007)(66556008)(66946007)(52116002)(81166006)(81156014)(6512007)(6486002)(6506007)(4744005)(3450700001)(2906002)(2616005)(956004)(26005)(10290500003)(82960400001)(82950400001)(478600001)(6666004)(186003)(16526019);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjPofr/Y5fgazFLkv3ShcQzuUoIc1tzdPeMSLOGySDkvGREjBR3dRrD7A3LqQFNEZbQ4iLL5fVJCZWfkzQqkt9vdhW1IMtWxb/a1VLiX9l645yls5lUx47I3DzX6vHxen58zsfWSQPtE3AzMfSHLsNAtD0a1OrP5GFZ1dCJnTTvH3eWF3Tpr01waNPpLz2uni3xDMtqKUQQW9uhVDfy2LBD3DaO2Iqk4OjQtotWeO7p/lggub11yurvD0to+pKLmg5o+DvwHVirjsHiKvaBUKrdzek/LjWyaMmg+D4231iTzKAXn6+KkyVL0edNLR0xHu+6m1CU0bygfygU8BLYwPkUsrxu6J5x33wasV6QK/2OR/WFaatJ/R25wpiMziRrBhgyOo75ucENULMQND3pSwgro1vOFVihKDFgj7yxgAw1OL+hEqFtTxC3P45micWX5
X-MS-Exchange-AntiSpam-MessageData: oaKYCAgBPsI2NoQBELAXvgyg2K4kuNhzuLbrwB38lYU1NMrla71oMJy8iTsJP1AA9Io/EofDUT5j38edz9Pfq9q827IkwELzmhFtWhtjrXCs4PO3dnLcDnMPWGxwLZlQYkdJfwgxpqz5sR5PnEiWnA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27619fe2-7030-47ea-37a5-08d7d58c01ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 15:56:00.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lprDkxnGM53Z4ymmY5D0otvKBGcxyYmIvEur7M9NxcMBcNhtP11FHOsfG0Wykfa8i++sXGrtkzdWk59y9z82VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1362
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If hibernation_restore() fails, the 'error' should not be zero.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 6dbeedb..86aba87 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -678,7 +678,7 @@ static int load_image_and_restore(void)
 	error = swsusp_read(&flags);
 	swsusp_close(FMODE_READ);
 	if (!error)
-		hibernation_restore(flags & SF_PLATFORM_MODE);
+		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
 	pr_err("Failed to load image, recovering.\n");
 	swsusp_free();
-- 
1.8.3.1

