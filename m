Return-Path: <linux-pm+bounces-15090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A490798EBCC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE31C213AC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2113CA95;
	Thu,  3 Oct 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zbBEQ2RW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D928370;
	Thu,  3 Oct 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944954; cv=fail; b=NfV22ItbaAbbC/ScZPN0bAis6vJgeE8KxfBBn0OIjo0f3rABkO4X/9WYaf6AiVU3HyRtdxDXmpr9GcLFs/rgoY4pbKGdasUh7HYJII2qRInk3TW8wiIUZj5qR7TWsXM2fUya/jkOAtXgRNQgsnEsbbBCsmATnQeQ9pAQpn+3w7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944954; c=relaxed/simple;
	bh=aj9ocxJYHhtVh/gx9OpnQMgsrz3u7ZaIlL4Qki4wD8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNiRpqknTDDzXxo3vRtEaNG7//hNFHCkYVGUxqGzzCy9AVmV1sDDOF+cOtHClxq0SNCGB7eZR6fiNlfYbdUwjQTYKwGzc/w51GiajGZHt3nByD0eu1lc7OUB0aPuUFJiZKgv4bANbo8Ij3IxZPKZiTbMzWp6l5fl3b8x+k/Jaaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zbBEQ2RW; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8gvy9B2LXUm/nsKX2YvsN2K2qLDSs+jIBGsrQpa5sU/lSTGtcfRcH+Y6krfRqeG1XTAYjaq0pgsKVu/fcbHKmIAy/5iGhPXo4LyRUs3w/kL2+Zncr2OREIiunFWdZ76HQXJor1Gu3ygOHm6S1lHK/uueg6S7ktQYvddZimg2DD+GVfTwh8pj4GwPNr1ZdNmofqyzpnXu17nsFVKK6pjiczmUNwUtVdq7osfKW8Gp+YaPSdN7vGSvuwi4zDcRl26W00r20c2Cf+9CeBKUKDe7cIRKyca3dXM58kuvJjcx5iBAPvQBDeybATQ500gRPUMmHS+gbt7j60xA9Azv3W+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBU3iBpdddFILPC/z/ouLnuV9OkpGuyvjZD9+uOeEY0=;
 b=QEpuLBrG/KOmWMJteNgWqfXn8Pa5uFzTkKZlINA+jaWvFQTem0tb5dutMIyAiNVunUJRProS3QR1lj+NLMzB9Sv9Pxz0VPeOqND+dFquse2avJUrY7RFctchqHg5phGhSGzJUjwRlCmsV+Ugy/xGac/r3itIO4LivVnYq5JO0T9u1+RCoGMMv98ywvBdJuRVfu59OtSZuTxHoa9vWEzymVxeZMY1bjotAbMGOpwR8NpBu8OiiD/oveK5GXjLu3iEIeF7alTndVmX2CqUCLbeApVrAK2xuKIQqSb0KNCFRi6PBlfCrmuVFCoBkJZXeFDiA5JWyx9V3hx4XIcfdJmRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBU3iBpdddFILPC/z/ouLnuV9OkpGuyvjZD9+uOeEY0=;
 b=zbBEQ2RW6pFraN71o0qX8nI8EHx/6KECCyfUJHL3MX5I/3vw0M00eTCSVEpkS+2fpRw5Zy8b2wSwnN5yeb+n2sqzdZjeU1Ei5RyeOWSKwYY7eKMbi4Yub3lM9PseBPXxxyOiwVZzC0X4exd4SYStOOLexu7y+ZouUl+y4zzofpk=
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 08:42:29 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:238:cafe::a) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 08:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Thu, 3 Oct 2024 08:42:28 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 03:42:25 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/3] cpufreq/amd-pstate: Set initial min_freq to  lowest_nonlinear_freq
Date: Thu, 3 Oct 2024 08:39:50 +0000
Message-ID: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9d9b2d-bc23-44cb-8a72-08dce387506b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Md3kCcflJHA0x4FQd+Mg1As400Eez4iyrBoY1yaFFvTTs0wcgbu9yJNTse5w?=
 =?us-ascii?Q?7oZnIW+YN8rD2l+BI4vAwGyJSCeJzl04QKzwgYMHkl3qQ/9FRqxiq3B7FBjf?=
 =?us-ascii?Q?dsagn/A4DbKDyZ1ZAzMVTZOeNBSJS5hTwoJNwSS6bsbTwKEMqMCyyIdJfpMi?=
 =?us-ascii?Q?TuRCfmkgwb4BBq+Op/BjIm1nQ5tdw3uimkfxlr1XNa0InpGYOzwpwX++z8G3?=
 =?us-ascii?Q?jJrC537FS1r2LXfw81Kl+XtjnpMIEXWZRlGy3bAUBTlW5l5yg+sIzdxvS2wF?=
 =?us-ascii?Q?qA1gfOvwrTAoeVcxk7htXryIg2j/PUnKhr6VIGL9szP9MGiQ1g/YibnuCDiT?=
 =?us-ascii?Q?5sLOpqR9qdDzTm3N57Gs7HZiuPiHCI99dAV0Oa+0a5aRtsRsjS5/+4yXX23X?=
 =?us-ascii?Q?HtmpGjAtIHzTf/clw7+TN8hBmzZ/KH5zRa0S7ybrRxYf7ow2V6rdVsbzBAzV?=
 =?us-ascii?Q?prn7hON12qhNzUg+HIVD1xplOKKwuRnJ685f7x1GN8jE74ZJcmw1TdrkVOAk?=
 =?us-ascii?Q?683qRYbrA+tStKuyePzQDSExk4kuur6zPQN0awDgBp6diDpu3CyYQNha11Kn?=
 =?us-ascii?Q?BCDFCnGaAy02gcIxDpl45ZfhSIaX5BvmT4Sdy26AzABHmiYxYuhIMwnmPG0W?=
 =?us-ascii?Q?qns/dMCjKPXdsLaT1ryT+401HEbuA5nRxQNJ2x/sHFFrEj+a+rK7Nj6E8K96?=
 =?us-ascii?Q?I66gLIExmc9hIYJOqrm990zcxeJUK21R32LQ/llCj2ArQUB0xUOeRpxdO9Ze?=
 =?us-ascii?Q?ojZIMKFIdhQ56IcUaCdFUz2SjaN7ZGCdAbpSGfBIBLD1P0ZJ2yA5f2+FJBMD?=
 =?us-ascii?Q?unC9hJI/dnPMPd5fhHpl4zDLqFqm1QR2aZK2XtfjLGcfBasmKWMNDTlPI6aj?=
 =?us-ascii?Q?IigZ+TH3QQW+3Bnu1yTzpvPsUxOMjFhr21o8v8DYAPezg+XgL65djH5o6Cza?=
 =?us-ascii?Q?Gnlqf+sFJrjm+zs22Jf3kV12cqbkxF/nxDyOvXtmyaTZRBLKSJjgbOF5eguL?=
 =?us-ascii?Q?x3pdGdJ4bbSHol3DGRcsytDPCipJxXPg3BnVe+QSNmMU3PDtqM9/rIQZz1ux?=
 =?us-ascii?Q?xERUkP4sK5J5um5GRFnxt+dyxwVwa5zZgVkkWtdwwIZVZy0e0IAT60BzAtBZ?=
 =?us-ascii?Q?y8ym8DeV2z/WFMh8GLGZGKGu0sqGGV4mSYnFEG3DVdHabjzlWxp+JPoT8oIX?=
 =?us-ascii?Q?jHf/wAvKM6xjut5E3Iag3iUyvy+yb4vR3e2Od4A6JN+a2hI4294qbF6htwuZ?=
 =?us-ascii?Q?SSJWnXzcaqfsclO6suBEq6JvSDJWbikQs3zOIe3CHGsRkgx0Grfmct/RKqWx?=
 =?us-ascii?Q?CN8/EGADz1NqA4+2x/TZyZEym7RFccvptmpllxLfMc2WGz0vHZyB75JePh9/?=
 =?us-ascii?Q?4IH1xJI5J9iuj+2CVGn/qVPFZF+S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:42:28.8301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9d9b2d-bc23-44cb-8a72-08dce387506b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

According to the AMD architectural programmer's manual volume 2 [1], 
in section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described 
as "Reports the most energy efficient performance level (in terms of 
performance per watt). Above this threshold, lower performance levels 
generally result in increased energy efficiency. Reducing performance 
below this threshold does not result in total energy savings for a given 
computation, although it reduces instantaneous power consumption". So 
lowest_nonlinear_perf is the most power efficient performance level, and 
going below that would lead to a worse performance/watt.

Also setting the minimum frequency to lowest_nonlinear_freq (instead of
lowest_freq) allows the CPU to idle at a higher frequency which leads
to more time being spent in a deeper idle state (as trivial idle tasks
are completed sooner). This has shown a power benefit in some systems.
In other systems, power consumption has increased but so has the
throughput/watt.

Our objective here is to update the initial lower frequency limit to 
lowest_nonlinear_freq, while allowing the user to later update the lower 
limit to anywhere between lowest_freq to highest_freq for the platform.

Currently, amd-pstate driver sets the cpudata->req[0] qos_request (lets 
call it amd_pstate_req) to the lowest_freq value at init time, and 
cpufreq.c sets the min_freq_req to 0 (which also gets resolved to the 
lowest_freq eventually). Writing to scaling_min_freq, only updates 
min_freq_req qos_request, while the amd_pstate_req always stays same as the
 initial value. This leads to the amd_pstate_req becoming the hard lower 
limit (due to the nature of priority lists used to manage the min_freq 
requests). Hence, if we update the amd_pstate_req to lowest_nonlinear_freq 
from amd-pstate driver code, user will never be able to set 
scaling_min_freq to a value lower than that.

This problem is occurring due to the existence of two different sources
of lower frequency limits, i.e. cpufreq.c and amd-pstate.c. Removing the 
cpudata->req[0], and updating the min_freq_req itself from amd-pstate
driver at init time fixes this issue and gives flexibility to the driver 
code as well as allows the user to independently update the lower limit
later on.

So, add a callback in cpufreq_driver to update the min_freq_req from 
cpufreq drivers and use it to set the initial min_freq to 
lowest_nonlinear_freq for amd-pstate driver (active, passive and guided 
modes) and cleanup the old min_freq qos request code.

Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]

Dhananjay Ugwekar (3):
  cpufreq: Add a callback to update the min_freq_req from drivers
  cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
  cpufreq/amd-pstate: Cleanup the old min_freq qos request remnants

 drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++------------------
 drivers/cpufreq/amd-pstate.h |  4 ++--
 drivers/cpufreq/cpufreq.c    |  6 +++++-
 include/linux/cpufreq.h      |  6 ++++++
 4 files changed, 30 insertions(+), 21 deletions(-)

-- 
2.34.1


