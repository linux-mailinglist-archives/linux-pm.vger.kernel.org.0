Return-Path: <linux-pm+bounces-40267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72ECF70E4
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 08:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 450B0300181A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119830AAD4;
	Tue,  6 Jan 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IoVZFgAt"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0F307AC6;
	Tue,  6 Jan 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685020; cv=fail; b=Ma+yoctdUw82XptP21pXRn8aa1wBNTMJXvpNoC+YyfIGKBafiP32GXzgZAvmo0uNrDqtKeO58ZVkVVs8BoUk+lFQK+G/Q3uNYZ7kx1pco2Pk/cZOcLYbg+BTb4G8fbmncAd2zMyNmT6qRKfuai5n4CNZHAd+dD42qBu18fRb9TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685020; c=relaxed/simple;
	bh=Q4Bw5AGIqlKXpei00q0Q3uXX8lt2x5odEZEGiAQlHJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU2WoCkgEZXxEh6glEc2VrgOPuwuJhgc/+zpRuEwjWZY2jsZ3cFjiOGqZPgwtORqEgk6upBCGv9L4jGJR+ITvz8BU9gm6dxKGoAnq5LecnRmNYSCSCfwOuGY0tNqbx6PMGkWIUGudredTVbzzAD0ujOUL3CAFVw+HXvv4p5O+2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IoVZFgAt; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkwDiQNVxECuIMSb62DzT/ijVfzAJ/q2mHxPyKWCiLx8fQyT0wmH2yAkx0qMUGWBb0qbWqjRjlkNSc2EOWoOMNpAZ8Unz20nVQF14wfEkEXp7J1qQftsY9CoOI12s9FRRP7j7PQsLFl/86pEIN1c2A/NHaAIrrqft6BwfASMSzrNpy+jgbS0dA+jXWwzEhJEDUD3RDsW0OnARxTIi6Q0bE5rZ4AlmFIgaAFAvJ40xVmfnJvgJj4SqFtDm7kkC1mdMHtYyct8wYF7vcpRRDC6x6JdmJc9gX19F6VHI9umf1fpJ9hJlTnegwjsnecOdxrhCZJrVptrwWjPGwYHsg01Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h17OfjEwAZjCwZYe65rqWcI/WIAtXskVA0VSGWVAtuQ=;
 b=bDxN+NHZcxZdtKvBnhWom/0o9WVdLoEONZ4aH+O5pY3xUGLMR0ZG4scwoafvjYbbizz8N3A8QgR1TJ3Nh0v3MuxbHN2uJeX0cVgthetggMjlt/Si6nAqlxMlYW19r/PinuqAbXCLSYttf0b64TE9nTC35EC7qTSHKxxiLv9/vtmvRNH3qApFiAIbMXokS4t21WDQxibp0NFAEZw633NLnkPApmU0lbrFgPZ96G/Wkr7Xn4BhSJSCCBqn3ncEjkyLdca9buNZrICVE/MK6+OKXyBwmEK+3px4gyhx0KYzSeF0abZ5smax18u03ClMpSHBYAECGduWmE5UfSiJc7vusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h17OfjEwAZjCwZYe65rqWcI/WIAtXskVA0VSGWVAtuQ=;
 b=IoVZFgAtsW7j4CyX9/KWGQQlSgBK3HFbavRXq018BBS+y72DvDNi8hLkfhe27ELTinhr9MAI2fw/k7HIPriI0bpfxjL8ljlyLy94CiTonoVJxHl+MUsHl4Ea1ZHDbSb5HMU9y1rceW81qelUgbxVsbRP3pIBH7/xZTLs6DngLNo=
Received: from PH7P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::9)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:36:55 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::f8) by PH7P220CA0017.outlook.office365.com
 (2603:10b6:510:326::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 07:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 07:36:54 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 01:36:50 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>
CC: Perry Yuan <perry.yuan@amd.com>
Subject: [RFC PATCH 1/2] cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
Date: Tue, 6 Jan 2026 07:36:07 +0000
Message-ID: <20260106073608.278644-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106073608.278644-1-kprateek.nayak@amd.com>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c328065-095f-44be-e018-08de4cf65da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDUGK+4EaAFxqtm83xZuSFLDfgMPTk7jcz0tJCegmyzezDJtPaw090ntufY7?=
 =?us-ascii?Q?MrPb9alKCYJFWF7iYUWf2SnMwo7mx4Yg7Z40+z0M1omUZp4u1num3APTI403?=
 =?us-ascii?Q?OUK5J8pFLxHA0GqzZcswPeZWAHwpoRIkvUVEtu2hhoGN+W46RkhAySVnKv8F?=
 =?us-ascii?Q?Y8whW1Iw4FF7LEVVrhjb3rsai0jF6jG9biavPzUETzGr3p/9hamtGI4YzWeR?=
 =?us-ascii?Q?NYTglIC8r3Xs/+bGTb76APUC7W/pfTltEIH+V1VC6rk65UWX9OUbzsXSFocQ?=
 =?us-ascii?Q?Nw8/j+Rr+ZO15e2tupwGCqoL68b9/+MmoHTJaHxkfvABPZkexcKzq+cTfFoO?=
 =?us-ascii?Q?zOBHsP+z5/JRSHIMlEVp9L7dlk2aWdhO3lC+KhP5jSs72c8PnYeAd/N5L7d3?=
 =?us-ascii?Q?kS8VAHiYj6yJ1HQToJrVSWkufonOUt1o0ArYnxFRdkfMbbn+VoSlJiWn1gPm?=
 =?us-ascii?Q?KDvamzNs72RHkcEh/JRuwnJtjjMoyTwns+77IV2Y5UBou1Fxm9euTrAL6rbz?=
 =?us-ascii?Q?QYbVkv0StQuLAihB1pMZbgmJsbVhz38IImSJe5pPExyRNGt8vm03L3ia8L0V?=
 =?us-ascii?Q?DL8o0A9U9SMNjsALVKDeHKyB80HR1rtqjTAoK5PJjepKRcnsAT0/7QW3u0TT?=
 =?us-ascii?Q?du6cP/bjP+ySOXOENSx1MbdTs7ywyIK5DVD+EH86s1yhrH6wJ47CtrHgHze8?=
 =?us-ascii?Q?MxGc0QxRzMLXL1EBqRV2LVlFuhvkrMseo4Tva0b2fcui/4SB4i6IMagPOUlp?=
 =?us-ascii?Q?WgJ1fYAAW09bjkH0LFpEfxH6vtm/rCQkiigtO3k88yYrtIHSrv0nPOv3UF6U?=
 =?us-ascii?Q?e4Y1R4NfqwkB0Rdc42CHn9FkOJKVFYXJpn6RrYxTY0rh6i7zoBAeLR36ArkW?=
 =?us-ascii?Q?Eik9Dli50FjM9edIL8PVqyubLOobrgRlfIbmMvw1L0HQqFppZTX8nwXmkh8/?=
 =?us-ascii?Q?7Py5GMnvFIZX6yX3VGGql0AlSDVULLVsMKNsr7nJvstvQyD8QQoR7+SKHunm?=
 =?us-ascii?Q?TT6EWy4OodrG8waQdRh1sKC93U/nNkliyZdTycDX3M5cF0JCP6MepJlmXHVB?=
 =?us-ascii?Q?4GTGkNAzQZV6Tuh779rx5tUVdjDISaFIDdx+aMnRckNQwt2vgoiq+YSHgJT+?=
 =?us-ascii?Q?Tykt6apoeBj2lbL1MIdD/8/nljV03P4MdDvKlQlpz9CNuO9Mn6O5atkndDkd?=
 =?us-ascii?Q?oBS27urXh5+5HvykKGv2hD2mwsgu36bcEvrBYfr5xODcJoQ0H1V9L1P2FtKL?=
 =?us-ascii?Q?bXjYmaOpe/kl01lZpLS0m0ivD8ybGQ9pOpnZ6y+w0AI6JIAO2FvPlcabOgdH?=
 =?us-ascii?Q?i91kIqlgg5P+VQWza5a+wu+3PfS+OrRKTiIPuxscxt+lk3pIgC89N+QT8D5V?=
 =?us-ascii?Q?9tGlF8KYpRr3gf7NHEDzsh78hwJkOH4VQZcoYKc8DgABxFHPouiXvYGAbqYb?=
 =?us-ascii?Q?sDdJspvuCGOUhbo5v7VU+9cMH+B1UQNlxHRTBYywWFqZNTGCfLbCjkRqSaEj?=
 =?us-ascii?Q?mRcxZ5ZrdYiCv4iV1ZvsfCEkFjfkfbM5EV/LovNdR8Iaef9qsAfPTBFGlL80?=
 =?us-ascii?Q?E7CmRuKV+RfGkHBcHVp7P5nEwd8hIjoRDxqqyLGC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 07:36:54.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c328065-095f-44be-e018-08de4cf65da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

All callers of amd_pstate_update() already have a reference to the
cpufreq_policy object.

Pass the entire policy object and grab the cpudata using
"policy->driver_data" instead of passing the cpudata and unnecessarily
grabbing another read-side reference to the cpufreq policy object when
it is already available in the caller.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c45bc98721d2..5818a92d96b9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -565,15 +565,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	return true;
 }
 
-static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
+static void amd_pstate_update(struct cpufreq_policy *policy, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 
-	if (!policy)
-		return;
-
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
 		max_perf = min_t(u8, perf.nominal_perf, max_perf);
@@ -675,7 +672,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!fast_switch)
 		cpufreq_freq_transition_begin(policy, &freqs);
 
-	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
+	amd_pstate_update(policy, perf.min_limit_perf, des_perf,
 			  perf.max_limit_perf, fast_switch,
 			  policy->governor->flags);
 
@@ -737,7 +734,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 }
 
-- 
2.34.1


