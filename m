Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80F42FF6A
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhJPAWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 20:22:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56828 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231881AbhJPAWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 20:22:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FMRHF8008100;
        Sat, 16 Oct 2021 00:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6RB0kO3zT1X93MwO8xxE+0xYmLl5rorJFCklVfyz+eM=;
 b=oGjiKJM61zHPZ+gEPahizm5hpGCioUTUIgLTMH5+g9UlrXbkZhOUllc/33a8whpXZ6+c
 KFNRDxQVsXafLeEy1yuz73sKN9JsdA8JiQPXIlar4atRolopAS8Sc1jSZ9MVzJWGne2C
 nuQTszn8OcE92aXBAMC1RdjTHyOLvN5M0iLS0FnPD6Uc10w+ufQvV4oMwRQhJMD9+ITe
 DA/56XXqKomXcx2X28qQmmkx5ovj7KoiohCepzrS6Z8TBgJ+lqpmMtSF30cWE21o63O1
 D2xZYeue+qvhKp9r0VS0Sa2NpxfeQhHOXsbqdquwLPSuKY9QdEnWQxe+9p+CJZNH6+F3 TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqbgftqvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 00:20:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G0BGdk056622;
        Sat, 16 Oct 2021 00:20:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3bqkusrgr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 00:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYG5e8e6KcKFIKMsGI+VcJcFnJYZXtmMofZ++uTpR4gBKz1dOmXCLmIuARFWr82fj1OUNCGkHp4ADIeaIB5VRYeHEoC7yj+4BSrbsGtAzGXyb3SGR5Rw9LhmAS0c3I4ss17SOZpngBO1UckOiJ3lQHrfZ2K3jGJg0XoCNkEK9n/fz1K3JU7t4HoySkhXihrunq6KQsu0gfLWyl/rbpYo+FIp1TaJSZTOthQOCNUXFKJxlQ6Cro42GQp/OPT5d7E66w4uYm9L7XDN+RWIY5Kfk3u/BAYlhzevOTb3H9oD3L6CGO9BZV7fURAHkY8PRu6tc79eld7u6E7ojfqOWjCRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RB0kO3zT1X93MwO8xxE+0xYmLl5rorJFCklVfyz+eM=;
 b=QWjoNJZeiY0q41ByVNsdkU7W/zoUJf180luyr+jjYtlow1rB38BacSs9jHJXulM+YtzUH1rOv0z/85lO9H6Ilbtr31V/4Fh+EoaffwBYJHPDWXheiuBnamDWc5AGlrBs+qg+h1kwC++yeYQ3lNI6Fod71HXzsjkDy2Cid5L7e9mNFnbaY6hncLE+vauCKiz0/GP4YkzpUaM5llgJiV0CK/pbkHKHidKVzN4KDa3dZz7sKQtkhDrJ+BCeiXAJl2e2q4i/+BoDcWtcDYTIKvI+TYCJhmP2DDwiKwX45f7dmmer6xhg2u7Fz7MUtR999Ya82m8jNoz5wLsN3RLEhcXHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RB0kO3zT1X93MwO8xxE+0xYmLl5rorJFCklVfyz+eM=;
 b=LhNysumnjwvqgOBDkkXMO89h1kqmwpijgVczpRhRrJKbjffm/FPmXBodVsjqEsu94HydS/bZatTTzGuY5FqOWSnyFWcfvSSNa1K2D6ArQ2gYpM6QkXh+bqixt/S4jchGmX9ndDnn1BaW1Y0uIaAX7LQ+Ip2WtPYEYjlf2b6xoCg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1247.namprd10.prod.outlook.com (2603:10b6:301:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Sat, 16 Oct
 2021 00:20:26 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 00:20:26 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH v3] workqueue: Introduce show_one_worker_pool and show_one_workqueue.
Date:   Sat, 16 Oct 2021 11:20:07 +1100
Message-Id: <20211016002007.143661-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (2405:ba00:8004:1018::16b2) by BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Sat, 16 Oct 2021 00:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac612df1-7e6c-4698-a530-08d9903ac059
X-MS-TrafficTypeDiagnostic: MWHPR10MB1247:
X-Microsoft-Antispam-PRVS: <MWHPR10MB12472977541930C4BA9588C9B0BA9@MWHPR10MB1247.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjK2tBgoXXJdMS6U9N3nNDtjiKRemijWZ7EOK51sWUL2ewZ3GAETWQIS6TNmpirBmFMJfXHiKpPav5h+e6ZwxkAuMs2vohM/J9fwH3XZXr46LLe+yTkxQ2mvpi4XmGFl8Bq+8LZU4oUSybRLqA6Az+a9O7Zl5UXT37p7v5SYkrGTMMr1xfokdSSOASIbTAjGiVgwsjGJwpXpLJ9mANf7KC5iVm8D+Z188wUZUbYn4HvdxtWmSWkuHyW29Pj/8211sWpTHWRuLQ6UE+mgjOn9Wk3cY913cRcTy9g8FGKQXRWAvppAHgajZyfGaL1pqKJdZBUu1RSFe3JqV/RDn1Dbh34BpwHwa7b788lXkrfXyI0W7hFsuy53xcBqigbFNC0PwLE0ZTnFannikrk7g+jgakJlcKt7/KR0yJ3bWp9+Yoheo2kdfC//RmqYRTUOY8ZZpxl7L0c0tjzrZxBtL6923olLWPr77XN1W1MOuBLgSHq4DEB/Yw6VqXKCTK+48Y17xQqV6P6UQBCOeii1Ipel6/NIhv6KChULVitfTJUxODqAuIfLdBX1hAn635iLupPbxqmZm/xBX5MpPfRLVQ4Tm4McgydWLYsrPr6/g9W2SaauDZj6s5+tQlC8rhJyPEBEXlgMN5E46MGi4EXw7n+/zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(8936002)(38100700002)(2906002)(316002)(86362001)(186003)(6486002)(36756003)(52116002)(6506007)(8676002)(5660300002)(6666004)(66946007)(2616005)(66476007)(66556008)(6512007)(508600001)(4326008)(103116003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Omp0+QciLBC3v5xDGIgO55xvCAweoyXoyMw4IE+2EDmVB9kah0HsRJTWfKDf?=
 =?us-ascii?Q?wXgLHWEh/nyE5z+3HEvRQyt3I5yQu/yt+qAnawTaeU9MlPa/Qg5riQZWTO5W?=
 =?us-ascii?Q?DW2O1dQL2GWeYf7fPux8h88h7jp9BUhRT93FAeB6JddrtwqE1H/Rd5EwhozS?=
 =?us-ascii?Q?a+7lGiUV6Pp2F8rU+AuaX9IAON/QZv2bn8zJZaCwiRTL2dyXM93y2iN8padL?=
 =?us-ascii?Q?52HK+ccNFADfQYDwhc2DehM/zBHaY8sr5aWd0l3W0YmsyD1sPRsau0EWtWB9?=
 =?us-ascii?Q?3jTHBX0frfou7v0E2jPyQN5rVQmXW4fN8cPZjCHB98BYd9Z8/dpcsDqx7M3g?=
 =?us-ascii?Q?SdV9ay6SV1xZ8TX78uXeCaeuVPmDg59HRNJiAkXEtJUQowKxJBsg5vXlr9ed?=
 =?us-ascii?Q?HKGEVzAEdKrO36VQRv9YszA33EQ+4fvzeDblXNrGXMC1pPnP5wy6VJIzuNlD?=
 =?us-ascii?Q?6KvnVKDjw55mdxpqdMoDlQZPh+eW2XT+AHjC+M4E7oMGuHQrHOCf54Hin0dV?=
 =?us-ascii?Q?muV+jhdghZd9MAtOajIrOm29qgoMYCyUu+a+fh80k0DQOmMMzzKtXSAFlrMC?=
 =?us-ascii?Q?j6hkXI+JrMu+MrZmeMk1RlE7Wwc0wBYFwxdBx1lX2zPUqtY4b7AJC1uhdQxe?=
 =?us-ascii?Q?lzXsuihQQ7mzAxK5r5Xg97mc9v6Ou6yw3OAdEzbAkYygcHv909mIl+DTG2yA?=
 =?us-ascii?Q?1Vo+U+4Wwl4JdRA5NhhQlRnAd24Kza6l/ZLvllPnfj8ihhax5vxrjuvd0e6B?=
 =?us-ascii?Q?IdeUKNpa/4HyK1tebjvqOwSPYdchdiaz+bMzixOh9EMM/egPuSIBQq5cVGbY?=
 =?us-ascii?Q?fNyKkEnJohoBbM0uAH4AK613XsHnJ9obDeI9kUcQq+tPQ/isch9ZF9pk1GqR?=
 =?us-ascii?Q?tGQU+Eix89mV3H2szfNlfpQ/4vdOMbo6ZEche7nQpidN4zzYUnjYPcUK84gH?=
 =?us-ascii?Q?iX71e8GmeYTjv70lm5H6JK4xgflzYr9/E/TXsEperJvbFC14rL412kjt68QV?=
 =?us-ascii?Q?ernod86JkcNgLDUzI3Mm8AcSBvkKyHUFniDaSp8et+KpcJ4fpelnJ9bqfgfM?=
 =?us-ascii?Q?zLBU/2ajuwy8fzXfq+qD/0kbjQtIhfVvmfbTelkzAGPD8S4WpbFo6xeQf7WI?=
 =?us-ascii?Q?U+Mu+FCrhg0P2GdniFsW2o03HA/8+UcHI6yBrJuYKSy0uziGFNb1du0Lzjsw?=
 =?us-ascii?Q?XofVAcjp4THjB2W8eyYdx3CdSGGtD+ez0t84+bqvcJrrZRgEPkSO+KxRQqdd?=
 =?us-ascii?Q?8Bx4hiLASyHCMpSIy2No+nb/C9rqAo6LylXMFPq8nvj//anVeZ1LKwT9NQ9t?=
 =?us-ascii?Q?DAcjlxFJ06lq2ZYmF4eBF5GmJq+6GV57KwiZDUKws483QrYmyEnabO2KurUY?=
 =?us-ascii?Q?qut5blo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac612df1-7e6c-4698-a530-08d9903ac059
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 00:20:26.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/IisAoGqPJbJwODT3qcsLJIPRV0qwfkQOc2WqFr2ll1PNtzoj/wxU4gGcVHcsj8xWY1ck+V60KNHGYKuZonmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1247
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150148
X-Proofpoint-ORIG-GUID: wArvQI32n8f9JiqEl-u3V_vc6f8ssPFC
X-Proofpoint-GUID: wArvQI32n8f9JiqEl-u3V_vc6f8ssPFC
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently show_workqueue_state shows the state of all workqueues and of
all worker pools. In certain cases we may need to dump state of only a
specific workqueue or worker pool. For example in destroy_workqueue we
only need to show state of the workqueue which is getting destroyed.

So rename show_workqueue_state to show_all_workqueues(to signify it
dumps state of all busy workqueues) and divide it into more granular
functions (show_one_workqueue and show_one_worker_pool), that would show
states of individual workqueues and worker pools and can be used in
cases such as the one mentioned above.

Also, as mentioned earlier, make destroy_workqueue dump data pertaining
to only the workqueue that is being destroyed and make user(s) of
earlier interface(show_workqueue_state), use new interface
(show_all_workqueues).

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
Changes in v3:
  - Address review comments regarding function names
  - Change users of show_workqueue_state to use show_all_workqueues

 drivers/tty/sysrq.c       |   2 +-
 include/linux/workqueue.h |   3 +-
 kernel/power/process.c    |   2 +-
 kernel/workqueue.c        | 148 +++++++++++++++++++++-----------------
 4 files changed, 88 insertions(+), 67 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c911196ac893..8d0f07509ca7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -296,7 +296,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 static void sysrq_handle_showstate(int key)
 {
 	show_state();
-	show_workqueue_state();
+	show_all_workqueues();
 }
 static const struct sysrq_key_op sysrq_showstate_op = {
 	.handler	= sysrq_handle_showstate,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2ebef6b1a3d6..c48f86e38d89 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -470,7 +470,8 @@ extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
-extern void show_workqueue_state(void);
+extern void show_all_workqueues(void);
+extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
 /**
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 37401c99b7d7..b7e7798637b8 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -94,7 +94,7 @@ static int try_to_freeze_tasks(bool user_only)
 		       todo - wq_busy, wq_busy);
 
 		if (wq_busy)
-			show_workqueue_state();
+			show_all_workqueues();
 
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9a042a449002..dbdf14738ca6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -375,6 +375,7 @@ EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
+static void show_one_worker_pool(struct worker_pool *pool);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
@@ -4447,7 +4448,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 			raw_spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
 			mutex_unlock(&wq_pool_mutex);
-			show_workqueue_state();
+			show_one_workqueue(wq);
 			return;
 		}
 		raw_spin_unlock_irq(&pwq->pool->lock);
@@ -4797,83 +4798,102 @@ static void show_pwq(struct pool_workqueue *pwq)
 }
 
 /**
- * show_workqueue_state - dump workqueue state
- *
- * Called from a sysrq handler or try_to_freeze_tasks() and prints out
- * all busy workqueues and pools.
+ * show_one_workqueue - dump state of specified workqueue
+ * @wq: workqueue whose state will be printed
  */
-void show_workqueue_state(void)
+void show_one_workqueue(struct workqueue_struct *wq)
 {
-	struct workqueue_struct *wq;
-	struct worker_pool *pool;
+	struct pool_workqueue *pwq;
+	bool idle = true;
 	unsigned long flags;
-	int pi;
-
-	rcu_read_lock();
-
-	pr_info("Showing busy workqueues and worker pools:\n");
-
-	list_for_each_entry_rcu(wq, &workqueues, list) {
-		struct pool_workqueue *pwq;
-		bool idle = true;
-
-		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				idle = false;
-				break;
-			}
-		}
-		if (idle)
-			continue;
-
-		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
-		for_each_pwq(pwq, wq) {
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
-				show_pwq(pwq);
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-			/*
-			 * We could be printing a lot from atomic context, e.g.
-			 * sysrq-t -> show_workqueue_state(). Avoid triggering
-			 * hard lockup.
-			 */
-			touch_nmi_watchdog();
+	for_each_pwq(pwq, wq) {
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+			idle = false;
+			break;
 		}
 	}
+	if (idle) /* Nothing to print for idle workqueue */
+		return;
 
-	for_each_pool(pool, pi) {
-		struct worker *worker;
-		bool first = true;
+	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
-		raw_spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
-
-		pr_info("pool %d:", pool->id);
-		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
-		if (pool->manager)
-			pr_cont(" manager: %d",
-				task_pid_nr(pool->manager->task));
-		list_for_each_entry(worker, &pool->idle_list, entry) {
-			pr_cont(" %s%d", first ? "idle: " : "",
-				task_pid_nr(worker->task));
-			first = false;
-		}
-		pr_cont("\n");
-	next_pool:
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
+	for_each_pwq(pwq, wq) {
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+			show_pwq(pwq);
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
-		 * sysrq-t -> show_workqueue_state(). Avoid triggering
+		 * sysrq-t -> show_all_workqueues(). Avoid triggering
 		 * hard lockup.
 		 */
 		touch_nmi_watchdog();
 	}
 
+}
+
+/**
+ * show_one_worker_pool - dump state of specified worker pool
+ * @pool: worker pool whose state will be printed
+ */
+static void show_one_worker_pool(struct worker_pool *pool)
+{
+	struct worker *worker;
+	bool first = true;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+	if (pool->nr_workers == pool->nr_idle)
+		goto next_pool;
+
+	pr_info("pool %d:", pool->id);
+	pr_cont_pool_info(pool);
+	pr_cont(" hung=%us workers=%d",
+		jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
+		pool->nr_workers);
+	if (pool->manager)
+		pr_cont(" manager: %d",
+			task_pid_nr(pool->manager->task));
+	list_for_each_entry(worker, &pool->idle_list, entry) {
+		pr_cont(" %s%d", first ? "idle: " : "",
+			task_pid_nr(worker->task));
+		first = false;
+	}
+	pr_cont("\n");
+next_pool:
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	/*
+	 * We could be printing a lot from atomic context, e.g.
+	 * sysrq-t -> show_all_workqueues(). Avoid triggering
+	 * hard lockup.
+	 */
+	touch_nmi_watchdog();
+
+}
+
+/**
+ * show_all_workqueues - dump workqueue state
+ *
+ * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * all busy workqueues and pools.
+ */
+void show_all_workqueues(void)
+{
+	struct workqueue_struct *wq;
+	struct worker_pool *pool;
+	int pi;
+
+	rcu_read_lock();
+
+	pr_info("Showing busy workqueues and worker pools:\n");
+
+	list_for_each_entry_rcu(wq, &workqueues, list)
+		show_one_workqueue(wq);
+
+	for_each_pool(pool, pi)
+		show_one_worker_pool(pool);
+
 	rcu_read_unlock();
 }
 
@@ -5855,7 +5875,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	rcu_read_unlock();
 
 	if (lockup_detected)
-		show_workqueue_state();
+		show_all_workqueues();
 
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);

base-commit: 683f29b781aeaab6bf302eeb2ef08a5e5f9d8a27
-- 
2.30.2

