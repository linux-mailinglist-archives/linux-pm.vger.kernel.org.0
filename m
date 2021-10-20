Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED784343B3
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 05:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJTDLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 23:11:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhJTDLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 23:11:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K2SkQl014998;
        Wed, 20 Oct 2021 03:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rEDnBX6RY3TMa8gOqqff46orgpijQm/YLkbwBipFtd0=;
 b=oau9zPCeSNJH6U/85YyhKuK/XHZrZeJ+uZpw3Dlr59eJoxB9JIPZwWrQzBWAns2gA4QW
 WKtiCU0Z6TdirOkln+Pf1tJfda33O78j4MTbuD4gqJbVbNvbCLjZl90H/OMUALP7xvfL
 MZfEgEFnA/ghZeVw2wMu8Gtv1BZ8emY/O9/w8Pum94qPAr9k0EiShS11NkMeywVbqA8h
 Rbk99EnJxrGBnRjsPqb7DgNIOhVAMFb7ypZ/cVUGWLsFYw+ihb0ZWMjAXQM/6tE3yrDr
 d1QVtxBrzRV2aVB9RJ3+6HRdjGpNmTcL7GliJNnG4PAfAEEs1RwECVcuaoTMWAlqv+VC Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsnjhx37t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 03:09:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K36vdO105509;
        Wed, 20 Oct 2021 03:09:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3bqmsfrfgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 03:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ6ClzSjJ2Wmo1ZRyogOgzjPZ3RRm9xUeQx3jDUwvWxuzaZDzzO7XyPok+ze9xuM0P2+ub1zzwtLo8ZAaNpDK/0SbyvQzBAEJc3UcMPWeYLko1Y431Wq4I90oXlYHjbwVOpgyBBZqaPNBiobYfrcHAvd6AIQ1XAFR1ozppwFJFa88YR3w52ZPSypH51qqlo9C8Cwh2IfYxycmu9vKXqfIzIbnJfT8XotI2x+I5eNTvqR1g8tszggjDAgQS1TqpvFVvo0g7ETXmNMnmEz+8yhc49xSfM3KE3fCRPLSzvUcw8RM+/kS4Cg+ubG6LcajK/7Tr724XtDjHCf0cAAuceooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEDnBX6RY3TMa8gOqqff46orgpijQm/YLkbwBipFtd0=;
 b=cvOKOld5IJ1QhmaN7RMhV7DG0H5YCKtz1mwV9KjB6gmLpECJB8kIwJEVp+f5hIzBnxc6FgSzmSNgHc1vwN1tDILbOQC7gMIomvsU1/a5sVr7DWmRdxHNGzmSvkbqoGF/or30/2suzDH9DwVPjlM9FvV6uw+Za0M6XdA3yzuJGeMDjzJP5XHQwR2OV0pQVYi7veJUcz4PsJGSAhqMyaU1WE2+ABZUTeohzbE5joW2Cioxe62ESlQf47GQ5dc+qmAMviX1ourK+Ea+Yk0CSsDUVTLFgm6Eka3wNAqCZqp3oV9VHo7OQL4HbvTibNoUqMzZ3Tvoz5JcoamIal7HatzTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEDnBX6RY3TMa8gOqqff46orgpijQm/YLkbwBipFtd0=;
 b=M56FUXKsIi/VXDKeistpMy8CVgQwGwa784wyH8RFQuiaDNuE+lZCNhPnPM246cvafEpYGNqNxAcKgyaKfKroRJiCEIvU6q9c6i9ZMaVdetwSC9g+8BJkoEzye4ttZ9AhSbLUl6swUEUTsws+K5/2y8/+eOuFUyhJ5vvxvl50PjA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5569.namprd10.prod.outlook.com (2603:10b6:303:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 03:09:15 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 03:09:14 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4] workqueue: Introduce show_one_worker_pool and show_one_workqueue.
Date:   Wed, 20 Oct 2021 14:09:00 +1100
Message-Id: <20211020030900.321837-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SY0PR01CA0016.ausprd01.prod.outlook.com (2603:10c6:10:1bb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 03:09:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f00d698f-b98a-4571-2474-08d99376ff3e
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-Microsoft-Antispam-PRVS: <CO6PR10MB55692CC1794C6169D5D9D7A9B0BE9@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3BpaHrrNP7+EtU0hkmEAmudmbI7lk3e/tHCbUIFTPLjdMFNF6a9bAJ8bp8ubBIjZhtix2GTG68+O8dAzdkQO0vDqBXK7WXYYPGRB4hb+LPUBeTM79hOYmXzFd1GuQMJIUEKAdHWH/K8vxVCZLnSW8u5hUSbYUYJHQDlcUYIT8PX1I4G3TNuZhUWep+TSEaL5+iIUgTXAM6fWv3r5udNXQA5vUBg9IEn2fFh64ogJj+3biDrZfF6EzBM/xKu4CIsPoYxg733d1rY9gklrAH68kRKVq94c/ZYIIGXbmy4B1BlP8y74nX7Pidrjhaj/gSXZCeXtdoYnkltK7B0VShBuW3gZdOiFxwux3b5ewbWfYJS9+nuK+NmTa9aKteqd41iM7q1FsaWp591NaiSXjaO/uuLlSFPT7tbv3iyHrOmtxCux1LYHMK1mqSbijTIwXX0xjSZHefRHzOhHXWZf7AraFEUEB8MZo8feEJsIlgL2KDXcLqJbObo3eYgue/bN66Rg7no5B2cImNCOuOFX0nBdbQiHq2AO1KhOkf4yHfaNjp+rqpUFuJm8oQt2MOJj8VGHdqKgPrCjiE7/PB6RdIvJlVn4m1X70+YNdwjzHONIKGr8eiCbgmj6QK3lPJqtgSn3AqHzbu/4D5XgNTAzUI2Gefwhue5LjOW5bwmve/WdtYkRESlzfhax4Qw3v3JBhkEIsa6a8LkuWvVWl6FZAo0nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(956004)(4326008)(36756003)(26005)(2616005)(316002)(508600001)(66476007)(66946007)(66556008)(1076003)(103116003)(6506007)(2906002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(6512007)(83380400001)(8676002)(52116002)(6486002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTjdJgbjHnst54T0PXBiAjbEXGqItcn0VIGnwV5bpFgLsHntfooy4L5sDPcP?=
 =?us-ascii?Q?LriybKZzzgHcmuzxI6qUzWaCoLFcTz6aI6csbslmmqR3GDlmDK+kU51ude9H?=
 =?us-ascii?Q?jXOq2mYqQjLJobz+n98niCEpFP0hH00FOEeCUy9gpdkFTt7DBms3H0BN9HK5?=
 =?us-ascii?Q?a0DVjkk2OIjCqWJbJrYAbry0O2qq9T6xJX7pJHLPFuVPfGXRduuB4lsdhy7Y?=
 =?us-ascii?Q?DFgVT6bTm1/Vu0tAmPJFrWh1d91PYYda3XLXBBPYaeK8Z59RJbuWqL2xIB6H?=
 =?us-ascii?Q?AQwBW4mDkyCa4Nczi2bfHO9mZ9x7jt0yKHMP1MxAFOKu8euFKf4VtXHPIxy0?=
 =?us-ascii?Q?RTr4rr8BjQ6S8Qiu9FW7PHuukUJJhob/lVbWDbfqwtDVkwA6UnhXqqNqoQE3?=
 =?us-ascii?Q?03fy1NFhnvTgwAX4nh69abM39+bV2wnU//QFollHUYT8m9xBsG2EMemuEMVF?=
 =?us-ascii?Q?Ef6BOVLCvBvqRx4dkxt0K4cKcafek+cCUNY/FBVNFsorjgdPdYuJMbrV/Iac?=
 =?us-ascii?Q?67G+ZShkzHaqWJPPSWCufHiSnxkptqo/YXmZtX3csCmbgyz+u9JkqfgVrW9d?=
 =?us-ascii?Q?jvA8q3H2okWEjAQ0OA6peziHAK/3SaiIbOeLRkozpHthcH5AiriT6bkQDbTc?=
 =?us-ascii?Q?NY4ivkmN8Ui9DpMpvrX1CEHQptRFw4Vwbo956jTS2RGP9Pm4rrOhMVlpJHPb?=
 =?us-ascii?Q?sEhyP62H+M4BDZOaxFVa3QzDr1M4SEXyWNnz2iGHuuB9RnLrvyubBWeWp6Wu?=
 =?us-ascii?Q?pzwhGxWxt0XjugamEw6/HXB7wRaEAbOwIvk/7bbvzH5M6Q5VASTsS/s4RLX/?=
 =?us-ascii?Q?lVFk3VRXGbzR4BtfHbpP7rjosKuJqFNwusk0J8D+HApmdgNq9+BJAWNuhhdz?=
 =?us-ascii?Q?ZYmALsm6cIkf5tZEUrHtUGalo74VQSxoSr1IcllYemb0yXaFnbz9pRTWeLsp?=
 =?us-ascii?Q?ZxjUKBk+Foy+OA0c0kzknrugVxBUSogQ9sl1r/vHvz26aO1pfvocv5zaQCCz?=
 =?us-ascii?Q?gqsKYaHLy+3sd7Kx07yIXH6uWfQmmirBLj5B2gzjhXgdHzp7Gmu16i2RU8PW?=
 =?us-ascii?Q?FbfeqED8+V1vNrLQVe2Vla/vTX6nWyBpbZJCjbLvBhkUw1TWKHVg9P/oGM2q?=
 =?us-ascii?Q?jgUiMVWP9811joKKFmjwURZCksyXVc/g4i/mgU3utD5KfIPPNsx+VKUENDB5?=
 =?us-ascii?Q?aSotwKF5j7udNmNJ+iQga7OzesABJ8Y6tntfB1Fb5SJ3N8Lrluc0rNGpg94Y?=
 =?us-ascii?Q?0luhqvylCkW+htusPR3VYOWhhdBgTAtinPVJppXDaWiEIVw2cP/a3Qo9KQpy?=
 =?us-ascii?Q?zidu82LLiPKGr5J+gN9uwrJD/HWyHuspN0vEFrk82LN3jNgvSShDLBFu3pXr?=
 =?us-ascii?Q?i5ml4cRe29tR9rpoydxdyiIOwlj18uvP3FUIZPfY92894IemKo86iPKvRh9+?=
 =?us-ascii?Q?5N7g9eajNdUmtgJecd71BDEPd4+cFAPG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00d698f-b98a-4571-2474-08d99376ff3e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 03:09:14.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imran.f.khan@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200013
X-Proofpoint-ORIG-GUID: 5CWQje3WeY6r7ur_skLO7zvK3S1gXYKL
X-Proofpoint-GUID: 5CWQje3WeY6r7ur_skLO7zvK3S1gXYKL
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
Changes in v4:
  - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
    for-5.16
 drivers/tty/sysrq.c       |   2 +-
 include/linux/workqueue.h |   3 +-
 kernel/power/process.c    |   2 +-
 kernel/workqueue.c        | 172 +++++++++++++++++++++-----------------
 4 files changed, 100 insertions(+), 79 deletions(-)

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
index 74d3c1efd9bb..7fee9b6cfede 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -469,7 +469,8 @@ extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
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
index 76988f39ed5a..1a7df882f55e 100644
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
@@ -4797,97 +4798,116 @@ static void show_pwq(struct pool_workqueue *pwq)
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
+	for_each_pwq(pwq, wq) {
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+			idle = false;
+			break;
 		}
-		if (idle)
-			continue;
+	}
+	if (idle) /* Nothing to print for idle workqueue */
+		return;
 
-		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
+	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
-		for_each_pwq(pwq, wq) {
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				/*
-				 * Defer printing to avoid deadlocks in console
-				 * drivers that queue work while holding locks
-				 * also taken in their write paths.
-				 */
-				printk_deferred_enter();
-				show_pwq(pwq);
-				printk_deferred_exit();
-			}
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	for_each_pwq(pwq, wq) {
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 			/*
-			 * We could be printing a lot from atomic context, e.g.
-			 * sysrq-t -> show_workqueue_state(). Avoid triggering
-			 * hard lockup.
+			 * Defer printing to avoid deadlocks in console
+			 * drivers that queue work while holding locks
+			 * also taken in their write paths.
 			 */
-			touch_nmi_watchdog();
-		}
-	}
-
-	for_each_pool(pool, pi) {
-		struct worker *worker;
-		bool first = true;
-
-		raw_spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
-		/*
-		 * Defer printing to avoid deadlocks in console drivers that
-		 * queue work while holding locks also taken in their write
-		 * paths.
-		 */
-		printk_deferred_enter();
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
+			printk_deferred_enter();
+			show_pwq(pwq);
+			printk_deferred_exit();
 		}
-		pr_cont("\n");
-		printk_deferred_exit();
-	next_pool:
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
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
+	/*
+	 * Defer printing to avoid deadlocks in console drivers that
+	 * queue work while holding locks also taken in their write
+	 * paths.
+	 */
+	printk_deferred_enter();
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
+	printk_deferred_exit();
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
 
@@ -5876,7 +5896,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	rcu_read_unlock();
 
 	if (lockup_detected)
-		show_workqueue_state();
+		show_all_workqueues();
 
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);

base-commit: d25302e46592c97d29f70ccb1be558df31a9a360
-- 
2.30.2

