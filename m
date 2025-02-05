Return-Path: <linux-pm+bounces-21383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341CA28935
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC63A3D7A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87A22AE73;
	Wed,  5 Feb 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dotCiWWl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10C22ACE4;
	Wed,  5 Feb 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754875; cv=fail; b=sQosFTWkN9vggb2HJqTX/qURacTWW4dl9UGE/iuAbxNxPgAXqM9xf2F4k2ZeW2He7/N55924sFHPmmcrbfnMGUL1heTau3TbmSVC5DSDwmxR9514Zjxx2/LnSu4r1yr4RkhsmM1CoNJSKbpyjuNHpYs+JZyf3NH0/mm4VtdSoqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754875; c=relaxed/simple;
	bh=WycPElaCc1hqQI2l3eB107Y4wWjlq7Kdg2x6zvEXw2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji79xqlZaWYefp8fpcmRY9cBZ+uNUsXgHZrxwJZlIKkRDZiFUCoXZqXk8WILXswDnKZBXD91TvBju+2nt6STi27Ho6V0TimFkT7c1dsMoQ3zCOQPpMhIwtZh4vzViy8bkzRF6Mfmp0lwl+fvtZntENpcBTSc3pbL+J8Bn/aC5+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dotCiWWl; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBmPjDF7gs2+gqvtbt8pFLQ8I0j5NrIubZ0to/84SckN64ngAJlSfKUNm/28FVLBK0W8UCih18nyGGXqYsaqVSYxM5qC6Z2cz3IV80gmu7Iw5ph7ILV4yphdpLx1nGCkB4yhDKAhwGHBCgS4F521tb0OzHc2aUn7V3Vkyac0uaqianwOGGWUOCRIwCjb5CYOblvAErx4M3zznIe2xXAdarkZV3d/0FPkezuG47iCu4oeTzIiPdSc9Ad8cjB5D88uPTlVmX6HLT4nnY6Otz8D61zoyvq1Kln++lb0kVWdFNDW/qlmKWgRr52ACYZ1O68yrrudo9kZgTBZC5lOYiuF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP8zS7f5DI+O6aj87gcX+Wp+O48dfToHf/CM3VdzFqk=;
 b=mz9FTKeSofwMdEccu7qsrJEeKowbCBPo0pZrKbV7Wvk0hyWU466DxxU0JBYBqDygLEPCiP1eN64uVT6vkmzqiFdrgVlSxLKD3QXimU4gL8uqOX/XyqU+Lp/nlFvj5YhhcFV7RxCArZcta7Iwx/hSk+jUKGYqbqnWe+2Ef4olfC85V5N8sUyyNy1/nHd/5GiVVvzSwMjVFBxPpjJWwcTBewEOGHIv0WEBbt7lSGIZm3n/h4FHRZg+kfQhdY/lQVCfHm5RUkLCZgDuLduNQMSCYGamHhYv6AWG5OGvtGLjKHTvAwQ8pKHZH2VKpXhQ7ioNSBwjoGN0nGZ4oDolVdt+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP8zS7f5DI+O6aj87gcX+Wp+O48dfToHf/CM3VdzFqk=;
 b=dotCiWWlUhBUrAdLx5z+60gi3hJGl1oAXFeefY9QIj9JZbHuaU+DaOX9jeXdt4/m/frol7Jd2qnPwDZynvKX2PnkP/1ZQZ/b34Dvl3l2QqfbHeVu3ex2cU/FK9ZnshhcHV5Dr43BJV0zcPTf72yG3sz9Q9vX0SaTnJaKv9q69G8=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Wed, 5 Feb 2025 11:27:49 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::24) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 5 Feb 2025 11:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:27:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:27:46 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 08/12] cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy call
Date: Wed, 5 Feb 2025 11:25:19 +0000
Message-ID: <20250205112523.201101-9-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f207249-ca37-463d-9f94-08dd45d81f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quQ3tsXd7a+eamNkf9ryR4gqHDk6WQjIHgG8eA8zveTummVSOnhTXd1VPolv?=
 =?us-ascii?Q?GhHJ5ICIWXDm2hbnfeD1l76ZY7FdOXJdKjx7hPcVdKiWksoy/MmGbCC0BJtE?=
 =?us-ascii?Q?laJM3RB6I5s5SiyRXz5m8lxfUdoadI7yOFHp1tZTP3TIyzjUDpQ0i2KVoEqB?=
 =?us-ascii?Q?qlujibceUoZFmYdcP3LI+jRSlNPTiTzWdk1Ayn5ZU5wxyU6QnURCIPuaZ8MW?=
 =?us-ascii?Q?CG73FDcQP++KibM12X2doFhber7Fi+5B6ltb8/Ivtqs8MDl1+1YPMlZiA3cj?=
 =?us-ascii?Q?bHK6ug0rEk7F2EgDZo903rAI9bf3QUs0ZXHsj2NaKb7ln804rh52hZ6XfkHi?=
 =?us-ascii?Q?1j09IPKYgJLE8HsrMVqpirNFDcj+4v/gKZKBf1SLNNIC7t5d/JhfnL6E0M+6?=
 =?us-ascii?Q?YfoQUaGAXnwjPQDEKbi6zhSxaidtmPGnQf0C5fR5jU4w69QHnv76tVk6P5yo?=
 =?us-ascii?Q?6/8Z5dKDvl+IIhyuP4uGyfX1Ep7ngXM4M13ETpjZpzPur9p46Y4KIu9E9kEq?=
 =?us-ascii?Q?1YflLUWml0UsSBwhVTISiEku46r7gYbzny96VkXFxsTqOn608AYl877Q9jhg?=
 =?us-ascii?Q?AfXhdoqvzSY/+4TIB6s7xDojIj+RmPCjZlwgkIdmZQPkwyztQwN4RLgYTgmJ?=
 =?us-ascii?Q?iUruwmB+aSLIGpAKIqTg4tUqQBrFdK/oITF4lqn98gU5+y4LtrpbSTuU7DsP?=
 =?us-ascii?Q?+Yt/m9ogv4ohg+1GIfKfGOq7TQRg3BFsRMIYfgtgJE7A0/zROEFBYbAExv1Y?=
 =?us-ascii?Q?2nmuC5HwvmuP6L9YorF51VY0GahMkev+dq3e4/9ygCd5zQhSvUsybaPXLgpj?=
 =?us-ascii?Q?7mq7pv/IuimXJTKgUW2OgdznMo0xBKYrVuN+FuK9xVXFmIWiAu3aIp5wKcC9?=
 =?us-ascii?Q?vGFrICtP84PA9lX1mr/ITxRRK6Dq3RTJM020nExIeOWuLZkdwl3nf8wQX3nL?=
 =?us-ascii?Q?995pfJIHz06GKGVo2Eoyl85y9f3DsAVzsPImRzGwBIII1wViBhQp1brmJojo?=
 =?us-ascii?Q?fvAbmIODndcoxQHa/NCmEHsgGdysyJ7IVVu99iBYw0sv+Njj6AKHd8gXkDkH?=
 =?us-ascii?Q?Gbhj9iuoml2eKQVRNvKoUEYb839POS22mC/35jfo4YmgK9Ry6UpyRYRvvY+M?=
 =?us-ascii?Q?vfWbvQWCRlyV+33DzoQchbnddtrqdIuuvfWGzhYcs6hNWlNbxYGezYtrH1ln?=
 =?us-ascii?Q?ziqg4X1Q1USGpm0u+T6UhadD9saAq6dIUqwiK+qQ2hK1pxrLPRPWtr0UIlsO?=
 =?us-ascii?Q?NtKxGNv6IIRNxoWrN0W2drEyXrnFGYf3MhhjKCIRWOfmwK8SX0XebxPlkQ5U?=
 =?us-ascii?Q?4TLMf/3NWWazNyOrkGkxXQYcS42Df25Pv+0WBzKqxnnDWAW3hCE8bH08zzSW?=
 =?us-ascii?Q?8BQTL9eWT5dM0JuJ3/Zr5PHplE0a7eUxIVPiPRv0Nc4ei0JNtTpfgHhiMEGf?=
 =?us-ascii?Q?R82iWbmDvpxQfrFe+XOIGiejksBGMj04IH63Z0CRNtxauAbZLgyIiR5x9LNx?=
 =?us-ascii?Q?jCZQJQV6C5oPYn4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:27:49.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f207249-ca37-463d-9f94-08dd45d81f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

The update_limits callback is only called in two conditions.

* When the preferred core rankings change. In which case, we just need to
change the prefcore ranking in the cpudata struct. As there are no changes
to any of the perf values, there is no need to call cpufreq_update_policy()

* When the _PPC ACPI object changes, i.e. the highest allowed Pstate
changes. The _PPC object is only used for a table based cpufreq driver
like acpi-cpufreq, hence is irrelevant for CPPC based amd-pstate.

Hence, the cpufreq_update_policy() call becomes unnecessary and can be
removed.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 346fac646eba..107ad953ce43 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -852,10 +852,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 			sched_set_itmt_core_prio((int)cur_high, cpu);
 	}
 	cpufreq_cpu_put(policy);
-
-	if (!highest_perf_changed)
-		cpufreq_update_policy(cpu);
-
 }
 
 /*
-- 
2.34.1


