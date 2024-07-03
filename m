Return-Path: <linux-pm+bounces-10498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC1925601
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E36AB21EAC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170813AA39;
	Wed,  3 Jul 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2et96idB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019363BBEA;
	Wed,  3 Jul 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997122; cv=fail; b=uv0jkg6McoWPWCWvNU3VnYtEF3OFZD7wf2Khwy+buAmpAQW8TZSphGxGM2kNO68jugkZBThA0RviNBbAmjqUhL3pEiN/YVi9m7DUjXKrZ+XSk9uN8tRQBpvBwt/TCK1dakTx3ZwHXQ/KoiM43+te0W+rPpP/b2ZIDJFenvzLnvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997122; c=relaxed/simple;
	bh=90JiEur5nM+DgrWJYF0Kq5zVVcSPyvy5pe9VagntI7A=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=by4k3PVaR86nNPFG2CqvzyTmxs46izDOFq61Rm2h7mlCO9w0RuS1taksMRu9nJkBwzGf9J5XTXaA2WNjoLFbIqYPWSMqXzvoPK8KQSRp3JbVaVTQYHgAXgWQ2Fzc42xQvBXx5uSG6HBeNrx2qM3dAZIInu3/iJh2yiGH+69BKXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2et96idB; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2UQs5Loz+0ptDSKa4BBT0qPAip4gZuLiDPF6S4ky/aTlV8OdgrZpLhMMKnbBuS9kxmmOpQ470z8Kj6dCN1xqQj58yN7E3crtygFf53rQa5zIEKRjDF7owQ60REn/j/CZTzljaMTYhIsySSbv+Xy0sf98xpUlK8HKrva28+Lp5/KC1Geq/Vl8M3au9VMQ2kWLiZi/6P3JKH14ibNW9tMBTMGUFKgjKJUv6bz1/5ru2t1rLzzo4/BmSFaHxCWZlFJ4Zn8TD1ukV7MIsMgJKDNUEQavynrAGhzyO3koF8+URiaZZfIjx2XSl9HOBGt9KYO+xIQF1utVk92Szg366ROew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vrnGD2tShGaSUDNTeQvKVcL+lLjEsdCb4SMCOYQwpY=;
 b=CdWiP1DgvTd0frYhHk6AfiKmSTdNLSvFSposmlh3Bfqe2+a+DNQa/6XcQcXzpWSamXv8WfzqRUCa3HC1LWTb1Ixi/VVvT8pseMLv7pBx0pDiVe33C73Ksmw8Wpt6uHGct+98RyzpQpYG9qNnyoYTxb57g2xn6SPq5MkHieCwIXuUI2+n9AcwVd4Xe7Q9VeMjVcYz0y4SZR7cb4sFj0bmMMg5yqvEi+s1tvxnR8QRd3t2VFfBfUWAh4k0I+ye6n09rWafAxQrKqpEJ7azJhOcMOKQhhI8uS6o4MgY+Fod1gWTkQdx9c41itnkIzSa/MNvD060Ui9sOQtaFSB62r2ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vrnGD2tShGaSUDNTeQvKVcL+lLjEsdCb4SMCOYQwpY=;
 b=2et96idBwiE6r9bWN3c3KUl/P7ytKaQc//2vRqOZRVgmjz6l/tbBfYQIyCf6ppHf8SQKJm2UEM1hs6HLMnNo8GMNrFXm7zq6n1JXxoZ68aly32f4MSXMCV3WNChPUX7EMMYSVnZ1h4HDSotK8/tkLx8O+bFNbjPnc35zHLaCCdA=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 08:58:35 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::c3) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22 via Frontend
 Transport; Wed, 3 Jul 2024 08:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 08:58:35 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:58:32 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Meng Li <li.meng@amd.com>, Perry Yuan <perry.yuan@amd.com>, "open list:AMD
 PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate-ut: Don't fail boost test case
 if CPB isn't supported
In-Reply-To: <20240702171515.6780-2-mario.limonciello@amd.com>
References: <20240702171515.6780-1-mario.limonciello@amd.com>
 <20240702171515.6780-2-mario.limonciello@amd.com>
Date: Wed, 3 Jul 2024 14:28:20 +0530
Message-ID: <87jzi2rgwj.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 199a00a6-2cd1-40e2-ea6c-08dc9b3e5259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?14WXI8dvk6Rthmy+sxVSF4u3Vri9KLmbKHC3iR3g3d0+fr8ZParO+pW/XRim?=
 =?us-ascii?Q?MH9N+gr3GGnhr6cMdM3wVvK3Mrwll5B1ZnY/QRdYDrspeUosY9bSYWz6q897?=
 =?us-ascii?Q?YX+2QlKeL3YHx+Lc/hTH/WDJVuXXFp5AKYs7Q2+XiyPpSZi7J8CyBJ/YXzBA?=
 =?us-ascii?Q?FpxpoE0gpeWnmN1EInMRpJtJrFRl/lgBntBUm/mER2RixSs1rtXO5ZtEYwib?=
 =?us-ascii?Q?pC/+SoGKGMM7UEEohTeGUINxdCDE+URkzKCVBYiSdffJ8s0G3suPNR4qSZIA?=
 =?us-ascii?Q?bwe0G1fDQwqNbYbBFFu0kzyoT+3hjHRa0Ag/o58rjYNsCSFKFPOyKnXRbA9b?=
 =?us-ascii?Q?Afclj0GroSHecs8gOBkcwywEOfv6WvUTA/e9pmL3MGgj3jPLTNNlg0VnoQBD?=
 =?us-ascii?Q?gQs901hcQ0IuMtrQfgsf+Y+BADRZHcBS65EBFRYTV6kGSwVdIfZEn+edGkRy?=
 =?us-ascii?Q?caL8N0mAmrY/erHr7J/OhaQVcQAXUpQ90OolQZm4jrDem2bnEiYHKV4HfpMG?=
 =?us-ascii?Q?sngOfiBvctLcEUu6Q1OVxZPa7K6A2T3PKe7MGqzSZj4DL+Ua96P7UqkFX8AG?=
 =?us-ascii?Q?1sRZZRw1QId10/gTRTvJg9m66/deWIWvCIU/X+HMj61jRA0xTbsVzk4UGEIV?=
 =?us-ascii?Q?5GpqNXHf+aGinaXQPkd266oNgcfMtA8yjQjMXy2LrQjbwG4VvURozWvoBHhg?=
 =?us-ascii?Q?Yu+/xaEN1OSXzy0Gf8SjJvcfl2zPiYTgLCozdCQj1ItZvdGpDSlhyU6/ZzEo?=
 =?us-ascii?Q?8bs+4e7CGSJgOEVVyO5szOiDxE6E5woNgzDg80rzcks5VJrF11r1PRZqNVSZ?=
 =?us-ascii?Q?KXic1qI1BgpIbYi5KRbg3UV0a/NUthQ1GqMYmFkA0b3o6vXKLVi8cG5nCMz8?=
 =?us-ascii?Q?sMw/LhZ6whLqnYKe+oVEYmtOwin6lCNcMXPuEBxxZuHT521j45tqxDHWJCyB?=
 =?us-ascii?Q?V13MuSVpw9tvLM4C/1GlKCCNMnuUxBslZeYlgcvmrYwtL2Auce2AJXCM363C?=
 =?us-ascii?Q?NLCiOgcAfULFX80g1oNZH2818zpbOFeRp7McGajA3pL1PQBZzvMU4jRZ0J8M?=
 =?us-ascii?Q?pR5UOC+WnU7cJ5UXqwwbfmnMCe1hyMR8F/bmoGfTzyo74hufcqVDgL5QqcgW?=
 =?us-ascii?Q?WaYhLx9P/xQmft5hsF+oRqP4BY4T7hGKdU/+0Ce1od+QoOh8E7lSDhFLTPBq?=
 =?us-ascii?Q?xolzgIcd+ohZjxetsoYqB0PDhx/zn4ovimO+G6xK1sXy3VWtNVrgdOw+H+ej?=
 =?us-ascii?Q?dGScykfLIMd/xPwC8LIMM99QtMnK4yx/r/NuwDNKUKouulhsnjRvse2+VIbK?=
 =?us-ascii?Q?gAF9/KBYzxWvpx9vsvzpvPGKzHCxDalgTz9Kpr3P8AqnRw2DFfdcTD8aADAn?=
 =?us-ascii?Q?EEitKu2/L0RchIaGR6qOXYi/SGnEBvWY6LMe6X/XAkYtM0hzPFqg1xJ5oShx?=
 =?us-ascii?Q?AebKB3zIMDVGxqvAtQkKEv+esmn+J2dJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 08:58:35.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199a00a6-2cd1-40e2-ea6c-08dc9b3e5259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004

Hello Mario,

Mario Limonciello <mario.limonciello@amd.com> writes:

> cpudata->boost_supported will only be configured when a CPU actually
> supports core performance boost. Add an extra guard into the check
> to ensure it only runs when CPB is present.
>
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index b7318669485e..b011c729fcba 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -232,21 +232,21 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			goto skip_test;
>  		}
>  
> -		if (cpudata->boost_supported) {
> -			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == nominal_freq_khz))
> -				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -			else {
> +		if (cpu_feature_enabled(X86_FEATURE_CPB)) {
> +			if (!cpudata->boost_supported) {
> +				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +				pr_err("%s cpu%d must support boost!\n", __func__, cpu);
> +				goto skip_test;
> +			}
> +			if ((policy->max != cpudata->max_freq) &&
> +			    (policy->max != nominal_freq_khz)) {

Writing a different value into
/sys/devices/system/cpu/cpuX/cpufreq/scaling_max_freq, updates the
policy->max for cpuX.

So if a user runs this test case after someone has changed the
scaling_max_freq, the test case will fail. While this is not due to your
patch, I wonder if this is valid test-case.

>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
>  					nominal_freq_khz);
>  				goto skip_test;
>  			}
> -		} else {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> -			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
> -			goto skip_test;
> +			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  		}
>  		cpufreq_cpu_put(policy);
>  	}
> -- 
> 2.43.0
--
Thanks and Regards
gautham.

