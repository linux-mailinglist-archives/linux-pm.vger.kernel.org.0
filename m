Return-Path: <linux-pm+bounces-18743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF09E83E0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FC42818CE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01BB2E630;
	Sun,  8 Dec 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h3HnSkLy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D83D66;
	Sun,  8 Dec 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639457; cv=fail; b=argJ0pnBZZ71YVIV9wqzk4tbgn0WPoX0cqcm/2oKEbYdt0WMLrfoHFCX1tMftyF230pzNPSZUBINLUxmtSSydycddqThdkDmTK1d7Lh4tiCP1Pp4lrBeia0HeoNHXYb0ZtcvDUZxM7iKRH2ahrj9moF0o269SKdQVGyZhWuaY98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639457; c=relaxed/simple;
	bh=KY8gtsG7yRhX9pyFzTD04V/UjNNDnyCXoxNoVeAC+jQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dumbdbfKVkNVclRYx3YzKcDcdj/5r5Yep9GarEI9XKw7eZQLX2WmGiRXgxiDRqJ9DDwcr/ZwsB1rX5bCdWEn0F9mTKr64EoHoEv2FWjwyzul3EKSMDIR0NVu2dIy/VlQ8gr9ggs+t5Ncb8m1f7N1KirxHdvIU4Iho5vewmaP1Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h3HnSkLy; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPHxq1uxhotjfKFfFFbNKrv5Xat8eLc7wECPjWcFOa2Ic2ljOWGvUksGHG6LME22eikBwhkXCm4DIgTC+UcCmIBHIMfaBk85f6W1SXFAC1UbePYLByEvL8okwXJIKm2LaUr50LZnmoRa3J4MUxm+zzjGZn/Rq7FpLZ5ZhNNbHp9dasZA52IAQIY1o56xXM46GRwWP01JuzXGFF9c8ouCiO3KEe6x+nMGdnNq1Kg8uOiVH5r1TIT3DZ42zTBQKe7S3BKBGngI1/xyZCQlN3xDASoYqtgATouKGjmY3CU+ivtsRxM/lHe7WDRX433hXpn07xDF7hJ0Pp5IMW7ANAkHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8VXuOUcT8OJ0nouVz2cdYJLliZI0S4JCIXB0+Ra+K8=;
 b=OFYgb/M+VENAEMQOGWkp+9JjRNoQikEpuwiDqDAosXw60XzkKQ2z8i1dlbur6APFl77QJ9APZcDqCGP/HN3mLY50kT31dYPAZ9AOW0LB+JqoJH5x6Op3PvUgUUnFr/LEGMadEglxWAg5YCraYTVq5iFRhEpAd6/sSdcbt9KVc+/H2DEFc7O8sAKLfPsSIvjAZ+ldhskPMuVEFFFGPz7/t5oa1X2yX7VzGQp5jBMl2ev1zZM3QSAg8XS7MrAy9Pf2zUK99+12rKQsPlW54wN/rPaWcyAnJ82rXB2sNzLn6lIqDQGrow94eHLswOy25H6+8kwlPnI1YcAn0IInT4B22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8VXuOUcT8OJ0nouVz2cdYJLliZI0S4JCIXB0+Ra+K8=;
 b=h3HnSkLy+xpN/nBfGgCq9QG9Vw2TZBBhQn2k0dmG5LOU44HWxKIZl8bYBKckpERPqCxU5TGBXoItcG3oxG1YHcjzslICdfm+t7lrIBUYwS2xsX3HrHXJrtpU5d9/VhLG8LxJS05+cxnk2wEW1Y+A/GuVgIp/ZIhjoneB39d50dk=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Sun, 8 Dec 2024 06:30:52 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::14) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:49 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 00/16] amd-pstate fixes and improvements for 6.14
Date: Sun, 8 Dec 2024 00:30:15 -0600
Message-ID: <20241208063031.3113-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c86aee-922f-422e-d3e7-08dd1751dca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/x6N2Ltp3fuZINjghXQ5VqjizzPqSh/C/rZGd2YPYLAzZl9Dbvzd5h+O3jdf?=
 =?us-ascii?Q?GMPGIIDMMdx4zXjJr4s3m+PRCcIGlMetlkObu0Z0weClPYNZXj8oUvvjsPCM?=
 =?us-ascii?Q?do9DPytMI0UoryeXpiQ/u534D9cYr7ya8h0tyoh1fK3nis9FR1XqyqnHYiGW?=
 =?us-ascii?Q?Vy9utVEfDJzDmumBryoRKqNTusV5xUXrqRkMS/w/b0/RmuMEEnpoD/VVrDFj?=
 =?us-ascii?Q?VRwTMDwajmfx8QVg0Wz22JQJUAt3rNvMwcOMqjSgCa2FIC0mhVaoZ8ZT1JZP?=
 =?us-ascii?Q?iAkeyzQCdQg+cMmPa3+En2FL00BwjB15EFK7O1ox/fQrFH+GHFkyD5vPLtpV?=
 =?us-ascii?Q?54eUX8bfHlLE91lHHKowDN0J7OC2c/ql0P6+ZZR7iEE0OK5rP2ScUFrL4R6Q?=
 =?us-ascii?Q?EIhu4hHMkKGLwfsmRHO+SG7L9yW1k6B7/XRFErUfcaqXFdVlMgfTFOXg3t0/?=
 =?us-ascii?Q?l2PPZpzYEbJkdqzZXdCSbnSqTH4zEd458BcG0oUMwHi5D6pPTgpAc5IxEtHu?=
 =?us-ascii?Q?7U0FynWbrt+25l84uVgBdX1KVu7ptTqNlK1MyFz+u4D/8QfGzoCHh2X52awS?=
 =?us-ascii?Q?U2o0dq7UaTE4Xywfc5O2uc3qJWFxfBJC/NUCMNe4Agaer2MB9AcgyqDMgrxn?=
 =?us-ascii?Q?Od2HVuoesSa5nebRxv/a9B7v0lk10OSSXG+PMdNYR7a7cWis6WSc+FORiSBs?=
 =?us-ascii?Q?gWdE1y/UyoG39/NpGL/nLf6wFPHnpDmphxspvFvjFj321JAFud4iPks0xmod?=
 =?us-ascii?Q?AusBtY3v+8DqUHBi7Z8NpSoHr1zPLkEaWtoTAZGJ4cyCYq8EWh+6nNxIGlwn?=
 =?us-ascii?Q?LHNxTFCLeL5CcP2bsEhZ3Ph0d9B3T8/UxpH5/p3CiQHYgtHbnaQY5IwzaD5x?=
 =?us-ascii?Q?g65oeNY0qq1bAcpElpQykgj6pnkIHfJi5pxlQMqEkRQ0w1PDGTzvSLi1Uix7?=
 =?us-ascii?Q?SaZm3ETAZC7mVp9NEG9xaYsRGy9sBuTMoJTk8h2MegKNlTtn++nym8ijri9N?=
 =?us-ascii?Q?0Ixrtcj1brR6/ovTGG65ezdavSI2n6LFBgZGmI+snILtJBNphGiT5S3UeIj2?=
 =?us-ascii?Q?pPwI/h8F1UIVNhBBdHxp6JqrnycH68RANV2kC49GLiGF2lnilNftU/ptuPXF?=
 =?us-ascii?Q?fLo+aPvwO1o5uOHkJJ7Ym9Q1ABpp/hUGkjt5qB3NxO3mzc9arHmEGpDSx/1H?=
 =?us-ascii?Q?T7EACE8K1ZCuLGFXOvmD9sZGzcVVAIH6UMBojvwxlGgycr4UxlFKxZn2qnf6?=
 =?us-ascii?Q?QrmmFrdGKRo/4IQ2un1OIHVNvsIZJkDnfNasL0EgZCIgmhTK1dmN/00Ke1Nl?=
 =?us-ascii?Q?rYRsaXa/vOpGA23mAUWLdrUDYwZBL+MSqqynxgvo7W2aDpApSWZZDxiudATP?=
 =?us-ascii?Q?WyvlHAlN6iewYVjs0N+rvhPwcGSC5JIvhjAhW0PW+i7/vY+YlYOOCbSieClA?=
 =?us-ascii?Q?7zOintfVOCaHXIMuS1Md4+q5zDHemqI0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:51.6077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c86aee-922f-422e-d3e7-08dd1751dca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

This series started as work on the behavior around boost numerator that
was changed in the last few kernels to make it more expected.

As part of the process of these improvements I found various other
optimizations that made a lot of sense in the context of the code.

While I was working on the issues I found it was really helpful to have
ftrace for EPP, so it introduces that as well.

Lastly a bug was reported requesting that amd-pstate default policy be
changed for client systems that don't use other software after bootup
so it includes that change too.

---
v2:
 * Pick up tags
 * Fix boost in some calls for tracing
 * Rename macro from AMD_PSTATE to AMD_CPPC
 * Use nominal freq for consistency
 * Drop unused lowest_perf variable
 * Drop extra mutex
 * Add patch to drop another unused variable

Mario Limonciello (16):
  cpufreq/amd-pstate: Store the boost numerator as highest perf again
  cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
  cpufreq/amd-pstate: Add trace event for EPP perf updates
  cpufreq/amd-pstate: convert mutex use to guard()
  cpufreq/amd-pstate: Drop cached epp_policy variable
  cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
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
  cpufreq/amd-pstate: Drop boost_state variable

 Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
 drivers/cpufreq/amd-pstate-trace.h          |  52 ++-
 drivers/cpufreq/amd-pstate-ut.c             |  12 +-
 drivers/cpufreq/amd-pstate.c                | 411 ++++++++++----------
 drivers/cpufreq/amd-pstate.h                |   3 -
 5 files changed, 250 insertions(+), 232 deletions(-)


base-commit: ab9e5b2eb56412cb8c63b46b935878d29205418e
-- 
2.43.0


