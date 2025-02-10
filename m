Return-Path: <linux-pm+bounces-21671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1210A2EA48
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415D4163AC3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1971CD1FD;
	Mon, 10 Feb 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmoM+2G0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810B1CAA88;
	Mon, 10 Feb 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185131; cv=fail; b=qDYqGB1668FPY7Xgzwlclloc/TP9J4CjPx0eekB2iOCwWCG8W7n2c7HEJgX/VpOGz9Z/3blLkZuTS6xUjCWtRNbzU0aLxmY5IwWIB2AGdMxCkSlLB4LM8+1ql7Wt7+Umr9RKNPk4HIvIZNA2CWuSCthUX4zSg2vG/EmDP3Rq9/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185131; c=relaxed/simple;
	bh=iYq0ZatOfNUK5T55ECN8U8IDPxsNORH4888bzOO0W9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqIS2Rx76RPGs9j0tPQ6Kd4tCVZGOmMIHhwsQWXVce6L50I7PjzB1NUaqLxQEDRXJOJnhyvTy0eoJQJa3o/e3Sny3InsVGCccJt2JjP9pXzwJA9X1GGjlTGeji9pNIgSRKz4ihdBByq0NSXspCrh4CW8VKVbXw4UrGg9xK1m6DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmoM+2G0; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQeyLaWNrWPryVPjGb6Y0qTkWCgWAvdlYWkHglATfndfinUZgR5BYh3I5U8bux2U2C4OzztSV2iFi4f9LuRaaJ2VfQ2FJs3Xfl19WaUdoDuzREkfQLrc8n2IUBWjOFtdoQJVcp9sAcFR0u7iTFQUkXPP47rEtUAZ3McB9Vy7cA5+e+hP1ZPnBKJFYhDwpmXoX/WVN6ZMhOxC33wtaFOCvpWKSe7R58z3lJyQyOhTERZD3Yr/insffKqGnRa8KF5sP+GxB1xAjEHVc6xrIAREX4zfSqbKHbu3Wdox3md1TXSHcQ9OxtPWG0WCRtIcUcBNgBOnDEjn6YQnggk0YcyFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4bXCtMilVFruXw55IcbgSYnX9Hj3cCNvWrbKz8ahp8=;
 b=deuElKWRA2tp/N+lgz71ZWyyw2OPPPPMIRqOHKqidy95dy1zzmEf1NY8Qtw3DGlUOMqkQRpSmuERo9U9p2ra+1E8samLql0BtVpgufZhk4mDWQZ39D4E+notIoQ4+YuY8xWel8lwbSaTZdxSgiRL03y7Mp2SPrsbwNQMe+uKwja2ols/gEllG4sHFLyaErtIweQQEeyS/j5iFwybarhpu9fKupjrO1fC6DCkE3EEauKYADosRpKt9K/9VmE5N64nYAfD8NHCwgTWI/qXEziYRdXFmzZi9o4IBPkzuv9ybSAp3Grp2wPgGZwcj7tdnhF/IorN1AtYFRmoYjDA4+e4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4bXCtMilVFruXw55IcbgSYnX9Hj3cCNvWrbKz8ahp8=;
 b=nmoM+2G0kd/af29HqBXT9x4YAkKD6gu1kc1/vzxzI6xqISKJdsFfNWXWOdDpHnqq/f7YpYF7ffPhrAuY0jHdDczfvTa9E4XWVX95r09d9tlDdxmj5WzhxMxcyZYtaKTX3q2Zk6lAo1t0GItrobSpuK4gqLbgvugC8kVLI8h6Uvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 10:58:48 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:58:48 +0000
Date: Mon, 10 Feb 2025 16:28:39 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/12] cpufreq/amd-pstate: Add missing NULL ptr check in
 amd_pstate_update
Message-ID: <Z6nb3xGSiSfXzIN3@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-11-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-11-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd3f2e3-d969-47b1-af01-08dd49c1e512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mSa5vBaqMW6IaF4oEmTiORUl3VTtFH4jHTN8IsELmMO7cxOQJpMZM+/LTpjn?=
 =?us-ascii?Q?8Zvdp4bR0ho8p+11qU4NWjFc6+NlwMGV4gBdIgUJCPc2cElqSjE2NJlanmf6?=
 =?us-ascii?Q?xSvslIDwLS0KmPQ691doY3xk2mLFd9HM5jv5XH5oF9rdhNq4FjXqFPKV+BzV?=
 =?us-ascii?Q?lBmPzkd+btIuLkUytIL5tqL7hBPIB0Fm1dVl/5Wg95fn2aOtWG182tZA0tWu?=
 =?us-ascii?Q?J3JyOjyr5JZFdgDAoJ7YTh+aU8tmnbDGZi4lrerQn9QGh8HW5WWTGAATH5ap?=
 =?us-ascii?Q?40X5p6mB8HQ44oR3yNPAujiK/lYTrnUSgoW1SBMGL+OK14HN1yHPdt9WM18v?=
 =?us-ascii?Q?uc7Az4D6CX3maTW+v2kmNxEQPlSzIdc1H+fK0UrpJy7IZ8MaVtObe/Zh6pTq?=
 =?us-ascii?Q?vOSToLBZmly8lxBWt1JXhinFw8a9QoiVRiVmm7QBLh35juTpRYDFUjZ8EqYW?=
 =?us-ascii?Q?Ij0sOlW7EifwKgB6e0W8P7qDX6X68LSPdbNwobJA1kpFGsvWBQZGuH536BCB?=
 =?us-ascii?Q?S7WlBKv8TDa+Ex8LvPO+bGxAAt9VHgC4OISh3dF1jVXgkvT2VB2M8op6CQee?=
 =?us-ascii?Q?quXRoWJZrB7hdBYWdERf1NGWf+nxVY+ngp9KJxlr9aKFG9SwyygqKO2Y/6Mt?=
 =?us-ascii?Q?e2mm8xI45SdCMXCvJBr9GbNCABDwczJoBrgW60IgiT/JzbyDpujlpVBhMOgQ?=
 =?us-ascii?Q?MJfuIKh6VZVRcgLHB8gIXkfHWELCpJPyyhjsjATKFDOF6AKqQxGq4q5AFM9t?=
 =?us-ascii?Q?C+XvSl76GYkTDV49SKxeLgPXN1eQk1b/s/lOVroKozi8p7g9W/tsW5IP7wOp?=
 =?us-ascii?Q?x2fPcLwfRiJQ60kWLSnqjYtjPV9Ueow2deC+nxxcYrbbCyx5b/oKN3yqxjpY?=
 =?us-ascii?Q?j4PIEHxFIQIEldlZHVJBVwHEus/OpjcIP9t+4oROxL6eFmZw5PFtt92nTOvl?=
 =?us-ascii?Q?NO4SLfQR3Ud9cadHluDf9L4NSjZUVELRhcC10CAIJjLlmv7ogXFxushFXhSL?=
 =?us-ascii?Q?p4GofFNOt8NdZUDMOh65BGuhBvUR5wESHppzcwKWUGSIiMiupMHnHhL91pox?=
 =?us-ascii?Q?GiqlVDrHsUGkleyP/HAF53y3PW+3fM64rcXimaZIpnl9me7AibySSLlFLkbc?=
 =?us-ascii?Q?NgyytAQky+rsU1dwTcJgNPS6d+ODB6rxAR6gdf8xB4dtIjY03uiB4VFuzB1F?=
 =?us-ascii?Q?9uqBqunCEzdW05GXU4j49PgOiCPGoJEA0lH7vfaepWMuZF5Z0VITSTWaJ92Y?=
 =?us-ascii?Q?asu8rm42RWCn6nOz/o7zGW8d1vyESMzW4ZBZPPlh6UucW69Lhghbtt1hLP2g?=
 =?us-ascii?Q?dy9xRWlyeVD35X3+bNe4imJS09w3SpV27v9hmazWnuuS2QWZeiARonbQgF4/?=
 =?us-ascii?Q?DqofETXCcZeksGNx8VsNYUuaW1DQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/nqL/Wa/IM2+37YaYKCt8RVhg/yY8h9tNFTm3HtULBgKS5ulpCPskkkPmGi?=
 =?us-ascii?Q?0acgYJy7oOmY11mExk4hwNwm2B+pE7rfx11PlsiuKO6H92TmbjkmZicOFD+J?=
 =?us-ascii?Q?OBSG26xu8bOfwCfHS3xgoMw+RZyB2rcWSYLR0q5ulLH3Qj/2rqtla5i1iaJK?=
 =?us-ascii?Q?Xun1WtA2GAUxp/i413PajCR6QTtLdJtar1aEcieJXtDRUyb17Fb7RoO0pT9u?=
 =?us-ascii?Q?dtAfof3qvvNGLkeNk62ZNt9tgpdHGd6Zx//2QW4jFZqt2HejWE/v8gDiYNIM?=
 =?us-ascii?Q?+tG8YhtwCWznGiwxVIGL2RxXOFQ8sKd9A93HSEpIGuVQU5T8ueK7sLbjeShA?=
 =?us-ascii?Q?BdBHSY4Fyxp1139SVCT9HchHjh9SSmXAoKrMr6OaVRndAxgEMC/jBD+wnPx7?=
 =?us-ascii?Q?WHFzs1Ane1yhJ+9qVl5k1srHghU37jR9MWY07Fnx473bNGnHxgbcz0WoxnZw?=
 =?us-ascii?Q?6gfmy3OobssbfkT5E8jLMBIou6VrfbZXNOu7Ci+60tKDZaJJ8xxEnVN8Tv6b?=
 =?us-ascii?Q?7Lt4K5OD9rBfMaeCFbKMWYgfoQ+Z2gJhsVBzxfZaZtldH4a8O7lDL/XZmKOy?=
 =?us-ascii?Q?YC7QNwulEod1mUGDP8u6CIKf/mA65go/QDBtlhbQthRFTL+juaSM0wzIiGz2?=
 =?us-ascii?Q?1PW2nu62baJwapbDXjvA7EtUQw6jKDkHWwvZ4SZlmzBGBHf2hMs/OuTBobkd?=
 =?us-ascii?Q?gGpf1wutTwh1MECmXSxcYfJ/rMzGnQh0MCtIObseAzDtQXPdgHcknJY/NWtz?=
 =?us-ascii?Q?Ixo8C43snebLrKerVjBFsBkG2KC7i83aoOv2+/lddAoAmTQhfDYLeQOvknjt?=
 =?us-ascii?Q?M1Nkyrox1U8IA4DeIF5u4P5boRkwbICwCEHMo7yUVjgT6FDX8lIpEqqPGVFb?=
 =?us-ascii?Q?ICkkYbctywwi9DTz4beI3utm8rlHsrN6Z3zrIHTiWNMn8a/3bAgOqxoPtb+i?=
 =?us-ascii?Q?xhG6wIfde1OvvfUi6xvOoWlbyQ476TmeBP1Ot8+7UB4vWkRaJICad0JZYYyg?=
 =?us-ascii?Q?zqe6RipawgQn5tzoy9FDjuB9X7P9T+RPqVaDZJ5onyDvuUokqDZ/VkoGUeS8?=
 =?us-ascii?Q?PQPXVBbxSJFiVocqLM0maTC/+9v95jJrgnllUNuRhInl1T9IDbnOZTqaWtZ+?=
 =?us-ascii?Q?wqc7Du8yXoRl0HKfZZelmCwMszxVxbVI9AVocV+MO9dUsRDkzqo7L5laBPyj?=
 =?us-ascii?Q?38WrWeMcSWmCcBJT7FKoita8Wm/QUDNNSD35YCAsLnPx4ToYdusQREP+bbuN?=
 =?us-ascii?Q?nzm58PDsM2W17OPLtJ+ca8qEUPcBqVpAV9VsKcHZg1BNE7sNY6OMfqde2rt9?=
 =?us-ascii?Q?btXlSM/7UV5KUU75xefdJGekTlkSw7DK5UvPWx77gZEAEv6pHe3r4JqEzz7g?=
 =?us-ascii?Q?/T4+PNMqQWKajZENk4lGu8WkjQfd0BBxZ+YJgUYoOMYkJyq4/cFnLAgrecbN?=
 =?us-ascii?Q?WzRTZraEX/ot30EhvkoHogbDQ30GBdp2ELu1GrQj+06D/cmyjLwGIX+yiqTe?=
 =?us-ascii?Q?t2AMUDauYVCS3HEaR2zNLc2xFT5ESNotN5WqGURCrEVrkUJ7oGv57fau4z5b?=
 =?us-ascii?Q?spyjIvs2t90j8bL8opFb2H9J8rRdwsUQpLypiWcm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd3f2e3-d969-47b1-af01-08dd49c1e512
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:58:48.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b34s5vUdcJr1Xc3nD4OhfK2VuboC7jbw49bDM2eslO+wUb09DZPbhdcm21HC3s286CTqzIjKT367kVNcs1aEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

On Wed, Feb 05, 2025 at 11:25:21AM +0000, Dhananjay Ugwekar wrote:
> Check if policy is NULL before dereferencing it in amd_pstate_update.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9c939be59042..6a604f0797d9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -551,6 +551,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
>  	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
> +	if (!policy)
> +		return;
> +
>  	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>  
>  	policy->cur = perf_to_freq(cpudata, des_perf);
> -- 
> 2.34.1
> 

