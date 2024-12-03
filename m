Return-Path: <linux-pm+bounces-18399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990879E1285
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 05:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2681A283302
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FEE2E64A;
	Tue,  3 Dec 2024 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AGyL2rh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47B17C68;
	Tue,  3 Dec 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201351; cv=fail; b=MsdEYcQ76prl9drSttAb/FQXs17r102y9QDjIfZpoiNGaFjohnrmn40Z5QRycKEQyj9TEPLCLCjZOA43VA4x19F1Ywc9shpX8KksVFHRPqTYGpF1cDrWqqqA/Wl4b4CHLh2V25Gw1SCci7rSoDSBu8/E/PLcjBMAttUL04u5lUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201351; c=relaxed/simple;
	bh=va47yGNpuOqIbMqOLPma/oA4Ffwk9oBSJ4FJvkOzSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tEVeY2mSzwp70LNOAp7BM10XE5FRTaxDgZSe3b1BX8KI/N+7wo3dh8nxEmFN24A5F9Mkd9V7pnRmbKZw3r+NgubMYKBX2Po1gdLZN/6AY1UjqWaXjygKJiv+fWKUthvMhUMe341XI1PE+eOM3y+OPzxC0DThV9kKbxap7rV4S9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AGyL2rh/; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1xJtnpfZXycUE8+tPpeiBRYCy0Nex7imt8VireU0v21kB3cur84vNHwuZOqXUcFLNxDcfuOO20XUEqafGcKfXZ9D5iKuseeOco4TUjtAGTXJ/vXmpzmOwVtnPbamdoYJaeLUkE+S14hmii1yKhdYGN7ZgI/HdlcZ9BZoGJYY+bin2DLN/lUYndWTW3O8d3Ji7jJ3Gl2asc4HiuAUu7sxf92lH8m2jPzOoZfVDVlrbn1PQzyQPupCUQ7C8f/BMgSo6waln8bQ5yIRNsO4dr6O7nFK/NjaanhjZEgGsTYLtuyeOzejFCZla81UOWe5eD3T+mjEa1XHJ0PN2EK/ZFpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQJ0I4h8yhqiPjLnHUElRiVsJJvWMU4RbSahBFTEPnM=;
 b=eP3a/kmtSz9ZCX3kIBZYFACGiJltNyeRVlTv2A04LUPHiwCE6m+Dj7HnJiLcrPFyivrS+e+GmL2tpZ03yc0k3lAqDbgwVwBg/rJioufa321LiS8bsbS5pzwvJzH9tEqmqiOZ1+4oHZ5vKdQLP1NatroJdeZUsCgbTVMZF8K4fQRguQQI/4KignZM0UObIqc3ZIuL6ZsXnLq90ek/+a89SqyYTvJAVEYnw6bPIMmCxRxwfTN19vsgig4e6CssNYUMzrPIauQ6MBJ0wqsONONmtrU6/HERjIudPDnS2bkezNh+z330z9wO6IDEaQ11bhp4wNF9gHKbWMipU7grecCHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQJ0I4h8yhqiPjLnHUElRiVsJJvWMU4RbSahBFTEPnM=;
 b=AGyL2rh/oyUI8CXfKcV/HZUQzedfaVqfhcnPHaiCHoRaO7V5Zmin1AoOcLhCO9/jjJtLdMT+kue9gkQ2bL1UmsOU7nVZCA/sSSl/2SuljD7Zck2P97xJd/ltmp3cV2cWU31B/hD/H8TtjYMLyEJQu2ORIQb7aSECBrpUjgR0Gcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 3 Dec
 2024 04:49:07 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:49:07 +0000
Date: Tue, 3 Dec 2024 10:18:58 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v7 4/4] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <Z06Nup3JOp+V8i86@BLRRASHENOY1.amd.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-5-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129182232.14987-5-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN2PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f6b45f-7803-4456-a100-08dd1355d1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzW40tlDgcWu8Fp2KevQ0+485DkP/acXxY9ak2LPhQcK4Qko+5cuJMmU46f8?=
 =?us-ascii?Q?vOYu2we7qnBV/jVN65jHaYHK1+U0HPS5zChOzTlvumWAjjTE0Dm6BaVaYyGU?=
 =?us-ascii?Q?c9ILvfx7dzjziW/l7wZhsTjrQi8688rIEPPkdE9xn4AmJzw2+5D5zg/7g4zD?=
 =?us-ascii?Q?Cs9NzwfqUoh2e5BAv5+Gf9h00JNgugaLdRiwiIqCuFMqRQ/7fzm9T2DlEPfV?=
 =?us-ascii?Q?zm39EQ7KcHBRFAxZ5ABuBZUpsZiRSj9bEAE0n1McfrtmMWwUm+xtUlSM/pwB?=
 =?us-ascii?Q?OJaiAST8e21gTgEkM7JEq4d9n3Zkro8cOL9nKiRyy2LHO6NQIRi9YdeQBoW+?=
 =?us-ascii?Q?wThtgbo65H4vEc5WRf+Eb4qwQw/Y/T92f2/GpHJSQVa1R8xetKKmvSoEVi5L?=
 =?us-ascii?Q?n/6Jtjke3yaw/lmxIdpl5tP/HMMol6IJe5xa1UBN7r7mRVoGdRqS9BuREOV8?=
 =?us-ascii?Q?r7OKqwK4e1LYJMG6GlWQopxw+blg5Td09RLPm8b+cPDeFCwzIjLjBO+kI7vl?=
 =?us-ascii?Q?LY/xsmG/fN/oLQNuv6IFtmGGGdY/KyvqAMBMgDphuTicLd58Y33j0bXna3e7?=
 =?us-ascii?Q?6WXkciAg6oA9RuXsc6yrylBXOKzoSBOFGroAh0MK4N7BSVSX07Yf2QulEyAA?=
 =?us-ascii?Q?1IC1vCyziWTGnlbT6SAWvzwa/Q0BSb169MG/4I1Hl19XM+OzcTiuCHMDS27H?=
 =?us-ascii?Q?BfqgSFTG7REXd1xcMy88lzmnfSA3l+/TK4YW91p2ruCfavLCCwDR84Toth07?=
 =?us-ascii?Q?zi9NwmuzTDE89oVnRbTu9CJrvNjWoWf3+Evnwl3IZsbdgZsn3Ql3QbsPXGjZ?=
 =?us-ascii?Q?yvlSvNOCHieIUGATOSbXghP3Hi7yMOPU0Z7Zx6/383zdVS4jmQ25c6sR5Ekl?=
 =?us-ascii?Q?Hk1PKRZLv+bU68ZjS7DNh4S12DbJaBu2tPfbyM4PX/NV8Fgj+xS7kz3neLVw?=
 =?us-ascii?Q?LBFTvT99Hus8nQ1jlaUnBEY7eNLivL30mIMHpFuSwzTa2sGfyGGCUcKSdv2E?=
 =?us-ascii?Q?JFhnG5sLESfhv9wr+0FKKaQvF1wJ22ruH/d/inF3OwtaeZqgavAblHI5wHO/?=
 =?us-ascii?Q?t4tgAKVaS3ZqeR3noQktr2/NnICJ8Hb9R0Jaj8KXqTXP6Mv3LCZEkOiyOcsQ?=
 =?us-ascii?Q?w9Bo8Um9QSfds1NSfsquRuutsw22XIRTTa5EXB0fox6XPIE+IUCs9NZUW2op?=
 =?us-ascii?Q?QEPVT8y62JyuxL3rDbFfvKpQeB4sXAO8chggxocHCyXp8kyyGSZKTclhs/Hw?=
 =?us-ascii?Q?ZztLYQhE7eoCOOdgqh5/l3oSCxJn/B8yj7SJzCptf3rQwHxK+ygnYmSLzIzz?=
 =?us-ascii?Q?p0GHdY1VLowwMTEuEhKBogk9g/Sq1hbXjmlBGc/7NbJkig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+USGY13DdXQpARMql1KcVBXcwvS9UeMNWMG49kUvQUjlS1Y6iissfqwlqgrb?=
 =?us-ascii?Q?pO4PdGTm4EvpbHMza6Eolk31DzrVgnreqwA7qAOgd9UvgYtEuE8YMbjbi25C?=
 =?us-ascii?Q?QAMwAZXekI7x+BAgG2LpHZVJ5oKBdG9qO8VKxkDVhNSltHMPNsIzBnLi2Rto?=
 =?us-ascii?Q?KFu+d+GZtGhnbg8hHlC6kh1gKwM7deDaIdQr+TqEQwY+d6XXJ+k+Sg2EisDr?=
 =?us-ascii?Q?yl3L18w7DMzIbWpJ/xqCoDavOI5lO4Q7j84NiCAG2wNdWP8FSkhs5/aF04bO?=
 =?us-ascii?Q?n57Yb8SYZt4DHKDXhtGSK5iTVlqeK4uDSViE6htdnyOWNEh1QwMIpMPLkvvi?=
 =?us-ascii?Q?YOhSJ2uhClTAj16XiTiY+u2NT0WdMWmXpk1Z1A4D8106LOGxyqRKmzwKN1Sf?=
 =?us-ascii?Q?TwM7NRsf/sDwKqZRADkHlLoEloVnMJN0HhGy71Tmv7/0Ofw4WviXQ6fgVvS2?=
 =?us-ascii?Q?JXSQ2coAg8FuKcmVZ23dxyk5KS/Z8dRwAGQQjYOmjv8az8t4su/k5wDDT8Ds?=
 =?us-ascii?Q?gGkSsGUN1cL2qZUttkdT0YKARfp8cWGVtcb0DQbsXYIjPu9XwhzWn0D1qGHx?=
 =?us-ascii?Q?0MVTWp04H7zPCFumSkev9Z9qgXFUDkgmb9Ztx7U+EPiHDQDUJ5AOrScg/zbz?=
 =?us-ascii?Q?a8ZwEYe15CzrMJpNVGG5+zR6WY6Elzk8kEYYNhkNNpZTl8W1/lqubV3Bi+9M?=
 =?us-ascii?Q?MAWEy02XfVsMJzpMS8nBqAz6qgRdLMSPP/EUvUhfKIvLHG/TJTxMobLqGgd+?=
 =?us-ascii?Q?eoz5pXRM7b73+OwfCqlJffZeluh9W+FVkcyRgjA1A2dzAUStFAclINhmIH5U?=
 =?us-ascii?Q?MxinPwwzMvNbqGjX76bu2SsCq9RSYuccYfVP89uu9IWc9SRuwISQVLvwujrj?=
 =?us-ascii?Q?48Kj/2oBrRH1JA6L3AYyVLSagZeKDVDELExLLqR3P0yKpm9cbk0ID+/ff78M?=
 =?us-ascii?Q?OLclfy/ykN9o2ZeQYRAM/fGY9t6NTZ584gw2V8Di9WFvSZs7yUhT03TgL1+x?=
 =?us-ascii?Q?V5ME3scyStgHOO1baz2UBrTdNbCxR2r/q4cV79i8/Ei/u47LK5vX6iPQssvC?=
 =?us-ascii?Q?rssm9KIrPx/Mo1TCJiTdcxVnqv8yVwjm3kBM9md4dMIvehUP1hb8sCfoXAlf?=
 =?us-ascii?Q?opLyr+op77ApY5O1D25L/MxaHVfaIQNiXq0SeJM/jW6wW+6s4XI3n2KTUsEe?=
 =?us-ascii?Q?On8ow78hp9QO9h3sfNdPZgtpo5POSwkMsxA63PBFjfVp4HVcGLWfEuWxGGlb?=
 =?us-ascii?Q?J1g4/+1kTf3ZqxjZn3apSXfMloP0TiIE9ESzLIPePPb7YYDfe0jSiWpUc8Be?=
 =?us-ascii?Q?nNDG/L7gCUiGoz76Be+1fZ5cNxZ49+52yAzqx8C2nvQuT5ZQnuFwW3f9chX2?=
 =?us-ascii?Q?JL9U4PrXUdzJYkfRuefcx1sgZGOtMIlnz7LdDIQrYX6g/w3ST2DFLQi3iwzX?=
 =?us-ascii?Q?A7mmFqqR29b9iTdbS//mnHlYdXMxW4UD6UjKKOG3vRoGjYRw2KlTRNpHa3RM?=
 =?us-ascii?Q?0gmNU08xxrDbeDn+YwwGlHFfNotHxMRWYpsSOf/w+3SV2NhtlVtXDTCL4dV7?=
 =?us-ascii?Q?x/JbrbrokHmvpPwnIy3oygJFZSj7wOvzOpGUXvcv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f6b45f-7803-4456-a100-08dd1355d1d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 04:49:07.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdvvmnPIv6p+GTQkzKYOt9hfgt732SGWvsnX17VtX2seGTe3ytaWbd1pquMt4dHqEX5GEL+uBZd0sQ0i7xTW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093

Hello Patryk,

On Fri, Nov 29, 2024 at 07:22:32PM +0100, Patryk Wlazlyn wrote:

A couple of minor nits in the commit log:

> The current algorithm* for looking up the mwait hint for the deepest
> cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
             ^^^^^^^^^^^^^^^^^
	     mwait_play_dead_cpuid_hint() after the rename in Patch 1.
	     

> calculates the mwait hint based on the number of reported substates.
> This approach depends on the hints associated with them to be continuous
> in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
> is not met on the recent Intel platforms.
> 
>  * The current algorithm is implemented in the for loop inspecting edx
>    in mwait_play_dead().
> 
> For example, Intel's Sierra Forest report two cstates with two substates
> each in cpuid leaf 0x5:
> 
>   Name*   target cstate    target subcstate (mwait hint)
>   ===========================================================
>   C1      0x00             0x00
>   C1E     0x00             0x01
> 
>   --      0x10             ----
> 
>   C6S     0x20             0x22
>   C6P     0x20             0x23
> 
>   --      0x30             ----
> 
>   /* No more (sub)states all the way down to the end. */
>   ===========================================================
> 
>    * Names of the cstates are not included in the CPUID leaf 0x5, they are
>      taken from the product specific documentation.
> 
> Notice that hints 0x20 and 0x21 are skipped entirely for the target
> cstate 0x20 (C6), being a cause of the problem for the current cpuid
> leaf 0x5 algorithm.
> 
> Remove the old implementation of play_dead MWAIT hint calculation based
> on the CPUID leaf 0x5 in mwait_play_dead() and delegate calling of the
                           ^^^^^^^^^^^^^^^^^
                           mwait_play_dead_cpuid_hint()
			   
> mwait_play_dead_with_hint() to the idle driver.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  mwait_play_dead()


This should work since both acpi-idle and intel-idle drivers now
support the .enter_dead() callbacks for FFh idle states.


Otherwise, the patch looks good to me. Feel free to add the following
tag in the next version.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 56 +++++----------------------------------
>  1 file changed, 7 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 8a3545c2cae9..82801137486d 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1272,6 +1272,10 @@ void play_dead_common(void)
>  	local_irq_disable();
>  }
>  
> +/*
> + * We need to flush the caches before going to sleep, lest we have
> + * dirty data in our caches when we come back up.
> + */
>  void __noreturn mwait_play_dead(unsigned int eax_hint)
>  {
>  	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
> @@ -1317,52 +1321,6 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
>  	}
>  }
>  
> -/*
> - * We need to flush the caches before going to sleep, lest we have
> - * dirty data in our caches when we come back up.
> - */
> -static inline void mwait_play_dead_cpuid_hint(void)
> -{
> -	unsigned int eax, ebx, ecx, edx;
> -	unsigned int highest_cstate = 0;
> -	unsigned int highest_subcstate = 0;
> -	int i;
> -
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> -	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> -		return;
> -	if (!this_cpu_has(X86_FEATURE_MWAIT))
> -		return;
> -	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> -		return;
> -	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
> -		return;
> -
> -	eax = CPUID_MWAIT_LEAF;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -
> -	/*
> -	 * eax will be 0 if EDX enumeration is not valid.
> -	 * Initialized below to cstate, sub_cstate value when EDX is valid.
> -	 */
> -	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
> -		eax = 0;
> -	} else {
> -		edx >>= MWAIT_SUBSTATE_SIZE;
> -		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
> -			if (edx & MWAIT_SUBSTATE_MASK) {
> -				highest_cstate = i;
> -				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
> -			}
> -		}
> -		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
> -			(highest_subcstate - 1);
> -	}
> -
> -	mwait_play_dead(eax);
> -}
> -
>  /*
>   * Kick all "offline" CPUs out of mwait on kexec(). See comment in
>   * mwait_play_dead().
> @@ -1413,9 +1371,9 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead_cpuid_hint();
> -	if (cpuidle_play_dead())
> -		hlt_play_dead();
> +	/* Below returns only on error. */
> +	cpuidle_play_dead();
> +	hlt_play_dead();
>  }
>  
>  #else /* ... !CONFIG_HOTPLUG_CPU */
> -- 
> 2.47.1
> 

