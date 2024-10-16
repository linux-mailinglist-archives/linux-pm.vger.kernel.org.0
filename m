Return-Path: <linux-pm+bounces-15776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A399A9A0D2D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A9E1C21883
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1019209F59;
	Wed, 16 Oct 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ho90/ADn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017514A4E2;
	Wed, 16 Oct 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090089; cv=fail; b=HPabOXfa/hbDLSVg9SB4tB/+iMJXlvR0x2+BIwonI3Bn3m+g1veKbw7JEeZNGtt7c76GrUmrn99UV1eKIa+/xDSq28pDD+iBlFL4Ezic8Mk4HAsz+6jDXDZ6d70BMvT+yyBvrqC77G8epkx12AKQdtIDftjo+cE8B/4/2ChtTSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090089; c=relaxed/simple;
	bh=XXGVR4oMU+vnVsxoeMq9s2IqncjCUyyQeRQmJCs4Olc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UA/FSPsVZz5NOl38qZ8jQIPuRhj7M6+dNzjhPf13UjJBJ+Lfjwn+Gl18ps2MCDWM4SXOiC4/wJjqBDPYvklOF1qj2YVEPRdWLiepVHhLhPaZTthR4JOLaSG1xW/E4nLP3AGUDcoDrohTN9qSKwu2wGbOWkXmVLY9EifDbQMo7p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ho90/ADn; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBJvPytShh3jJX6bnen0Ee05QCeaOJBht1zKZXq6HRB5/4SPCbAVC3ryckjH/H03Nt5PbfketdvQ0aRQ77wRRWU+pOo9lz6qPObk1/2QpBi2lXNDnAoQtaBMVFTgJ/XIqky354c2iDgvGeK9Cje2heWvMm6sg7bvUmS6St62CZ+yvjx8b0qVIp3WnodMr2lE23ffpajxOzQ6oODxNRw6y5jGgw9X1Mwdj7UexVlAaqhF7d1BAdhcy7T7LLojuIUtyyZywiqr7WWCQ3Ii58jKJXMI1DpEw1I+CQad8EprtwQ2a594NKCQSDbRmXnJIQ45LT5xSNZfGr84IxbLklgLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sb7CJIo4cG8jRWf25sjzLUHQFtap6osLkjKtKRHD94=;
 b=s8LKqK6ocl1zzOQRQqv9+xWw4a1xIiF40vv0Ay1ELq180DSDppq3RbfiIb2vgCMjefzFxbghXz2q9dFFMVnVg+KGeZrr/nuMY10CG4zKs/b74vvG1JAqD7PyHOkXuE/J32llrLFPx9hBv+oQtK8X8rJUCCkB3N/+ZeKsjynjY6ZLcoEcYSPqiei2jDyN34p4Xn1htxBjjLZw32tQeK9JpdWqZDozTMOFmt2EobGjJnmns1qbPNuHkLJUQUcIbyUX2JH0uhaAYBPIAVeQvksXRd87QiATd3SmdQhV7vUmCBv6htAZ8FeGdzmmoL4UxWwVnZY4WRukjCzw+ifynIMWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sb7CJIo4cG8jRWf25sjzLUHQFtap6osLkjKtKRHD94=;
 b=ho90/ADnvQmJZFgSQdbhNlfUTdeQX3eAOxb+uIjc288KBT3Q5gvE2woHrEcMVb1mXwCksmM8pRFgtb7JAh8hY0XdelVOikq553zJXNqphVgNhrBXziILEYghOyqFBVQg3qkVMdLs7EtazK4nCyo3JmSlrvBvg1QlG6yh4oEQ4Js=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 14:48:04 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::4) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 14:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 14:48:04 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 09:47:59 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 0/2] cpufreq/amd-pstate: Set initial min_freq to lowest_nonlinear_freq
Date: Wed, 16 Oct 2024 14:46:38 +0000
Message-ID: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 7725879c-7b68-4d46-2bc1-08dcedf18a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ifz9ckyhO4Q/1FuUn0D3JhJeca/oSkt4PLWHObTKrPhtPnAebqtfPTor/GHc?=
 =?us-ascii?Q?Tm8e8es1gC8TAe+tlvDIM4hhEpfRgsLJr7ikfelfbKenSEYLr7Zd7x64eXti?=
 =?us-ascii?Q?D9gvsm5l5GtCLb2Hz4x8Mkl/ZMiR3Q/TQ82ZqXaGDRVGemmdOk6YBQNrWYDG?=
 =?us-ascii?Q?bSAJRNy6Bai3/gltNRkr6WuZrR+HeSNpMuYnps4dI0+aExuzCp1t+KDY/rFq?=
 =?us-ascii?Q?6CJSMSaAPUZwJFDwSfV05xJ/B4Bf5Ox3v5inZaKNCSeq/quYcmNYwG+A3y/6?=
 =?us-ascii?Q?hXNv8BaeUHbmd8x+zRZIqsj+atvZS15UPXfvd4X8wzOYmpZxmtcQxQ92328U?=
 =?us-ascii?Q?w9MDkS6OiW7qoxuCfTZ+7hSp/TNWeQPeQKGrc9CWp+z+4I4HcJwgJTcg7n81?=
 =?us-ascii?Q?Mn31TGev8sLKfGnxjDj+AMf4hMJCJGrE9E1WXhNCzCBt2UxW1JtkZ9gpgBmc?=
 =?us-ascii?Q?Kf/aRZR7sB06JyTJKHPGQlRSECVi7Gu4GIabk8ZblK4GKJS+v3xU4mLmSFxE?=
 =?us-ascii?Q?g9wk42PuidcDpMT1Y1xdzfdFYMVtV0gklZ0fA0O2Hm0R7puImcOBHwNRAeXV?=
 =?us-ascii?Q?EPYc5E91kni9TEm3OoP8tktB06rmM9bWsuxDeAkybkWIrWTOFSx9w1IrOyp6?=
 =?us-ascii?Q?tMwuhbcFIfqRyZ6vjdKW0P4qMDDdH9BK5k5+5IPgvr1pMSOzigWz83D0Lt7i?=
 =?us-ascii?Q?8FWqVkcjTqk2aRZfYfNNrrCAPwSFSjLgASNjGFpKUI/Fw7CU8D27v/LVZNYD?=
 =?us-ascii?Q?Zabn/i1vBvVPEO95BH46r184R7dllJJuv1GZCZGRDvqJiczviie7i/oA6UEj?=
 =?us-ascii?Q?iRwx2BqbcOaNfyxTyHlHXdijMKJdyoOzvb9/41tsqWP6AbNLLTXazHcr5Vue?=
 =?us-ascii?Q?7lZq5RklPNTpOre7oPVD0NAWTMEPi+IIMPlJYLmNTYrWHoPkQzl/slIeddvQ?=
 =?us-ascii?Q?+xyzVgXH4ivWdA9ULGEnci7IvMH3A94vK89zvqDLMrNdo4mbq8XXZ2tJOR2g?=
 =?us-ascii?Q?dfMJP09KQoQ+otd4CI2nhxfM8qNhRCm7+n3s6Ki/l3ImBvApepIuf6FChYIz?=
 =?us-ascii?Q?mMS6TJy6Gyo9se399ZDB0CpEkNXESad+itsFvPacw0DhJGu2Zn0XJr1yXk2e?=
 =?us-ascii?Q?KY9tLcB8zeAoKKR02BwlCtSZE3MzWDHe7vx/shpbXXJcEHVzLwGGgDWZdhIJ?=
 =?us-ascii?Q?Qk0zUw9USDsK6wnpsOfj0Py/d2o8a2CifowneROiuxqr03cP5eXLQhLPe0p1?=
 =?us-ascii?Q?mIHa0dchXR6kMArHJXBbn7R3ZVFZI1yNyYRkJ/+R832rAUjYeGShppnDMz5s?=
 =?us-ascii?Q?m69TQCpKcCp0BO2GV7eu8o50zp6aGwnDoD+L9Ol84Uu8JAcNJ8XH1Yi/pMsF?=
 =?us-ascii?Q?0znPJ/7wGxB5Fr8AUWtNLgC4yvS5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:48:04.0436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7725879c-7b68-4d46-2bc1-08dcedf18a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

According to the AMD architectural programmer's manual volume 2 [1], 
in section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described 
as "Reports the most energy efficient performance level (in terms of 
performance per watt). Above this threshold, lower performance levels 
generally result in increased energy efficiency. Reducing performance 
below this threshold does not result in total energy savings for a given 
computation, although it reduces instantaneous power consumption". So 
lowest_nonlinear_perf is the most power efficient performance level, and 
going below that would lead to a worse performance/watt.

Also setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems.
In other systems, power consumption has increased but so has the
throughput/watt.

Our objective here is to update the initial lower frequency limit to 
lowest_nonlinear_freq, while allowing the user to later update the lower 
limit to anywhere between lowest_freq to highest_freq for the platform.

So, set the policy->min to lowest_nonlinear_freq in the ->verify() 
callback, only if the original value is equal to FREQ_QOS_MIN_DEFAULT_VALUE
(i.e. 0). Merge the two identical verify functions while at it.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Changes from v1:
* Modify the initial min_freq from verify callback, instead of adding a
  new callback in cpufreq_driver struct. (Rafael)

v1 Link: https://lore.kernel.org/linux-pm/20241003083952.3186-1-Dhananjay.Ugwekar@amd.com/

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate: Remove the redundant verify() function
  cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq

 drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.34.1


