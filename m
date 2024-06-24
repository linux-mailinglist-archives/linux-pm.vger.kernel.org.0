Return-Path: <linux-pm+bounces-9871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F077591426A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B72D1F243BA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5FE1C695;
	Mon, 24 Jun 2024 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zp3HENd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2A18044;
	Mon, 24 Jun 2024 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719208921; cv=fail; b=SJU8CYkQhupgZb0tYOoV/EXBYpE7dI0lFBk7i/+75rGG6ZaZmv8kC7zafgIG9z6m1EARXJLODzAPo0Ec9hzRsn2Gzmx5kMB8wx67xVcuiMqGR4ft1CNPU5BU0uACUju/AcGov3K6k4Vnt8gyDT3nemqssSpGa2kTrnYof2gvzFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719208921; c=relaxed/simple;
	bh=FbVldJAzwBUz/OiIKlBv24FGlyQJ3s39q84DqVs7d1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlrBjP+0FJn+kI6FEZoOdJ5BL17rrajO4Lcm1U3a64s7HN7THSBveOKObq+i9+/YzxjDX4yjUXvB/s8KFr8z2rGqmw/NbWh8CrvZJIe7lg+pujukqT/i092aicKu4b0FbzkmN/r0uasEewpnARMCLoXbhQ9YW0pTRaBTA04unxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zp3HENd6; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZiyru3BzUJYX3oCVBDZqZ1afOmqXPxrGAdEph1B36vLMVnrLl+nk+0KpcHJi0hfK7wDnPdPt21FvJ1N+hKsNFDYjXVWPMAd+nZ7A6+A316iYQuCsIA9hVC+g5Qs/FJefVwVNQxLx1i8AhtpqmSxrP9gFpDazejhp6AHEnIkPAU0MLxavo+MCR5ffOyjMfZToyIdt+RGo/lhFkO7l8X2+OFXLPxRCThFNhrgGEVlBS1wz3QRfPH3ons3iv+b+4h5328A3CUOgUP/orFs0LMFFx88Mtg1gFmSiXZ/5MlFfQ7efmBHKXnr3aVWpWAqayxi9plPVq1FuVkxaGACk+xJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WSqqtWS5pLK7gm63CqzM301h8Bv9ShBNsN1dNvF7Fg=;
 b=WcugYVsyclc3hXdjRjVYn1QII0sEs/hWnkzMzAi5XREkyPpeBgPSnrC8VP4+oAd3g0gZGQROziT1F3LcGOVH7WuO5hbYusJw1XtQnZPiiSUiYMGgys/aciD3EI6cMj+YjPFHIPdvaOoZVLZhAYBeYLOXqMyLatT1QI3xpGk5zFR+BnNLEyM2aFXrLKvAhhSfJJwxHU9Pg5nPOHnbkqZmuHsLI1dYNmJ6Nedb8d2DXN3FhWA/ZYGs37dfzG/2xPE0dSoqObhXqJm8bu8UCVtgTVVonW13QqGxEuORWIkHYPlI7AgKpfd0R/4MpDLHpd3WiodFPjzInWzK1q91Smqgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WSqqtWS5pLK7gm63CqzM301h8Bv9ShBNsN1dNvF7Fg=;
 b=Zp3HENd6GwxzqXpmwtl/JXzkDIV9TnDUpGajhla6zJVVFVmbOnfF4cYpfMcQkFATOMXrHep2yeQ9qfIEt2EpU0EeW8MVXMN31uVmY6MXsrXTLXfavhUkNEw3sZtezOHswSsjicqZAxUaqc4Ek9UkoiPvdogem33iSIi5SRMW49I=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 06:01:57 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::96) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 06:01:56 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:01:49 -0500
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
	<sandipan.das@amd.com>, <linux-pm@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v3 05/10] perf/x86/rapl: Move cpumask variable to rapl_pmus struct
Date: Mon, 24 Jun 2024 05:59:02 +0000
Message-ID: <20240624055907.7720-6-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: fed71c6d-256d-4dd4-d5b7-08dc94132792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xe9OQM1AQpoxmqln90bQLVzFQGu7H4k7P6Qs+L4MW3zDp1RwNQMQv+eZt55I?=
 =?us-ascii?Q?72h1dHPuAzjC3aKpDRitcy+evd8PYR8p7cYRDfvzxsdI3z2XrdV5v6uRFkgn?=
 =?us-ascii?Q?YsxrgVyQPTnKLwIBWDGPux5MePp664pxablrlHS/5lwbeqoa7c8ya4exA51D?=
 =?us-ascii?Q?VuNucnGdLAPcoN4sCKk9QvTDdvTb6K7+920CHnNDxSb1pJ9fqE3TuTwuCkNK?=
 =?us-ascii?Q?BDcNQYiK6prKLZLFgeymErtWtj6eh6SPO3In4uMKYzqiw8yoOIzSZ2x58svK?=
 =?us-ascii?Q?MC63mHFBUYCfS2wou9nCz/PH0rId9iWT5XNkRkRkh8BvbCDUDep5OL6zO8xb?=
 =?us-ascii?Q?sStm/TJgjXjx9ozOVF5jlmiXBnpRf7OI87DVhgEXguGKDbrgY79m90hm73lF?=
 =?us-ascii?Q?suTJyxLyBdD+1BdvDDAgmEISC4rTHNBTTahMjbJWiczI/N5BpuhkBSm0MC3F?=
 =?us-ascii?Q?lFwt7RSIlJx+uLJAw2WHV7ytCmGkxtBAULkTaIwU3E4fGpGYADy/WIvegmvT?=
 =?us-ascii?Q?h67/iJzlZNtq7S4/dS4TevZj6y7QR9v+gIeG7Oo+Wc4ha7VMFEdJCTLiTEwC?=
 =?us-ascii?Q?bjMWDgjSN+rwDTx7RJHciAfNCYcqR94cYqXz8NDouRx6UPMSBzWXUWPpJHVG?=
 =?us-ascii?Q?SuUdAmnxGQr94hMucS6AdqE8pXybK/tt97LzuMs5ZTRZQaLXG3YaUMBHTVxp?=
 =?us-ascii?Q?t0/RolzhnYuOEVmYI91uCPbZUD2FrMPbCj17qbZVP5xAMkZmfJzOYmp/8BGn?=
 =?us-ascii?Q?zq+CW1ULQkpxge4nEVHMSAbcSlBwtja2T5lDZrjOljO8Lslx08Cor/h+Aoid?=
 =?us-ascii?Q?xTO7iqYggNvqB4jEQkeuKy2/36rJfs2bDF7R8omDasfzQhKejB6k29Zi0ODt?=
 =?us-ascii?Q?utEmXIrVwTOLLcfNa/Na1dDY1GyY7XHDI1evRSkjkKRTIacEQebHwBmc5fS/?=
 =?us-ascii?Q?bGLTxS/Q3ffs0YhyBe7uDGVzqHYGne7EfvTufJXjnoyZIjYWtSmy1ptlifpQ?=
 =?us-ascii?Q?+z+9aWjzOFJN95Uf3OS4mqp3leH9Ks4MWOG7xOOjmIxQej6GDmVAcBotw4Io?=
 =?us-ascii?Q?C6yv7q/8gcB9/rfejhGdkEHFxu9rzVU+mEBZVpiW2lr+0CV++0vWDbSWcdD0?=
 =?us-ascii?Q?V82ounPW08Ws2IlbfGg9Hvmqd92x7u/p6lhcZnlI0aEnZ3VbFpujXyyc+Wgo?=
 =?us-ascii?Q?C0aimSA0Vn5SVYFmysCcRwoGeE0CQxiiUYZ2YCAWFiu6rPLQZz7xmLHXk0/k?=
 =?us-ascii?Q?eNmY/IkUhvyG99Chv1IvJHUe1e8iQFhpAsm+YN4FOPu6ezlwmk7SccIdzs1B?=
 =?us-ascii?Q?f8ZLla3aLXW+U5SZWpxRNAaXUwWMkE/Wm2uUPOtsSfVeYrVvgVaYkxn++2hb?=
 =?us-ascii?Q?Qgf2yHYqxCjAZBW743hJHfodwfKzYrlL3cS4SbZnCSOD3Wb0R7xMeQQk7YlH?=
 =?us-ascii?Q?XWLMk8TmLH0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:01:56.8366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed71c6d-256d-4dd4-d5b7-08dc94132792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

This patch is in preparation for addition of per-core energy counter
support for AMD CPUs.

Per-core energy counter PMU will need a separate cpumask. It seems like
a better approach to add the cpumask inside the rapl_pmus struct, instead
of creating another global cpumask variable for per-core PMU. This way, in
future, if there is a need for a new PMU with a different scope (e.g. CCD),
adding a new global cpumask variable won't be necessary.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e5e878146542..be139e9f9ee0 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -119,6 +119,7 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
+	cpumask_t		cpumask;
 	unsigned int		nr_rapl_pmu;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
@@ -139,7 +140,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -394,7 +394,7 @@ static void rapl_pmu_event_read(struct perf_event *event)
 static ssize_t rapl_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmus->cpumask);
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
@@ -565,7 +565,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 	int target;
 
 	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
+	if (!cpumask_test_and_clear_cpu(cpu, &rapl_pmus->cpumask))
 		return 0;
 
 	rapl_pmu->cpu = -1;
@@ -574,7 +574,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
+		cpumask_set_cpu(target, &rapl_pmus->cpumask);
 		rapl_pmu->cpu = target;
 		perf_pmu_migrate_context(rapl_pmu->pmu, cpu, target);
 	}
@@ -606,11 +606,11 @@ static int rapl_cpu_online(unsigned int cpu)
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
+	target = cpumask_any_and(&rapl_pmus->cpumask, rapl_pmu_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
+	cpumask_set_cpu(cpu, &rapl_pmus->cpumask);
 	rapl_pmu->cpu = cpu;
 	return 0;
 }
-- 
2.34.1


