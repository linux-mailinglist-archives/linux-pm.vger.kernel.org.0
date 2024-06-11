Return-Path: <linux-pm+bounces-8916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97A903719
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5828A120
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76383174EEB;
	Tue, 11 Jun 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ig/apmSL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404717554A;
	Tue, 11 Jun 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095969; cv=fail; b=fNJi3tCijm+0VSf4OzZi0dyEqFGnYBEHEeUZKkDZPsS4JfnlRH8EBZ8YbyQP+1BQZMOpsXveCEdOK41ficK38afp0DsPRPNiC2fgXdwGAO7AG3UUqsK7KS7MB7F8Xx5M8fNlmsxwS2Lc+4VAIlWc2IrGMnpnkXSDWWaQm7ogcpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095969; c=relaxed/simple;
	bh=hWhU3mMt3w8b/+cVlfId0or+5ffQyiS7TMt1uowgbhE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bi9nInyr/89hq9xEiawKD33UY9dPgJ8qwhuJ3TRNZ72HAy8v703TM07D75QUlCEKGWqNpAMcOpOs0IXH0ViafJgHKl7rJtYobhaS1SMamKsEgNmLMTdYRaELNNKbNaB6jXWPeXpAVnc7nYMGHPqgjvmjcz6DJoxoCKcUOM0EV70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ig/apmSL; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcelLNOx/jsqfuVPujunvSCKyAfDhDnqo2tK50C1hTvsZmPGxxcgwBoZVEZ4PRWixSUMv3O7u8gU2gGqqW/uE+4kZszVYJ1ToSiKLDDMO2Q4xFuFxmR1+kMHnp7ZbgTUbANgnQ7Rltyf7fi0yf5biJ7dMPFgSy7yovC+hOMJdH0xN/c1LJWVHY81Lq2EBhN6sq1XYMeFTqenTiXFG1eR7nJfrj8m3jI66M//ept7LkuvZp58RnOay/XGiPs1QBdhSxs/NuAPef80lP1QgT7Zd+iw73ko7AMej8sjfmYuOmPLp50TE0N0yRN9MnP021UplaHnKHWVi8I2aRSQUd6F+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/RTtuSBKp3pIo0iJ7URnUwFW77XxkhvSi49MRDD9Bo=;
 b=c8Ro5GKE88Ma9gEsMCb+VPC0SqgFE/BTWz9o7+mmDxbKSdmMzVmAfuinQUPEgvuD+PNosIZEW5z67ieeWguZegPGYgjVb+cl59xLRvPVJWmM7S142HnfC6em0PZwqQFAf2+n3ULhnWuDZXod3PpvpUGqzR68Dm+VdAyr5zXLOOu06+iCpU8N5c33MrbstibZ1Pw5q7+66/Zs9+AbWCe/3uzDR1GhIwhM05CdIIyzDag2czNI7b+Onkilxa9Wi2ttF06XDV3tV3uNLgNwnBRNQGfyBY3bk+6vESleQlj0SnbsyeMUEICL/6oNmjX4hAaHKkCfJWwdq5jR34T83UVsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/RTtuSBKp3pIo0iJ7URnUwFW77XxkhvSi49MRDD9Bo=;
 b=ig/apmSLMsQU3m4irsyI0dL0/is3LRhsP9oPo5HmRMA1NnjEvl/O6/Mx/5L71TO+suxNKQ4GD+UeqG1fOsGPfRt0s/EmOVE7UEWnTmiqahBuMPABZe34rIouhZe2Scp5GuEamOpX+e1RBNr3FxlfDZZZPRPdI2V5mYMbPCbtplw=
Received: from SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::20)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:52:43 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::2b) by SA1P222CA0152.outlook.office365.com
 (2603:10b6:806:3c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 08:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:52:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:38 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/10] AMD Pstate Driver Fixes and Improvements
Date: Tue, 11 Jun 2024 16:52:16 +0800
Message-ID: <cover.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e83166f-7b5a-4b36-49a6-08dc89f3db9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUyAMWZQSDzoYhhbMMkjqMJhaG12Sl+RdG4IOE8emUACRkM2Vn3/4ySqUKSZ?=
 =?us-ascii?Q?l0Cf3tniEQXtVIefaWlmu+rNtXmkPbDkDGpIYr9me59nOAvtCtmsTJ8BSSl9?=
 =?us-ascii?Q?Q9tp0orZosUJKbzLzzdB1N65ZR/3TmX5tgs4Zas3dsDs32J+JJgSorcvoFOC?=
 =?us-ascii?Q?DpgZ4FLRDh5kwLsDl7ZAq12aKUJaNL/QsjYzghVKEe7gN7d37iHQB1UW3AZ0?=
 =?us-ascii?Q?7DDTr8M9q2szeHTKShPuIMGJn1StpLeZ/VY3BHIoBaBgABqskOmgxiCkZTDM?=
 =?us-ascii?Q?/14QMynfPukivJRfYF+r2KsCvGRkoXaa7zIv9qlu9xJWvBHwuyF57hk8Cijo?=
 =?us-ascii?Q?x5fdzZwig1Byl6AH5UelftDgvVhq9E4g6bO7FG8mtj4Qsemk85IKxvkokuWW?=
 =?us-ascii?Q?W9sAnkXnxTkfkMO3XJdcbXx66VuSimpDrdNJ2uU79501egBTWXOxIPAyd7D4?=
 =?us-ascii?Q?uli9aYLn9BlFFYPC/vI9XOOVJiY7wjI77+CQ498qwBvSnAadOfJ8S+YCDixd?=
 =?us-ascii?Q?+stC4nOW0rH3ZMIDVpsg5qXclOXeshfnELFdn5yOK3KmF1f1o8oK1cUPPNwY?=
 =?us-ascii?Q?WNzxivAXpjbl6jt/aZaZxF8IjoWN2rKxc/5P4n/fz0BvuTDHpfONRW7R+5M9?=
 =?us-ascii?Q?R/Vo7BVy5KAzWSinf0ssaIeX+aoXAFzSArHNwnLYc7XZSYG5OjJo1ResvKRx?=
 =?us-ascii?Q?EI+5LdV3b9ZC+MZRJ6dYexHWbetZi2Y6V0PBJ0Ksc0Yp5suqftZOH1urVVV6?=
 =?us-ascii?Q?EHXK+mC3KHqckSomAdoI7uVf78+I+ZV1qSpe+GnmYH5HS7HBfXf7gLujpBCP?=
 =?us-ascii?Q?ymSshLIILUMul+mxtkdHwfUCiuf/LgREWQZQdqM2fzSw+qtJQBloyZVwCDiZ?=
 =?us-ascii?Q?HFZ+xFSW97xF7iX4jFhrtXcvH+E/tyCE10t5METDmBwkw6yuzYq8bGP2cHuj?=
 =?us-ascii?Q?4pmvd0aZv+6LZGhI/75HFbWLsgUHxw+JCKX3ZHxtsJ0F4SbS7Vyt0d9cpHtH?=
 =?us-ascii?Q?TImjyY3up2qnPuxzmF7Uunr9STELyL5KOayBp6eVzmKx1xCRV81pc/mdKqMM?=
 =?us-ascii?Q?Vf/Tm4ugD8ip/FIJeEKxiDPdQTQVCBUs5/JUjSLcI9ktfkSMkdBoyxQHSrd5?=
 =?us-ascii?Q?AECZNArNG2psmpdXYe6eyvqZn/eHpR7r/8TNyB3iaw78R/B507yEKCKx6Rpt?=
 =?us-ascii?Q?ORbm/i7bRRjAHEYEYAitDgWPGKfUo1oGYZs/k9K015nymTRAX91jMmfdJ2PG?=
 =?us-ascii?Q?V7p1VfiW3+GvTzSmfWCNemzdXGpB9xFy/v7KTliFxmDny6R/m9K2CkjQ8G8s?=
 =?us-ascii?Q?XFw8fwf92le+QySOaKbR4r+skHPId+5CrMwpd58QOTg7p+2PaAHRAs+zlr8W?=
 =?us-ascii?Q?ztmHUtZzQ8c/1dyZWBW3gZZbCRkyNflrHkgSZ0jJwNWSqlERmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:52:43.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e83166f-7b5a-4b36-49a6-08dc89f3db9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

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

Perry Yuan (10):
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
  cpufreq: amd-pstate: automatically load pstate driver by default

 Documentation/admin-guide/pm/amd-pstate.rst |  15 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/processor.h            |   2 +
 arch/x86/kernel/cpu/amd.c                   |  19 ++
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate.c                | 201 ++++++++++++++------
 6 files changed, 181 insertions(+), 58 deletions(-)

-- 
2.34.1


