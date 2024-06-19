Return-Path: <linux-pm+bounces-9550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205BD90E6A9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F523282EF8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42380026;
	Wed, 19 Jun 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qBbaLOjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF77F47F;
	Wed, 19 Jun 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788631; cv=fail; b=LFFXnAHdTbvFK+nGDDymB87ODoDn38wnieIEiQLUtqmCtAMi+X/oAeEwLGCgnChPI0gwJUsHA+W61LK8bXnSOCanMPnRrnZNkszGkwkmP9sZv1Izg5kZpuWbpgC/0TbZG+/FTwh4/2cG5ZJ+qmmaKBO+aOkQOz8E7KZN2By0FCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788631; c=relaxed/simple;
	bh=exishdh6QucRAfEMk/FHyCTpAxX8BzLTuVp6scuC5es=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JEg9Zkrd5gQodgBKh6cQea0/HN0Gce2DEtfXCn9zFvu2CwHJlOCHiuuxKX8Z5GnRP8hLfdgXBk9l9QGoqHTTSZbZrYw4M3556py5FP6TAq8ezrkTK9em4NE0vcx/xFezpHrfkPD3cooBCaOBingvmJF2fthbx5IwBi6FpY/JHHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qBbaLOjV; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk90m21Mb2YZEkz6+hkcvsR8NCVGWaNL1eUHHnv2GybLyOWwH2oW2aV3gc9nzbpoF1OMGllwjC88EnBKP4uUDqyP8ehsdkKgOHur3sQR1pK4mxUaasEHlmGpTJlsuWHUnmeTNj/DZk+bOWWUFm9dLYQ2TcmpcZArWR3cxbw3/ZmEUyASjtkipC+tPgXZiIt8J4m1J+WBFyu+Q3nB2JfUvSoi3ClVlsgleO8SU+7URuilVTFiW1q6FwNFfeb/42qmFa/MgJWZMUpatjKqY2IKABn5IAEGjm5C/WKibjJBpvMf5djUg/15rAWvVdy6y+P/qJhMuOraihzYie3gfTfKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7nuRVTFKKdZJNhhmQ30hbF2ocybAGwNOY5JCi63Gtw=;
 b=AwAsz3n7i+8qvzLtlYUjMUiqNihZJcI/R0vuDe7o03ys3GrYh49rO7kLRie98mKGtwPjO3H0AVTYKe0OvfPFnyIWuauun4hDJqWmC8JZKKw9TQKDOzKfyAGmMV+fPYlWt5urZlvs2qi+Ex6voqKH/4JMg5OK77uYylPJWdvfypy+UO1BpIRiGM2nqw1MGEMvkUFaLOu5GkjDwYqnMHBDgVy3FQvz9kWuOJtug7TRQYWO1FNfYKDkwYZj+gPA7/pzl05Rcay3VUwBr8919HQC18xlh3j6VKItPbWIcKyYXodjMpsPzlqnpyCigvQDlNWSbG3N6sjB3NQY8uQ0a0poRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7nuRVTFKKdZJNhhmQ30hbF2ocybAGwNOY5JCi63Gtw=;
 b=qBbaLOjVmnOzBQRHKS51hcEIpFWkSLO4WrRVNGFOVYS9bSicTXZ85Gyn3WhkEuHowri8WT7nvnn3X3hfEDWQ0wZMfJA3gugJasmMpjXYd4HNu1qv70SXyVWiOyVNoYhQogc9QwFt+goxKmKfTknUXbe9Xm1m+XHGj6UBV5pBB4c=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:17:06 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::70) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:06 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:16:58 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/9]  AMD Pstate Driver Core Performance Boost
Date: Wed, 19 Jun 2024 17:16:33 +0800
Message-ID: <cover.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: f373f372-6922-4376-635a-08dc9040971a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tmZnRtMmhMb3VLNE8xYmpjbkZHT29HTHNnZHFMS0lua1V2dlVLd1RlYmlp?=
 =?utf-8?B?TEt0KzBrbnZROVhWNTNYc2JQTUYvL1l3OVdrNlZ2cEtlY1UwdnlhR2tlZjRp?=
 =?utf-8?B?TkE4N0VUVmtyditQcmdtb2VORk93dUZFZ2pOY0R4bzZ1UExhQTB3c2J0N3Rj?=
 =?utf-8?B?ajZVUWVFZEFqakorSnA1aW1sVzdjci9ySkk0WktRSWJtMXVuak1MT0xsQ25K?=
 =?utf-8?B?YjRod1lGYVJUUXc4SVRMT0RlcUYxN1pJc21VU3ptcTBpQ3hVZ3BDbnMyVy9E?=
 =?utf-8?B?MVU4MFh2azZWSjZVMHk1QjA2OWJybUJiWTZIS1V6WkxRUVduWGZPd05TZE1x?=
 =?utf-8?B?S2RLOU0yZDZSUDRQZFlGMXJLR1VnQlJrSHhnTGc4MVB1aEJRZnArZUVsVnYz?=
 =?utf-8?B?bDlMZVl4anFTNlVabFRoNi8rRUtMK2VkbytRNWQ3ekNrd3lRNnplS2VycXRK?=
 =?utf-8?B?MGhQRGplcGVwNXRjd2tDZkJLS05EZisxcWlZdzFQK1VUdUZhU0FFdkxiSXRi?=
 =?utf-8?B?dXhLMFRWVUt1ZzZlQ1ptYVVobW9WOU4vNjNxVXhYT0g4dFNFNXdvUkZlMnJ0?=
 =?utf-8?B?NGRQTHRIalNKa1BCRC83NFFRZkdmc2g0czlrMnlBQmZFcnEvYXo1M1NGZFA0?=
 =?utf-8?B?VEkwbW5aOE1mYlRXYkJSTjYwNnY0dnkxTndBYTM2NFc5dVZxTXJuTEtZcGVL?=
 =?utf-8?B?SkQwbTVXZjc4UW5qZXZMVlRKNG1qb2twZHhGVmJsNjIycjM1TVByMmM3bHN6?=
 =?utf-8?B?T0RPbFRkeW1XWVgwUFpCay92akRXcHBTbm4vc3c3Y014MjZiUEdlbjlSVWxI?=
 =?utf-8?B?OGN0ODVhRk5qbThpOWxTZkVkekx3UVhHaEVMa3p6dHJkanZTcnEyKzhycm1M?=
 =?utf-8?B?Z2RVTWw4WWVsRFNWN0MzZWNBLy9La1NnelN3RGFPK3ZvZ2NVZ1NHNjlXWlhr?=
 =?utf-8?B?TmhZY3VRelNLdG1taEQ2U2ovTldZTUhIZ0tpMnB6cmQ5RmhySmdReFJpOEd5?=
 =?utf-8?B?M3Y3Q2hWWUcxSVpNdnI1aGFaL2dEZWh5TjRyWXl4cWVWR0wxU3orODc4VVM4?=
 =?utf-8?B?ZjNEeXlCUDFPYTc5VjlJK2ZrdGdKTGRZVVg5T3RTNVBSNEVYU0tvdytrbi9q?=
 =?utf-8?B?YTU2eUQ5NHZITHJZM20wMjl2YW0vQlh1d0RFcXJoUjlrTVFKbksxay9IZENM?=
 =?utf-8?B?bzJwbnN6Q091MFhtR2ZyUWJoTDA4MmhnMVEvZzhXZEVWYkNrYXJKT2pGTTBq?=
 =?utf-8?B?RldIck54NzRYK3laRFhvZ2I1b2hncVhJV0VmT1cyZG1yZ3FXdU01TVJqa3lE?=
 =?utf-8?B?bDVVUXBnK2hCRVkzLzB6QjVpd0tMS3JralJWQmJUcXloSkVvN2RRTXM3K0Fw?=
 =?utf-8?B?TFI3ZXFYeTVqa3RhcU1HWTdMWldvUGx1OXd1L1JQVWtWR21iVW54b2htMmxZ?=
 =?utf-8?B?RDFQbk1GcUJSM3RFRHo2K0lBTUNoZnQxSVluVHBMdnZZcXBhSVpSa2NJemZI?=
 =?utf-8?B?Q0NUTjRXK09QTElHSXFmclZVRnhlVU85TXF4Z1NVMUsvZWJDQzFKaEdwdjg2?=
 =?utf-8?B?dXovZy9FbjZvQlo4bGIzdUZhMzB4bE0vZmFPRDY0UmIwdkVlVmJ1WlM4TE5u?=
 =?utf-8?B?b2w1cjlYd0l1NjdWcHo0S2NHSWYwdDBDV2k2TUcxRm9iVEdMV3ZTNDQ3YnRE?=
 =?utf-8?B?eWwvcVhVd3VnNFBNR09jQUpyNmNVbDhuVUpFc2hSNmp3TFZQdVkrbUQ5KzQ3?=
 =?utf-8?B?QmxMa0lUQXZUMFYrWElvSy9hUzc0ekhyVnZDV0h0RHFxY0tlVisrdHZTbk55?=
 =?utf-8?Q?/XWHLnMzo1XZ9bQ/jLahkaOTsKWTun5N2Yblk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:06.6069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f373f372-6922-4376-635a-08dc9040971a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156

Hi all,

This patch series implements the Core Performance Boost (CPB) feature for
the AMD pstate driver, including support for passive, guided, and active modes.

Users can change the global core frequency boost control with a new sysfs entry:

/sys/devices/system/cpu/amd_pstate/cpb_boost

It also supports updating the individual CPU boost state in the sysfs boost file:

/sys/devices/system/cpu/cpuX/cpufreq/boost

By default, the global control will override the individual CPU boost state.

1) disable core boost globally:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
  1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
  2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
  3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
  4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578

2) enable core boost globally:
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

rebasd to keep syncing to Mario kernel tree: bleeding-edge
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 

Tested result:

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 3110.0000
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2732.3569
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 2312.2109
  9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2310.1011
 11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140

sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu11/cpufreq/boost"
sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu10/cpufreq/boost"
sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu9/cpufreq/boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1242.7240
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2754.5710
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2659.8159
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2308.9929
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
  9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
 11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140

sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1233.8630
  1    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2714.4851
  3    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2732.3569
  4    0      0    2 2:2:2:0          yes 2801.0000 400.0000 2564.2639
  5    0      0    2 2:2:2:0          yes 2801.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 2801.0000 400.0000 2732.3569
  7    0      0    3 3:3:3:0          yes 2801.0000 400.0000 1110.7140
  8    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1233.8660
  9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.6630
 11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.5050

sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1234.0200
  1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
  2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
  4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
  6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2278.8491
  7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2732.3569
  8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
  9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
 10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2353.0449
 11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140


Perry.

Changes from v11:
 * add “goto out_free_policy" for error handling and update error 
   mesasge for init_boost in cpufreq.c (Mario)
 * drop dead code policy check in amd_pstate_cpu_boost_update (Mario)
 * pick RB flags and Ack flags from Mario
 * rebased to Mario bleeding edge kerne branch

Changes from v10:
 * rework the boost interface with cpufreq core boost control, align the sysfs file 
  created from cpufreq.c and allow indivial CPU boost control (Mario)
 * fix the pr_warn code format with %zd (Oleksandr Natalenko)
 * replace sscanf with kstrtobool for cpufreq.c (new)
 * drop the boost sysfs file creation from amd pstate patch #6
 * add init_boost for cpufreq.c to unify the boost file creation(Mario)
 * add set_boost callback for EPP driver mode
 * fix syncronization issue for indivial boost control and global CPB control, now the
   two control way will keep syncronization after anyone CPU boost state changed.
 * rebased to Mario kernel tree: bleeding-edge
 * run testing on local system, no regression issue found so far.

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
v10: https://lore.kernel.org/lkml/cover.1715152592.git.perry.yuan@amd.com/
v11: https://lore.kernel.org/lkml/cover.1718262992.git.perry.yuan@amd.com/

Perry Yuan (9):
  cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
  cpufreq: simplify boolean parsing with kstrtobool in store function
  cpufreq: introduce init_boost callback to initialize boost state for
    pstate drivers
  cpufreq: amd-pstate: initialize new core precision boost state
  cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
  cpufreq: amd-pstate: Add set_boost callback for active mode
  cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
    while cpb boost off
  Documentation: cpufreq: amd-pstate: introduce the new cpu boost
    control method
  Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
    control method

 Documentation/admin-guide/pm/amd-pstate.rst |  30 +++
 arch/x86/include/asm/msr-index.h            |   2 +
 drivers/cpufreq/acpi-cpufreq.c              |   2 -
 drivers/cpufreq/amd-pstate-ut.c             |   2 +-
 drivers/cpufreq/amd-pstate.c                | 192 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  14 ++
 drivers/cpufreq/cpufreq.c                   |  24 ++-
 include/linux/cpufreq.h                     |   2 +
 8 files changed, 233 insertions(+), 35 deletions(-)

-- 
2.34.1


