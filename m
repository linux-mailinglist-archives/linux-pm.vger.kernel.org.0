Return-Path: <linux-pm+bounces-11294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F388938B95
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830191C210EA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D51662FA;
	Mon, 22 Jul 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qebawem7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BC8F66;
	Mon, 22 Jul 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638574; cv=fail; b=P4xUNnd821qOVu+RXmRCRCJ4sQex0XaQ4ta4Ky4Exe6a0apSIhEtZfUS8evMAeM1afvroCu7dQY6IB/WKg/eM44Qv9PZHOC0DCU2SoF/j6D11+Q0LHVLW0BpFRx1NXQX7y1SZyvHabJAYve+Nnr+yAwK25AKqQ/mV81uWFn5IoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638574; c=relaxed/simple;
	bh=sClSnud+qijmY6oyRRmDQ1wrqXvAXO6uc0mcSlkg3Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IEBm9VRgBifK/WKZiazqFHiKeNPtdmL1mHEdZOjWnP9oo/rga95xWy/oqUeUlkelhO90APlRfKVUTOG9nPVoDC/o01NGN71xN0Bv3wuN/suadGkS1RynTq25WzNdvMeXjIf1fP3g4ZF9hWIRiHb4pFhB4/kZINlF9KrL44+ef0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qebawem7; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQw/VpK2U6/v9hHLEM+e8t9/+KnD5EpObGuvPYJzGJH8EENiVLzJF3Gvp5V8mSnjfgQJ5/j40fL8DFsTD9/O1OfnLj7nVkYmu55/OFF4dvsR2k7Xe5SnPVBkeTTk7I3Wv8rOsYT7gtlasWWbulTnSqL7Jy/kI9FsKIcBIiCPzI1v09e2/2qPae5EWrgNoOEzBjO13oj4TujqQTgiLfxEUAOF4JnAHb5pMH3nYBvy+AL13BZ/wBOxlZzmeWky7slG85MT+UBq3EUsIvL88CD/84aNzNpopzn/HY4AzCaZic8HGWVVA9KAt9LTWT868QJKTP6WLhKgeVJ0hfqGraAPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsUJIddy8HA1doLAtEWzzbyQKWn1aFLHhnf8XsBHc0s=;
 b=YP3gXw78QoQ85umkSrWUMfW68iLNmtKmtvORsCTy0igFHJE9HLeEpdllEY4D9leb8xaHtvfnsob5Uh/Wpx7fDBRnRxcG7fuH27zN26BdE/epfty1TLR6Fo1VQmC3CK/eduGXX45G87+XICXTwQeT7BOpUQffhSKRn9V62LNUtkg3hvhdktPkjZmwlQsAKAi/6hjP3w5seDalf4tmrC2cVGpabyQiswOuhn3pOvs4s3jFdX2hY6P42Cac91wC5s+vfkXTjgf6eEBatdTh2bTzL6kHXbnAZB6ro5Vmj9AQeVjVXbULvruwxf9iMoq55nqQ0YHRFaqyZxxjJyGNaiR50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsUJIddy8HA1doLAtEWzzbyQKWn1aFLHhnf8XsBHc0s=;
 b=Qebawem7SmWMPULdC1skVioQuQ6YgrYtftcWOgHbnHapncSDDrKt5u5OU5BedbPXBySGcWw+77JRRb+UXVvLUnzs6E8yrWkZ/sOzOgVQFiaWd/5cuRnmhi7QtWrK6+bdHEmObEEpEEXMDDYnhsIkj84+qWeTnp6W0ewFHLgUfkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 08:56:07 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 08:56:07 +0000
Date: Mon, 22 Jul 2024 14:25:52 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
 amd_pstate_cpu_boost_update()
Message-ID: <Zp4emEks9X5jL1x7@BLRRASHENOY1.amd.com>
References: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1cca01-ce9b-4e84-a29d-08dcaa2c1fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRl21oJ4U4txV89RoAu1dSzCK2vqgm10gPxNHDrIj6WLWX2EnRWmbZbdwwLB?=
 =?us-ascii?Q?bq3LDddqWZGen/Aln7QtsFodkDEMcQqsjEWZt8uLPlhldWCMGQOKevD71ia9?=
 =?us-ascii?Q?1az27L9MUxyRmN9hxrX39HsxThapgf1n8Kag5FlFXnFzWG0nG+4cA9jADJ93?=
 =?us-ascii?Q?+9KzWx0CPsa74BRtJoMPMO3CKKrEmBWfvqL6ewmzg111zgGSEb8QMy9ic66v?=
 =?us-ascii?Q?aWMueQeK7RItpX9uK4HIP+LDtmb9CUB1olI4Bt+G+x5P0cpHU4PHorTq+j5Y?=
 =?us-ascii?Q?M+dydqQo9P7+GobieLTqxj0p8JjB5mJmSQKg3B5hyyNjP8c5msJdKru9QbiJ?=
 =?us-ascii?Q?vsT7IR48MM3785PDzz9Z3r4f3P8pzcTnNmFNnMYDodfWygRspJ27Vtk0MaIr?=
 =?us-ascii?Q?eIhp5GQxNZEjBbDbZXMND4lLXwS3jFFoNIerytqZ44O4JtR/SP+lGh/RGoKb?=
 =?us-ascii?Q?JzTSiKE1AKsnGjsxugU4Nizu1BQbd+pKYzfA2jYDtFEHWBy2dXGaBW/48H4W?=
 =?us-ascii?Q?pHGvsvDDe5ZC/211ijLvYj39WCQziR+mc+oap7K0APdq6orDPcp2HnKFLPsp?=
 =?us-ascii?Q?Ol49pi/XUjGf5Y69DWriyyiYwmuNjMFbusFQf3q1m2IdUfOdXiAQF8Hn/yfb?=
 =?us-ascii?Q?lWvM9X08w2W4EWo/fmcprN85biL7CgSDOkcOu4HTNxl64Al2BJ8vLWPBzzHH?=
 =?us-ascii?Q?J9d4AOyNX/Z/upn70m8rpkLIC1/6HkcxuT1zJk8NMwILuokefATWM8pgopqU?=
 =?us-ascii?Q?RXpEfHVnIlDHWxe5I8ITLY63iELqpUYB7wIk7Fy9wmRqYRwnK4w62+AhVDU7?=
 =?us-ascii?Q?RnS8z4elC7Ni33vMsevkML1P1lDRnFmRuoIP6v4rYsNjtgB14WPHMaV9BJEu?=
 =?us-ascii?Q?fG/eZgC7FB/BOit7AnutJhFR1u8S8kYAS+N0cI7hWLYoZ47H2wc30zLECSsz?=
 =?us-ascii?Q?C9JLiOH4DBiIBhS3gsDdO+Ds9gH23BZPq3ofPjJgd4ZkzOa+XL0CfIOfBiK2?=
 =?us-ascii?Q?0OHqTcAXp5qSmwfAEwqUgmsrp1p1UPdLVKBhlqjpSfzNAucQUsIt8bgNEib9?=
 =?us-ascii?Q?7cKWwqPi3243336EVkTdWQivMmBGYprNVGjz2RcDZwFV8BMrruGOrOxw1LFR?=
 =?us-ascii?Q?NpDazT/qWjoRGPEEST/sgpwSEGimfDbH3GCDwtYy3v3TqCRhe1Nm2xe8x6DP?=
 =?us-ascii?Q?paMW84uvxNZSkwpB7hDklKImE/7UrL+uAUTUFMsXCMd9+c6NhpsEakmGTnmm?=
 =?us-ascii?Q?MKwnvRfOTi3BV7HpCbojsAQW9ZvLh2e7YV7PegCasPx/ZNDExVm24fgjLdJm?=
 =?us-ascii?Q?PVNRChMLRAwyS0Xkjr3ZY/gWFejVs38SapAXADqaP+n1ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZctrMkvX0GKKCNBaSl5A4hT2UcB9irlxebQFnuYW+cJQUfE0Ek5aNVLzcvH/?=
 =?us-ascii?Q?FDzMq2WxjnrJ0/8OmBa+v4KH0zV1kCGvX49jXtiJSn0BPkb2d9Ikv2aHyaCe?=
 =?us-ascii?Q?y3Lp+gtz7hq5KDhnuPCoMQu7DN+h+QXLTT82wy2VfuOSrwqTMQHfBhtl4kPt?=
 =?us-ascii?Q?Vjijvp+bzTnr8lyusunOeJbNvyPMm2iAjxRY5chDYnSSuhejiT59jAEy54G3?=
 =?us-ascii?Q?jIwDgQ8FTIrsZVKeubcYfV75ACUC5cIXL907SY35F0V7ZmjLNQkS2cI9pt6O?=
 =?us-ascii?Q?/NmRjEiHHsS2mkBYpxTc8jUjgPoDmuw6iQO113D447hdWEEpB6I7RYxR2Z4z?=
 =?us-ascii?Q?yjAqh7mpqy7Z3J9dobvDDDfirD6pt+7Qb3JPqXhgjCx54frl3fdD5c4j5+Uh?=
 =?us-ascii?Q?pz7qtbJZ7YHSvlEmn1ltTVzbPuhE5+t+dgpeKObENo0nOYxBfLQMbw9NYHIn?=
 =?us-ascii?Q?1DuVnXW0NPIog4J09plOI2CaN5lZgGk/VOGSb7DFpFyHVFNvWWOy3zH+zc0d?=
 =?us-ascii?Q?++mzzcx3xBliB71m/7i1ZqaYKlRT9kKNMicHX9tEL57h3LTGcOshRfsGD8oh?=
 =?us-ascii?Q?UeSCOCw7dIVZDfOp8qm5oPFHbN1QHyOdA3PuT1bvq7q/wd3ezupSozeBwa3o?=
 =?us-ascii?Q?whUQV4yUR17/Orke7pVufe9xscYBPpDCPYJCkcOAYYgLtz2t91H4sICcoxWu?=
 =?us-ascii?Q?70PTa3ApGlXzbWUE0oN4w2wdMNhWUUYHvkMqd+wp+AnJHBkjbnMi2pGpqYut?=
 =?us-ascii?Q?1GoKNw/REEM9bFpJ+gcK/U9RBQWDVAi1pm3Uz0ohGyJtVZ9SWS9+Cs1q52Q2?=
 =?us-ascii?Q?ZyabcQ8E3vfz1F3hGGgZYyifTmTjJ/Jpz2Pt6xcqqhGnWdxXixI4f2p+2qxW?=
 =?us-ascii?Q?0RZzGf5rYTMCD2rX4Q+rOSKqFazecfrVzLfufCSZzJi/65G9hh6iRtAovcPW?=
 =?us-ascii?Q?N7xr8TrI18ozCooRXlpvVShWbwIEZctXDQO9DHARi3oqWPV/YKdbGjOQB71Q?=
 =?us-ascii?Q?NlfftVzhCa89SGB0pSIJessC0uouHys/Do0l+5IyHoeeFM9Vkrk4S7GJ9M5g?=
 =?us-ascii?Q?FGkCo+xupOLQfGoCj7lcir+CnMu68gDjE+tuKYMTm7ZO0wlQm5tdLPfGnQr5?=
 =?us-ascii?Q?dc3uOo2xvhXpKwoe7sv2c/BAyQ9PHVh91WCIwEKWSwrt27cHwwT7O91MQ3FY?=
 =?us-ascii?Q?vc8cKm96oP0z7vCdP9F9MfOfNvaHHgExuw+XGO9lKDXIYvL0/XZ5M+2uVJjV?=
 =?us-ascii?Q?bjWySsPuhlIxhToxewQZUJhmf+zmvvEfXm1ti4lo4vEp0eMeYIGzv+yDvCYO?=
 =?us-ascii?Q?KT/qn5PbU5ChNccpzq/jM92Wzx1C0+J8VoaJQG0McydRCAImVIdfWGN6uyHr?=
 =?us-ascii?Q?4J8Y+oBtWkx1NL6w4b0khNi9M9cFbDFfiH5eDjtTacwKLACrH8IURexos1OW?=
 =?us-ascii?Q?rZ+lDJL4nSg99z30fss3VWO5IHKaO3A/ID4doeHaaDS3QokQgQy2WNRCLWwo?=
 =?us-ascii?Q?Zp/BlH2FLjzI51LC5YpyLg3IMYLckLtsqzfssxLicFQvFbupJlcgBp8gnWwF?=
 =?us-ascii?Q?i+iCOuOUicytpHwI+Cig1L+MGjF+Uqy3eNErr9OG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1cca01-ce9b-4e84-a29d-08dcaa2c1fda
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:56:07.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KVJ+WQ2i01n44sDymYz0Y36v3WbhCzOijw7rit2Rl16x/U+DiKpNHh9iDDcShycAdCvyT28lQeFpn4ILlrF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

Hello Dan,


On Thu, Jul 18, 2024 at 03:08:36PM -0500, Dan Carpenter wrote:
> Smatch complains that "ret" could be uninitialized:
> 
>   drivers/cpufreq/amd-pstate.c:734 amd_pstate_cpu_boost_update()
>   error: uninitialized symbol 'ret'.
> 
> This seems like it probably is a real issue.  Initialize "ret" to zero to
> be safe.


Thanks for catching this. Yes, it is a real issue on MSR based
platforms when the amd-pstate driver is not in the passive mode.

> 
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..358bd88cd0c5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -692,7 +692,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
>  	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> -	int ret;
> +	int ret = 0;
>  
>  	highest_perf = READ_ONCE(cpudata->highest_perf);
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -- 
> 2.43.0
> 

