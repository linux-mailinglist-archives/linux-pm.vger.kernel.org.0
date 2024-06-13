Return-Path: <linux-pm+bounces-9118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46B907B23
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C76B23815
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BA14AD38;
	Thu, 13 Jun 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D/KjMiz1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B014A600;
	Thu, 13 Jun 2024 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302890; cv=fail; b=dat/XltuYyY6/yyBUeCBSp6ZI7IgiuF6/sEayoQEopbdTJ12yYQL9EJdhb4tjpSaRF7BCNgxt9UBjZ79Hg5tDoJxAKYgGUyVaPvjn0Zdr2qo//X5Rlb3zQc4Jshv6w6uPmnhjygI/ZEv0G05AbrQqcjSCsS6LLYJDNLhupO7DCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302890; c=relaxed/simple;
	bh=p0cKsEkbsM+vF8/wgff97JNOl/JpHboL4oasYrYew2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lkcn/NQmNb1+EDbjUQ59wzGoFh+OK7hm45TLf1S7/pW3Ka4IJOelddh0bLMmM93S0YCXwgg8/HsZjqfFTL3QiOrm8DpnAETQjR1NMRP/mXIijrsPW3yP7pRq2EUQA14hVqteLJ4DCzACSWrJCbPDnPQ6xmLkk+cqf/3PjF7aD6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D/KjMiz1; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnFIgEyAvLKuyzfjzuDNouN2YpFoP3LYlmYYvSCtLz7luFNmZHUKJXANUrwATyI8K8uvDqyKYOnr86RwbrmzsiIRy5hW2KmyC3ZPVXqNRygL7gLM+HiyYtA5ocILSQj2sydMFHEQUCw+aWhVXzBjSixQXQh5gb+GHk//regn7xsjqJpKj2vMSnkLrcL84IURqijU4ePRyi7fE1T+gIYzdj0k42Bpjdf/aWZDIGH48+gt6a/Y0mNHNTRMinp59VkMO7ptuheg4QeeFFVJD2vCJYzIoaf3ailUC90Xecz69CINWVZScg4foZ+uSCjSgvLQsZ0aZxaVKBNh6V0gnP0cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bZVytII8R+C/v+PKo5wVvTus0SddPbaB1Zkfd2yfPY=;
 b=FgJh/4jKWf+oenoFYIN3dKoM+gQ/AEQPD/mcE9kZk/yEQOD8f39YlbCVXwKugLBZ9nYJA4fDeHG8BFwFdFOkX4Z283BjGPoZaMYHgH9vtXCLaNewl7NNZW3gCpOMMwW2we6X2XkNR/pP6i8P2EpC35n72cBWAU/nuJovDug0O3JhahNIUiDNEPnmF4JQ0AURKY0DscFPlqtBBuFBWGYjvVIycQe5P87/+wSvgVYGWCL1Ol35OC4WUI5LrO6Eoq7Uc/SREYMkU2LBx9rUJf+b+tHeRbfz8JR/6h8MUOwH9fuq/FQOjfpeydfT636Rj56TBduyKppIGTC92f2z5DotLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bZVytII8R+C/v+PKo5wVvTus0SddPbaB1Zkfd2yfPY=;
 b=D/KjMiz1YfOPD9duGajzB8GVoGiYev5C+/JGnu/oD7XmWTuxOCQfVTWo6B//Fu7NIbIrijhh2Vz/oO+/6MEjed0pK2cwQCdyFxsLd7M6AhlmExQhlSBWr9jKCk5sCs/ONZv2Vd9EfAwXmqf2OrwEMGXYYw3HAZp5ZiiS8sELoUM=
Received: from MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 18:21:25 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::41) by MN2PR06CA0024.outlook.office365.com
 (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 18:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:21:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:21:17 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "David S. Miller" <davem@davemloft.net>, "Andreas
 Larsson" <andreas@gaisler.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel Bristot de
 Oliveira" <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	<sparclinux@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 10/14] sparc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:09 +0000
Message-ID: <20240613181613.4329-11-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613181613.4329-1-kprateek.nayak@amd.com>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: af9bb6d8-ab9a-48ae-d809-08dc8bd5a2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KjnFamwtsOv0+kkIeS4C2HyEk7bDBEgS1oRMGmIgWPeyWauDQbqcd0fOtn2y?=
 =?us-ascii?Q?lnmEsnjfMGAuK6Hd0bsCrKvMt9iFaY9WrhYpzP5d/DVj45/dNi5xR59LgAc1?=
 =?us-ascii?Q?RMF/F+j7Ifv2v2Mh3zNbDn+0mtyGlZ4Sn4eOGPlbN3RxFzdY+8+PnqX28gJc?=
 =?us-ascii?Q?mi5y9slGNPHdnJUwZIHIKk4rJPMYrl9+u4mOuxKxwfHQkoh5b1x10JON9c+k?=
 =?us-ascii?Q?3lSmIQH5KoIUJAFuArTkAeIf4NGxEjtU7wdXEw+R5qjVAPtzT/JCcGWE9XUs?=
 =?us-ascii?Q?f6HMWmvDqEOyo2R2SfzwMZ+jCX7joIsR90oeTn+e9OALuydnq2J626QINVtA?=
 =?us-ascii?Q?zSbAsN8iZDmh73KW31lDN22TN1aZ7Lhj5CjdEI3gl/oVbXJqLoCL0xsHDtHL?=
 =?us-ascii?Q?K3e+I2SzwbeXdJiIEm/y2yhSRVtbGlYskZ60hH05VlN7ttV5bvMc+faIWcsR?=
 =?us-ascii?Q?aXA88s7rLRSO+06x7pO5Ixma3qXL8aHmuEnCXpXzlc0U3yYr+6BJARtcBqnl?=
 =?us-ascii?Q?VIuGreDaIL6kEVenWv0+lcYYJao/aKJyfOQsBdFMPNmmqF6hg99o/PPgcDT+?=
 =?us-ascii?Q?A78v3jMRzcO+oolUem5O/P7cEbw6AwS1MaIscLNb/WrEQnDv56i9d2zhajIo?=
 =?us-ascii?Q?WvNy0YeYsfufVhTSX2O8z9ZYWr0GBaYWFUY8coPfGm9VQ1uzH7hg5O/4OjF9?=
 =?us-ascii?Q?fAx0uI6c5kpMim8nP4XMDLvrCKit1L996ONDJh+AnZoZpU7VPP3BDb0S3tgA?=
 =?us-ascii?Q?v2mjcYcoUr0Q3vx/ZftlJreflsHphY513o2/tcUrzr80hGlYYhYUKxyIu9P7?=
 =?us-ascii?Q?V0/bjuJWumqw6LwKjeLqZqEnn+HqiprtvQvZzzy7I+cY56wdr4WeFhMG1xmn?=
 =?us-ascii?Q?rVnH5bNwAYwBG87sQD6gjtM/ekfPRUb62/jzkE3oIASzNuliYFqdHB0wamok?=
 =?us-ascii?Q?9i+TIoilLoUBcYBufK/DDiX0gQqdYepTCwSvXowUs2Ejhg1Adt1tMIAL6Wzv?=
 =?us-ascii?Q?og3zrSh13McP5CenIoQjbTH/GQl0SJ2SP64MVzArXlrFpvIHsZXNFFtvCczQ?=
 =?us-ascii?Q?nV0Pb7/4MxzZJiuoW69EZwGuq3U6Lw8v/wtpe4rDXJlkpcqaDk/38TQply9c?=
 =?us-ascii?Q?TGAJYIUpvSP2S+gT6EtcS68AaEKFu01yUoRIuBPJoyGMWbclKU+0GP4d0YNC?=
 =?us-ascii?Q?Pvj9hm0LFney1V3IEr+irRYYQC+qXGjytCnICxeV0qmu18DMKH/0+Locx8e6?=
 =?us-ascii?Q?h3T7i+gMSbU5cXEx3IDrIesk1p0PE5aKzvQnRcDMAl3rw2zjIeN1HNgD7dIB?=
 =?us-ascii?Q?OctH0LlHwzD56SPk3CB50fHWDdgvyg5bABFZHoinfDXjcjEAZOAyJChNgsJp?=
 =?us-ascii?Q?c3Kcd6M6fUPhZVxZOmPth6JYwcybfQKKlZo8vhOawcrLpUUShA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:21:25.2856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9bb6d8-ab9a-48ae-d809-08dc8bd5a2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

Add support for TIF_NOTIFY_IPI on SPARC. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/sparc/include/asm/thread_info_32.h | 2 ++
 arch/sparc/include/asm/thread_info_64.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 45b4955b253f..f538ede526d1 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -105,6 +105,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_USEDFPU		8	/* FPU was used by this task
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
@@ -117,6 +118,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 1a44372e2bc0..3558101ccdd1 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -194,6 +194,7 @@ extern struct thread_info *current_thread_info(void);
 #define TIF_MCDPER		12	/* Precise MCD exception */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14
+#define TIF_NOTIFY_IPI		15	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -208,6 +209,7 @@ extern struct thread_info *current_thread_info(void);
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 
 #define _TIF_USER_WORK_MASK	((0xff << TI_FLAG_WSAVED_SHIFT) | \
 				 _TIF_DO_NOTIFY_RESUME_MASK | \
-- 
2.34.1


