Return-Path: <linux-pm+bounces-40800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CCD1D42E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2146300CED0
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE43803C2;
	Wed, 14 Jan 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdU3ePiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2533803C1;
	Wed, 14 Jan 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380722; cv=fail; b=JimZrUB1+WyDpLATzVnZ8wl7Ts/NCFRdgCnFV8Imsw2DVQBZ0FBCMuzjk22tRLQ/1ri2wSXptig4Pl1DkvUk73eyo20fdRsXlVTn3AjX0ua7tgN7k7S6ClQN4x4JOM26LJvTMBU4bfRyDBwW1Ws7WD/myTZGAdoZBIgbH0bzT28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380722; c=relaxed/simple;
	bh=UUPDWuqz6r+y1Uce0Oyqhfz39YYYLvH2os4fG1u6Wy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PgIlC85cEmmbfu7o9bB2jn4hNvqwLUa29KcFKkgktPS9aeyanYbPPtRGXEbycm3OVXZEiJ3Ni4jBH9SOX+EzmzbM6j3FllgQPQZaU8IDBEsqAQvFZKtN0UU6lwjUj52zmV31a2p0W2s8EjCY4vaGEY6AkkRXeB/E/TgYq4QfSCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdU3ePiz; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+sKYa094wmqZqzZeX9pAvrowmJL1sy+dR5aK9Oz74HGUYN1mNp8QOicW19biKedNZYMCihe3x1yzmUp0faAu9CRdl9mzdzUFXM3SXt6VOajrdhA1w7ByA7/lO0nvglMANw9i4RZ6TnVv/p/RrB6bVdI/7m7wijDcDD7nez8W+/FNpB05Q607hcgbg0uOXi1ZWCz9T055HXxC7JuB0KDTf+TkLU5yXr6Q//jzswsBnyA3U52kGJZkQQZzUfuC0vzCuiFPSwh/aS4V+4WXFjLTJiNIoEEGj8lZEsNw6YXs/sQSSk37UeG39e8vy/sAjUKwnMoqmAG0Ljy1t9ccgWm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dap9frJL0J26nLMX9TAnyfTKh1In/NlCFbjRZggEJZY=;
 b=BbGB6U2z+aGBcArfh50lKRIRqz46eucqtKHzJRwid5LtJrythgqRtsXx+IdAW3IBW8nSxKOGzBSUtt1+DFfW7is81ZIgOep0ziDO7h0VxwteCbj+tc2QHr4r55pHlTNChpiN4hvQN3icyr9jTqtU5Cs9u38jCvfi08NvNDEjQNXfGAyliezNjUj6o5Lke05hBHWS3Mjc4sXQjFhIVMVzz/uOHotVBb5+CJrTpyKmzhyceSa9X6He9EEt6qv2V+wV+dbm17drpr9y+ZfkjWO3wlsKguh1d6IlQDcPbckRNqzJHRgQjJyFdmxCOEut/FuziP8z8F0XeeowL89t/2/kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dap9frJL0J26nLMX9TAnyfTKh1In/NlCFbjRZggEJZY=;
 b=IdU3ePizT4fBfIMGkkEIt/kI1Y95ZCkiFQk1CQrHmuuipapXD2IfBe8/4YdHYdAVy7DlylnrvPpfO28QmwPXhzvJVArKXt0i7gpZdT9VSNWBAN6zpGsuNCw0jBBBI7q4oib80SySO7iIBzBcxygQx1PwdGNdL8gPdFvVCDelMZI=
Received: from BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::21)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 08:51:50 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d3) by BL1P223CA0016.outlook.office365.com
 (2603:10b6:208:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 08:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 08:51:49 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:51:43 -0600
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
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 0/2] cpufreq/amd-pstate: Prevent scheduling when atomic on PREEMPT_RT
Date: Wed, 14 Jan 2026 08:51:11 +0000
Message-ID: <20260114085113.21378-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9a9050-7c5d-4718-0df5-08de534a27d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ptc57jB9qSa1PchNXI8CytNLZLxPxKD66d0yBVTzjCTHnXHWE7KHYA7RkGMp?=
 =?us-ascii?Q?ujtbY16CUx+GszKGUN07IO69Y4tbZwP/OufjkILWrDF5SqVTebxfjFPsYUxZ?=
 =?us-ascii?Q?dLWVWPctD1wDOrUGSRQ4b5sJD1L/rCXeSDdpCzKEaBZEgnL7aBzxqMfYn5b7?=
 =?us-ascii?Q?vdJ4NGtfDFaCi0+3COIof34Wqp98kUW6V+0jRd8t4aZE1RXjyHGlq0pnY6y0?=
 =?us-ascii?Q?i/rWsG5MwzlrdXP27EZ+SWdlXjdFjsuJUqjiO2+x+4lpkqoY6NBrHeM4lCtV?=
 =?us-ascii?Q?/nvBNobLfmu1hy+1lWZujEhEP2MROS0ZMdBZlyFv7y+00IWZfiKj+r/lIAUB?=
 =?us-ascii?Q?/X4R/Ti2qmv5Ajku8IIB0XnvwxJEtvvuYvmGaVofNmr/8rzqVxkElQO4wZFS?=
 =?us-ascii?Q?gEZD2aDx0L87y2oidjSvqawBm/qqNrYvklXe92y1e0kqtj61w3RYxUTSqqiV?=
 =?us-ascii?Q?HaCpxzuSryeWfXt7+3GCSXjUV7g8/D4Z2Nbfs+fQuMhXMQXhM+2NylujmsPD?=
 =?us-ascii?Q?IB6Pn3s772vC2czcScNSvEvsoPaaa5BoNi/6D915DUW2BirCF4tsuwNM4UtE?=
 =?us-ascii?Q?OgqYstn3H91irBZn+l2kiaXhtzpAQIcxv6aT+TfS8eZRtI3IocSXc6fHJbbd?=
 =?us-ascii?Q?rAhAdiJIGLJe6BujXxBJhcbAjqIgQc1I73s/kakjs4r7PGWlyBqPcTAi+gXI?=
 =?us-ascii?Q?XWv7ho/w0RzRIcOmcupLeMODg5pkV/3nmX+Rj/jzjsuVDMR8jwPQJZb57Rxz?=
 =?us-ascii?Q?zxOkC1KypHpU2MuiJRoQW6+QaVIpInlTnpTmxJnRJZrFFbpARXJz6Z1nH6a+?=
 =?us-ascii?Q?tiQHVndk/LULI7gShQpVVAiOopIFQTNCPDu54GZK+2pz79bfImS/fYk4K1PD?=
 =?us-ascii?Q?wH1BZWhmoDgnFoF8ocbjqHcbb7uN07EXjDC1U52GglU8JlPkqinKgfx8PW3o?=
 =?us-ascii?Q?wtUtjMhHwO2N3mWNX8Wr74r+lpE+NyXQOzV0hkJF8/QEETzPyAZAa/GKs/49?=
 =?us-ascii?Q?VlUZjbDoOI2Az5f1EpN/YaR5BtI9w8uEL/BPoI0zEpb93lXQsoa1tcTxD6cw?=
 =?us-ascii?Q?4t4cle7Ejax8rH8H1truWaopsrqeJxj/H8BNMqIZtuivRFN4w+gopH0I7/Dc?=
 =?us-ascii?Q?xDe6ggPEPBveule1FkIxw3/GkUg4C5JsF5AnNvNFFD95SBRUBzSPxy/EIXsM?=
 =?us-ascii?Q?bpNkZBfkaDtA2IWnJ6XfOOvnae7SrZ5TlhTZ+SfQ+rmDzxjpG6Yw8qrHdXl7?=
 =?us-ascii?Q?hhU3y4n7DYdRs4UxN3jJgVn27pnzeBev2FaKjleVtZcT5E+5xrghwm+mDVkU?=
 =?us-ascii?Q?SLTreQ/qE1W3EYTh9q+sHWgx3YgOR7skU3zlLXBvD/v79OuHi3oErELA8SRK?=
 =?us-ascii?Q?igyWqFbNheWb85P52EYu2la9MHSOR4PtzwrI+qxDamPD6+VJXWtBjiVogneD?=
 =?us-ascii?Q?hNJAiFXmRf0qiYF+nM9qvziC81+bsrYEr/epkDrJ7kKhiNxxskUvcsw8Spht?=
 =?us-ascii?Q?1yvGDGTiwhvaJ7/ppsZ9RaBcmrqz4qBurzLeBqeltLvILTAcjD/hv5Kb0w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:51:49.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a9050-7c5d-4718-0df5-08de534a27d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

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
use this cached reference from the sugov data. Any changes to the policy
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

at commit 1f630297e183 ("Merge branch 'acpi-pm-fixes' into
bleeding-edge") (2026-01-14)

---
Changelog rfc v1..v2:

o Updated the kdoc comment above cpufreq_driver_adjust_perf() in Patch 2
  to reflect that cpufreq_policy is passed as an argument now instead of
  the target CPU. (kernel test robot)

o Added "Reported-by:" and "Closes:" tags to Patch 2. (Mario)

o Collected tags from v1. (Thank you Mario, Viresh)

o Dropped the RFC tag.

v1: https://lore.kernel.org/lkml/20260106073608.278644-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (2):
  cpufreq/amd-pstate: Pass the policy to amd_pstate_update()
  cpufreq: Pass the policy to cpufreq_driver->adjust_perf()

 drivers/cpufreq/amd-pstate.c     | 14 +++++---------
 drivers/cpufreq/cpufreq.c        |  6 +++---
 drivers/cpufreq/intel_pstate.c   |  4 ++--
 include/linux/cpufreq.h          |  4 ++--
 kernel/sched/cpufreq_schedutil.c |  5 +++--
 5 files changed, 15 insertions(+), 18 deletions(-)


base-commit: 1f630297e183aa2abbafdbe8c4f916ee647e6e21
-- 
2.34.1


