Return-Path: <linux-pm+bounces-10479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10153925327
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 07:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6542DB21B4C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 05:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5349641;
	Wed,  3 Jul 2024 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kda375Ek"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5F22067;
	Wed,  3 Jul 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719985636; cv=fail; b=CLvz6JM2Ax8tgOx5ayamdTNg85e6EN3JWX6zY1sYLEtrX5T8zNkLy0KrkJkvyS9S/FhThlIyjEitlP4j82NzgxXt2B7587rwjLKvZpqgv5UVQBWQjpEMgpcz5ByH6ZVrHpcig4sE5KoN2hA8SwzqmCQFkCEFZzveNqraIfxVNTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719985636; c=relaxed/simple;
	bh=t/PID9g41hYzOimWt9lfguUlcbSJg6/MeuIk+cJiRtY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SP1I1avEyLa+5n7xcJ5qw7M7fC49Wx2PiO0cBuO763c9jqH5e6ORGXNxcVeUjIJI4kA4eDOfwEXm+fSK+6DorMITglAV/wPNpo9eY1enKdcf2GomWsWy/zgwLjyZxiK0UXWpzCAocdwprWO1HkvbFrLt6a1Gpi4bgjS1YmBHN7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kda375Ek; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db01ztEyvSH+u136GkpB9MBZFaHIY9HT0dDEYU/AfsT2gqtiWvdKJRD+ufpc1j1HTZjGg2Lzq5mlZPMk0VAGOzok0u15o1GpBIiE06bQYQr8+xi42f00iq2J9A1UnJwPVOjB49bwW5F/uGnQlQMJdTCNC7M/qjsi+VXydYr6A3P5j99aAo/bmTP1SjiK3MK2SYOaMpbb+P38+LT7nkVw+c4gTAHJJuyq4wpyQzqTkP6FyyJoE/vhu3bcyGMosVzDM+Jzo4QGVWk+wQnOVT0UPiqk6+fMLgNO5eSYGMcvpZQ/QgTjVHQAHCWOl7884d/Unqr0tYmtRBIEbjUVSkjWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k6fJ6HSJcZT6ow3ohgSFezHrXZ1MPyPMsEGoSBVh1w=;
 b=YuOSK4gLP+UdSolwxfSAahD+ICCFAOpFFMZ2NdT1SMhqc7SoVb+tIYvb7AR2CGLAq6ObHSMsGAJpO75QgJ3usY++TSLkaM25dWNtkvSdUYihzEv3rechGhzxMQhtr1VER9P1MCQWZa9dDhSNSzRpBnJF+l0d0U7fQeVLkfOa1Wpzz/l3MyxkSG8gNZS1P7hrAX/kFKzNt+hACXzlLMy+lQSXFs5pQVKLc0Pr9X094iAqZceHOfJM2VimbqUT4r+kn5c/M7e3VNQIrcxeXDfEVeoXpIFS7ZkfFWYyAJkCEbq4DBMwZTjjXQZwNs8Uca1Q6NdmMKj7TnibdPfpGt+EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k6fJ6HSJcZT6ow3ohgSFezHrXZ1MPyPMsEGoSBVh1w=;
 b=kda375EkY4wD4RbNY9BPTkmevXM5aHJPaltqArYjWiRO/GNZCUR0ph2qfLUdlD42VtcMfFuSbJUzVfC0cUtPP26CohQdXljqu15KwzxESO0LGZuEHcx/fpeDi2hvNruaGjJzXKHcnDBwAq3+5rHeBn//RBZv5CfTc2Iav9E3LDg=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 05:47:10 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8b) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Wed, 3 Jul 2024 05:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 05:46:47 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 00:46:43 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq
 setting on shared memory CPPC systems
In-Reply-To: <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
Date: Wed, 3 Jul 2024 11:16:36 +0530
Message-ID: <87bk3fqb7n.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: ed92f716-93f8-47d7-8cde-08dc9b23873a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pK1WB/g8LvpinNqf1cZjZauXbjrDO9RlKCdGLLyTiT/4k6nKpwc7pbTfZ5I6?=
 =?us-ascii?Q?NfTWr3ydwMTntjgC9lk8PJw+o+oJ7BRKUD3DQDC8FsGmjwZVyYLHY0EWAL4W?=
 =?us-ascii?Q?rEwm0iyxh/FXX1gXzd7enLjt8D2biJMltrcYaRdIPXOVjzj1g+BKDoe8HaA2?=
 =?us-ascii?Q?ULOfJN5M+NwilmZaOybBSDgag/5e6XwRuuqLURDpuNvSED0RrkIhxeqNCGfq?=
 =?us-ascii?Q?yB9VQjxyuEeL/9jF1NQ8sZId137EWuNvdj00crKJM5/n1oYMYJV6JGGK622I?=
 =?us-ascii?Q?zkoOq5vBsOw+RCkcYAltBWiQmahE0Z8A2cug0N+irC/qvMjm/hzWAgb6Yc9H?=
 =?us-ascii?Q?ZT3HXEYOt9Iw6bDwh87IbRkYDVKDTSs9uWsFgUWjm7XK+c4iExiDNlG6sty5?=
 =?us-ascii?Q?LgFRGWL+dJQjkkesrhwHj5UvbYAab8Bc4YOE6P5JlmgW3w8LKS7N8AX+wtJD?=
 =?us-ascii?Q?lRs6PVthYDEg9ffFD63BXWtu1+rY5+xQfTcMo8GeEhWS12BkUueRsBeOQ4WW?=
 =?us-ascii?Q?vRO6cQfVjv2tgHK16tcTxdeYUuYT7HAd0Oy1EGmv1R1A5A2reFzTOBvwR19H?=
 =?us-ascii?Q?ItS4k5CJMnAVdMxqw7Z2SPCQLMWE1Udkq6USAlQ4EzfYz5fDvE03XTkbgLWL?=
 =?us-ascii?Q?MuWxC92gfC2q7lLecJ3/lJ0A4D8E/tzfsl7+rh+XI9GH0OmpD9ZDyJxj7M2c?=
 =?us-ascii?Q?7KlHlPuXN7Ws7uFlG7vlqCrjlInJ8RzbuRMXyeGRkV3lqIeKGZqgxbf0cQni?=
 =?us-ascii?Q?Vz2tVwsSKXgHbtOb3U1GB7HDgvGFHuio06qgjeaorqXVusHW6qratWocA5qK?=
 =?us-ascii?Q?wNcfyKSw42WFdvDu2uUbQwT4w8ISxJkMmzauA8ze/CayElnbUcwxATOjoblw?=
 =?us-ascii?Q?lufPFWjFKM/wwYZoVs9NTWOiBfFNrPpkDZLCL66Gdnz5vV6sJP47vYzgaGpc?=
 =?us-ascii?Q?uqlMvwTpBdJzyvPCj6LHHMnqXT6+OCvyJfcrVldh/7OGajkuqulJLXvP+OXU?=
 =?us-ascii?Q?tJ1Yi4hm7lIJxod2qeDuuqYl3x3O+Cz5JewvlxOtgQ9aVEwh//dfsSHnWI7U?=
 =?us-ascii?Q?Tl9a8ybfW/ehielVPX6lisUKMZIwy3dLHegpGPOO/SYIyMazg/MGDjgw9k4O?=
 =?us-ascii?Q?zgTDPweZWZyxa0RdrIhfbibEsC0Ph+koNtO53OORzyhJqAbjm9R7pO+Uw9uc?=
 =?us-ascii?Q?bQibiquBYNR5TiAG0AwBqfarJu3FPprTvQhxGDBfPUKXiQ9ewvx/F4y6YrhV?=
 =?us-ascii?Q?Iik/QtUzPon0Cj22xgHFscXf69pReFpPR5KZoej/kSmEySIfJV+EF1iFKeP2?=
 =?us-ascii?Q?gmDppG0tsWrXDY8jbujoLY/qtm06O4iCnGhHWQ6MdBqILDaHHYHm6jmV8ASW?=
 =?us-ascii?Q?00vrY4uNGHZIZzTOLpJ8VNoWp78I/IR3CuQOLfPXrlsn4TSOK/NFTmQ69Cp4?=
 =?us-ascii?Q?9bS6FiATVs53efcFUMts2JAa3QFALN3q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:46:47.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed92f716-93f8-47d7-8cde-08dc9b23873a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> writes:

> On shared memory CPPC systems, with amd_pstate=active mode, the change
> in scaling_max_freq doesn't get written to the shared memory
> region. Due to this, the writes to the scaling_max_freq sysfs file
> don't take effect. Fix this by propagating the scaling_max_freq
> changes to the shared memory region.
>
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reported-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 43 +++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ad62dbe8bfb..a092b13ffbc2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -247,6 +247,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>  	return index;
>  }
>  
> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +			       u32 des_perf, u32 max_perf, bool fast_switch)
> +{
> +	if (fast_switch)
> +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +	else
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +			      READ_ONCE(cpudata->cppc_req_cached));
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> +
> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +					  u32 min_perf, u32 des_perf,
> +					  u32 max_perf, bool fast_switch)
> +{
> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +					    max_perf, fast_switch);
> +}
> +
>  static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  {
>  	int ret;
> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  		if (!ret)
>  			cpudata->epp_cached = epp;
>  	} else {
> +		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +					     cpudata->max_limit_perf, false);
> +

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>



>  		perf_ctrls.energy_perf = epp;
>  		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>  		if (ret) {
> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			       u32 des_perf, u32 max_perf, bool fast_switch)
> -{
> -	if (fast_switch)
> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> -	else
> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -			      READ_ONCE(cpudata->cppc_req_cached));
> -}
> -
>  static void cppc_update_perf(struct amd_cpudata *cpudata,
>  			     u32 min_perf, u32 des_perf,
>  			     u32 max_perf, bool fast_switch)
> @@ -475,16 +488,6 @@ static void cppc_update_perf(struct amd_cpudata *cpudata,
>  	cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  }
>  
> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> -
> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> -					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, bool fast_switch)
> -{
> -	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> -					    max_perf, fast_switch);
> -}
> -
>  static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  {
>  	u64 aperf, mperf, tsc;
> -- 
> 2.34.1

