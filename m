Return-Path: <linux-pm+bounces-11620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17089406A8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D312822FA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416F15CD41;
	Tue, 30 Jul 2024 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svg031hv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3C13B780;
	Tue, 30 Jul 2024 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315196; cv=fail; b=SUK14l7RjjnIJzj9z9b1e+z6LICYrnTvC4ZOR3oNbCo+XIY0fiVGN00RxUMCA0kQmWA5ftiS0NYTdHEZV8UH3GGQr/5pBo3czNhIBac0dgqx7oBuSkgS8J3Dw/8coHs2OVX+zrA7WEdyPNdQLcvMa9dil5rTE4GVTXrbJUuJHYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315196; c=relaxed/simple;
	bh=nQmt7NnUDNm18+hRH4KTRL/NtveGR0rEJ4EMinAfOTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g42fdFQaa3npHVUXXfzJXye3DmDbMackwOIXWWKmbFiwRFCsF8BMRGE/IZCHBWb84TYWG/UVyLdx2/oyg0ItQ8rdVbQKx+xCU+nH/65Xflpet16kf/KKCt4tnbpDqxz0Zxscjd4lNNY1FxsNFIKaTIsSohM0sRfadiTu1PrOf5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svg031hv; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izbe9E5pe0N7nu+oe1hj1xe8C0kOfXNxjYEOk/JeYlkDSPhf/suqJL0J3ehEKkpIvaxdQHhIeZJ+BGrwMuOhiZVAEPn+jDIysn/ORgc+y3hqalweqDde3qPE+dLKiCQGP2gWu3vp9sYTxN//d4gD74PUydMLotMVu5NZeC1HBmmhStAvPXbb5vdyJdz7aiVrFPhXgptc7AmbBcaTRyijMSESKfkq74cZ9+AnjWSpSETN9qjS48pCHUGDpw34CQZxRyrBYnJ9u2SDyLmP2SABel2iDAK8+/Y9bFgewar6tfFQqeHQdD4l1Lar0aGSEOwo3lvG/3AwVpfaPx2TwwhtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8kPrJMXZ0xSnt1N+v+dzN+i7G8A6E4hS7geXvwHKLM=;
 b=mL+TxTWEdisGkl/0RT4XFpnTED73fj46vdjPnWYffRoJJ5auQQ6CeK0lpwHZQZgA7+2kIGwx0KZ9FIvltX0rKshrH41uw2GOQFvevId2xZn3787ZBqcPekq3ficdppWG5U5ZJXj1mfGXakFhLOBri9f9N7WWipailcamg9x7JcqnEYSb7+AwbJKfT0W0HMuoe6M9f3nyrRWRk3jkqDII+ntgm+AoZJzYPhR0Be+ow7eVaxVM/Xl5nOdOeIP0ijWrXDwlwN1+q7z02hdORQ5AUtUnVNHl9UdvaT+Vgf7sDNa/jjXfPSRks5spo0ZX6nPY85WtZVqXBjuzd5ruP/pS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8kPrJMXZ0xSnt1N+v+dzN+i7G8A6E4hS7geXvwHKLM=;
 b=svg031hvh0O39iwsiuuHvs/qHBBaOwUyUDw7LHqZBVqsuEdKex6Jch8gZi1Xvt3lReBepxNXF+jQO4PYR+I5cbodGxJSwDa4fVF1TJzsWi3fOb11nyLsPx9honBBLX8swPGvRJ5+hV1/TbHiYfCwrg1KxL9BWjOS1xii6aaQOe0=
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 04:53:11 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::37) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 04:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:53:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 23:52:58 -0500
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
	<Dhananjay.Ugwekar@amd.com>, Michael Larabel <michael@michaellarabel.com>
Subject: [PATCH v2 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs
Date: Tue, 30 Jul 2024 04:49:19 +0000
Message-ID: <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b8ef94-4ef4-49cf-e987-08dcb0538386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avg1mzJiEimadqRpO/kiR5Qn9NhTWdbnaSm/+pe2C6/PtnViyrBLYFKTiKbI?=
 =?us-ascii?Q?hTpthzXOL4HBua//LFlzfJ7jxwDT5Z/xpxJ1PpYlRgt6HVh2fzFGwmqhgr/J?=
 =?us-ascii?Q?UXHMN5KAnwTO8YGBuagGRilmdT1m8i0SlKx8snq8PzHcJOi+4UaD6DlkVoCb?=
 =?us-ascii?Q?WNPjkQ157VStmkP639Oy/mFy8e1oaaNZlu4ACxFRFnLxJ0s2Pso/XdRhfWKZ?=
 =?us-ascii?Q?3StazEjaynGVcwgxnZ5n4DUzOFe3veBSdAcDtzZur679Q8NP+Va5mqBJKJbo?=
 =?us-ascii?Q?6IC1mF+TdEveKCoC/eL7LntjpPXaDL83UMr2Dk76I4S4/GU7QIt3X2UAD/1G?=
 =?us-ascii?Q?HVYFmBfM0V268jOzrEkPz5ZOP9urgBHzr575GfFqh2qUpDbKRNyqxztKKS9K?=
 =?us-ascii?Q?I3mjjkR6Q/SlFUvN+K5b+4OCZWoRX+8jgcdpZOdtt+qbOd11IBuOUygxSE0Q?=
 =?us-ascii?Q?VtcN2ahwwkO0cK0gSjLm7CEvCy4W/30hJaC3Bq7XrgzRwzX7LhmCScO67cWn?=
 =?us-ascii?Q?Tw7hS0tf4mWgqKekbr/L4jOOLsQYk0qhilXCKNG0HP2VYjq0xCyLtQjcWUt/?=
 =?us-ascii?Q?6GSg1jhHoMDEooA6d5sY+2NJrjvHk+wghq+O7oKrFuqQ9d43UVFzycmFuC5m?=
 =?us-ascii?Q?NgF/+vla+IV1GqSZok2BD/p+2jpCSFwbj6VnLCg/gHLDJcOJ3mc6lRKibuJw?=
 =?us-ascii?Q?clkEQnuikJCnpQVC9188q3uaxLbJ24lJN/azEQN+PXIt2muyixfRU0wEFhcE?=
 =?us-ascii?Q?kyqGCjWQe1nbUecOFLhdcrFdiM6UMDlGzUavZ13WPl6j8wlj9u4KDQxzaeLU?=
 =?us-ascii?Q?cuB2ocMk61Ru1KfDpejDcXCBPKSiQf4TJ2WZjTlv3N5DQ4i/kcHgMGMlf34E?=
 =?us-ascii?Q?OzvSU/IW7YPf8WE4NTOJQDLlKjpSo+cwsvOhcYZ3+7CeSyGcwKPuaS5vd+0l?=
 =?us-ascii?Q?isvcU9prQWBve0wDc8MR/jHfD6NVEDA+ea/n8SaQosDIb6YJFjnP2vZWDGtb?=
 =?us-ascii?Q?JiCcbOcDD73gX4DO5IBoQbPlmIdzfwQgD9RWC9pa+tGbm52HZg65o74ZR3lM?=
 =?us-ascii?Q?l2EAggteXQMIPQMU1Y26OJsJ3TXKxiNPBpkqZvzLbLAPqvMeaZxaBj4O+5K3?=
 =?us-ascii?Q?oPw4HPF12zaGs1rwQUd5clj3Ku7B/LUU8GDsk0Y96yqKSUEcEPFQ8qmGseD3?=
 =?us-ascii?Q?bBLmg7H1TuwHRPW/l35fCiRDQQu3Uwk69mqz9QgWw+Kh5TNQBEU0FoIxhtLl?=
 =?us-ascii?Q?jFS9sc4CMWLp3109p4fBde9/lUc10tobQVYx69MYgPo+q2hGPUDUdvwC7TAD?=
 =?us-ascii?Q?M+85+4FBc9kAovl8ivd8XEIwzbElldA5aFsesxZnwCNN2fyiviaUfasi6d0q?=
 =?us-ascii?Q?LEfmjCCdjKmHKxynlgT0F/3rTQFVRe+O0DWeIKLrx5lphhW+8L/NZRcs8DZE?=
 =?us-ascii?Q?jJCBVn3i1S8RJ2VOW8CcT+DhZLxuuxmv4dGNDr/8o1nY5jEbgv2bZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:53:11.3792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b8ef94-4ef4-49cf-e987-08dcb0538386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735

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

Future multi-die Intel systems will have package scope RAPL counters,
but they will be using TPMI RAPL interface, which is not affected by
this change.

Replacing topology_logical_die_id() with topology_physical_package_id()
conditionally only for AMD and Hygon fixes the energy-pkg event.

On an AMD 2 socket 8 CCD Zen4 server:

Before:

linux$ ls /sys/class/powercap/
intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
intel-rapl:3    intel-rapl:7:0  intel-rapl:c
intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0

After:

linux$ ls /sys/class/powercap/
intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0

Only one sysfs entry per-event per-package is created after this change.

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Reported-by: Michael Larabel <michael@michaellarabel.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---
Changes in v2:
* Updated scope description comment, commit log
* Rename rapl_pmu_is_pkg_scope() to rapl_msrs_are_pkg_scope()
* Check topology_logical_(die/package)_id return value
---
 drivers/powercap/intel_rapl_common.c | 34 ++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3cffa6c79538..4bc56acb99d6 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2128,6 +2128,21 @@ void rapl_remove_package(struct rapl_package *rp)
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms use per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1 CLX-AP platform has per-DIE package energy counter
+ *	2.2 Other platforms that uses MSR RAPL are single die systems so the
+ *          package energy counter can be considered as per-PKG/per-DIE,
+ *          here it is considered as per-DIE.
+ *	2.3 New platforms that use TPMI RAPL doesn't care about the
+ *	    scope because they are not MSR/CPU based.
+ */
+#define rapl_msrs_are_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 /* caller to ensure CPU hotplug lock is held */
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
 							 bool id_is_cpu)
@@ -2135,8 +2150,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	struct rapl_package *rp;
 	int uid;
 
-	if (id_is_cpu)
-		uid = topology_logical_die_id(id);
+	if (id_is_cpu) {
+		uid = rapl_msrs_are_pkg_scope() ?
+		      topology_physical_package_id(id) : topology_logical_die_id(id);
+		if (uid < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
+	}
 	else
 		uid = id;
 
@@ -2168,9 +2189,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 		return ERR_PTR(-ENOMEM);
 
 	if (id_is_cpu) {
-		rp->id = topology_logical_die_id(id);
+		rp->id = rapl_msrs_are_pkg_scope() ?
+			 topology_physical_package_id(id) : topology_logical_die_id(id);
+		if ((int)(rp->id) < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
 		rp->lead_cpu = id;
-		if (topology_max_dies_per_package() > 1)
+		if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
-- 
2.43.0


