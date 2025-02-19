Return-Path: <linux-pm+bounces-22378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F99A3B0E1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7175B16B10E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E61B4145;
	Wed, 19 Feb 2025 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Li9qNFQw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DFA1ADC90;
	Wed, 19 Feb 2025 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942672; cv=fail; b=YC+Li7t9bNgNz/xZul0HU40dZ/e5W8INrToWUHY0QW86OH/D6vJI13hQxtDnqcUvB+8iVOQzlXKpxvpxXD1DILGBYpQU7ZY0QXFk/Hi4lcqUMrsWxk5Kl4Xr2TgQZR5cAmTEF4i4EJ/Mp55wYGLwG+SV4vL68bFxahHK+C1cacU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942672; c=relaxed/simple;
	bh=6iHzQfsT7r+g+a5lT8yWrvDPK4rF28/1CFXxXFbLLvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WyzF+bOMz5YuL5kl4ZbeLEpsd4WAaJa+dCU6ggUhRE0wRHfRmfJM2DY5aXJ+zm0Vg3eY4akxQBmz5dOY0vUfUprX3mwG2KCcAp1xpz9GGPFEXMdk5B7RHlKm5yEeyOluyMhHw+IxxH2iwWlFXF0YU1sdd/HWoF2pLVWR9Cnoy68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Li9qNFQw; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGLhdn8E1/phgX/vEOsBiS7lpzADqdiZXUv2AILG0XqfHl801PjNIQc3g+scleqZ9Ly8g9p0P79zdZGOJGMrM7MjfMaM+AyHh1wta1T1C+Q5rPn1TSGs9F2g4nuTS3Sp6JTPWfvWUCmCxGkI0D+iiHEtYHmMudoSk+mxHnQWEt7A7vqhI0h443UJxZWgw/tNKeScdC5bA/WWvCoJZ2yoeAEMSFQm1IB+AjnncsFrdpQylLPqavfHFsRlD21GBc0IgKLHaY4xNQjpS5s7LUhL5Vt+89UjvDbq9PRuenqcZVxA+htXUsLS1ILWALWF+rWy3MhxM3H8hHVs7DXXBLUwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pfq/Klm7pEcvzh4xuRsQ13JI7JgZJ33hsD7KYJHaMc=;
 b=OfCbwQvqhiY9gIa/FE/pkVJgX/TbLqFlkegnUh7l8H+u1qkUk/rQVhIP28I+3yXJkfm+1Wwj3CYnt4e/Ef1qRjyFD3ssQssd5pT38bhFeUiBsDnetZ3f+/Z+Ga3TYA8Ufbipkd3xKc4gKRiYM39WJy8vo3lG9okTmy7p3/tJ11m7mzUIC3SpKe2NJVTFMANjH/NLg3jrYfT+5egc/mwxQ6XRIEPwRHbs6MN7RnqDoQSsaUeaaEcARqAgLhMdpFcuOQ2f233W2aXYSOafB6a3ssTAAFQsdMCY5roMLGDN4/+A+64j3e4m0Jx6aMD1OcxOUU9cRyrBVCm7kFaHN/8TCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pfq/Klm7pEcvzh4xuRsQ13JI7JgZJ33hsD7KYJHaMc=;
 b=Li9qNFQw/o5GENOji10hJnHzFTWXt0zzf5zOn17go1AmIURsH+bTAYoOPUJD68jia8B7uwN1e96QZH9YdXZ00LTCh6DnGXYB0wqmYGAxWZJMqBM28l1YCjRN/stwwgPmwq/wUDdU79Zg1o0y9fa5YuSllfYLp68/r2FO9wsVOso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 05:24:26 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:24:26 +0000
Date: Wed, 19 Feb 2025 10:54:16 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Miroslav Pavleski <miroslav@pavleski.net>
Subject: Re: [PATCH v3 01/18] cpufreq/amd-pstate: Invalidate cppc_req_cached
 during suspend
Message-ID: <Z7VrADfrrPB7GtfX@BLRRASHENOY1.amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217220707.1468365-2-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: a080f473-9c8e-4e86-73bb-08dd50a5ad27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g15XYxW80YbRyrgPlMUjKczGox3tHimOELbvMQmpLafhvXSguYVPEWeyDvnK?=
 =?us-ascii?Q?Q2OqQLGy2qsRRALYVxaXybSIjHxAokiyPZWG4JRRq0vG8BbHiagTddckCfxN?=
 =?us-ascii?Q?pGpzTPqW/0Za+tJZJqeTyYFNz/5b/QgqEfrgu+yGYm4al97HInGf9SyRJbmP?=
 =?us-ascii?Q?WA2xJO8s/eB6J2drEwX84uEVY/DOxpAmCH5j7fQL4VGnlRONrP54Tbu8ruku?=
 =?us-ascii?Q?m/2vZQ5zB6oPBJZEQz4BFojxcySHs7xrVJIW/FFBPnbt/SOeFLW5M5uBksuB?=
 =?us-ascii?Q?dFmJhAuN29xUdxsL81v4Z0GsIjmcPNioRCxJshF0QR21+MpYChTdNq3hRLdl?=
 =?us-ascii?Q?LqF02P/WmzAtCbeZfRTxZF15iERUh+r9GeLIctN9Rpr9e4OwdBxL0wsK003R?=
 =?us-ascii?Q?2xrw+WE4c/81tKMgWqp7y1mQaLoccNqZz7011iY3LKHyFPVtZbPRw/N4J1VH?=
 =?us-ascii?Q?Kb3P8qw1XtGkKgMsWLhgvHqGNWFHbNfyARYilG14ZMIQ5cK80Fh+EjkYRuy5?=
 =?us-ascii?Q?VJmeY9gWQuDbnQV1HB/VZPYJPD56W9oaxb5e3TdNETfXcn0uUl+RdcfB2K6w?=
 =?us-ascii?Q?WKV/Uu9y5SpsXi1YnPaW3mwDXVo9oGpqCpRm9fA9ap+dOMFzBOH7io13R3+q?=
 =?us-ascii?Q?vqSicFQzcld7SFvJuRwEeBxgcGIPx6cwLTnkm7xooZV8htHvvFHujBaQe0Kt?=
 =?us-ascii?Q?gXHBtbg+wZ/SvdDVX5GithOwNAqbPioU4xndLBkAQCQENfYuHPpwZlm4iDn0?=
 =?us-ascii?Q?rP7apsA2bdt9QSQM+B/HRmaJJg2qnvIHZg11fkpGFXEYNkF+zaGvA4/H8MGH?=
 =?us-ascii?Q?VwDURLcZ80fQ3jHwsv+twZourheUjWkVfZbMkWuMYjKfOMutU4UU9rnxxQ9o?=
 =?us-ascii?Q?kRrekpBEH67QjHwgT+rD7IKr6jZb0PePIc2XCT+iqdD7SeE7KN7rU6HbB8cY?=
 =?us-ascii?Q?bjaiBn3jVqokmOExIw5cUyEBI4UG8Zzw/nF+S70pcfZhepRgkx4FLJS7keeq?=
 =?us-ascii?Q?kHC4vOx5ob7O8dd8l4LrcoSjutKB1ncdYpOUWwaN5Qo+x+QEQPR1sXpG2SbN?=
 =?us-ascii?Q?weLpQy95pHT3jSR1E5w+dTT91J8JKk4yifnj49gpEi3QwkSKCMZ2KuNjYqE/?=
 =?us-ascii?Q?Ep1JRdA9kTLCMC5tZX68a0Jun7wZp8lKRgK0so1UygusYOHWWLQ6BZ69mAPT?=
 =?us-ascii?Q?TBqczBfZTFn8UbLuv6vaO6YOKyOYXujicDrXIkKPH5wrgqQISh7315N65iHW?=
 =?us-ascii?Q?Cxzl8QUA7xPIMfPLlTZ21PnAS9U5s78CtHSQLiGmQZv4si5uG8Ianim3sy//?=
 =?us-ascii?Q?CiDoc6QwojM5GmfuSzLCXV1DvGxf8Y4bhfmzoXyOebNBBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZIgNEXNI2KjddBcm40urGLIDp+JevnPUxq6VLGZ86RI2PBOMHjfOy1bEXL8?=
 =?us-ascii?Q?JbKptYmQVRowIhzKZRVeS41oThcOFmsm5iqm4rgLW0lEeVuBFXe+cg7fY6sz?=
 =?us-ascii?Q?rtAQEBTweP7L6C1aOgqjSfWExFx1pcSxO/YKemqxpAkN+jvcXt6G9yykdVKB?=
 =?us-ascii?Q?8pRVVIZDNEHwKC+Q1Yz3DD7+G22hVXviSUhofMYlkMuRF9GmMzqLJcjBv0UP?=
 =?us-ascii?Q?btcHAFV/4hWUWb4qBzzMyLzoY7hBBEVpek2PdcFRbzaAXEDl6OZqs5IrMwau?=
 =?us-ascii?Q?Gchopb9S3M6IM8QvOW5kl/iBKdW87W9a04wjV90ZZ4Q8+kR+7B0rPZE+kceJ?=
 =?us-ascii?Q?h2FHcZ26pWq7ZYqWFJ+trF5+z/jf9FCEcFMFEI9kievJCIxTeJbyLFYaU3dB?=
 =?us-ascii?Q?0LLAnb+yTsko8m40wQ1towwdIUndfMqBsaMBJJe2msZoYVJYZlrU6/SDojsA?=
 =?us-ascii?Q?FGM0yBGsxzNkvoPUqUdu6utonOmw5k4dm4vlXrBGD09UDU8tmVIyEEIUKpzd?=
 =?us-ascii?Q?LERWwtuCdYJFCLt9gnl4LwgcpYgGIMzKFC320gyBcJrzo42lCURr4HDDRfxx?=
 =?us-ascii?Q?xW7uF0EcB9W/FGz5Dcak4rftyi7ZWkbdTZuSQWUvgMX0ATr909lcT4/AJd3o?=
 =?us-ascii?Q?aXkG3IsDQFfQnfT7pbVM3nk8/cXkH+eiUb02AS9SDlcvToclaDlhns0YvETY?=
 =?us-ascii?Q?Sl+OPVKvnrmbVeoOhpLIGPhk2EFkJjlEemM6An7gJAdtWvYDL7WmoTn9yoio?=
 =?us-ascii?Q?4wQNGJH/NY0Kt5Cnz6dHEcVKQmmuncmR8GG7mLOFCYW7K3K4mDB3rt7D1ZGZ?=
 =?us-ascii?Q?3WNv3DKBB4s4R22r07gCMktcA0qAgqcFaEqFWAhm57y56EN86DcHY9EkRxy0?=
 =?us-ascii?Q?0iSPBQy3OcWkEqrBjv9DbB1n2nZJ1AjqcSuPKye+4kOxLKN6XmD/9vp8qsz6?=
 =?us-ascii?Q?Xf3WnpHGXXXahrZyonjInZ8K92nXIOwQQusskXXD5l1t2UEj1qVAcbi63RxN?=
 =?us-ascii?Q?oknXH+QYlF78F6iWUDB5O/TnhEb4LpFeSqLF5EKQf7jGspeKYlhCX1yvU/qj?=
 =?us-ascii?Q?CPubum9zUmUlNrwUDFfFk4JUDxAR4G0qfi+Ez9BgfH2HnQJNTl0vBaCL7qZN?=
 =?us-ascii?Q?zrv12TtyDww/DE1TEzA06MFFiqGKGIhiF1/xKGd2ait6J3Rdpe6J7kCLJ3Sj?=
 =?us-ascii?Q?UXRYkWb1GL/S6Fadrp1y5wPoyWDnj29hV1VyExTR5JKHVmc6ikQNI16rm31y?=
 =?us-ascii?Q?mpcf1USUS2C3953zTXg6CUILytSxPpxZc+sc6Zk+ROv4UdLaJ36FS/yGAykJ?=
 =?us-ascii?Q?SZ6lWP/kROzoORKK9bE59NGj0bd75LzhBu1ScU0liLtOzOzj3Fr02vacxQg6?=
 =?us-ascii?Q?U8oq92/MJj8sfy1X3OAJNviQSkg0ZOUoTIo/IkiWBQWS7zzIK1vqFnyWsS47?=
 =?us-ascii?Q?6kE/0X8neTikC+yyxaVccFxdojEbk4tiqSNFODNkHopQeUTMJF8BUT5lkCRL?=
 =?us-ascii?Q?IhFd9a1jRIRytj4lqeRTKMxHBU7ef5Xj94f/SxJ2hrPmfqqKpbFfuiAyV4+X?=
 =?us-ascii?Q?Vohtrj+iC497fi+4CvGr7ZFBQYs7mgzjYB34PfnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a080f473-9c8e-4e86-73bb-08dd50a5ad27
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:24:26.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmKIYzw2mi0ZoXkfnX8426xAqIskFiMNOGS/tEdmTUnCZH4S218AX3tsX33iN8v4eRhOjyDS+KpVBRYEtMZ38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

Hello Mario,


On Mon, Feb 17, 2025 at 04:06:50PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> During resume it's possible the firmware didn't restore the CPPC request MSR
> but the kernel thinks the values line up. This leads to incorrect performance
> after resume from suspend.
> 
> To fix the issue invalidate the cached value at suspend. During resume use
> the saved values programmed as cached limits.
> 
> Reported-by: Miroslav Pavleski <miroslav@pavleski.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f425fb7ec77d7..12fb63169a24c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1611,7 +1611,7 @@ static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  					  max_perf, policy->boost_enabled);
>  	}

You can also remove the tracing code from amd_pstate_epp_reenable(), i.e,

	if (trace_amd_pstate_epp_perf_enabled()) {
		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
					  cpudata->epp_cached,
					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
					  max_perf, policy->boost_enabled);
	}

Since amd_pstate_epp_update_limit() also has the the tracing code.

The patch looks good to me otherwise.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.



>  
> -	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
> +	return amd_pstate_epp_update_limit(policy);
>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> @@ -1660,6 +1660,9 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	if (cppc_state != AMD_PSTATE_ACTIVE)
>  		return 0;
>  
> +	/* invalidate to ensure it's rewritten during resume */
> +	cpudata->cppc_req_cached = 0;
> +
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -- 
> 2.43.0
> 

