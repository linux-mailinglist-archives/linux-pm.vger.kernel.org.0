Return-Path: <linux-pm+bounces-21167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DFDA23932
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 06:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766CD3A938B
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 05:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F571C687;
	Fri, 31 Jan 2025 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bCdWqk02"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A017BB6;
	Fri, 31 Jan 2025 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738300020; cv=fail; b=sl1njdbdYCAszq7PdONj0BXsbp0lhL0P/mUIob5ecjI3qKBXcqIeYva1MJwyVv5cHh+Tr22mlwI3KUMt61/BiXpWvff8a/vtK2Wf43XKbu3pZT8iOMdjFilpgagLXzAgqKdi46m+i3YyF+ZF2V80C5VhEsaiiPHzCauYrFx8YdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738300020; c=relaxed/simple;
	bh=cXMScq7jEYmuFPGmgWe/c8UDaQ6FetH8+ZBuLimPehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h0lJWn+P4IbSlASQt2rCtK+Kmq1sxjrdxT5nIYfmU0uWTVfqGH6qi6LT3WVpbF7RaOv249KQBq+CjEihP+5aBbxnAjuYayRISDOdfud8P3ZFb6kcfBcXPcJOhbScbRo8t7LAc57kWeH+BL4xoJm6K3WB5dMzMlxVwYsjz6UYhTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bCdWqk02; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9m25iweS1jDU4uNa+TxDVPmmls8y7nGZ2MThwKpebR7M56DWp4cVBnY9qWnqR/iIdyOXrRFN955IBWq+76qBwUJxLkB8RqDO7rPFbsyolK+9O9IWmDWfrNNyw1FENwy+zyoRT7hzEzMPEyvV5yUfQcXYQwvMT6T5ZjnGLDyCGPXEufBSn50mXyWYKXBuxOKwtkvFMOt+9k3P6kU/kMeXbDa5YOie3nyjE2yyj6Jn34KJTXTWho8RH/kxgH8yRnpoXPoxaMz3gY42ux8ajSpRl/39SLB4t/j1Rb/7o0Vfh/5rIgDKf4t5VwCgF2R2IarjzGMixVO5yKT1YWUYsVP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFI+ijxk9XEDqT2lFUaTmjLMAEUKgyyRHcRa4fJuMWU=;
 b=Em9S/UscKof2Y3OUgQcGdVeiMs6BYbVirRPjsBdFbAopaz09PW7t2/R8PECkVCwSt32AZaRiEYYA3YMTCzYQKEdInXsAnQoK6D2Y6xDSifDFE6BMkHlrrTphHNvy27dp5h5MC63SMuu8BIQLDDJ/8CfSwUU6QbHhiAScl1/ul4Gk0CeCPZvuVe/hO9Re3l/CaCt13JBbznAOeZlW4Ae4dYf/KeQdZjIv9cOPPV0AsRrUIFFEwFiDCEcy1tpFc9r44R0Bnm6nw1LDrGcDQFiZS07EvTi0GOqXqmTgY8l3LJyua2TkD9adrEyHozarcV4ND1RIstiNhXvL+e+w1uUaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFI+ijxk9XEDqT2lFUaTmjLMAEUKgyyRHcRa4fJuMWU=;
 b=bCdWqk02Kdnl+12L0IPo6N377Lrnerm4+P441Mu4hvh5GtIx9SYodeZdDbluBrY/fCXIULIyghlMG3wwiKnGK5Zjgo2D/cTfqw0e4/oG65LNeNg0EESgAGOMglqLwq2mFkMALDNXnn4IEsnlmM4OkdTmgY0GsZ/AdzJ+bGysCao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 05:06:52 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 05:06:47 +0000
Date: Fri, 31 Jan 2025 10:36:39 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove unnecessary driver_lock in
 set_boost
Message-ID: <Z5xaXwMNXQc+qbqq@BLRRASHENOY1.amd.com>
References: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 418fedd3-b54e-4429-e93a-08dd41b50fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxCJh/oyJhmVVNUMt4Cfcmu3R7fJHi7gJ4VMTj3y1GTfp4GxmjP9ZP+FdcyJ?=
 =?us-ascii?Q?5yeUVQ+rxNqFYOl5mtzQJrVXls7LNt2GVQMG7nfl6b9q9MuRT9TRvxlqCrUD?=
 =?us-ascii?Q?igDByrsy7WquIqRrYrtFNj86AnCdW8/WHKmiLeEx5E1w/ffdlNzVfHcfsl6f?=
 =?us-ascii?Q?nUJRdRN2YOG5ebL4Y+jjiUSGvUIoZ7RXZSRrcfhg50Wz77wv1FF8sZnbl2sV?=
 =?us-ascii?Q?RyOxH+WGKq0SvjRUaax/dXFeJRRW/Excemgx6LkPPgHMKLGNagDRlN7TInSh?=
 =?us-ascii?Q?74EUnxJ+094f2pjPWFUHRF1PWEE6aeNHyNBGUmyB8XqraGKwJla11u7Mxu5y?=
 =?us-ascii?Q?FFRX67NGyWG+hq8BO7hDIXAH9FQmbINQm+rQdErC/+8vOpNGrNhwHe3cBQLG?=
 =?us-ascii?Q?c0etT/Ud/taokmSL7Cqedn4oUa8loQGaM3YORWpvhXGuWhtWGkrYAMMZKr2Y?=
 =?us-ascii?Q?DDUkQQr9147pHodY55qki3Po/TKPCm7cwDGKYkk16IvsHUSF8b9B07O1zbsv?=
 =?us-ascii?Q?Ma+4zfnC5Ok8GXbA1EDpDsNmOJiOJDP1U6nX3/r8g/p8cd6OPsnlELE+hSyu?=
 =?us-ascii?Q?KmFa6i9+YGj8EqjzR504DmUo2Icn3rQH8p9NdAE5pe4MiBiluSMLN9+sKXZ9?=
 =?us-ascii?Q?rm+ZLuYc0wcOynM1lGNIttliVcJl0w/AB6xOPftcovn9MPuu/uCP7eEY300Q?=
 =?us-ascii?Q?mkKbK9HzQMm8r/6a/ewhoVo/P++ZhYNkGSklSnY5r3DqvmrcNJp5tXyngUq4?=
 =?us-ascii?Q?LXG0SLk4WUhkrr3ZX/0/rvO/oxdmONX7sWMbmywtvC4Uak5Lb6HVvsOwAxHG?=
 =?us-ascii?Q?UMnIFJNEarj/WKGhDWssjC0aoXQD4dMwgmcjt5l5yt7KwSy0dE8N408AEj6O?=
 =?us-ascii?Q?On04RCZykDpRVIgWkBGvzxpIpvG9VuKa/HsOWRYsJHZ9GXssp0sinlF8sIOM?=
 =?us-ascii?Q?LarltgZFuMr23+vZ+WoLEpzjRkKAO/lPGRyPTSEkW1V+3QpIDDLY5JefUIp8?=
 =?us-ascii?Q?lbGba70XsFs/XHOtdbRv/F0Xuc6RV+yIBo1Uq6v3ULYrOzV8pxm1R/RK+4ZY?=
 =?us-ascii?Q?VPYojAhwe6E/WfRbSyQuvVwtrerAhmfzAT6yu6oSJ1UjiWCvQYUrDfqdmDce?=
 =?us-ascii?Q?UvOaGmQn5Lq94AkZYgDih24ggI9LGjHWsPjFTsUTPYZiO10039IvxNhi1lyK?=
 =?us-ascii?Q?mAYXO5C2nfczi8os69LMbt0CT6eWdYaiRnouh+TEeh2NlAZ5dIx7srz53Vis?=
 =?us-ascii?Q?ec9oEmBP2IVzk4JBRJb6NksNY/y09CF0Xe2h+1nrj7swmgOsvATrFS8Y3dER?=
 =?us-ascii?Q?GluBYTfrL9PTU6kHrtBxdWWyX/p2/evkOXPZwUelvUvl0Bpk9kTM7Rgh5Pcz?=
 =?us-ascii?Q?HIlmofMfjBQ7XEuzk/LZ8QJE6n1h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbqWLG9GWenj0RH4zqqUcjzrh2xdL2cRmV8ToaES2YmIRXdotVyjU/B3hvrJ?=
 =?us-ascii?Q?teV9KjB8zH0+zgeGG0rdTQZI4XtD/3fEDVJtudkWxbjB4oT0xYuU7DZ68rlq?=
 =?us-ascii?Q?OOZc/TagnUUQXbdW0vIvDEuHNbOkj9PcTA2WjOHC/0YqlCCaMgdPOGeWhxFQ?=
 =?us-ascii?Q?81MdQeOoZmuDzOrCIqu5L4Q84JpZzjyz7tVcMesbGBE/L5iqixsUhu8bb6PF?=
 =?us-ascii?Q?MYoxg9VWUea6rYEhrP7+RuoyBEm4HQrvDhf8w+bD0zVZoTNxa3zjli/nurYH?=
 =?us-ascii?Q?xn0wF85UDQE1QGt/IyXZJ9PxvCPMCLQU/Ph8o0qEnB4hgpQQn66PNGplHPTC?=
 =?us-ascii?Q?sWelUxtFV4rwcgzXV0EKT2Z2fLE4mu3k+UAyuGrZGE8nIj8UA7rd5rEM4e4F?=
 =?us-ascii?Q?k3ceE1mrh5mKuvJJdlwPzeEtP8GkM71o6n/zrkkDisAG0qx24i/XUOb5VVzW?=
 =?us-ascii?Q?/eoDuY4BvTg+ik5DrrdzvP0PuO5uMmVJwc4qogjK9K8hA4UuxpLiCYGtgun9?=
 =?us-ascii?Q?g91YkdQNZ1rcRIhRwkH9wQLuAOiaQp6CGEhF4pUGM7hKgq8k6Tz1rFfR8TA+?=
 =?us-ascii?Q?QcoswNE1AfTg5grvWA2fYO3A/bR4+XiifMvwiX41G7tpN8iQsMyO63bQkaVJ?=
 =?us-ascii?Q?1exfxhK0AwE+pAVTbCl2yLxf6fwcdx+ZbDA221xZF/8MlQC34t41Xg/MXBUw?=
 =?us-ascii?Q?SpIRGv1g3pj5fWHJCnkJSLXBHyeXk2hu42oU/0RfAC0Y5cObr59iOOSAo8e4?=
 =?us-ascii?Q?kteGcZvsehbo4M77+JmwD3qt+nzVvElTxiMgKXWxBhJeX5OQKwVFgySK18UV?=
 =?us-ascii?Q?FFZxaZqK0Qv5tunhtRF7DPqplpTVxAtL94/KArraDo5wmVULxkA9zPu0/OZe?=
 =?us-ascii?Q?ueS+6G4v/3XzMYYSbFIvPYuUGsEoidQYRVVSzktHryE3pyAsMiEH1Nj9gdT+?=
 =?us-ascii?Q?9EtJMCV9p5qADJ03IqI0DIcAWyR1TS2emc0QruxO2wEWLaVl0ZeWXooPX9o+?=
 =?us-ascii?Q?XJb5FlQO+HZvjpbHINMS8ciJTllxEJdIL7SLV8W1DQE32Z3Qi/a1pzp9OZn+?=
 =?us-ascii?Q?fzUsUZRkBM53An6ZmDULB+33IeptcuRhtDHUeo1DyJXiD0A/VhDXrO0bfTm2?=
 =?us-ascii?Q?u9gDLcTNkeC4ZjX0a4TA25krzBvrSUJ2Ai22aabyS6zyfzMCsTrKHD7SVz0t?=
 =?us-ascii?Q?2JiAI8R5OuSsjde3jE2oI/Yr+492SOtFXfqYw/x6M0jV1L6ndUmOtD053x+D?=
 =?us-ascii?Q?gT0cHTevk83k8C4vfdSDzJA4CS3t4OpNiya2vatb20vZXBywIGaKTOdecU6+?=
 =?us-ascii?Q?5c5krkthQhWtGjrvQhlngqnjn7/dwPYW8PkR+RUVKXhLJwbYBydbY2qVdYgJ?=
 =?us-ascii?Q?9EAnxMwTbrFIEnZ/hUvPUA5NCUsKy7U61QnvTTxQwiVGnEsirAajxUPeAf68?=
 =?us-ascii?Q?bkFBWvb1xDWSR/k/opx+C5kfK8zXtShvWo8RlCJB67T7iZ99CTpCFIw68N12?=
 =?us-ascii?Q?IEI3PO4e8JIr5KO7yazgPCHp/3aweIMS4nJlV7aP5m2HCIYz9N+Gf3sXLpmG?=
 =?us-ascii?Q?AhjlafgggMqBvwa2eBfjurGIGx4Fvuu/YHi8qDXn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418fedd3-b54e-4429-e93a-08dd41b50fbd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 05:06:46.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKswhEUXRRjU5rDY2/ZTC59NR3oBM8vmO8VSQURVJsKVOJDInxfR/U7ItLG7/m2pIst0+oHZjA7sUI+EXMtiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

On Thu, Jan 30, 2025 at 08:52:52AM +0000, Dhananjay Ugwekar wrote:
> set_boost is a per-policy function call, hence a driver wide lock is
> unnecessary. Also this mutex_acquire can collide with the mutex_acquire
> from the mode-switch path in status_store(), which can lead to a
> deadlock. So, remove it.

Looks good to me. The driver lock should only guard the state
changes. Everything else is a per-policy change and is better guarded
by the per-cpudata mutex.

Once Mario acks this patch, please respond to Viresh's series and let
him know that this patch needs to go in before his series. If he is ok
with it, he can include it in his series.


> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
> PS: This patch should ideally go before [1], as that patch uncovers this 
> bug and actually leads to a deadlock when switching the amd_pstate driver 
> mode.
> [1] https://lore.kernel.org/linux-pm/e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org/
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d5be51bf8692..93788bce7e6a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -740,7 +740,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	refresh_frequency_limits(policy);
> -- 
> 2.34.1
> 

-- 
Thanks and Regards
gautham.

