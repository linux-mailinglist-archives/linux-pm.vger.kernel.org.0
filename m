Return-Path: <linux-pm+bounces-18647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A99E6088
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45202844A9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEA1CEE82;
	Thu,  5 Dec 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2iD1sXzv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC11CBEA4;
	Thu,  5 Dec 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437751; cv=fail; b=qjztgX5CCVvjCI+WeSeqM+uzihVIPSy+olozNIKvufHcMrXJzIE8Dwlb0jWGWMekZvt50WGyeN5cYChwZ3tDpOzQ02+S8nh/6ajXkoJjLuhseAZ7AjuHnTJ9RG01ErDUSYHlrTVofdRva6Mp7Jw/FdQ71AyBzi2HceLkcoraQvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437751; c=relaxed/simple;
	bh=c0uIe+UTK6/R1DFCQQ4zfMzZy1p5S5fvhOXc/MPzH7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlRIua10ySCaDINqd6h+rXq1izw4YVAoOFguVvjPwBYoKOSiOxbTIcVDHNiGAvFghrBatSrwKGm/Ie72xihQ0uAhsk5eB/9di4cKMwT0aI4E74DFCH5bCpyQc6k1+e5W6sGl9nDWSJBjX6JFs05SGb92zYYNWZeAqkONPd6rauI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2iD1sXzv; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U55rs2oDEl8wLI2U7B443s4KSNd9RLFjuPW8jJSdqAKgr0EyrmFh5Cdre2n8e2DUPOGx3DJJmdyJWtV2Qk+ayxiJAnqbZr1ql+OV9IFu3YsK4rsH92vlxpVR9Isk4zPKuHjVJ+pSEgDQtZqeOzCp9G87MFhZKhrCC+fbvTIIlOf7ltUwwAfiVlBBtqR4usFbgf42LK/283YtT44S1i7CzuaIeI6tY+VcltzptkhBU9R0fD60bTptMKrsIcGm0UQemnqdoc4HNtMHViY4QMZyMfus/yB3rnp7n+ME5F1zXYST6l3QCBRiuCP4/huctjUqsyR1A9zPJ/v2tCZO8i5bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anmIpxE0+wTruxd3v3xe2G2c1S/JP+CK+/+dppTZwxk=;
 b=QldMGwvlb0d8zPWkQaBE2SLbsGNw5oLjiiBBfOUqwqBpOtFEJRDNsitvJBts1YdCHW52PVFbI8addhuIi45J+sX5faEI0S9vFcQaVvzGgxREDt9XcEcMu2DrQkJRCQ4iU67o57J60OaAE1lBEzThCR6auUiW+eUs9O8yMpV912zT5ajoIrf4ZBf4ltLQn1koJVFstt1SCWQaquCDmhdPyf8Mxu62+VU0QYws6BPbSES7rosGR+tn6y4k4Gq3ZLg/YzMfHozbXB7EWzMQKCpCZT4HM656L4KvSW8/9J2iKWnQwnZXOOpSi7aXleXD0zc73g4iD3bgzx7gw0nx2xwPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anmIpxE0+wTruxd3v3xe2G2c1S/JP+CK+/+dppTZwxk=;
 b=2iD1sXzv/dVIIcQGjGow8gV9iMS/ip6t04XQAcRZxvPajxP2fg9i1EazrkpRi2h+0msRo8T4n81kvjOrPvT8YR2KTda0bb4kKoopnAoR8ps1Z3YEM3coNolKgxF8YQISkngVjlcQenuenlYux4zBAUunRZSqCNIdmaWiCFoKQfo=
Received: from CH0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:610:119::21)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:29:03 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::17) by CH0PR03CA0387.outlook.office365.com
 (2603:10b6:610:119::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Thu,
 5 Dec 2024 22:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 00/15] amd-pstate 6.14 cleanups and improvements
Date: Thu, 5 Dec 2024 16:28:32 -0600
Message-ID: <20241205222847.7889-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3849f6-8b52-45b1-7867-08dd157c391d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWLsMfzBkPvUKPGdqK26OpFYrFieuw4MO7wuXlKhUGVtVTXgu4mhuq7jQx7V?=
 =?us-ascii?Q?luGY96A6amU4HY1v5e5oX2UZhpT0sSOg9rLFOxJi8jD407lfu2vClidUy/9B?=
 =?us-ascii?Q?jT6Vroyzrrms21BzxrXwBksGX7uyWoDKMBpQ8WBhtw+dxlCsbbCHWCQlqrXQ?=
 =?us-ascii?Q?s0qJOFIxYsbCoqIttQLnz2bTz1CfY7+JUGAY3xONafOL8crALHgMgFNoRoR6?=
 =?us-ascii?Q?SsM6GNwbrkGoL9KfQQMsR+lJsNXPsBUYXXjVxJCwQ9rhkz6olWC9jiVRm5Hu?=
 =?us-ascii?Q?cdcwNVIwWzU2t2/jpBI4N/m3USXdQYz4b9dStYAJEg/EWsy0NBLrwt/i1064?=
 =?us-ascii?Q?NQNSX9FrLJfZw0XDwAz1IY+cbtCAXKGVbNsAa2r4n/lZlyNrVxz0eYBHsjCB?=
 =?us-ascii?Q?8U1nH0IiUF4cnZAYELAm5zY70DchlifAVBcQG+FozlNYc2qgh6amI12Mds4U?=
 =?us-ascii?Q?CL+ZRSO+WCeHMjHTw5z/td4vOKHAaxY+9s10sgKualHc2eNb+Mb+Oq/IVU/z?=
 =?us-ascii?Q?qMR7nbAfIatHddJ9hqZSVyFfLWDmkR1bmiT/1KFCH1wFfCcRWhc75JA4Z65c?=
 =?us-ascii?Q?qE72QM5Wjy9tA+FxGUo0sFNJMT8fZREb1ejCDzI9ni/oJbq7Vp6uE0ok7bCW?=
 =?us-ascii?Q?rB17GkXpNWjQ89Q6apAVBa81x73mB7embRJQDDmDj/S1FbFU81manhYK+j0U?=
 =?us-ascii?Q?XdS/Ehx4RxMIsuc5KsJph4RyIat95sxY+aTu5nU0KtoPjWx1FpCUOVeRBtoS?=
 =?us-ascii?Q?n2Am+cc6mcOFcIZ3nRsDtOqNgUeRrXK1FTSZYl2uEoFcKn2zjBUr1o9Yi1Da?=
 =?us-ascii?Q?GuOj/NislcLFnHPV4Uf/l3wKkbMzjPQeM+CkyWrmEOStXcN3eT2zbiK7Y/tX?=
 =?us-ascii?Q?ZXNPFP/izM9PjjvMx/mDHbzatfR6nNUPcBk0H3RY6xUMwyZBo57+Fq/ceJGv?=
 =?us-ascii?Q?p0egD8Wnp3bpypwhkoCJjB/26ve6ttbaS3201L7A4CEphGgGf1JJdRPbTTIf?=
 =?us-ascii?Q?Hcp+IYYsRbptJALlBKZB3IYClcH7Zvx3tCLpO9Fb+ua1pcfNh2LYr9sg3Bqe?=
 =?us-ascii?Q?XKK+7VENQQZpsNcx48QI9MKdeJ/jYblzX9MKRyp7CMF+o9CyadUGh70USe8X?=
 =?us-ascii?Q?Y+vF8UuKHXB0vhwObxLcRC8BcKGprN9VPGPUbonMWgdiwXX9+WSxrAResW55?=
 =?us-ascii?Q?ArRphWccHbD45vYLuY92KS0+6+jDgBmJo6UNxxhVeCpdmC7gQiGSFuoqSPRw?=
 =?us-ascii?Q?/TvV+ZvVHiyJ3Et3HDSyoWXhmiirF8hwqOU8D5wrE44Fk7RPqRd50mhw8WMu?=
 =?us-ascii?Q?CSAqhMKq49Rv78ga0QgKsoFKls0SqQ/qAtrHZ+SOCfJxK2fx11DA6ndcRjCp?=
 =?us-ascii?Q?DZdFOsKk7eSxWenLszO8dwFkMaqKR7ASZbfjl767lo+C+pYHZ+GuNYbHRrMX?=
 =?us-ascii?Q?DqBLBwCRGFKt1Ch+ktNmA1+S7R2DCLv6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:03.4057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3849f6-8b52-45b1-7867-08dd157c391d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

This series started as work on the behavior around boost numerator that
was changed in the last few kernels to make it more expected.

As part of the process, of these improvements I found various other
optimizations that made a lot of sense in the context of the code.

While I was working on the issues I found it was really helpful to have
ftrace for EPP, so it introduces that as well.

Lastly a bug was reported requesting that amd-pstate default policy be
changed for client systems that don't use other software after bootup
so it includes that change too.

Mario Limonciello (15):
  cpufreq/amd-pstate: Add trace event for EPP perf updates
  cpufreq/amd-pstate: convert mutex use to guard()
  cpufreq/amd-pstate: Drop cached epp_policy variable
  cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
  cpufreq/amd-pstate: Store the boost numerator as highest perf again
  cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
  cpufreq/amd-pstate: Only update the cached value in msr_set_epp() on
    success
  cpufreq/amd-pstate: store all values in cpudata struct in khz
  cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
  cpufreq/amd-pstate: Move limit updating code
  cpufreq/amd-pstate: Cache EPP value and use that everywhere
  cpufreq/amd-pstate: Always write EPP value when updating perf
  cpufreq/amd-pstate: Check if CPPC request has changed before writing
    to the MSR or shared memory
  cpufreq/amd-pstate: Drop ret variable from
    amd_pstate_set_energy_pref_index()
  cpufreq/amd-pstate: Set different default EPP policy for Epyc and
    Ryzen

 Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
 drivers/cpufreq/amd-pstate-trace.h          |  52 ++-
 drivers/cpufreq/amd-pstate-ut.c             |  12 +-
 drivers/cpufreq/amd-pstate.c                | 395 ++++++++++----------
 drivers/cpufreq/amd-pstate.h                |   2 -
 5 files changed, 244 insertions(+), 221 deletions(-)


base-commit: ab9e5b2eb56412cb8c63b46b935878d29205418e
-- 
2.43.0


