Return-Path: <linux-pm+bounces-9949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67C916933
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1271F291EA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0115ECE5;
	Tue, 25 Jun 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmKsAuSS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C851161B43;
	Tue, 25 Jun 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322943; cv=fail; b=kZ4TIFO/hCtUg0Jzk5XrGAV0BSnJcGuscBJErLH/xRCEswfol41T5SJbfFczvrTC3UObdUH+e2fbavm5m4IcHXi2+iDKG36pGgRDkzXORYNj/m+LlHKe/7yN7xZftBZjilMukd5pElbhpaWv1UAaQKCkWkRPrFyxdZvIbKo6Mgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322943; c=relaxed/simple;
	bh=TI1XQ2rnYX/q7o06G9WFxU8rahGP8SRRs82ybXVjGFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hAfdLakMYB+44faPcZBkooWhNj0mfGmh+4FwGM1ePveX0o5pOPGSguXy9slcbagrUq97d/32M0aiWuSwm1Dr1qk9IVbTCCp1B0mQap/eHXKowwUWj8Tkbi8ekEyVw8QN1dI6y3noGfqBnkBWr8Ya70x0ZfRDGcsrIP+E9UuD/J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmKsAuSS; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af7MYSGOLvh38ZtEn2v3rrlDpt2emqVB1/BXNqGLqUbXxMbU51rZG6JqBGDZ5HBxQ1FQB3pCkGlnpsSGrHKQKvE4VNn27b01Y50Mm/xCL/9W4EibwNzTycTZIW6fhnHLnl1wx1RdQv/uJuRcD3mWJghz8b9hesell6Fj3BNbfrPJV5OxzNuIZ0J6DpkGKnXDw+/wD5KkvyiE8nLSW45K1WSa8MQZCfpGUHwSakicOAJ8eBcFaymkPXPu8VA24ZYPYY5IYQfxL4i0p/WYa5cfGpCmvIKmfcH/FH2SzpMTf56CXlUSwd5qhY8qmy58D0i7P/M7XDQnjG3a6pRgSWNqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+54OC3x9AQJNKepXjddWClH+4zHfZiFB4b29qh2bVLo=;
 b=bZizFvcSnbgNlQIYmbRaMZfoKKxYNLqBOqkHu5PVs5uuO5NLg/Z/KRx2i0tMAXGE+kI3WFhxzdApGOwQFZYqNfiHc41hSyvBHLrXU4uU4ntr6DKCulrqI1WayLUClBjWewREEqT65LGGmL5IJNrtBUnt5cYgypZuoq5dbcu/MeRQKpRNT51ifzWxdSgM1r4LT6/ilVsUcFH6qvLCb0DVUZLgZDomqZfBmr4hGycL21nwjzXqZMfKwpm11wqa3Urm0mufRAmF9PTAUjsz2qkjj+coQtKKw/seSH0jrM3Xh9YKgQAykRs/lmEQsqdbWJ5z+M5KvFQ9jPgCLN3H94pxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54OC3x9AQJNKepXjddWClH+4zHfZiFB4b29qh2bVLo=;
 b=nmKsAuSSYLzswirYFAY5YjWJ40ICqYhKwFoGMQhSn0ZNV3O+zEmqtoCQ7csLSj6X4T0gFKoTnXF3N7PnL0bFaF7ENaElunO4vFZKhp02wyOuBnjNuTxhb0XfQwXrY0gtufLySlkyhrGiNButToxWADIcJvXh7kbPtXdrY/GxVeo=
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 13:42:17 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::da) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 13:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Tue, 25 Jun 2024 13:42:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 08:42:11 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/2] AMD Pstate driver fixes 
Date: Tue, 25 Jun 2024 13:41:25 +0000
Message-ID: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f582a84-1ae7-40c8-bf74-08dc951ca0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v82qjHlhuyHh4QqN9IJUJEvLuN4oDrYnZkaOqWk9coYlHYR7xUq0WnYhIVo4?=
 =?us-ascii?Q?ERtrchdw3ZHAcaAsiuguwnV8qU+kD1HVofXFCfkkmscTJdnqyQjw5t4fMsVR?=
 =?us-ascii?Q?OzYzNpp8LsC3gW+a8a+AXWDYaMHzw28gAv9LQxmtlekV8bbfzgQeP9kovO3J?=
 =?us-ascii?Q?knt9L/hCG1w4vm/HBRY2GYNpd3eladddSfpiobMjIE/axtC9adCWDw0nqQQq?=
 =?us-ascii?Q?OTg4moAv6w9nTSVz70fVKjgio0YtZFRjz9jGSJeFt/Me9G4wTKAe6hWIrQQa?=
 =?us-ascii?Q?7Qe74yFC5dlNJfGXxeociHrFHPYzf8t+ogsz85mM0qI+iMHJQMbUIBT1l6g1?=
 =?us-ascii?Q?Qbm98+YAgYHos/sncFRjfm2A9R7kAHiHE3U+bMql5TEQgQujMvmqyfIwlpfM?=
 =?us-ascii?Q?tWXR27JVW2QRH8mjVk+ff+XlenjjrBLCc0BxLATa7iQ4YzrA/em/WZoAD0QO?=
 =?us-ascii?Q?3Z3yaXpI4hrHR/S1y6cx0QoEdq8hsTA+uBO2hKc4B9FFdvzDDsnbHGW72TJT?=
 =?us-ascii?Q?4p+On7crJwfKuo9I8LfzmCYrT+24woto2SlWrI5bAu2w2kfD7pWXdcMzIgt2?=
 =?us-ascii?Q?OXFMJPhYRdyJildpKze3D0tP1voK7yYxMJk2C6PErVLEujsoFid9xPUMh/uC?=
 =?us-ascii?Q?JWZt/AOSP+IQfiS7fp6PFEjAeygMVAXSO8rlmJYJ9svHsIt035kuHOFP6l90?=
 =?us-ascii?Q?wPHOIc8KJZ6npAu+JLgpEjbKKLhl76e2hs3PajYnMTko/366EOd9QmkBliVW?=
 =?us-ascii?Q?PVoODgEhsiwGKb6mjLhn62XscIkatXERfIHhAH7zE5yNz5BOI/82CB2CuRn/?=
 =?us-ascii?Q?51ujl2KcjlPmCiKIBCfJZE+uRr0tTIU8O07j10xFdn3hb4NDsgZU7hzH8+Ze?=
 =?us-ascii?Q?6AvOf4xRoOiayvYwpem73xgkgZRwbjrlNkBjntNwVWc1s3fwCXfsO3lZzpqQ?=
 =?us-ascii?Q?uI8KodbZMpxLkTIfLAoOnsCesqbzQ3nhIyZKOS+Xb8fQn+pVgJDNjO0BP9JK?=
 =?us-ascii?Q?vNkXrYEsaPCObknkV5gx7tsH6bekRjXSiq3FhLu1n7dltvkmo+9XP4hwAkCx?=
 =?us-ascii?Q?YJQSRA0TRSeI5m08BrnP6qtrUQUaHjeKvUnAvw4OgtJB1CPqhfcfaswMZpzf?=
 =?us-ascii?Q?2WbUple4ZncASAGRsnOTS+pwvG3ZHBmxojFNBPBAEfBhyvCLt1ApUrkv/6UR?=
 =?us-ascii?Q?Ia47w79FmsA870veF3PCu2UpIVMpyHTYFlXLPTQnO/cQvZBTDEU5NF7iLwFe?=
 =?us-ascii?Q?N+0oTDdEhqNMs6XcH/j2s2TALRS6RodrAWRhq4n9By5Lgko3aLCFtthvDWPN?=
 =?us-ascii?Q?XYZXdsEMeu4HCI09sGeViM53x1NFI31X5vhkrea7+OPbVXBtyKIe5hQn+gJQ?=
 =?us-ascii?Q?IqPH99RuZw3pV8GPAY4ve31+Bg0atmyMn10OChh96OaJ5nIfFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:42:17.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f582a84-1ae7-40c8-bf74-08dc951ca0ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

1. Handle the nominal freq units inconsistency in amd-pstate-ut, which was
leading to the below error on inserting the amd-pstate-ut module.

[ 4982.498864] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
[ 4982.498873] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
[ 4982.509151] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
[ 4982.509155] amd_pstate_ut: amd_pstate_ut_check_freq cpu0 max=3709000  >= nominal=2401 > lowest_nonlinear=1903000 > min=400000 > 0, the formula is incorrect!
[ 4982.509157] amd_pstate_ut: 4    amd_pstate_ut_check_freq      fail!

2. Setting the scaling_min/max_freq on shared memory CPPC systems was
broken in amd-pstate-epp driver(amd_pstate=active mode). The
scaling_min_freq and scaling_max_freq value was not being propagated to
the shared memory area, so the frequency capping was not being honored.

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
  cpufreq/amd-pstate-ut: Handle the inconsistency between nominal_freq and
    other *_freq units
  cpufreq/amd-pstate: Fix the scaling_min/max_freq setting on shared
    memory CPPC systems

 drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
 drivers/cpufreq/amd-pstate.c    | 10 ++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1


