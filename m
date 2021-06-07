Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2604C39D577
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGG7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 02:59:32 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:44876 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGG7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 02:59:31 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1576vWNW008277;
        Mon, 7 Jun 2021 06:57:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 390qcu0jsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVsItXfN4sy/3bPs29kGXDGDJCYYuMqPQ13riEM5hR3x/zs+eBFTnLHH5uTkL2PVGItO7m3gO4RU78szgBtN5Pj30/PNaZWgxS7c2lb6AM5gjDb3JxrVkzm47Ppq/VBNE+7beL0oR1UZdzcJTRPPhs2BGp82/8QZ0gL/N5ylfAcV06SYZ8zekJ8WKBNJEmQcruSEBgn/aTZHmQsD1Vq4qQjGcljsEM98Bbl4FGJgRPTOppMU4ck8x/xd+wW89Tj6HEM2cIuwXyYSu0ftB0zVUnk0WdmbRRJ8wJnWmuzsL1aIRYwPrgIzy+2zIOwndSwCgbOVbLRarbr3UJVMuwZL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC0Cm5KdqxQ2eHtoQ1Rx7DoT3PUUHtAJD1xSFFGr4mQ=;
 b=gbia5+H7f2v43JA2MnQdr5gS9onSjYRe5R9pm3H6t8/rcV0iRc94itc/KLCJxoyG9jbzTtH//pA/lUqiRue3j5olf0oq61lPLkk0/4jZXknnltWnw8R4KtHt4e+FwZbMFa5/sE8ryR5lMeOAoigbCwVWoeYlTJWCV67poZ3KZSr7KMkaA+DBOHkIMj4eBq3j0AEIQjXUyhXD6+9qR1rHj0QAPw4BskXgBQQ26IfCTDu+ps+IqGbO83aOEQ8xTWKRtazdEAxbJAk6DBOl1dXOBFIFFgyPFbPaRq6ud7W0n8cH0aNwSuG9YgWunGnJeBdMxRRjeORt2b4scNcx3QaFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC0Cm5KdqxQ2eHtoQ1Rx7DoT3PUUHtAJD1xSFFGr4mQ=;
 b=Xj92xHuYtW+Zh/D21K2R9Y0dXR/vf4D1hDhMdx1lomlzIFGWSnQzOl2s7EyvArlRoQ+pJdg8aGHLy+xIUgDaGBqYUSIU3CnEpH8uHFHnGRj0I5fQXqAGEH/HmLJU+FNF7UpsdKNsJDa44OzIBtKZoUblK116FB0DaIKpTvPMkg0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR1101MB2106.namprd11.prod.outlook.com (2603:10b6:4:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 06:57:30 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 06:57:30 +0000
From:   qiang.zhang@windriver.com
To:     rafael.j.wysocki@intel.com, len.brown@intel.com, pavel@ucw.cz,
        paulmck@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with rcu_read_lock/unlock()
Date:   Mon,  7 Jun 2021 14:57:43 +0800
Message-Id: <20210607065743.1596-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Mon, 7 Jun 2021 06:57:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2bf54a7-341c-4729-bf37-08d92981848d
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2106:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2106486DCBE14A814D1A81F5FF389@DM5PR1101MB2106.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1GFfPEA1FgI3NnOkpU1XJoMzdvTv44NW7Z3WyDj2JjX4bO8/XvU9TsnE93cBRVuRaElZ5QhyAjG16igKd4IXT0q+OaHc+O2+0+KFXwzsKHNrtB2pMDI4UwW1xbq/Bn5CtYDNn8JrunzWEVx8JYcBskHZnnW+nqfUcSwuY37UySyRWRcb3P2MCuj4FUPu5iGBuu8bcjuPmsNbTlTpS65Cxa4M3wbDRU556C/8UdY3fjyfW3ALYQCWJf7ddX2MZWYIPuPU1v2d4ImwxjkfA7h5372pCjZhWqd2EQFcEqN5s3ccZyN3G5nR6iamkJc3GoR8uGElAT1Tvogi5CkcXu+hrrr03oHEo0f162yJShS8kHqcUSyNBxfx58X1NVbRWT6NF5j0TYWZi75QYKi4CB8+cJtE8JYUnChYy3nSUZFkvKxHzJGKoJtkpj397k8Lv7V3LBLv5aze2MCzXjS26kNRlUoPm/SnNsH/tRG8BJEMksg83gEeU8shMqLa1BS9ZiurwzuHGQNgzk8UULVtPBYc4K+ckgvBolXfqXaWrYc/cRIn3QOvtUnpoVeQhfjs8Ejo3CEvdGtZqwl8G686xyfVtOtSZVDCXHV1VlCO/mmO9GVmyIOOosq5RyuGqZTA59ulDT4EyB7speU0+Olua10xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(16526019)(186003)(1076003)(316002)(4326008)(6666004)(8676002)(38350700002)(6512007)(8936002)(6486002)(26005)(83380400001)(86362001)(66556008)(66946007)(36756003)(66476007)(5660300002)(956004)(52116002)(478600001)(38100700002)(2616005)(2906002)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?52N5dfS3asN2v3RvyQQCMIxoOP3nt5/klofT8y7LXUJhsjujbUCq+ioO+24h?=
 =?us-ascii?Q?Kmqg3l3vMze7MdDtQohyKri4mj7VkpEWQpNKyAccNJDom/usIcOyTQ5XbC8Y?=
 =?us-ascii?Q?5s0gnYP/H9AsNQ/zFVJe8dDEtI2Jq1Qon4q/iDlpeNS1Yb36E4XONhPo0GdV?=
 =?us-ascii?Q?0vHGlDR/PgMrgLWSYG9/Efu6VxkxlQkfDRbntU9bo1cRpbCEVZw5NiyV04vu?=
 =?us-ascii?Q?KLtmlwKaJO+JqIC3QklpSo+yA67KagYFG93L9tEjvwNW2J4S/BXPK1Z0bi1g?=
 =?us-ascii?Q?YnCWU/X2Bhyk/6eWbijHX5DSwJmUw4ApXhgGatT6NZRNs8pVmi6pMK4S3T6M?=
 =?us-ascii?Q?SM6P9d2keuNI0QadUAGR5uTsX+FPN/eF111M2U/b481xi3oaIVA97NrnkvQj?=
 =?us-ascii?Q?h9SSpeNt69Hg6Pyv+xP/atS+PRf1WmT+48ZPrwGwTEzx+V/d7zMMgmD57w47?=
 =?us-ascii?Q?WkKhxF4PIUrAW7GhcdxJOV91hTg02WiAMjwTTVYOsx9P2nb/2rfyKXSlGLrB?=
 =?us-ascii?Q?B28zel3jclCYU7omqGLU4ktvVHgTq3CLNLxQWg0e/CZAN5cQYbtgUAJcLNvq?=
 =?us-ascii?Q?02d3+yv0hDADNo5PpJByZ4Wyfkvtkwb64TXFC8Lu7Ate2VsmsqsUZzss2ois?=
 =?us-ascii?Q?OTcovQWVV0ffxwMOx0vnyKbzidzYtJo4nDP2+G4Wz1cksnvUlW+BPWRCK25z?=
 =?us-ascii?Q?XISq0qgZAJ0kUCZ9pO3V6Jjwe9iVXSz8yYyoUKt5AkSQfPrvqfxMr2m8HVEy?=
 =?us-ascii?Q?59Tr/uBDQy6Bwud1mrXPvAvgIqyrr8gKMXxtX3e0WSy1XdwDYt6mwD2nyHy0?=
 =?us-ascii?Q?0799aT9zYWFnOJqG1oOYPgWU6EpdtPSJ+fTr3Wy/JeO8gyP0ERfhdP/16JYG?=
 =?us-ascii?Q?dJ/I3t2w00KcQ2dyHqRfqfoxUx4mAKTeIiEdQrBaCBtCgiF2m+NsUpATFkvy?=
 =?us-ascii?Q?sa+/z8aHVF3+ZGj8UWH7u4eG84MVZA+F3HuX3HTyavy51ie7RitKb3UpgwP+?=
 =?us-ascii?Q?wuorHO0BjFKLQI8dGLhxrkYEdCLn4f6lbZp7RnZlvlElviGoLumDUndoUnIB?=
 =?us-ascii?Q?NLou44YwAlQAdOyGDyypwg5NVTp0SzX31ggiDlrXCS7QMhDD00vVjFrJOEpA?=
 =?us-ascii?Q?f9Gesviwrd3o5ceF0FKqrG25HInj9jurY9TuBjC/n4zl6dd22PALyt+DjOst?=
 =?us-ascii?Q?z5OrfMNUVG+d9MNTEdEouYMc6FYVq2NmkkCAPqjhaOTLlHTcyZdi5RZI08dU?=
 =?us-ascii?Q?P3kfRkOH3qKO3oINLorQ9EE995aSwhiwYIXTlVM2EjyCkzB/58Av7Qmfot/r?=
 =?us-ascii?Q?fMjjT1Mi9adJLipQGbZI7yXl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf54a7-341c-4729-bf37-08d92981848d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 06:57:30.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSWhqJdn26dMr1mLrunn2kEEEAYYL6Pm8g6qup48dPWFmMsplOFs37o+40AKib50WiHLj6JEjgrJOX9Yj8Co06FhrsvH7mcaslrKCt9ZRYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2106
X-Proofpoint-GUID: Sb5MDY4-kAfswAd-Isnwj8VLwfaxqV2V
X-Proofpoint-ORIG-GUID: Sb5MDY4-kAfswAd-Isnwj8VLwfaxqV2V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_06:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=742
 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070055
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_lock),
the task list can be traversed in parallel to any list additions or
removals, improve concurrency.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/power/process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 50cc63534486..0f8dee9ee097 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)
 
 	while (true) {
 		todo = 0;
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		for_each_process_thread(g, p) {
 			if (p == current || !freeze_task(p))
 				continue;
@@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)
 			if (!freezer_should_skip(p))
 				todo++;
 		}
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 
 		if (!user_only) {
 			wq_busy = freeze_workqueues_busy();
@@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)
 			show_workqueue_state();
 
 		if (!wakeup || pm_debug_messages_on) {
-			read_lock(&tasklist_lock);
+			rcu_read_lock();
 			for_each_process_thread(g, p) {
 				if (p != current && !freezer_should_skip(p)
 				    && freezing(p) && !frozen(p))
 					sched_show_task(p);
 			}
-			read_unlock(&tasklist_lock);
+			rcu_read_unlock();
 		}
 	} else {
 		pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
@@ -206,13 +206,13 @@ void thaw_processes(void)
 
 	cpuset_wait_for_hotplug();
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/* No other threads should have PF_SUSPEND_TASK set */
 		WARN_ON((p != curr) && (p->flags & PF_SUSPEND_TASK));
 		__thaw_task(p);
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 
 	WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
 	curr->flags &= ~PF_SUSPEND_TASK;
@@ -233,12 +233,12 @@ void thaw_kernel_threads(void)
 
 	thaw_workqueues();
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (p->flags & PF_KTHREAD)
 			__thaw_task(p);
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 
 	schedule();
 	pr_cont("done.\n");
-- 
2.17.1

