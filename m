Return-Path: <linux-pm+bounces-18548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58D9E3E07
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B19EB3D33A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40520B1E6;
	Wed,  4 Dec 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3mJm4pIP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C1203718;
	Wed,  4 Dec 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323770; cv=fail; b=q45GI7rpXDE//4v8C0jzI5L1AxAkoyq3xIBVsKVYN73hlxXnC0RpwiNUFLyADsoneeCJ3CBw8bpMCAyPFLwll/uyp3itW2UBZPYngLxwF1yBJa2f+2e1TmYea7Wwt4j551sN54pXNwcyj/e8U9wB9WJHzCwXW59O/35YUbH3fRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323770; c=relaxed/simple;
	bh=WripAe40sJpK5OgxlT4di9Iakcbd0I2/SVyahkexZ74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBJgjDXgIduU7GYxXqdy1yZGOZhA08ettxSKw0UVbg2aKOcHvXaCimcpjT2+faXyqhy2Rg6RO24jjhu8fuSifJUDt7qGql2AUA0bEChiXTGZPI0D0BkJnbIBb8ETtfu8aQf3ENn+0z41ahhKQ/hbC58/fJm8FCKXvEvD4xMpaZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3mJm4pIP; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy41KtSyvKv6ouZWAhuT6c+fcmrC4L4g4wc/5176GLeU9CYXv5z/nd0A/+Mq0uUmDbifF9NXUVQ4KPwyExgAC8BOSkOjKQdf6EJdITf0fvkj48wq3Ht7lyzevx/X/v/q/LgQoZ2CkG9T1Vw7sYMT4C8AoKzS8S2jm469hRVF28Sk4dv5o9gQz2ZMOJnX1wMWkLwOgQ9/aAR/S0uE+iDkxg8sAbiIMxUGcYbr96lzN7wmVrhYafiuWtb+D9qVUZPjmZtfBSzkPI0u0vicjVyANV9F3oS7tlqE+JuH+9tS4GrLUI4UoMFTI3LZIfGLOdObNOS3LTmDLEWCyR1r1SCpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHSueZdTTB8NZCZDg01rqlO2UVRQYv5qHvNTQQ0SQIg=;
 b=s2dadrXDfciHPX5jfVVJ0LScJz2NC2dpqpC3SGgd8W1LiAoLjd4wzmIWjV8eMehinbzEaNzhD3WYoIyKEpt6yXjN3qNvCDjaFPOTP5UL71p0pYyshTbQtvWJnqmuHe/rEWnDW9j8wg1Olf5+nS9TYyJ97KVPV3bfvg+5PspRFA2sWbdPb/HjUic4XCQFj82LQB+3ePUG2vxGZbbAHZ3AnTsnTpT0boNxMj2i5CehSAVpR1ZbPiZvU/+/9qR3tLkuHA1lBJXjrvaGfERUSYvbiuczjqovSk/J6aBC7i6tbTiwtzwNa5m2iAQv1WkGyOPUsVYsRdR8BBzqoEeFm8OCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHSueZdTTB8NZCZDg01rqlO2UVRQYv5qHvNTQQ0SQIg=;
 b=3mJm4pIPdKBg06h8SpYXuOI/e2XTO9dmFjZfdNvF9Zb7XFII+mbPMJAo00T2DDesXGI7KtMjfPYgdIEhEiBONAT6Oq3+cAacx3C5du1vYmX2AV4TUp7SaTmMHakmipJeaYWy99+0/JZSb1E/FDNPvnnbBM18NysjPppi7weasDM=
Received: from PH7PR10CA0008.namprd10.prod.outlook.com (2603:10b6:510:23d::14)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 14:49:25 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::2b) by PH7PR10CA0008.outlook.office365.com
 (2603:10b6:510:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.22 via Frontend Transport; Wed,
 4 Dec 2024 14:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:49:24 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:49:20 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/5] cpufreq/amd-pstate: Reuse and refactor code
Date: Wed, 4 Dec 2024 14:48:37 +0000
Message-ID: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 04139a94-21ef-4de0-b5f0-08dd1472d8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M85GIl05qmRCJaEGdxV+rWeunT7yE9WmVgJCNtW2tT1d+XO2zwDQBl/4OmEr?=
 =?us-ascii?Q?1HBaKgivUJT3mZ6v9r/jYymiyD0ik8xkzIii4ianRujSwbogKsQUePvAYdjM?=
 =?us-ascii?Q?LLy94xQS16ALAR3s742pfhD8VUJ0ZPdcpvuSTE1/yagpNMnd8t4h81wygoR6?=
 =?us-ascii?Q?7imm7p24ydTc5h04FAtzhXzUt9mKW10aKYwqRLkRADXmCGSAO1N6tRU8jpfu?=
 =?us-ascii?Q?o7D07X17RJjrqxSC+xy9VM2KbPdg9NNyW4hJs1h0bHzoecMQeyKoXWEUkc6H?=
 =?us-ascii?Q?Myc3qPdVx7goQ7GU0Tbx5nq9gPkBIQ+jtfX+5aQJjMVs3u6eMxEL6xB1mbbV?=
 =?us-ascii?Q?GTpgvtj7xcUUMRjC0JemVxFHmLcj4O4//ngWKyZR28d3RNxyexC2AyDQLSnP?=
 =?us-ascii?Q?wM8nZIyHWdmCN3ITblengOeuJNvMwZoYi2rn0tZaegRiZB5dRreSe73Ux2JV?=
 =?us-ascii?Q?gBtz7/ba/8nmTK0pSJf5n+TM9acUkVhJGUiTGw/tNYRt6hvewWi1awM439PT?=
 =?us-ascii?Q?50U6R50RLyfBcdAUgk5Hn6P2YdgIHZqoKB0+KytDl0VE5qlwN4GMldPe+g3w?=
 =?us-ascii?Q?tkk3TYabfgbBi8uIy6wbgbMgEEedbbuSYXfE/bQdPILO+7ftU38MH5VZKzZ8?=
 =?us-ascii?Q?Tz7baQDov5Pp2k9OJMto+BwOsnIUkJgPQOcVULSepkRDpWcZ02ZNgnPmKv9v?=
 =?us-ascii?Q?HngfV/A+G2wChCyFmrk4mXBDJQrwOHt8GMeiJkUL+Fh8SMAKF9rIgMmVIV/4?=
 =?us-ascii?Q?1Yt/75YjtgzqbSkCxwPlz9X6qasiddSYq4WFgQoUoAQQ2UJYyw2YVNGxRR5E?=
 =?us-ascii?Q?QbKGhBQBrMcHu3z77jFG6LxA+kuxPlaZvHzUYJIQdg5HyCcFXyz01yc4DRSR?=
 =?us-ascii?Q?YTya18qcm+NY3ql0TfKw3ZcPSPj103U9ah4ms9C/NUTZJ4gIoU6lODboW9KR?=
 =?us-ascii?Q?gdlFJA1AUHrJJ/mvKjP7vXtBIRYzT6ZUIEoEb1ORqctFNjA+SxdjM73JdV4p?=
 =?us-ascii?Q?DilQTlXrPVuHgRKYiykhEX/jOXha1+4po0LyALqJGesRLzhaQssDBz20+aaN?=
 =?us-ascii?Q?y/wQI4ekkrKskKGM1WDW8JrqYmFf9FtNMZzWmHQd5uSmnPcbWnggsfh/MhBT?=
 =?us-ascii?Q?pRRH0EsshLd7ihpeCO00fIlA+aJFlh9dyaE3aa83R5i6Jzw0sMraod2ApN7y?=
 =?us-ascii?Q?HcwvoHaRsSUZ6splALnW2LygZ4TB3xems+lJXORNnw3yI0hoWjvdL2w6IJc8?=
 =?us-ascii?Q?8vDFhciM85a2cSpFvOTfveR4d6NUD9ii1XTp3TjpotmlUEjIDqc0QR47ZIRa?=
 =?us-ascii?Q?x2wV5z/wegXZBhhPcjUDdpDD2p5yhcpM0cG2kUIWwosqM0LKkwjTNjA+zsjz?=
 =?us-ascii?Q?pBFbfcdJ71+qJJ4Fh3nbVpqo2kryX3xxTRVjakTf1fV3JVwI9OksNhZass/3?=
 =?us-ascii?Q?Fm82heku6OWuVbGEztT/1Qm0PVpOZicz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:49:24.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04139a94-21ef-4de0-b5f0-08dd1472d8b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

Use static calls to avoid frequent MSR/shared memory system checks.

Reuse existing functions amd_pstate_update_perf() and
amd_pstate_set_epp() instead of duplicating code.

Remove an unnecessary check for active mode in online and offline
functions.

Eliminate a redundant function amd_pstate_epp_offline().

Dhananjay Ugwekar (5):
  cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static
    calls
  cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
  cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
    amd_pstate_epp_offline()
  cpufreq/amd-pstate: Remove the cppc_state check in offline/online
    functions
  cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
    amd_pstate_epp_offline()

 drivers/cpufreq/amd-pstate.c | 151 +++++++++++++++++------------------
 1 file changed, 73 insertions(+), 78 deletions(-)

-- 
2.34.1


