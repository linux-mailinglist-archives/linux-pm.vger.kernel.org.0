Return-Path: <linux-pm+bounces-16288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C809AC7A9
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F88284A8B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467C19EEA1;
	Wed, 23 Oct 2024 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w0bGRLMD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FB15F330;
	Wed, 23 Oct 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678888; cv=fail; b=P/+M8rVR74Y5LYBhqrzFthxgeDeWYdXE55g4oIQeW6VjZU5GbTEZp3IsWJ3rV+WufV6m/9gQWQOcbzksZnoS3eE6gOgrU6Fn9nprLFoYalJm8WxYzw163/UyT6ht9BCAg4vcy1PVr3IPL9jgZkKStmSZeR6TraEEmc6E41UiqV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678888; c=relaxed/simple;
	bh=CP5wTFto/456SDSE71NdLU/2JqvLJr08gkTgSh3oTKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YGiPlhJIbaFXcTmtjpqxvbKxUyeci/kvmAxMIeRWGBz8NpEGBE5mXaF7HHmE6XrBKJ1ypP7glGxIJQ2HrtYP2Dyn8hn6K/X6IA9Yr4S+Zl3uScL92a8HXqJwExI0TEA9VwZQxHsisp34wLIw+qWsAWxWEiGIZP7fmp0uxfdbBRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w0bGRLMD; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLYCLTFpIC30ggUlKIHsDw4X//RErtS9s78XpjgTYplES0Y3r/yZkK4m3B0SLrUKFCqSQj1odJ4TkT7qPFNpXjkWNLcndI+Ak1eiZ7EGWLRlGeTJ4Re5UONCnDpritnTlt2m4Mopp+Xu676id8Xi1HFx1Q7p2YoKWgWO/B0R8U5rguczA59nlA+SiVtvsW5WpEhtlBifOvSkGqY4juWo09x/PsTJYhuZ/g7vRj3SUBTPN1yzQ3w2sm3FXT7Q7LmRFKctbyYSGKMviP8NQdLlF9bizJ6z95K31+XKsHhiYgWgOBxRQ8+AaH9LUFjrU/rim+vx8NzAd8Abzr98v4ljog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYASuStTPqkZgkiL1it4xF0mXL0Pj0Gn+89I3ldsc60=;
 b=xJA5vIgVyBlYcW7K4jPlxIfKJ0r8TDwEu2brc5Ft2ZnPUbuL1/xIGnipxc0MwRf+m3QO3QwGHg8QTGSy4uQqe9UnN1TC0SMDHzZkAsVYldMNeCK+pAffP52iN5U7rIsLKyb7TX+8I0OvVKHONFlQvNXFVDmUaaV134tZEORE9y/TNPK28BoUb0BV7BLkOVEyy6tKowCoSc+Wf+1jrX1iJ2RmtFVlrjLIsMgCiOUc92gwKn0BeWFch+pkjcMHsEDJ/oFBQrqnq1ad5ZlZC2ggoTjpN5jlauEPvDErXiKVvz/Us39H/jhiolYNDSrb9X79MEOtkq1nefJ+oO2b+weJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYASuStTPqkZgkiL1it4xF0mXL0Pj0Gn+89I3ldsc60=;
 b=w0bGRLMDoctX8eo7eYGGxhIu21Iubn3V9ZesYeoZMkWYoIc5UkGHh1MYGZ/IYHNrJxP3Bx5JRJawwjDMgjIKRpuq/f1M84NSzk2PEIWrsrgfo627Lp8CuwT3ooSXCeOtbhIv/wGLkBF3svdGbFMaW2RnngMuHSFpiqpNadnENMU=
Received: from SA9PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:6e::33)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:21:24 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::f0) by SA9PR11CA0028.outlook.office365.com
 (2603:10b6:806:6e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:21:23 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:21:19 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/4] cpufreq/amd-pstate:Cleanups
Date: Wed, 23 Oct 2024 10:21:04 +0000
Message-ID: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: b8600f3c-4089-4933-107a-08dcf34c7247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FiOZS44/2pYu1xeJMICpo7JAgu4uUv19po97550AQjajN5O4fz/zmbORBb+C?=
 =?us-ascii?Q?hr5fXlp5zv/bZKp6N+S7UUYwPLmhmApIXque7xX1UAQLbM94RWcOi+w0WcR2?=
 =?us-ascii?Q?iBqyn2d/sGQXe+i/8L9KeQW82Ek8MswuYyR6y7Uv9+uw0ixo4p24Mi9+YEhg?=
 =?us-ascii?Q?PiT1Ix55Mk0lFskS9WKmf62Hco47hXJkOn2BISsr36OzW2g0jyEs6AKg3U16?=
 =?us-ascii?Q?VIEZnttsTZ0lyL1gumsB7vqzmV9vJ5k6vrK5w/gvNGC8CBhD3hyAZgDqMgk3?=
 =?us-ascii?Q?ooLHuj7vzWLdqNRDKwi+iixSHZpx8W7cXhmlcUTZXAAFQ2P438JU5rgsdjFH?=
 =?us-ascii?Q?yC5yUAjADG3OkY7hCs0hTsTz51ZtpSJjG/+Gfm28CbS4KGu48reK+mav1bnW?=
 =?us-ascii?Q?zLCoemH7azqMIbuaFHoZGvN96KazFs81Kji8/WXXBdoW3fFMza3FmwYPTE6w?=
 =?us-ascii?Q?B/KVIovL5x0PvdUt2UyVo0F95wZC6Pk92oMSgLgduUfdgeecqF8J5/3h/HnT?=
 =?us-ascii?Q?vtfBCHz4XcMVOeDHwOtfrwPkB7fWYmOjCL1vqAKlAKNg0jo18LmceaW2CJE3?=
 =?us-ascii?Q?3vWjATnra7Pmk/lmgxi4GILGXb16t+tNnHcznzMwtmybaGRPUWOrpf+ZCcE1?=
 =?us-ascii?Q?MyLZcGGL5twVdIkMY2Z5uAA2MSaHnbmZnyjN8k+3b1Wbh146CpGIRWZsbM+C?=
 =?us-ascii?Q?I+yr7MRcU2R9OkX8XDHxV+t359DTH+YRfhxHU7pv4SSp+SgyizCDzMT3oi6Z?=
 =?us-ascii?Q?BpyetrCZo/9iuj9IIwa6XAA3pb0FQw8pwyMy/l+PVo5+T8vhHcP74YRxzx+o?=
 =?us-ascii?Q?W9Fdbx//cENWdnl/vrHLWbeFu0EzVLbm984V7mTslYu3bKwVj1jR2W6l93Oq?=
 =?us-ascii?Q?S5XzIATq7b5Eb2VuB66blPco/ESxa0QPKQ0fQgeFSHY6LbLDhczW4ZdKv3wB?=
 =?us-ascii?Q?A9rkjwpTwmdKqlHkoe3Vrx2lv/4hILbB5R60T3Ai3shCsXJU8qg4hS5aH8Q1?=
 =?us-ascii?Q?A0aIy7kZVaJCyrnjdCsO1TEwhKHBba2A01CBKHclRlrgxpLUCixIzNC3KvQG?=
 =?us-ascii?Q?BW2Em6p7PVujSVB9fZekpfbvPePhKTvV31WonEncj5yZY/FSk/xPsNLvFP7i?=
 =?us-ascii?Q?3d4hdtGAjihdByIFsHoClMjttHV37h1ciHTo4KHxIAVPj5Z35rF9BbZZIqNH?=
 =?us-ascii?Q?ND6C5OiFx6+xS60npyuNh8XNGdP6vfGVpuQIdc1Bzjpnpsj5qvV6C6w/OUGU?=
 =?us-ascii?Q?T4Zd9hCLgzYvDK73BnKLFK9ig2ktfPQwDmkhVKt0tovsIZlRIXfycrZmIBaX?=
 =?us-ascii?Q?npnTNoOL3Xj9HuqK7ynZUBn9mM7EW9C/tDA/FBgY11XLLMurOMaeFOJahcbc?=
 =?us-ascii?Q?j3/7uQRmt+LxBNxUvcCESM1ILMUQVGtxg6w9N2zuMmwkEMF1+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:21:23.9154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8600f3c-4089-4933-107a-08dcf34c7247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

Explicitly rename functions that enable CPPC as *_cppc_*. 

Do not clear MSR_AMD_CPPC_ENABLE as it is a set-once register, i.e. it 
cannot be cleared. 

Propagate the epp value to shared mem in the reenable function.

Replicate the offline flow of MSR based systems in shared mem systems.

Dhananjay Ugwekar (4):
  cpufreq/amd-pstate: Rename functions that enable CPPC
  cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
  cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
  cpufreq/amd-pstate: Align offline flow of shared memory and MSR based
    systems

 drivers/cpufreq/amd-pstate.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

-- 
2.34.1


