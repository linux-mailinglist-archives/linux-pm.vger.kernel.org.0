Return-Path: <linux-pm+bounces-8186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2F8D0676
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7523C1C223C8
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FA61FD8;
	Mon, 27 May 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IwehchWC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE026292;
	Mon, 27 May 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824736; cv=fail; b=Rd44YEppg6NB8xMPXWft/iu263XqHtyXEb9qchh9nIGV7T1QTWEa0PUnRKsGqX55I77kQNvhsqBLTimyEUa1gRjfpFBr6hhXhPIhS3j9E1Baq7mXCo6CaijSqITMpY5U8UGxKNbkqBCnFEX+jHkgu1cvm1dDf9EiWnoFfBdPpeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824736; c=relaxed/simple;
	bh=5u09ktOlF8cTqlzFKS5PzPp7j+CwC6s7Vw/RSBuO4m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hoahKGXWUCkvVjKpVXTZ3eAWRDDKoxaxFvXw6RYf8KvDghW0xi81pZ8k1793+Nm1Rgu5u8N4QRsxUNTbBNdMRTGraNZjMDXY0ZxAzLLDdDPdElQ3YIi4ixfdg4p+iB38SHqWh2Baz9mc01T0B/WDPG5AiYuZPHHw79Za65UEDj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IwehchWC; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfnfIKley2Z1HSejidh7x6pJ0HRP3rRfvZ9Z8k/YV3Esi61el75SCZEC/44ykiatbCMgbzDJawqMh+rGywpTpK4CaC9bppF1U0direkqOOkmorsRY0BVJyfv3gvP8uf8GVWJK732rCARdiw0pbRYYNMSHPhPeZV6wIQ2/TxIPXoHH5K6H173PkFmHKwyMa1gcJLnICfjFUX94rHLnDjOUoQqkNrd7N17oxWv/r7izkisZdoVzPa8ky5d3quBOk80Yay/z87B1S0jSRXRCsFCLWlBrgdP0VtZ4QpnXtIggEHb2LjKKZVyGLKkGTsxQ9R5WGplGjTgJWJSynTHncB6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX0gdfU4UYutgW7hyuwEsIyvqaZdThbGw33r+PJHkGg=;
 b=RQKqzLB67N2He/VC2r6A5szmQw2BCnxAeeWKge9gdr6U2Kgl5ngbVL0jm3uVphJJ54jnH6NjrANwpjt+zAx7vcXaBGDGyeyi6PLvjlQ4biODoBff24Lo8dNhR3TZlC7rt7u0rrTLb1kbrlTT39KCe2/2fHOyD/rbX1rFK3/HUdfTtqj9FJcqpPqfmYDn4xJpkzlSOqF9Z2TQdBYBcpTNogmDQ62JonMNp0c5cU+2RG38VRjrvdHyPhKHN5b64E43Y+744CxktJtpTtQ5unvFHrJMILkE40VvuL6ThidlLZuGmuJfqmJZFhCLWD8TeatKM8QiD9IqXA+wXQzbMe6ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX0gdfU4UYutgW7hyuwEsIyvqaZdThbGw33r+PJHkGg=;
 b=IwehchWCL3CGdbt950Ij/l5cTK8dNlBnSI9E+LN5ZapfmOT6d5CkVPeJL1EyHbXro0OWUlpo8Wm8bzIuwyf03qzdfMyaD/w8Duy7praMvFG58UvN2LEAfBDQ/ZOWwbNDuvlZ3lf5GU6dqzLnVLlwsTU6ghjlKQ417pqo7mZW38A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 15:45:32 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:45:31 +0000
Date: Mon, 27 May 2024 21:15:29 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, rafael@kernel.org,
	ray.huang@amd.com, viresh.kumar@linaro.org, ananth.narayan@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH] cpufreq: amd-pstate: Fix the inconsistency in max
 frequency units
Message-ID: <ZlSqmYDaPNE8jybO@BLR-5CG11610CF.amd.com>
References: <20240527051128.110091-1-Dhananjay.Ugwekar@amd.com>
 <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929aec0d-690b-4277-90b0-d0b4adb437d3@amd.com>
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7969f2-3124-4aa1-b3bc-08dc7e640a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3x3q+x3NEkY8zhXKXAYc86AhY7r5a7o0FBnocOsU3G6b4Uvl8nDdnTd8wCT?=
 =?us-ascii?Q?rJJNtwKW+MG5zj4ATH1vv7pG38y+AAoLeoKAWgrA0Jd7fJpPYLm8HPEKrnIF?=
 =?us-ascii?Q?JqClEhiRAuakFB2AkgjBrbjVwVGlZ7ehQnEcL8wN23zk2OuE4PXny0GD7/Ro?=
 =?us-ascii?Q?SiENuB26Aa12Sc5aqDWIL9+cv5dktHukOQfpbJNhGTg7P/lNE4+Htr5UdrbP?=
 =?us-ascii?Q?vcA+BJuRjqHKb+Yih3Oa4b9g4T3W4bWHUHAxB1MfnKjSLuZcjIwsEF+Svoff?=
 =?us-ascii?Q?gRlgwVXhYOo1cjBISoqrjfLFR5+q8/b4HpO0DxwlRrNGSfMPLyaK3RykStzF?=
 =?us-ascii?Q?Egg1FMEYY1Px60MeUivptP04AfLtkjELyox7Clybt/5RVXMMoZ2+df4CB4hw?=
 =?us-ascii?Q?38i65EZKw93IZVA4koXsz6UdvptiyRwvn9et6LrYtVc+LC+uqHRNYos+RT4J?=
 =?us-ascii?Q?vQ8PoA+hb+Wwpr9EqIRfa030CmJnuotD9+uIYQ0BEjr6W6PG/FzUSYPAEOS3?=
 =?us-ascii?Q?edBTyJRk+bzpsfeMW7IleV9XBsoO1yFKmeIpCDd5ErIfbvD6tDDCXjy5udyh?=
 =?us-ascii?Q?Pzv7NFNbS7EDslI9ws/7Z5EQ0r0yu+rcl5RPpBZzmP3yNxjUdk8nwscVBOh1?=
 =?us-ascii?Q?FQHZ+i8mvtphrYsZtazoKGTG8a9It17Ra220lojTvCAqtLvAU4AhUxYzzLVw?=
 =?us-ascii?Q?gW5TcXybVnZvSxd8y+MkxvuO4zP7Gx0Kyeb8Wq8uJPNfGmAaupRuCtn1pJ7K?=
 =?us-ascii?Q?xSmHA3rDzyb9sStSrn/ZPXqVMz6ptx4CG48ooS73Ph8QM/7RBJZ6AkvDHAxY?=
 =?us-ascii?Q?2mFqQ3pLh2tTV7r7BygW/kiWwCzog0F89HLLjIqLW/Yzc7165/WyQFpqTQ0r?=
 =?us-ascii?Q?FbJBQaG7TrskZZECavapY/9Dkt9SaL7+CuUZ0lu/NdoqNpCM7XEEkKmMO7+G?=
 =?us-ascii?Q?7c2hyZzcM1BxE8AHU7LJ4P78n4Z5CSP0ffA9nDZs/r+TGos2TCefc/P9Nhop?=
 =?us-ascii?Q?tQdFkoGcYXj6TMWZuSj8YhnaPFKLiq+ksfzEMmoeca3NToelgLFq7A4PlaaZ?=
 =?us-ascii?Q?TOmdQgZfhGH9+kuM09eUHLK8HSWZx05S++kH7XN+4/w21zORNz11u44zhNhY?=
 =?us-ascii?Q?V7ICwspUfimo6f0GxTCYHx4hboeAVowsOvWtE2Y7zci6xiaVoc9c9LkuatUn?=
 =?us-ascii?Q?4Xuw2OST8DR4EQfQAdpV+1BlJCa1Mvz+MZLb1mF6vQ+BzqJRvcUaRubmjHbU?=
 =?us-ascii?Q?X7NQx8VGeRy6eZhX+nPoaPvK39X1Xgyv4S+7W4mHSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WozrBNoG9EdkR/KrwkvJbF0OGUsLPxll9o2FlWA7PHWHobfIc/owYtWs0+v9?=
 =?us-ascii?Q?uYOOuq89mbjhoGkcor6wmFNtyRAuiFSpF7qrT4KOhXX5AZ+SZbwuGBJjeTsi?=
 =?us-ascii?Q?CJHKDoo5ddx6pFl+ymVGUEdcDfNcI9x3DqRdrEaXFAHbZjPfSTwHcLpMA/B0?=
 =?us-ascii?Q?eCtarnUAaPJyAXmK+EdHYsjXfqma9gCFv7ilVp2+vgBJgeCvbv9Ysz7eq7YK?=
 =?us-ascii?Q?va6cMlxJHmL3JQBvwHxU5ChqtuhKXIOYSHQqprKhXRX9jtmSrN6sOR7XMjUO?=
 =?us-ascii?Q?z3GN6NG3Ui0YfgHXeWH+5QsKFXSN8GmeCmFxoTwJ4VbwsnJyfcdf4gBzs6aH?=
 =?us-ascii?Q?i81YfVkdOPv31llZ5VHnp3SHvzcbOnX3079lHezHoFxMRGg+/5tFhc4l5N70?=
 =?us-ascii?Q?eo0QzkDzJKg80sFiL8+ITnf8FZkrq4KY1igIIGfXqF+e8OLPOOvNfzraBNcX?=
 =?us-ascii?Q?EVbetRyzXutoBHXkveUjBOCVoRMgnP6B1pbAYjh8zY9k+q6gOcnJEeNpax3g?=
 =?us-ascii?Q?W4hRo3Q6vn7FbCsjpbGw4ghTq+kcDac31CR2Il16G6WaCdj5R2/UFdXk2OoM?=
 =?us-ascii?Q?8xIyFvVlvRY9StC3gJ6BWPkrkcWMzXlgb6aCykqA9KTptDZ9uc+QbVRNYc+N?=
 =?us-ascii?Q?EIeU+XxB2WWciW6W3j/vFT15f/BR0/32ITvc6n6TFgyVWgyNifZc2K9YAO5P?=
 =?us-ascii?Q?m5uzTx6xbBbEIPkJ4ROEo6TBt6uYeVrNubAzu4g8iM6dN+64XZzqrwICAtO/?=
 =?us-ascii?Q?JsRg2bDg4/RFcMiP319rRP5UNm8atWkxSgmOwjyqT9WZR3hldiJzCYXkvjYA?=
 =?us-ascii?Q?Yi/X01SlCTOWzfqf9Hs7xTw5JqcJjW04qdHBdSbBug2sh3hPUouEL4DnmYd+?=
 =?us-ascii?Q?APGehVxrddUOILtyRwc2ROfX/NgwbcdDF+kdBxXeFg8m7FCy1Uncd2JcJ1kO?=
 =?us-ascii?Q?qCfcV4P8bB/Cwe1UeBr8IV6IsxfvctItPT0g0Liq2n1GfYi1w/BrcStwJ9pj?=
 =?us-ascii?Q?fvvYQO5xQMLnjFE+/fnjA4SbDN130fTPqoD/Dr9asgVtaVjDsMHTTIatFVg0?=
 =?us-ascii?Q?fN4S7RSlujSrcUtUJ2jizwCEns7tK0BVt7Bv+tfxvdmQOJRfEaIdneRo0gEh?=
 =?us-ascii?Q?qbm7ARAwbYwsZbqAh3i0/V9CWC8QQRuB3beOVACWJMH6Tx1tTNTa9o8NRh8F?=
 =?us-ascii?Q?QPL04hDbL0lcFgj2DjRWA6yz+DnPtsjtfRqJ2kzmUSBgTK8y843m36YRucBk?=
 =?us-ascii?Q?SkXXj8NuXWBTJ+lHaDAb6yCqnCK5SC0J9gH7waHfHtAKht7NDwEuZI5OteGl?=
 =?us-ascii?Q?ho/umeYgOmAxIefwSCVDdcwPcZR2exMLiESZ+3bf6raEnUX9jmb8H6Vs/UL/?=
 =?us-ascii?Q?W0Z8LcPscnDQUuTi4FPcEmOQH+G4lUvojiBGxR/UPP/Rz31zOg3GZ1mnv08u?=
 =?us-ascii?Q?TqEept6Kdr6ay8IqAFsc7MakeQsbQSMqu2tcgyfwxej7Rguel/aTLX4+E5gu?=
 =?us-ascii?Q?tceBFGfhPm2+3SWPuxOdbdteAqIt2OL4u5Qim+rVhqU4W5F+7hkRn/C6TJd9?=
 =?us-ascii?Q?YGfllxJ146mstiLTx/0UqB0Z1z7tUNqKIFYY41a1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7969f2-3124-4aa1-b3bc-08dc7e640a57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 15:45:31.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8Bfe6hTlTwoX4agAIwYpi6qzIotJ+Rf6Vzmh5B/zB1iRZPEPaiVs9mj1BV4QA0pb6PXViMcxR3a8yz2X5v7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520


On Mon, May 27, 2024 at 09:40:21AM -0500, Mario Limonciello wrote:
> On 5/27/2024 00:11, Dhananjay Ugwekar wrote:
> > The nominal frequency in cpudata is maintained in MHz whereas all other
> > frequencies are in KHz. This means we have to convert nominal frequency
> > value to KHz before we do any interaction with other frequency values.
> > 
> > In amd_pstate_set_boost(), this conversion from MHz to KHz is missed,
> > fix that.
> > 
> > Tested on a AMD Zen4 EPYC server
> > 
> > Before:
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> > 2151
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> > 400000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> > 2151
> > 409422
> > 
> > After:
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq | uniq
> > 2151000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_min_freq | uniq
> > 400000
> > $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq | uniq
> > 2151000
> > 1799527
> > 
> 
> Cc: stable@vger.kernel.org
> 
> > Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> > Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> > ---
> >   drivers/cpufreq/amd-pstate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 1b7e82a0ad2e..cde3b91b4422 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -669,7 +669,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> >   	if (state)
> >   		policy->cpuinfo.max_freq = cpudata->max_freq;
> >   	else
> > -		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> > +		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> >   	policy->max = policy->cpuinfo.max_freq;
> 

