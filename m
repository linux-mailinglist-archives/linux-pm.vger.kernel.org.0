Return-Path: <linux-pm+bounces-17013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FAF9BC4C6
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 06:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DA2282F91
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556921BC066;
	Tue,  5 Nov 2024 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="weXxGOIr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5C26AEC;
	Tue,  5 Nov 2024 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785353; cv=fail; b=HwQGwd70yPwDYTNl5yGiYb77vv9+YQBd2+CYNIufhUZuonyeIwbyULSLRqOi/fay0jkb39O4xeVpRXw2gTLIU5CYXZ6oPnfaMMUCQtwA0P76uin1FhfrNwN/IpnmbugDh9nyWk3Ts3OYlSL7QOI7POc6OYGOZ0FN5G3AhWf8ahE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785353; c=relaxed/simple;
	bh=87nypO8zMmKCHAkMp7ejPrtbmNCeens2NEoSpcu8Yas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODx8JXr0WHckrPeFWRPwXnkViqMnc300v90nooA1fauEZSo0lAiJoul+MZ4oAHkkTtmCgzgIqUaQt8cHndJ9mtx7msNU9L11fC2Wtof7cnhfST5nEkSV0hpmWcRBKaHww/ZifU+JJLcfbdEe2gqb4irHJO7q+2q6j6abzdYxro4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=weXxGOIr; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgpAeoXgc6Lkdr0tyaaS7Fy97/xfAvMQujBUwNMvQZOwgd/A5wm72WZEtO1g17i4P0aOUMFmsAtCTsYg7lWEhm3MXezvZSg6svQE8yeUddELp6R5qxw91tJpcmuSLe35eFEm8KjBI8yuxKiZ0Z9Kiptw7ljufOiVqFT96QRrGfZgp6vEBkzXB3Ryw7HAXnfekBazzwI0R4kwVLojb9P1Qi8DVSLWqC2n/L7anpLPRHo2ZTdtSON1Jdiac6F9uh6oTeM1dkKV6paYwM0xQ/y8B59BhHMw9OakVM/1W64XoaKiCggalxQf1DTXG2HRqFB/bDyILDa9lrH4MU38wEh8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o7honbdpZ3A7HMKbDB+K4dMCh29pV9lnVuLsa+A5mk=;
 b=WHfHbhGuDFr0NT4LowpI/MabuAXUQTI0QgP+1SP54Ouyjp7Fjd9u2kcEDyYzdcjFjmOtUQNa9ZcfVYcKYBITMub9EssBqyFm5/oM/ggw4Q4uvfqIGpPdhQdhfpQBIcnlW/c+BwFuv8ZKNKqw1+hEwVA5aYNac4kKAEXxOB6+dtNp0x4j94cXX8PJl9ueZFeXSNS0hQ7JDMSMDd0+lw5xcOF7aF50NTFOjizJ+j86kgFtSWgkgIBDL/5MYjWG6G16IX2+vwLhrLMADYqGXKHfxolktELVLTuFIc06owtEwBtoQDVWXU8APOSSQfewwL9Q3sAfEJf24lUNG/53DHABOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o7honbdpZ3A7HMKbDB+K4dMCh29pV9lnVuLsa+A5mk=;
 b=weXxGOIrMJnZijVUXHqdP404G+6TSyB9bGwjhKlFMVmGJSrYKAJLIt5zVjGGtrnlYLR8MWsBVUYabcAYWwv+M6B3cVHhIakcBQrjgSCu51ASr0NXc9RfcdR3oYvOtChAkPO60OUhjQ+p89iq7FOgykyIdMEhuvcKnaVQYBWjOns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 05:42:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 05:42:27 +0000
Date: Tue, 5 Nov 2024 11:12:16 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v6 11/12] platform/x86/amd: hfi: Set ITMT priority from
 ranking data
Message-ID: <ZymwOJtr1k+6ZJGk@BLRRASHENOY1.amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
 <20241104175407.19546-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104175407.19546-12-mario.limonciello@amd.com>
X-ClientProxiedBy: PN0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ce32e5-c2f5-4d2a-9809-08dcfd5ca1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8ktefjR/D9PAtCmOwLgCAfi2SWUWz2YWlTtSIpLiGmPzJMYdBlE0vpVf4HX?=
 =?us-ascii?Q?eApFu9+VnEgr+DszLv4QFRP94gV8aCdnHPsvEWHcwy0BgTpSIcUT+NkWG6hQ?=
 =?us-ascii?Q?BqDSKdKa7yvWkGaOsjnhevIMcHuQMzAFmUoHZqdbC2OZH8RJh+EQ9JLDhadb?=
 =?us-ascii?Q?W0FksKGD4Tmw8mitTAMYqYOrzqwYgeLQ7CM1z6mYsA76m5b3KOPuaNL8gc1S?=
 =?us-ascii?Q?k5q448mg/oebptkxol3qNT63UwuQMbnAqjgAI1aMgC3yHX0E3q9+so6NFnt3?=
 =?us-ascii?Q?zKI/JX/mIIeDNDMrXADoTStkrz2Awnpz+sEha7c9oRfI94PUfWeA9smc4zPZ?=
 =?us-ascii?Q?chrPEWRuRXdtXyvTQ2acU76mlTMIlW9lbAV02DPiTgzKxaJRhuYS+JRRDeDo?=
 =?us-ascii?Q?2YXAgRYQjmqWz689EgBmHcvKdS9wKZC+d6YW3yYgkYzu0uzCUmSog4TN+gG7?=
 =?us-ascii?Q?0HHvzAXWOEmeSkPm1tS7HJqh+/pbILlqvUcZDdRiwjRIsAXa9BdL97NzwTB+?=
 =?us-ascii?Q?ElvEjarVNI+kUmRlx2rIRpGrs/eQjTfPo3FR69nSV1k3H5MgeYogHk2YAOrv?=
 =?us-ascii?Q?JmfcehmwSdMucufShzBiw2+9HRAaavzB5XI44qAiUtqrsQ4ryVQIBuIdLTft?=
 =?us-ascii?Q?qxjnmm8ZS+8XTU/kQayohJSVRmcSpENDnVM1IeA0NoT7Tpt2WrQb8BJ7HudN?=
 =?us-ascii?Q?VJdJXg/SBtDCi3hMiPJV6/RWAp8WPeBGKwUZjegf9EEsBsTFmOZvVrP8eW6Y?=
 =?us-ascii?Q?2YI/Rr8z+7s/1epw0QZEZRmz1S2NBbANYt2MkUENI8ttxIFU7V2qGi6i0pVI?=
 =?us-ascii?Q?p1g3vDfYa6BFqvj5bzWS+ln1wvCrlYaPo8Z1t3Jo/cDULu/bXxwrISuzTp0L?=
 =?us-ascii?Q?xjuC+tXzbUZPQQGip7Q/iHy3vzu3MmWhSQvVpRdN/Uy0x/DbjZ7cfl9Tlj7n?=
 =?us-ascii?Q?Agpd907NjGaeoSNAerH1KI9U7Cd/pM+PcA0tFsewxVp/7sdgDWX+nbU1R3AD?=
 =?us-ascii?Q?F9DFMpiaMaMUFzptZxxUm2w1mhQkaXgDjwM+53+WdbuE0PF3C14FaUuC3sGn?=
 =?us-ascii?Q?OFyhIBOue4BctQ5X1gxRkqKMxcjsDM8Vu9Or/mEU6+teA8etMZ5OksMVrOUD?=
 =?us-ascii?Q?VmNOF38OM27w+5DDLbIBTPeZQcBhgc4NcSsunnArnt1KcCHpnufaRtTLtOlc?=
 =?us-ascii?Q?6yfhXZ1vEpph1whfGA04dYeqtNW1ltEZFIcEhah78KwOz1PItT8iWL6HXmPC?=
 =?us-ascii?Q?cAPcLetD+kneCN9Pn0tmPVG76kjBlwa/yH2nhEH1YPXm0XLw1mKWGLTNfANV?=
 =?us-ascii?Q?HtD+LAaVeX3qmQ01r2WpKrT+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?creWxezaCeae+XvGQPIe8AwTxnhuKT61Mcp3y6tjzOTK9Azw5eLajFoKCVww?=
 =?us-ascii?Q?F0BvAuMZsecCoUcGFN+lsEQ6VqRqWtrSPbd8Ld7FRABbnpsFSqCSdih4nyBH?=
 =?us-ascii?Q?WtxwZibUVeuXa3FZCP4rpUC17KQRMeinUSwNp+44RcA8cXbbYTZ8VxgHzXII?=
 =?us-ascii?Q?0kRRBbkj6oSCkIFQVUCyXSaaswX742ZNoujUCCEDMM44wwX4VWm1PiqkGm4M?=
 =?us-ascii?Q?EBGG4Mzu6tj51p47OVpTE2/KTihOEb8eRnRCFlbrOQM88ZoNJ+e8K1BdC7v7?=
 =?us-ascii?Q?0VojEw/v7/OVIw2HQRqtZIifw8haxtoKIw1GU8lrGkr094AJSUCZS5KtBIWb?=
 =?us-ascii?Q?78hgTpBy9eSVyVic1jjbAiRvhydz/XbQQkJhLmGucXm5qL/iE2RotTvbjIHY?=
 =?us-ascii?Q?BV3z8PSdNRkxFaeA3u7ls9hgJyMECkNlMRFYtF8dXByvKYuyoBR0m/HHs2tz?=
 =?us-ascii?Q?scXtyfL+IVNPN58LmbHzV0PSeHCAIkNUCMyt87ctvsxheS2sGnEwb2wOdKaf?=
 =?us-ascii?Q?es1SOU0F4RnApD0NbJKPVTJ2yXBUvKXWV74pcVw/UlZHc6qZYKTPAKFgqemA?=
 =?us-ascii?Q?+q6b5P6iCtkfrBkM+JwFB1K4feh3No8W30KpbQYmuHP2/LkULO95ZCxeABSe?=
 =?us-ascii?Q?/8dCtEv/IrsXiGXflxvh5WXQQsLZG3hvUIuP9YmlDvgQfkF7Cu2CE+u1CqZZ?=
 =?us-ascii?Q?IAWOyvE40wHUYr8whJb7fCxGuKXv5ntKjacXbeRVH6cTYNPyRKLRSTkTyYhP?=
 =?us-ascii?Q?os6Nagv0zesR7kU759Yk+y6TbRxLhgPowgQtLaChO7C4dzqwHRKLMMjeSgdH?=
 =?us-ascii?Q?E5a1/vKvR5LOwbo1PT4A8FXdh0miUuSWmq1BrEhIfe7bSvRglsLE9Xxi0mfz?=
 =?us-ascii?Q?MVcyunOXQt9DZqVTNMzVQRKgrW1VPrOKxo4ZfXe15Td/KP7mIwS6qdqDG11l?=
 =?us-ascii?Q?txrV6pc7epMil/jFDstjFhk+jmxxzTf1hoobQxXjUM6PPmYe1GBcesLm+8Bg?=
 =?us-ascii?Q?LaqhgLA4c9kRS6AhlE4NxEXsMbYF/ubDIy6tP7T5iAf3tVDXPVEoXtQpPSvd?=
 =?us-ascii?Q?HMgJCbHWFYXWsuNicyCLmK+GZawPEYlgSOE8hpEGykLoXXqwQARWwwnW3iAe?=
 =?us-ascii?Q?USKqbAhif9fgNpW/CLTa9TXfmu4KKv97+BLCpjU0w6uMTpWMc5WP9SLyPH8h?=
 =?us-ascii?Q?pHTPbQv0KI5lkd24uKLLXanohuneh5cC0l688EmBsNzK13RHHXMueRPi7NtV?=
 =?us-ascii?Q?AoKK3CChfaCEB+dM5yxa9okfIV2nykmvshZ43i908nt0Dt01orARMqaAGRuW?=
 =?us-ascii?Q?cWunJAc5Ken/652wCM+4tFa5xa0Tt7AC5RxdztBxUMowo0cDtVf9ztVQadla?=
 =?us-ascii?Q?oE1JQXrXpuag2a4axt/V12Dg362coNN48wn1hdH4hyofnLw/pG1ProBMwjNk?=
 =?us-ascii?Q?MG6env2RBFRrM4HorN584NAjeTgNqBybtCd24xQMk91Yeb1VyWyMYw/gXj8Y?=
 =?us-ascii?Q?POprI274LvBdt96b/vMnGNoiCzfqlLlNE0LAbgOLy1hVDDwEi7+WoTVP8jDv?=
 =?us-ascii?Q?xrkvOALYUhTrQQJUQEXIvcfHyrDmCUpeTnuK/X+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ce32e5-c2f5-4d2a-9809-08dcfd5ca1c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:42:27.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6CqdEYCfj+k6GNJyZfad+PsdDg1PS0huNusX51QNdtaEJA56wRkns+HHe5yoJIMurSkMStC735P9SnWrEFOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

On Mon, Nov 04, 2024 at 11:54:06AM -0600, Mario Limonciello wrote:
> The static ranking data that is read at module load should be used
> to set up the priorities for the cores relative to the performance
> values.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/platform/x86/amd/hfi/Kconfig |  1 +
>  drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> index 79e3b0073275c..5b7c2865f4aa9 100644
> --- a/drivers/platform/x86/amd/hfi/Kconfig
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -7,6 +7,7 @@ config AMD_HFI
>  	bool "AMD Hetero Core Hardware Feedback Driver"
>  	depends on ACPI
>  	depends on CPU_SUP_AMD
> +	depends on SCHED_MC_PRIO
>  	help
>  	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
>  	 selected, hardware provides runtime thread classification guidance to the operating system
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index cef6aa84bd85e..09905a354efdd 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -115,6 +115,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index =
>  
>  static DEFINE_MUTEX(hfi_cpuinfo_lock);
>  
> +static void amd_hfi_sched_itmt_work(struct work_struct *work)
> +{
> +	sched_set_itmt_support();
> +}
> +static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -234,6 +240,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
>  			   hfi_cpuinfo->amd_hfi_classes[i].perf);
>  
> +	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
> +
>  	return 0;
>  }
>  
> @@ -453,6 +461,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	schedule_work(&sched_amd_hfi_itmt_work);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

