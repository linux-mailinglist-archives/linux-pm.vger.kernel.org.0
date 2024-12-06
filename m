Return-Path: <linux-pm+bounces-18672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDD9E6692
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935A5167A56
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC59191F74;
	Fri,  6 Dec 2024 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="McpA7GAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80C14B07E;
	Fri,  6 Dec 2024 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733461276; cv=fail; b=QT4zlNWCux4HVpuKJzVBc9O4sUTDVtbmjsv3/3XidxfSX6ewt1jMWu/HHUxtUZP5fHtWWSIZeFNBfsu3ZdkfFN5YXi3IfIeqlAIjKq5bhv9CNU+sDFyzmqqbeBoRvV0YvZ8cbTqQVFX4bC4PAZKYiWiKIZtNKG5NgA0FttL0MtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733461276; c=relaxed/simple;
	bh=nK+ovbMdcrNU93g5EM7TY0QtkETCPDB01PoOB4YeyDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g2FQpY3MsW1lKPTw4S4a7FMLnLtRstceGz7NYySyhqQWyxJma8633uepxG6D09WLRaB6P1SVw4zBL/sb/JCAVt87U5nWM40J8GLYtlF+76yUyIzI3qRQwSsq/oZnQ1Ii6oEW9UoVyMZvwdfOmLm7qxYcUEKDSLiv4nN42YPe+LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=McpA7GAM; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8looVfdQmdKU2R4uXDoJMdcpOlGUSuMqwFqjMvOF6q1RXGFpk5PAlEVGrVzI/WX06Sr0Qmmcn5CVmPulRNVLXCeIM0Z3IpDLbhn+BFfTzD0Hcm938REKHcyoHCrrQ5vwK5IERnDxNh5V9qy4E94p25ZPetFmowGn4h82DxpFO3h6al+hZh3GkZDJnxeaSHSYBvTujJQnM/lL4nbJ/qRSQ1dDy3dEBrlCxTpRhM6zptN+8nE9c/otdiE0Ige6Kql/0xrhvx/hVi+Txx/MIct3Qmld2UvkQmDRJHqqk73VQoaokAefDfGfzeCC6DZVdHojFZVoqfUyImH009dnJ8YzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkB+fBz2Blz48Wrs8WnOmjTKdcn7Zid2K2P0+2ZBC+w=;
 b=iyBPzxe1MIsnLQA+xD0037cel9rmdtZkmy3vHfK+Xu9aUodpEInX5UaHED2jkZsyRjxUIYZlTklcBIX2E/pl/yt9WTZqJXJ7iuVE2n9WVYQmQmiXNnumtoQj0R+tf+tb8ciiv2qYGtZ0o5ZGTnoYRFvQAzVMfWifne6Qn58nR/9bP+7G6tTg9ijV4vf1J4Sxda5zVaKyY0jFdBV49i38Mx1ffAGMdJxFWjtimRXagTCc52QXTnSBV7Z7rla5KQdRSrzoBr71XxyPiYqE7D5YoJEIRc2X6TDTADH0eNZn8iYsHajkxUrQ4CySpZH2qG01l70HBuxyMNTieCdKoKl0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkB+fBz2Blz48Wrs8WnOmjTKdcn7Zid2K2P0+2ZBC+w=;
 b=McpA7GAMj//Mxh9P/P7bmjf2XBllD73TmkhcV5Ino9j4w/BBm8wbniWxHlidZxCP0ZxYt3mNsSFy4FXNZmVqPmYdsLSjrhE8Mh1bpDsC4rURQIY2iqyNYJQoLnoqIlgFXlajhjm/YEWxBg9Qzla7jXzlSaYw+01+mNpQxJr/U3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Fri, 6 Dec 2024 05:01:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 05:01:11 +0000
Date: Fri, 6 Dec 2024 10:31:00 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq/amd-pstate: Refactor
 amd_pstate_epp_reenable() and amd_pstate_epp_offline()
Message-ID: <Z1KFDDFl3L7bHS9k@BLRRASHENOY1.amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
 <20241204144842.164178-4-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204144842.164178-4-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e9428c-531a-468c-88ca-08dd15b300d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dvemlCZGCCsLbqCNh6ZtzcZ2MDxHJlZHcYGlkoPgavNCfbkUZQdkT3I1fmd?=
 =?us-ascii?Q?TtPsdrz1a1jj4eWlh+VgXqV4gTW5PGjOPDCuhl6xJzT32qVhV7GTV+Q+zfRa?=
 =?us-ascii?Q?UBOdkW+4AN7FsAQJ1eu8GCd5VSzIQfZftcL8BScwCDRTFYkmvk6FRqY3K+/W?=
 =?us-ascii?Q?cIPYt8rzWPXaJQBSIqDzJ3EdeLD3xOrsEcRb1pc/IYeVwgJvSsQGMQn/po8k?=
 =?us-ascii?Q?hu60y+8+654fK3visPrRinplBCrEAYkkX1vwCOPBf+YPZrQ4tTRDpXRBOpQm?=
 =?us-ascii?Q?SY3Pv8B/Wn87lZ/JhBtM9QL7wDJxTTMNqi9V7PwS2M4EfyNslUN0usCtTnev?=
 =?us-ascii?Q?6TsxP2nXUw/JP0lHvP2mRqhQbQ9KuHE5dilbkgZ6ZlgOZWzbjZQHuWX/CdDO?=
 =?us-ascii?Q?QriOlwsQX9NCcwtkbfmLP24w6j8yjGtCkchL7DIygciLt+zpDVwpVYqJtUS5?=
 =?us-ascii?Q?i6JcYHK9Qn0OYEyKYtapNoOqwdDZGgqG2cW6VatoH4SN0WKi8O7Wx9ZKAs8u?=
 =?us-ascii?Q?SvaTh5HR9iz8ZtDJLxkWX70sTSArkhHedAJdLLayKGkSqCi4Ly2Q5WiPahtQ?=
 =?us-ascii?Q?vynHJ/w1TyNFulS8xdP1bPwKjK5qzqGB1f1xMS8UbhdRjTsGhYYrBrEIsjy2?=
 =?us-ascii?Q?nB2+sFGVGJQeaXV/VJjOnqRK83Q6UVeeWM6p0ePsMkl5eAEoXmPeLOrlSHTH?=
 =?us-ascii?Q?+QTebBLYWb/SSFCVvxPNbbjqFE8iHUZS3JY4sPMVmB2bUEACzBy6Q5Vy1PY1?=
 =?us-ascii?Q?gLcyCRv9GUw1bdXUd5NogdTFpWvc6AtrXMYg+30mK7o0o2XJQ1UeiShAZjvh?=
 =?us-ascii?Q?DvTDI5SxtdWT9ytYJ17Z2SAzcYR2sV1pEfVeQaFStmmBzn7l4W9fGqE0Lt+L?=
 =?us-ascii?Q?9HaHWAujs5LcW5UyjVBegoPH+NLOywr/jxKfx8R4P9716FPC1Ms8mXKhri14?=
 =?us-ascii?Q?hk6RReUy/yqfzaE4TmVn1WhPTu/dVdLN/at1+3WdH73IZO7KGyomswfhrbm+?=
 =?us-ascii?Q?AKiBZ4tLpUywQqvA9bIOk3ptZL2+Tcjzv8D805gHve2iJI8mlH1oB8vm2bj9?=
 =?us-ascii?Q?3ITilhM5LpVqJzt8N6ziILFch/b74nH7MWMbf0YUdmoYxf8B3QrYQDM+ZuoZ?=
 =?us-ascii?Q?QvEr4WYwAw09W/DRDvZ2L4jcS5TYAXhGwS5vJYCl+HkqU98cS1fMMNVQLQHJ?=
 =?us-ascii?Q?Hvt+IYh8spjJ9NI480PvCaFBlMCve1jPw8bnYlafdFHrQ/IYxJppi/JSnvLo?=
 =?us-ascii?Q?nmLX6YBr7JDqVXEcOWt149IQ/Bqi1DYvz9BAXlO8mCtL5yVt2TLpjYTDDfBx?=
 =?us-ascii?Q?Fl9B1b5J+UrgSLHnhRKLGnJUMRLf7pOwCX4mjURggonloQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMhmkiBeeIJDwg2J1wQX2S5zaGA76HOoTaT6Mq5Tuk0njKL+1ggF4mx5+BBD?=
 =?us-ascii?Q?ABAHFYXQbSkfCkvNZFBBAJSxC9S/mQ6e6j8VwavRPnx3hd0OCrgZZftnXbzj?=
 =?us-ascii?Q?hH5skW52KkW1PKTkpgp40u+R/w6O+l3ONHIeqdJDMtMSOgWXlxMDuIug3kzf?=
 =?us-ascii?Q?c9TBA2xhTmLBE59bGIq5+tGGZitmqVkFP7A762UVkHTXWpWsdrmgtDaNVZJI?=
 =?us-ascii?Q?Ekb5ZetsowVEMAsRY5G6xzcndFX0V5JyX9bB2Ac9Mg4ukp5ychC3pTOX1vNz?=
 =?us-ascii?Q?wIGeZPgeOAnYSjXyUeQdYutwLYEZP1N1Yk1BcRrxuER4sezKyv8mfzY5T+yI?=
 =?us-ascii?Q?8Es82tasLklMGYhQyqfMjAPWiGf6mFRda0NkmQ4CFFTGoQQYVsuQyPONC4qj?=
 =?us-ascii?Q?f+B32lehTUQNMlXAM/n5/8p/Pro8PjyKb8Q4jy628cKp22SHljIFmViQfVxW?=
 =?us-ascii?Q?vx2stdWPW+e+juGWWW5W62nR1/qTBKk94nTkoYsBR+el6ZxBzoPxzjFLkc5z?=
 =?us-ascii?Q?7A5Cx0ImjZFAdXCX4HdlMcJNdxnjf/lQSk7j7169M9vQYYVuLLCEgWpag0j8?=
 =?us-ascii?Q?eobnXb8IZ9yVlh2Vh75LZXrsAXivAaqXa1W/O/Uoga+S+g9OFm3xYaGgo6Oe?=
 =?us-ascii?Q?JWWQQFcfZZJP25xZ5qLetWu7BZZMR+VIZAHQfhZP3oLPSzZL0ga1/Ls9nmRD?=
 =?us-ascii?Q?7HxnHxy/w36nZ2JtOg1z1BXMDhCbUj4Voh3XmWvSYfjWCf4SsoASg8l1+xeY?=
 =?us-ascii?Q?vEIQ4+C0pKGH7o6fn7KIRZDT+DPvHDgIfu3UesbCGL3oZEhAJWTysXqsjqQ2?=
 =?us-ascii?Q?w8Y4GR5GXyTfMQyLf/08C+RlOLQwSG7kA+FgArwTsZTBMFvI/+a1O5LBYFHx?=
 =?us-ascii?Q?gH/m0W5XEb1sy5MruABUizo826OyGEe2+LpIZGs77cIHK5QL+Yam1CMyGitY?=
 =?us-ascii?Q?oE07zV5NLvmwaa9AbXODb5jZY3CB0wQ+FjDCEsvYJDzdcjf8s+DqnZExeDa/?=
 =?us-ascii?Q?4JfwPajbnjMuez/EuALeswV89EM/nZFRPlUuBeggoMbVZ7UQPx2bK4Ob019f?=
 =?us-ascii?Q?1f+2bH2mhxlEUODx+7metVXaNCMIMAdNbfiVF37S4CFRsQ5ZrEP3F69cZy7T?=
 =?us-ascii?Q?h8Ef1AcOYj4yCvc1qyAiyt8gr37EMoZqPOuY4rIO/Sm/8jSyzsaRLQRauV6A?=
 =?us-ascii?Q?QHebsZNTvafejqeb+I3EECGEdcZhad7c4Dy8KoOD5zKotE6cnOOuGfMzTBum?=
 =?us-ascii?Q?/CxEhiswP5wiukpSHumjfI8CKEIX9xpGd2oaXzljwAT1TxiEYBFQkkW08UZf?=
 =?us-ascii?Q?nKJDxtykUxdAEmqum1+DAFFox/7FlXthQrPin+H3FArhtBU91pJi1MCyYEDF?=
 =?us-ascii?Q?Ru8/nCNbxhLHU3wXPGnTuv4EFY30C1wSn9yrUBhN4w3LTpSg/cg6QMcnvrjx?=
 =?us-ascii?Q?y6lkJSHCDs53kmvwqhmtROJhaH6ioSWEZzmnQ4FjRJCCTk8Z+ITCiAyyOHTh?=
 =?us-ascii?Q?gQoRwzHx0Pt/hCctXeNmMVoT9HzmbKgw+61dcnt7+lmrkGjl2PZpu0lW89In?=
 =?us-ascii?Q?pSOQdi53r3RYpbXYjognOIspWi0YMP41vtMVE68i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e9428c-531a-468c-88ca-08dd15b300d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:01:11.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYrIjok4oAx20hV8G+4qj/fnIh6lsCpFdJdobWjcWeDv0tu9j4mtlSDxkiA5G5JaydY3bRffFwk1I4ZAALXbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On Wed, Dec 04, 2024 at 02:48:40PM +0000, Dhananjay Ugwekar wrote:
> Replace similar code chunks with amd_pstate_update_perf() and
> amd_pstate_set_epp() function calls.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 36 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a1b2393cef22..a38be7727c9d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1630,25 +1630,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  
>  static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  {
> -	struct cppc_perf_ctrls perf_ctrls;
> -	u64 value, max_perf;
> +	u64 max_perf;
>  	int ret;
>  
>  	ret = amd_pstate_cppc_enable(true);
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> -	value = READ_ONCE(cpudata->cppc_req_cached);
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> -	} else {
> -		perf_ctrls.max_perf = max_perf;
> -		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> -		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> -		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> -	}
> +	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
> +	amd_pstate_set_epp(cpudata, cpudata->epp_cached);

This will cause two MSR writes on MSR based systems.

But then, we don't expect the amd_pstate_epp_reenable() and
amd_pstate_epp_offline() to be called often. Hence it should be ok.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.




>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1668,7 +1660,6 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	struct cppc_perf_ctrls perf_ctrls;
>  	int min_perf;
>  	u64 value;
>  
> @@ -1676,23 +1667,10 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  
>  	mutex_lock(&amd_pstate_limits_lock);
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
> -
> -		/* Set max perf same as min perf */
> -		value &= ~AMD_CPPC_MAX_PERF(~0L);
> -		value |= AMD_CPPC_MAX_PERF(min_perf);
> -		value &= ~AMD_CPPC_MIN_PERF(~0L);
> -		value |= AMD_CPPC_MIN_PERF(min_perf);
> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> -	} else {
> -		perf_ctrls.desired_perf = 0;
> -		perf_ctrls.min_perf = min_perf;
> -		perf_ctrls.max_perf = min_perf;
> -		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> -		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> -		cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> -	}
> +
> +	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
> +	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
> +
>  	mutex_unlock(&amd_pstate_limits_lock);
>  }
>  
> -- 
> 2.34.1
> 

