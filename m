Return-Path: <linux-pm+bounces-15755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861729A06D4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93E61C22161
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EA206079;
	Wed, 16 Oct 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XkGRoV47"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C33206071;
	Wed, 16 Oct 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073706; cv=fail; b=IkwR5kLWO8Ui/ttnEb/kGv2VMaC8tmLsuJaFrclrpYimQNUjcWcLSShVwanQt+fXUkeR9c+DubZE1z8L7VQuSMXykevhW1BfE5HLsJpr18bdUbDAXucYZI3F+N/upziD21bkpCnBj8wS6sQrQ+z1ldvycLsujoEZlmt+vRInCQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073706; c=relaxed/simple;
	bh=xiftLz9619rFx22DSahPNOiopbuqGlz2awJ5ufmdhiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LmMuBNuxBgsZsiWL2OhAGIopQ8leUNlFrrYNwmcVPwxvEH7PFmNtYHaC1hXNdS4O8tOj22r2vhVO17NUwwixd7a8QbHvOwA+X3Miyeq0Ddfmf9RhJZH3pt9qpReZB3xeAC93bSlK2iz9mcWwkdIPfzkwLZ77bB45viEuYAYU0l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XkGRoV47; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIotK9pWv73FXa2BYiPJH5Xdt2oQNuN/phsgtdV04Ao54BUuBdOqA9n1tRVxYne8KMMhsF6dl1X2mH0Z2y4IwZeIhgdLkS/+8aX+GozLVEZt5/zuZd2khDmUuS0R/apUBgKt+4WYFCeec9tgI3ZeVzGUgp4jwSINwRI4j5LBSeyuHY9wxGdEBemKppwj/Czv8Hec5bAUA7LUqw4uPpoILOtegX7TnqLkGH3XHufBz4bap/cTSMyDsXncZGXvUBjAB6q9a26qfwn3cDILQvjTF2SZltPAdqcg2iCLMk79QRijSNqvVvu4+Qt+R4FNLFRKCgs9XVGwNLXqJJo4iWVRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOp8w+pu4oNBbKDmBLTK+2kSG/yIl24z5JXJYLMQsaY=;
 b=SLGpxV5cXE8VaObcty0Qw0HtJlUpVo1cPqvrbbrDX37XlLZxrSEnY0XuNrJ79yRip4uxhlxeROL0zLbxjn8QyPFJXQgkfBfCQzusr0dDXIEKpkHjXOQF9kxxaMKSvxIhGR/XoYxDPwDV5Gmdy9iLitqhLSKa1yCnjlxp1LAlHGSzBEYyhYIEjmokzdzJDEsDR1JWW2Of/waf0hyNbK1lOL8hU/QMPosSDofxjrCzqZCJsNA6IBqP0J2WSErUX1zkb7j9ZjZoniHDVlCno2QunyxOMmAl2cTgxEnx17OzADNTVlYRqQPFmpqUHlvuOw9MzvFZMi6cuRC8V3ywNhBa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOp8w+pu4oNBbKDmBLTK+2kSG/yIl24z5JXJYLMQsaY=;
 b=XkGRoV478nFPoHA4Fa9ray+Trz+0M6q8mZ2YXxakn7SAxJivxalPwxXHHfwzpwWsvV/0u4a9qxCbNafhL6DQz72w+u5rBjXfv86BXxXFoinMidMNDjkLtzlik+49m0Hlxn6B2lrYOduy70vbJu4/+HBPyrjk1KYGBC5HhgdlhDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 10:15:01 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:15:01 +0000
Date: Wed, 16 Oct 2024 15:44:51 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 3/4] cpufreq/amd-pstate: Use
 amd_pstate_update_min_max_limit() for EPP limits
Message-ID: <Zw+SG3QKITR4TCRw@BLRRASHENOY1.amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012174519.897-3-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: be8751e2-afc3-4efa-ee03-08dcedcb654c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5EzHxmLXbFOuCv1aEUagAmZKnBRQT6ya7av+SVMzwf7dkSiFuis9+ECj8uv?=
 =?us-ascii?Q?CZyXSaH9G3pAB/iYO+c5EFyrRlsipGKpu6VZ4W6fV1dkY+rrCkuPAZoXjyti?=
 =?us-ascii?Q?XZaouzt/Lrtc867sbm8LRsR5eOKFDurOZHIB2uyJk6GwyvDBs8n7PzgJgxg3?=
 =?us-ascii?Q?7U4mUSe2AEnIPc1h9uIUvJ/expF4Hh7CJbmSEeUSBuKh9l4aw8mgNDnkIh1B?=
 =?us-ascii?Q?4HNKFCr9TdUX2l6ZJ8+Z5A1waY+lY7uCc5giWmWR9wxDDnRiPOehXJ6r5OdL?=
 =?us-ascii?Q?KVgrxrZAtNxnClBb6xnqTfX/pV4CWExOrJpSwWDUtoE+KkqkdwkAPGTqzN3x?=
 =?us-ascii?Q?R4uZu0ji3YmbKP6v42Yi7LaGxkbtqZCtVStQaGSyvuNt3/19iCVy3+9kIVfG?=
 =?us-ascii?Q?Baw4mJpsMKuXoJzW7q5S0F+QVjrLMYZpdpADXIwqQg5KogJ3DXzfX9YxX5aZ?=
 =?us-ascii?Q?3RqR6THkmTCJLp15AH0jxTsgPeD44bu6CTa5/IOb31HOR/G2AteXXw0csidX?=
 =?us-ascii?Q?yuKTQ4rxtAWqVAhdjeXrC0EsEZcVOuw+isl9nLWAu+2YFRfEHDFyf2K662p0?=
 =?us-ascii?Q?X8FDY2YRsfHt8jdEh1iEQwu/OXc9JVqyx0/bvbBRxgfaNBMc0Aywu03PCzZU?=
 =?us-ascii?Q?lBIbqL7mT0joC2zSJgQONLc7k8tFNo7S6JlGTVNKokPSCjO2kWvZ77LeOnZP?=
 =?us-ascii?Q?LS7558v3/d6sk0AiRNEn8fMYKbH7NuW8Bbd11okUir4ZwHYO+QLd2jY6kCh/?=
 =?us-ascii?Q?DFqllgNuK1+Z7GCqxF6u6mJKY0VP9O3cLe+x+uCurMGyH3ol2YrBT+XlfeiT?=
 =?us-ascii?Q?gggyqqZb6kQPSaAph+nxNcUMKj9GqMPSZQfGDgejmg/33HZT1o3MdvmY4HwJ?=
 =?us-ascii?Q?7XB45eUQ2Ub8tDAnKlPGHG79pzluJ2HlgqsDvLxP6Zr/rxnv78xH6CwJ/Ejn?=
 =?us-ascii?Q?IFnCXiaoQM9zQndAHV5XbRAuz3bfnZq97BGHHeTzEO19QwEIN4mOCnc+K84g?=
 =?us-ascii?Q?LNhQr3DNoF/+kbL60Smz8z5dT0KsG12K3Jo2Kyo8cEVvaOfYlfXR2UWbE0xB?=
 =?us-ascii?Q?aq3czCfM8oDR3JamFrp71QwVpkaykmcGuO20CDWW27a4k5Wbm10XeYPbvlUK?=
 =?us-ascii?Q?Tesra6TTaBFzeZVEjPDwV5VMPQL1SgdgG1Km4qsmDugGJvoaLdKOZVLQ8l/i?=
 =?us-ascii?Q?Yp5DtHaXWeWIGI0wa0d+oGw+G4KykIcYx+FwIQZKAz/J7eZEMIznIZLH+tZ0?=
 =?us-ascii?Q?VfIFNFIAzNyYeN6AXUfJPjVG1pqTxe74B10PQlRNsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyH6Un8nxhgZLKmIHfNldxujwdWKasYsGHuxFkcR48MTXkCbTtJXitJEKzW9?=
 =?us-ascii?Q?2qrrsFMDRIjGnX73Hs4ocVDuiJ2z1ghMIX/anHIJrDPB01TpvH2HU5cFTDGj?=
 =?us-ascii?Q?4Q0VDSRBFX7uDmynwE2BazYF8Hm8yROxPVRpqcigx7rh67RpKbhLyB9WvPYa?=
 =?us-ascii?Q?MapxcaZNM9uNqRs76uBcIpQ2mHDpmdppMGEeF9/bLlX+h6ruVfxiyW/3T+Mj?=
 =?us-ascii?Q?+IFyqAmjglx0bwvt5fxZg4cqGhFxScUU4IMGT7SwuHGW0aP0mwbpXnOIrGDN?=
 =?us-ascii?Q?mHGYaBRMhoXmGFtb+H9UxLt5y7ufETlPdy3hDp6Xl4r1hqFAW0Qebe8VJhQD?=
 =?us-ascii?Q?ZcYTdcaewIIhiewhGnC6MRya8Qh049fjgsyMuviautdYzTEDYxZJY95FWW/g?=
 =?us-ascii?Q?+mk1Ma6gi0W7DkFnQl/SgovvYbsgzb55j3HtlMndei8AaqUoxjdflQVReqjU?=
 =?us-ascii?Q?v986NfF33eNt4YLJQ7wvtfkztufu2k/ccknuW5UuAquKEPCXdPhh2PMsNKqo?=
 =?us-ascii?Q?0xqsDK0ScBBnHMSjI1rVTAj3uD4J4BDFx5ELsKo8Y6RPc0DOJvtSoQcxWIMz?=
 =?us-ascii?Q?G6hqAorIJ+MFTpAX/ebRK53IvZH9m6w0e12VHERz/klrbXac5aglmYJw7JSd?=
 =?us-ascii?Q?HZPoqUCgnlpTNjr2NMhXYKN4FxVrjMHSAz8uAePLXbVYHjArIy/Dcf+D0NKn?=
 =?us-ascii?Q?RWpouWLa1meQIIYT/VkBK7qvfhGgyNHGCOBoG33Zvhr/SOq78WQrFTCisMyx?=
 =?us-ascii?Q?0wGyb1ezo/OPGbrIWeKIbdBaEKNTK+vUKmqUH0Cv10QofW1feX8Kiokx4xIi?=
 =?us-ascii?Q?L5+bxINB1StbzoE3/UpUdvmvIeaK+KwzBmPSIrp/1MyuFlWdr3wmfr2FcmD6?=
 =?us-ascii?Q?jWy4VBtMc+a6cFMCzARjoiiguHra083g3d9XTp/qVP9zDhP+EeGVhFumh2uu?=
 =?us-ascii?Q?JQH0SXEPI1ulXcTUjXfwSpKfTm8GfCnXviOhY6W+gwUCXffXg7+Z7E8c0A13?=
 =?us-ascii?Q?/BErmrVpHjfvpOTgcHJY6/Slfd/Y2R7Rpq6XUJbE0bV/8RANtBEizHTCg0He?=
 =?us-ascii?Q?OMwRxhnfgMb+1C9VfahDV9r9RBfUJ49hu52yWvS4k/uEwAILkd2FPd+ZIErU?=
 =?us-ascii?Q?05/8Qc7YNad4Wwr3jsegZ8vfcZbKc1cBlyJax90DBCgw8749X+eCsaiKMuj6?=
 =?us-ascii?Q?qV909xwASFF2LuK8IyccZVw+MVNP5uet0hPSpZKgzE1KdXD3/uS9Ro6m51nf?=
 =?us-ascii?Q?Ql8ZYS76TtJ3h8ZTaunwq7otFfoHeqMFrYl95b2hJcmmdJ56kHwhqc17gpPV?=
 =?us-ascii?Q?8m2UDBu4Td/kjyG2xpmGUaR6c4RPmBNQrFqiANsQjrclcWcAz5XviB43QzzV?=
 =?us-ascii?Q?cmq/48urD0hc8v7WrI2c1Va1L5Wb+eKrUG64CLB1KQWbov8Xvm2TeFpUMIb8?=
 =?us-ascii?Q?rpCiswO3rgKsdH6AR+Kyrok42Yv/OdYF2suuwREl4v4ZcAVcGJfI0JKIraXI?=
 =?us-ascii?Q?SRcgpyeosrKKxqDjZGBa53iPnX4DFOxezOvqbR0O8/MzMdljrEf7xKRbCp9q?=
 =?us-ascii?Q?D6pDhk14Or3mQtTvq4o5njIyVJR6NRhtKyooKEPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8751e2-afc3-4efa-ee03-08dcedcb654c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:15:01.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4F5G8QnuHHbDxSfCJ227F3XV7+YQvJSQyzwCjTj0tHyX66QVw1K/wCJ06QUC4+n6TQLDj0oe45V/LfJLMhl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

Hello Mario,

On Sat, Oct 12, 2024 at 12:45:18PM -0500, Mario Limonciello wrote:
> When the EPP updates are set the maximum capable frequency for the
> CPU is used to set the upper limit instead of that of the policy.
> 
> Adjust amd_pstate_epp_update_limit() to reuse policy calculation code
> from amd_pstate_update_min_max_limit().
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 13dec8b1e7a8..8d2541f2c74b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1485,26 +1485,13 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
> +	u32 max_perf, min_perf;
>  	u64 value;
>  	s16 epp;
>  
> -	if (cpudata->boost_supported && !policy->boost_enabled)
> -		max_perf = READ_ONCE(cpudata->nominal_perf);
> -	else
> -		max_perf = READ_ONCE(cpudata->highest_perf);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
>  	min_perf = READ_ONCE(cpudata->lowest_perf);
> -	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
> -	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
> -
> -	if (min_limit_perf < min_perf)
> -		min_limit_perf = min_perf;
> -
> -	if (max_limit_perf < min_limit_perf)
> -		max_limit_perf = min_limit_perf;
> -
> -	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +	amd_pstate_update_min_max_limit(policy);
>  
>  	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>  			cpudata->max_limit_perf);
> -- 
> 2.43.0
> 

