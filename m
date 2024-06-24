Return-Path: <linux-pm+bounces-9917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C6915916
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B6AB21753
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4781A08CE;
	Mon, 24 Jun 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hKiZ7DKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786C2233B
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264863; cv=fail; b=kRwNmSd8Q0ob5JtI5A60b8asGBhit7D010jzGBy5Q0IOjtyA7i/WVzxEQkF6XZr2T7vq18FAjSPAf6gF3hEie/73gx7yhTfF3sCB2QxAz/tNYHy7+bQ0ZlIbDg4qdUtby16yLVgsYKNgB1W3mHeDWMCbM6YyqYyNj5SVMMbhQSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264863; c=relaxed/simple;
	bh=QPfGjPiYoR+WWThZ0/Obh4l14zk9fdvgZBpmblsfmC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d11MNOrP1wbsFJ1xMY6XwNkqWdGr/f5ayJtMOmmdmhldRUaogbLf+CeKVy/7C9U8cbxjBkL6bvsdi+Vxre9/onksU8pm1CwQ8tvd2gi9VZ/ruKYrJZieZfEbCIUetmvmBOf5GdgfPsCCh1+S+pnHBq/u9/YMpsfhjCmyUyZRZfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hKiZ7DKD; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7hwOw5DJG6OQfVFcB5qgzXzZLyyMQOFK4HOV0U6TvsN5HyABMW3Ym8qRKIDIYK/v1pDkwN9qHmaqz+Gq9iEVapvbHnZVFRukPEa7BIJ3f0tLoKdmgVaUNqQvJUEkjdbV2u5j3pNEZoPyeQuEq98goX5Ue71xnW/EBJKY/MM94zn2ldMDiGtpK7gQ9op5hr4QodzYutS/1O+4GAeSsB40SxOdFOM98K1O2eZdVVAadV+0jiZ51IuKvI8ewL2XObrxiIjkkN6iSG2bIrBRkmaClScUPwizxeABi0s+egTAErJl/r36ihdAWrY3PmQJDllMfyX6og2eMKmLtNhPwHQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex8IezI9/3GmSo7cFdtvQobYg9xb07x9xI+dVXGQTLY=;
 b=BQA2LDXKTwcjNmpG5JsWoAb9r3eST3ImFIscHaaupUHT3AxJoh52zJluEurgxJJbf7iUs3EYJGvFWMlrPe/wDqXlJybecbzANZSRWCRFP+XIh+ymk2I6QJaop1ogahm2Q6L2deuGO9kG8uDhyVSred3usDiivv4w40Z+isFe1hU25zo/C2bFSoXJp0UyheIx7wKzFy6Jieq/UH7jKeJOqbpaKb6KjJbitvXpVhFDADuwwyJMIgE1MSkFgqDnW7Ha+/LNnRlKbm7Jqk/TSVabF+nDXyM5c1uHNR6ecq1WIl3E+tJ6Rtw6Bz1Jf29pCMwmrvkUofqajVhy2sQlaBrLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex8IezI9/3GmSo7cFdtvQobYg9xb07x9xI+dVXGQTLY=;
 b=hKiZ7DKDSZKGG24PoFyhyh+yMs8hxWz5Vo37Fplq2ewZpIiLl4wzjboMbZd4vyvljEGUi/fnqPSsnm9hG/+VRAs45jpxK5JlYjNSs5ar63L7AoKz7arHMKWQKGvvJB7NrceZMB5h4T3G4IC6cSWOh3NkoF16MphUkN+la+/t0j4=
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 21:34:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1d) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v14 0/5] AMD Pstate Driver Core Performance Boost
Date: Mon, 24 Jun 2024 16:33:55 -0500
Message-ID: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: fd759ff1-dec9-40ac-270b-08dc94956704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfioeHXrjHtXDCRf8VN8ytSHus0EXxm94rGRQL7VFnc5zx2M5kHL2DydQENk?=
 =?us-ascii?Q?Eg5ktuhDs+L7wiXsXBq80jjovje9xs1qAKwLzfVHmN8xKUFf3daymEhahPhz?=
 =?us-ascii?Q?Q+U0nRTtl5cuLnoStZwJdYMSklIzcdfYOV5MjxpKuyjVgYiu8GdmSK62aVNr?=
 =?us-ascii?Q?BNMT4Hf+/r6hxy4Z6CIJAuhR57O6uWeZe7AQvlk9QzqFY5IQio2SxJuDH2BA?=
 =?us-ascii?Q?P3zjTG7OebvWuWjwAmO/ba2Hop+9NUwq8D/ZNyQFnBbD7mWatmBmho/iebL6?=
 =?us-ascii?Q?adC3K7wmWus/7EZaAF/qC8FKy6SZJOaNLR4+FUZDW4rqeCoXXxiEIjxRY6J/?=
 =?us-ascii?Q?v5mRCGqf5zX7NHnFezRJyNQlJmFlRxyVCYakke+j1OLpo79QRrMnSCyc2RFc?=
 =?us-ascii?Q?/LhUKs+zktqI4/u0zyynexcZEGHW/ElvRrrp5YHqUs6DWcxFAg+QA8O9IouF?=
 =?us-ascii?Q?7GGEoZQCWHPZn3AZf7QPeJsKwRnqKyiLv5f0c/Fm9MR64VlrK6IYXut6cZnI?=
 =?us-ascii?Q?ocStofefVkKU/kC5x9HMgUQ20oHw3S2POoQwh3TUFGS4e0rqI859ZvmAjis4?=
 =?us-ascii?Q?kLhiel8M5i7BsHHjKBGRHy0ZCo46Lf1+pMFxFCSdk5SxYKCaS/rhz22OjQt8?=
 =?us-ascii?Q?2bk/ds3ZalGy6sWqJpkXc0esGVirRqLjKRqieZEy4FDt5oPqYY2ZQxsbYOx1?=
 =?us-ascii?Q?nT3WjcTobPdYEX92YMGdX1WrWBoZHfHZror+8MriIMg/CkWT32UbS2qHSDt/?=
 =?us-ascii?Q?TefNqnmh+B+hB8mgjYZOVgJjDR6npY2JSx+2ET3ln/N7vSCRo8qUwP+Gw8DQ?=
 =?us-ascii?Q?4i7+gUJx+TTsANEBDnDBIlQ3dircJaUV7Asdz0w91AnokzGyuwHijDjcR2cB?=
 =?us-ascii?Q?Zl+elPjUUf7vTvWb0Xy9wicPae7+Qdwqqn77v3S2RiKpVTQb0/+/WJFC5T1y?=
 =?us-ascii?Q?2PTJoseb0Bd8pvK0eMmS8ZrLZwZbHXZ70u/0qT8fO+E3MEXNjRMYfcScJPut?=
 =?us-ascii?Q?LUdjSI9MZWUKT9eUgsHCjsyzV2EDsE/oEmeinbdLXGL+V9+4oghWlJPxdkkQ?=
 =?us-ascii?Q?tXN01EF1oBUeIddZ3vt2Cpya8N2SpjNeVMmRecHFDSSrBbqQT6lxLhbDcEqD?=
 =?us-ascii?Q?1nAQcKotoDEZ0k3AFUgzxNHdtNlO+hdQzRRMIxmuge4PWBZoAtB6/zeMF3k3?=
 =?us-ascii?Q?ZTAdeJjQVt3jjp1j4Ree5W1OCMnoAG3JhDCfM2jWD//KP8VK1Cre9VVzhybd?=
 =?us-ascii?Q?085agMxs3EYTy3rkEOIiaQnl/xNyCsfCMrxCCSP0hYkRstjqf3vyIRkYrbbt?=
 =?us-ascii?Q?6KxGGreI3NvV3Na1x2yKhsxvO5W4Fd/Z6K0oLZTBFiQ9RhU+SuvooeTBWanR?=
 =?us-ascii?Q?ofqA2M8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:17.8349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd759ff1-dec9-40ac-270b-08dc94956704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

This patch implements core-performance boost (CPB) for the amd-pstate
driver.

It's a follow on to v13 submitted by Perry:
https://lore.kernel.org/linux-pm/cover.1718988436.git.perry.yuan@amd.com/

v13->v14:
 * Drop cpb_boost global parameter and sysfs file.  It's unneeded right
   now; but may be introduced again in the future later.
 * Squash a few patches together due to the dropped parameter
 * Add a fix for incorrect boost value in sysfs during bootup caused by
   commit f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs
   using cpufreq_boost_set_sw()")
 * Correct some typographical errors
 * Add Co-developed-by tag for patches I worked on or modified

Mario Limonciello (1):
  cpufreq: Only disable boost during cpu online when using frequency
    tables

Perry Yuan (4):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: amd-pstate: initialize core precision boost state
  cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is
    off
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  16 +++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate.c                | 120 ++++++++++++++++----
 drivers/cpufreq/amd-pstate.h                |   1 +
 drivers/cpufreq/cpufreq.c                   |   3 +-
 6 files changed, 120 insertions(+), 24 deletions(-)

-- 
2.43.0


