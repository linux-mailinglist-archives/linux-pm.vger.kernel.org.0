Return-Path: <linux-pm+bounces-9113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63459907B0B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA251C22880
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72D14A624;
	Thu, 13 Jun 2024 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JNPeXEKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAB14A617;
	Thu, 13 Jun 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302774; cv=fail; b=GAgwLFT5h79ftywInYsB0mIQ5qinZMU+kyBX0PmwfsRaIjvazdrCIcLaqQdjL4AyjEHGIFjX4ylZCWldM+jnlkMCIDVa0eAOIIxWY4qBrFbVgsWJQSR2MA3Cu8UGRlKiizz2Zo+hy7lMpYSb68UyvXQDjexlwPeZ/ANX5PoT07c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302774; c=relaxed/simple;
	bh=N5Xs1gHFtmRB7g78aJer3bDzIFfcfTiplMLpviSEwbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJanbrmLSvvfNKeuiHze4/joyrRKYTqQP30Apg5kj3ApKwlARjgN7qj1QkPQT8r4S6o+nx+qfjuQ/3zA3gSj0GsNa4ZDsrixJ2QWBLdSHs1lN5rjnIKoKaCEzs1DY2kro5L6jkRE+RyMT4jreuBexmpFn9gAUOrj628CeeRpAg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JNPeXEKc; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJGYjMM7eq3jcQSvLjD8JwilT4BLJSY73LwPGvOT2sRjPx8AyWl3zHvGGWlQ4/Fl9+8wgsIsx8GzkkGgsQxdsUqeXbb40NfWbS8WdfrfNqVkKryijt127SyoliHrc7UOFLnpOl+eYYp/CAtmz3Nw3lhZAF2A5cpoV6XlJOpGGqiVlf372U6s0JlRjnh+2H30lG+1d6roU4vbaHFbkC45bbvE6llmDcyzshi51lOaRrp48ERwWqVrUcTdDgdI8wHzRPPL0Me2BUffj6GwtvoKUIecrRj+MHoXQVT6hUbPXCxc1qIQvcVOZvsXibXk/JGRL248vJ4AMQF+8gxX9Us2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9SP91OYsN4ihnOgSl0XGZN6I6AzoKAxRQI+tR3d6Hs=;
 b=c9xwAg3FwSKdaIT9eqQ6NRhwq1Q4LOmU43uPgxyZG7ar6powrXDvWEbQ5UuWsARb0E7gVPvUB6upzpoJKRJD9pYUG6ksZz6Y6HvJJNv0IMKplWAet1XSHvZjgPB15GJ1oZ/UoPN8sC701o6jknPs21nlt+dSK1J6Aa37iw92GgZ7HRRl5jE6Xw2aUfH6cEk0jMpt3v0VZEHNZOUnfAbKAptJZGJ47kAD532PA/acMjfm4+ObMZSaEhP3Kw46aNlvN7WuBCQWc8WTFLSY1CR+xGHLuJqnlebIceYR7OPhm2w+GoLp2VJyIBnf4skPg/6/pkYGeaty0vdcuBEowMSIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9SP91OYsN4ihnOgSl0XGZN6I6AzoKAxRQI+tR3d6Hs=;
 b=JNPeXEKc8NKZzjLLfZoFr+HwwT04qggrDt65S0suHbCGHWKm7Op3xhA4fXldfVXnn91htAQtmWHbdXnAjbb+LIPrmEatVnLJPC+/dh6j+xCJ9fRoFYqt8Xet4VyZFDxm2HFM2rsS0yxjXcaA3zkr8sTZ+baWl0LraZ8w/+VhC2Y=
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 18:19:28 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::ac) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:19:28 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:19:21 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Russell King <linux@armlinux.org.uk>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 05/14] arm/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:04 +0000
Message-ID: <20240613181613.4329-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: b58a1efa-cc9c-4400-5bdd-08dc8bd55d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSMgb8ovqqse5ZaPqQTz0yBg13jzsXXirtTTAwCByqjVrdbx8B4DXpyByYui?=
 =?us-ascii?Q?/PENqw9xk+Tmshrct8X2ufQjxA+pKfubOaEpwRybZGdlKoykr1dNLCAmuLP2?=
 =?us-ascii?Q?DCR+60GL/CuIzRfi4ntV1EyOQOrFpbOL2YRVJWs2NgQ+tDxPKIcc5pBxLWxf?=
 =?us-ascii?Q?qhwFU5VsuBF416NMH1NU6hhbmwitwh8fdlhNhXDo8rtCWBAz+scgA6ls2xnR?=
 =?us-ascii?Q?OIcpmfvymdxT/l8l5kpTWoay7KqOLMFQzZEhk2BF0b6AHkWLfmFsELzxTeYr?=
 =?us-ascii?Q?f3CERm8Ndp9DHepQqtiiV8ptxpN8HOLNWbBkJdtyR6XqZHlgtSgQurCE2/Vh?=
 =?us-ascii?Q?yglqH/fOneUL4tZukDKmO9H4MOegldjT9W3csUqXg6D4q5EQXFwwYW/T75ke?=
 =?us-ascii?Q?qhOxq5gpRVxNZQMDGmJgvzuTgtsZsrIuwzq2J9OvVd/hS96oDghFgU0lDben?=
 =?us-ascii?Q?ghlIE7RiWADkGy+w31rORyLzfnsxkJ0MeaaRw/EQ75hXK94wle973hhuLrtI?=
 =?us-ascii?Q?ovlpvYJfJExsgAp2Q0ONQzds52YFoQoEKV93RsWsd3PhbqCx4hpq4vXq5YYM?=
 =?us-ascii?Q?a+Zg3pH/zBp7fHZZc6vfF0KXZyEGIn7c2CB8f2h1MJCEy1lrZJJ5hUhrr4Ui?=
 =?us-ascii?Q?IkKHLuS1c9ioJ/qrKRAjrMkGfmkTBjGAnJU32zh5d3+v4NekF9b4Up17zO2S?=
 =?us-ascii?Q?vW1IQ3dhk37xXJY3ANiUaVi2CveOQwuzqM1v7g0r9nFJBSq820OMuNRGK7Hg?=
 =?us-ascii?Q?UFA+4lTf2Z/n/FxUIvlHxm6sj29/op23+oh8vuICBzd+neHvbNe7iD5h5qmj?=
 =?us-ascii?Q?JP8Ha1BIupPsdhcMwhgQ2Lpxur4WUzTIaSw/3z1ZblIUnKR9flt35j3dnWZn?=
 =?us-ascii?Q?Hkp/pSjIWrQb12GWQHi+0Q+ktrECda2TQCNrkiCssiyLb7LexLUukwCPft87?=
 =?us-ascii?Q?Ex5EBMyDXoofXBUNs7oXMavfWql6a4CZFobsM0A7T5HvL5L9BrciTGwjV9/w?=
 =?us-ascii?Q?0Z7PRJ0L+UQfJDUJDw+KssTAC5Vox6KiiIujs0kpyQJwgiBvK2LNv9YBCA/X?=
 =?us-ascii?Q?io2IpD3lwZyI2rgSFr5ri4KuEQ1HQ/vDP1OcI+JcPXdfmEGuNj0JNhtK2kGc?=
 =?us-ascii?Q?9luv3RprBQOsO2M4OMZir1o2+9CJUs/GfipW8vjdehRhvJICPqLSOzoQmXmF?=
 =?us-ascii?Q?/bCilkqdCh+UwgnjonvIFoLd52ZOTr2uAi3pwEzyzJESh5yihqDRDzIF8g7/?=
 =?us-ascii?Q?zQ+6BItpE50kshThI1BpsRt8vVnlz+Fh/BQt9Ag8lT2t8dZrXiTSFcrZm3ur?=
 =?us-ascii?Q?fqED7A9M5dx7UuI35MPsxvA7pHNR63qRjbm4bm+WjbbBxTdfYt/4w/R34top?=
 =?us-ascii?Q?mOvOtyv/kIvZ3ZK9+dkySkoyFCwK8S7xOIWk+fJEsUX8rhpNYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:19:28.6283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58a1efa-cc9c-4400-5bdd-08dc8bd55d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Add support for TIF_NOTIFY_IPI on ARM. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Russell King <linux@armlinux.org.uk>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Link: https://github.com/antonblanchard/ipistorm [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o Dropped the ARM benchmark numbers since I could not get my hands on an
  ARM64 server internally. I tested if the lack of TIF_NOTIFY_IPI
  triggers any of the modified path or not on x86 by only applying till
  Patch 3 and I did not see anything unexpected. I'll update the thread
  with the results from the ARM server [if and] when I get my hands on
  it again.
---
 arch/arm/include/asm/thread_info.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d2..324248d87c9e 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -136,6 +136,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
  * thread information flags:
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
+ *			  or TIF_NOTIFY_IPI
  *
  * Any bit in the range of 0..15 will cause do_work_pending() to be invoked.
  */
@@ -144,6 +145,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_UPROBE		3	/* breakpointed or singlestepping */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		5	/* pending IPI on TIF_POLLLING idle CPU */
 
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -164,6 +166,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 
 /* Checks for any syscall work in entry-common.S */
 #define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-- 
2.34.1


