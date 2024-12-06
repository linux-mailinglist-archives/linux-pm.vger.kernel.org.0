Return-Path: <linux-pm+bounces-18670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5469E6675
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C3718861A3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F098194C6E;
	Fri,  6 Dec 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsO/ay7v"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F2193417;
	Fri,  6 Dec 2024 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460231; cv=fail; b=f+eBdVZ1nNgOgoiry7sQTiVspAZG9m9Lo3MPretLFtwVwLXdOxjKMzxnTqt8gjLIZmLPc1DC7MwflHxcUozdkJ4YD5M3eBXHFLn1G11elfJCu14N/Dio6499dPZCU+mkRG1yBisberAErKUM4tkt/crQ6ewEd24eBPkc6wXbrXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460231; c=relaxed/simple;
	bh=+SYxSZrrDCRkFDyFOeMIo7NIHsTDCIc3Lhqyk4hK4VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOaz637MfUfS9k/mP2kfOcFgA6RXYrbNbe8rpabN7lMpeIDbFa1dqdhl27VZ3XGv8gJUudAYEBBHJgghnCTlUMqusimsFdPQUfbbqv8e0t0MaXZI1dyOQ98z1VWimeL5sBsoRkj8oX2Y2RfZv75+6v5F5ZjKPNSyX9m8ytMKa2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsO/ay7v; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA1a1IadhlSk/EgiobaKOTZXcC3mzzP/L4snydccH1TUkJTCXHyQIYx84+rVY2NXzAWJ8G7k+bq2Ls5GeLhF0zDagxFrBLSU2iCi9e9RW9fnyIx+34BHdNC5cxWW/plJ9vIfQyVBX7T9vzFW2BnNSAJSxv6c65TBivrb2GmyPdBlhhRPk1eAnT3puYo0fUcsL2T64DAKZfDyz0sAB7H3xD3zrht8EwgzSRrhl28R5gYd0G9vlQAjQeSdiLKO1mSGImvIjuJlEhLaIrJBaWughQYs5l4yDET33ZenCJBTSAluvb2DN1yHZw60JNDkRG9icyHlEBuH57YyyJ+h3ci2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy4/dqVwmtpyqCVNQ8mHgCqUhlZrA9VfL66CFO+nMM8=;
 b=BYLuPDx6zcrHj2r0vSa5j2abIsYHLSzhcXhUx4yYl3qZ2LdZlejm69P97b42r73+CdiG9Gdpw3H8QJCMygrUfFdxzRfkleoxeKLBbJkS4DCGgFjANnb0ZyzOMV+LdgmDcjHIDXKkI4WKTsozMc4XsZAOO+f82aE48xjIU9S8F7yDHQaO0qIqWyrmfjFN074jR9uhPXodvW1bo+vFGl0mxhsLYvE3yG16XcKalNvdoskGOqOtnpQzW1t2phI9bLO+ubLEqO0emqwLLRRFPQWaDfvA8vkryoddIbTfoUN0Ue0JMYuiKSrSTbwXOg9ilR/K+Tyuj4tQioPA8ALmLthsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy4/dqVwmtpyqCVNQ8mHgCqUhlZrA9VfL66CFO+nMM8=;
 b=ZsO/ay7vKIVjZUM4HCdYO2lbHQQF9kgEAF9Unnf5VUNbyhelo8vBVexemaPCZY+4XEFQVEM0yEebc2BwW8PbjSfduYVpFZEOY0sD0RnlC58SACAPrADbXkisnMoI+SMa4YLPshyXE+oQcJ8V6D26Va0NYgAbM3NdNfVPpYAlUv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 6 Dec
 2024 04:43:47 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 04:43:47 +0000
Date: Fri, 6 Dec 2024 10:13:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpufreq/amd-pstate: Convert the
 amd_pstate_get/set_epp() to static calls
Message-ID: <Z1KA82G2rajkCHLx@BLRRASHENOY1.amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
 <20241204144842.164178-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204144842.164178-2-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: d7819cf2-dd01-4e07-cce5-08dd15b09230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GX3gQDRbmpNTw0Xr0BxaRM86S0vF1RmumH5ZJh8OHu5ScWwkB0hYZobqyHTR?=
 =?us-ascii?Q?tD04sDrUXggEx2o0Ti9EmzhumXPONvNd6X4EUh210OKgeIIdr6VJjsWyS7jP?=
 =?us-ascii?Q?kFSKDV3K2Z084NV7EerDrOa1YUCbDwHkn8e+sCzhRJk/zlM47aW+/cJeiyEI?=
 =?us-ascii?Q?L3WVl2OGl9gudzwRFdDWqXnGeBPAqXSG04GZTCM8Oha1AqbUvHKQSXvpa/bf?=
 =?us-ascii?Q?I1Ju0YhhobZGKjMxSwWo8yLZ0vJ3UletFpxCsAy1aicG5bk/srPwf9sTu2pD?=
 =?us-ascii?Q?hUqj7iW1gswNM8Q6SdIIyImC2TfDBhi6xQ5ystphq14tOzHExk+UUYW64i54?=
 =?us-ascii?Q?d1auH/7a24w/Z4YFHJrUjijVgvwTrNuhZH4lLYcynBgAXlQVluZpuvbZmV7v?=
 =?us-ascii?Q?+HtKvvmGLsBmnJ6qhouDbJx1dpt2yGqwZC50oNlCIBcInKmzKJePmZlpRJsY?=
 =?us-ascii?Q?oL+Ai8NpOrWEt7V5Xh7I09OP4y+o/UW2XdFiR/qsGM18Bt2tCZvTEVYUMjr+?=
 =?us-ascii?Q?mTkIaXReEaB8UJCzhiODJRH8qVruE/aF4YBQ78jzUBtNgC8tPvBuQk+vjjOF?=
 =?us-ascii?Q?b+ibwhevmb6JWgVGyISU8bSxaGEakByoMOPFinb4lF5Kn7eQ+RSFJubzpHmN?=
 =?us-ascii?Q?5Su9Iym0Vxyb4aWzlQ8hfqlvPaz61DCBP6Pmn+GMzZ47Os8/9jIo25Nokjw8?=
 =?us-ascii?Q?oNnWe6phWeoRbq52rj9qNtglWwvwD6Y8oE6iEr09roNyB8FBKLKU+TrlxP/o?=
 =?us-ascii?Q?WhjKsdn1zG11NSMwlAsLSDlxEhymZ0vp/LlSOkvr3p66yT7Y95unFRBcxNrN?=
 =?us-ascii?Q?UcM/YfPDedOrVanD7mGvWhxluTntwRTxETHqHyJDHc6DcTpXv0DJxS/IzfWJ?=
 =?us-ascii?Q?Xi9mMNVQkvZIplCHR2eErnvTTpC5TFk+T6xspmj9SXeZPltvSl8DywZDe06p?=
 =?us-ascii?Q?SBZNLZ1W23GYzcfFy81D2/arvz70ezos1WyGwTGwk8zQKL8ACeFDZG31T1/R?=
 =?us-ascii?Q?x8G5I1TF3nuT+K9d3aDOK4+BMPpSjoFbBuNdOy7kJz33tD9Rhvyvk1NdgH7l?=
 =?us-ascii?Q?opKgOXknEipNGNnYDscquy5W4ZbnZJuCokZJcyfw283D1LTwluNqBlWx3VPR?=
 =?us-ascii?Q?r+WURoItD1eHlPeiUk/R0YCXOvyj79V+Ad5JSPi08qOatb7uWFfqfQba69kq?=
 =?us-ascii?Q?6ib6ApUSrAS94DHk55cBXkTQkyyBDw9GWdoX97E/ZWTzt1X3908m6qtuUVaf?=
 =?us-ascii?Q?HnMLNfM0Uj1EOJ6LPQ8rRRTIDjNz7fBLQW8RBU67ar5nLBPaKlSr3T66ZD5k?=
 =?us-ascii?Q?RenUGVUNp7hDBK9FgC3F2nd41hPjE+cGWHBtbTYncC86wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qw1jYsbOdyOsSDlDE7jargjNIJ3eNM8NvO7u3rCHLjB5gZ3nUkgBcPUYDuPk?=
 =?us-ascii?Q?sCGrB4SFCtn4Pz3SL9a2ppFnbLJ8CD8/joa+KbGbx8IzIcyJZ4MwuEdIVl13?=
 =?us-ascii?Q?ljRfaILDW6bYx5Dz8xCsXEaHq/4pIbj26QUqASh+ZtPcLH4VXB4M7dxib7Dz?=
 =?us-ascii?Q?7Ieuh0IhMUUZ/DoSLWHxKRDw/7harmmI609ED/1m0DTKe/sKL7e0EIEgCdmP?=
 =?us-ascii?Q?4fd05UhOhD7yYOr/LSHevDYgCXqR7NjCz2Ihtcp+RYEtMnNWw0xMbfy9wpCb?=
 =?us-ascii?Q?tNi0VW42c+jRm38uwxVTbNEEVvYTwMoQ7OwD6IOhjrBCFgIW1wzBMmyCUy8F?=
 =?us-ascii?Q?Y0fDL66NGl14cv79ZgitRY/SFKE+87JryF07fjwdb5g26hW+uFnjqTUk02sK?=
 =?us-ascii?Q?Km7NJLsVWFvQqoetEZ+02/+KoGgZ1hhS4Lh0CnUrCNEtgApC4zgJVQSUa39G?=
 =?us-ascii?Q?L6WBKRiOaohgYh8W9qd/uBYMsHybRmw7V4M5ihIMkd1Yz5TyeU/MPoC577b9?=
 =?us-ascii?Q?o9jXkr832mxKhCcrOsE7Z5my+9DSkA0y68FLG+i8tGQp7oj4QdcDfh63b+WN?=
 =?us-ascii?Q?6IYx6rqrskyQG5IjPgqkIvZeARcvpG8/ghkGeBArpRUNWSzngNtM2L7fkJ2t?=
 =?us-ascii?Q?DPKBYmvZtLzgKmVlHIDlKe/dxDnTFVmMggytT7qb79HjDuO52C+Qkr+Y21Am?=
 =?us-ascii?Q?/GZofFouzLuQxhpsULQNF9ELNJot80pFRP7p1UqEmyiMefkJp0mS/FWBnINZ?=
 =?us-ascii?Q?nkpsNc4oiNxsxBOD6TfujnmIw5CohPc41w2l6yiT+9ewXCi4Ida9pzLvF3jP?=
 =?us-ascii?Q?QSe20G0/7266y/J1WY4P4QOzhkEKAlpTG0WBbVH932433vaSxE0P9H29Vr4b?=
 =?us-ascii?Q?FHgHHIxwksnGBSQL5VeBwEMURrVBnCphuoM/Dz3xujWB92yk07qBnG5xu+oy?=
 =?us-ascii?Q?/bw6Vj7zTQvp+6qhG1UkWyNaE1doE3nipBnfrWX/6vqGVpob9flfSJAsKGMO?=
 =?us-ascii?Q?1R0nJ9hN+phXkFURDCQJkW5PXt0KUl5pOrcaBE+J42LctBL5f3WRLIP9tyUR?=
 =?us-ascii?Q?qXOIz0c8hkhNuSxb223L/dbGF3ocMh9wKQlYK2ez9bhd0kDLuXbDatfXEuq+?=
 =?us-ascii?Q?UgEC5IHO+xWRaF/dnkShYsDbDU457snkHtzQJ4mc+LzcGrqsw7sB51B/OvqZ?=
 =?us-ascii?Q?HXKZ4ZybBAiilDStGgAJC0xoHj2UKgU8IxTlg/unc3+LhEIQj9hQqXxD/mz1?=
 =?us-ascii?Q?IGSAQf9cYNxyGke4Dy75ZYTZu+jbmlixo2x1oe4e3hlWCL/qV0JhMCsVun66?=
 =?us-ascii?Q?S/RLQYRPEmQbE+C9NlxONHH+yoyEKXMM+ZmUcSY8Dr/QibPNwYb8saqSH23t?=
 =?us-ascii?Q?Nbu5ykeJfaqudxcsh0CCK1cdU9wK4a6Im+TVqTfo9RP7ZnYcrtVnphI+PdQD?=
 =?us-ascii?Q?cOnZyNgAqHGSN76iIfCGGx22bRePkYmDZFYeXo0PyW8+dXBTtbckiw7Ll1b0?=
 =?us-ascii?Q?f4z5N6nyPWjlfrX2etb8sYTR1drhw7r6BEBRhkCPkt8J/DWJyscdyi3z6EJN?=
 =?us-ascii?Q?8w73HGgt4Iw93Nh9bKpl1kj67fUt0+wDCLLV8HDT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7819cf2-dd01-4e07-cce5-08dd15b09230
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 04:43:47.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqkk1tOHicOeiBUVhRcBes8Hvo2MIXMyXbfeyUwgB0Lj0FltYIkwdVyTOEooXwob38J1YeuUMdbWH6gv9fiCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

Hello Dhananjay,

On Wed, Dec 04, 2024 at 02:48:38PM +0000, Dhananjay Ugwekar wrote:
> MSR and shared memory based systems have different mechanisms to get and
> set the epp value. Split those mechanisms into different functions and
> assign them appropriately to the static calls at boot time. This eliminates
> the need for the "if(cpu_feature_enabled(X86_FEATURE_CPPC))" checks at
> runtime.
> 
> Also, propagate the error code from rdmsrl_on_cpu() and cppc_get_epp_perf()
> to *_get_epp()'s caller, instead of returning -EIO unconditionally.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Thanks for taking this up.
This patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 92 +++++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7630bab2516..d391e8cafeca 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -180,26 +180,40 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
> -static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +static s16 msr_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>  {
>  	u64 epp;
>  	int ret;
>  
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		if (!cppc_req_cached) {
> -			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -					&cppc_req_cached);
> -			if (epp)
> -				return epp;
> -		}
> -		epp = (cppc_req_cached >> 24) & 0xFF;
> -	} else {
> -		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +	if (!cppc_req_cached) {
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req_cached);
>  		if (ret < 0) {
>  			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> -			return -EIO;
> +			return ret;
>  		}
>  	}
> +	epp = (cppc_req_cached >> 24) & 0xFF;
> +
> +	return (s16)epp;
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
> +
> +static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	return static_call(amd_pstate_get_epp)(cpudata, cppc_req_cached);
> +}
> +
> +static s16 shmem_get_epp(struct amd_cpudata *cpudata, u64 dummy)
> +{
> +	u64 epp;
> +	int ret;
> +
> +	ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +	if (ret < 0) {
> +		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +		return ret;
> +	}
>  
>  	return (s16)(epp & 0xff);
>  }
> @@ -253,33 +267,45 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  					    max_perf, fast_switch);
>  }
>  
> -static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  {
>  	int ret;
> -	struct cppc_perf_ctrls perf_ctrls;
> -
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		u64 value = READ_ONCE(cpudata->cppc_req_cached);
>  
> -		value &= ~GENMASK_ULL(31, 24);
> -		value |= (u64)epp << 24;
> -		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	u64 value = READ_ONCE(cpudata->cppc_req_cached);
>  
> -		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> -		if (!ret)
> -			cpudata->epp_cached = epp;
> -	} else {
> -		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -					     cpudata->max_limit_perf, false);
> +	value &= ~GENMASK_ULL(31, 24);
> +	value |= (u64)epp << 24;
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
> -		perf_ctrls.energy_perf = epp;
> -		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> -		if (ret) {
> -			pr_debug("failed to set energy perf value (%d)\n", ret);
> -			return ret;
> -		}
> +	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	if (!ret)
>  		cpudata->epp_cached = epp;
> +
> +	return ret;
> +}
> +
> +DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
> +
> +static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +{
> +	return static_call(amd_pstate_set_epp)(cpudata, epp);
> +}
> +
> +static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +{
> +	int ret;
> +	struct cppc_perf_ctrls perf_ctrls;
> +
> +	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +				     cpudata->max_limit_perf, false);
> +
> +	perf_ctrls.energy_perf = epp;
> +	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +	if (ret) {
> +		pr_debug("failed to set energy perf value (%d)\n", ret);
> +		return ret;
>  	}
> +	cpudata->epp_cached = epp;
>  
>  	return ret;
>  }
> @@ -1867,6 +1893,8 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);
>  		static_call_update(amd_pstate_init_perf, shmem_init_perf);
>  		static_call_update(amd_pstate_update_perf, shmem_update_perf);
> +		static_call_update(amd_pstate_get_epp, shmem_get_epp);
> +		static_call_update(amd_pstate_set_epp, shmem_set_epp);
>  	}
>  
>  	ret = amd_pstate_register_driver(cppc_state);
> -- 
> 2.34.1
> 

