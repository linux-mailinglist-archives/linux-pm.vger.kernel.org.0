Return-Path: <linux-pm+bounces-9122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FA907B34
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B5A1C226B3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0514A62D;
	Thu, 13 Jun 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GtrHipjY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71014AD20;
	Thu, 13 Jun 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302981; cv=fail; b=umt4PiG940jQAt2+y9vb9MnN4yDPEJXeKGddDtsBpgtA8MNmVKl8FR4u1mm1YjhpCD2bSPHLxkGI2mxfjqPoGcmDP3U9zGw+H8HnnAO57G0Q0VW2A3oZPKWdeOVmE8LbZGT0EJIjx0baHhE24jPOuj/r8/Lf3yHvhA5w/OHwADg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302981; c=relaxed/simple;
	bh=EwqSEJGQzhfTSysTU8zyNcy0wEjpWJpLS+8Gv4T14bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLMWkGuTd9C5LJGXvbRNx19HqrjMsT+qtq6LV6cD5B6DpteIG/om5OrtWT0UxPzEga5eJkEfy2HZgEab+c5EA806JX9q0A6LbVOvoniXKihROfDaLTyDCRYZFSF0str5nx4jCezmAVjfZpluvRxpOibI/WWFCCMyeNSeF3g9Ykk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GtrHipjY; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M373mYZW4L8C/I7f8iOFkCeCSISBbPB2c6anIMd0VB9QGFR/rz+03+6muv+L7R0uz12byDiLHgw+I67RyzmL07V1oqPlG9Mwg7+w4eelyN2XGbiw0JKeKVtgXYl2mq+vUjm7KviIckGRVPjTECr+pxnrnIuh0O87Gv2pLnnSOkhLVdOChiIKyE+95dC1e/xcrhJxSJDoL1OJcjPUsgSaVAZSe/RZhb/nAKeoC6XFUoV18raGUJZljF0KIsZ1SlCtD7x9gZfJ0yw9gqLp1dgze+m+UcX4ZxP6TLIQF1X3C96zWq4pJSFH9FrAPoAxTi36+h+RZ9J/FrCvJbMYNOMD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgacvd3u+50mG7IuO3XlM7C/fryoshVvDV11ftVHmIY=;
 b=ftWz5uxLf4sylTxMMNYdrlP6GfNOt2PdmmobB+oty2hK5AyvRv29LI/IMWMRT3mK1Ul3zt4qRMeC5GA297EGPuqRyS1mLVBqiHHOAVh/QljRE+9SrfmhCTogg+Wd+9znXa+w52pUrDJ0xJ8ySAHrwRedrKXF+X5BoS5ffUZvoQEkdmEVjml73yjY2qOvM/VBVzM0JOcWXut448XV4IrA9tHN21kHjjbaKQ6gUjCjNBqhO38R+z06KD6doxCgWG/V/vwiNCvJ89u+RS206mlknbJ+pGILDoGCQYBxteI6v8799EAu0ZmQz9xqEnMHuMqd0cmdAnrL4un/xgPgdcXBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgacvd3u+50mG7IuO3XlM7C/fryoshVvDV11ftVHmIY=;
 b=GtrHipjY32mGdugCpwW8gP3rUnbj9tnN82QqSZJ2DXVzJf6G6e7ThnMvxD423iOk++7AgUIgQWVS6u8OzLKmBRyIUmRThu4l+8vptnrI52QUt89ZB3I/kapLgzNmkgaaGgf5FHMYdksF84+47O6IRJjbmhHcOFKeX+A7QNtvwRw=
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 18:22:57 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::cf) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:22:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:22:48 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Michal Simek <monstr@monstr.eu>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 14/14] microblaze/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:13 +0000
Message-ID: <20240613181613.4329-15-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6dfaba-d5c2-4715-349a-08dc8bd5d9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7qx4qbAwR4ebL9d6362WPNN+A5sFbmK3PrB8C1tLXA9221ZI7HJrr4+t5hj?=
 =?us-ascii?Q?03c7T+FICa+ZO58MHDlSe16ugEZDSmWXiR0b6wdcNVCPfFkycTMBqH3g/KA+?=
 =?us-ascii?Q?VyvoEyJpJsA1XM2r8t3EJEkXDKDW7E62UOIpai19cWLy2PHbcaQgmKHzSHH1?=
 =?us-ascii?Q?ucbp9ZBwWrRhBeIt2miysah950/lMb1ss6a1YvieAV5pUCrkkxfxOcfbXarw?=
 =?us-ascii?Q?tUZf+ryzjchvYwcHdUms7cxXbqDBiuCl4FF+kMy3xJ+jpFhjGzFWmvZrYMhu?=
 =?us-ascii?Q?z2EaMfVoTWPknjK7HTmYSmFBVeu2XXOCEUECribmUltMCtkaSV1wBbw1cy0n?=
 =?us-ascii?Q?w3L7AR1zGaVpownZ6EpqeFrjm9lZamO0h81ypzZQfNihESqYHtEOalWB1QYI?=
 =?us-ascii?Q?aCUUwPgy6h4FTc/La/El+n/DJ1XFN1tSFN8qFXeOTN0OODSPQOtK2OmqPenN?=
 =?us-ascii?Q?n6okVESpzLTBda8RV+SymNkFc15pAo6svdK+260I09l8TaZrXcm2PPMx8Tos?=
 =?us-ascii?Q?EAUhJKWUPEu/HNCGeUpvptk9Ro5wSkPFKI8k5iG8I1mIYOTNTp/TQpESvIJK?=
 =?us-ascii?Q?d4RYJD64PIDLaRnktXz7f3vZ+Hbdo8o1m/FDJNld7zCFAT3oazRrT+l/FKnR?=
 =?us-ascii?Q?4Vo3zSuB2xTBtUcTVS4OAROXo1tEQr1mCjnqnlapWsfJrk2dBLQ1dBTtXypM?=
 =?us-ascii?Q?nH3beIIMsY9MMvZ+JC/KBdgeye/esmIKH+R9o87d9fhDbi+GmnnatblHOtvW?=
 =?us-ascii?Q?XDB15mN6rekwsGoAsEvGYzzFTEcz6WJFEe4mrCUvkwBoaT/FHazu7qoaFOoP?=
 =?us-ascii?Q?LKD2LHZQPh59TN68DDpbtPKHFHTWeWLkIFmP6qoVM5dRJvSykk1tKTHEhHC3?=
 =?us-ascii?Q?Wn4bX+b9HtWVzudJ5n9Azho4Dybr1AXBEYNTA9Iqh20XHlnPXPmclJJ90HOH?=
 =?us-ascii?Q?UR/Vrt0P2hAoIyubL8d6Ok0qPSf1gLDVNBsM5UuQzdNzHCjO9kfe2jGo0pT+?=
 =?us-ascii?Q?AEmHqHI3PJO/Jr8Hx9jvW7YoW27A8ahDzCwPxvCw0+EIdLEXsF9r7qZquAvY?=
 =?us-ascii?Q?dFd5kGhV6cfDspv/OlyVdv/dcTr1TJx+i5yZ8ty1ZvSH4rfDg2Q/Wcq5oQ4S?=
 =?us-ascii?Q?5BHN1T/Zm5yNUyJe43DqyyzHBBLn6ajbZUXwfE5D29iE8d8J0AcPVHwVSfBz?=
 =?us-ascii?Q?UHOZYDnGAtRAS73cgouiVbpEIqIOtm2iZijX7HP9aO5w/hYcYUUioLZGxwbB?=
 =?us-ascii?Q?nOXonjfL29yOmue/6zzEeP8ltFOjlAlYGiNGMjGCMq5771RZPUcmxCpOZOCm?=
 =?us-ascii?Q?PmD9pkqd88/xNRzwMH3cuMpW7O8eMkwUEPPAwE3vzRpJGVuCzms3zEdQxy6V?=
 =?us-ascii?Q?4X6mnQP48xJ1K8ZbaEfleM+fkBms6ZMvMyyzCWLiHfXRyFtgRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:22:57.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6dfaba-d5c2-4715-349a-08dc8bd5d9c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

Add support for TIF_NOTIFY_IPI on MicroBlaze. With TIF_NOTIFY_IPI, a
sender sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Michal Simek <monstr@monstr.eu>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/microblaze/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index a0ddd2a36fb9..953a334bb4fe 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -103,6 +103,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		4
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
+#define TIF_NOTIFY_IPI		7	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
 #define TIF_SECCOMP		10      /* secure computing */
 
@@ -115,6 +116,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-- 
2.34.1


