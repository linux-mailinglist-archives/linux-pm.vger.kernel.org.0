Return-Path: <linux-pm+bounces-18882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E39EA68F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 04:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73363285D34
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9F1D5142;
	Tue, 10 Dec 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYTZycI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4CB644;
	Tue, 10 Dec 2024 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801201; cv=fail; b=DToKFz7NQNJu2/Wl4MMv0ZS6KpT4hLofUrjqRaRkF9ahzBY4lx5rk0529kfJFTQt03BLvf5W9aA3bbfMfv9qyqT7eMIt7cUjCbTuKvZUvSJqWVFbzD5AkbZlv2kynJg+4RLp8M9PzKu9S1ukjQjYhAkLJ1t1vpllGzgFA2gUZg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801201; c=relaxed/simple;
	bh=KP+NkzxA/tBPO24GhLBcA+QFFWNkU79fBN62awwYmP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SxnKcIQCBrD2wnlSiVj/XvKN4+cZVoI17MFaS5zoyp2OpZfi9DZM7PC2w/ZgOcRMN8R6VK97RC5a2SXaS+BsuU8DCawWZ+D/oDZyfLkXzVF12j7tpcHWqD3owaesgbymMv0azbV+JIiOA41lg52MFgg/vXqawThZOuJrgP1eYF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYTZycI1; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpvwfbl70tZtJXZ4cHQHEWBg8ffwf2mM2GsGj4KWiJbwlxwVJzfHljhXVknV2TUjUPbu4S1M6w25kDV25RVbnDQ/PhdVJbz+yG6M9HTPeCHpuEbQBQQFJA7GRItM2AHgkOpls8J/3qxHS2K1NLoPxtRXZUyy1BxXgVpqNUFJgTvvQWlGZ4UHt1VcFtG/x+d7v0cv73ZZG9YpzZnAhRn1vLX49GlAC8YA/oPix01Pbswj0ghkIJxnHa5v6hAV0d0aQbba6AeV2DuEcacInO1/sKHLvyir8Bb/AmpxCT/GTfSfzIQ82plKpkC9dEGEl0il1/3hxLGnGesluJnnEJaIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXi9nxi/yqvcIuAT/67it6IavU439eN6n3iPe1Jk2kk=;
 b=Oih01nG+m7s0ZmdunKAbEhPXah/5XM18lrrrvN8BcLQJjx8TGrJDGg06hCRbsoo+E/Ih4stdGu36OZiWT8oxncG+qp+mFp5ulBuxE4UFIi+EmUMbG+sDKyT7X09UVV1q7pI0xcdtqhganHNhU0SqcTey88b0gFLrarf/8nH35UPo2Yl9LgT1LUKTciGjk/ZaN2+Lins2nn08HgQr+/4yc5gR3HCwAwQQupo6n3fAoC8C+Lja853wFmt6vyCblhX1DwAIiJhsb0xJlQ+Iq+T1kX5UTR8+RkDRxPYZACYqPpo6tVsouaeeyTGD2JApBbQ2XhpTI57gaup3ZPRpBOse0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXi9nxi/yqvcIuAT/67it6IavU439eN6n3iPe1Jk2kk=;
 b=QYTZycI1NQm8/CdHRvPbynV5WZX2OggtPH1y6a280pNvY4sS2Bq25YggkMyn1dFnErSJ3w6ZvQBe6Sh37JZSWVmt1ZsGp3qlv1YfLEIUkh00IbAn4Xfq02isYLqHdjhgQJyuZ58sXNwPUXl8PZMOpGuBFI3uOWyaLKyJrKSAP70=
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 03:26:36 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::c3) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Tue,
 10 Dec 2024 03:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:26:36 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:26:05 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Detect preferred core support before driver registration
Date: Tue, 10 Dec 2024 03:25:57 +0000
Message-ID: <20241210032557.754-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: f7727051-467d-4116-ee58-08dd18ca73d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h0gHpFK9IVBKgo9hOBwAlhGz4aIamfzZ7PfIFASht8RCnPnHiG/WoQjpbL/Q?=
 =?us-ascii?Q?rCzLF0z23cBmuk4k5hQhmB0XSgyt/TZENIwS6noFYDc4t8qBi/DX7ow1qgav?=
 =?us-ascii?Q?+zDdNQNSmPJDDfyrN+4TpUlFfgFNezcO58ahKK22dMRvKQHLa3FHgSOHWP01?=
 =?us-ascii?Q?11Ey6fcjZ2Ak4tuoPT6KbHNDBEAj8lbUJmx+Fr8yK9DfxnNJKyhGMZRSDH/H?=
 =?us-ascii?Q?M2Y+rn2z2L6eowOEOhGeVOmIwsmN5oXg3mMadh6m4JS+XsIaOkYQ43fVKcVv?=
 =?us-ascii?Q?md09ng7w/1t8D7pw4boMLfNRvQlKQGu3JaKShj4iuN0r3qDpMV8FeST7v1fc?=
 =?us-ascii?Q?e+44E9QEFRWrV8qdN86/DdCMADzMrG30AlN0o3xKu7kXC7F3OJGOoB1YarWL?=
 =?us-ascii?Q?F7W/b6Sx9pUdTZv162fJw7GqtbgcjjPDeGInP9iPcU1kEqHxIobnRTki+cKn?=
 =?us-ascii?Q?n61hawsxii11nY1o4vhCiEpWFihdy2/Bd2VZ8IMDhH6WRxGGX4J7LVcFepte?=
 =?us-ascii?Q?5Djf8epe6NbX8c40J6/o/SL9g0KywGjB18n7j+tRrhqDRrAlGnbAbt0gvIVy?=
 =?us-ascii?Q?eAHi4NO4yfDggSJee5fI6jeDaQbbrcB4ymW2rFZmKOTXzyzQNjR5bgS5Kf7u?=
 =?us-ascii?Q?L9vn4ef76nQIpaPpTgVera7Otw0VuX4VLS8VsqAkA2EveEht8b2aMbDUSWmu?=
 =?us-ascii?Q?4xKN3IkzP8TDEOEV5rSTxsBgRZgfm2m4Fpt/+kEwdhU+IozrNeYqlcXE75If?=
 =?us-ascii?Q?Y1l2RbuwRnbWmUfbPfQrAYlW96QPDA9HHrg87oOPEivFLKtBML+qVwdh5A4k?=
 =?us-ascii?Q?2VTyZ0LIXOhDlI2vGgUdo9R6Xp/gJ6Hp9Jcydpe5IauYNwOGrK2wvGhPo60j?=
 =?us-ascii?Q?g2GZbiKX9eT/SHtdrJc7FRcRBmV+nhmv8QqWU72MXzWheXYa0PEkh/M/WQE2?=
 =?us-ascii?Q?xUiYlAcJ1KYav34K/3K3kqAu4xA5u1yTn5OPLbdUk86SRdlLD7JFyCwT+clA?=
 =?us-ascii?Q?n71qOO4eBXkMKKAwheUsU+SFyWsxKhNMVR5yTQRaHXjoMARBCE+RrA6KFluG?=
 =?us-ascii?Q?6cUqO3R4+iwbY4CTaV/Oxr+77QyANi0hbX16aIMXa65y8SMYXAbfQINtqkxr?=
 =?us-ascii?Q?gBfW8KczQKAoUa83ozySTKIkeI0ADzjLAsk7z5XkLaPtdxgOOuEgrkUdbJLW?=
 =?us-ascii?Q?HBurOwnu8BEzAYUreDn4Qay696zHsvn8IyWiIIsXkxrTEP0OOmffQn3IUFtO?=
 =?us-ascii?Q?FWeR8jYz/j4ehdgxC8SXnqnmPjbz4WP7a3pQH4XH1jMR4jwXw9EIgZ2VeOPQ?=
 =?us-ascii?Q?0xxfiNNCZFDt0qHnw8FmmhN1IQEc5X9nZNC77TAoP1xaJEihqNx+nYRW2KCX?=
 =?us-ascii?Q?lVss7R6obHCYzwx6VbzPp1dOMmL6mleMBWcf1Mkp2vYlf8b/NJkNkF3PF8id?=
 =?us-ascii?Q?nku4CQ8pXfUoMG8BidUWoZJ++lwPeAs+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:26:36.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7727051-467d-4116-ee58-08dd18ca73d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

Booting with amd-pstate on 3rd Generation EPYC system incorrectly
enabled ITMT support despite the system not supporting Preferred Core
ranking. amd_pstate_init_prefcore() called during amd_pstate*_cpu_init()
requires "amd_pstate_prefcore" to be set correctly however the preferred
core support is detected only after driver registration which is too
late.

Swap the function calls around to detect preferred core support before
registring the driver via amd_pstate_register_driver(). This ensures
amd_pstate*_cpu_init() sees the correct value of "amd_pstate_prefcore"
considering the platform support.

Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
Fixes: ff2653ded4d9 ("cpufreq/amd-pstate: Move registration after static function call update")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
This patch is based on the latest superm1/linux:bleeding-edge and was
also tested on v6.13-rc2 upstream release. Following is the behavior on
a 3rd Generation EPYC system with and without this fix:

o v6.13-rc2

    # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
    amd-pstate

    # cat /proc/sys/kernel/sched_itmt_enabled
    1

    # echo Y > /sys/kernel/debug/sched/verbose
    # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
    ...

o v6.13-rc2 + this patch

    # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
    amd-pstate

    # cat /proc/sys/kernel/sched_itmt_enabled
    cat: /proc/sys/kernel/sched_itmt_enabled: No such file or directory

    root@yamuna:/home/amd# echo Y > /sys/kernel/debug/sched/verbose
    root@yamuna:/home/amd# cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
    ...

System was booted with "amd_pstate=passive" cmdline.
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66fb7aee95d2..cb03f7d6575c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1862,18 +1862,18 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_set_epp, shmem_set_epp);
 	}
 
-	ret = amd_pstate_register_driver(cppc_state);
-	if (ret) {
-		pr_err("failed to register with return %d\n", ret);
-		return ret;
-	}
-
 	if (amd_pstate_prefcore) {
 		ret = amd_detect_prefcore(&amd_pstate_prefcore);
 		if (ret)
 			return ret;
 	}
 
+	ret = amd_pstate_register_driver(cppc_state);
+	if (ret) {
+		pr_err("failed to register with return %d\n", ret);
+		return ret;
+	}
+
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);

base-commit: 1f2f221668b210107f1277901bb757f1d77de842
-- 
2.34.1


