Return-Path: <linux-pm+bounces-10499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD1092560B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D999CB23335
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFF13C8EE;
	Wed,  3 Jul 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wUFFz+hy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EA8F58;
	Wed,  3 Jul 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997209; cv=fail; b=Soi4Ey8wbZD0pk+5PfbxhVQ5VGg/mn2xJ4dzhSsJZ5JA73ZZ23erOkjyBOyXi7NcjWB2xLPMX6mMGLAwLJIgKaH1JniVsllcugHL2a31vvjrOHc7MgbKLKsvJ7rEb2kdWHXe0XhAvg/3zHbkrwYDjC2hEBo9A2sHkUeAMD51ZGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997209; c=relaxed/simple;
	bh=NuFnVDQri/lHoHx/14dFKG5q0qdkMDiTKT7f80RGVBc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGnv1XsS6B/HnHp9e8zsW2g0bbjzOD4lX7iSFZrr2aZljPLwH2mZfb+6ueLFKvShd83y4+iTiMZYgO7wO4flxBSuxwqRUfRgPLTH+8MEEnpuEmPo4dfIQUWb+9j2duc2s0N4gp89klC/Od653h/Oti9j1p+voQwYMNmxLVKua2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wUFFz+hy; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbDmvKiJbizdZsoD35EMU3+4Av427Ixgx4zuR1kR2g0Mwyg0NEhsB7AT3CDN+4yXCVlFOc10sKwF2CCSzF91PH+/rPiKZ7i0Nc1CO3bg0A9xi1btxCLiRb+J3OfbYGjNKwoZDeWeemx/GoNRk0ezgEl6M5ddp/q/s+ppJ9W0GPETbXbP6DkGo4/9xnRdApFXBQSn9/9amaRk4wZI9sxRoabIIlUbNohsO2GXoEuv0Rcocf/Za+TnGdZfNYFHgcTxoxG9lo+MS/4dMnBO2SLPBqATY6R3N0pRXuQScPUfnTuV7CpB+xqARxkcD44aXF7T2KyknFVpus20MtEudQPMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuVy20ey0baBbiPerAXIJXubohA1j/+DYdB9MNKgrzk=;
 b=eumkw6PCc9T043Nf0wMNbU1BBWHugeN1xzGnFaU30En1gPmHOjo/M253EQgMIey39oKNzlBDQOHUm9VqbehCUne6b74+BttP6KrIuhTo1E49PxOAMC2rcfdcNgK6OLTDgDj4dg87+5ncZe82/ZHTuwy5+Ru401i5KcDGxP8jk12vSmK8uRJGAbJMg5GpdpJ5AYcac/sFRceQOkQEaUOO5xc2VuMEVJuCPa+5MQUbVXAmYgtCxgq92rCcFB4DaEhIKfBMVf85igD2KaT6GbQyo0w8aiF/uSV8C7N/1XGxsa7mzYn3Bt6rRauzUT9oz/zyGxun4VzgOscfj1z+d9O/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuVy20ey0baBbiPerAXIJXubohA1j/+DYdB9MNKgrzk=;
 b=wUFFz+hyKdvVbpt5UrCFCJDcCE3fRW5N5QAhUNde25Z17c2qjqkPPCtfGTsv6vsoq7d7eRAbzgkstr/W1vgZcILlZnAFCOMfWFlhjaBPbP9g8lQJUzBntPqrFY24B4CGRN5Vki1c6oU9Ut+b6ZTPZ91O1cauKgIbm045UW/85A0=
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 09:00:05 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::df) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 09:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 09:00:04 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:59:59 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Meng Li <li.meng@amd.com>, Perry Yuan <perry.yuan@amd.com>, "open list:AMD
 PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate-ut: Don't check for highest perf
 matching on prefcore
In-Reply-To: <20240702171515.6780-1-mario.limonciello@amd.com>
References: <20240702171515.6780-1-mario.limonciello@amd.com>
Date: Wed, 3 Jul 2024 14:29:57 +0530
Message-ID: <87h6d6rgtu.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4748d5e9-de62-4184-1d9c-08dc9b3e87be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdDzFwJVnMKWS4Y5qK5DShGSuOowsAzcVAHFx7Pl1TLbOoC+YrDBFhxn/ypQ?=
 =?us-ascii?Q?zZY6D8iqFS43Bia50NTTFGzGBBPYN7Nra8HNBtxWcxjZzwnt3S3+IeSmliwP?=
 =?us-ascii?Q?a74ZyTau0eoYarLHGHLwLfEH9Iiks8PfLZxRJhNccIQPQHs121aGgjxynxKe?=
 =?us-ascii?Q?ykm4BTBM2q1/Nn7Cp5faM2YJTq0Ev3qzLQvh4Y08znUQTRlsSnuTOxhW3K84?=
 =?us-ascii?Q?cx/X6Lx1r4XOTYn99v7l0mqwD4DFsfL9qLWyfgWVZ8niOLZ9MrJ8iiVTxlwf?=
 =?us-ascii?Q?lNHKiFmtZDtNQN3YqT/nh0Iteeiw7IXOGIrTMgCbEsh+VzQYlq9WKuo8tbF/?=
 =?us-ascii?Q?AAwe+LSWul76jBfq7fEImw6UOvwgsFziTn9B60u1fFKQ8LwXqBVCQQFGpQSb?=
 =?us-ascii?Q?sYnzf4Fn4hQylQprxmPCj+tYYNvH4pOBFREZqqOcnay7QDkl0hrP7p8lEzQ6?=
 =?us-ascii?Q?fSz9Im5QEpbu4wIHfpGKUc8Y3+SwG5XmyX4PYWk/SdV5teRC+lFFtXb/H6jD?=
 =?us-ascii?Q?aUiu+pulhuI8U7Fhj/uMgIpMxwYwHZtACAsJxi2bwuF5UtEqrcq5Jaxy/qAt?=
 =?us-ascii?Q?YCddASSGzyB7oM2/ZIXxins023COaEafjd0piUE6bZkc7JD4ixJtkWn0apOu?=
 =?us-ascii?Q?Z9xzIv7FQt8AKdXub7nTz7zyrwZgloSIwNSMtAPt6XqWuKvnRVptBCybHYJ4?=
 =?us-ascii?Q?effqf26y7IM1vyJYjGcgjX7f1wGQpeUB6lKvTW+u4NaFTE30I2VbNaeNOzTt?=
 =?us-ascii?Q?STzp/5AJz4uHutJ8cv8kw8Aj95c4oruGrXBGCQnNPwfrxZkEEwLntPFnQCLe?=
 =?us-ascii?Q?N7W03v3aPrJMEMY0GA0fGNUSELAPVfEwDTG4lClsKbD1r9/OF2+CB5+EZtih?=
 =?us-ascii?Q?iWtPDXt1UimpB7heiB4sIZk2aORHgfArl71ZACJPTc+xsljR9LfXL195f9MW?=
 =?us-ascii?Q?1vrNfueoo2POEcV28+B+PT3Lf8quPMpGPIZJHJeZAZsmEHsyRoMUxvDBN7fK?=
 =?us-ascii?Q?rOmgRTeMp6svgI3/L/fEAv6EinBqdw0Z1888Bb+MF/lRGVZnhze35V05XO77?=
 =?us-ascii?Q?6je8X0PlJy6ukN81Tj6bq8NMqikNqC+VoaxEJ+rdHw54ESoHlaBrCimKZYY4?=
 =?us-ascii?Q?58jFuLdeWLlSGvjicaTCSTKpIA5YrXd30NtQMFa7rZ6gi4cOJD4+peMpDv3B?=
 =?us-ascii?Q?NK5O7CZ/+Naw6rGg8bHu8L3GzC+RNYsQap/w6YqtPm5TjTahb4+ATgZxjU8Z?=
 =?us-ascii?Q?q1qIJCM+Y71so4kMZD+B2BtXYLYDzfytVA5+ZyzR6ivYbDYPWcH4w/ht2q3N?=
 =?us-ascii?Q?2a4HgjvyL+5cbpImTv1C6SSlEoa1FmxResqn5wPZCSUAwzMHLJkihaOTBiTy?=
 =?us-ascii?Q?0GNuQ0YLRZtu38kj21dyZobxO/RhMGPeRQ5EY7FCxv50aYYhHx/OfQ85Uy6O?=
 =?us-ascii?Q?Hd63Va4uBcuzYpSocIi9ftiY0zFj1i/N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:00:04.6179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4748d5e9-de62-4184-1d9c-08dc9b3e87be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

Mario Limonciello <mario.limonciello@amd.com> writes:

> If a system is using preferred cores the highest perf will be inconsistent
> as it can change from system events.
>
> Skip the checks for it.
>
> Fixes: e571a5e2068e ("cpufreq: amd-pstate: Update amd-pstate preferred core ranking dynamically")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 66b73c308ce6..b7318669485e 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -160,14 +160,17 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>  		}
>  
> -		if ((highest_perf != READ_ONCE(cpudata->highest_perf)) ||
> -			(nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> +		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
> +			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
> +				__func__, cpu, highest_perf, cpudata->highest_perf);
> +			goto skip_test;
> +		}
> +		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
>  			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
>  			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> -			pr_err("%s cpu%d highest=%d %d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
> -				__func__, cpu, highest_perf, cpudata->highest_perf,
> -				nominal_perf, cpudata->nominal_perf,
> +			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
> +				__func__, cpu, nominal_perf, cpudata->nominal_perf,
>  				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
>  				lowest_perf, cpudata->lowest_perf);
>  			goto skip_test;
> -- 
> 2.43.0

