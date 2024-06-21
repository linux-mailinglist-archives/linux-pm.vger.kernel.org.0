Return-Path: <linux-pm+bounces-9746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A3911F0C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24141F258F4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4216D9C4;
	Fri, 21 Jun 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="33QBSiEg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB916D4C0
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959426; cv=fail; b=JvypetP2NHZLJJMycLzykcHy/jLUq9t4hnf8tHM3qEPoeRzA1JruxfcMl6xA2gwrIZusU1+7MP2VOnGxPOoyUSd8e+XMYqYKpd5I/qNUU1+Iod5If6OfC6aKj8KUheHdd2M8YFU9KOvjKOPhutL3o+vjuE6ineOgsLZdX13Kxcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959426; c=relaxed/simple;
	bh=dKthA8amsBesC3z6VtYREu7y+LWXbyMpk0gTJ9nMhkI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijRxHZTlsKs40G9gsEkY7dyakvESkG3oOu/yJPa5Lgqle79pCn4WGdVQdGHgrjlBDPok1nCsEPEi+mj3axEO5Y6Ol8rMenabFu/JBBLUJ4DtoYDSz/LEzu+ueiLZ1V069F1f331IXtvfshqVlaZ9qv93/oWJFL5Ln1DPic7eXPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=33QBSiEg; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVX/EeKgf2Mdm+0bJhGpAI7kef8kSazvYXD6cRLa5jKzInUt0O6JjL8B6xEDI2H90HXrVyaMhNt5hhgUeJ68QFQM134yWXAS2HYkMsncIkK5E2p9ZHW1aifkrQvuTb+zqAf0CspsVWNFEUiH2nwhTCTHR9bXfORBxVsbGqwrKtL1RAERsHFBmXj7x5+OmlNUKMVin2PsFXrMhe5gK4LqWGwtOIQkdAHRm5SjUEkIpyMrjjHrDsOcD5xa1tZdDrkBwdsnkpNJ1T9vGzdC2IV3OdWPZ6nHGfLKTItEul4jVKNgVmpbDxho0rknUJf8ac6Vq3j+dsLkcdATb5QrxBRosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzILTWubIQjeboaUWx3a7EyJtca+HXYdBqdS4XiXguU=;
 b=NRsadn+hYjYfoUm7Ev1r2/qOGq/RLfFP8DK1KpgSRMQYNYuRVWt92zTPpEalL7QqTNWRpvIbqQ2r4otSGi5cRz0UClKAgOobEaL0hwH8N8ZOJszGxnibPQQ/x6XzvLFU5KNERVLlX6Ysw/mJgfYH5Oucoh34tjTc0NKjLbw9iQHRZQCb+aMun2J7y44fOdmjc0doiKHuvHD2bbEk8/yx8FWINKH6YDWmEPWWapiV9RCI2coEH2YdP/D5wZTRlfUFcLGNxT/q6YIKOnQiGTnLzpJ9xAOTmhW7eiNRlEIFtVx2ehkYgWNTlWYmvaGcZ/BDPye++v3hgyNqdrUn8KWZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzILTWubIQjeboaUWx3a7EyJtca+HXYdBqdS4XiXguU=;
 b=33QBSiEglLZw7/hOuLv1BXPT1l85uNAjrx3b8uq/aZHFpjkUfnX8+R39GyKpwSoO+ClbEVUIe3eeqzUKAlxSX3tpidgxnJhGXAhs5I1FJWWjMeCfVenAdW03TbL/lWOcWHbFnpCvJo44dgUBwaeNdYBleeDrB4tuwVsMKvqIAZM=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 08:43:43 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::aa) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 08:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 08:43:43 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 03:43:40 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Artem S . Tashkinov"
	<aros@gmx.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP
 string
In-Reply-To: <20240612145737.1618-1-mario.limonciello@amd.com>
References: <20240612145737.1618-1-mario.limonciello@amd.com>
Date: Fri, 21 Jun 2024 14:13:38 +0530
Message-ID: <877ceivg79.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 660b9e0b-1b1d-41f4-696b-08dc91ce41c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I9jAJx5DQq3q0NNMzHpquTHmz3XoIc24nIBucbi33S3qq8Se7rBw3uNddrbB?=
 =?us-ascii?Q?H+ugwWNinPYLawYnOI397L/+PtVrMys3ncvVt44yoG6Rna3MZ1PFxdoaSgy5?=
 =?us-ascii?Q?dtmgaMpU3puyG8uj0CmLVt28XYS4XqdMhrTx9QO0FmD4kUcixa15I43UV1yv?=
 =?us-ascii?Q?a9DNkWLsVcuzKdcdBf4bRdOqyuwXAt8Wc/mo1dbVz66gfJln5bOV2mbhVyC+?=
 =?us-ascii?Q?v53dK/HXu/qOWD4NgmOEsvv2l/SLSoGp8CWn3tiqiWHIPpVnp+l4WtBEmNpX?=
 =?us-ascii?Q?3uftI5DUaxr/yRUkeR+4S7Y2oP6nduAw29II9tLYjdCNbO0TDAdfPrUmCfJm?=
 =?us-ascii?Q?V6NCmTOwCByajj8w5rWH0Tdx3eumPXTty9fTMZga5IC8mzrvHBUQN/1Nv4of?=
 =?us-ascii?Q?oh0TFy+K4X92DN4xE5uXa+bl96ucGSO/k23zmXSeki1LNPk7qW0C4dhzhtLK?=
 =?us-ascii?Q?q0Af/BvUVmf9lsLDBE08zGDgScG6ZcB16VTbEkLqAU1oIwwdzaiVeWg42M10?=
 =?us-ascii?Q?XKGrib/e0/nvOW/O33LMotpiDrgngy1CTs9JnAZzmFX9CI/Bqa6VYlH2qiCW?=
 =?us-ascii?Q?PfDtmMcwk9Po5GEn/HF9YUN6oz8TyflDnIN89TunUxhXDGoEwAmKp1E7r21S?=
 =?us-ascii?Q?PHvQm/iPHr77TsPvMj3HX4Vi9ScMwcBntOAvYj5DBhql/1GISqQfEAm6fn1J?=
 =?us-ascii?Q?m+cXCws6j5ijaQpz1/Px3+BpdiGdetP2v2rXeHC5fzDHJJtJcBxtfYQaInT+?=
 =?us-ascii?Q?ICwoRH1gSvr3gCx+pHZQ53dCJXj7fv4wsz6BbFtrABPURbcnUVHGSeboTXnE?=
 =?us-ascii?Q?+YtWrKUYtslS+efn9fup8aPfXRvYvDzKk7PYISfSOFcwbz13JuIBFyGy9/TZ?=
 =?us-ascii?Q?rApnzaAZv1VcAYOrxyS9mv6cyG0Lqcw5UpcaCDM+GYS9wALTTVEMdzMOPWbj?=
 =?us-ascii?Q?I06r6ufpYoZimazsfp4wi/y8kBoJm1HJFYuQHlNYrWdqxa3Eb0YCQSBctsOt?=
 =?us-ascii?Q?JyvXoNVodCPjIwBxHasmmSOJ47DjyHIjN2Ik2mGh4y3C3wVNQpfPSTINqaiV?=
 =?us-ascii?Q?516DdDHBy/9pL9VfAf/aoWZlzrRP5Uxu2kep4Jtc94fISagpVztaY9mgbFHr?=
 =?us-ascii?Q?FBlrnBAPEfSy1UFNaQqYozOuiapGQopWHQNnmlmgft7aTCFgU6/Rz/NmF9hd?=
 =?us-ascii?Q?Q3e8SSxdMdNCitRDrf7ruxsOIYiz3nGxtuGch6DCQ8j7F5zBdD/prPlsJdoD?=
 =?us-ascii?Q?rV40aj4s8PsL4bYLua4KD6q5JPiiqPcfA8K0CQ4lXPX7ZfiluWfbK0ITE1b1?=
 =?us-ascii?Q?a2+vcsEMgxVF9FqtSFusMMOvZwSW/f5dZ1jRX7/DZetwBFp0LTU/zxwVawyh?=
 =?us-ascii?Q?iX72aH4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:43:43.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660b9e0b-1b1d-41f4-696b-08dc91ce41c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

Mario Limonciello <mario.limonciello@amd.com> writes:

> The EPP string for 'default' represents what the firmware had configured
> as the default EPP value but once a user changes EPP to another string
> they can't reset it back to 'default'.
>
> Cache the firmware EPP value and allow the user to write 'default' using
> this value.
>
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931#c61
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 8 +++-----
>  drivers/cpufreq/amd-pstate.h | 1 +
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fda8f86c90e0..5bdcdd3ea163 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -282,10 +282,8 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  	int epp = -EINVAL;
>  	int ret;
>  
> -	if (!pref_index) {
> -		pr_debug("EPP pref_index is invalid\n");
> -		return -EINVAL;
> -	}
> +	if (!pref_index)
> +		epp = cpudata->epp_default;
>  
>  	if (epp == -EINVAL)
>  		epp = epp_values[pref_index];
> @@ -1441,7 +1439,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
> +	cpudata->epp_cached = cpudata->epp_default = amd_pstate_get_epp(cpudata, 0);
>  
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index e6a28e7f4dbf..f80b33fa5d43 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>  	u32	policy;
>  	u64	cppc_cap1_cached;
>  	bool	suspended;
> +	s16	epp_default;
>  };
>  
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.43.0

