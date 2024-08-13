Return-Path: <linux-pm+bounces-12135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECF950196
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66476B280C8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3A1898F4;
	Tue, 13 Aug 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jhHfFK1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF3184537;
	Tue, 13 Aug 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542702; cv=fail; b=G7tr+FqgLtveSVWtIas72K4gY50jdRMUe68XsND3P6lWPHf+pXLgVwcFmELM9y1eUBmX19G6SQRk2zqquRv5USr5bdAm4H3GNlWWh9vJC9MH5VWKltIqTXv7cSphwHZ77xYt5kyXyp7XW+ql/h5ZDXQb7BUynpzNl1sSIeiDCwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542702; c=relaxed/simple;
	bh=RCJR8crysmmDKMQ6HOlfkH30BUUseN7kOP4aBJunjSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mylr07bY6j38ZLuY/5ek1+0QDLAa1UEz+xxd4cPulXC75Y1fQ+Aiy+haiLFnhkEYHuvD8BiLApLU9dhds52ohd9RyXcLD0i2L4qVjhDqg2pXOJnriiu2mL+Sl7Hw2BX8kPd8/4H0LUNby+8oKqcLxK6XpPimfVicuBjfGaI+kYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jhHfFK1U; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrouqghwMmIIO52HSJ8BC6pv2+C1vvlxVVOkgLNrI+o1YfNRMeoyJPiJaqnMGEP8zcHhzWwCRAUmfcpzU6am7feCwc6s4BIyquyu0XnmpJWFSJ1JZyEONEhmRSgVB6tne6ykA4QT5Dtht95UuYbOd+orR0m93sjVkfvmIO5G33KfD0V2xFEjMWr7yjfbDoKBDLqnh1V8vvQrxgc6jdAJds10mqZQoZ1HnJ0qPOjiJrfe5I0QlsO/8AjKR/PwnJYUk41hp5KstKMuBUQcABBuWDyT6HGp5gAuqyrYhPT1G27HdqG7Vnp4FndZxQsSqXLocYbmPgbLDfKa8aMTp/HTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh9mabdVmOsskjJKrGGB1tqVHWBMH0WNCJPRf8SkoDc=;
 b=OGCWHW3TZlUjaVZbCgC8X8V/fNFBTsCMeVGw+WTEy9/vH9Y3mV7S7rwEbhwm4gNd09M0WjOwbFCaQfE7uYL4mqtwY0DstS6boZjSJIulI5uatHSpc/yxPJnH9XvldOMHFmoDBQcRF+HFdxrOx2U4pzie3NbpGzReNWetQ0h3MvbIIubN5/YEWYXpQWzjQi2qnAZgGByqByucoS8bcQpukWW/8s5Jc4bqP2jKjQKRAYEkJidq0+Aky0wEfu4+cse1WfcGJfH5dCSWL50hidYsj+MIljduVcT2M+vpby7I6ivWk/rkGsB9QEe6EB24kl1h/p51JiihbuKp5GYcdeFPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh9mabdVmOsskjJKrGGB1tqVHWBMH0WNCJPRf8SkoDc=;
 b=jhHfFK1UX2zQn4LgyM3dDjLsdXvobLmHq+lsmGgyOy9tlr2EwMEWo9LKRDOZE7z4m3B6p/DB9B/xbjtEMrTTUStLrvSEaoOsStH+PiKQFyhs4eOPwbJOM5396qRMIlKE89BRPFPSqrcoTaU0T2mMM1WrdvtjpPETKqzqCkvkTzE=
Received: from SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 09:51:38 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::42) by SJ0PR03CA0013.outlook.office365.com
 (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 09:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 09:51:38 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 04:51:34 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Perry Yuan" <perry.yuan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 0/3] cpufreq/amd-pstate: A set of fixes 
Date: Tue, 13 Aug 2024 15:21:12 +0530
Message-ID: <20240813095115.2078-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 360fc800-3f95-4ef2-b2c4-08dcbb7d86c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/zcJOnJVhL89QcPlhebQaHAkwRZK7vfjzNOsRAoxLca5QyJQoEZxQDCWBT51?=
 =?us-ascii?Q?/yhY+lZixUY4g21Kbs6QbSoVL/K5yqzZ6acyZJMyeYNaGXNxgNZ2jee//iDr?=
 =?us-ascii?Q?KyjtuWraeqqVy0+W+Cig4stjkEQAmwOyUXIDYefFEboGrrLOS6ZUa2T98LB6?=
 =?us-ascii?Q?lneqKzGayWvmRYZSdP11Kjz1kAhDoRuhOmumkgZ/WqOp3wsZmAA+bZ44efFB?=
 =?us-ascii?Q?LyKIQYQkEfidHREFpiRY+PXIwY69aUpruE5FbPJdkxJhrX5cy6thUiQAfR3/?=
 =?us-ascii?Q?V1/WnaY64Earer93h4o/xct64bUcip5bj4yNPjqL/wkazGEVKZjlLSSU+uZj?=
 =?us-ascii?Q?IO3RLq/jgGV8Bv5rCNChlDZSeMyAc+NaO3ROZ1wPqVzXlM7XogpZ5MbAEq9p?=
 =?us-ascii?Q?/MydxOO0K0XCfwb41ysW5gEptbwpKxuLorV5FyOXVF5CQcQkOjfLLyuZodEL?=
 =?us-ascii?Q?rq9CPpImRQsMghao8QE7Uxwq9405P8bP8HplqZcpJTcnQ3y3whhwykvBaYZ3?=
 =?us-ascii?Q?IOITY0n/gEghLB2RPMOTxagMnF2/hBGJAxPFdLQA4RwT/mz7GJuuRv4QO1rz?=
 =?us-ascii?Q?VeujOQY2pWhAFJaUAo3+/jbkNSq6Fo4xTja5Lw2f5ZEwL20LcGSfXfMp5g5P?=
 =?us-ascii?Q?+9ForBqe5Tw6U9gcodPoFPJ0J3RlkOEyz2TOcwDDsra14E/KvIWtE39pIWhc?=
 =?us-ascii?Q?OsYwI9V3Fz3v9ElmmUCSLy4l/RApjdFW+cp9a18mEUQYMfDfcbsqQoQ8KDOs?=
 =?us-ascii?Q?JPX05I8/LxTh/7GusHPmVweb4GAAkdO2cXZduQPLqYwEK3x4brbA80BT2dDa?=
 =?us-ascii?Q?KbMooEK+oUEQb2+oEwIcBKxjEk2QrJGFwj5bnqnSELodh9IBikpiKEhNBETE?=
 =?us-ascii?Q?SIO5S5tX21bHgW3uMyoH3rQrC6ilOWnTvbK2pvY0OKw1HWaCCPaUR1ti1N5X?=
 =?us-ascii?Q?dCZxcO9UPNsswcyT2n6/9QYLlUhxl5C8Zp16dGaTyOeLQwsFp6n/scbgteD7?=
 =?us-ascii?Q?LYhuEAMDOvTMhvqLheLhwOSGOf3d+dfxNvRuicY/8u1KU+cZbMsiU+7usMys?=
 =?us-ascii?Q?mYmDFqMJL+9YNP39NKhNTfdcIoSiFyWDVCe6sCMNfFs3WyaG+CpJU1MT1Yb2?=
 =?us-ascii?Q?i1pUzw35zCu5Nn5+LhF+lsz5SZXFweONV4JS4r6MJPUSnKeVISdttqbajAe+?=
 =?us-ascii?Q?TteLyT2i4fnDcEaex1MC1xlZCivH/38ArBm+CLFp06f6niGXz6n0BQQBevEa?=
 =?us-ascii?Q?PuI6IXpy+pGQjIKSXV41Yvs0BlSW/PWRvgh8f5Exu72LHYaQ/ZOIQKxm79QW?=
 =?us-ascii?Q?PMLj+u6w/NgmVfTnXzKzsWGNKAdIiAw0khXsht0P8LWOV99joM0mK9iqXlRd?=
 =?us-ascii?Q?E4/FxuuEPQRjFzkgXpcj7KcVJ6b3zqNz2aNyF1l1dO+axG8Q+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:51:38.4483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360fc800-3f95-4ef2-b2c4-08dcbb7d86c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

Hello Rafael, Viresh,

This series contains three fixes for the amd-pstate driver for 6.11.
Could you please include it in your tree?

These patches are based on linux-pm/master with the top commit
7c626ce4bae1 ("Linux 6.11-rc3").

There are three patches,

1. To fix an uninitialized variable in amd_pstate_cpu_boost_update()
   from Dan Carpenter:
   https://lore.kernel.org/lkml/7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain/

2. Use topology_logical_package_id() instead of
   topology_logical_die_id() definition of the later function has
   changed on some AMD processors since the inclusion of the CPUID
   0x80000026 parser:
   https://lore.kernel.org/lkml/20240801124509.3650-1-Dhananjay.Ugwekar@amd.com/

3. Remove a warning for the absence fo X86_FEATURE_CPPC on Zen1 and
   Zen2 since they don't have the feature defined. This fixes the
   regression reported by David Wang:
   https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/

Thanks and Regards
gautham.

Dan Carpenter (1):
  cpufreq: amd-pstate: Fix uninitialized variable in
    amd_pstate_cpu_boost_update()

Gautham R. Shenoy (2):
  cpufreq/amd-pstate: Use topology_logical_package_id() instead of
    logical_die_id()
  cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on Zen1 and
    Zen2

 drivers/cpufreq/amd-pstate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.34.1


