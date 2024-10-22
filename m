Return-Path: <linux-pm+bounces-16188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F69A9A1C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60708286419
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3D145B07;
	Tue, 22 Oct 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iBXEDQ2f"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E84811EB;
	Tue, 22 Oct 2024 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579351; cv=fail; b=HmrtGiYxlFWGXjCOI3OIycXkhYuNukf1g5IfxRcgcLmdyGHEd3qgj3sXcoWBXUOSYcPK9tbiWnVPH2tOLMOfq8GGT4In9qjetR7wlkwSB7C8oN2N+L1sx+qEolReEwaH6I/Om6wCt7tOXVwxTlGBf1aTnfH3LlAbRsknH2HnBxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579351; c=relaxed/simple;
	bh=aKIDj6QAZ1tobvTcRlDX2IvCjCck+9SaC9M7n6lePSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kbsJUaaI+7VpS3cSARgFQnNW873OZKH80AsWUyKlTQ73G6ElR1sHmqZ+68Bo8EeUjI9nEiPK5lbIMc0dLv+rE736zNMdxLLdRelw3sT9W+Okq8Op5p9syfjf+ri5qvz+6d/w1mQnT96fS13WNlCmzA6R2AnnuR+A4sdgByQL/uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBXEDQ2f; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4r47rwBZFVhEl6j8uXQ0MwGv9FOMFBTxAqRNRO4BHuqr/o/azDx4EifhnyvbqC+EhXS02nVtaSU1kLahfmcniHjQgu2MCm1zhpkSS/UgO0/6/pO7R8yG4jsu6kyQwCLEXHSG53uCVJ7mkUAsRMv/LOZMVCFF0gOMVI/H0FC/55ul9n3kJSmuOUoLyZ9Ar+Ak42Y491EL7WX6IgYNzTMGh0nxlJs3jaCw7ERZk2pptIJoI8mEsMt2Wd2LXPG8qo/p5OioNbFBbkSnP8pXZnf2/nabwtslBjszQ+AfgdqW05e8iSI/HGITySFt+q4euq+eDUTjP0k73GJgkXLnDVp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtvxVvViNMTjL3HQk37att5kyMmgndndOl736AzDREk=;
 b=Ycnjz+tFUJSwzqUGxmgiOzasg5IwUulHW66PzgN3oAvg61dH4KAQFLJvsjG6kjU2pk3f1Cc9a0MTW/Deln9C+5le/Rn5AIVmFAEiKqG44Qy1HyocMBlTLak27gmQiKqrHDIfuLEGu4beCdJXZxHXWp9sEaFsi5CNdZiwPLR4161thsbAAu3I7IkYTGazy14Xs/bmSB+NYDhosv2Qo/aRKy300sNe5R9vMJujLBmLu/Fak0Zgo/Veuw4zxxg1hco00v1EXknM98NVCiwPl2wNNj1heInwAl35tZM/9KKcfO+UwVoqko/2VRzmO0RYaDGogx8PRgXx/1wrIA4MRZbfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtvxVvViNMTjL3HQk37att5kyMmgndndOl736AzDREk=;
 b=iBXEDQ2fLqV2j4U92LC7YL8FsyS28dr7iDj8ABuSwjHqI6JjKzVPOhfYQySEPz3JKF9YHQGZ4oj7YHNKefzjC4ptEq6WNWWSej7AjufFwdDg/hXJItvY9R2GloY+D8JNg8qaqx1yGE4T5lEawrKwPCLCYkzbYSbM3nRvdChoCgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Tue, 22 Oct
 2024 06:42:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:42:27 +0000
Date: Tue, 22 Oct 2024 12:12:18 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 13/13] platform/x86/amd: hfi: Add debugfs support
Message-ID: <ZxdJSm9z3EmULUT9@BLRRASHENOY1.amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-14-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-14-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::30) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbfa9bb-b300-415f-cd0f-08dcf264b1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0uRBvmFlD68U5d6dRwEPQEJrkB2pNHKN0yU9CSfWTe+IrYVBGIQFOvJR7GCG?=
 =?us-ascii?Q?fmhHot9kIRSYT6OOL2l+l27whNH6p862qhukod79iRvs1BIoQMxMQnUdUVbv?=
 =?us-ascii?Q?FtVN7C0MZMCNVYJh8CfyLDSAPg9v8xQ9tZbyGJ5wAPqAHKAy9pgMe18Z3kL6?=
 =?us-ascii?Q?Bq+NL61f289FipgNozz2KfwBaBdGoO1FxbqxPBIykJri4icvxAQaRVPUigXd?=
 =?us-ascii?Q?N4ECNi9hzx08od2uorM7OHiF4PWlV2Fa27BfyvKfSo8omUWfNnqERVuTZ3Na?=
 =?us-ascii?Q?HYY8JujAYspFJgX0wdMk8tgWP2lG51QgdG1DVcUKoOm7EoEb4vGmA0u6aPG6?=
 =?us-ascii?Q?4JEt3la7qsz9TDhe7VkxByOoHlg4ApPl8u+oejYKRVg/jcWWS9JVKepIa0ug?=
 =?us-ascii?Q?2ZTW2bzPs2qcjf2vsREme8335/5IX9cZxEGAqdN75MwaYswYTLvHJx+Vdvei?=
 =?us-ascii?Q?6K26pcpm25z8VDKdcVBPi5kNI8PLgxj6XSKSSa+8inzuUI3ykFC/Nm25h63v?=
 =?us-ascii?Q?LPMxLo93+54y5ZExkjwY4kgHrI1pvuyEI3Vq9V9+wtedU66b0qa3TG18rffS?=
 =?us-ascii?Q?6FfcKRY/0w4D4O5HN1YYPLNuCT9gg8xV98pep3Y2llt35mF0xcx3qTr/rosQ?=
 =?us-ascii?Q?eVfHrlxeXdFVY9pQZZI+bBWvkAIucyB+JT0jSoGYLgwq3zlUhrfWjaOVx/2j?=
 =?us-ascii?Q?9BhYlAmi+MQz0Q87y8uzlgmmYSls6QVLcyXwYxg4AMIHDpBF75AybgUx8FEn?=
 =?us-ascii?Q?CkFU5aTKYYKzXchgAracp8brUMWKQRTLyBWwc8Z8PO/C0JceW6kTmVUYq78p?=
 =?us-ascii?Q?4Jymvgr1Vdu4AaYVeYCRlNe+3HFXf/6F7806Ut5vFWk950k84olnPiyembQx?=
 =?us-ascii?Q?TIVnFHWVfvRS5oka/dE4N8+zL0k82D0d6K0ioFsF/Zv66xPbDmOjndaA79A3?=
 =?us-ascii?Q?flNNpc0t8FrqHbGwpvjx2a6KxkpO1jcDkLg5MI91WFn7FiFheU/qACkzeYh9?=
 =?us-ascii?Q?3H+q/VmI8jWxOEtioZ7+BeSlWoswAyqc3G66bH3KCyUXln0g7HgkMIphBIOg?=
 =?us-ascii?Q?uXhPr/7vGIg1+wchdHwsQBqxXXCuWsWTZtcrABnnI6MQYHvdJ/MDMCP1WngD?=
 =?us-ascii?Q?f1RTIftAVrM2HHcH5WRdZv7cdJIJ9uMqFEn4OEiMSsSKPXYbKHVys1Uocc0d?=
 =?us-ascii?Q?FGmDZfPx0MN6TwnbWSkm5T4AeH/axUan9qlpdawbvlmYsLwonHFEo8B3V4Mm?=
 =?us-ascii?Q?w0XmAWSICvWeAB/obUdWhJO4LWX+X3j9pdCAf4A8igzd3yS+adEvFx9bnzx2?=
 =?us-ascii?Q?A8cQra1+q1mQmsUyp1WdfSg/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dCwT0+PDAalmlu1P5IhiuzR5oUbtXAyBfeLpLDeUUrfO2rIHDa8epu4eWKkP?=
 =?us-ascii?Q?7+EvlAKvX3J+SqOO85Y7KW1Bq+0jVp4czrhYwvzXT32h0fsjnEO+TPUFIlyW?=
 =?us-ascii?Q?qGZV3BAovRuTffgy5AJpaZ9sgf0727OLtlAnesUT0hNrZyP4zaQFpGwpWiMq?=
 =?us-ascii?Q?8+KcGib8U5zVwgXC6gjMl5f0wW+UxUTIybQYLm757OPy7zWPupQEyKLiTpkV?=
 =?us-ascii?Q?rNbHcN1xThthUSeha9cFw//MT4AevZ1vMb5la9VRC30S/FwC7IR9t0UYLW6N?=
 =?us-ascii?Q?ok/MFxvJLc0FRatjBQX6jnsCyexjzhKyM19OwLc2TP5vU8YdPqS9NSGRRRyz?=
 =?us-ascii?Q?3j4hysuZcOVERQv2hBfaI11xIzh6I8RA9fKetwFhOn+j0m/zanZUEv77gZy9?=
 =?us-ascii?Q?jXsqAst9AYiUhPasdsE6YYTT/m0EwJVsqNHp0d3gS7/1f26GtMu7pLqQwlFg?=
 =?us-ascii?Q?hW5jNAF8M9b5Qi+0UMHQeCsRzU0GGo7ns+V2ZvQKMpwK4VZztdBssp2NQ6Ve?=
 =?us-ascii?Q?bg/Q1j5kxpEFiZlhm84znPOB31Z5wdBeQCUhDXTmZ4dDkn0CMa9qP1PyOXiA?=
 =?us-ascii?Q?lJWcDbQpIa+y6ZGROhV0merky8+H2fqDWkcAwVjfahTEI0o+nhy9hzzqx0pc?=
 =?us-ascii?Q?SmYeiR9zx+6WmJYxqhqGr803RhFaIch9ZetblqbFWktruOdTEjiYkzR3gbI3?=
 =?us-ascii?Q?FJA8SXXr0wOUFQ1jh9RVg0lJFlRRyFlTNtCvVaZj8dA9PFA56FqcOEF5k5M0?=
 =?us-ascii?Q?0xrHVF4oYQLeDIqCq3ejSzPFnIKZbZ0LFOizaMvzNRonr6AaKvWM/nGsKttZ?=
 =?us-ascii?Q?BCAs/T05A3u05jE5kPqzQmJsN/6ZSHYQX+hp9Qn7W3W1J69vgMkuhc6Zs9GN?=
 =?us-ascii?Q?YZR4nimE4X9a9m0ZxTZfhp6you3lmXpBkMwx2ySXHIQXPeJrCfxe69i9/TRG?=
 =?us-ascii?Q?3NfeWxdTUFQXmfntn9uvzmqr4/vTKFHSntNmXHS/GEQKUX8//Dn6zT6cLEWA?=
 =?us-ascii?Q?ek2bgb4erzpaghwS88T6TpwVFn1AVo7kli1fC7ThB6s0cgmA1EaJ+S/LPxpa?=
 =?us-ascii?Q?JkbSzwM0/84HvuA9UO9nVMw8um2IiaGzZZIqqjr/n8oM1E+wYU2t/zI9nX28?=
 =?us-ascii?Q?pIWo5AKJS1ShfUO/wAJAGqx95Yf1bOiaJ2FSpn9QcmRUHa6FbwVE+jGIImVt?=
 =?us-ascii?Q?U0pgTQINF5KHWCoO2bLCdB1UmDfsxuHhCMBN2KnMbMqSD8ed/Fk/qBLwoMFG?=
 =?us-ascii?Q?F2Eg0bEBOQTbf4pMKteAz5o4+TcJoeYv/ctv3OiGpveAt6Er8nsCjq1ZHGsE?=
 =?us-ascii?Q?wjSMDiAIzvBdh3As2V6vfUehlODn9SAKsbABDh2/+D9+fG4E+ZUlF6mJr3E3?=
 =?us-ascii?Q?/b/lYcIavHR2CbZ7urT3onISXSYrPn52Fl+t6PEbMfsCMs7CuxC0AG2E7JXs?=
 =?us-ascii?Q?vnvfCqoBXGwhTQRFeY8fy7ziS7bZOCpIVAq9kCCHppAGO3ogbfSjEyCotCgR?=
 =?us-ascii?Q?ETFBlsAk1hDHZrJJdabixhXn9sSKbsE555R8fB7uEdRZ+0r9CsP51CklrFR3?=
 =?us-ascii?Q?bkGruXNIXcVEFAdInMg3p89dfqF06dtV60jLVbLl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbfa9bb-b300-415f-cd0f-08dcf264b1a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:42:27.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1L4zBg7MjkY9XJcLkUIeKmoLLEsW0VIMcgxwD77Q1WmLSXWCfMBGjG65qp2YbS+vJ6lcQpSwtXGkSNBWGIg4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

On Mon, Oct 21, 2024 at 01:02:52PM -0500, Mario Limonciello wrote:
> Add a dump of the class and capabilities table to debugfs to assist
> with debugging scheduler issues.

Thanks for adding this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Drop conditional printing (Ilpo)
> v2->v3:
>   * New patch
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 50407ab805169..839007684b049 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -13,6 +13,7 @@
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/debugfs.h>
>  #include <linux/gfp.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -75,6 +76,8 @@ struct amd_hfi_data {
>  	void __iomem		*pcc_comm_addr;
>  	struct acpi_subtable_header	*pcct_entry;
>  	struct amd_shmem_info	*shmem;
> +
> +	struct dentry *dbgfs_dir;
>  };
>  
>  /**
> @@ -239,6 +242,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  {
>  	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>  
> +	debugfs_remove_recursive(dev->dbgfs_dir);
> +
>  	mutex_destroy(&dev->lock);
>  }
>  
> @@ -396,6 +401,27 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int class_capabilities_show(struct seq_file *s, void *unused)
> +{
> +	int cpu, idx;
> +
> +	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
> +	for_each_present_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		seq_printf(s, "%d", cpu);
> +		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
> +			seq_printf(s, "\t%d\t%d\t%d\n",
> +				   idx,
> +				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
> +				   hfi_cpuinfo->amd_hfi_classes[idx].eff);
> +		}
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(class_capabilities);
> +
>  static int amd_hfi_pm_resume(struct device *dev)
>  {
>  	int ret, cpu;
> @@ -469,6 +495,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  
>  	schedule_work(&sched_amd_hfi_itmt_work);
>  
> +	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
> +	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
> +			    &class_capabilities_fops);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

