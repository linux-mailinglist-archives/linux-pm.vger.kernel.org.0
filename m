Return-Path: <linux-pm+bounces-43116-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOuZERFwnWk9QAQAu9opvQ
	(envelope-from <linux-pm+bounces-43116-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:32:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1A184A50
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36D53011C54
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8F36BCF1;
	Tue, 24 Feb 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPIVHAbM"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49903283FC9;
	Tue, 24 Feb 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925259; cv=fail; b=kFAx46miyxZFcK5eruh3Abvjhsexd9zKr2o3bzD/Qdzh22OP14LtVMjMe0QkqKR93mdmiMSw1Wy+G1sWN5vYujlKs07Nm57Wx280U8Bpcw0Af9hyQ8UIgSr9P8c9rNhEWJWNYYzViaYcHvqtyxvvAwdc8gzUCQL6Lvozg+/iD+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925259; c=relaxed/simple;
	bh=bzcu6Eul1JdREhxXFlrZ/4i4Sx68WfE5ZXlal0gpxUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTRT7nB1ST4BvVBxJbcRDhWYWHb5gXtx8MWyWLdQ+Qfogp4pwE0n1Dk/4/pK1C+IYIco+tkjGbn7b2aVmoYdKM+F2EJyriM0P0GyjIEcUDkif7HHRsOwfGfd7fPrMYvC1juTOINcNI1tAGoZichjbUOU/uDFcjb+Sq1TYd7Edys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SPIVHAbM; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCrsDlfxQ1ru09q4Af3SD23cW3RXImt5mJ/NZ8dAZWNmHnytPc2yALIrlXKdXjR+GN6bUMqE0Rw+mB4nvbPzTN3/dctrca66kyByu9446UwcsynJ79YlWu6oBZ6YpwBl1r+wwqGMJSZUrSh4TgfsREHGA7EXuyKmHkvIvwYgBuSa9DUnaGi9DLqMjf8bvFAxJZaBeepVy1SE+Yc9Z6A8KZMhwPpdGqUNkwdYYp/z8HNsRw3IYh6Sr1jxlsUeFYSDK7N6my6E2LMfEvr3e9KkNf8hWtj1yYIIJc3aL0Ma543rNLWAGcO0PWYf5QHikA2GMrL70r86t3EoYQLPN4UHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0fq8jNFbhZQL0ibJNOBN7lM8AHq1zH29Kp6RHw9gMw=;
 b=lRBK4DlMegWAVbLObNluaCg+wOg7h/izrBQgt1U3MUJ4haKbfj7hLs37ewUEgAPtA0EwlUG4LF+AwGFffIluBYs8gFvLytW2rCyeIWb2GcxB/WAql4sQvWRXe9raYFLUUoR0oSqWkWk0w2u5op0J5wU+mtETlyQzd1OiYgzZnyn7ht3yWR8roHD+vzzVoEj+xygRWYPl2UhoVpuwRUS5JY8pDJhiADsfFj6KpUg8qRBUQIScP3UzSAyH71WByFtRkspryKzJSbH2MKU/RHrB81s9Qs33OnN4EylUdj2OACAASK3G+PnRxSuPJXF2p8MUIBRrJoXFD86vq9NPn5k1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0fq8jNFbhZQL0ibJNOBN7lM8AHq1zH29Kp6RHw9gMw=;
 b=SPIVHAbMZNkz5Rz9DmLmjRqPRmsZJIHYBlkgZXihnIds9n/IhreFehiNf//C55ATahcgfod/XZbDF/9v9H1egu3NCr/H4WW1pYrqEWDJX2COhxGJvdteyyuFUsK/YP0OH3nWXVy9eSBOD5C2GBYl7s40fljx3A5dVHY9dQmFWBxDHUVYzDN6YaRfcqlA2SfNuPWu5iuzeO1q6W4DRGEbKApRRac4CstmJKveFe7bCbHIUfy5u9yNafL/aQuliJOW7W0uqLhr7XAGxaYzauOh0OoF++CdSDpuVfJ/qmiuYBDiNxUcqp7pLVBDOq4dJCfWTwD/RCq33fe2FqQ5aq6Hvg==
Received: from BL1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:208:256::22)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 09:27:35 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::af) by BL1PR13CA0017.outlook.office365.com
 (2603:10b6:208:256::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 09:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 09:27:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 01:27:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Feb 2026 01:27:21 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 01:27:16 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v2] arm64: topology: Fix false warning in counters_read_on_cpu() for same-CPU reads
Date: Tue, 24 Feb 2026 14:57:14 +0530
Message-ID: <20260224092714.1242141-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: acbb0c6e-151a-4f1f-c35f-08de7386f142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdLmABD3lqXznGKZUgHHX2S/2d9XUu+06X5aBj9o+JBb/HqaBS+KC0Np2XUx?=
 =?us-ascii?Q?8Mzvm/leNi14/90ZEoD2EfNrJwAoob94PXgsSOGHlaRK0SRkmUwDYDw6X/xU?=
 =?us-ascii?Q?g4Q3BeZtFTg37i1dhCKqlaJddILqQCTQwF73yZkWm/gtm/60pYikhudBtQlv?=
 =?us-ascii?Q?FnHBeV6lOJuDwuTVrRGzfdODN692FGeURj8NxIMO1zQ62Xtyheuf4HVnfwZ5?=
 =?us-ascii?Q?7wekT6Npf+YWlKL3qMht2OASSeOO7P/JyDj57ffFQATVuatXXgtHGzDqq+bq?=
 =?us-ascii?Q?wZJWuEVFA2wmfK/uy2WB3bUIuuMwygNi9+r1JVCrVAobK3DhgwotM7iJSzJI?=
 =?us-ascii?Q?CVBKBSCwj1K834r50skzog3eL8iOn4cU47KrGXD0EWD8xSVjxNTDE94pV68w?=
 =?us-ascii?Q?kaxJ2in1pnYDuzaulZ6pFGhTCL7XDStDOFpsr954XeQdOgHmuwrX8/cCIaQ6?=
 =?us-ascii?Q?Ci+r5kLlPOeIOob8N5Yvd1gjUXMuV66iN173fYfzk5ZTzFgOAtY9sHvuppaR?=
 =?us-ascii?Q?8Ukmcz5qeXbtp2jrg/lt7OodNvUGKQwbhYrU3Whx4RZsnsFyZfEMwBD+THUh?=
 =?us-ascii?Q?c3NsXHy3GYTDyqmc7cElwmRp51ze/5TKZjemJTr2K0r0iSGV0YUrXXEeB5eR?=
 =?us-ascii?Q?F1W+SAZKUqupwzkxqzRZcCMg9ERuhBaHJPfKeS8ENWdUGlD+VvHvlDPB3RGo?=
 =?us-ascii?Q?5Gv4u/Eg3VaCwk/GCu4lmlBirZEXlep2oR+ASFBKIBeDKEXDG5Alrqy9fPOG?=
 =?us-ascii?Q?rhFfBPWqFHMOOxMFGS/O7hUZFNiZckYby0Odg4pPWwCrbjG/XFQzQNzW/VIO?=
 =?us-ascii?Q?4ytppthjQkMPso0J+9CqBywiODY6614GdLURXX6+KqeAEmL423Gxh4OMsAA4?=
 =?us-ascii?Q?iphgYXbpWiWiIEmVGtyFLcoOqq2K6xy1ho12IVN05juElII4MvhhitAravBP?=
 =?us-ascii?Q?s8N5+embnSYT129kYE4odGBa6SrxEPPz4sfFdmyJ3SqeMXyGeW001GbubKvi?=
 =?us-ascii?Q?gc8ghw543utjZSBFRO90t1F6tHskbHRF8rh9IW7TPKX7O4jobPL2p2L89p3y?=
 =?us-ascii?Q?3NgHWSl499sl/wn62V1/lwj1eOsdJ0VnlDSFvI9uXMi+u0jagR3KXoJiXv5A?=
 =?us-ascii?Q?RkkDKb3IDcxDuLXIEhuHnioAeB69SFBzjVNIVvPPtFSjtFXg1oqscLNPAAm0?=
 =?us-ascii?Q?QPCjojgQXnpm2RbcqNv8gYk6sd4WQb2pnqVxHXEGA20V2UZUDQg8m0I2DNgK?=
 =?us-ascii?Q?WWRVF6AelmheWDhsJKMacFkrr8FOSHPEBm5elMQkkFOkYggb4g7svn01FEGB?=
 =?us-ascii?Q?UFZA0ayG0B5kZrxwbQpB0GsvK1SWbIviKplD6feuBlAFv+qDaK5PRsqbM8rD?=
 =?us-ascii?Q?PdtEM/GZJjLokzGhmROnMqaaeyNAQr/g2Liir0HbcHs2eFaGwzUBb0sd+eCS?=
 =?us-ascii?Q?2bulZDFEyLqSfOaCNGSRNJ5Z1RNMlnRyUmQN9xD7M28y1f/jca4rZCO391rk?=
 =?us-ascii?Q?mrJ9vo+Rh1bwUVTwDZjGFYGRFyBgpt58tfNjwHLJeoSAgu3oHIN9ACHw/5Is?=
 =?us-ascii?Q?woWERYx1zSfE5ORlnSlzzy03s55tJzgvAfICVaEliXgQ70+jJdRGzMfsb29+?=
 =?us-ascii?Q?MoAex8yZ7MLQQ3iFknQGtjgAD/XMwbXud8jUvDmYN4A+R4cCvxX62RMV+4lq?=
 =?us-ascii?Q?LrlxNXbyOCUQzArmu6GTCUKf2D4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N2ANBq9QGPWjVp2ot5PghDaWnaZuL9Zut3oViwQY+xMEMMV6qhqdggsZ/ZElzj3TYnZKaLBWWYUe6rgl7F8xoVHyyCxZbwfJIy9ieHtDH1SHbINa8RtSyP8z9meAvrGpD6pg1M1qC7VnN1RqnAhCsTTfZwBkVLyugHckEnEwtLLrHVduCzP1yZxI0W68IlHWFlmD7v5cFJcW0/B9XSAXJtiYRzHZKTIYK0DF3gvcNm9sMtx3ojR6q/M4WzEOvId6Kh8YZdNAxqWOm3Dre1cja9Obxcvaqhxic0OpFuyjvd4y9xDJKjo6+bd0X5Xg5MzNyHVjli1zwx05g+6US4tr+ebcfs202RTf4jTYv1U3ng1LX3727P3GyfmFpV9rnMTaM2q8y63TLymu3BO34iH55o3l61EcMOHRumMk20wTmrelEIKQ05AoQFSi6kmr4AUc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:27:34.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbb0c6e-151a-4f1f-c35f-08de7386f142
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43116-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,hisilicon.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E5B1A184A50
X-Rspamd-Action: no action

The counters_read_on_cpu() function warns when called with IRQs
disabled to prevent deadlock in smp_call_function_single(). However,
this warning is spurious when reading counters on the current CPU,
since no IPI is needed for same CPU reads.

Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in
ticks for non-PCC regs") changed the CPPC Frequency Invariance Engine
to read AMU counters directly from the scheduler tick for non-PCC
register spaces (like FFH), instead of deferring to a kthread. This
means counters_read_on_cpu() is now called with IRQs disabled from
the tick handler, triggering the warning:

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

Fix this by calling the counter read function directly for same CPU
case, bypassing smp_call_function_single(). Use get_cpu() to disable
preemption, as the counter read functions call this_cpu_has_cap()
which requires a non-preemptible context.

Fixes: 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
v1 -> v2:
 - Rebased on v7.0-rc1
 - Updated Fixes tag to match upstream commit SHA
---
 arch/arm64/kernel/topology.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 3fe1faab0362..c3e883e99aa0 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -400,12 +400,29 @@ static inline
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


