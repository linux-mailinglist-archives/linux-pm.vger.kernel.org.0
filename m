Return-Path: <linux-pm+bounces-10981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B720092E4C4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C972282241
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FA15884B;
	Thu, 11 Jul 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qIYpM3pV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6415748F;
	Thu, 11 Jul 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693881; cv=fail; b=XXgyy/0DdXeUqMDRbPgfJ00WXRIeqgtVNUmsDHPt/beoaklM7+f/OJ5i7XlnRv+QWuxnnmNvNxrdXvvv3pPTrDuJK9rcv6r/lPmEdg2aURPUTU0KlR8ny4HZ9VOE9HRMJX8u70BryZe9eBbKrTg/I3b4qEvpw6M8DxbHemnoD6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693881; c=relaxed/simple;
	bh=F2OuO5/pQYkhNLRUyk5L2tLI11gXz926ZzKgLJ7z+s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAyog4rtGXJFEn6OQYtl8uSkd2zmquHId30HbdYJXYpF+hf42hk2PEmtVGd+fnfNoiZ7xy8BnpNwYiGsvVgG14q7GscXklTAnAtGr0tJQpRBQipTiiBcDp6XA8noQ95oB5w/3nlZSeKr+4S/4ZILU5aN+2n2c1LvX8MDtn4FgNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qIYpM3pV; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8jUzWUaySCQiacklhAzcdMPcegH+wlLg0pVp5rN2uV+zq4Pmwecjn0AJlsffLgmW2vK6N2s/R6oAcyzqYQbvaAy6NngPal16IvHT1RdpeHm5acepPre5TTC3SgrEHA4aASy/BwbvKK251K1UtbWZG0kdTUaWvOZYRui7zc3V9J0o1efTjUjm8tUwdoalqQbqk4As1aVnV6/u0iAplGeHmTfM667xXqHxT4qsuHzBh/oj5MCQr45RYJrReSsBrRsYb3UP3g6FZQJIPoWSENqspll6QzVhyuf+/DNHFVQDmnj42DJYXZKWlPRMD0P1p0k3RCXh27BT80y2cl94rVTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEo0HnXMWIwqRGr+UtqPMK5iAVHuDsC0gEq8KcRO6nw=;
 b=ZR4Z5x9qaCzWfXGtvBGlTQG5QvFUMp+NAgpOhC0RJJ/P4SjjQQtleMRkQX8Dbu/6xN5WZTxW++tTu31vtU/KyCQOC+B+aGUlfhNcubDxsbaRxJEAMhYazL9vAYAmaLog9L+hXGIFX3FS3QOjXjEWnYwk8dUVJRk3IIBFy9VQrmRTO6NcVyPGwb29rpf1/ukGAvO5E849nUWFj/5Y3NMq7zblCszv1DiOZWn4LFWXA8uaaUgXRrc6jdR0PWLSJ1NOFBcSJCSFLUSDfLhNXGDcRfiXNEtZUmpWZzz5Gj4Sa/KXmSeogTQvd/od2qH5eHNNDw3u8E9qTITT4yqc4mFyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEo0HnXMWIwqRGr+UtqPMK5iAVHuDsC0gEq8KcRO6nw=;
 b=qIYpM3pVLv3djrPdRdaTrthtivNQvMJCFIjm1V4cK3+j8MuYjSn9Kwk9Kk1kpOvqH9ABqP3B3pIb0RDsWVOGT+qxm9jbwwWgO1UCDGmXLJ2fKTDHmu8KgHS4jJxOu0p0iHoUDvUjBRwXmQh3ytRIS5wNOzQU0an6rP76tKPDiX0=
Received: from SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 11 Jul
 2024 10:31:15 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::34) by SN7PR04CA0162.outlook.office365.com
 (2603:10b6:806:125::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 10:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:31:14 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:31:05 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<rui.zhang@intel.com>, <oleksandr@natalenko.name>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>,
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v4 11/11] perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
Date: Thu, 11 Jul 2024 10:24:39 +0000
Message-ID: <20240711102436.4432-12-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a7c42b-efc8-4fa9-85c1-08dca194978a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jJdqflXFTiiXRuHZw/AZO6UoF56pN5M4Ao79goOR/M1B/3nN53E/qabsApS0?=
 =?us-ascii?Q?Z5JcPTyoGvQjnJJ345lqpv+ePfldFl2BUnU84d4vMWfTWlPoMw+80oSZ78m7?=
 =?us-ascii?Q?ldsVpYS+A6shkof3jizNw9c0vbvxADc6tR39JXn2F4TsRl8Gt7fbhRbt5G9B?=
 =?us-ascii?Q?90941o+kfUiaq+NtRPI/HgAZYocEhTysDiQarM3HJpMh2dxJBOt4GJ8iI7Or?=
 =?us-ascii?Q?HT0nBd1JiGwI28Uv1tS+WmEQClNqpG9jpLjH8d2Gtrvd1hoF5AeRMMl+8rdI?=
 =?us-ascii?Q?omOH7H2Xg+SFdoixW/YthMizQZq0aSRBPmj32O/nt0JUHWuxUAwKgRcEiH0p?=
 =?us-ascii?Q?q6xvoapXLE/B3zRwsIJtmEErqjRSsCd4HOUseF0XiiQUXU+eDj6UIpGYcIEg?=
 =?us-ascii?Q?HqBG1xKcH1dDrjJV16gsE9E+S4ZioiIW5Q6NkIMB3r9/FJXfyi5QKT2X/rqP?=
 =?us-ascii?Q?Q179Gi+qwqN20wLJ+0VTPYxGO6ZJDUjSF++BhdzDFFa4oztbi99VtKpB8ne+?=
 =?us-ascii?Q?S7GW0KPSxAniXq2gImIvdcofqkaSM1VrXMAEHfQh1qRM9rJ9CtkAvNfbBgk5?=
 =?us-ascii?Q?FPTCVSzPoGTjt16ZFiSjEbvzRivHLy4ArhxsLmB+LoVWVliEQCboUcVP8Ll7?=
 =?us-ascii?Q?3H2KBiVbMMOQ7qc9PDLUsKAzb9+0+WWqqqk/IMoWtfSc1MG0Wi2z30MA/FBm?=
 =?us-ascii?Q?yKDDUhPFpcn3gc921dttvoo6bN16lSJ4Rmjo+KzqS7uXroFhbU3c54jeawCv?=
 =?us-ascii?Q?OZLPc7wbKvNTmSeY7ABAhWoGwolC6161Sk+pJMvEqkmaqwsSiF7QWrncnTaZ?=
 =?us-ascii?Q?Nj2MWKNWLcPHsdgRCVHGthHbp1rkSZjzveIWzJwTpncIZC66/SyRGNdjmPGX?=
 =?us-ascii?Q?MJfApRZNPIpKXoVn8i1dwn3ddgCepDv3OA6x7bReIYwMH4fCniggWEF/CxsX?=
 =?us-ascii?Q?l+KtJ6TDJAiMq/ED2auZWi+pO6GF0NMWNHmzwVNMZYVVaEaVKDcoyjItGRDb?=
 =?us-ascii?Q?cnMbkg4ghSBWIsO8LI1751Pq5vi92AHdaIRpMYUyFImWzhfNKh7yd16m8RN3?=
 =?us-ascii?Q?d24+pE7+fCfXtztcJuYGMMK9tdgNP+YsWyqK9TdGMjKPKxnVZpaqLqn9Oczj?=
 =?us-ascii?Q?XOWw7dxx0wc/XBwDx1CQKAtI+gOft+bqH43Lm62kwqdPuL6Gd31FEoUByYUS?=
 =?us-ascii?Q?jda35ADFNFszLlrkPyw8NZiFCxT4K16m6zcNeaBQYA654EMQ/aBrkqLiJPgy?=
 =?us-ascii?Q?DN0u9riy8lue5nR2XF2H21eG63BwzVqj8k/5KmBeV+Ht2UNW8ZSyN6Zikq0m?=
 =?us-ascii?Q?lMv6rph1cPELgu3wy6wFwXUz5uyXyWPM4rYL1jj20egzbdgG3zr2anNvSP5U?=
 =?us-ascii?Q?ULxoHCQ2e8XU9HqKE8vBHDtDnN8sXpYfpeVmRU+KeegYTeE5Y4TbQ6DfHYP+?=
 =?us-ascii?Q?ZmONfu5Bblk/nPXGHsqab1b3a3jGfng4unO8KCBzqbMM41BFObKZxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:31:14.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7c42b-efc8-4fa9-85c1-08dca194978a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

After the addition of per-core counters support, this function
does not work as the same CPU can be mapped to multiple rapl_pmu
structs (package or per-core). So, remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 91eb9850df9b..6edbf798a1a0 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -183,18 +183,6 @@ static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
 					 topology_die_cpumask(cpu);
 }
 
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
-{
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-
-	/*
-	 * The unsigned check also catches the '-1' return value for non
-	 * existent mappings in the topology map.
-	 */
-	return rapl_pmu_idx < rapl_pmus_pkg->nr_rapl_pmu ?
-	       rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx] : NULL;
-}
-
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
-- 
2.34.1


