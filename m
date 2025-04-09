Return-Path: <linux-pm+bounces-24980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F0A81C34
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 07:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F7C1885290
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839741D9A54;
	Wed,  9 Apr 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAp9ECwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EC1DA31D;
	Wed,  9 Apr 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176952; cv=fail; b=ukSMC+jG3QJxNtOr+UAET7rMi021U2v2ehgOFBv8mKDsKZ6BFeQw1W6Zik/UscDkIHyKmNJ1FLtKv3hxZxf/MJOTRq/qsuPliQdKEwnuvR1UTES7Ae+NJ4CgPU050JXgVfzFZe2Q2g9sArLkY6xOLa4MdoGKFCDTifq5joDTW/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176952; c=relaxed/simple;
	bh=ch2OO2uTFB++vKi2+f1AmC4xBJXbFwWRLby8k++DEiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d342Mmc+wKq4lHa+wKcwGhbpe8j9de6wwyNl/oCAuWodGwziOVb592PW1otUDo5DdPcpXmYOCk74LOa2yfSeqI00saSLkzb36I9o7oat1qG63MqQuhDkw7bxd+oYa0+kANQAVdISienqGeNB5l48nAxnYagTrTP0WSloyV1/oVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAp9ECwL; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiLYbBsIImWNERnKOKH69jIla+kTktNKt7HKWpQAn84TeYwTtqJwlglFsjWWO+usrCmX70CzsRIX87jD13w9AfZAJUZTo5j4DGCq5k4LmxWluntxFSGdXjnug93XMWcx/YEVdkEFTuByGjmB8vgHClRV8X9U4eTnNsSlyZsp8AUkxrdcU5a767DqDzYwhCN/DLugJiRtBt7qxzuzznDCNpyyemCzmaMZY3cOx9sUrsKO2N/12Z372+0VPCAwtkzJ2ljhZIZwVwdm++gqNgZZ2RdyblRvIliox9OypiTp3WrI1WYIdChTdSTakfKffEzXG6Hq7cScp/5pE3FE/g4kTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILSpoY+KJ7iz7AV48G5OaYYYNNxC1jjMGxxokpXzcuI=;
 b=YDhBgmz9vTOuZfJG78iyBYwz7J9wpLCPR9aXvMbDqAsELD48U6ZaUD+5dKUOf3WmM0yHieQhgDh8hBZDvUxE7l1KieMcfjQ9NxoBogafsjCDgX355vhdpSQBAaWZ2GQFtkt0VrLXs/b+yNQeBnbbNqN46dO86scVzkQ/MvBwsxiNfnkCqOdPz8Ke0E5zVOKbYlosnJSLWBCYHxTTAreakpjBCvEacsSM3/pBaxX0Cf06qXEWJXZrecYVf/xE5FnCyxfmf4pYamD735ypJFFFmmrzgR8PEV8Ka+4tTNWxDwlseSuiM3s6zeA4D8tHRCk2vG7t2HQu2hZHlaAtf4zYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILSpoY+KJ7iz7AV48G5OaYYYNNxC1jjMGxxokpXzcuI=;
 b=KAp9ECwLFn/n0bAPEwjcN21meoXO+AnNFgHuaCnDMssqqlc3toja/nWIc8nAOMSXU8hJXVxiG6ldhISK9tkIrHRiMFcaVJF5yog7WT2QClyxNqlVCXthui1ob9g3lRgtUjv7I+3xUOaSRBZscmX1z+jJfNx2iH1bJYhdcSQ1e3k=
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Wed, 9 Apr
 2025 05:35:47 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::7e) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.28 via Frontend Transport; Wed,
 9 Apr 2025 05:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 05:35:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 00:35:38 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Waiman Long
	<llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, Huang Rui <ray.huang@amd.com>, "Perry
 Yuan" <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 2/4] sched/topology: Introduce sched_update_asym_prefer_cpu()
Date: Wed, 9 Apr 2025 05:34:44 +0000
Message-ID: <20250409053446.23367-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409053446.23367-1-kprateek.nayak@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 334b92e8-d2ff-4fb2-d10a-08dd77286047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/jkuA3i9ySLKpNiWc9C1wUmKGtpq57QX7N93VZ0iYGGNspcLcJFqNb8Fnju?=
 =?us-ascii?Q?01fVagu2mXFOKUmxcENDkNGkxc3fsCPBlYhPHyt2+vZNJt+GAoHts6+ZhIRM?=
 =?us-ascii?Q?Eod3bvHzmJikuMMzHqdG+rBtC3pa8/BVYKPnwyQX7wrmdvnp5ngloT1wGgVy?=
 =?us-ascii?Q?oUUcL5jhLLrpjGXH1trSkJmurAi21aYzIpQ+XSUjyA1At0UiIoTTPmCNb7UN?=
 =?us-ascii?Q?rygJMtiFgItZxIORT68mOl6olHOO0I+UMTTJnzt7/rwSWXe4ozcrkzSQxaaF?=
 =?us-ascii?Q?XUUZNafTfFgV/0PCF55oqpR8nlTlr8WsIYmDHyG3pRCB5iUTpBPCF6QDFJRZ?=
 =?us-ascii?Q?im9EG2SDc3uiKzLYSnXmsEROcEpCFfKPeguah7p/L+P6eDDMzVfxu+FtYRXr?=
 =?us-ascii?Q?1i0KGL9d5b7S35lZHjnJWqfu/AsORla+S6ZS00rtby7TVPDxk823dTMNLekL?=
 =?us-ascii?Q?xVnvXifWJfoWX5rS2QM0fgIn/feZ8bb5GvbxwHmstpLzIKkTFKhjhP+D0lmm?=
 =?us-ascii?Q?yYpUqwY/D11uRdR0px6b49RPao4a2IPFFod/KmHWi4CzvBZUVxbwSmbU8hmY?=
 =?us-ascii?Q?b77/JWWGzMb7buE+Xgz63BMEtAALfk0Zg+cRCcknUs0/Q8IG8KkBVtEG1Beq?=
 =?us-ascii?Q?eiEQIjCAoYU/HyQdx0/gRAgKRPethfGlv2fkHp6iYeit8XskV5KjkFYSzAz6?=
 =?us-ascii?Q?StdizHBjGwSeaLlIr27Gm5lON11+YA7kQMQzD6k7Tr3pAchsF7p7c22YuVd1?=
 =?us-ascii?Q?qUbXKPhVKdn5OXDbgSlhmrF0YM95cdU/6V7V7A1gN+oEpKPXSfF+WPjKYpi8?=
 =?us-ascii?Q?S0ygGvGWTurozk6vWHqGL1XXFnRahZ9JidMtafRzUNOWxLEUmOYlGtyi1oT8?=
 =?us-ascii?Q?XCZ3ZzeVwJ9ERBUGN+mMpoUrIivWG37LW15AxeSks63tP+jDK2JwKaGUTyY6?=
 =?us-ascii?Q?CRZHOOCV3dBYk8FCownd81BgcOtxCE0A0QLLWrMqX0QfPvawCkqB00e2TwYA?=
 =?us-ascii?Q?78ZknisWaOUJHFk0wIef49bsD3euS+NdnZGkH2/Pp1f4XXezzeeD584bdNqP?=
 =?us-ascii?Q?4ig2et/VXNDGR6XRUK6rLyWy6n78h3iYhOKxiU82OOth+HU4sGLaup+siNEK?=
 =?us-ascii?Q?2jBH6p8i+nN+FnjpP1oRNV17aHaVjsnesG8EnYsqVoJnv4CTN6odY+5jvFcU?=
 =?us-ascii?Q?0jvPmZTHivgS0CC3vclZj9FQfElmK6OkbrGyIU5L3Kb8NEK6afy9+/Z8/JvV?=
 =?us-ascii?Q?T+QWe7qlpD73GURIDvd340bQAEwgvWLt0ff9bR/z370dGupff5jWhBZcqllO?=
 =?us-ascii?Q?05QPU7VuT9zlThZqO8sekJY9g1E+k1TGNUNPZqylt4jz/SfKovNDxB4XOAJJ?=
 =?us-ascii?Q?lknSA8gsknnU1jnPrifun5sfL+oObQK0w8qyAHRnDoZEsuddhNbUhbCHjsP8?=
 =?us-ascii?Q?OxcDHloqJbXx0nvGaIMKhD22EU001RKeksp5APzjbD1w8Oy4bZg/UGj4vL0T?=
 =?us-ascii?Q?yR5JlKRX4SzosZZBFY+q5s3pVFIqgHKfX2ziDvYFALSaT6ZOks8BzhM6hg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:35:45.3257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334b92e8-d2ff-4fb2-d10a-08dd77286047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

A subset of AMD Processors supporting Preferred Core Rankings also
feature the ability to dynamically switch these rankings at runtime to
bias load balancing towards or away from the LLC domain with larger
cache.

To support dynamically updating "sg->asym_prefer_cpu" without needing to
rebuild the sched domain, introduce sched_update_asym_prefer_cpu() which
recomutes the "asym_prefer_cpu" when the core-ranking of a CPU changes.

sched_update_asym_prefer_cpu() swaps the "sg->asym_prefer_cpu" with the
CPU whose ranking has changed if the new ranking is greater than that of
the "asym_prefer_cpu". If CPU whose ranking has changed is the current
"asym_prefer_cpu", it scans the CPUs of the sched groups to find the new
"asym_prefer_cpu" and sets it accordingly.

get_group() for non-overlapping sched domains returns the sched group
for the first CPU in the sched_group_span() which ensures all CPUs in
the group see the updated value of "asym_prefer_cpu".

Overlapping groups are allocated differently and will require moving the
"asym_prefer_cpu" to "sg->sgc" but since the current implementations do
not set "SD_ASYM_PACKING" at NUMA domains, skip additional
indirection and place a SCHED_WARN_ON() to alert any future users.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched/topology.h |  6 ++++
 kernel/sched/topology.c        | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7b4301b7235f..198bb5cc1774 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -195,6 +195,8 @@ struct sched_domain_topology_level {
 };
 
 extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
+extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio);
+
 
 # define SD_INIT_NAME(type)		.name = #type
 
@@ -223,6 +225,10 @@ static inline bool cpus_share_resources(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
+{
+}
+
 #endif	/* !CONFIG_SMP */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bbc2fc2c7c22..a2a38e1b6f18 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1333,6 +1333,64 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	update_group_capacity(sd, cpu);
 }
 
+#ifdef CONFIG_SMP
+
+/* Update the "asym_prefer_cpu" when arch_asym_cpu_priority() changes. */
+void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
+{
+	int asym_prefer_cpu = cpu;
+	struct sched_domain *sd;
+
+	guard(rcu)();
+
+	for_each_domain(cpu, sd) {
+		struct sched_group *sg;
+		int group_cpu;
+
+		if (!(sd->flags & SD_ASYM_PACKING))
+			continue;
+
+		/*
+		 * Groups of overlapping domain are replicated per NUMA
+		 * node and will require updating "asym_prefer_cpu" on
+		 * each local copy.
+		 *
+		 * If you are hitting this warning, consider moving
+		 * "sg->asym_prefer_cpu" to "sg->sgc->asym_prefer_cpu"
+		 * which is shared by all the overlapping groups.
+		 */
+		WARN_ON_ONCE(sd->flags & SD_OVERLAP);
+
+		sg = sd->groups;
+		if (cpu != sg->asym_prefer_cpu) {
+			/*
+			 * Since the parent is a superset of the current group,
+			 * if the cpu is not the "asym_prefer_cpu" at the
+			 * current level, it cannot be the preferred CPU at a
+			 * higher levels either.
+			 */
+			if (!sched_asym_prefer(cpu, sg->asym_prefer_cpu))
+				return;
+
+			WRITE_ONCE(sg->asym_prefer_cpu, cpu);
+			continue;
+		}
+
+		/* Ranking has improved; CPU is still the preferred one. */
+		if (new_prio >= old_prio)
+			continue;
+
+		for_each_cpu(group_cpu, sched_group_span(sg)) {
+			if (sched_asym_prefer(group_cpu, asym_prefer_cpu))
+				asym_prefer_cpu = group_cpu;
+		}
+
+		WRITE_ONCE(sg->asym_prefer_cpu, asym_prefer_cpu);
+	}
+}
+
+#endif /* CONFIG_SMP */
+
 /*
  * Set of available CPUs grouped by their corresponding capacities
  * Each list entry contains a CPU mask reflecting CPUs that share the same
-- 
2.34.1


