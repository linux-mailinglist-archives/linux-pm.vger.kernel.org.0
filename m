Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823663020EA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 05:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbhAYEBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jan 2021 23:01:24 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:25953
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbhAYEBX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 Jan 2021 23:01:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anUVKc+l+xc47tyMbnzq+px6dTC4Ic+XtPlTzRIA467WmmM1uX5ovMBkFHcBx1rUaMeO1RK6qt8e8weOQ6lyF/Kmr+sVkqKwMsyqn+b7sivxDuyI/v4mnYuu5/EKCUjJAyDeODa5OjNSn2uy91ZY4Xv/OqUSIxjM0MtkzQ7bI2VJ1zwmm2aTvfxHx/PIB10VM3BIjJY4Fcky33pjB3xdIBSw3qCsBzy0VemEDVMet5mrmha5/r4h+6GUZzBBW1KcN+mt1bHvPoBA0y9PlZwriMFZNydVP2Z3mhFs09weK9MSjtaAXthy1+6gJj5a6TL8Asn8yfBaFmIf07Amq/JX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U/BssKee6HcJTFOcCCEicToZSOa1sxOE5onAosEvu0=;
 b=khSH9uo5CEhOWhsXSSRk/BJmK72dN4QmZzM9wWpjFlVg+tqNoY5HbJ+ALQji0eNHTKkpnRMXv5cea6qG95tJ6aJK+NmMxY0lYxelcABaQot9K/s1CTnuD2l+Otqv/CQ2rjdasiaJ+PehfV6QwLvVZvIT4KanY1Ek3yj+65RTZI0YOl2OVaLpJgm+t2F6Yoxp7xkAPHGbe6KM/GIYIrfgjidrToB7qHsHFL5MjKvmTt+NgkXfl4smVkWspD5nL6hmVoVgcvpTsU7Eho6j0XcMjyZ3LHtZphG+mBpKteviDm1ulc1zi78RSDuz1P4tuCOqR/ka51/S+FYil4Xasb9Y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U/BssKee6HcJTFOcCCEicToZSOa1sxOE5onAosEvu0=;
 b=L4yEtFQpnudALTvtPokJmIuayuUL7RD6mm6mxqiyxrhuQtlPv7+tpXuSBh1ArqKwsuXK7WPvxptiS0FqflqA5qpA6k2lQ7AK85Wc4f90bPNcS+QESeK1r9hL5koGVAt91wSnCOJhBVUZaLbmAokfY6e99cJumSuuhdwm2Rq5zcA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2903.namprd11.prod.outlook.com (2603:10b6:a03:89::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 25 Jan
 2021 04:00:35 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 04:00:35 +0000
From:   qiang.zhang@windriver.com
To:     rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: remove PF_WQ_WORKER mask
Date:   Mon, 25 Jan 2021 12:18:28 +0800
Message-Id: <20210125041828.20965-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core1-vm1.wrs.com (60.247.85.82) by HK2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:202::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Mon, 25 Jan 2021 04:00:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5f9002-1fdf-47bd-9bf7-08d8c0e5c466
X-MS-TrafficTypeDiagnostic: BYAPR11MB2903:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2903956B5EC255E0DCF866D9FFBD9@BYAPR11MB2903.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsfqepxE163/HTMusOBxpBDn2hmkioe+jQ89/G7PLixsYUGFDDoRxjsQ3ryWcAosFQZw58HqQFAEuwO8QiiR8rPsSfw1S3xOvSjqep6L37So+8OsopO04HNVASALXQH/slUOkGp7309VjPme7xjtweLztotqPUQR2U97N7SdJNdgpmb5mp6CJhFAhcOH3wuu59o7NBzVF5NbXNRnlwD3rF0sqtHFFWZEb0EQWjfqf4msWdTSve1iU9s2iKgmSj/ZBVTkCdaOs0sOG2WxYX+bWlmUD/Y7DBp1BcQvpHGkCf7K88VbiwR9A4qpO40mz5IkKcGru3XTwXhscRWN4O6pEBJ4M5pxbfgRgPgSS4cl5Qq2oYH2zDjHf5h270MFAwOchLDvHKRfpNpIvNvIdV8/Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(8676002)(52116002)(6506007)(2616005)(316002)(2906002)(66946007)(5660300002)(6486002)(478600001)(8936002)(36756003)(66556008)(66476007)(1076003)(4326008)(83380400001)(16526019)(26005)(6512007)(186003)(4744005)(6666004)(9686003)(956004)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ClploeYElMh2Ca1Tvf9DrFYiKp54BgoloUcUdSl3ApEUH2orRr4Pu674N7XW?=
 =?us-ascii?Q?dzGCTuxzV0RdlSpphULOPIxE+veGlpC8xq6Y0EsYBv7N+j2gPby/llnSLKmQ?=
 =?us-ascii?Q?lyOysnnkVv5YF9HB1hD+HXlLSTif/pbx7wtpTwRvbtZxFz4txwGpMnA8CuGu?=
 =?us-ascii?Q?5/KVo9T9vneVKdrogV7CtyND963nsKzN/etloTZpUx4jclRBF5XqHOdF33HW?=
 =?us-ascii?Q?4kzSDny0OINNc9Kxjn33J6hUeiIqHiK23Y+0/3fyVyZzuXDrPu8+/Xc80an9?=
 =?us-ascii?Q?OtC+xcjwQXYTd/awLXuefusE6skUmU68hX9h6fXKpiL8l0ZSvJM8Wc7AWavE?=
 =?us-ascii?Q?mfX8XlV08gp/eegvKJVpwfy2MK3N1679h6MYJD4y8r2Te3EFYO0oTp7qjK8U?=
 =?us-ascii?Q?6X24Tu01RMO1NvdVh99QbdH5bOSBNr6trEw5EdPsgBSjPsCiXXBciEM/0TmQ?=
 =?us-ascii?Q?ZHaTSdRoxkmbqubE0ca7c5bI4DlvkdRdcU4upGHIBQ0OABuo/3vA2PbLA2Qc?=
 =?us-ascii?Q?7cWpWQ2Q1w25yaAS1Uol/VkTWF1gGUkjoQ/bUwY/C4ZQc2eyWuf4Jax6emdu?=
 =?us-ascii?Q?AAqdeMzdg921lYOlwnjw2N9baxkGJn7EH31+neUa+27YBFiYWeb+8ivR0vX9?=
 =?us-ascii?Q?Cku6Fk1PIEw7zX8SlClzOhk9Nksh+52cyu9ciQRksoUhTD+iu7eaCYpJRrhm?=
 =?us-ascii?Q?1iPEaF4vwPtthE6PWnxCvSC1R74zyFTc3ddEIYZPVf+u9Xy0eiW6z1+3dSaY?=
 =?us-ascii?Q?18j1jhAh/wNHlwiVOVffI4vbR/qDhDwzgwBbJ9Th216K2CR1ZyWQbbioNTP9?=
 =?us-ascii?Q?eJwyMnI7yGQ7VpJ27hi1ZvrHl+/Aj8LCThTMP9jVgYV+xWlRBToo/tM18VPp?=
 =?us-ascii?Q?JBl1yS9jVmvOnSRVV3v/b1GELyLJjBwGbyuveZwxCtSm+bud/t1TV/u8ZR9W?=
 =?us-ascii?Q?9hCVlKWQUm3vI3u7tFudFBZwWNZbXq7fmmnSi1p5TjM=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f9002-1fdf-47bd-9bf7-08d8c0e5c466
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 04:00:35.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rn2a5tfaupMnODege+fb0bJjUh5J91udd8w5c0Fce2vL9JxXH2mLvyRD9oKm3FfFLUX8Vk00G0BhntaQeh0ccguU84lfZdtSzxV2WSXLYOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2903
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to kworker also is kernel thread, it's already included
PF_KTHREAD mask, so remove PF_WQ_WORKER mask.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/power/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 45b054b7b5ec..50cc63534486 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -235,7 +235,7 @@ void thaw_kernel_threads(void)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
-		if (p->flags & (PF_KTHREAD | PF_WQ_WORKER))
+		if (p->flags & PF_KTHREAD)
 			__thaw_task(p);
 	}
 	read_unlock(&tasklist_lock);
-- 
2.17.1

