Return-Path: <linux-pm+bounces-9599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8590F261
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F171F23517
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E115252B;
	Wed, 19 Jun 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TO62vXGO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637B152170;
	Wed, 19 Jun 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811644; cv=fail; b=W9Yyd5iVn85gyKoOzx9a4w52V2ty4ky4fHum9ZauDUfgGurMdq6eit7hQMXHxRJzvezowMVEToDn24lDDTqIZjWdYOCDDu6+Ca+pHdfgWQp6TQ8YvqHs04ExRPCcMhso/LAYUgTx1wXo59VPu7mpQV3qDYWRoF8TUsV1MFw5bCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811644; c=relaxed/simple;
	bh=CqqOTcjb8YDrvxRG43PIWbw8cWBOUOS2htSZSQpuebo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZcS1++wAs/gezJmKjPviZORhg6Wu7sHBESUNwIgA8xsHLwUa3svn+T83vvbcenqQoP8mjcOpC9lKepMcYg03gN6g3LxB1tSpVGS+hDNQ5yENu/nYC+4VkjYLqciZ/1acr7BOOl/ajckcf2J6ibgUDmiPVIb93KOZNghJQ/WRQJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TO62vXGO; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDTHzAVmNn79p5QUYeXG1QwgddzM8R/eTzc7duQkG+Cn1rFyhm2xzHayo3t16P1WlO+77NMoubbBP/C+PmzOSegToXLhuLesz3eQN6/V/7gFE3PtcvU2pAjz98G3CA5cVho9Hh/Q2bc6/o2o52LCqlTcbhmH9V9q6CKEiY16wIL2Ixstr1etNLkq+sDK49258Q/OyWfkEjpeIJRSYOL0RIkAJPd33l1ZzqHP+v1GK9DxrtErf+8oFKibKZAxxhbm805LBJitd5Ow4+77Tdyj30WRvZNnICnP8bRjwB8uBTja5SCvbZfyw+On8J19TFIgULTi6zWd+y3W6C3bDIcKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt5mYAyAYdvoHo5t1Rc+lVRUMJgUsb+MNFKcKwjD2cE=;
 b=fwJbZwlrjtI0In6x7DWmT1PCQy/0ToN56fGiZEgMDj7XHMUOqUVRbyANIRIxLs7De7Q44PAxfdqNUJVO6SGM6ewAbNzOZSrYbzmGKacTSRFQ/vfattI+uCH710DC0u8X37Ok1bOCd370hrwXycJMtSniRsftJk035lWJjNuTo9izAjTxuFKYXY7S2NBN7DbgbEmgq+tA5PvgEFJWAxACppCtbaMubRavbrUnlJaWtVs9ww9fn8pSq6sSTg4WPoKMVN9ExqxXZwM0+vzyxGCBi0Y19IJaD9rzzC7stRZgDW7/B9s33NaM0nzIFoYlrT7w/6Lmx2UjOEToU3oZjsn2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt5mYAyAYdvoHo5t1Rc+lVRUMJgUsb+MNFKcKwjD2cE=;
 b=TO62vXGOs13v9qhBL008br0OKm/s4fU3f6PApVxTVjxy+gXcID0Bi7ykFmIKJMCZmoTAUwUkuYPIloWc7I1W0lDfAOlS9q9ZW2kmCsLEdBiSCyjuby7PY5RRu7GSjiYXMnN1z3x3oL8iHyCCCHb4F7n7OdzkMwCjR8glWfxc1Ro=
Received: from CH2PR14CA0037.namprd14.prod.outlook.com (2603:10b6:610:56::17)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 15:40:39 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::fe) by CH2PR14CA0037.outlook.office365.com
 (2603:10b6:610:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:38 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:35 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/8] AMD Pstate Driver Fixes and Improvements
Date: Wed, 19 Jun 2024 23:40:11 +0800
Message-ID: <cover.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 34950d79-6fbd-4fd0-4ee4-08dc90762b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AI1ZuoVaDp3SnSa8+qMuP9lMbE5lxsFFpR+xuexz5HKvyUE8hUOI1qcf7gJ7?=
 =?us-ascii?Q?MkaVZvVYEoaVN72sWk9wezTBSHLCsgP/yAyIe2SxF9lr7KjnfCju3aSoomuv?=
 =?us-ascii?Q?D6cOdWqBGGjJ+0HEaG7WY2OCi165awmgbfPLPa4dP+n1KbEsH25hlbpGbNMp?=
 =?us-ascii?Q?fb1DlF89/WvJJx7Tkkz5wJHtRL1T2taBNKm3U1ZFxlZADTqG88mpmZpRMkVB?=
 =?us-ascii?Q?lovDQgaxuQNWuLQosBdC6O0Bkfk07KvfGibHH/mH73fJzXLqGPytzrS9A31v?=
 =?us-ascii?Q?MeDmOyQcXcWlYYUuWojOyP7dBVNDQknpD1qlD8OvAS2x0EkiJDB8+DlwSl1U?=
 =?us-ascii?Q?un1wmcbEjRzbxNcSCrHO074D4JLRrLs5gNTYbDKK4Dg+JVhMLsheOXGefufr?=
 =?us-ascii?Q?OnnHjsJ2gJfrSzGgDD86znqjSY5cvHYgr1kybnawyUyAjK2dv5oSzyxijsp5?=
 =?us-ascii?Q?G5pNmLgEmcH+KbLXEsSumz1Ok16k5t4Oizt8+FtyzU1hCl+R8V7MyN6SIjh/?=
 =?us-ascii?Q?Ws7KNoyfICDbAM6tWOIxdrOB4tPT1mVuFwhSPYuU5uypAwRqgBklt6shE0YM?=
 =?us-ascii?Q?4TpB513/UcRA3Nmo0DuePqKWzkCLB6fYSLOiRJ+bYShD5++Rf7/R56L0LrhB?=
 =?us-ascii?Q?9/8tOwQnI35FlSPYtaQtTICLQIAC4kizs6vlCT5GhgUrWA4pJrj8N/XZMBRT?=
 =?us-ascii?Q?cNzB1lN9htMN9Oep2467ox3I8jCfT4HdnCEC3lreYRfuUgUHUkYta9eV51gN?=
 =?us-ascii?Q?eEOMWO1IN8j8fCBia+GsiXWUSIVN0sC6ifCfI9jeY6FJs+1GEMsKpAszqvpT?=
 =?us-ascii?Q?UcERmUpLDTIlZOru19Qlq/tZ9hsrXGSR66UJOvH8nT3E31l4kcB0xkShc2oX?=
 =?us-ascii?Q?VRYZ+0yXni7V9MeEzhKEHDNvKJCsyq8HImo9zWBvL4bBFMXtQBrCHXalS2Ty?=
 =?us-ascii?Q?s7URDCmnAiD1a3h/ipjr+RgeS5X6ObjFXR6rm7ivOsMk82J6QoSziaK8qX6g?=
 =?us-ascii?Q?oqjjhU+o4I6vvuYNX7FbijdZ2Ml1vhCkRHG0CNZDVvvdB/vzXSGVFxYgbN2p?=
 =?us-ascii?Q?/jC5SXOO0p4FmSdd+x+erT0uvckb75elVu/lCK8gBVX8E1HWh2EgrUAD5ms7?=
 =?us-ascii?Q?V75N/HHwBM46w38cuhJNhfoZiyiuclrtQdJ2hGb1KGst50QVsabh7fLCOFFI?=
 =?us-ascii?Q?ewRqZ+DUZusXedGjaTO3AMNZ+8ftpycoJwFSrO5K8L17WqTRyDaifOzB5ElH?=
 =?us-ascii?Q?4Ct3Ss00H3vIwGQgW5dj49PLXleOuGKqRDmWk4/qw+gf4oTI2pXdTySbLYVW?=
 =?us-ascii?Q?yBDHj35CU2xCjZonBQrslWYetkENiGiq/Iu8sPr4TvCRdrCgiwR8iWFu1BLF?=
 =?us-ascii?Q?yXUPo/lk+A2FexC3tlLlSxjCWnDbqfjRG7qsPHkrdAaqJmT7lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:38.8242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34950d79-6fbd-4fd0-4ee4-08dc90762b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

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

Changes from V4:
 * pick all the RB by and ACk by flags from Mario
 * fix typo for patch #10 in the commit log
 * improve the commit log for shared memory in patch #11
 * drop hetero core type patches into another patchset
 * drop debugging section patch for amd-pstate.rst

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

Perry Yuan (8):
  cpufreq: amd-pstate: optimize the initial frequency values
    verification
  cpufreq: amd-pstate: remove unused variable nominal_freq
  cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported
  cpufreq: amd-pstate: add debug message while CPPC is supported and
    disabled by SBIOS
  Documentation: PM: amd-pstate: add guided mode to the Operation mode
  cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
  cpufreq: amd-pstate: enable shared memory type CPPC by default
  cpufreq: amd-pstate: auto-load pstate driver by default

 Documentation/admin-guide/pm/amd-pstate.rst |   2 +-
 drivers/cpufreq/amd-pstate.c                | 145 +++++++++++++-------
 2 files changed, 95 insertions(+), 52 deletions(-)

-- 
2.34.1


