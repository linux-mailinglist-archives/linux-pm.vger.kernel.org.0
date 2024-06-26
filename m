Return-Path: <linux-pm+bounces-10014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7D91780F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20112833CC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851413E3EA;
	Wed, 26 Jun 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ClKy+tV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA328DDF;
	Wed, 26 Jun 2024 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379545; cv=fail; b=uoLsqnxhdBJZxQitfLFCGqf/7uy5jN4Pr0Xy8mWKi7oNqtRGoiS6ybfgDUrTCI56378wRwv4f/ooJEUnAFcUUyutwvKIPpTTm9bN+agTCzkfaJobko6ifmcReY2BaoGZ5LjluoWepD2CklB/MW9xab4MgMTXUECR/5Mki1vSF1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379545; c=relaxed/simple;
	bh=nUTgF4sPUYEp2x318UJ0y7NzvPAsvvJkMUCMtMQrJpE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sPisNuNdRO2LRBevx3Y+rGPS9oVY90VWBAXkiLX6Q6PMVEZTNpvXehTnbPvh6nRCcjW2WEK63yHXv2IIL7iA62hjwtX0v8xLzJ4Q8XsTancOumlCVqDg8psANC5PluKzVsngaSJzNXmJC/QLMqsg0Y+kQ0mBgWwFpz0JyW3yPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ClKy+tV; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvN4fZrX/bxgP/3fzPoMSNkO+i1NywcS32gDlNa3ZpbeH5nUTdPaNJooKP5iXYgmNrP5Ni0sB2mogkKqb3AX46Gm7vK8wBZ9F31QIuxSr0oh9ZQbZMfgpp0qUYm24d4otXG8a4n/r+fBDsXw9W2nZmZIvFKiEeHpGbkW2oUsNywoJ+yZoMlJOdkE2Zddk42zYb0qkfP5XGLnTDn+HeVUtv4llurBQJaOmc8fPEFEccGh9+WE9t+440Q9i2wQMjKq4Qv3kgjlv4zrwE8H5p7HMtuX6ajAx2Uw44QM0Vtqzk8ay5bxwFnBz88s1lJ4/4X7gXH3iIOysTn56ejlmPNodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liPYPG5ahSpqgGKu6NatyaOxE3vLrU7F1NxTHo1P5ww=;
 b=AFl0qJ+BJ6DCrvffx9IeaCJ0ftXnObbD6tVIcN9Jisc86WdiSY/Tks/krjCqodehvuYFy1jtrIqumrCM6gC+4FB6WVnEf19bQLTwhz4yawcVyfoP2/W8vPWVO7IdG6lBNDjKk+mw8V02Cs5ucrQ9NM+AiyuET01obOqK2Vqqk4FRqaSz/HUU2P6peDQx+j55y+JXB2qEnUw2zER+4QqqP9cUUDicCWJryv0yP83VSDZb8pDgsQmzsswFZZ9HKY0mHMmxxcIbbz1HeC8RFZt4g42EkQVQm7S0dw3Gbg8kIfZ5bN1ygKueZrJw5C5CIFVAEBZhWD4CXc2tbUQWPj5yeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liPYPG5ahSpqgGKu6NatyaOxE3vLrU7F1NxTHo1P5ww=;
 b=3ClKy+tV9V7/G3IuxIIxTC4NiIWkU/+9bXBxFIZ+yYOJbpWJjVwvU6eEvznR63yONfjnSugeXR7u2tpyiT/CxLZR0NQN7pSgeuUL60eHL+qsMb+HYpAPNSYvIhTq+C0QIzmWvYpHfdlw5g5jIGZNs7rze63uq4qsta3XeH4Aww0=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 05:25:41 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::95) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Wed, 26 Jun 2024 05:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 05:25:40 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 00:25:37 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] cpufreq: acpi: Mark boost policy as enabled when
 setting boost
In-Reply-To: <20240626041135.1559-3-mario.limonciello@amd.com>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-3-mario.limonciello@amd.com>
Date: Wed, 26 Jun 2024 10:55:34 +0530
Message-ID: <87zfr81dip.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd08c78-2ff0-4254-5b64-08dc95a06b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|82310400024|36860700011|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?08b+xDVOmODn/cXj5yqq0YOvzry5bWP5KeVQyAFwXlR7m358Dp5++0B0t2jo?=
 =?us-ascii?Q?e3IE34H03d1i98isdmWPA993PE1zG3nOn5bYYJ++NsNLcNHSqwzbBpIYPJVF?=
 =?us-ascii?Q?43efCxtcL2a51w/Vt7HP3BBuF0+bPR9i65xG5SWhozIlaSGO3Qv6jg01l3Ma?=
 =?us-ascii?Q?j8FruZTOvVrk8IY5NVxBP738cHZgp65dUca5wjfV+YAcG0WXXSoLWsKT9lYs?=
 =?us-ascii?Q?u6T0cOYFmo4BLWEohUa1m+cWaS1bRn3uACiNkYZsRQ5n9d97mzOUZGRO3eZ7?=
 =?us-ascii?Q?ImekC/g9FUZ6bLJqd9wfuN/AQu9Hbjt9Gmflt1PyBT4vCOrfBUvgRpkzDSXQ?=
 =?us-ascii?Q?HpCBktJj3Y3eG5iaPX1N56+x926vO+0kxa9I6gm3kBjrgs6vwaYpXZIwwTWs?=
 =?us-ascii?Q?zvUSTnZS0T/zKQTnFSt5wqT1gwNttsY8itOMPh+EaYcrpko8qt3iliJJ0aXf?=
 =?us-ascii?Q?w6nS7Z0CapcEaMeTDxVXCmPug3vOCgM2vfWaYFGnsyPDKMWED94Tj8XSSJPV?=
 =?us-ascii?Q?Ys5EJwSXsVsUs11tdXl69UwzRMjqbx48bsxi0ilk4XdNCBfpCgSRvkY31AEW?=
 =?us-ascii?Q?yEpTaWyMsAr2gD9EN4KVl2jo4lHJX75peuGmQ+Zj9BRFR9xMcwXFCHmMGoiX?=
 =?us-ascii?Q?/byC44YdCQVT2p27pPi3cLPf6f99Ug2wjqs6X4XLuIl3n7+R5ew7VhN621nu?=
 =?us-ascii?Q?2C2AP+4uWPdyrLTE2FDSbptRb6zGr3kZucwMuUf3sKImoQ4sJmVWlzXuHcOn?=
 =?us-ascii?Q?lwFzT7musgeYQIHS2bFnDEPVGfbZSCP4WtN4c2oALL2UfqF4ueU2gkQE7zVW?=
 =?us-ascii?Q?7xXVaIjNC//bvNDourquD18sD/RzxgCrN3OaNY8ijQWYgxKX1kVauuIbKZRz?=
 =?us-ascii?Q?J8lOMVPheUJRGzV61Jk1YzGb5H+03Lqrs8G83rQcI90BuJF7kl0XOJ5DAnG9?=
 =?us-ascii?Q?thypNwIk1+spwX3uSBGPlezRWvQzbBvQ59zSC1L/QFg97I1IL3M1trso77Kg?=
 =?us-ascii?Q?hwEd81tDs/p11syNg5ZQLLC+gAz3NLrxg5ZnIMGXv1gunXpknxp6p8TvlJG2?=
 =?us-ascii?Q?nBo3FP3pk2lIjTemCs5TmQAy6ydMtmGIYWe7CrAH9/C6tbd0GjTqASwkDl7b?=
 =?us-ascii?Q?8oTe0OW+2+sNOAeQ1IXwD6QchjO6trkX+m11+EVnORQZ1wEmYHDE92SqOBVh?=
 =?us-ascii?Q?vc1qsKvcKgb6D0ZyEEzp5Fhzu6iiafIbWzf08hFad/ASjBG9cRfCt/EvuvdP?=
 =?us-ascii?Q?n0Lw/xQx6z9mD3+iytstpMtLdTCR8pEDwzXm5IAruhNH6FANTKWfQflhlq2n?=
 =?us-ascii?Q?OcgFqVG8ij8tWImquGHmwN1sY1jl18qstbe10pqJZum7B3Sql1WDiUuf+Ijd?=
 =?us-ascii?Q?jroG9HNTgYXSCsIKHTYEUYZpRARf9T3wTLomkgAygVDN2eb1NFwC/96x+dIN?=
 =?us-ascii?Q?BMgMu7vMlasocEh15fBs+EOK6XbZJfAV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(376012)(82310400024)(36860700011)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:25:40.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd08c78-2ff0-4254-5b64-08dc95a06b60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

Mario Limonciello <mario.limonciello@amd.com> writes:

> When boost is set for CPUs using acpi-cpufreq the policy is not
> updated which can cause boost to be incorrectly not reported.
>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v14->v15:
>  * Use Gautham's suggestion instead
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 37f1cdf46d29..bd3f95a7a4fe 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -139,6 +139,7 @@ static int set_boost(struct cpufreq_policy *policy, int val)
>  			 (void *)(long)val, 1);
>  	pr_debug("CPU %*pbl: Core Boosting %s.\n",
>  		 cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
> +	policy->boost_enabled = val;
>  
>  	return 0;
>  }
> -- 
> 2.43.0

