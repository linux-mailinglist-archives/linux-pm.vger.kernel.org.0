Return-Path: <linux-pm+bounces-7627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DB8BF6E9
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259B0B21032
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC0E2837C;
	Wed,  8 May 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZM5OQBiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75626291;
	Wed,  8 May 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152894; cv=fail; b=gDzhF8UHsqXNpBdAVcxHf4Ndsn7pXf9Hlnc4AOwziovcEc6qsMBpDt0sTqM7thNI3agplgNIXy5fHwfhwV/vhAvmOngHqE/AlzUQs8ouaYXu05YP2wB1hOARsDTbxEj/QYelnVVFOc6LxTc6/izHr9gY9IqdRicF/0jTnnNWPMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152894; c=relaxed/simple;
	bh=Hup2+gXfQC8Z/VRS8TIpfCAFJuiUVXHTe3ednvc/kUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCGwXmreo+T4NXLr2dmC8bMMLL1r9xRd92dzpN26t4/FEEZhpY7avS1ERFgBJaJkga31Puj+OF1eGtlIwOrOX7r0WEIxh3pOi2cC3UOkdOer1+yatEsBcm5qpg0sMtFrPQlY1+KSyVJHU4+tycP6z8NlQASETDmgGG72tEVCiPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZM5OQBiP; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrUN3ZA9dU87NervJAecDwCtRDpxkqrm77SF0Ox/0sSOqJnjlv7R/e3zYWL/WkSxM6DslNCQzi7uK0pphmHdODLOMrh3NXNj3wC8Qencl0GOyc1QTQSvqAVM/XpiiNmil+roqgXwpQa9ibRaiBFSC21xDBJ+z0RKH0VhLJDjomsWvkpA4KBwKlLY4nzwIRyYVnQ3E4845v8T86aIaRPNMq6qCTiQtzoeyypj7OWvx5CzHQubQ4SHMtEGGWZ6MSaUMNR76mojic6kUnKvMnAZ85pwuwbMyCoFhGTbKzHSZ/dvrJTdrMCyqw/TPi7GfdUw3HIaPKU0T3dNW0CX4EdoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xL4kFKRtC9K4jiGXoD/qTWI9S8TZbt1wr3ZL8nPqUs=;
 b=goYOtq9/0/2/RtyRpcjFfqqKep6vOfXyz8R6rF0jh8wUnwlLLaQKSbk14F1VH1qo0vHOlizBmG57hukLCgdkhpnOjO9FvaOnC/mn2cnhwL3R06Z2abj6JXC7jgRAIO8sit2BB4gErksAgIPX5/Y+3eC46kLtYTTzbjkuaXC+yETcY6lFTZpYlwp3zJp9HpY4aqyeBtm3yLBajJiNJiKF6IXqISp0t0zcU3rLTH777Cj5+anxuWZcIsJnUpu9jY5N0qATU5hufbgnjSibW3d9WzeJvAwwv18szOrKaM1KV85hJtv5IPwRpRq+FLjQT8L1n9bhn9QNsLTBIVFNPI5MvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xL4kFKRtC9K4jiGXoD/qTWI9S8TZbt1wr3ZL8nPqUs=;
 b=ZM5OQBiPIA3JLzPFA0bh26xHCSA+SZtBV6Acc0jqmauFnV5ZV329Zpcte/V2pcYQH2iDmkvceTafuv31qDxcFWrSel6R/mv5SWCP4O0bvEdG/mvGtLvaQm13qCQNCzGrsy3T+SOzVIMoElh92vvHz4MkBbT00jrXve0mq9Tq2+s=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.40; Wed, 8 May 2024 07:21:28 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::42) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 07:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:24 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Date: Wed, 8 May 2024 15:21:05 +0800
Message-ID: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bd08b1-5417-48bf-897a-08dc6f2f7a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4tB8ecZT0ZH4dS0GrK7Rrm7fmjo88w+mPsxPlOCX2OpuqUYxLqdokSxAZZq?=
 =?us-ascii?Q?A0GdK4VH4JPkyR7E5+oW0iJdQ9zFO44X+HaQ3AFV4Sk2OvFXqgQs5aM3RZUT?=
 =?us-ascii?Q?SU2ZZ2Agxf074I0ztZSMWtbPnE2hD6iLB7LO6Ur2MxqRpSttvlgxRNnoEv2L?=
 =?us-ascii?Q?LQAoSptsdn7bQ6z8YdWrryvRdWhVFLpJ/cPaYYjBVEStF/EiMPsE2kpFotLV?=
 =?us-ascii?Q?j8oQSOlLxk13nw0uinPiP/x06gvVoJ0NFYw39iLo30iN26v4Jl3U9A2Rsa36?=
 =?us-ascii?Q?X/ECyFBZREHS58pggottOAGmbAKPvtUNvuDHbUlZladN5l5cE1Ou3njctg7C?=
 =?us-ascii?Q?0CCPdH+yGdfzev6Gx25nNxxuxQKjfRzZdffb+ROniAATgzlCeCbucr2ni0t8?=
 =?us-ascii?Q?ehXV5YGEOTAz/NI4AxJi6bYdrZBWkHI1yBr+Dl/3dUMnbVBuHG/7qFKlywxN?=
 =?us-ascii?Q?C647NNOnyo8QmKGI3yKCRpRlH+F/modegByRPar8lzdEvFpI3Twja8Gg3H/n?=
 =?us-ascii?Q?IQcf5gZ8tjBJ8biLZQephwsrWpr/SSIdXVCEkpADhQlFuFUUtwSjwDGk10Yq?=
 =?us-ascii?Q?G6FnkYb3TkaGF3WMIi5IC3+UhDEjr2GDe0+SyX3yT6rLcZkAc94gmtLfdq6H?=
 =?us-ascii?Q?dGqYDLu6OJB0D0TuSl2GQh3GLtxCbCl1yp0jcqFLALqxS7v+axlWxVPJg9Zj?=
 =?us-ascii?Q?feR9trVbFwj4fDc5wlz2DNvZ6lWK5mYTZ1HXIh2pxQmPxwOJFY9c/yH0UmRQ?=
 =?us-ascii?Q?KvixMS7yj1577WFsfWIR0wlRtTKsl2zAtWhnW9kfUsIjcGDFGR8zSmty8tdu?=
 =?us-ascii?Q?jKUzyn65tDtqnZr5LIRERmgLl4LsXWw+f2Bi+dg/SDUwv9cEpN0pxvSDdqOA?=
 =?us-ascii?Q?IB+pRWVaywQLSiCdHMfqHsk7vUIF8gF1jn8DuRNBMtW4vWFNJ+TI8KobxI4E?=
 =?us-ascii?Q?5DkxBuzBCJvasmH4WV89mahovmY17OzppF0VCL7ttRb4XKTs1CXphl1IvDDC?=
 =?us-ascii?Q?UeQA7N6qSVV/zMUnTiRwMZSHGIN9sIVHA1gEpRPcbC6Kc0AI7zWJdWMqqPCc?=
 =?us-ascii?Q?WvwC8rvNsBlG+8bz3ZG2u0qScvgb/+ual1LA6kmx4xVQE9NCpDlUsbnlX8Cn?=
 =?us-ascii?Q?fK1k/ZUsbFW2AOx0AMeyzQQk1QZ16/dQnD/bEI1AV9x4SYM3VQS7ZIvDYu34?=
 =?us-ascii?Q?qPBl3DmLBxEh2K/g+R6fMuDY1bcIwYdv3z8M2P0rtSbbupRk61gdHjOEA1S+?=
 =?us-ascii?Q?M+cDW2EkG4wiYKJrF5ICzny8Ro+i/sJOa7ux7oxYa0iGVUsNjUy6pcdvUqwl?=
 =?us-ascii?Q?E9vegk9cLAZ7xpYCoyxWj9tOHs+peUNuj8cnml7IE9D96A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:28.5543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bd08b1-5417-48bf-897a-08dc6f2f7a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

Hi all,
The patchset series add core performance boost feature for AMD pstate
driver including passisve ,guide and active mode support.

User can change core frequency boost control with a new sysfs entry:

"/sys/devices/system/cpu/amd_pstate/cpb_boost"


1) globally disable core boost:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) globally enable core boost:
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

$ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
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


Changes from v9:
 * change per CPU boost sysfs file name to `boost` (Mario)
 * rebased to latest linux-pm/bleeding-edge

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
v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/

Perry Yuan (7):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  cpufreq: amd-pstate: introduce per CPU frequency boost control
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  30 ++++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 189 ++++++++++++++++++--
 include/linux/amd-pstate.h                  |  14 ++
 6 files changed, 225 insertions(+), 14 deletions(-)

-- 
2.34.1


