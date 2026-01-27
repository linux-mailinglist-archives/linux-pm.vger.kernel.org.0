Return-Path: <linux-pm+bounces-41516-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CwjFlpyeGnEpwEAu9opvQ
	(envelope-from <linux-pm+bounces-41516-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 09:07:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AE90EEA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 09:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6BA63008769
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3B27FD4A;
	Tue, 27 Jan 2026 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGsfWoft"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18A225775;
	Tue, 27 Jan 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501253; cv=fail; b=CoLsoWaI6AgzS80x0y4Z4yR6k9qmHLXuqzL6YaiTjKlcrfls+2XZosNZUCLf2Vs3eH7qSHAt0dkw1FnphMrLYIACI0qBFwqFgNcQOgzlHSSWKynAyTJZhI27jCpDLtqKVmGt/YKZYleLdUNhyVbpYNZVQhq/Xih0hp/lxSB5hcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501253; c=relaxed/simple;
	bh=qgeyC7g3n0Blh4eYXkoay3vJNz60xO0BOxFuZsZUceI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NCn6fETQukGAt9gwLI/tLme5MWNgsCGCFmzadfEeeePlHIxznQZewt57AxFgOLo74PBby/MYkAq3fKatG9Z9JLD9iyfdK3qXGjF+GxbitK1RhopimHvREP5X43ugaQuzrfWcN8Yq7Utd1ZR0X+q7hHNFaiDNpDEEMiFy7JMCPpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGsfWoft; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSnAZN6Iau8+Kp6uAUlmubmH9klxrZAYDpOOBHgAOx4VvWLvnsZJ4vRVZfbqQJWUmBWffFm9pah2hEKT/cuwrNLAmZBFyzCHVgOvdTcVjp/OFb0stnbXK1SRfOazwchzTuDgpUTCRjtkI36GdXCP52gIjnbpxakmLuCr+vhyQJjPjJIVgNONuyqAD99AwHHLScKc6ClqslfuGppHxrXKqk4a4WtdKOiPifXsEQ98jy4S36WzRsMeyq0y5wNtasdwXpOODyleXfmEFoz5KUB40C664oI0os6gY9NStgrEROF0OIJvnA3hIYhhiMf8XSxJYsNDX7+DhjeYZJQbBebyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBd9iAsdM0uDnGnSqriuSE9SRmgRVRur+Y8Lpy/FyVo=;
 b=Q96q6hMRHPadSupg3ezTxPHhwjPkB4ezWNsoeqzIDOHSpSev3qBa5EoEo8APQ2CSWviJwezS1qzopzIdtMNNxJ+nwzL/KjYMXwJQiP/g5+oIr6tUSJhj5hWAAdxVKZvqPNz1snql/JyemRY/GN11r/TTb9ByPaKxUlJvi0uu8nkzPHF49DywyGF0js+iLe1LLus7W8BfsWWD6LokOp5KJDoCMwNeNaVbt/ILzjZhhisdNMU2Y0OHuR7pVXBdbagxF8sX6/R/7E8hgAyp7S5ojyYj752KKrlMUXvXSfXeQYqLGdCxGLoZmHhmnRsjbgGXzF3HdzC4EgaTtXj9EAD7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBd9iAsdM0uDnGnSqriuSE9SRmgRVRur+Y8Lpy/FyVo=;
 b=DGsfWoftAog9bJq3oYUfDT4/6UQ3iwlU6NSRj+h5uaHvlrpPRebWV+MAUPypJ/j9j1yEZMt1dGYYbRxWVpNcdGOP+5zJkDp1gVbkUbG6gVJ5YQUP96FnMW7H/rl/zJP2rJe8nJzCRYzn2miKJ7n54dGcYS3+831EG+THiQo3vINahXV2bZtqnI2O2FIa0ghIhYSyvwNiw2tUUkihpOwgW+Oe1vNRJkDpDP0SKIByqNBHI0esbctm8iTxL+RG9FY1SZpdySsFDNNDjUWbQj5UkviiXVTmWH/1Odmb+HEm+hjw5oO6qHM09mHflgHhs3lW3IZy2uQKgtHJDNICCX7YTg==
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:07:25 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::1d) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 08:07:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:07:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:07:07 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 00:07:03 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH] arm64: topology: Fix false warning in counters_read_on_cpu() for same-CPU reads
Date: Tue, 27 Jan 2026 13:37:00 +0530
Message-ID: <20260127080700.3565546-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 427c725f-c8d6-4d1a-bbb8-08de5d7b1b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f096rxUs+XVtb9etbe9dtpB6dUteQ949mbRFTpaOZKSf+8FENQ5F9NW9K6GJ?=
 =?us-ascii?Q?LCnGxSSwZlG4ldfck6urm6947oAzeGwB+49qTLpSk+C7HqPURMpJOzFpFp8h?=
 =?us-ascii?Q?3PYeiq4f1fuFT6bTIzmgNHr/ZCQB0Jm210xOW4RMxs+cNHViRMdbhxd9dlPk?=
 =?us-ascii?Q?9yWOKB2RacsSWfecNsya/0IBM+wtIqDLMVIsbc+UvtL0R0U/jy3c1VSG/em/?=
 =?us-ascii?Q?Zx/ZUaKfY9RI1HiCBNFaEI9Eq7YCjMm//+0knDpq8JmeQEKJguaEYiC/TEIp?=
 =?us-ascii?Q?TC9I7ZTHNarLLC+gn9lAKoLX20xYPP1ZVh/7COupt+XElROqvzZQKWe5mkG1?=
 =?us-ascii?Q?17/JoFn4KGNVYQtEux8fAkrRbL5yd2ZG+7J8MR+zS/wLHEkxbiMhMNKtV6eX?=
 =?us-ascii?Q?N93Q5EVU8MhysyW1fF/V73+n9jbK+Ice/p4qIVoEwnZtb+VZXoGtHi8ItzFB?=
 =?us-ascii?Q?lCjAaXbf7qqpxoUZl3IXgP9lUs8svO9VuP4IO6LmhdylECS0Awri9VSOO8Zj?=
 =?us-ascii?Q?o5lTRJTG3cKQRL7TRz9f2wifs04i6t2wfM5beOmmX3pKsAJKh6Cwm8au1Tuv?=
 =?us-ascii?Q?xRyHpyInsG2Y/CPgPFn+2CeF1VIMP+Yq7rWhskWhKJ2Rn1/HieVIwBilOnQ2?=
 =?us-ascii?Q?Sm/SWKfYEVHQL2lqlOzMMueGwPglgxWgy9o/ao/m2SYXQMOFJISp/cV9h9Hb?=
 =?us-ascii?Q?TF0+QDvhL1k/j7QmoorLoSfehe8eg1pFl22ce/IxebI6tfckd/jnR10mT+m7?=
 =?us-ascii?Q?4IgQH+pMFTMUo7lHnmqtgwKKGBq3UG67eCs3uvh4B0bwLcnALi3WBTr55DZx?=
 =?us-ascii?Q?Yl5bBkTOuLfcaslghPAyj46OHuu49XdvzI9X+TIfy4qzIhd8gtTMxKepgd6C?=
 =?us-ascii?Q?bYUernUQ+zEio2860zIHoNFN8/fNkcstBsXqFgfLaJFf5AWrhQlg/QOBmqoK?=
 =?us-ascii?Q?TEhrKZlp4nJnizovhHcw2dXwCf1Us8/jJz2XvMkGjD0lhfMob3L6nwgvypqw?=
 =?us-ascii?Q?FUvsYOHlcBEjpg3OlhUQlbhGFm8yWb+oQPfb6PKde6ckAESal0hoRk6rgc1o?=
 =?us-ascii?Q?rKBDWlr1E5zVtUGEXNwJz9dqXVAK6nzCE058SISCvQRvVxX7ADGI7T8LbC2W?=
 =?us-ascii?Q?Kg5YsADq77KJGr+B+1JjhclHq8J4f5+Gz3+OoSAJfsE0xd5KvWmTP9y4RDCm?=
 =?us-ascii?Q?QyFVDo84MJ3f7e63oNd06Gwwp8srY/p7PShY7VY2m02obO+hWxbGSFmHgDIq?=
 =?us-ascii?Q?Q5Oq3JqhlsANNbfRlZIteAdUdSDosLD+6Kt8moa4V+Lwc55gvUlXfvO1EnWv?=
 =?us-ascii?Q?tS0pnSbxeKRiwimNRZ42sOvpDtqwAM8qGI1FLXzPE8uq9RbWnjUYSb3gVzin?=
 =?us-ascii?Q?fqfmctqeKLNEMcDtvbqZwrHUX2lbb/P4+gKNyPHBz9pvxnFnZXQo19Di700z?=
 =?us-ascii?Q?mBRMsmmmklVb8HQ/ucOoq/AqSn+2Z1aJyI52taynRmJ4taKvP39iw6UixIBf?=
 =?us-ascii?Q?811ZK0zlKex23POYYESnsbcSg9DSLy4d74l5GlrlGUOoeJ8CXebMR4FJ4pe7?=
 =?us-ascii?Q?sodNDp6r+yzmV4SWYu8wdM3CmB7wZp7U/EqzzJ5H8T2wfsB3ViwM2ii5fa+D?=
 =?us-ascii?Q?/FGWk9Ja/Pk5RDnga4l59EIJE/LRB8m2t5qFhH6Zuea7N4PxvKyAIxv2Sbxx?=
 =?us-ascii?Q?AbvSWiVDKIiBI074SdbuDYv5Dv4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:07:24.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427c725f-c8d6-4d1a-bbb8-08de5d7b1b2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41516-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C71AE90EEA
X-Rspamd-Action: no action

The counters_read_on_cpu() function warns when called with IRQs disabled
to prevent deadlock in smp_call_function_single(). However, this warning
is spurious when reading counters on the current CPU since no IPI is
needed for same-CPU reads.

Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks
for non-PCC regs") changed the CPPC Frequency Invariance Engine to read
AMU counters directly from the scheduler tick for non-PCC register
spaces (like FFH), instead of deferring to a kthread. This means
counters_read_on_cpu() is now called with IRQs disabled from the tick
handler, triggering the warning:

| WARNING: arch/arm64/kernel/topology.c:410 at counters_read_on_cpu
| ...
| Call trace:
|  counters_read_on_cpu+0x88/0xa8 (P)
|  cpc_read_ffh+0xdc/0x148
|  cpc_read+0x260/0x518
|  cppc_get_perf_ctrs+0xf0/0x398
|  __cppc_scale_freq_tick+0x4c/0x148 [cppc_cpufreq]
|  cppc_scale_freq_tick+0x44/0x88 [cppc_cpufreq]
|  topology_scale_freq_tick+0x34/0x58
|  sched_tick+0x58/0x300
|  update_process_times+0xcc/0x120
|  tick_nohz_handler+0xa8/0x260
|  __hrtimer_run_queues+0x154/0x360
|  hrtimer_interrupt+0xf4/0x2b0
|  arch_timer_handler_phys+0x4c/0x78
|  ....
|  CPPC Cpufreq:__cppc_scale_freq_tick: failed to read perf counters
|  ....

Fix this by calling the counter read function directly for same-CPU
case, bypassing smp_call_function_single() entirely. Use get_cpu() to
disable preemption as the counter read functions call this_cpu_has_cap()
which requires a non-preemptible context.

Fixes: 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/kernel/topology.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 539b38935182..57b71f403007 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -401,12 +401,29 @@ static inline
 int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 {
 	/*
-	 * Abort call on counterless CPU or when interrupts are
-	 * disabled - can lead to deadlock in smp sync call.
+	 * Abort call on counterless CPU.
 	 */
 	if (!cpu_has_amu_feat(cpu))
 		return -EOPNOTSUPP;
 
+	/*
+	 * For same-CPU reads, call the function directly since no IPI
+	 * is needed and this is safe even with IRQs disabled.
+	 * Use get_cpu() to disable preemption as the counter read
+	 * functions call this_cpu_has_cap() which requires a
+	 * non-preemptible context.
+	 */
+	if (cpu == get_cpu()) {
+		func(val);
+		put_cpu();
+		return 0;
+	}
+	put_cpu();
+
+	/*
+	 * Reading from a remote CPU requires IRQs enabled to avoid
+	 * deadlock in smp_call_function_single().
+	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-- 
2.34.1


