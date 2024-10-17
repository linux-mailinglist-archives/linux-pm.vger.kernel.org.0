Return-Path: <linux-pm+bounces-15834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9577C9A1A43
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 07:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D902883F4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D815ADA6;
	Thu, 17 Oct 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LjYT3Dei"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BF1388;
	Thu, 17 Oct 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144366; cv=fail; b=NOnoPnfiEwAz3i10+fSlfAJJYCkAXgVn8gFRIwvcTltmXOg+5/YORdjRW/+4Ni9JlERmlu9J2cRJ5ZDTu1uyNC17vcZV1FYHLNWhlE9kGEAmJqLSTyxCrztHHJso4pHWIGoECS+js15xDD90zjPrM8KpomzeVe0hgQJjbBew8Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144366; c=relaxed/simple;
	bh=E2cSFv4zwe35iCmn/7kf8rqT36CwF1EgB6ouz8oda9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q/ZnMBArdIIDHnA3HodZGo7WQO3TPky8Nz5hi3djg5ZCS0eihGXeWu1TSQ4K3HX3egMYVb8ypDuR5jhgz3aJJq5M4ngzrSBQY2ZMFyPIzMLPxk7SU1HUNSh4IpftNcXbeaVtzNbdP6YE5V82kOs2QLYe/7/R6ZCMwHTWopNDjPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LjYT3Dei; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx740rkPRNVxLYk6hmQkZp3d2x8HKyeu6+DJPnXiZdr+Ky8P+Hr1/mGPITwO+IsYKRZzXX0jvFIi7oSiM7smGw6hffaJoWu3ilQ3eLJ3ydUBh1o33uLR0TM2UJpd6m5An680dw4dkr9UYQzmsqdx6r3NhvXW7PxBwh0sgSbQ0NUd/RyHlA/kUL2G3VIaVj6CC8iqfLoi3iq5ZWMv+fn2+NdkmRP5aLDfKz8XmpJA0P1yNUpNk370j43igbCOXAjs5KtQpBvgQP58Rn3inxWKbgw4BWRMcMtqAaWIlurJigg4GMCMK0F2XGM8NgS61QUmSMYNm5EceGmL0200JVj4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztUbbAQSDPZzId0dIgrqHESh7fClWO7h9Qi3zro5sAc=;
 b=IyGkVq6B2rHKZFDAnbOxR4mZT8WsHV/TPFyJXevtBBuUlpky/PK7GYL+F8sA2Pg8x5kDXNcGeLoCaJ4WrzP0zdRgzPaJ4m/b4wHdxYIO6sYM2CKiyloYM/2loBtgNl1qmKzbCer2Mq0oXJvkFhvwohzzcc341HKSKB4MJZ/femCh9vaHVYVfnjQbTgyX3hLxkcoOlorMtn+yukfCKSgclellx9f9mlWr9VhhFJWTVAmgE/Bg6ohFyaHUSxcTvxNuQNdgnFdtzq+V9dsOIOFaIvJi9FALLa4MQnOULuMiXlhCfXUHtu+7d7GdRUL1G4aOwNipKj9xNU/WSrNJxavA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztUbbAQSDPZzId0dIgrqHESh7fClWO7h9Qi3zro5sAc=;
 b=LjYT3DeiIQeWsg7PkiJ/fw/+5cTS1hP2eL/nLAxmCaqiTvqQtTHImXsGhPwlNGrYvvyPoEwA+8RAsYHMAtudqiHRFpGoCi3wpzK1lDVdXUF3qqVvftogXRVTLWqxDf/SpR1JED1s6opKn0xgxtNkvq7x5dQCh+rrxUHZI6mRzIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 05:52:39 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 05:52:39 +0000
Date: Thu, 17 Oct 2024 11:22:28 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 07/14] platform/x86: hfi: init per-cpu scores for each
 class
Message-ID: <ZxCmHErZZmY27H3M@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-8-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: a367ccf7-f233-4a7f-a3a8-08dcee6fe879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNvX8EWRLX8ticA4sVoDH3MsXQ31xIDICc1rtk+5Gmh39BeRiL06QzFvdier?=
 =?us-ascii?Q?12ANp1CnzXL0tNRiDIaON7Ah6wtBnh/BWaEVkxuf6Tzq+CNnUoX91dWPidRv?=
 =?us-ascii?Q?JuVBb01dntbcK+8BVcACLmy58JzaIrbMZb/7C7YyysxbEE1ihXtbwqr4nybH?=
 =?us-ascii?Q?9o2g+FCQJLFWdq2N3mR3HHNtLfcxGt88b7bHo0GXgkHTeGQV5vdaRV+e0I3i?=
 =?us-ascii?Q?Jb4zDOPh9SOpt4yRHRP30vaRRH9sSrgCmc1APGM2upT6RESWdUn2YrWWmFz3?=
 =?us-ascii?Q?SxLetBwXhBtHejQqBQbYLfbMqDLQjOWDY7enV4qbYM+2rnCr1ttM6GGtA1Vp?=
 =?us-ascii?Q?/CUmYMbUds/icjcWaq3gyUKTbUhpF3ZbKD1YdAEuNTiUv7BtVHeqY07u4D4R?=
 =?us-ascii?Q?o6bkhqNhkYtycMIv81bMHMMWOSr6QvaaQ2I5+LUQ+l0arlT7ZUD0MG0aZ04/?=
 =?us-ascii?Q?wMYj8SuxaLy6q1oqleOTY1HVR25qZEPaiVZRhiR7Wi44ZEokx77/gFQusaXU?=
 =?us-ascii?Q?AlCcyVjxfqhc4WIjDdErUD69fQDqjJiA/D4LGIOx3DYH+qlbnrxHQT+pilKp?=
 =?us-ascii?Q?DxQ1uJRSUwdKO6XrmFl/et3tQ7GylKu/Xs/Qa8lBS7r7aDW20/pSBZOA+sJx?=
 =?us-ascii?Q?WTa8AW5zOo3YYLKcHvsZlJDhCUL2lD3iNm8Qs0s4oszRnRxzNswrnczliPP1?=
 =?us-ascii?Q?ynsagwF8hfNV2aVC94vYJk5wcdMBGgwTiFg1s9hjW9pm9rx2J5K6+OvxEIzx?=
 =?us-ascii?Q?pk6Au0qJWoiBZ/pzsV6zyULf6uIHACTzi+qh/iA7b42amkJW2A+nS6T4MjDw?=
 =?us-ascii?Q?TSOFiiACsoDsesxOu0XfVMqcGCv3v+7QDZ11sx1oNHUHnj4uZ/AjFavy5N6u?=
 =?us-ascii?Q?dDw2XccCs8vEu4ijOXUseXeiO4HamGUlYliZzXSsM4Rs34t3bFixJeOyCCGo?=
 =?us-ascii?Q?VfhiUgzsdWk2iOKHXZO86IqLC9fsYBpgTfR/ajyahlMKw/iikAsborIPeWmo?=
 =?us-ascii?Q?z1JmI4JILiLck0QOyrjT40qP2r/+W3tOwxFuQeUtsJYPHQ8QgvTHR9+mpeef?=
 =?us-ascii?Q?3vvalXWLfaRg//vmBPNC/lR4LtOSAAS2UW70nsRHxgCwVslhJBX0mNrA/xUA?=
 =?us-ascii?Q?ZZEI1pvIdRgWvCVcb+Ih8arzoC0C8s/CMD9GJApz7evbzfDZbo3alF79cYH8?=
 =?us-ascii?Q?tdn05vhNYwg4+NLU+InybW25KLeUc8ou1zXT7DQR+IxcOldAEeE0wt3go93m?=
 =?us-ascii?Q?RuQzgxc8SVQzMUeyUA0GMxTKbRjzNzbhVMHbOPGqCjdLtsqqDJgIZFxfm3NZ?=
 =?us-ascii?Q?crDC43a0XE1216e2ZR0tGbJS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nXSMAmsISTHVw9jzsQofjONkq477kFfIXp3yIaLA5Cm7svBINFJ8G0CKv4bk?=
 =?us-ascii?Q?o41/n3FxKDJfZjJ5PyfHldML8DZKpJQYXCmVtmluVvb18spTJyWIeb4c25eO?=
 =?us-ascii?Q?pMpfzD4MaASk0N+MHd5Y9f1+INty3/KFNHBnraB1PbzePeaDbJAqGk3URI7y?=
 =?us-ascii?Q?NmM38D63IPEQtnFaO4cQWHthTJdjQIJyx3N5ha9z7NWkLWKqTlbrr2qtn/FV?=
 =?us-ascii?Q?FQMcxcEoEXZBzDzuPWElcSezhlRn3kgFc24wpka5DTXFHaQwshzfcEh/eij7?=
 =?us-ascii?Q?1N/120lLnqag9jhDM3wpe8D9tfBVH1VGN53afaJOT6QsEynMJQSZTmy2w1Si?=
 =?us-ascii?Q?FkB3AVqcp841j0FDn+xJx5qxUuDEU5hhhBUZPgy2K26EwJ1TtswQxhMihbTX?=
 =?us-ascii?Q?MjN7eiq2FgyutYwS6AIBnqxb0kdABmWuvOrFA9jAZEZtc+wcbIaK9SJGXrVo?=
 =?us-ascii?Q?KhDj5AoqvQ83bWDa/AQn91Qp3e0wns7gXwgqsHiN875CkxJc/CzxLcH8/Kgk?=
 =?us-ascii?Q?H86AaSfSn75kyHJSq+3MLyi6ksyE81r2RyHQ7QeoVH2h1kHffkI6iYXgFgUg?=
 =?us-ascii?Q?BfuY4SCdvN9UOMd+ncqPW7G45hXvv8cueECUGrQqtXrORmsA9WmnBPkuv9Lh?=
 =?us-ascii?Q?LZkkVQGfdmRde0igkX3tOwa+seBOql7ADa2EGoP5RMdPvsD86eE3PfYxqzVw?=
 =?us-ascii?Q?Zjkxlq0Yo5z5d8A2f1szd7vWb3suVYU93KpIbO0HU0ZwNfzkDiOgZA2X4Bbk?=
 =?us-ascii?Q?I3N3inh68EOmzNdqH4LT5bxnzr+UAYCXpFadWWSQVxBfnnYmv/ifnCQsBLww?=
 =?us-ascii?Q?jmOMmNbFEPnKdhaAgCmT7WX9G507lIYpBolOg1FnSKOBeKS8tdtK7eqxengX?=
 =?us-ascii?Q?doqexvCzo059+pD0RugydhlfR35qXW/aOtVxCBA9ASbiNxva+yx0UxER3oBz?=
 =?us-ascii?Q?VfdpNeBlG9+3wzcK1lxwBxhMQKOfdHKMve2bfd7PQxfKBQq6Gkn7mOh7Llur?=
 =?us-ascii?Q?ZGpmvpmEWWdQuk6mq37Juo8NpPL+v8o3Tqz7U8eqcr9dNS863a+CJjGTqKyP?=
 =?us-ascii?Q?S/9dfFpwY2yGz8SgkzPPuf/5sKTWufGlhP4PHJbwgJZLbKdwZhmeYlcqxg8M?=
 =?us-ascii?Q?mzdbWQQwnbPvn+z5w85rgSDbQE7sqjHYR9iax69QHkD76JxjD70ySVPYv102?=
 =?us-ascii?Q?0KyjZzP61m1dsVfqx1XNsc+aGnlmqhKKP7kNWda2yw6Hi7ZgKkcB+T1ppFW5?=
 =?us-ascii?Q?bGuZ3q43IOGcho3tSv9g5BBQ5dN6sUZraBiLgw4V/b/LrW3TYXHYaIdsT6qf?=
 =?us-ascii?Q?3OZcCujNkk6o0o/31143nCuAM9Esa+QNl7dIW1J3KWqQX1EFBD/XZCG2n/6d?=
 =?us-ascii?Q?5v+RMi76mX1OwOIFu1IgJIMPShrZxE/QnYiUAkcL/6EzPpiMuiIQnHfJd88J?=
 =?us-ascii?Q?chQtntdkdf1Sxh4c1mFdv9M2ORiXdCSiUdNkQCLtGVGdyTCA3yFhIk3UtU7l?=
 =?us-ascii?Q?59Wuz7H1p4nb+5xaoL7oLD/DbdASVqyGUCCtwYz57nNesIG0tOwizNpVDq5M?=
 =?us-ascii?Q?LpY2ATrKmHJZWCdKkxnnF/QT3pyDcUsbv1heugah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a367ccf7-f233-4a7f-a3a8-08dcee6fe879
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:52:39.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOKjExI8FNSovespyBKD8vUfnIYRLwcHeCMB61UaT2Tl+rCmP+Lrhfqaw+pVR6NurvNB6eCpAMtjsR5hA17hHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

On Tue, Oct 15, 2024 at 04:36:38PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
> and performance score data for each class.
> 
> `Classic core` and `Dense core` are ranked according to those values as
> energy efficiency capability or performance capability.
> OS scheduler will pick cores from the ranking list on each class ID for
> the thread which provide the class id got from hardware feedback
> interface.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Drop jump label (Ilpo)
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index d2952233442b..63e66ab60655 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -118,6 +118,8 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static DEFINE_MUTEX(hfi_cpuinfo_lock);
> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -238,6 +240,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  	mutex_destroy(&dev->lock);
>  }
>  
> +static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
> +{
> +	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
> +		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
> +			   hfi_cpuinfo->amd_hfi_classes[i].perf);

@cpu is not used here. But I suppose it will be used in a subsequent
patch to inform the scheduler about the changed score for this cpu.

Otherwise, looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.


> +
> +	return 0;
> +}
> +
> +static int update_hfi_ipcc_scores(void)
> +{
> +	int cpu;
> +	int ret;
> +
> +	for_each_present_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  				   struct amd_hfi_data *amd_hfi_data)
>  {
> @@ -321,6 +348,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = update_hfi_ipcc_scores();
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

