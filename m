Return-Path: <linux-pm+bounces-9112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F271907B08
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10A5B23703
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB8414AD19;
	Thu, 13 Jun 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOj1f0Md"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCF14B07F;
	Thu, 13 Jun 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302754; cv=fail; b=Ajr1WjaiGENLS6+dNIpAe76Sd3MNM3O3rDs+aVr4dcRfZyvzq6AO8qU4gYNyrDl9v7VRbX6xUOsUas/EDAEqxMDqCR7U1HvezPk8+LpB3/YLqHmb1W+ES356e3PmpqP574YyMMxOGfjE9wcTghB8tq4QJTmtRbAZ88MykCuBPvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302754; c=relaxed/simple;
	bh=Sq7T97eYF/tf+lQ0VywpZcSaLF6cYPR0rgHDdOkxMjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djuO/M8fhZWdMJktD5JvNI1hSBhsCzxNbORIIgHyuv31xG72bAXWiEldTYC0HI3q/6EwmwYdJZzPughkFfjxde2qg+0FNPMCMp0bZmw/xBwVgugBcGf2sqZSniUuv/At9f+jk1gprQQHZHPF8RKYQpDoeWxXiwRB7yowSmjV3o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOj1f0Md; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1sd9O42AdhbNTzKNuqGmHh2Nn4f40X+OseEjPmlgOytnIJK8mtZ0WqJjyy5rdUEEYzEbMxpe/L4qC/vPGslsiuzGamypl79SfA5Ix5EhUweH3KeecFuGEraRHuQJxB3URN5TphiY2VIAiUtgzU/Wrv7LcE795OaANeiiPnjOKB3JE9mtAHaB+3BkhsYyWFSiaHDRvNvpQvJWolPkJXql6IH0+kI93CqJ0Gao3G1FOXzWynbi9pPh2xeiOMiOSbf6xxcPqjhG2fOBEqohO1ugDXU8kFpYB97A4RVxiR58i/VBcpjUtz06TNa8kub9HVTy276zWel9qMzln+fY9lg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vradeM/yOEXyBdiiMbEOKNXy9nIsAdQb7sPMO3R7RGI=;
 b=kkQuW2zKN4zGXuXGQJyeJcDjhTEF/FbOXX9DT1OYG/3I5GstYRZ59ixKqFfspyEv929CvHVWzC8Stx2XiW2MjoepLLGBhaRufDvOca0cGWl2NjzeV0HX4twUUk3hXY8Vr85DKBEayM3JrTEZfkAffoC7RiJTwdli9hTYjCadYLgctyUgLDHKsGj+f9J3TyTn20O4sQT9GOIlb26yNTO/po/HMPFQieV2IA7UW6yvPEhqdBcnGbBAWh1yyBqNhdrTkSQtpAg2Wak7DTASrhnuTqwmptNxaW8hEzWXirPcrL6iyapXo24MXp8XqhBiBJz0zXavWynuiUmGKAlDR3nZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vradeM/yOEXyBdiiMbEOKNXy9nIsAdQb7sPMO3R7RGI=;
 b=OOj1f0MdGvEG+6ROifgPjHgVV8nTn21fXRk/NDU6KiXSm/Q0lcgiPw3GOLSDh/LBtqsv7uSLZ2j6y90QXQxvhQftiUBUvVeHLOtSRm61rQzZwjn+W5rT9p1S5E4tCFCMIG40AMeY4KzVf/xc0HV1SqzniKjmmngIw4YKg5Vf9hY=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 18:19:08 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::36) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:19:07 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:18:57 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin3.li@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	"David Vernet" <void@manifault.com>, Julia Lawall <julia.lawall@inria.fr>,
	<x86@kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 04/14] x86/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:03 +0000
Message-ID: <20240613181613.4329-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e246c6-4498-4d4e-3bf1-08dc8bd550d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vJQtjhVjK+OjBdbS4kdrzEwygbFSa+0tn56caq0YHEFyowed3oYFyaWUFAvV?=
 =?us-ascii?Q?37k4VeAX+ky9D/PdFg2juDdHIH6T3uav2N9qfN7mNCCnYtcLC+PcLA8ib/sS?=
 =?us-ascii?Q?x5fIOGc6+EvTrp+LSXwIHXRu7109Sl0FJjGPLffMdhsqOcMY8N+8Lumb7cWE?=
 =?us-ascii?Q?YIi5ovQ6qW7vuxQypHjLfq2WrQqCeFqKJZW2+b+GYbXNH4zXrcwKMGJq46zu?=
 =?us-ascii?Q?nln6e1XG9P4f6x75Gqwq2BeraMZS+QKzWSgtGdteQauM4vXF0VXyT/hUB5U3?=
 =?us-ascii?Q?2DTE48L4+NDfJu8hZy/uAXmMkLjHU4xcWTDBpPkjhcUmIWujjGtde9ynjzv/?=
 =?us-ascii?Q?/CxzIUyKWJFriRcRg+hbEAk+gk5QTAZ7pU1z+W1X1SrfSUSNWt5WtWJ2GZmt?=
 =?us-ascii?Q?8kIdcynrATSK7658tr6MVF8LCDeH6vQE23zYvcD1I2Spm550HuIeUcbMF4id?=
 =?us-ascii?Q?wdDHt+xzWFnvlUPmGQt0bHRzJPykxWWJ6uf6L3PULZYUwmkZKleqXQwYl32i?=
 =?us-ascii?Q?jHRVTWfqc/j3VI5H4abJY4wJw++okiJiejui3mJ5jeoaLGTaxB/N852E/OZ2?=
 =?us-ascii?Q?4QR3che7Y5J433g9qU5mR5l/2HlOSojeAobyXEARfhxi5bgqNbnTEBOxU1Fw?=
 =?us-ascii?Q?CjMRcKslP5VJAacgso1wrLhzEPvSeYH4nVjoAc2AqiQGox3x43J6SHZ38MZd?=
 =?us-ascii?Q?990QN/1Mwqc2wKfcV5ZkPxeo+gIZjN2+PU5QkmsVL+6t8Jcri8uCplBnu9o7?=
 =?us-ascii?Q?HbtJVpbo3OfSJ4+ujZ4OW354JEqOjyZoIMCpfx6PC5h8rkZTNVHUdbi4IUVW?=
 =?us-ascii?Q?O7BdDE50FHwAxO96Ljn/rFXXRvWZdqchmljpwHTjfO+xCov7pYbfkmcEoE49?=
 =?us-ascii?Q?j6csjZCAwGZRmtggrW+jTvHq8lw82lqteHD3/b36h4UcNgT6tSLJp+iqvDe0?=
 =?us-ascii?Q?Jbc0NSLgwI3qSr24WhtDpMFwYyYcOxwcI8x6ZmyGZ17gjdu+YlL5ln5/sVYi?=
 =?us-ascii?Q?CVy1eusL3sglQZTyRv38bJkyy2xao9FU/RKQx3RCl8fmbLo8QQxQd5y4mNQB?=
 =?us-ascii?Q?OuwSzU0X4RawGyODwzdITJLI2B8n3oen5AASwAWZ6UyB8L9xzuL6dOKnyNfV?=
 =?us-ascii?Q?dvpOJu+b1IRrn3Px0aT3xDx2MTae3h3+rub9YaVWXuLKk6N2K/qY/3lCDppF?=
 =?us-ascii?Q?KFlDDmShqO9D6Qhbzs3EYKmOjzqZtEvOGVft+C6ESQALyz/2CuQeE+p9OTxc?=
 =?us-ascii?Q?ywCwxMZuXNxmZG6m0OIDrFq58a2RKjEPRZPWVz2+nlrAwemiLjFHmwCzLkJd?=
 =?us-ascii?Q?y69b0z8sjwRrHR0YkHWi3SW69ZmOxGOE3VcU9uS92YtW8/NFdWLmYf5Rzqz3?=
 =?us-ascii?Q?kWXt9/gI3OspFfdXqbOr7CTSkA4x9VFOkUrfkA2wUwPu5ZZVTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:19:07.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e246c6-4498-4d4e-3bf1-08dc8bd550d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Add support for TIF_NOTIFY_IPI on x86. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

IPI throughput measured using a modified version of Anton Blanchard's
ipistorm benchmark [1], configured to measure time taken to perform a
fixed number of smp_call_function_single() (with wait set to 1),
improves significantly with TIF_NOTIFY_IPI on a dual socket Ampere Server
(2 x 64C) with the benchmark time reducing to less than half for
100000 IPIs between two CPUs. (Note: Only WFI idle mode was left enabled
during testing to reduce variance)

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

  ==================================================================
  Test          : ipistorm (modified)
  Units         : Normalized runtime
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  kernel:				time [pct imp]
  tip:sched/core			1.00 [baseline]
  tip:sched/core + TIF_NOTIFY_IPI	0.46 [54.88]

tip:sched/core was at commit c793a62823d1 ("sched/core: Drop spinlocks
on contention iff kernel is preemptible") at the time of testing.

[ prateek: Split the changes into a separate patch, commit log ]

Link: https://github.com/antonblanchard/ipistorm [1]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin3.li@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: David Vernet <void@manifault.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o Updated benchmark numbers.
---
 arch/x86/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef1..640ee41b8c82 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -89,6 +89,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -112,6 +113,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-- 
2.34.1


