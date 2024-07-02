Return-Path: <linux-pm+bounces-10315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B291F0D8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2052DB21BD3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258B14B950;
	Tue,  2 Jul 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4SYJzY5g"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA14884C;
	Tue,  2 Jul 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908108; cv=fail; b=r6KTD0L/24c3tNKRWlFcyrKn1jVpZbt0Hndfa2MYF8NvWnPFB3cik4Y5AsNyq/0h7BjuQDmBYNlvqNiJgsNUuZ0h6MlsBi/FtfRTZbnYPN4aH7QsFS9GApCRKNhUNsiqffVCi+Mw+lXHy7NOoPg1SB/OcCStOrj+Q5oHDZrn9rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908108; c=relaxed/simple;
	bh=eCT6CRhvQ1j5CezI1gDhNK8g6poD9BMr9gM8RQ/xb2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bytckp5vhk7oiYms13BbLHfS0qPJIhgghX2PSvfo+vxqoPJ1SaW6RAe6VMD7DJ++1BD7PiODlVP+RlTtOk6edObq88UhbRbqBN2wOdNBaiCv6T8m9NqQFeCWAB0mqR3TdBSzF0sp+WJWtL18vv1Sm2wrVDy9+xwqc3GgAhvOdLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4SYJzY5g; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+bZGz+Wnysxy9FqaY4vXyT0T9uUnOvbimpdjIDKIM6xgQdVkPAQPSYkTiAEe0RotKrhSmxKWgliE4V7te0xTB/1mXUpbaU3fpUeXzrAZhYRPjrlS81KWKSr1/F/adFjxwymGcY1C/l+bE0aVhuF4ZR8pf2O40XNA2m4XS+HiwN5UrYnKzznPDa1c546B0slPeTbYrvvZjtP472ucMiAhdxe3LZHRBt5yJwQaQkoZdzpo+C861VLxRejGvOeelovYOEeYC25TVuSA5VThCLc3n8Cevcsdb0UAhasQrsVZLPsVx5r1oO3v5PzFbAdBRAWNdYR7eJRWTvMWp8shPWpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGJ3Tglu+o1p5rxNSYoCdQ25nms8o9xdbZ87+di+JBY=;
 b=g1s3fWjKOjecExopuMXGQ4SlNOfZQ0DTZ7/d71qIZwBH62X9A3bG7ns8oJifTGD9X9Ohf6FPMhDWKHPuJ6dGrNbzjQGITz9OuBV3hjJrQx2zK2aALCGu507dQgiL3ypEjAwwUb9dc2fX5WMyELelcKjAfET+6COFr8mWja6coPEie1R9cQxp37swV0o3x5iOsXbynilrnnB2KgEL7ky/UAWSMm3ctLYC3oQFkzC0bs5ztysn7IzNK+uN98ZO7HGnlRm/paiQQAgi697/qcs0JG00YUNlVa+XzQuq+h/5CVdGBeeMTPaaMlTnAhNIzsGEsgdxpYqttBqMtpFfeSX84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGJ3Tglu+o1p5rxNSYoCdQ25nms8o9xdbZ87+di+JBY=;
 b=4SYJzY5gvcr5hl4FA+TCaJn9am3SAAhCRfSizZXvTOo+sPfMfv/46IsvGPceNM6wU7Rb4y9LKh8wgQxXWlWWEJN0YMjgJHNDW0MAtpIcu75Dv16kKwijNjBHVb8/85oZosUrFb6hJFjdq5ZN8tjNrYa/WonTEBo9tv29+0oQeNM=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 08:15:03 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::e) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 08:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 08:15:03 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 03:14:57 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 0/2] AMD Pstate driver fixes 
Date: Tue, 2 Jul 2024 08:14:12 +0000
Message-ID: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: c56c1e0f-906f-4606-1bc3-08dc9a6f1338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+LBOLvhT3BVd1Z9mdN9/p+qiT5KKRfut4MaYGUGqvJ26RpVO2AC16JtmK4H?=
 =?us-ascii?Q?JxbOIXox7KeHFqlcXanNgD/q5FaW08hX3ksUzPU6F1Iotps2iYueB91D1piW?=
 =?us-ascii?Q?0ZBrIdZJ0RhhvSR5QjgnfoAbjVTexBSdr8rm1HoxExYXLqAQ0XCs4yLzKx2Q?=
 =?us-ascii?Q?BhUszRc89KsQuzrttdgXz7WrfPIy7iJv1CfJ0G+2bgavyBfa/Dlx5b30GQtf?=
 =?us-ascii?Q?HSIMf8ZejRcMqdlP8B1GD5oLQPErKHv4fvTT7qoQHhW1UYrkCBcQ5RY4xhuO?=
 =?us-ascii?Q?hj84GssMK4Ol2lxYdQ3Ex5fO4njAIDVQvRK/ICJi8WVPZS5GkpfB0rPjQ1ys?=
 =?us-ascii?Q?aR5x10MIh9LarBQOtCi915MRTNhi3o2JUQLG8LiBaCR9ykq7a968qarfSp1Y?=
 =?us-ascii?Q?+TilQMzMN3LG+2AiGRmM+c2OoujSkF5oM0I7wYHnLOrF0BouMUe2mN9abigf?=
 =?us-ascii?Q?svp7UtTJ0KgT6R6M+x+d3wpQdSPwCEOh1/caGzAheLfw2ObGmByKmlnUnLMW?=
 =?us-ascii?Q?DPzKnmjSZvGQ6r/xDyCEffdn9kmJ6e1Wxj/MHt8QuRQMb7baezviLx6kLyIM?=
 =?us-ascii?Q?QJIAx/EmwG2XspvaBeldIACV85ki1BIv/K5plFKa6gR7+neql47rDPHqm3bJ?=
 =?us-ascii?Q?cMO77t89wJZAizGJGyXpHPVcGAhYjrhCNDGlYBVAgzLFJIEp71JhWFHZcbU0?=
 =?us-ascii?Q?3GFrjRqA7m6dr/hfJXmpjOW3kvW7YiM8y2Y5Wslk2Nn5k1IkOmWsSDDVVeNd?=
 =?us-ascii?Q?kjiekkGuKa68n1ZOHO1umXLxDopGckXYoLehsauNHOwAs10w9bG1zpmIUkO6?=
 =?us-ascii?Q?shHDeDoX6DI/w0ou9NurMOQd9NFqGAKClxmuyzdlgJd2YJixRxotvbf2srdB?=
 =?us-ascii?Q?lfKtZ4EbyImG7q8JcX+VmvQj4Fz51GdwI6pvJuuqdq20n8V43vCEswylztu2?=
 =?us-ascii?Q?QZ2tnImJ5VnY7CFwcG45XTj6w7b9PPCzf89U+oys6iIEdn5wxyk42ZDMWhtz?=
 =?us-ascii?Q?UxQoUrQbmnSd0HzRelqDIOssz9BKsdsEkEOtEj5LSnYJcnIBgmNIOdL2MgOu?=
 =?us-ascii?Q?B7uT62Bp4tjqRCmIikEYExlxd7o1Wk2k7wqZr2tN/YCHT8NMhbHTZMz2+SVN?=
 =?us-ascii?Q?7M1N+4JNaVTlpRbd93YJjC77QVRleOPqh7U9JaCwkC5YbT6PDOOUTPg0X/My?=
 =?us-ascii?Q?bNIcOdKq29QjIbbaZh07HnbbUoj5iiuZb4y7a1uH2O+CiJXLGx8CyPDIBHHK?=
 =?us-ascii?Q?ln+K+x+d3RWCriFHzb6VA/ZQqoxVMzJT4NVZP6S2BvTHYS5gjgI4Tk+ArTpf?=
 =?us-ascii?Q?mGjQPMN6qpydh9BYGRPptaoomuXl2BdQwGpnewFynmYoUzY9IrDF/C3GB6X+?=
 =?us-ascii?Q?ZASzE2bcmNxnuzhJw8uj3wv59PueLKZpfRwhoUUuuOPLhNkRwbZ6cTR5gfvc?=
 =?us-ascii?Q?jHZHsYfe9Sqw6Y+pF9LxXYMp/N7tKrhz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:15:03.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56c1e0f-906f-4606-1bc3-08dc9a6f1338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

1. Handle the nominal freq units inconsistency in amd-pstate-ut, which was
leading to the below error on inserting the amd-pstate-ut module.

[ 4982.498864] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
[ 4982.498873] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
[ 4982.509151] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
[ 4982.509155] amd_pstate_ut: amd_pstate_ut_check_freq cpu0 max=3709000  >= nominal=2401 > lowest_nonlinear=1903000 > min=400000 > 0, the formula is incorrect!
[ 4982.509157] amd_pstate_ut: 4    amd_pstate_ut_check_freq      fail!

2. Setting the scaling_max_freq on shared memory CPPC systems was
broken in amd-pstate-epp driver(amd_pstate=active mode). The
scaling_max_freq value was not being propagated to the shared memory area, 
so the frequency capping was not being honored.

Tested on a AMD Zen3 Milan machine(shared memory CPPC): 

stress-ng is running on the system to keep the CPU utilization at 100%
to test the scaling_max_freq capping.

Before the patch:
We can see below, setting the scaling_max_freq is not taking effect.
 
linux/tools/power/x86/turbostat# ./turbostat --Summary
turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
[Snip]
cpu0: cpufreq driver: amd-pstate-epp
cpu0: cpufreq governor: performance
[Snip]
Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
2620    100.00  2620    2026    0.80    164935  0       0       0       0.00    0.00    0.00    176.07  249.18
2580    100.00  2580    1995    0.80    162208  0       0       0       0.00    0.00    0.00    173.27  245.37
2584    100.00  2584    1998    0.79    162379  0       0       0       0.00    0.00    0.00    173.42  245.68
2577    100.00  2577    1996    0.79    162146  0       0       0       0.00    0.00    0.00    173.15  245.41
2578    100.00  2578    1996    0.80    162025  0       0       0       0.00    0.00    0.00    173.07  245.46
2575    100.00  2575    1996    0.80    162115  0       0       0       0.00    0.00    0.00    172.96  245.41
2576    100.00  2576    1996    0.79    161998  0       0       0       0.00    0.00    0.00    172.87  245.32
linux/tools/power/x86/turbostat# echo 2000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
2000000
linux/tools/power/x86/turbostat# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq | uniq
2000000
linux/tools/power/x86/turbostat# ./turbostat --Summary
turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
[Snip]
cpu0: cpufreq driver: amd-pstate-epp
cpu0: cpufreq governor: performance
[Snip]
Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
2620    100.00  2620    2038    0.79    166103  0       0       2       0.00    0.00    0.00    175.44  250.96
2566    100.00  2566    1996    0.79    162038  0       0       0       0.00    0.00    0.00    171.79  245.23
2566    100.00  2566    1996    0.79    162289  0       0       0       0.00    0.00    0.00    171.76  245.59
2571    100.00  2571    1996    0.80    162034  0       0       0       0.00    0.00    0.00    171.69  245.44
2566    100.00  2566    1996    0.79    162179  0       0       0       0.00    0.00    0.00    171.62  245.41
2567    100.00  2567    1996    0.79    162028  0       0       0       0.00    0.00    0.00    171.57  245.46
2567    100.00  2567    1996    0.80    162037  0       0       0       0.00    0.00    0.00    171.53  245.41

After applying the patch:
On setting scaling_max_freq at 2GHz, the CPU frequency gets capped at 2GHz.

linux/tools/power/x86/turbostat# ./turbostat --Summary
turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
[Snip]
cpu0: cpufreq driver: amd-pstate-epp
cpu0: cpufreq governor: performance
[Snip]
Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
2551    100.00  2551    1956    0.80    165998  0       0       0       0.00    0.00    0.00    171.34  231.22
2713    100.00  2713    2078    0.79    175801  0       0       0       0.00    0.00    0.00    181.92  266.13
2594    100.00  2594    1991    0.79    162183  0       0       1       0.00    0.00    0.00    173.99  244.50
2606    100.00  2606    2003    0.79    162632  0       0       0       0.00    0.00    0.00    174.81  246.51
2599    100.00  2599    1996    0.79    162168  0       0       0       0.00    0.00    0.00    174.05  245.46
linux/tools/power/x86/turbostat# echo 2000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
2000000
linux/tools/power/x86/turbostat# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq | uniq
2000000
linux/tools/power/x86/turbostat# ./turbostat --Summary
turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>
[Snip]
cpu0: cpufreq driver: amd-pstate-epp
cpu0: cpufreq governor: performance
[Snip]
Avg_MHz Busy%   Bzy_MHz TSC_MHz IPC     IRQ     POLL    C1      C2      POLL%   C1%     C2%     CorWatt PkgWatt
2010    100.00  2010    2030    0.80    165565  0       0       0       0.00    0.00    0.00    101.22  173.52
1975    100.00  1975    1995    0.80    162042  0       0       0       0.00    0.00    0.00    99.03   169.88
1977    100.00  1977    1998    0.80    162559  0       0       0       0.00    0.00    0.00    99.16   170.20
1976    100.00  1976    1996    0.80    162243  0       0       0       0.00    0.00    0.00    99.09   170.08
1976    100.00  1976    1996    0.80    162490  0       0       0       0.00    0.00    0.00    99.17   170.16
1976    100.00  1976    1996    0.80    162056  0       0       0       0.00    0.00    0.00    99.11   170.17

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
  cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory
    CPPC systems

 drivers/cpufreq/amd-pstate-ut.c | 12 +++++----
 drivers/cpufreq/amd-pstate.c    | 43 ++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.34.1


