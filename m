Return-Path: <linux-pm+bounces-40266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35212CF70DE
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 08:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A26C93002163
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0ED309F02;
	Tue,  6 Jan 2026 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r3l9q7Zk"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1943093B2;
	Tue,  6 Jan 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685003; cv=fail; b=VuaPnGONjL5nnNi6Zm0dgnWzLu1QOLkmtY5DaEG5s5/V3yGct70j38XJl3mr6j4QAqGKYO9srzx9sLFg61nFnZof1GRTvEmsvpIcn4Jqj9+RElcnl56yyoi21FxjKzFvscM/sh6THGH91bkGsG2+EFbEYMIfQT9M4FEYMdzogIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685003; c=relaxed/simple;
	bh=Z0c5hW4iN0W0C6qpGWWK/x3R+2nhtdtx0DbFMGewLz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9Ax9eMshDc5mAI65vp9ZTB1OB+fLedoNH8ZXfPYm9uggwunC2MveQSPb3TQhi1urQVO5ycK6wru2m8SWHEEZ7PEYz9Munmj013zoq72VXGgM3WWFm0mc9YGZ8zNu3PZfv9QbsWOcsABzI6Ed7S7mayDKcSqGs2AmOxZStFtS+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r3l9q7Zk; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNaw5CbjxPdFbAy4YTNwZdwszVW/OPgnSuRX6Y38z5eg6OAct+B8Y7z4CF8ZtynkMaOk6N5E0ZvNm3Kn1vNIPPAlGGBbGZ16yng1oaPIsJZbqzUF2nMdj4zLiHaxW7HnTOKUH2a/BSiTDuT6aqfLC5q/iIJnHPeSB7NAJ0/WDb6uilymepsMGrjQ/+sR8Ros2lbWgEbc5H/5OlLKI5k8euCiUxdO+zMxbgIUaHc83TRVZhYDJ9lmbejVHHFy30iYzwHRqJdtwy+TK51M0HDOxU6yEUoXspY3qZ29UprHULplP2fbFGVz6sZ9Jq+X2C8f/gPAP1csZD8FFcjDn9SaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffNBY5FoTAMpfTo43absTAFkN6GADZ0A3zmayeLid8s=;
 b=fGLWszvtJ2PYgqDBOXYpycy66qQ8qN+/hBg6pQDsXe9+eujufx7lRK0zuzTsAVm+SP56SMDEMlrrr6jFwnoGLQl2K6LxM/fBlOeCd554GCPc9z3Bu3FKiiPydc2qEJSaqK4s9OaDi6OBO4ejtZyEJri+HUVB1lVKbnIBJAwB9LBw1m69/qGK3Bs8piHwB/MRHjme648jstY86NTDj/isiN3csHmfJQIZSPv6Escsr4ldWgESzY+uvplrF1/T6oZvwrWWVBR5kVj57SITWYT1KUIRceww8EUiCFE1x38KHVB3iCVktyH3/Y4jl+YYVtP8tdka6v3uF3NWFJFDEuQ0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffNBY5FoTAMpfTo43absTAFkN6GADZ0A3zmayeLid8s=;
 b=r3l9q7ZkLLLVERyJImMcSPW6IAZ8p5mvkFd3+NpithPm8EEN1L95F9AT87Ias4UbH7Fc/eg1QzxXrMPeO6t8OMUsBufx32pj33PV3KKfOGbCo+AN7tMw+qPViuwWW/c//4WUnlD59JB5b33QDcQxHCBPEEDUktlSRwBfdz2JRmA=
Received: from PH7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::11)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:36:38 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::63) by PH7P220CA0024.outlook.office365.com
 (2603:10b6:510:326::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 07:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 07:36:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 01:36:33 -0600
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
Subject: [RFC PATCH 0/2] cpufreq/amd-pstate: Prevent scheduling when atomic on PREEMPT_RT
Date: Tue, 6 Jan 2026 07:36:06 +0000
Message-ID: <20260106073608.278644-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7d63a3-b3d5-483d-512d-08de4cf653a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1zYncUX/Tj9eGz6QydWZ1LaUO1K5SghLfIrl1QmIt4SDGO9soYIEGnTvFGND?=
 =?us-ascii?Q?Aqrk3owDkYxryr9aKdVqJgn5x0O7gPtjCNDZaymLl+t6hUykwFF1AtF7aqgl?=
 =?us-ascii?Q?qd+PdbyrSEchUrf5waFg1xYE2pzE33wtO2Kza2cqNMhvDEqfd/Poit1QcPsy?=
 =?us-ascii?Q?9NAUOLMwXfU7A51SVO3BiwLdF9SKme6hb5J4cUtojU/TpdTWo0cJT3OMEU3S?=
 =?us-ascii?Q?fXJ1zqXOdqAYMrbEewQ8YK7b7YlK+fgmlP/KJA1N+uSA9SqxCtJPZ+WslqEI?=
 =?us-ascii?Q?D8zAN+d6IrLduUe51yXi5CC439tuQt2vROmJXTBSW1RRNGF7jUItHK4SVqQu?=
 =?us-ascii?Q?y9yTcMDTEfU+lRqpTOOZUZo06VMP5kDMkB1Fq6MOStc0kP43QKpQf3L67L0J?=
 =?us-ascii?Q?8AjFdVwMSzR4mgXQWA/FaBbgcCZs2rs+h9VgODpX6QpxDiybhWfn+G0uAX6A?=
 =?us-ascii?Q?zDQRpZPkniaRD4/5CFJxlhda6enGoMMmeMyjQLgEvJnZyYgZhoxieF6UEOIK?=
 =?us-ascii?Q?d6ePHoQ9fjdNBkVBvE7yR5xR2dKE2fLOlV8LStxtMyXqjMGTWYFy0sdqrPec?=
 =?us-ascii?Q?aFo0jTHfvPTYn5q7ro8RYqxOgIxMVRlOYyGXKNsoPOoKuKtNfHbkdbAEzpZn?=
 =?us-ascii?Q?W2547QdtbBD7qnJebIrj2ViRg+6oPjEbLhJbP0kCR+BleQYXB7Uq3yA20hYJ?=
 =?us-ascii?Q?NupwGKkK1mYthNzNgftvNYLy6jq0PeVyqj7W8aVNY3v5MhfpvR29ubk3cYDw?=
 =?us-ascii?Q?ri119npqW5AQjK2PMRe8jHU3qrugrt4O23cd5WjbQ0ITXe4J7X2cstvcCk2Y?=
 =?us-ascii?Q?DhcJqobZ6oR6zzyCDqx8AsykSZZ8ebaKuBx6O5zzaV1oI791YeSKnfyNI3Fl?=
 =?us-ascii?Q?Fn24D2DjLE09aVPkdx4MTA7iBsW1DGqipim/CnJ1P1JJGJxjgJerDe0SzaUu?=
 =?us-ascii?Q?sPHRBVYvUHbIcHLRRnl5gKU9Kw5JSNFHBgzmeZqRT+SjKpeBznkZo5M9soXn?=
 =?us-ascii?Q?CrIt4ywKLaDhgcuPbvzN66icC9Mfaz/8dxc2EcwTNCXF9ZS0OQ7EOBj6omnO?=
 =?us-ascii?Q?ZwRcOmjy9M4RlivuwGOYTgEwLTpBSN5MPd12GFs1s2mWBFrBcwLNLNCIS8oT?=
 =?us-ascii?Q?sibBKzU95g5/rfS7TW5QcjHfMnqEv0xbEy7WQQ3rO4THJaTNd77oMi5bTFXB?=
 =?us-ascii?Q?BCX4Ftx9fQTaaeAQsiexOjTKzLyXHhTzL4NvBr/cX4PcwmagdKahX6dMbjIV?=
 =?us-ascii?Q?ehTAkyCkoKn2W38F6FsOkHMVW87W8DgqI3wR2G2xMa4V+7gttFj9vfTa5wcY?=
 =?us-ascii?Q?a4VuNaxkWRhzYa31wQz+7v2Br3CMD8PP1mhrPX9xw7ACLSuyDljXOGbSJbfB?=
 =?us-ascii?Q?4tWScObud2bG71Cu/yuxJIcIhlyFL3Ie2vyH5b0Z1rHPQm/Hs6yWtwsxnSwq?=
 =?us-ascii?Q?xXV3ll6xgWRDghHUhjWWE53Az1r9NwisElaojjBUmxkjxpVqU821Vi7AcB/G?=
 =?us-ascii?Q?HhhyQj6VJVQ+JsAEuUD4hdMnOVNx0y8/A/UUfmTG83qEgrkW5npFIyEXrbI+?=
 =?us-ascii?Q?tCScRmHhREpHBFy1eM8OC5smhpHaLtwQLTzodoeY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 07:36:38.1197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7d63a3-b3d5-483d-512d-08de4cf653a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108

Bert reported hitting "BUG: scheduling while atomic" when running
amd-pstate-ut on a PREEMPT_RT kernel [1].

Since reader-writer locks turn sleepable on PREEMPT_RT, they are not
suitable to be used in the scheduler hot-path under rq_lock to grab the
cpufreq policy object.

Unfortunately, the amd-pstate driver has a tight coupling between the
cpufreq_policy object and the cpudata stored in it as the driver_data.

Trying to grab a read reference on PREEMPT_RT can cause "scheduling
while atomic" if a concurrent writer is active, and trying to grab a
nested reference in presence of a writer can cause a deadlock (manifests
as lockup) since the reader fast-path is disabled on PREEMPT_RT to
prevent write-side starvation.

The two patches included removes cases of grabbing a nested read
reference to the cpufreq policy in amd-pstate, and modifies the
cpufreq_driver->adjust_perf() callback to take the raw policy reference
cached by the schedutil governor respectively.

The policy object outlives the governor and the driver making it safe to
use this cache reference from the sugov data. Any changes to the policy
will end up calling cpufreq_driver->set_policy() or
governor->set_limits() once the policy is modified which should ensure
eventual consistency despite not holding the read-side.

Series has been tested with amd-pstate-ut on PREEMPT_RT kernel which
successfully passes without any splats on LOCKDEP + DEBUG_ATOMIC_SLEEP
config. Additionally, the driver switch test from Gautham [2] was run
for 10min on the same config without observing any splats.

[1] https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/
[2] https://lore.kernel.org/all/aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com/

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge

at commit 8aa9e2868a8e ("Merge branch 'pm-runtime-cleanup' into
bleeding-edge").
---
K Prateek Nayak (2):
  cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
  cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

 drivers/cpufreq/amd-pstate.c     | 14 +++++---------
 drivers/cpufreq/cpufreq.c        |  4 ++--
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 5 files changed, 14 insertions(+), 17 deletions(-)


base-commit: 8aa9e2868a8e38ccc5228399fc641d54aea444ed
-- 
2.34.1


