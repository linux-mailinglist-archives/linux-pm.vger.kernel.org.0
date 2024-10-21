Return-Path: <linux-pm+bounces-16068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD819A6273
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B6C2830C7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606551E22E9;
	Mon, 21 Oct 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CoYUZGAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF39DDC1;
	Mon, 21 Oct 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505946; cv=fail; b=k+XivHVexyqF+ylsir4eUeQ9FZL8GCNqGYAWJnCBbIsyeIDtOKWYtW60X4jJBGpXbGSNpqW2S9EOtGnYTWsBlIO9Adzm7P+xcAJ9kJKHrKpnzo6Y3cTuunzTSWixdghIUxBUA24xx28Rl+Qt/4kJA/7zccgQWlBcz3WdYNqvDFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505946; c=relaxed/simple;
	bh=Oh2zuFzUCcbTCu5Svbm+3LpwCe1Mnz/GG/j6tsl9mls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kqr5WE7h/6Gsti32T4LSIq7ZDMWoCvfssQvrYkEYzKcERdvcAVNJQWzyh1rMxfUu6U3bx19Zw+PIq6oE/3GqbGlNUpMD8yNXjULcYlqTrNFrc37zobfWZRLuF7JmuG4tBG8rcMlcuITcI86Un5F8MiDw40TiXH5xxCBcDA2HssU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CoYUZGAw; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6ifPLlvqyemj8DN7Ot0VuURFg1asDTkrb7ig6ups9T+KltMALuaeN1bYBNnvIFh4eqO1reYD+KeUArt+TQJPXskFkebtWzAnfg+VWPwmWQVbon1yYMl/SzVWhMhtJJMJyfWtb2xxDvTOpgYyu5+bqb2szB2CoAKPwDaeqiTaT0Tet4bNM1Bjwibw8WhOuFKQcXkUO2XEYNnA7eIvkt/NIAM8nfLvb77bB1EWjWc/wK9Ma7935P5InW5CUg0KJQIT5iE0rk+xRBtUq6sbCioqUZMvTu2NFs/96/YzvEBeFgY+T37vJvCxLv7HGZs3qHzz7UaIN2sw901bI0AdAc9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGfV4qXT/2x8uD5n8JJznGYPjPlD4Hr9POuYErPcLqc=;
 b=JS+jrl0hhEoD/4RtbFdDTyOm9PcsW/Sle2Cj8Sng0g5M0T08gYm0AMbksFPLR24TXPP9W2sOqg3nm5Qs3Kr7nkC9/78y6pmvbVG1dvtpqGReExcKndituF+cxOXn7T/t6q9bp29QulAWBpR0BbZf/Lwek3Qx/zTLA691W3xkYmlIY5HW/FgCSw8Z6CxU5WM7z0IexSc8KlfRaJTam6Q1xCazifzRcmGP7JS+7+BN+sqFhx04mZP/02pk8FtHMTfRJIcaJgzelYgnVgGYalr25pDcSlgVPmj9c6KlwHV3679M2du+i+qZH/YKNNwJoC0X2IcVBZ6NU/zbcEhQMYVcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGfV4qXT/2x8uD5n8JJznGYPjPlD4Hr9POuYErPcLqc=;
 b=CoYUZGAw4iHHeTU1Vvc01WHXTxWUaVXy/SkSt09Ckot0BTXjbrVVhvk1OwCNnFTD4r/KhNlBc47fGVHYxqI+GT6RQsIt1QWOPtikLOs7o5B1W1T78MpXPPoAldsJOf6Jza8g2C3FJhm4uDb8YwRd+VIwPA+lttPmZJfnOIrPNyg=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:19:00 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 10:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 10:18:59 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 05:18:55 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 0/2] amd-pstate: Make amd-pstate the default driver on server platforms
Date: Mon, 21 Oct 2024 15:48:34 +0530
Message-ID: <20241021101836.9047-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 9174a4b5-88a0-44f1-8b34-08dcf1b9c762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5832j9Hz81A0I3qek8PoTyZn/gMB+UVIH8aDVrh2axZIQ8Y6vHvkruncvcKa?=
 =?us-ascii?Q?eMeQarYS+xMJ08t5Re2bYJHZTvS8aPWjBhcap0B4kebx2YNvDMo3tuTSnzgI?=
 =?us-ascii?Q?NTC4g4c2Z75/DEY0Nz2WjCbSTGCX5B5Zablx9KRPFxk+14EHsfssnJ3nBnvb?=
 =?us-ascii?Q?u9jWPXWNet6At+i/IoAucpyNNKcGUD8MsxjsEyASn+8C9arb6/3VTNCKgV/P?=
 =?us-ascii?Q?bfVzSIoBEKuphI/tLgr3s9wY8O0meQXQeLcgWHn/3NzhMEyE+Y/jp50waKP/?=
 =?us-ascii?Q?aixur+rkSPnuvUmxXQouxrxxLTkXmSmzazZot+J19vEDOa+wXEK4ZTFefd6E?=
 =?us-ascii?Q?O+Swk9WAx1nZUmTjU8tQNmvvkhHB4JKa9bHzvkF180xZ8lHOFtI7+umJCQIX?=
 =?us-ascii?Q?LoGt1FZVGDjxYhEyMkYjcHSjkB7Gvn3JZm9MlNFmxmnVYC4rhKBd6zLkyGWc?=
 =?us-ascii?Q?UGm3pNVt1a4NeVjWL+hShwgKcHuG+xp19dN7VKnr8f+toXPF45i9/wAfCTn4?=
 =?us-ascii?Q?uofYN/7dG8vl38PiihMPrDQFGA/lceeed0dgv1YdjF9Txs3/p9eR3eFD2yOI?=
 =?us-ascii?Q?Z+Sr56KWQebWw1GiH2x9CcOCLV1wYbNzEPhASCHOGHDBAXxhABrEP0c0ImS0?=
 =?us-ascii?Q?e99WA732hlnl8tf2nnBkvc/0pSRKM5JNMiCaWAYDxZc5Q+JKu88TR6gclBVd?=
 =?us-ascii?Q?Kw11X2pXZgOLHTlBtt/EAgpU+9Np7RrqciCQH/DDnU/csFCzCK26pPxHzbxv?=
 =?us-ascii?Q?lcFAldCCPsrSpaQfZwwJ0fgBMk8Ks36wVxzs3W7WVEwTx2g/BVe4URh+Ajrl?=
 =?us-ascii?Q?fA+LQf1rKsKH7E45xqeHkMUAYqvFkP3vb5vSh06GQUfMdmkP5HoQ2l0lM65b?=
 =?us-ascii?Q?M7XbhlDr1HD+xeglS6uictwPhNUr2TkbIkIYmgm+l70HJu3SW4W3DkjrEoIf?=
 =?us-ascii?Q?HgK3j0K2MepryKEnaN9V54/JpNUwzaJFnlCkYcdQJZWzZlNk7dUjbstcolcM?=
 =?us-ascii?Q?USNzWrApWo/nfzRN5yyBQLgc7Ncplq6tom4zhgWv1a/udB4z9XmJRGEgBCWL?=
 =?us-ascii?Q?sq1QOoTGG2otD3JUYF6XR9LgU4fMfWrALmYzpIRHuGN84JAfSrq568/oSkDb?=
 =?us-ascii?Q?SbW+qcdrdeFAevmRY1C/j+i0HN4NILHEukjpxS4obScJ/8TbARv+5/LYZCVO?=
 =?us-ascii?Q?OeGcxA6ra9GfkVMSOj7nyfxi7vBRw18lFuDIwNIkH7kAjsfmfQTUr7dBWxYQ?=
 =?us-ascii?Q?Mji5jCMhuaizjnGW+Yx+CjpaXV0cWPgJJv+RyhkWBvkCGkT+YvXvlKzKDbVS?=
 =?us-ascii?Q?u8e6feib6VIOa2lhBSKc/3ZjAQwhUkPrdaUSk7b94j8+AWYcQmseEDzyGKFR?=
 =?us-ascii?Q?xTwZP1/YsHiqUit2JJKK+ZpAdkoH8uIyTXKG9Tuzhd9qTs9K2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:18:59.4260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9174a4b5-88a0-44f1-8b34-08dcf1b9c762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

Hello,

This patchset contains two patches to

* Prevent frequency throttling on power-limited systems with
  amd-pstate active mode with performance governor.

* Make amd_pstate default on EPYC Family 1A+. Based on tests, the
  amd-pstate driver performs well enough on EPYC.

These patches are based on the "linux-next" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git

Gautham R. Shenoy (1):
  amd-pstate: Set min_perf to nominal_perf for active mode performance
    gov

Swapnil Sapkal (1):
  amd-pstate: Switch to amd-pstate by default on some Server platforms

 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


