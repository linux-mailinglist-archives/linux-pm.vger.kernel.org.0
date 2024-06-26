Return-Path: <linux-pm+bounces-10010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E611D9177ED
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DC0B20B5A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2F13AD31;
	Wed, 26 Jun 2024 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g+MgREgv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFD44C84;
	Wed, 26 Jun 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378713; cv=fail; b=BqM9EhtUqDG29QEITq8vgxVR/1edJ1V4TQs9LEBBSIj+p9gBZppZjK473CcMbQzjMVyZ+kHbeZDPXWqA266mVh7Itp8BkxCKjdqTWzZ/WlUYJjm0dpAZ8B5GZETkCmlcFALblP1k+4n2bFCcD6rG41KUzcXqWwrsYtYEmFhhco8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378713; c=relaxed/simple;
	bh=n/zIpSpZw0ZuJQRYSxOCf7i2rP5QioeVtcKdv1V+0G8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehM8vHYb0LNMdTtbu5K0brIsWDA4Z2lX7mkmU4kM3+kdpsNlpmKH9ryj1lLL2yNDxmo/QrjK2uAsmBld1aT1rYzG/zmLBTdFhUXsmeSaqQw5vPqXRpSyVqa1MGdyIwYNgoAfbXHk0EzUpR/iMLj4vUQE17QAUHIekAIiJgp4uR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g+MgREgv; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzdLG/rxUNXPn4IbS+j37jINn3CLR+RAuV1LLcjHH74JrsC7NDF5fV2sXpMnYR79kJyNh5PAYT0PGip/alh3UpqIGgPl8X0brWhy8bH9ceqPsawnXGjafVDyzOXCEinKVebaVCbef8vtPw4Isd26j5OWVG2fdLbprss6o4vPpolm9kR8o4mBIw4c2NPgcYB4BRQ+3gVJMg+kQE8uUtWuBQ+Hfsxww/gO4nwSQJ/PPNmIyUYwBEH5SwKnMYl2aAKw713OrfJ/Nz+b4kcA2ih5+qEwpVNI7OKWFZc02XNR6dGnOkwTDzvgefnh08e6wRAERJ9b9OSf5IuYLOjOPPDWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUeE5mzp6Rm7SX+mjQoXTgOCsvmrOG8rMPuvfxlIysg=;
 b=UO2Yzd7+FqAJEtYlGy9zzeslN3HLBZ2/LO/KfPKEFOb9TA9H6tOS2XfpJ53oZJMOTtTZbM28CcgHwme+5YMHB4BGM4qQP0HfPwDF0EuGEBlo+H0pEV9f483tSQSnUyMovZYKe4d/uFf9WIrlFI+EiCRF1k6V+isqnF9Gl6JW9xSyxgDYpGLMgdt96GL6mbQQiUZOOXGhMD+vl5rInajlehjZZGt1ECIsuQdSeXdUmHFSgMoalbNHHh8DSJadqv8YiN/mr/OT+R+bD/rQZZmqQk9h8TQnvKNmY+7eIsJrWQVW2bUBrOp51QTz6w+IlL5FPjjIxXwZM3qQN0vs5HkMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUeE5mzp6Rm7SX+mjQoXTgOCsvmrOG8rMPuvfxlIysg=;
 b=g+MgREgvsXnObmGvwFx3kd/osVPMwP+sgKtuXq1MeEoQo33QEqUTkxll+aHYUHej84FAQoDPE9RfC5R+VpIFBVczhEOGZHYmjLWV8qcdKgHj+roYIjPjD9lGW5r8Kz0Dw22WegYQ8RDFuTMvvGatukGyvgdE2iufq67MM4Rn0ME=
Received: from BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46) by
 LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 05:11:47 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::fc) by BYAPR01CA0033.outlook.office365.com
 (2603:10b6:a02:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 05:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 05:11:46 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 00:11:43 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Sibi
 Sankar" <quic_sibis@quicinc.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Dhruva Gole <d-gole@ti.com>, Yipeng Zou
	<zouyipeng@huawei.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq: Allow drivers to advertise boost enabled
In-Reply-To: <20240626041135.1559-2-mario.limonciello@amd.com>
References: <20240626041135.1559-1-mario.limonciello@amd.com>
 <20240626041135.1559-2-mario.limonciello@amd.com>
Date: Wed, 26 Jun 2024 10:41:35 +0530
Message-ID: <87bk3o2sqg.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b7f1bf-8c86-4bca-67aa-08dc959e7a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUM23cn9ThTnx1cxSwMhywYTbQhZigq6HDAMBKNm49ULv0fexu30uU7kzViY?=
 =?us-ascii?Q?xZr3rrNSAmK/j26Dzb+p4kmfQEb78/iXq6s7DBqMbwIDhmgeKBgxxCwQqG3S?=
 =?us-ascii?Q?djXjW3LbA/IUsZBY/4ETsis6iUgSZ0W6lLWfGdNq1FyVqWCtYS6KesIcnz28?=
 =?us-ascii?Q?lP6yjSbsBTAABPzw5lBzkXMzVwKLYJN6PGNHqKPPsznD5D+eRG5+S1/zTc20?=
 =?us-ascii?Q?GrG6mreihuAq4GOEK8bRQXO7emV9rc7WutVRqOF+fdtnRiCDPhdAejxZTuAI?=
 =?us-ascii?Q?3tMduySHwuQkEu8vI3/L8y2TsBXeAKkH0S1R2OqHVFotplf2J03QR2+GBLk3?=
 =?us-ascii?Q?Wad8Qy/slNJzt+KnAD04ROejcCiurQorPqWDd4j3Mc+SRLiz2migDO+uvdVy?=
 =?us-ascii?Q?2EygcSB/e1J3qppXlg1WxXp4tBmNvdi/d1P+npibQOdS4cATWWRE4SGugtB0?=
 =?us-ascii?Q?vzK44aje0pN+4l7qLnNXrZcjpLDpkT3ua02V1dUCJ8ZyZEV1wuw1atjWvQab?=
 =?us-ascii?Q?3EZa9tcx9kFcX+KT3GQXCbLuLPzlscUs6m7WWGykx4E4BqRXdndVdtS3U/fL?=
 =?us-ascii?Q?jvgFFsvsB/+5JrzioaASlesL6SFY1vzJX3lAWka+jLn+69bvLw9yRM/N44K/?=
 =?us-ascii?Q?IHq28b6uS8lKfj3aKFnDLVuXCe9SqZk4BUgraNX92uqGi4Xko8/SR727LUs8?=
 =?us-ascii?Q?hXuHxAi6NQTpDtxOs+BYokz+fIrKljc9sG42tgS/5PYkujAN5wsbB1dKsUsH?=
 =?us-ascii?Q?d550+61t3kcqXgHXRS+Mqep3IEQyyoOPIHDzbuMBDEYJIMF4ntZ8YCmBPuNX?=
 =?us-ascii?Q?QzHZOKe0trwkRYkprFCl50gGvewomAC7WsWXVRswLdfpS/xcWLO6FbQBnkhL?=
 =?us-ascii?Q?2xjQAWz2mcaePzpWOFTZDd5uXlvPBAj4nLJt/LkoA5pdItlmR1RcdJRmbKFu?=
 =?us-ascii?Q?hHYoXEEPgmaO1SxaOv68ZTIa/SUYR4Oh1pKcIjgQhzHYarUzVjRI9oD/BAOr?=
 =?us-ascii?Q?s3xa0IYIXoKQNQrGCv+xhIZDndjKRwg19FKj5Ewd83JBObe9xZfg2PaNEIHH?=
 =?us-ascii?Q?nD0BUwPDRoqQvUzuVkJKA+r94pwBwCyFJUAUv9wPyKNI4CvMhQzorfyoLNG7?=
 =?us-ascii?Q?fbf5CQq94ZtoeYDMkpTKyUbnLeYhkgqn5SgfTUzD7PKIKusFfK+DC2P8ubsM?=
 =?us-ascii?Q?YOLnweArjasMMMWm628IT18DBjkU7edG5sK8uTX4vJk/KdvixyEm5HUxdAp1?=
 =?us-ascii?Q?wu6CILLG7ClB+xBGnzI9N1IrySalrMPWdIqRbIcs5/+yj+vqAQPTc90DD9bn?=
 =?us-ascii?Q?4xDiJIz8ZY8UtSuXbSgV8PfrQ4F+49StQhu6UaCNirdeN4tmvYbh51EuMPsE?=
 =?us-ascii?Q?hA9DD2Mt29m9cLvijd+jo0BVvSqOFbCIiuiiYVstivFX+qMo6ycwApTonX9P?=
 =?us-ascii?Q?c5r3dahciXiD61P03gEEF95xC0mJchkF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:11:46.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b7f1bf-8c86-4bca-67aa-08dc959e7a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

Mario Limonciello <mario.limonciello@amd.com> writes:

> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
>
> This is because policy_has_boost_freq() assumes that there is a frequency
> table set up by the driver and that the boost frequencies are advertised
> in that table. This assumption doesn't work for acpi-cpufreq or
> amd-pstate. Only use this check to enable boost if it's not already
> enabled instead of also disabling it if alreayd enabled.
>
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> v14->v15:
>  * Use Viresh's suggestion

This will work. The drivers that don't depend onn
policy_has_boost_freq() should ensure that they keep policy->enabled
in-sync with cpufreq_boost_enabled().

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..270ea04fb616 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>  		}
>  
>  		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
> +			policy->boost_enabled = true;
>  
>  		/*
>  		 * The initialization has succeeded and the policy is online.
> -- 
> 2.43.0

