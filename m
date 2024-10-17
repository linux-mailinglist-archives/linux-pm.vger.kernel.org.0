Return-Path: <linux-pm+bounces-15837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A29A1A70
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE1E2826DA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4B174EFA;
	Thu, 17 Oct 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BLA0fel7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40979FD;
	Thu, 17 Oct 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145187; cv=fail; b=MmmLSHmH6j03HNgv7QIAoSbYRdytnYNt1Rg76wWh+eUy/p7JomdGGN7nMfynr94ypg5t+gJkzBkYWD9hsYchhUToA/r+TjnNKlHWA0h7glQvnkZvqw3T2QY9EqJp4tjZLZ0PGJKyIkZyEQgO32f3mjfP0o7ZmBh+y6UomUj9siQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145187; c=relaxed/simple;
	bh=pRBja74G5Btk0yndE0850mnIsNyK3zFLRnqU189smyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJdBSaa/LtqNuXOgeOP9MxWZvPWyz6KJgyvreggS386S4IqEdPqrHa2df1xJOXLJfwHvbRE2VbUbbhPewjqqIMIzzyCx/queiE352jRSkIACi10de06+Jjf89uzJjpezOlDaqwD36NPp783FxloGoiBuzoCBqaAXY57CoFlopB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BLA0fel7; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV27VgnZTZu71qFl1z/MRrEqniAvzx1u0PbkwS/UW///0bb1Xr/0wzCvBIPJwk78jBfUqIXYlmPYBW94lY6Wf+OWO7IQJqRz9VKVOKuHSr4cbJtKbkqRKjYcae3nF7YXk0UrXEETE1AGVMI3tRzEconizaBaUtIYv8PbN/MqclnepnB6h6BLwTiDYMPIUFU+GbyGsHMr9zLguJhBco2rteVvfiiiwrJs4gUvUrWF02A+gjQzKQ9FDDzxtsoRVHtAaK9sbyRuml98nluqRrR1tsFPbrqCvBehZo/UUz/mw8Jt/1F15iQx7YirenQ1VNbYIXNw8Kko99CeGZAWr3Teug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SHwNqoo5U/TVms0j6/VD8t3ElSOTv+c1260Vjzd1IA=;
 b=b3W/b0H/DAL0/of5/f8JdaFBqQi+3JLTKtbUM3Mw5Lmq9wiVFiYxSz1hP6qLDilBaLwmFEx+IMK6Q6RlWpnL1Bo+FLJDgPo2G5rD9Oya6o7iWvWkRMEJnHnM/2vjTr4UxlC6vOVE4iQeo+dqMsI51eiIAV13xpDYyFuf+zwzj9u9r6l22B0KBRH3MLBPkzXAlT6BwA9uAZshbiCVAs/cCM/qYBx+VdXLCS+s6CGwmOVO0/AJ9c6Jy0g2U5lmsIvnJq+8qT9K3Uip2UU05VPhRTCSU86w2L3hCzG+vo8VJbzXYhisp95VZT/JENQbKh18Mgm4hx1t6VXPEJyx3Bo8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SHwNqoo5U/TVms0j6/VD8t3ElSOTv+c1260Vjzd1IA=;
 b=BLA0fel7pitaMFasX4aRmVx623SHk3pLhkWG4c/5+b5+ngkkj95oNu+wW2n4sApDuGV4hLaIkFzX0ZL6Jy+fLx7JiLbPKUBRX2pzkCHId4fW7Yn8Hl8s4/zmk03A4+/w7nfhS5bK4r+9oRB8IhNxQQkQ7FIKpqiBDBGsPm7cu+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Thu, 17 Oct 2024 06:06:22 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 06:06:22 +0000
Date: Thu, 17 Oct 2024 11:36:13 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 10/14] x86/cpu: Enable SD_ASYM_PACKING for DIE Domain
 on AMD Processors
Message-ID: <ZxCpVfcOAn0PYNwa@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-11-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: e06870bf-5548-491b-6904-08dcee71d301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SisjOxTzUnH0Eh+KFdKOzC5AmVTZl7bZmwepeT3At3J4VJ9KZT2rpnW3JsOh?=
 =?us-ascii?Q?bCn4Hox3wWur1YJZ0egyK7bdG/N3iAxClfBs6gwURqC0TRC8NMKy3Rf/RTFj?=
 =?us-ascii?Q?QVRdPs520hKtom1SrP42S/k68v2anyjk8IrSPWPu9McKvlQJFiin2JJFQjXp?=
 =?us-ascii?Q?F7yfJ1xWED9NmkgGZEJ3K/3N9hxkwlrhFrHHMyRKCfH3uZbd+5I5AvvhANNj?=
 =?us-ascii?Q?mGqnFPcOzz3nevnV4wKLHPwdjR4SgEsUTScsMbL5FM6SrlNfNcuo+dUkIJnV?=
 =?us-ascii?Q?cUfX7FuaF/t/5GzTQiJdsbZlQTnULzkLbmeUGpqR+jQlOFWqRwTXHmxEITdR?=
 =?us-ascii?Q?Oa1Kp4zvmCvQQh94ooJlPcmDcCQEgq9IhduXOxk5/YiYEpbQfPX+pQHdDjxY?=
 =?us-ascii?Q?GQ4Wla03lNL1lS2ThFizwlTaPBcGveFBOoQCiKj93Cu/ltrcMMwxdYSu+E1v?=
 =?us-ascii?Q?DXX8Lgvm44CSIiZHVPrDZRYnBbTpGDhUQzBpWn0aw/H2yBrNIeaFLLG9bJB3?=
 =?us-ascii?Q?JgY5sC4exz4eWaZTgZ/3eSu2xNHmJjqp+RdEjgDRTtSONdukhWBKU8KH+q3+?=
 =?us-ascii?Q?j/hR92mBfGzEndgYdhSmIpad4UPADvv9CixK+jYLd7w3GOym2L6OB6M9sSQG?=
 =?us-ascii?Q?KgHLOeRCUkPEUU1SE2CP+nvGvWE/4fpdlYTWq5cMaaedhmhFPi01xdQswVUQ?=
 =?us-ascii?Q?xCti60GPvZ49GvM/8oE8fHmxJ2iWaJ8zr3gMK7cjeZhW+MfMyozk3jQI8QvN?=
 =?us-ascii?Q?aO8bhE7pwNU7JVEe+mTp5Wdr5Y2AzzPrl6ejhjva8Oxfws8NQBvDQygiz8cF?=
 =?us-ascii?Q?3kvwbNFghz7K1w2OEpEwga6bypUazECoWbreHkzdLpNGDdfb8DKwL8zTGMVm?=
 =?us-ascii?Q?1la6Gzd9WnwGhdDkKJRl671MjdxMdL4jP8eprjeGMfJkIpPxfSjqTG+x7VzY?=
 =?us-ascii?Q?BM6N88Gdek5KeW/+P+GIvfIl9nFBKUMeKgTC2wyu2oMnR6l2r7ItIfpPWvWE?=
 =?us-ascii?Q?8cbUo1w+pgfSFlaz4hFiAow4wW9dwnsijUrrw8O5ncTzWodSBpqE3YPDQszL?=
 =?us-ascii?Q?y+14NSldfAJ0FZ3SLfWc+g/FKQ5hcWTgjOms5VcAnoK2uEFEnXTYa5kkCe8A?=
 =?us-ascii?Q?fPyzsSHPgQRB3eKrwV+ZX9lbEuwsxlcT+lNZY+RwRtr+Au/6Ef9nyluqX5wD?=
 =?us-ascii?Q?n6RFPV3Ac7pWtsGvmAKE0wJ2fc/H7tsrzuK+9E+ajIO6ygMe8hzOX7Wgaf1t?=
 =?us-ascii?Q?81M+RrEW2Nr7dC5VCu39/DkFAtYxvnz2za1yE/LKgoUAepcOoQ9n9pSmbNFK?=
 =?us-ascii?Q?pOhBOML+1sjlW9YqvZGHOnOw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jO3vrLfPTAFwuFoimw/BSeoS22RDI3yui5fFUJ+vOBLORrOJSg9fzw5oWb/X?=
 =?us-ascii?Q?W8WOrxw67kkYCIM1Mu4Jzs7dYGb4piQ3QoDVTfypiFQCGO11/gtjg4w0A/2V?=
 =?us-ascii?Q?ZJpQpLrfvlxCjdZm/2HTB2TeCmMqFRJJTdfFJTKRcawOBgP4EX8HhGwASRew?=
 =?us-ascii?Q?Tsa7jjZ5YaEmFK8/66/VqGi1feUXQ+Wm+ZI1WQIyd+11Yds+dknEY32clAmR?=
 =?us-ascii?Q?PyVKeJ7UOTAxQX9BZq33GfgZAsL98I98FqRVL5uJTLZtD5P62gqc6jFAyNbO?=
 =?us-ascii?Q?YvauDWKtY8S89kpgRPEuTuZ2fJoicbFUF2zJsy45dbNMJz7juaMlO8hFfTJy?=
 =?us-ascii?Q?2Bi1TjnWxCcPPLAZV4lWtbXjVjGUnX3c4nqsIuuGU75VFZ79Rz2NmWh+srCr?=
 =?us-ascii?Q?TkVItFouqHgF9Ryfgb+zWGkFq5Dt6MgFzVPpLxGAqxpueSzvYY11KymIksXN?=
 =?us-ascii?Q?uqD9V/bm19wp+9fuK09TzIOmhK2PiIRhJMs0QwrB+IQXMRBUtMHiPr30mbUd?=
 =?us-ascii?Q?vmU9PwGuthY3X2VDI69zDI+ZBimeSTumkxghspTSwzxKfG6uIo0n2PKq29Hw?=
 =?us-ascii?Q?ORTD6uEY4oGz6GWxuXo4+dcBh/KP5jBZbJQ9IfoLrNT6WX70Klue2OJF8Qqz?=
 =?us-ascii?Q?bfKcK8Yd5PzNt1AB0oubNisaFNwG1gwbvKIiLcWgxbXIjowy6wnY6MpkCS3a?=
 =?us-ascii?Q?Wvtlzu9mkHGt+8fc/JRmWrZNMelYzteFgwTOUF9sor72ywP7P5AmAJGPhL5y?=
 =?us-ascii?Q?ZFAMKQN2vGQKNvXTQU/ZUMcQniPHCJSRMkpoFw0gfP9RadKVrT8I8hmB3TAX?=
 =?us-ascii?Q?bAmNB/NBaK8DYwCWIG4QneNzGh2nxpPv/Y5Yq9+QCvpdN39CoAaWJIbJqsMV?=
 =?us-ascii?Q?yJa6HHQnZbqJqLNLgYXoalMbp8HSRMSj6bMTxjOoHjWsK1WStNUEu7IiKjut?=
 =?us-ascii?Q?Zjy4RwzbyFYu9zplrOfQ8dYi/fcCik+2A/LBj3bg+QbWA1RyMt49VAWvsJVG?=
 =?us-ascii?Q?qGXHrYCwwwYtt0SAXn6JIR1PMGnUfbm4niF5u7cdu+h/mLnv32vmG6zWsDK6?=
 =?us-ascii?Q?GTjC8OTamcDWGh4tKeZWB8QSgJcTSf2xbqAJIAqTFSeJZGGvuUw8CxT8iAqT?=
 =?us-ascii?Q?FwxQ58lOVybRsgi33VahQMnZvPIlus3kD12PyRPD2ukkaBUXrRKWv/VLIw8S?=
 =?us-ascii?Q?okrhoKxIg+lkObgThLEguAB9wKnkmzTyLFDVi3axt3hKEbMHR2fTjrjUk71p?=
 =?us-ascii?Q?Bcz4Ci5YBwLw6J9RMIpVKQrYUrikwa20LIMo2r/MsIziK2d0u9HkQ4l1X8FS?=
 =?us-ascii?Q?chONW0PSXCFzDywHF0WAuNKZtAmt30xVOQzY2hlbBEpzjiC0g8BphcUL0vLd?=
 =?us-ascii?Q?IqzY04DFmvKPie93rbSzqz0Ldln095ThEMfDj9+m6w/PahQS3xzx08y3EhIt?=
 =?us-ascii?Q?JvyrTexCei/tBNQvpXhPnysY7fzJFMPJUw3zFjV005cGh4iJrvm12QjVdkp2?=
 =?us-ascii?Q?iiDNkIJZ5u2L2NQ6JuPWoyqbpH6bZKYGSb9IRjLVxaO3COsEM4O9f1sYbN/3?=
 =?us-ascii?Q?AhhjaafYjLk20bhpGBHLUmd1gPnwUfw1X/SRxKYS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06870bf-5548-491b-6904-08dcee71d301
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:06:22.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNGSIg4LBPkkr3s7b5wAdF+HEMSTsnjxV4FOyhgSj4VjC21r85xVgBWnAfU2tRGvhniMdoCQCgKP/oFzRInEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

On Tue, Oct 15, 2024 at 04:36:41PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Enable the SD_ASYM_PACKING domain flag for the DIE domain on AMD

Nit: It is called the PKG domain now instead of the DIE domain.

# grep . /sys/kernel/debug/sched/domains/cpu0/domain*/name
/sys/kernel/debug/sched/domains/cpu0/domain0/name:SMT
/sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
/sys/kernel/debug/sched/domains/cpu0/domain2/name:PKG <----
/sys/kernel/debug/sched/domains/cpu0/domain3/name:NUMA


> heterogeneous processors.
> This flag is beneficial for processors with one or more CCDs and
> relies on x86_sched_itmt_flags().
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me otherwise.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  arch/x86/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 766f092dab80..c01bb75d0375 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
>  
>  static int x86_die_flags(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -	       return x86_sched_itmt_flags();
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
> +	    cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
> +		return x86_sched_itmt_flags();
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

