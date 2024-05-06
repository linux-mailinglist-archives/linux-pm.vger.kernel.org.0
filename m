Return-Path: <linux-pm+bounces-7529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D28BCBE7
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08398B229CA
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB518144312;
	Mon,  6 May 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YxA6hxto"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E45142E74;
	Mon,  6 May 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990854; cv=fail; b=GX5XFopFaF2SovJq3VPSfXo4YLVTV+95KdHA2aXTSZHkFJV7wMzEtyIkENvtv+9LxGIrbOBF4GZ6VGdgLfuT85fgOmieSy3lLVT5wYgmq78pRNfS53FoWmN3WgrcA0ZJzyb6anxC4ckqyCSSw5tFbZ++UsNoMZZQpico1XW/Z7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990854; c=relaxed/simple;
	bh=shacbMOWdHNX5CkSBE5ehgIMflgX3CqgR18hngYjI04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9ZI6wIZ9H3/ofTglEeUnjJK+v+xnqppND5iXiMuHesOU4wVPTCAozBzApeoc9cZiNyf3X05GNf2AqpP+RNzvgTbmUDUPa7Tnktz/Wi9tknm5xsfxehaPbK3UBmmQBkzVbaANmWDs3pgjWsanqV/Duq+9aQO+QX0ztwaxVQIJh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YxA6hxto; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cogocl4vXLRy4yYzYdSip3S4egCNv1v4dwxRP8VCyJg/lBYnC0l3EE7kgo4xHt0Y1eAIXKf9Qr6EaQOYfFNk9cWTzdkNeWRQevzP9OL8e0V9HKiso8ZCtAMnFec8l0orJBMtn1AKEU4ZUE/2phUgralH+QgC/xp2XvCOp/Xnr87UxY0Q4220p+SBRCOMVNQiaBoXHGWQ/HpkoGCw1KG8z0c7BMj5S6z5BGVlMLI1tbHOh29R3R0XSiL0FVls95DJCokgosudjdKCeEgl9GIpCSm9sur1KC15/clAS1hUIjroyitIRBuZN7FyjXOzWnCZTgjB/lQqZlBW2831gi0l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFn1JX3yZbzwzR7VCM0QuVqNzi4fcg5YsHFwxoNtucA=;
 b=WZXmRvCAD/AeFAyY9iWdt1AjucD0nUBL6G7xiYYyRW8A2nT/qcxhvUniYY94NJEZPt08hQae9VBLiDu3r4nF7PSFwFcdK1OQWcN3BzaGBApKN2l4O7psc3pmNEGs9R0hRYZ/I2b3WSwVI1U/T47w4nqPYp+ZZtXCZVwXvYZTx7YJ68wwMs3+0cmdhVVj/1mOxzwXO/5aOGs5cEqqEIWggEJ5gLQX1oxvLpUFxsgikFUHaAYsyEohOkFsBKE373nG9RLqnYQpEx98vMQswBhvukZYy63tcHLUABommHsDtWJExZfrrhuXMhZvUEQvbG2hmLGqhMGIINQ2Trm1pp2PzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFn1JX3yZbzwzR7VCM0QuVqNzi4fcg5YsHFwxoNtucA=;
 b=YxA6hxtoBhNA8W7HxcduLAkUi5D1rph74cXQFYOPdxs8mpjb11rMvHdB3R0/JxDTCBZymB/KOXbkiNkX9cyLogmxQTMcxKCRb7ese27jk6E2Yf6GcUmoJlebQRs7ADnzzJ/H05rqimOYb3Sb5FM3duy6trnFZScPfi3Pek6tF2E=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:15 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::74) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 10:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/7] AMD Pstate Driver Core Performance Boost
Date: Mon, 6 May 2024 18:19:52 +0800
Message-ID: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: c148d41f-0d60-4822-037f-08dc6db61f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLajF9uBVUG9sW8RcEPNa8BFWLRtRJdkHFx9w2h44inRgurHmDrmXK5jAeG+?=
 =?us-ascii?Q?R6ue4fKYOQJ36PMeyRD24h+QWp9AUgwoF3UMkE8vFnV2fOp46+KT+Qnogztk?=
 =?us-ascii?Q?yO3AlkC5WtW4oYJXBnkSXPEU4XiRZkzNN+sVVTYh+gDIK9gT43l7y3I1MqGT?=
 =?us-ascii?Q?aigFVtD+4CjJi8RxFgMxcV9lCYaU1AKOlcCxM4SFZcZZoHW1JPmZx7oO20tz?=
 =?us-ascii?Q?8bHDwlsxPBUeG2lrx494l3oKOzKm0fCGfx1h5hlM7w5tGu2kz9yzHBQm6jFv?=
 =?us-ascii?Q?Rc02dsAewDggidra0tQv7bXlR+OP4CbH1ozn6Qfn4LADxkRqAluW4vbBeD+5?=
 =?us-ascii?Q?Shk/9SFws9LPJm0k/kUzCyecS6xvEJ6nUzDgF+6ambo2gUiJK0fPBuvdrApl?=
 =?us-ascii?Q?3IKk1GqDadM8mbXDEK8m2E0AXz7l5lof6p0JR3zWi5W8Vo9gb8ibyQ//l28V?=
 =?us-ascii?Q?wsRj6UTuJCsaaFAF3tu5ArgVZpJayupNXOfv6maxpkkQB8fbLolhIcth2sje?=
 =?us-ascii?Q?xJ3n470CS5SX6oqfaSM+7glqE6xvuCpG4/xRQ7ZWiLkwx7d10P/fanlpeSwl?=
 =?us-ascii?Q?tFsOq7a0guuB/rxVeAprstdonPt4klzA85+86ToNc7At3tlBnwh8t6bPMWkY?=
 =?us-ascii?Q?ua8sTGBn1mauEeiAbxwxpS3XkvholFh+WRiB4dU9m+C3PyQsGerlKQbVIZFG?=
 =?us-ascii?Q?h+6AUwvMrBNkzbjFp2iAW9UxrPjh1dvXixtXPWZWTz6EbbLcMrCjoFWpELhz?=
 =?us-ascii?Q?IkiY7+nL+UF+ugPFFsrw5uH+jxZnpEKO2A/2Okppa6T01kDFxgkOK8GwqLVu?=
 =?us-ascii?Q?nJB1EVKeu2exFAUsudIe8LKlmgDa6LfUY5si6j2KmtkFLmS3ceCI64tmTKvy?=
 =?us-ascii?Q?gAaGirH0RJEdp36UjgnJFwbWTE3z21TNU0iY8/2qKnjsKOqwrQBiCQEYV3v5?=
 =?us-ascii?Q?kqjvNyOnZ8mPfETEYzT5/ZwXwxG0GLDqbtYCk0+C3/p/SFCnsjGF0HR+8lN3?=
 =?us-ascii?Q?F3loHKNbpx3PzNcfjSTUUXXMkIIs94Bml9/0DUnn6USw7KqkXpPQg8lpiNCF?=
 =?us-ascii?Q?W+8HMbvI+fMZrXaaynFCkUH4cPCN0P+lhmS1LVsIVas2TV9p0EHVEl5OfB7W?=
 =?us-ascii?Q?fKZwUqYIPHxRoRm/aOCGPJAoD3vzeDM/QMNlfRTUJ2YZHndOQ9NyH+nup65G?=
 =?us-ascii?Q?bI+F506XTrSLeVRzQjNQFv/7i+tiv1VuNmME3DzGLEMLx9RKil/U7mlIhsIy?=
 =?us-ascii?Q?qU9HLOTHqGJpt84AZ5wpcb6j4xwaeq8B8jJJmwUuw4prh2gwmGsU4PEZyJHD?=
 =?us-ascii?Q?VU4Qxg4Na27CO1W+Lyy0dnYCHTBLNnhQLKEaZE3nDshZwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:15.1418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c148d41f-0d60-4822-037f-08dc6db61f06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054

Hi all,
The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"


1) disable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) enable core boost:
$ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
   0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
  3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578


============================================================================
The V9 patches add per CPU boost control, user can enable/disable CPUs boost 
as the below command tested on a laptop system. 
# before  
  CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
  1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
  3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
$ sudo rdmsr 0xc00102b3 -p 0
10a6

$ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_boost_cpb"
# after
  CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
    0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
$ sudo rdmsr 0xc00102b3 -p 0
108a


The patches have been tested with the AMD 7950X processor and many users
would like to get core boost control enabled for power saving.

Perry.

Changes from v8:
 * pick RB flag for patch 4 (Mario)
 * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
 * merge patch 6 into patch 3 (Mario)
 * add two patch for per CPU boost control patch 6 & 7(Mario)
 * rebased to latest linux-pm/bleeding-edge

Changes from v7:
 * fix the mutext locking issue in the sysfs file update(Ray, Mario)
 * pick ack flag from Ray
 * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
 * rerun the testing to check function works well
 * rebased to linux-pm/bleeding-edge latest

Changes from v6:
 * reword patch 2 commit log (Gautham)
 * update cover letter description(Gautham)
 * rebase to kernel v6.9-rc5

Changes from v4:
 * drop the legacy boost remove patch, let us keep the legacy interface
   in case some applications break.
 * rebase to linux-pm/bleeding-edge branch
 * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
   Enhancements which has some intial work done there.

Changes from v4:
 * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
 * pick RB flag from Gautham R. Shenoy
 * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
 * rebase to latest linux-pm/bleeding-edge branch
 * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
 * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT 

Changes from v3:
 * rebased to linux-pm/bleeding-edge v6.8
 * rename global to amd_pstate_global_params(Oleksandr Natalenko)
 * remove comments for boot_supported in amd_pstate.h
 * fix the compiler warning for amd-pstate-ut.ko
 * use for_each_online_cpu in cpb_boost_store which fix the null pointer
   error during testing
 * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)

Changes from v2:
 * move global struct to amd-pstate.h
 * fix the amd-pstate-ut with new cpb control interface

Changes from v1:
 * drop suspend/resume fix patch 6/7 because of the fix should be in
   another fix series instead of CPB feature
 * move the set_boost remove patch to the last(Mario)
 * Fix commit info with "Closes:" (Mario)
 * simplified global.cpb_supported initialization(Mario)
 * Add guide mode support for CPB control
 * Fixed some Doc typos and add guide mode info to Doc as well.

v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/

Perry Yuan (7):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  cpufreq: amd-pstate: introduce per CPU frequency boost control
  Documentation: cpufreq: amd-pstate: update doc for Per CPU  boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  31 ++++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++++--
 include/linux/amd-pstate.h                  |  14 ++
 6 files changed, 226 insertions(+), 14 deletions(-)

-- 
2.34.1


