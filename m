Return-Path: <linux-pm+bounces-16473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C99B09D4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFA284672
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA4D18660B;
	Fri, 25 Oct 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FQYy+FGu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55C70830;
	Fri, 25 Oct 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873461; cv=fail; b=iOMftnCdaeF8LU7PY2Ht3cj7mfso2tuuvmIZ6d0Eku8pQg+uxefUotIY8ocirJFbFwyY9AGJmrMhcHIeuEPy3Z2gr2VLNC2FUbH1TZTjFbufj8Y91DknX+Fdt53pTZftVphWL5uoTYcI2ogRaCgpCvPxCmQybE3tHxP2kzRssWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873461; c=relaxed/simple;
	bh=oNw0FBzBk3hCU8KMD0sblU/bCWAOKdN+ihV/rl2KlWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KfOdAUMaQ28im8ulSHZ1VohbD3wNK10Hw2YAbOBkQt3wmAGU0aiVtZGCerrnFck4lvWw6//q89027id11SWjlGQgc93j1+gI/eOkNY7Rhjr9AgDkjmWhzFbQtKQVeHuIFovHg2Zh/xv0j83czDFOmzow6t1cpYhskmYJvLAN7TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FQYy+FGu; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdbUagQgsXJsBmUi0WL/jE+CsPI6ayGp+aobCWDiZY6KYCd3zt2zMXZ2oQdaWwZwa7ko4LqQQbvUi9zvCVdPdYWWzXcyWHcCcva9wYxq5B6SRB9DrxYlSLjNEa2+C3GxB7YiLc2/TQOWRJzHWF7KROu4tsm4sm76AlP2RrcX6UlNTSy3zjg/moPs2kDFCiuau2Fki9s/lLUN7ByKdA0OC4bsWB/npRpfPxyfggWzqd7LPlo6AbcgyEfCx+NotkgbP1u4KsrmudEVqNQp64/XoYUPcFYgURadcHcYMiuFqEitzCs+IixPGfbfevvetC9w8yzD08/bURq531ljM6y9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsMdh2EDVNNn2f/Gx+2EWuyJhBHWCi5V4bOYJw6jnsc=;
 b=WkzqMBHn5EypdyqoPE9qeFWQ69r/REOVNAHM+jkWtyAmTHemXbmIlCJNP97lqMIKFNdlP3sYZu2ok39TkI+VgEnELCJCcXvo9jjb5eTDgmZzsUITkxfgilWPK8XQlOmwPpLjCiGCjy+goGTMx4nYI4yQVPPMAK9qm3Lh5Nk/k3BTI6sqad7IVxggyLe6nGFdObMtV8EyYcOmOiHI/FRTJmUcC+8rteE9KBZQJkZXMWiJS9bzSzuIl0dDTdxtEB9f5BRwdWxLlm9LR/m45V1V6eGZKb3uDGpyuVWqym6zEiLHy7lDxM8NUwhK5RB/9o+6+AsXxcaMNn00h4BLbw5ySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsMdh2EDVNNn2f/Gx+2EWuyJhBHWCi5V4bOYJw6jnsc=;
 b=FQYy+FGuwzAIIGJaUDc/T101jAA2cbQsjRIl9G0snkPXhQBEWnK2Gr6Eu75Jh8Dw1P5BqYJhC5wDYG73fq6Sj2JF1ZvrG8Al7db0Qr30ls31A2tXEwtrFtfUpBowdEH3ysSt8I7IB824IRLcNd9X/Srn50VpqXeuh1rVGOZuGR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 16:24:12 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 16:24:11 +0000
Date: Fri, 25 Oct 2024 21:54:03 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cpufreq/amd-pstate: Do not attempt to clear
 MSR_AMD_CPPC_ENABLE
Message-ID: <ZxvGI0qob6YQT+YO@BLRRASHENOY1.amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
 <20241023102108.5980-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102108.5980-3-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN1PEPF000067F9.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::30) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: fd153319-cbab-4883-59ad-08dcf511750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzTo8a4PZpG2T3uYh/JG/lgfm2K0ppt4b7zZQOCav9E+OesaHY1siAeFRbdh?=
 =?us-ascii?Q?MXblHWqDgVElCIZpr5uEYEAY/TqLdy3GtFYbjSFFNM5iObHnH7q2rfuf9H+b?=
 =?us-ascii?Q?2yQzbx+NqZl9CFcp5CTLWXA1ZOKbUsSYu9HmAuxOZuD0+yc1VE0l20ikWPvY?=
 =?us-ascii?Q?BtgDlqnt/O9Cg/zqGQcbO5lx9qJKzYaF2bVpKqBCfL3qD42Szz5bO/vE/GbV?=
 =?us-ascii?Q?K5HVO6PhCUXo6s+FQ0DKB9NalOvDQhOULeL5ASfVnlbbyZEphKkD2r5rTVJ5?=
 =?us-ascii?Q?vDl9Wv9MltNtehUIZTODMFoSUioc0Eslw1+C9TCbwoEscKI59cf7vkRZSka6?=
 =?us-ascii?Q?r4yYohY0F0aznZE5jroXjBylfDEJNwNpGKLqy6/P0fIm/ccmTNN6x+apopF8?=
 =?us-ascii?Q?FKFs7EStgmZtasg4W73xanlsVFfJ5HI4r0nYtNVvNvYfquvS61oY6SvcnpVm?=
 =?us-ascii?Q?kqiB9YsYQHIc0CKZEZ8QHZ2OV/cHNLmwTYSapqjbzH3Qfcn4Kwu5jISzZaM5?=
 =?us-ascii?Q?/zssH49EQda8wKNU/C9x4EyYfGSNaqCCOgOKqlqdiO/PqTIlrqsYAiJrRtU1?=
 =?us-ascii?Q?E+7MNcwbsaFe7Pnm6+MgjRCPCMrwudyGX7evz1lQOhK3Vds86zDhhE/7M0GW?=
 =?us-ascii?Q?KHAns5kSmf14gHsb/7L0l4QaGrylEUo/0KPtgdj08mgIaXMtMnyQmz5IaCjQ?=
 =?us-ascii?Q?Ks8AcVPARj9q2sA5V82Z+yukGATCJ8llAJEB0Su2IzORJ8oOYzMWJZGz0dKR?=
 =?us-ascii?Q?iwXWpyomuzkmidN2WYyhwc3NT8phclkVNxonkP15nCVJ6Kkuw0xoUDDPYw+e?=
 =?us-ascii?Q?Lp42fhubZJgAtGf8rurTaMkubTvQaaTw0c4jTdBU/gVGc7mLN7dKi0dq0+1H?=
 =?us-ascii?Q?YkjHFQCHK4guDay74P8AO/jqBYbgVeA6nnnzkzy00rD1a5QcN2bwOYqaRnC4?=
 =?us-ascii?Q?NOn2UMe0yc483qMk2FCQiEbUw8nSLbZ5KANJ+iei2erTdSM7/j8XYNnyK4n2?=
 =?us-ascii?Q?0/SXGaBV96rm1hCsnLcf9xpWhG2o22PxkshyuCdr15P3CWH3yRQF3TQb3kdi?=
 =?us-ascii?Q?mjDNcDmJbx5/uxK4wucYUB25r9QIR3UrvPED8zuwEb8jYJmcnuiBcYNIwpGk?=
 =?us-ascii?Q?km2bE33oMyUWhwWWh0qFvfD4Hov1bjZM1orSuQHOrQ5i29s6MCfOk8BMidBF?=
 =?us-ascii?Q?BjHq8T+0reulDrys/KJEQ6om8J1IpERWCfEEdfZCKLtfKELljzUjRlF4nLNl?=
 =?us-ascii?Q?9zs6/esjU1hPcUkiZD6XeB2pBV8VZOuJ8+UTmCaEnJBivpea5MJeGr+K6Tfk?=
 =?us-ascii?Q?Mesjg9RH9/fmmKIJOoYZ21W3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4bt+gbv+ajaDfJOuZaUkRDJKivVS58moSN35Y+vI6MFKebtX1JDOw9qZJKz?=
 =?us-ascii?Q?omA2CasFPCge5LQ/T+5+uWsuft2rSumrVEk2ay1b37qcXwqKsaybaqpM+qcG?=
 =?us-ascii?Q?S2ibTVWMYaAVl2CkmCzLTqVwNDkWJcRrjRxUan3i50B2R3shH93C+3szv1fT?=
 =?us-ascii?Q?mkXZEGX3jcVHMTXh9YTqTP53Lkf70hzF04XNPyXwMbcDfb7ol72u1ESnNJA8?=
 =?us-ascii?Q?dYsFtzWD1f0iz0qeSpxmUw923Kgx4pnlQjD6aWx2IarfdpHuqu8hhms1wd9v?=
 =?us-ascii?Q?yyQcSs5w9PABuRk+ZlSh6EqOIDqCDpDHbNkiT/pMW8pJoVpHO8VB6zFm64Fs?=
 =?us-ascii?Q?O02U04MUm6GAFOwrrsSw9IYBzdHMoRa3VTcgt2/p1H86n63jwWgUt0QTIh1H?=
 =?us-ascii?Q?tMiAmi2QxJBIZ9fzGVhaC8usz/CNBgsgHHDqQAe5Z5y5WZnsmo5WwPAVm8gD?=
 =?us-ascii?Q?fIjLLVPXhjUYRcIGNkVUTjBxD/wumpPXcd2KaR88wSf2RQ2LxLy+G2dDgDWA?=
 =?us-ascii?Q?PtQN3jFkmoWDo3fWMgTjYCuOrrb2HhFO9XPGysHYiGGU/KHWim+IBeckGtoO?=
 =?us-ascii?Q?Q76/a8ELdljssAu9EoWFfooiY7A1R0Mmg+XriG7ECEtOU5IIZmORVTpOYwO3?=
 =?us-ascii?Q?EqfJ+jLRA3IR9zLhQ5I5+haWWVsAgvmjMunQhfji8cMZixh/7lcpgCmfBoX5?=
 =?us-ascii?Q?WdyrObQ/hkOy8qTeaK/o+g3+5lPxMauzopV61bY1/IU+ShCj/quQht7ZqSw+?=
 =?us-ascii?Q?c5N4yvvsDuOSGNE+Xnlpf6JlXsv0KhiT/uxS6hFdSQAnQwBVX0yhVh5K9HW6?=
 =?us-ascii?Q?dvSonFdBSBIF2GM+9fSjfARtTAxWFqydoPrr7Pc/AMx2uj5vJIIn6e+ZwVrU?=
 =?us-ascii?Q?Vt8emNWSZH96Ez3nzNfDkpxCEwdPRcYBwCdHu2B2eDWOgIsLfVjDTJkE26Td?=
 =?us-ascii?Q?31vdG6hiBok5PqiFG4tNQVkBKHp0kU5Ez7PbYxWepbFVbusFNd1GcQX9yyae?=
 =?us-ascii?Q?9sLjtQR8Fy5E8ImQq1ZOMyJnwLxjjG0YgJYZRGxWZFbn51O3HmCgZ2m5miC7?=
 =?us-ascii?Q?iyRyLH94FuCGY7OzgO3lSrLLqvPqolRXK2JSn0ATTdn/Yl2mvUMChzn6ZJpM?=
 =?us-ascii?Q?QU5N5jAmk15bnj6/JaRSbAD5njACikMVKoZDry2PGalmdfK0zHdGt2oIUd26?=
 =?us-ascii?Q?2wW8S8aW5lsGlRzzlSkLvucbg7Pi7/x4Spfc4bnj3y8oNCsmSx8NeGpmHWu9?=
 =?us-ascii?Q?6jONkL+Y1FPcWO8HkZh4lpMCCXmiJ2syTDPHaxOqlMkuBzrf29r8TY6e1AX0?=
 =?us-ascii?Q?H54TOAxp1hw8/23lpJ7B5KkQ2Pes3A9cy80oOk3WTASHSSsVc1+JRfapZOih?=
 =?us-ascii?Q?oyBof7b4gMCd1nRvcOzbEUVxntGPnePZcyo04fhJij/bMs7Ijc6yjDZ6dH5a?=
 =?us-ascii?Q?LqpPPyEKHt8r3toykQmQOc4SgWPfmDhjQxkJkP0RR5uOXmsRkupCuVp3idQq?=
 =?us-ascii?Q?y0gxfXOXeTAdR4Qnjq/uGyz0mCv+GT11rGTcnKkghtyHSkNBRi7zGXrv2f0R?=
 =?us-ascii?Q?CVEUdxSGRG3i/2Kjr6LHvPQ5tCqTDwnVwRdOzwB5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd153319-cbab-4883-59ad-08dcf511750f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:24:11.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfsv8snI5Or2Op8fhF6jUFWkoH274ouIGfkyMvvx2hboiIJRDURXWMVpEtE7nJ7BySy8TbBjZAFOx4o/6PS6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

On Wed, Oct 23, 2024 at 10:21:08AM +0000, Dhananjay Ugwekar wrote:
> MSR_AMD_CPPC_ENABLE is a write once register, i.e. attempting to clear
> it is futile, it will not take effect. Hence, return if disable (0)
> argument is passed to the msr_cppc_enable()
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0b4a4d69c14d..576251e61ce0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -311,6 +311,12 @@ static inline int msr_cppc_enable(bool enable)
>  	int ret, cpu;
>  	unsigned long logical_proc_id_mask = 0;
>  
> +       /*
> +        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
> +        */
> +	if (!enable)
> +		return 0;
> +
>  	if (enable == cppc_enabled)
>  		return 0;
>  
> -- 
> 2.34.1
> 

