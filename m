Return-Path: <linux-pm+bounces-11249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F3D9375B1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C22B227A5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD280C0C;
	Fri, 19 Jul 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSh5Jrav"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039555769;
	Fri, 19 Jul 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381277; cv=fail; b=nMqk5iRmIt6ElXwbZ5j32u/p5F1p8dlZIwem+5VCTywe4rqaURBEgbhni3MkVGOJ4JQoC5e5a4u2LoTUxi/BWRt0s/Aqk8AnL7bLLIRqq6fkgL4hj0L+Tl4ofaeJqTmsgA/KTJdDEgnzqnqPrMlWrP9Pnxnj6T5TEGyR5uPhoXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381277; c=relaxed/simple;
	bh=De2+nqgQnlomAEL78IlpI06+cIGsmRvwpK6sQpZas8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8F9dZfrktocokbdf+FHCE1hJY7jFhoyFA2krLpeTK1vSBFs1dDkebzw2j9wLm3rWfwA0PEGJ2PEdfB9DYxaOU8Zsso+BXmkFGnTZEf6oD4NapywBy5WOwZ0bHb4eVkkD7iw/lWh3F4H34q366vGSYc2h9K5FLf+G6Pm+z7t+wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RSh5Jrav; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6KgUkb8TnnzXkd2NNaXFiTj9Wvj6FgZbdVcOywvqIdpj2790NGyP/1qki36AJ9WirvpJDZhIFb45qiEfjoiukaZpCCct4efLisUqjWOsvuNQD4sfe5viwr+wrTuzPZBu1mzlXjivepHQjmKKu6TmmGatXrJiHAfjPv3e0gZ9BiOxquR0Aj+pN4+msjJP27Z2+nQBBIypolYF/Szp/h9xWN3xLxEFiiuG85rP4tCw5pWBzyHyZONb1T7eZJkACtiIq4Xy/RZ/g88fqJwTo4bL4Zl1iG21PMwp/Y3CRRMB6ff+3s8hXyI+f7kD62AvHQkfpxpo1qy8SH49AIn+j5n+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSJ7tNvUspHjJs8Xn06jhcj7534DAqAuRIal2aoVMKw=;
 b=OgZgmqkjLI6iwEfSHJw/RF22kIJ1XyNMasXUlLVuYtldUgl0c4FtEtJm086ac6dE1BzREiY6c/l1VTF+HlCSmbn7g2BdgtZXW4DKpdFkF+jFfjqsE9k8YoQl9RsHph8q3dj/2LyllBLskPa5NxFvoSvuibaWyET0oMvlleFUsF2EsNso6xZTshG6iUdwMi3/Puvy3USvFhHGgP9dQZDEa0SVJf4wN1JgwlcUiBOBO3Ph7SAplBawDBdkFEQdRr9lUzRiTdURYaz8SRta3Yz7GMzT/wo6cvvPMRJBf3svH4bsrXKiZhpZ0pKV/IP6TVFaWzgJzh8KXz7ODmqW3oHTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSJ7tNvUspHjJs8Xn06jhcj7534DAqAuRIal2aoVMKw=;
 b=RSh5Jrav69f+bFeq1+mAhZhtpQ2NuB3cPRegk8m83B08LvyuABAR+TAwLlcknF6TJfcz2o20ultG4TL3bEuOvvMcy4VWjUDopvgeoguyvy8f4mf155l+YJGKOPNVl4Y46KYFhZRMmctEAOsOEQGP1+gKXy4I3PaEY5nmdujPC6Q=
Received: from SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 09:27:53 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::6) by SN7P220CA0013.outlook.office365.com
 (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 09:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 09:27:52 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 04:27:46 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <rui.zhang@intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<sandipan.das@amd.com>, <Dhananjay.Ugwekar@amd.com>, Michael Larabel
	<michael@michaellarabel.com>
Subject: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs
Date: Fri, 19 Jul 2024 09:25:46 +0000
Message-ID: <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bc9582-ce49-4d1f-73a6-08dca7d510a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3rAOs6mTRebPTJ/YiwA7cwH1ZtFWakwOum9EEeU4UfVIGFt7gvhmnhRhpWsJ?=
 =?us-ascii?Q?w9gyU78z1144qemtUmsFTHdNCyGIVQ0xYfjnOZohsfy8kyYAWepGFNi0cbeD?=
 =?us-ascii?Q?E1kl64SlP07++TwKO3+CS9ccrVrOMT765kdXPRGIQPq+XWnMNA/2Tf3q/NFr?=
 =?us-ascii?Q?BNAptXIgPecrs9aOZUPSy/9Jqp9RrzOofCTkLUU2UvLRiBVOHhIxgWcwN3fu?=
 =?us-ascii?Q?jXfrFuDt4GQ4bskHMduYuJqHH5zKfpt7BSOSA7bUUjAzTwomkpYkdknZMNMQ?=
 =?us-ascii?Q?Sma42TsmoyJK05cVWOWqEg2hL2SWY+Qqs/7ftm1Ge+at/+FiNHd1zgr3iFfx?=
 =?us-ascii?Q?uCgh9cEkyXnQllQx6k7chLo8QdFBd+K0g0TpeHJicw2gd9UhBSMoQ8lvE1vZ?=
 =?us-ascii?Q?ghEhSkLH6OaRZhnviUNHNDpEUBCxSLfIvsVHPic0IKyT38/rVTfJHp2r0tpS?=
 =?us-ascii?Q?8S52ft/76tgulZXgvC4nj09RlyTCffEcYxQAjDxuJ//U6WwiO5ZfBgq/2Rbe?=
 =?us-ascii?Q?dzX5cwO4tBy8kyYD/zfA83qr3cAWWTF8kzwZ9ExudE8I98PEBwRUaaxm6KDZ?=
 =?us-ascii?Q?XBYdVxp3Q2ECA/bbAcgw4SHUWahN9nuOO84nFWkWDDTRZUSc2z1j073f7qUW?=
 =?us-ascii?Q?3b8shI+mmNZPi0qKc4dsQs4IyttZR3zxRvsf2DkK1xt8ZIHQj4yusQsr3oMg?=
 =?us-ascii?Q?9iJqcaS3amgbVZxrc+iRG+6TgmU8qKPnS+rpgryq7/vxpSeYWCXPaL9SYuBV?=
 =?us-ascii?Q?C1Lu510FEQxVGzHz+CAJYMZ2dVozqA2OrmZK6vcCgdSXOY5LgShW/4/oflis?=
 =?us-ascii?Q?Sb5qVeLEh01kBYMwRSk4S1t8MED6nxHDpn2JJPxr+6sS+QZylP72Nr7t0VkC?=
 =?us-ascii?Q?rRnWaPGA/bKZ2sM0vE/y6Pvk9A0IF6gQSeGa3hIAdNIXIphYePN+qEHHLlPo?=
 =?us-ascii?Q?rP5HbedpZmzl7OiHeozN9zIRcUi9MhgFp4J/H9qR0gZUEwnHwTZ46HV/0XWz?=
 =?us-ascii?Q?yJiCws0gz8fepJnPkgX/bch8ZujeOelVtXaX8hecmGacS/rm6xuQxf752Rlf?=
 =?us-ascii?Q?LYxy98c1h+56lIb4Iv7i895fxcmovrzUWggPkXMATUQvf2isfPFhlU4ZcF2A?=
 =?us-ascii?Q?5AaJ4PBIkH47WuTfsNs/IFnHNUxZqW0IymXmSTV7UfnmmJ8XBi9OEr96Zudz?=
 =?us-ascii?Q?0mzUOhZZQn+JbOZp49o3uKLziIBNptzZulWLKtAdxrg4XnNS3bluP18tra4d?=
 =?us-ascii?Q?LDQZGebnH9W620rWFPQtsMPhaKHuSEbzVKGoOeDSsOcJsArhiVuPGFmADaYL?=
 =?us-ascii?Q?Pv5M64m/KCw3XjWC1ekd5rFItt/pdHyTwkSzZ254gQk0AjqMYEA/3ZINxY4w?=
 =?us-ascii?Q?aGwobH46T7+liJXNvdqpD4SOmX0lW0PD1SGtXg85uMAWVy51GW2OckFDG/sY?=
 =?us-ascii?Q?q8DUo/ueHHajHnTi3WQWxg8NeqCeGqACP0Yl9hLxUEFCD2uShsf5YQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:27:52.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bc9582-ce49-4d1f-73a6-08dca7d510a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_logical_die_id() macros, no longer returns package id, instead it
returns the CCD (Core Complex Die) id. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

For more historical context, please refer to commit 32fb480e0a2c
("powercap/intel_rapl: Support multi-die/package"), which initially changed
the RAPL scope from package to die for all systems, as Intel systems
with Die enumeration have RAPL scope as die, and those without die
enumeration are not affected. So, all systems(Intel, AMD, Hygon), worked
correctly with topology_logical_die_id() until recently, but this changed
after the "0x80000026 leaf" commit mentioned above.

Replacing topology_logical_die_id() with topology_physical_package_id()
conditionally only for AMD and Hygon fixes the energy-pkg event.

On an AMD 2 socket 8 CCD Zen5 server:

Before:

linux$ ls /sys/class/powercap/
intel-rapl      intel-rapl:1:0  intel-rapl:3:0  intel-rapl:5:0
intel-rapl:7:0  intel-rapl:9:0  intel-rapl:b:0  intel-rapl:d:0
intel-rapl:f:0  intel-rapl:0    intel-rapl:2    intel-rapl:4
intel-rapl:6    intel-rapl:8    intel-rapl:a    intel-rapl:c
intel-rapl:e    intel-rapl:0:0  intel-rapl:2:0  intel-rapl:4:0
intel-rapl:6:0  intel-rapl:8:0  intel-rapl:a:0  intel-rapl:c:0
intel-rapl:e:0  intel-rapl:1    intel-rapl:3    intel-rapl:5
intel-rapl:7    intel-rapl:9    intel-rapl:b    intel-rapl:d
intel-rapl:f

After:

linux$ ls /sys/class/powercap/
intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0

Only one sysfs entry per-event per-package is created after this change.

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Reported-by: Michael Larabel <michael@michaellarabel.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/powercap/intel_rapl_common.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3cffa6c79538..2f24ca764408 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2128,6 +2128,18 @@ void rapl_remove_package(struct rapl_package *rp)
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
+/*
+ * Intel systems that enumerate DIE domain have RAPL domains implemented
+ * per-die, however, the same is not true for AMD and Hygon processors
+ * where RAPL domains for PKG energy are in-fact per-PKG. Since
+ * logical_die_id is same as logical_package_id in absence of DIE
+ * enumeration, use topology_logical_die_id() on Intel systems and
+ * topology_logical_package_id() on AMD and Hygon systems.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 /* caller to ensure CPU hotplug lock is held */
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
 							 bool id_is_cpu)
@@ -2136,7 +2148,8 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	int uid;
 
 	if (id_is_cpu)
-		uid = topology_logical_die_id(id);
+		uid = rapl_pmu_is_pkg_scope() ?
+		      topology_physical_package_id(id) : topology_logical_die_id(id);
 	else
 		uid = id;
 
@@ -2168,9 +2181,10 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 		return ERR_PTR(-ENOMEM);
 
 	if (id_is_cpu) {
-		rp->id = topology_logical_die_id(id);
+		rp->id = rapl_pmu_is_pkg_scope() ?
+			 topology_physical_package_id(id) : topology_logical_die_id(id);
 		rp->lead_cpu = id;
-		if (topology_max_dies_per_package() > 1)
+		if (!rapl_pmu_is_pkg_scope() && topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
-- 
2.34.1


