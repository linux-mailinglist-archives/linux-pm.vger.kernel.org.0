Return-Path: <linux-pm+bounces-10977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FE592E4B9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7521F230D1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57468158DA7;
	Thu, 11 Jul 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SlMhc0f+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52F14D44F;
	Thu, 11 Jul 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693797; cv=fail; b=ZRsvuwWRw5kagttn9d2Hh4rql0DK4MCpxDI0X2jPLKKGYeQAmzM/PNK08wG1sQfZLagoP9PJt3vSniKdwszHMwT9qOX25t8MQWw0lQnTqCsbVwwtqqzP5zKMag0ZLqRhjkwA9hWHeD33C/2ByGeWqnAvMi1E/HAwZUV77RQuiCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693797; c=relaxed/simple;
	bh=D+gLgTvQgEN5lztrVYIjZ2UW4DehNy3FMRMtdl6ZsR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNxU78AH6d0n9JU84onlMIw2GmXmnatjrqwd/05ky9oSGgizJjZQDn/L/YFQ8cITyvl/2jYcccdnozAD/nY/5vvuyXRFOikpGaeZG8E3COj4p1r9ZKzN/nNNtl65K1BZknQU0mbyq+JDfXsoJMDnU+PoPJI49JlG6N6MgGM8P0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SlMhc0f+; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9t1JrWXldSTvp3ke1paBiDljp0ZnQ//xmd0/ir/3ZApAuyhqqcPgfaiLVLWs6OPXuPNR49XErbEdYbTbq273ZPtRLxAj6nq/mo981cU8ZOsQEiUMpfMcaObdu/sl1HzjNSH2f2Q3pT0tSMGMhmsRLwVxomLKLID7dVJ6VPTH3KkQkz2lyUzdhlFFg32ky9xb8UdT9WrYxjtAlBXze+/wX5mtUvvIwNM1SPRibtMXoCYI6OZCNP8Y8mUweJaHa8ITHJOCsz2nHoDoPDyGXbI63zQKsKi2Ly9Rg+0Eb+IEftVAqZcDmqB6dvr+rMg01h+BMYD3VMhnkgIHo9CLSbQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QETpHWz7mQm/u1yCrpkg7I/uOwOXgKiBOV6erzVswI=;
 b=TpUc+tY2g9w0Yovq1qI2dHLeMOc+XxXcRPA++VTAxTbqrEFZqx1jAECv9PhzUM0hpxUYzjt7CXQLGNfUDZOfkG5FOUG8Bn7avDDIEZ2Of05j6tnodH/soKACNBc8smvO2lYqv2ejMwingGNFUj14toiZtCbotZLTvqXAlUdrIxWHmt5fS8MJ5iMYSxNrh/a3li8kt3VOVTI4NYfTptVaJEgfSW2PTphzS8vvJQjziGYVFxLwu20S3mO/WzG4dAFT2JUHnudSGlNLPVTXYW6si4+pr46ZEoj7abKvdLA5nExLl6kvtWZnkKjuFDKR+bBc9pJAzz2ZJCS0mHiFpER+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QETpHWz7mQm/u1yCrpkg7I/uOwOXgKiBOV6erzVswI=;
 b=SlMhc0f+IpydG+AOiETeCVsd6bMCkBOyixxpqR1k8NZRfMrj0FvsNU4ulS06dRXnXv/+h2IFHC2zd8wfflSpy6nmwmswMJpZkL6+MkgO1Oz+8dFJejehX3sqxKF6UB2XOl1HHWSFEhd62eVlYZV8LburuTQq9Cj4a+PtYCiHVO0=
Received: from SA0PR11CA0167.namprd11.prod.outlook.com (2603:10b6:806:1bb::22)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 10:29:52 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::dc) by SA0PR11CA0167.outlook.office365.com
 (2603:10b6:806:1bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Thu, 11 Jul 2024 10:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:29:51 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:29:43 -0500
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
Subject: [PATCH v4 07/11] perf/x86/rapl: Add an argument to the cleanup and init functions
Date: Thu, 11 Jul 2024 10:24:35 +0000
Message-ID: <20240711102436.4432-8-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6f62be-a69e-46f6-fdf4-08dca1946636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QlgJscLsHAwugKOtgX07GpfXVj9oYbNwH3OE3eeC5FzkISTDJ+nLQ3v2JQlp?=
 =?us-ascii?Q?+Bmd6k+EXD6k4NlVb+S/EpcMKLLB1+h8+lvvIlPnWITMNZs/6hIK2RMX9jfq?=
 =?us-ascii?Q?4M5YvV9UdhZC0R/KoIOx0rEe5bVkFyP5xunZGvzFwAxQKesYhICQ7b7d6r1C?=
 =?us-ascii?Q?gs/CdkL9xpRPfasNAGuY/ubRJGw0tam2U3wH9dN0CqriREYh01138WaLryMl?=
 =?us-ascii?Q?VPM7b4uyqOchJkFL5xeig5wLNrObLKmmHXJK7f8lA2/b96PF1sUoON0I5c66?=
 =?us-ascii?Q?PZQtKVd2Wmnb/U80Zk8FrXqwQcHhBGY+lp8Jp7uCxoyTrE5vfeGxlKYW10dG?=
 =?us-ascii?Q?7dEEDeJHjbqDAA+IRhyrEWoDx/d0fHi2iG4Zn/KkTLXUT2fnQh90ll48jxDR?=
 =?us-ascii?Q?0PuTVPEpPaAv7TBLdjc00pu/nYzMJS4EPXdCTuPMJwf5Ip6iMf5dOGEkXCyd?=
 =?us-ascii?Q?sUuXQNw+P2kBtJ11+DOzQzLTryBhVIxpUDZyV/gqm1HZoN+wfBtQtjjUnkAY?=
 =?us-ascii?Q?L/vsoy0ib5goM3ilm+EgQWxvfyDzRSkkSgCZu0nBTFZIf0tMHvAl/DC8a7qM?=
 =?us-ascii?Q?Jq89dV+zCKqY7lG8loUI386g5JnQC7tGVHwd+Z3oPnwhuruHmp05qs73Y3zI?=
 =?us-ascii?Q?oF5At4N0clw4i9cDqSisBlPiX5kBpUJxqPb2zPaVTV/DIwAr9qcw7zm+v3Wy?=
 =?us-ascii?Q?OlMxX4OiQUMwxFveWf2e+k+RKdowmeG7n3O3eOtIS6kbE570MlEA2b+BIPkN?=
 =?us-ascii?Q?XwZ9DFYEEUkeARVSxvagzGO7OAlfCwA0AnFdv3kWjyT4BcmM0Jeg2r18q3BR?=
 =?us-ascii?Q?f7r+odQQroKizg50hvsMEe6/M8+Fs5z3SEbvQnkrXVEcHeEo8SlIv7FOJK6o?=
 =?us-ascii?Q?njJ0WvyylAAQRvKBLicG48PEVFIA6x2MJW/k10mYwll8nsOteQdxKNnDHaKG?=
 =?us-ascii?Q?MzPyWTEdMaX+EPqc/jnpW1rgahMtnb+cGmHRahZeQLR7+hb/Ka5hYq0jvaUr?=
 =?us-ascii?Q?i0gJEhvvJmI1gBMm3Y9qHoQscwfma4Vxf5IywdFoEg0dbcZ1+I8velbsHIcf?=
 =?us-ascii?Q?nzZpQV9DIEY5Wd8LyUSuWfD7H8TQ/aCihag9APDvrUVgBAHTylYDz2waTeVm?=
 =?us-ascii?Q?8vrepbY4p0BhiG7O7x28cfTFNAMxHsESkSYOIyuly3+TK4pekla84W9lvXth?=
 =?us-ascii?Q?/a6xPJz2NYhzkOv6J5klnX397KEh772vWCzhum0pnfHR21ijvRJciSD3LvyR?=
 =?us-ascii?Q?AfX66Asr8kOlPqoxPT3t87nfPkCH7/I5H3UHtLMidHjYmW85Vut+EHq+auw+?=
 =?us-ascii?Q?fWErpRsZkBV5tuiV0W80dkKx6DeTdZ+rAuEF/7AIQdbMLbQgi5zpyVeSk5+W?=
 =?us-ascii?Q?HcwlDvEbr4RRIIyH3gystGmqXLzSfg5DrN/PGxY9DIXuwhL9FVdqeN6x1drd?=
 =?us-ascii?Q?6T3jqUV52JF0EhQxQWbKvKc3Kf0TRQRL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:29:51.9379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6f62be-a69e-46f6-fdf4-08dca1946636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

Prep for per-core RAPL PMU addition.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 1d36565d0cb9..362e82284ccb 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -694,7 +694,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -712,9 +712,10 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
 {
 	int nr_rapl_pmu = topology_max_packages();
+	struct rapl_pmus *rapl_pmus;
 
 	if (!rapl_pmu_is_pkg_scope())
 		nr_rapl_pmu *= topology_max_dies_per_package();
@@ -738,6 +739,9 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	*rapl_pmus_ptr = rapl_pmus;
+
 	return 0;
 }
 
@@ -879,7 +883,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus);
 	if (ret)
 		return ret;
 
@@ -903,7 +907,7 @@ static int __init rapl_pmu_init(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -912,6 +916,6 @@ static void __exit intel_rapl_exit(void)
 {
 	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1


