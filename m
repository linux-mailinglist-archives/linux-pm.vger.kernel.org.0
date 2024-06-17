Return-Path: <linux-pm+bounces-9279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42E90A64A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84852B260B1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF25187359;
	Mon, 17 Jun 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8KEqJOF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263D188CA1;
	Mon, 17 Jun 2024 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607621; cv=fail; b=NEuPRzhUcxdfSceTqgdfJErzwZDzxTtQxhygbtKN6U6gAnhXtfxnK3A6QGdMNpzFJyoew+i+zcHdpAGLn14pYWjMWsOdhLSPTR8rdutn6wEGFjzGCjfNnkzhXRESLoQkKeSS9iUHbWqdUlEntDeZO2pM1b2wNBuR6fBauaJdtao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607621; c=relaxed/simple;
	bh=8APnC4Pq5Loi4F8AGmPFFd/e9xx77G6sYoRSwhSZlyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YQl0qGdJU9lOvcuG4unkE2gyahQhb0o0tRL07m6Tq+trvTRmvoVac/J/bNTcDza8cVx5MzMHAd+UW/S/o8yvj6l4i7M/Lju6PCEfhNVv7Y+kf+pn9UUgnCuu0P457qIyGly1C8jNaJg3PvueO7AZoi0cFonXYajXl0wkvIBe1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8KEqJOF; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1+8bH9CM6cFDyIcx0Wb5f86PUfv3cgIeNm4Yt/wZWMpO75HCXQFxJNQywVuX4eu8D3tYae837V+kgdyafuS5pi4VHCCSknVQ3VsOqriunCj4phKNyxEOMdsob+qLdRHvkttNXfqS14S7qUvrNvxBogk5Mwu2KkWTL6CpERNOtUsrOJW7w3MRoLNuJXsrvBYmP0u3QYjys1VZTREwzJSDjmCh97eezpbTZuLKqFAbtvRzuT31vL2mL4L+/3cEgbp1hoce5b6bbAQxQJSyYso/37gnjuGHpUahTjZSiMkDYbbPqaJOf1L7MucpNzIpTkSjRAzXfaoso67/R8t716Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fEP6IOk/dqDCVLBBkb/XglqICz97GSMG7gMhrxOxp4=;
 b=DXXnH/e73uJnfa+/m6rCQv+seArKwrcDVqKNh4/upAvuT6fSlrq8xlTy+dS39fhWbKHVV8HCorlWsfANL0UBQ9JOvKehG6wxDaMLtOQO4llgTczw+U0hzv7+UH7VCg5oqyl03GeDykhsJj66iNGFePFMCodRbuYevNs/4D37LS+6rOivdK+aF/iXn8wkQYk0ZN8l2ZpAndvoluoRtxw+sEj2i+7EUxKR21v1JYb8G3BMew3jOa9JvgVLAORuiVmKbZxtyJ3MuVskGPpa/rZsu7pAS7A6UzlUx0nYDqPOHIwSb4I2NJgaL17AJZ3SyMHnBqQGTwRkqEzIN+Pq4858Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fEP6IOk/dqDCVLBBkb/XglqICz97GSMG7gMhrxOxp4=;
 b=E8KEqJOFlxGAtnLyHofr+hXSdPMYQwHrzjN7KkdB2HawmCkT7GqwGAcbmk7agI3HWg3Lins5J8POiuV5EiUVHGXhMZ54q040J6i+uhXM8uN327bJqBCSfRPEkEp1unt3ltm087mxgGSs5I/xOm+isXnqKs6blqsrP8NznM01H/M=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:15 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::98) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/11] AMD Pstate Driver Fixes and Improvements
Date: Mon, 17 Jun 2024 14:59:02 +0800
Message-ID: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 22277ae2-ebcf-45c4-b910-08dc8e9b241c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MGZauBgXmDMyTKhgODn/PbYGKxVBmDjOD4iRq/7w24FcZ0AZxT3Y0B5bGRu?=
 =?us-ascii?Q?rwxOB3A9BsSj1r/viH5wWAzJCew7iU9SgHMgB36oBPwlJtUzlJfp1JykXgdE?=
 =?us-ascii?Q?RpEh80mFcU3pFnu88dy91GZID/wiH6+IQNXZB4IUPHvqkTwj+MMbBmzdY2RF?=
 =?us-ascii?Q?wVvA2Ji1WoI+GojdTAOctLeVyYiB+5e9RSW8ISk67yc6cZh7qVcVe6pYKXp0?=
 =?us-ascii?Q?fYww8dls2J7qN9RQ67/MeeKCPJO9nc5GEmppOjFwHEDbO5N77OVhgcVfG+pY?=
 =?us-ascii?Q?HPAPBuzzqgkEJaHWjb0SIGzgcuTkVPR7Y46IG+qy0sWFbdvtFj7YQrYT/Boa?=
 =?us-ascii?Q?4P/E2VrL7v2xj373+kZq2WtMOhueqoeJG9gZVmpKc/Sm+allEcZwW+WvF3qv?=
 =?us-ascii?Q?Ry0yFNyu6GrgJf+HJh9+UF0q+qXiHKD7Pw4FAGn44uxl0790Y0UztJ5xTisu?=
 =?us-ascii?Q?iEHMpJZfO/v6aPpCEERc2LUOUQyghYUG2A3dKQJCHR4MJehlI2tohKnZTajS?=
 =?us-ascii?Q?qBDvfLWN8jnzfxbW5SWUuhIJcShIBh2vN0YLmEWioSNkIuPmlks2F4IQUoWY?=
 =?us-ascii?Q?bXLwR+w9Ehb6YI01ZnaYFpoOutVaCdSvHXmGUo4ew4J+lisvhf3ajjIHRR2V?=
 =?us-ascii?Q?EXWhyjCVPYZYGHy2fo5doP/X0vDPmvjUXhLREZinFvhlcy+LtL81KzuHEx9S?=
 =?us-ascii?Q?FQKYo1ZW0L2DYeqKpciifUpG11kPNqO1l0mD5v9sb70ZN9zgZLvZCXHeOzGi?=
 =?us-ascii?Q?oBzVO5YAp1TCSYas4qGEpzTBCc1iqfpRhcKPO0O9F9KmLxhcEE070QOhL8jT?=
 =?us-ascii?Q?MnydVbnaCpak3TJgL0okD2EHF7ucO27nIPd165utu8NmdZX0DGJeJ470nB+U?=
 =?us-ascii?Q?RibXg9ZZCJduFmF4V3PIUNqSgOac/XYElimN2x1pLOTqwHrJ68VFEmLjCfJz?=
 =?us-ascii?Q?EoqFTJIJbDIpqS3uLPcO/H6GjQhqRNnHKsEiVzXj7aj9s7QgpI6MKskmTfQl?=
 =?us-ascii?Q?E04OzeNA2ZcLtC85UqAelNrMVioNvzfo9QVEvtZQA6GbyD2/udxAa30tap+L?=
 =?us-ascii?Q?JAmXc53NgBhuu7DHzYn2KyA4yzxWUVePCUOzoxUXGrHZQ+Yjwl3ESUGZE0xm?=
 =?us-ascii?Q?YRjRD4yTKNEtLVxtC0CPFQdkxn9IACixE96JMnpcXwLIjFC0xhPTQBqEdiuo?=
 =?us-ascii?Q?27+NsdDPaHfviaSlmqeMEYNxciA+k3FVy/dzTKSAkKsC0txjUygZrAJ/3FEF?=
 =?us-ascii?Q?w4YwJTAR/Nb2XGxCX2pF8CpMJx7ehrDrLXi/guvhkWX4EyblVyrgTfvCtpEw?=
 =?us-ascii?Q?xw3049y2WU2WI5G8R1cxlXgh+quyrJEFGtQh4iQuHBWJcQPf0SUQlVJxMi07?=
 =?us-ascii?Q?Mz/crD378yj41F8mWJNb53WWLCr2e+kovD0XKoPujOA/yYSKDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:15.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22277ae2-ebcf-45c4-b910-08dc8e9b241c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Hello everyone,

This patchset addresses critical issues and enhances performance settings for CPUs
with heterogeneous core types in the AMD pstate driver. 
Specifically, it resolves problems related to calculating the highest performance
and frequency on the latest CPUs with preferred cores. 
Additionally, the patchset includes documentation improvements in amd-pstate.rst,
offering a comprehensive guide covering topics such as recommended reboot requirements
during driver switching, debugging procedures for driver loading failures.

Your feedback and suggestions for improvement are highly appreciated. 
Please review the patches and provide your valuable input.

Thank you.

Best regards,
Perry.

Changes from V3:
 * add one new patch to enable shared memory type CPPC by default
 * pick all the RB by and ACk by flags from Mario and Gautham
 * update the patch #7 PPR link with doc id (Boris & Mario)
 * fix the highest perf initialization issue with preferred core check
  for patch #9 (Gautham)
 * rework return core type and commit log for the patch #9 (Mario)
 * address feedback for patch #5 for the debugging suggestions.(Mario)
 * retest the patches on MSR and shared memory type CPPC systems, no regression seen.

Changes from V2:
 * pick review by and ack by flags from Mario and Gautham
 * rebase to latest linux-pm bleeding edge branch
 * fix driver loading block issue for patch 4, make sure the warning will
   not abort the driver loading in case there are some new family/model id.
 * fix the driver loading sequence issue for patch 10, it allows command line
   and kernel config option together. command line will override kconfig option.
 * add back the AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f to return
   the highest perf and check others CPU core type in the following codes.
 * run some testing on the local system.
 * move the amd_core_type to amd-pstate.c because of the amd-pstate.h was removed lately.

Changes from V1:
 * drop patch 11 which has been merged in a separate patch. (Mario)
 * fix some typos in commit log and tile (Mario)
 * fix the patch 11 regression issue of kernel command line (Oleksandr Natalenko)
 * pick ack flag for patch 7 (Mario)
 * drop patch 4 which is not recommended for user(Mario)
 * rebase to linux-pm/bleeding-edge branch
 * fix some build warning
 * rework the patch 3 for CPU ID matching(Mario)
 * address feedback for patch 5 (Mario)
 * move the acpi pm profile after got default mode(Mario)

Perry Yuan (11):
  cpufreq: amd-pstate: optimize the initial frequency values
    verification
  cpufreq: amd-pstate: remove unused variable nominal_freq
  cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
  cpufreq: amd-pstate: add debug message while CPPC is supported and
    disabled by SBIOS
  Documentation: PM: amd-pstate: add debugging section for driver
    loading failure
  Documentation: PM: amd-pstate: add guided mode to the Operation mode
  cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
  x86/cpufeatures: Add feature bits for AMD heterogeneous processor
  cpufreq: amd-pstate: implement heterogeneous core topology for highest
    performance initialization
  cpufreq: amd-pstate: auto-load pstate driver by default
  cpufreq: amd-pstate: enable shared memory type CPPC by default

 Documentation/admin-guide/pm/amd-pstate.rst |  16 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/processor.h            |   2 +
 arch/x86/kernel/cpu/amd.c                   |  19 ++
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate.c                | 198 ++++++++++++++------
 6 files changed, 182 insertions(+), 55 deletions(-)

-- 
2.34.1


