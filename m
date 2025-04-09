Return-Path: <linux-pm+bounces-24978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD1A81C29
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 07:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EDE1B683CF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B331DB122;
	Wed,  9 Apr 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WVCiidWo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB971624CC;
	Wed,  9 Apr 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176917; cv=fail; b=kiy9f2Xuab4TZ3n9WpdtvmundH0SM64hpLuEPUlcotd6p9wwGcGXs8CyN9KgGE3zh5DliGnf6yVZWsvHo6zvffUs6MyVHXi0Mr5pe1dWupEN9gFwKwclMcKdnQYPJQfurMYwVWic+LUmwAAS5S3DIVqZIkbWW6f4KUZH0blZ2/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176917; c=relaxed/simple;
	bh=Iqr4YKD9MB/UUqBa4I9lrRYpcd6Ka5Pg2rFgxEhqjoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDZHkNowqqkwJFLxm5+geSgHJVFsNkUbmhxrsdfNT/qeOb9GqFBQglrN5TZjqDectIM+fmGgPr1KPBgeYQ9ib8XDg4hbmeTt8eqjizYLc4UbGqpINK5TxW/Z4gOu1D1QGqtZ7iqw78sCRCHArd0u0F7x+PHXLiF835CC7mZAhBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WVCiidWo; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Hm8j5c2GfbiKaPoiq3foBzvJrcFytjFOgFNSFfkJHY+2i9aaD2KHzEmWA/7qnRCO0Cp+rKdLk65OzNEVQRG109MXZAnEZLdM995vJB2hxiY84+s3wDorb3JrNUK1KdauM8bdpxzBNZgAuqZiuuXJg8teqMJdd+Yaun2u0woRRteNc9Nti6ExU2UV+HrTXrREIu4OdKJdsZ/FHo5zb94Stlq3ril7GdQ4evinSKgWt8WTsTall8s1536Z/7KikPpuc8Q8PSuj+OVeBbBM+se2TpQdJME3WF7SKH/iH5I7qwh+U06tRtAgfsoFDygdqBRu/LuNGkBH3pH+4IzJ3u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdQVb3bbGtqZ/BYLRMuJXZeyYReKoNn07YWrD9zfhM8=;
 b=f6N58l0YeIs+LHs9fptKHfRDEWkY81uIQIqxBD71LFgl2MNjdgiMxGPWmdXoKD+97gIKcGPd6ceYo+E7wQPpOS4Fk7YI1hBmg0gnH0/3Sk4TAcq/JrNuLUEPtriNDpAKDoHqneAPtA6wxm/1CXI+6e7jjqrIepiBlVDArMwPRDdZYVciAnq+g3eJ24hsYutwhv1FwSOMVnnsYmxyJ09IcNJFuYCGUv9MhMsOmMXO+fPF+oJuhpHpzBpDslnon2ltYHn5IwQ720RaAA/NPpKtMP5OCaDd8P5685hqiZkMqqQOPgn3dAtoYEjVGdA9GNW4a1+FUGFLYy4AuinCptv2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdQVb3bbGtqZ/BYLRMuJXZeyYReKoNn07YWrD9zfhM8=;
 b=WVCiidWo9KenwTM2cK80zAn3+6/J9Di6oGTq8k8+Xuem8xHDIvt39vmB4UnNWpDyBlJe8D5Nf6OEmR+q5II4GfG/OQ1TJdWL54gazllOM4na0pMu3N+eveL4j+k8pwqEX1aMLp5RhqfFK1WaDl/hHYjspPQdmUlFvTCBO0oCx/c=
Received: from SJ0PR05CA0198.namprd05.prod.outlook.com (2603:10b6:a03:330::23)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 05:35:10 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::a8) by SJ0PR05CA0198.outlook.office365.com
 (2603:10b6:a03:330::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13 via Frontend Transport; Wed,
 9 Apr 2025 05:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 05:35:09 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 00:35:00 -0500
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
Subject: [PATCH v2 0/4] sched/fair: Dynamic asym priority support
Date: Wed, 9 Apr 2025 05:34:42 +0000
Message-ID: <20250409053446.23367-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: e3abeff2-fb00-4bdb-ff17-08dd77284ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZEc5195P6FPV9wwboktyx0udzLQxeVGZF1O2r0OvJKTw9U2RZrCYzP3ZWC2?=
 =?us-ascii?Q?vPfaEmoJPaQmueyBZXw5t5keVtfZOP3CrC3trWxffGAGgb4VTEfokD3Yldsr?=
 =?us-ascii?Q?jGJF4M5M9SVl4r58kZjzPxRRnh4Rj1mSYvj7HWepVhHONtxmnAdW/IhJvsgo?=
 =?us-ascii?Q?v4H6P1HTD28xhXPW4VuQi3O3HoYTwV6iiAaUSBeXPc4dJABV8WGLSv/6/ATs?=
 =?us-ascii?Q?yn38NwegleAzVoKc+1DxFO6Q4yH3G5k3W+/g1OANfBSA7jraEDOWz67RaTXC?=
 =?us-ascii?Q?/0pJnqc2krQWOAUDHMixoF3CaR6a9R7itPtAdC8WMTGZrjRZIQ574FKwuVHB?=
 =?us-ascii?Q?v92f2QHIqhJPlJ0hqY0meLjAc+Qz4BeWGqsDnHfPQHkijFUq6ymVUU0RZg1q?=
 =?us-ascii?Q?czr34tL/omf+vEgQUajRs0tw0+VeGDZeCmy9nMYwqABeihSrDYhF7pYEk1vL?=
 =?us-ascii?Q?OY/L49v5/cBSipy/+MxvsMyBjcp/mpa3SDCQ4RvQZMTAL20uhtf9SAuj8Gxt?=
 =?us-ascii?Q?pRpdZOP+3/yGYeqp43It0mNLg6hCoeGE+BTYc7CjoRbdR9iaqqVFluVKkGlu?=
 =?us-ascii?Q?TRIsa6V4y8uWXBApBbCSXmrFHbC+SIrbzuecyhXz28pjugnRcgzUxreInDC3?=
 =?us-ascii?Q?M5LPXhxqD3tDNGr1pDJ9LW7cSil/kIL+mpOW63CF/VKxrSkjk+t4yZttl01s?=
 =?us-ascii?Q?ZJIvjw8dkTSUGppf2/riTlv0WoiqNSDdOW13ac9c1w2Co1XshOPAcz0runtx?=
 =?us-ascii?Q?mPBnPYPHsbd9ZLi8wI5r6v/TO/yjFs2HQMgFraAlaNsx4uR0OK3Ch4u2eTH6?=
 =?us-ascii?Q?9qfQUj97DYO3yRK7tjnIs4R+/PhxKr0Eyz0uojNeyBQV5SNMS4KZY3KbxZIH?=
 =?us-ascii?Q?0YtmCp2UEw8dH43Tg1Q23+NrVJY7vcdN48X+tP61ShLOwqU6MZne5pmr90k1?=
 =?us-ascii?Q?nwPQxaZp9kUxjqeJrk8lhPNr2VBZMUv5fNz1jStnw0tEJ0isUwN0FLuirkL4?=
 =?us-ascii?Q?uOTcOo9ZESNBVcb7OTP2VTFH93g3JH+Ylzp0OyPKcsIHcV6GlHPf9nieio0o?=
 =?us-ascii?Q?IbR4pR7VGVJIqAOUT1fnr7s28wd18C6UD0vYqYpwkyGy1zCGQ6T3Dfjtria5?=
 =?us-ascii?Q?c3u2b5rB4wpJGx1nKIhnt2D1lPzZw8uKZncu6h6JEOWKICN0JZLkmbfw4vwd?=
 =?us-ascii?Q?hYYfLfmP6FfnwayCa4fx1Sevl61BxPrpZlGDRYTVTySehFPLZEGWT1Op+SqF?=
 =?us-ascii?Q?yO+73PoxzOGebSZh9skPXUZ/sI4LW+gPMciFneo09h13iP6FKgVBCf/P+dbf?=
 =?us-ascii?Q?5Bylt7/k990pKfd0uG1XO1O3D3EzpQgG3L7VIjys8ADZFyKK2S4Br8Q7kg4q?=
 =?us-ascii?Q?334gpsadgBBbla4UQwGFMWtpPUxGYUA5eaKvjiX9L2CLH/BzblQuIOhWK5TE?=
 =?us-ascii?Q?ZTZ+Yj3XwRJtuUSSw8xLX1Um/pLaajPaP/U/mlk15BiCn9HfqVJmmJmpp64o?=
 =?us-ascii?Q?xM8FRDSqNLf0ATI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:35:09.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3abeff2-fb00-4bdb-ff17-08dd77284ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587

A subset of AMD Processors which support Preferred Core rankings can
have these rankings change at runtime to bias the load balancing towards
CPUs with higher frequency / larger cache.

In the current implementation, the CPU with the highest asym priority -
"asym_prefer_cpu" is cached in the sched_group struct when building the
sched domain hierarchy.

Previous approach in [1] to uncache the "asym_prefer_cpu" and compute it
during load balancing was not popular as it not only lost the benefits
of caching but also added more overhead in update_sg_lb_stats().

At OSPM'25, Vincent suggested retaining "asym_prefer_cpu" but updating
it dynamically when the asym priority changes without needing to
rebuild the entire sched domain hierarchy.

Introduce sched_update_asym_prefer_cpu() which traverses the local
hierarchy on priority change and recomputes the "asym_prefer_cpu". Since
sched_group for !SD_OVERLAP domains are shared by all the CPUs in
sched_group_span(sg) (see get_group() in kernel/sched/topology.c),
updating the "asym_prefer_cpu" in the groups of the local hierarchy
ensures all the CPUs in the group see the updated value.

Groups of SD_OVERLAP domains can be supported too but this involves
moving "asym_prefer_cpu" to "sg->sgc" which adds another level of
indirection. Since there isn't a use case currently where both
SD_OVERLAP and SD_ASYM_PACKING is set for the same sched domain, v2
keeps things simple only extends dynamic updates to groups of
!SD_OVERLAP domains. If this future looking enablement is required,
please do let me know.

Printing the "asym_prefer_cpu" for the local group in debugfs has not
only proved useful to debug this series but has also helped uncover
other unrelated issues like [2] which is why I've retained it for
inclusion.

This series is based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 6432e163ba1b ("sched/isolation: Make use of more than one
housekeeping cpu")

[1] https://lore.kernel.org/lkml/20241211185552.4553-9-kprateek.nayak@amd.com/
[2] https://lore.kernel.org/lkml/20250409030004.23008-1-kprateek.nayak@amd.com/
---
Changelog:

v1..v2:

o New approach that introduces sched_update_asym_prefer_cpu() to update
  the "asym_prefer_cpu" dynamically on ranking change without rebuilding
  the sched domain hierarchy.
---
K Prateek Nayak (4):
  sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu
  sched/topology: Introduce sched_update_asym_prefer_cpu()
  cpufreq/amd-pstate: Update asym_prefer_cpu when core rankings change
  sched/debug: Print the local group's asym_prefer_cpu

 drivers/cpufreq/amd-pstate.c   |  4 ++-
 include/linux/sched/topology.h |  6 ++++
 kernel/sched/debug.c           |  4 +++
 kernel/sched/fair.c            |  5 +--
 kernel/sched/topology.c        | 58 ++++++++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 3 deletions(-)


base-commit: 6432e163ba1b7d80b5876792ce53e511f041ab91
-- 
2.34.1


