Return-Path: <linux-pm+bounces-15756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373969A077B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4779288DF7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC8206968;
	Wed, 16 Oct 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQ9rk2dh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B8206954;
	Wed, 16 Oct 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074796; cv=fail; b=jL/LqopNv/yjeqwur2WM3MWKsFk55FWZhRWWcT1y0OXNyUkGxAYNWP3eyYbElMSFMdaxY0cznY2Xoy/oF6uYNa1Of/ezGHoW4FQjrPtYD09wx/pyc04PR4hpy5EHMDc3MhAapxizz6d+FF2WA7ngnqMZYTNKff5YLBE008WCv04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074796; c=relaxed/simple;
	bh=kuklsSb4UH4Xp9Xb3BIzb/z0mTGcF00wb+U4tPz5pAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/1Z9PZGPBR3HRDKFEtXFCfL8ymuv7lZs0Lc25dK31LeuC2tcU15JQL5acsl7MwWMKpu+zc6WevKp+8aFAYupAjMcLyKfaCh4DllYG9LrBIN8qBSAsf3WBJteWDssZdYKy9vpQlNMClvpCkCMwYDdNJETpukBlYK46FyAFKQWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQ9rk2dh; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXnM+NU5MmW6/Ze60Ow87HztGfzThPFwGi9QTQKScgTdrjPatFGMU/UGEvUxCm2i8CUTJhK1N15P4wVCCTiDwm6tM7SNO6sb47ecDEieGacMDl3gRjYqWx3SF82f807ptfYtiEdwB/hTdYVAsGQ6WEOw+v//WeRNjS5ExRTCJ12hmOo60RxYo9G7uVouLjdSab1J3VOQSkq+g/kt/ukGcorrP59r4aFafd74y3E8jtM5pJXGOdk49oTQ4oI3nCvDEtRseIZH6yJkrWUfuY2GI3fI3X3tPUByd6aQLKiFNZ6wqpZhVaB0OKBwFZ3EFTLzMT9OqoVjirqC/i6Tzrp1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+lOh6s3rnkI6IkPOYDUpwqphndxX6litptJvz82m4Y=;
 b=OM5HCFwDWPna0jgU5+sCdFpGe7XHgXlJ6mczBW6KLiONstcNW2EEbhezjZ+kblPox0hL5i0vbqsq/ESsqvXGenXV0EfMRkANaK4bEVf1zzL6Vq0ZV5Tu3k1wJe9ClhQKKkJMpX4+KS430NfgBdQ1mXFx5+Iw+pw+vcuJ/kC2cOTW64sSe0Sw7zRdEVSr4rTsRYZwUUlqag/0Fll8Qv2Ct2TwspX3ffBfGyD9BKC0O+8WqzzoXEL9/mAhfxV+bdDqOPYyaj/VTRuopxGRJlxSIUEpZjKjpUA1SFbHEDEmOSYtbnmuGaEsJ9opqsPLqcQQfwiK1vnA29d9HpBXqS8XEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+lOh6s3rnkI6IkPOYDUpwqphndxX6litptJvz82m4Y=;
 b=TQ9rk2dh46tam0kB1y2qd7+328K+W3TFzrTrj0MvtIi22TnOhpaGSdgGJXNdVeOLoL9XtHhWyCbNJlNstPsMHOPb9Xw+7gwGLGHJQ7N5dsy1e3J/ZB10DLVf4jqcjLZXcjyKcTMU4+c16nZrRoXa/4zqGtausIT06lnym4zhd6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 10:33:12 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:33:11 +0000
Date: Wed, 16 Oct 2024 16:03:01 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
Message-ID: <Zw+WXSoSiFzrUDT5@BLRRASHENOY1.amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012174519.897-4-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 8465c7fa-ea22-4dfc-cc5f-08dcedcdef1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX3vijgnBr6XeQd3VSXT2rw9F9t4dIlRoyYtR1455dVXsBykOduwV2EPVEfT?=
 =?us-ascii?Q?rodmiIGGrrY29IfGKnDuI1que83IcOzpDSjwwP6prDbc3ppUdfJ5xykfG2FY?=
 =?us-ascii?Q?9ih/66MnkoNgdW5SQsXd4UMVYicbyhzPX8Bwqrv2Cd/4Vw/JfxkxX6QC/KGF?=
 =?us-ascii?Q?K8ZvAOazW7NYsZn6b7B1320tx2YLelmg8LXo8It67Uw/M3bEnwKcDqoTUqk8?=
 =?us-ascii?Q?RFChuo9pT+3mN/rm62qoM7pxeQMCtbeYlaW6YzjL5LdSKAW4mUhLFpf7Ansp?=
 =?us-ascii?Q?FETYeyC+v35xE3IqWYTYQf+2ALBfkkz2Vc5JRQQVasrzj1/FufS+uyZtx23J?=
 =?us-ascii?Q?Gqb03s5/iR3QbMWLGVTRfkwF/9DPnZEM599nSKLD06c802vsO7Ynuhxkl4A6?=
 =?us-ascii?Q?LRFLbIYl1HGzmqVCx/c2/Rd215jvo3jQYFzCCkzO0TArWVeiXuu2CBW9o6hh?=
 =?us-ascii?Q?eh3Vm5pDlOswR1MeT49dbLbgbTJxrRAC+XR1zCfqHaU5udTLpnFKNKru80nC?=
 =?us-ascii?Q?xTB0pXyKVss2C7izsw+jA+8rjtSTlB59sDDOr0Ip2axp+wXCMVz8gjDlPZ9p?=
 =?us-ascii?Q?L1W1ilLQtUf4T7bM8s1q7h/e6IDGWBuSs5htGTdsCKCBJIsPcOA5z6ZG4s/W?=
 =?us-ascii?Q?n2Hoh1S8Ky9sq4+K2R+0m1qLSp595GhOaJkrMH+VtOQ34cPEwsOryUfSMCCJ?=
 =?us-ascii?Q?lWAiVi9+gyTxCNCl4dETZlwj3BWyQrnwKnrNLqBWcI8u0lGundvjGakgLXLU?=
 =?us-ascii?Q?P03a1afgPH2njO7JyF6Ls4FCJSEQLeBPsNkaUemHzzyMgHL5bBDYrV7dNwjG?=
 =?us-ascii?Q?FRDaYtMg+R8NbFLhKZeg3b3KMKTlMe4tOiKPXzrvxNPi0fdpzTsCqWXd6myp?=
 =?us-ascii?Q?BTGrIAoz22NRV7B7bntJNruo2NGIkpZCdt6OO2b6V/nRPm/C1sn43xkuA0pW?=
 =?us-ascii?Q?WjbVhgcGWeiIkk6U3EvhpZkvjbjl75qVvgJq23DcTnuS7jo2Tw9mD/PLDjky?=
 =?us-ascii?Q?Gz69otgFtaUA+NvfPSD9Km6yGATCmE3NRpeil7GVUaTNrANj9qwAFIB5Mz8+?=
 =?us-ascii?Q?gcoWHTTi88bbfV0EsZC0NVJ51Ui1OjgBjHW5PatAHmEW+GacNft5fekOvL1f?=
 =?us-ascii?Q?3sUqTaR8ArWjrCRKs1GboyJotB6+924c2/6ZoXrTPoznv2z4znahZ6o9EQfE?=
 =?us-ascii?Q?9z/Gv5O9OicEOnL+/s7T+zvOPdWmDCElOWZMv/VjlK68fIEexeygiFnfci8a?=
 =?us-ascii?Q?5XcoL/HBnY9uYmBBag4MBthnIHrb51jrfLusc58CjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/hcVqnoyzcNfOnOi2Nn0iwTgf6eF+dyZJuQtnuadQPZl1X9+bRadxfqfDqF?=
 =?us-ascii?Q?2+FmegrZefTxK+e7ZdXxyqpCs87sMuW3J2YzRFg4NMM6kw1RqcNrxtm7AapC?=
 =?us-ascii?Q?BSWEuhTcZiKDYU72800cXjziwoOqSew/Y+uiSE1pE7EuKV6mNo8Z4pD1M+lf?=
 =?us-ascii?Q?hNoIzPdADjVcK9h6jhyYwBMCh8Fx64m+MlXcmTK1jqi+CV1y6Y5nhUu2Pn5c?=
 =?us-ascii?Q?CLW01F51EtcB5wJvO2PvO80arsLGBbfaR/vxVHSz290wSQETdyvVkn991zq9?=
 =?us-ascii?Q?dZ22oCAFfK1XZgC7YdIgcJktkCSC1dNSZYJSK4SpuB+0ch4y7o5Bu1fD9zAu?=
 =?us-ascii?Q?INBB53PxUzYaoVhoBa3ZYojx+Va+SMo0Pkot3Awn7QelaADi5SWEMQhK4+qu?=
 =?us-ascii?Q?yKf+1HtJpGXGM1fycQGIrs1eKEZUdJhSJJGNaur9X5HRvdNemyypDIcPbXIa?=
 =?us-ascii?Q?Yy6up45BPgFH7214lLcqj7xsyEEg/xk5RYhv/ZQWMlghbLzRp29RvSYOoa+k?=
 =?us-ascii?Q?uxKeXBfyjA1MTL1SPzhL6rs/ZibioeXGl/xG7F3rMp6nW4teJwvp+m9/zakm?=
 =?us-ascii?Q?59woBbiNDIFa0qPMo2N/V2D24czDACIVIgJ7mFH1xZ0zh8Nx+BIDOPvF0qz0?=
 =?us-ascii?Q?ETKDcdFVOZy9eDmJjl60R7Y7+JJTMilafmqxnuTTErDiHWoVWQy7lRQmCmJG?=
 =?us-ascii?Q?dqsM42CkjUEvfClqeHWsz+zqc3ruzcuIjnKNWb87+P3JqoWTCiOpaBOWQh/X?=
 =?us-ascii?Q?xpCtdm3hN3XLBpv0AFhCfIaVG8kwcdost1ChhmUuu4x7nQWb0f1zAnz9VN++?=
 =?us-ascii?Q?ezNdZybx5VLAwdL8JNx4Ut8d5/MZRrsCAacQfvFRjwkS2FvNlRmjPt82tgmR?=
 =?us-ascii?Q?AGfeMdVIij4Pb95sfFiyGwuNLFTCX91bVpTkL00OWpgb4UU5nfbwA4z860AO?=
 =?us-ascii?Q?4SllvCDIBz+g2RnQXRM7vkPcBs9CLdlzQiAnc6K6lGW2iAlihPyiaa0AvPFn?=
 =?us-ascii?Q?6eK3gfhFA0Od4301yo17bxL6NAIiav7N+qp1lxLB3qUqzU1G10MEddpidJjM?=
 =?us-ascii?Q?jRIBZbV0S0CqVec/3ei5tAOsCmWya88sU+WVWkKtu0bOZlhqApTWl4tF92eG?=
 =?us-ascii?Q?/X3JANiA/GMIL/W2/Ut9iwRI5iYnx7ROjcbWRXZp1biMlPrO2eMD/8g+yWlf?=
 =?us-ascii?Q?ZFSvjNoCfoe9PwMX3eWTLVmSZv+I2TKAbLpXiaHxvwZE5k29pwpZcmmW9QiU?=
 =?us-ascii?Q?1Wfbbg5tIgMZRkU36v4f5+NnDgmwVjAuvXO1oduxSom8htMpfb/xMqp+qbTV?=
 =?us-ascii?Q?qI8iQDC55eUJojSfzfCrNdaSt1Akoxqma96sUaXBrzchoJl4ghuRLTP/3ydM?=
 =?us-ascii?Q?h8Acd2lsCbJCZ2TP2T/FZAO0W+0C4XpqyPH7ashCsoU1Ml6rWFilsYeeyj5b?=
 =?us-ascii?Q?sLeHqIEww1B6IaavqRV64MpuymQS0wqcssjeZWOhTofcZCIK2e5BE6jOxFbV?=
 =?us-ascii?Q?X4Qudkij/TKp8w7swfZ+jrS8rjGiEgJmfjGjeTzybt6JRF0wi6zYapEg8c5J?=
 =?us-ascii?Q?wtXBT01DD6Nd2hscloItQ2p5H6yajZOIsI+TUmoI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8465c7fa-ea22-4dfc-cc5f-08dcedcdef1b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:33:11.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us1EK+SDKGAMfjqVqK9lEzAYaBOCmwzBcMFhEThcXL5BFbID1WUlst9/Y/3pTTelQ2PT7YpJInrnzKMeopWS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842

On Sat, Oct 12, 2024 at 12:45:19PM -0500, Mario Limonciello wrote:
> The EPP value doesn't need to be cached to the CPPC request in
> amd_pstate_epp_update_limit() because it's passed as an argument
> at the end to amd_pstate_set_epp() and stored at that time.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for cleaning it up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8d2541f2c74b..90868c8b214e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1528,12 +1528,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  
> -	/* Set initial EPP value */
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		value &= ~GENMASK_ULL(31, 24);
> -		value |= (u64)epp << 24;
> -	}
> -
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	return amd_pstate_set_epp(cpudata, epp);
>  }
> -- 
> 2.43.0
> 

