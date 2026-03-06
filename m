Return-Path: <linux-pm+bounces-43769-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GuTMUWlqml6UwEAu9opvQ
	(envelope-from <linux-pm+bounces-43769-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:58:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872421E4E8
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C23983020200
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99533F595;
	Fri,  6 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ys3Kg2lQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE234B18E;
	Fri,  6 Mar 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791107; cv=fail; b=f4zoHYXuAJ7ordh8Shu2wNmxDq5nXWwyIoFHkEtCERA644tw8TzUMJArfG9vARjvb+U7RKjnieZgHQIPPrryl/WWRWNJVjBtiBw4KqXeVuzvTCW3sxY3GdYyh6e/nPQBu2j+SWCxV+q33Ikq+bNpFk4V13VifMJlhU+ntzf6OOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791107; c=relaxed/simple;
	bh=G0sWZn4hRD0FXkEhPxLQ7io1n3AWywtmMwA58syID8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EdQb/IJNeEIlPsjvZ984G8KQ0kd0UNZe778Sy9h6sTgJWkUyj5k8jqCZNEIjFBwIkoEksYG8r2KtoT1C5SV9AftOQnddhuKy307KmO3tRRdTtc7q+PXBvkLav4QRLV2FrrXV50gb76/3b+9K9ByuaZqjF06w5I+Ko+cixx7BfgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ys3Kg2lQ; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJL9VXCBwDjaTklSXoJIqUcBA13aIKo+qAMZlPgAsn+RaR5ZDS0/yiKdE/Z+KqJ1jvhEXt+jRC+Qn08OXt+e5LBDkba98EkZZ8Kz7OXaMt0HVx/+yVXldMXa6yKRF+DRzQsAY8k3NFT9vR6DjkKn3KKJqL+K1M751fvBNH+IvT5TSQe3k1gaI3y4ZlNhmtt40+JMnqKLqeaPfg3z8QkRbjHTszu6LFBvJOI/96lib+Fi+63Mra+kAzUUwAfUWdJLfn4+XlnZjgyuH2RoH+WZ6ak4inZOG2gA1E1VgLPKmzRMuemdo8JAcQvaNcfMMUpcVG7eD8QSR6f2cWPTBBdTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngfJA7uNR5d9xYyrtD6my4zEd+sUYkyHMCMgCZ55WBc=;
 b=qrYOvPTwedeAEcRCW/V6XyA4yEyt2g+skAfPyEmPDZrgKzzIZSSXTDSjpYxr8Fx4SCXlkJjiFBPtKJHpBTDTJrCoHeXJRB6XkrhlBWmYPgyzEAuXRzkzSuLyFLwN6sYO81dWkOKcDlKtdCv/QxBOcsYgWW6MX47r+Hl/ChD9yrHYQEYSKzKqJlBC5PdFjebLwaPKGCF6NtCOK4sbKb7d68xypAQPBJMS3pII5VuK84KDN2gubtpTxrm2MtXVJL9XGYqCjuFNN9E3zj0zeB7U/MXUqEb0erRC2XJf5ZZxEl+sF5jxlJSp4+MRqomIpMZLOMgTDfAWR/EGiLtwZ1E3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngfJA7uNR5d9xYyrtD6my4zEd+sUYkyHMCMgCZ55WBc=;
 b=ys3Kg2lQKgkUhEj7f1gZZFgIXx6gRSyRm13BibwO1tYW2eah9OLCAD6MJYP9LUE9IrmVTsjpeBD4MeDy7Wgfwd0l0fhqAdEH7bkHR9PeC7yWKpFOu+AWylTmivBucNmQefkp/3iQ+Z3hK3klN7HtSyW/yiOEuw7hpBrZSK/Skl4=
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 09:58:19 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::b5) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 09:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 6 Mar 2026 09:58:18 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 03:58:15 -0600
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 0/9] amd-pstate: Introduce AMD CPPC Performance Priority
Date: Fri, 6 Mar 2026 15:27:44 +0530
Message-ID: <20260306095753.17155-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8f5541-da5f-4fa9-fab4-08de7b66e4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	HegMUtWtAmrbhU/JT+Wz+nuTs7PFaPsUDNiNK/k5B6qZJZH5OnoBpleIFEt0VxNogZHI3MDlP1kFlHZfDZZe8tgX+IXc08zY0ZEcyC41dYlCa75IqQBDqXhv1N16VqJdAhkkDzFJwe//HYLBT0xiHNK0j2NhNk/zSPvj3gEnoLuHuU3g3EY4rg1aplge1y+YD7e5dCUKs9tRQU6YWFcsOSQlQHLHjgZMIQRe5rUHdNgbOhc3CzP6NK2dwdkKOBrn3NPHOrG5y0AaWZYyxVhjCUtvIWIdgKpvUQkr+UrWqNm9a41sG0idw1YbnSan4zbzA8RzNafMueVpebha0plAboH/qkEhISOwyxCR/zSNqpq6x97pGcUJl/gfvMvc/GJDm1jMVhx7VSwaO5jaceOFjejPGKPnEMPE/6Xo0hEAI8E3Wtx3VOfxHSvAYAE1iUKT8Ac6TfQu3nTufzyrmLMBk1VYougx03Vo6cOi9Ox5UXczcI184yvUF8rCTHBq4HfQ33BYDQ9JAomR/5a6TuBFHDrYCW4NX6+k2MhOT6QwBN61feAQfU7Whk2VM1XnwGuUY0Unxm/LlOpPevenkqFCqtRFUvSBPZ2z9h9JE2rV+n76spTDWYbZUVyVqKapdTSNtlrFQbhIuY8A42W/DZL22MlAVFJh4On1fLH5UmDYiAY6UdMGSbMObKXay+TCsJ+maAgmf/lfYpZsvWCTVI+CSpvb4DvH5PS5G/4L3lykW5hVAs+j2I6EaXKkhjffdkWZLJi/+tghiob19uPtZBqOkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PFarPNiFJQbAaje3dl8ZfRwaQYANiMvaHMm302VPuipMfQcI1k27Kna2sgjjOysAy0z78DVZBzP/dDHNbMNY//ZYtM9+qg+CxlUN/JlS9hfQtPYlbKzjDsLdKo/HAY+3qW5/9vV4eGU3xuA0dC2fD2grvWbAptCJxaaVPmOinTnmr2oQ5+gnk8wc+URBvXiTK5Ad9K1LxfzJXWcDCEhbpq8RXFqIZplfA+j8u9Kz/1dOM5Fn4yJywcrPmi0Hraaa+frjWn7ZKpgLkMcj3RN8YXJ/los1kjYRyhXnt6e5J1NhPOb0kiGSS3FVQzuM0rfv0xpF2z9puIg21TwAlndY0Jv3qtm4T80oC36YbklmBX7uWFQQ1dQ3YYixHU3ZgGsN5/XqQFayWB06TD3EwCTnoThFZhl4FCiNtJYocgN8Mg8dhHj51BBop6kpLSuOb3tn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:58:18.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8f5541-da5f-4fa9-fab4-08de7b66e4d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
X-Rspamd-Queue-Id: 6872421E4E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43769-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautham.shenoy@amd.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello,

This patchset adds support to the amd-pstate driver for a for a new
feature named "CPPC Performance Priority" that will be available on
some of the future AMD processors.

Details of the feature can be found in the AMD Publication titled
"AMD64 Collaborative Processor Performance Control (CPPC) Performance
Priority" (https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB)

Description:

This feature allows userspace to specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints.
    
The presence of this feature is advertised through bit 16 of EDX
register for CPUID leaf 0x80000007. The number of distinct floor
performance levels supported on the platform will be advertised
through the bits 32:39 of the MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR
MSR_AMD_CPPC_REQ2 (0xc00102b5) will be used to specify the desired
floor performance level for that CPU.
    
Key changes made by this patchset:

   * Fix a memory leak bug and a control-flow bug.
   
   * Plumb in proper visibility controls for the freq_attr attributes
     so that only relevant attributes can be made visible depending on
     the underlying platform and the current amd-pstate driver mode.

   * Add support for the new CPUID bits, the new MSR and parsing bits
     32:39 of MSR_AMD_CPPC_CAP1.

   * Set the default value for MSR_AMD_CPPC_REQ2[0:7] (Floor perf) to
     CPPC.nominal_perf when the value at boot-time is lower than
     CPPC.lowest_perf

   * Add sysfs support for floor_freq and floor_count

   * Introduce a tracepoint trace_amd_pstate_cppc_req2 for tracking
     the updates to MSR_AMD_CPPC_REQ2.

   * Add documentation for amd_pstate_floor_{freq,count}


Gautham R. Shenoy (9):
  amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
  amd-pstate: Update cppc_req_cached in fast_switch case
  amd-pstate: Make certain freq_attrs conditionally visible
  x86/cpufeatures: Add AMD CPPC Performance Priority feature.
  amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
  amd-pstate: Add sysfs support for floor_freq and floor_count
  amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
  Documentation/amd-pstate: List prefcore related sysfs files
  Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}

 Documentation/admin-guide/pm/amd-pstate.rst |  47 +++-
 arch/x86/include/asm/cpufeatures.h          |   2 +-
 arch/x86/include/asm/msr-index.h            |   5 +
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate-trace.h          |  35 +++
 drivers/cpufreq/amd-pstate.c                | 267 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |   5 +
 tools/arch/x86/include/asm/cpufeatures.h    |   2 +-
 8 files changed, 324 insertions(+), 40 deletions(-)

-- 
2.34.1


