Return-Path: <linux-pm+bounces-8859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B4901EFB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B080028204C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A777117;
	Mon, 10 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oz1FbNjd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC27770FA;
	Mon, 10 Jun 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014229; cv=fail; b=JHGNNkctNdiSCXg0rQkPlOGlmMIV/nVfLvqiygNms9isdHioXBPxJIp96iot3P+3XIvxPMPveYf1avMrfw/H99r0Sd1mZ51gFgsH2eUGGK8v/HFLa11ATAbLYBbYLI5ibUGEGF6qJP98l6bjWz4rJG0qUodxFsVySc4UVWDoQ3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014229; c=relaxed/simple;
	bh=kq/LIQ70NTTP1DzIxY8ZruVQUsJYI61SgluMa5jcpcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/MgDj4keyOhZHM4jwxWg0j2HkyXCZfXBvetuDqW7dm3zHCiwqLjmoEFlbZsOEFoQo/vhkMwUQlnG/4+74RygMwAp7z7iTDx2+JZrAkkydyRqZ+MFJrgRQ+V6j9WbaHkw3Vg4+yIWJf89jMvSPINmRCO6tQ3LmwUspO50gTXPkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oz1FbNjd; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL3CmA8IvUCM6Kw4ryhNDJFvXp1iyz9q1dS41w8XJRZ+E+qvfK3Y8QSmnV5Cv7DbAokIgqdnEcg/g7aI0m6W5evQ4zC0tt2Po4T3eDjF9Sdf5jdvtjMLc2hwM6GAnWLsFYDYiFgLbLAuwB7PmtSpwUSbaPHBmp4wxsg5jRrbDTMBaLl4GvW9auYiuAS+hKHhFx+tFQfzRU1mcDUekky9giBSb5fRto5jocaivcm4EU4OmTpMfgZ2Y3Ik3Pq5RgyAaRMca6edpqw6x45Bjsw9Z5CCnu77UnAx1925o7WA6KJAqEWqk5415G81zHk2aPxcem6Zx4IIBBcNStnqaS6ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=QQ7GuOWyRd/dmRFSrNXb0/HGJSp0IWMZ/g671dJTjw+/ieJjhJkOWLUejZ1rOacmTxdX3kClnxt8xr3bHHpnZzIKRa90IV1wEMovma+BOiCAF8ZNqE6EKkYppARaCKK/pE1zxqTfoD/yc5UzlxYTpo7uOiUMlQfn6JCN9FWf8/EGsWlj+sMbnokKnWWSIqaoutVtg6gt0wKnTNqqMDmu/QEAfQWQC3JDFjyxzUtqlj6hTPnyTmEYrqdJ2bcYogDWIxDe27+HsoscgF+8qKP8E5nRas5aI1O/4vovxRfRXs0fbBBsDPncKSZ/oK3ntOfQbu1GWFPTW1Mh3rk0Vf3yXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6GYhfZK2/e8rYuOISt+j+ov/9zcEqHtJ6OJpZIqp0w=;
 b=Oz1FbNjdTlzKovbujdSTAUh9ARL6dN+sl0spMar1wE+QDP+ON98kVgQqyIZt4K8lnUJeHvvnE54Ufq9cAuuYZMqc9DfgQU8mFqek3yrs0y1kGQOmZ91ffnTXuJ3VICvXwLq+PjNKbBOv8eW4YYQ7FB3fxojt7AF17A290zda3lo=
Received: from MN2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:208:1b4::35)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:10:25 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::e1) by MN2PR15CA0022.outlook.office365.com
 (2603:10b6:208:1b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.23 via Frontend
 Transport; Mon, 10 Jun 2024 10:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 10:10:24 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 05:10:18 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <kees@kernel.org>, <gustavoars@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 5/6] perf/x86/rapl: Add wrapper for online/offline functions
Date: Mon, 10 Jun 2024 10:07:50 +0000
Message-ID: <20240610100751.4855-6-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 43262d78-30ba-4e04-9843-08dc89358bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+OU9Qnl8IjJXoHukJkDrjAkABHqbmOuAK3VVAOlVsSLdOg+eayrx27Eyiej?=
 =?us-ascii?Q?nq/c1hNpmO1MnWCQpe8zJhXWwAR+VK+DF0A0nKXEK7GkSlI1RSf/oYs434+f?=
 =?us-ascii?Q?4RiK5OMLZRbOStf5juzy4N09RTxkV8GEo7bASXdJfbpX5BeuYPsF8pghlgWW?=
 =?us-ascii?Q?6YjegvHQB10nZhJyhbuDyGn7xb7ptKp67o/6Ezuv7kvO1EWw5PAnmp4/Avdg?=
 =?us-ascii?Q?H1SL50WVjYX4YJvafPchLT29yBt4THlXvE5aI6YU+6qhSy4EJapbIP4Bs/b7?=
 =?us-ascii?Q?JuCx1u+CNAfS+d5k2rY1vcwKKS/H+lVgbTbGNgJLnWpQFeFUs8Tfq+dT15z0?=
 =?us-ascii?Q?VYDLbpD0UcjW/lFxhbS4cLCrPpEnyd5n//u33N+auyh6J4UmVhfNX4hYWOFb?=
 =?us-ascii?Q?vIEJLG8kzcZbCkPyNBR70nWTSljCs2qTFdBpNtL+jR76d39MErbKJxVbOKxI?=
 =?us-ascii?Q?vFmnnjOBvg7qmEg1v3ibyJPCRSgp37L+PPiGZ4rkaQts2KifIpDy52Rw+jJ/?=
 =?us-ascii?Q?etqs1k0wVuLFAVS6fH1/RiFvSEHI5S75pgxACJIbBWsAj4K1Op+anubhJj0d?=
 =?us-ascii?Q?ZLnqBgXNeqO3K0BJmNQpwpi7MFnMarbejl5Dfmsthuj/BE3oqSqacO5dXEUS?=
 =?us-ascii?Q?XBVH6OPwMi/rJP5Bhm9Qq45RBYBbnaT8pxinEx1ziqGrIZUYW8jPrSazIXRg?=
 =?us-ascii?Q?YDoVIDm37RrBUvfxhfzKzxWF8Hq2fnw9AHBW2jWLi5grHRZ2s/GWydELUc4C?=
 =?us-ascii?Q?wf5jwIjAq3FRkO8haV9hR6MnpWEMqIJ2Jj2QAVgviDskKT6mWCYdxZm7OgWz?=
 =?us-ascii?Q?wynGaAmUHqbYv5IhlKRZ3Kj9dGljslhWVT9xsCD8jeqL9s5KL94cnvOdIcZn?=
 =?us-ascii?Q?KXTGgi+3rDlrIqg1wvMrBh09omAJ7pK9xJr+e2LwInS4dc58KhY+tZMlk/9K?=
 =?us-ascii?Q?oBAOZtWK40Ho3nSskrPYtooVl7xhnzK56sLIRL8xncftpryyMxu6XrgzWMxm?=
 =?us-ascii?Q?OlhTc7hVFZOsDeYMLo+MgXP3g37EQ+EBfUuIyY0zGl/X1CAZnT5iy7A5gMWj?=
 =?us-ascii?Q?HV9uwRdQYvZ7SfDQwc5ZdE8Bvb6jHIXmS+OFmjIRN1NlUpVLOhyr4nDV9xSW?=
 =?us-ascii?Q?GbjsJ5Gt2M76W6oGI9uowmiG9EOUE94EFaBJkC8TH6Qnh5dy+HE2EpgsFGPp?=
 =?us-ascii?Q?B7oKb1IyNDHuhdtv3/Vbgiuc6wiK0NUmHZf8jE2NZnXOeRTp7k6zWqSaH4ZA?=
 =?us-ascii?Q?J1hbDj5+E+w/t0nKZ1HbEkMqe+vWAb5onDjpYer3MozVmeGQ8K3dHfrrDKs2?=
 =?us-ascii?Q?BSuL3ElKZwXfT28obDo79f7Zgg629wuqhTtKoN9z36+nRutmqRJTSo7SCILi?=
 =?us-ascii?Q?QERW0lfxC3+jTBLK1uh/E+k8OVb0SBrKTRP8b0V+iAx2xVEmeTeoj1gt/70n?=
 =?us-ascii?Q?pT8tXlRCXvA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:10:24.8995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43262d78-30ba-4e04-9843-08dc89358bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

This is in preparation for the addition of per-core RAPL counter support 
for AMD CPUs. 

The CPU online and offline functions will need to handle the setting up and
migration of the new per-core PMU as well. The wrapper functions added 
below will make it easier to pass the corresponding args for both the PMUs.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index be139e9f9ee0..70c7b35fb4d2 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -558,10 +558,10 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_cpu_offline(unsigned int cpu)
+static int __rapl_cpu_offline(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
+			      const struct cpumask *event_cpumask, unsigned int cpu)
 {
-	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
+	struct rapl_pmu *rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
@@ -570,7 +570,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	rapl_pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
+	target = cpumask_any_but(event_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -581,11 +581,16 @@ static int rapl_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_cpu_online(unsigned int cpu)
+static int rapl_cpu_offline(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
-	struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
+	return __rapl_cpu_offline(rapl_pmus, get_rapl_pmu_idx(cpu),
+				  get_rapl_pmu_cpumask(cpu), cpu);
+}
+
+static int __rapl_cpu_online(struct rapl_pmus *rapl_pmus, unsigned int rapl_pmu_idx,
+			     const struct cpumask *event_cpumask, unsigned int cpu)
+{
+	struct rapl_pmu *rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	int target;
 
 	if (!rapl_pmu) {
@@ -606,7 +611,7 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_pmus->cpumask, rapl_pmu_cpumask);
+	target = cpumask_any_and(&rapl_pmus->cpumask, event_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -615,6 +620,13 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+static int rapl_cpu_online(unsigned int cpu)
+{
+	return __rapl_cpu_online(rapl_pmus, get_rapl_pmu_idx(cpu),
+				 get_rapl_pmu_cpumask(cpu), cpu);
+}
+
+
 static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
-- 
2.34.1


