Return-Path: <linux-pm+bounces-18397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C681C9E1277
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 05:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18901B2051F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378FB43AB0;
	Tue,  3 Dec 2024 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBMIb/Do"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718051F95A;
	Tue,  3 Dec 2024 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200772; cv=fail; b=dPXHUHb2RJQ+Q/qlZ3xxStYznXnc0h9dNVLs5qWnVJiJLO60o17iDdzo9Rqi5WlLABqNnlSdxKdQlCfCx0Hj74NSs2VSFULROUhiQZ8oE1VwhFvaig8MZW/aIizRMvZINjoCnlRbF8Cub3tUwZrwhuQtZ1lfGVweVJ4mMED/azI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200772; c=relaxed/simple;
	bh=n82JtkAYQz1uiuTGAALAWWnvYGl6IuXHlpE6ZfO5Y7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjXsO7BUwKgHOY2oQJldRYJ7PTGfxKLKLDCYtsvKJ4TE817XFznPoMvsI6xlzi+0DW2fsLWJyjQOmtOUScq07JVdLrvbgHw11Xu7EDGQKqnVFCHxlxg8lNT29taZQNqoBBIUo2X3ouPTBk8Pl/tR3DVJ1+V8YxAzuEorAaJ7Ia0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBMIb/Do; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mgxhg0CRsMPjA0sBDNAeQn3q1IYsedYQC6YYqN4mSa89kKsep8bp90swbe/hD1E7Jn8i9MirEGdd7uWsSzfqk6WxDvWptSd5s3zWmlrvlhExVwvdeCuiwry0ALsESXvyjiZ39K4cYKoHXkzLm7MdponCcE5vSphHfztbBdezfpG20R1faue3/LUF9x5nYODnZydXU9MKDgKTayDR9eq+9U2saNmboLvet+5Zlsgm9HIyYyanUyJWGFAPOZGLW6SrFQS8pHROH3i9YvgcmYfChutta+mhh8Sbz35LfFv/qjUPDxs7zMM88A/s28MSSk7o3CA5MDfsS83VW3ZbJAMfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caZwv75r9ZfF3PZBoRTxrOEGMcUlriGpEMWE87k1CEk=;
 b=MPU+xro/5RQBOvVO7t7s7rETn1qCSAr2SVEPcNMANwQj72TVHiVWpxqZi5pg2lbUpVlKaj5LfneD8NwRVe5Z4edDmp7gDp21hIp0h9tUcGFHN0GRtbm2Yv3wXAUfDgo4/+kZGDs0icVR3JTPuIA0rA8TAWBNfwvoUP92/ZMnS8MixkNjBb2X2fskw92f/C4A7v5aLay3xmjPAMIf4QohQ49y2hX8YFfiLZrBY7qVjwzLhiUNt/7/4eYYUjrySsVbDx2ZdC3D/t7QmJpm3uJM8skqVzIpRvwhF/odqpwrEwHHPsebwxPhC6ge/jVdYtmFwXqE/JymJn56V3LlmEWgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caZwv75r9ZfF3PZBoRTxrOEGMcUlriGpEMWE87k1CEk=;
 b=WBMIb/DoN4aNm7bZdoSE+l4lOZiOtOCUMq5J9XP/nTmBxcJkjTLADUGQN+HJxsQkCtEprf9o4MLq5CuDDfJibLDNeizGtopTq/w+Y9eYQkhBBm0ygj/9fMI29WlzluSi9enl4557qiIfk/LUCaCo6UBltADJIFyky8Kg1k+t3nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:39:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:39:28 +0000
Date: Tue, 3 Dec 2024 10:09:19 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v7 2/4] ACPI: processor_idle: Add FFH state handling
Message-ID: <Z06Ld/hobdnAQF5w@BLRRASHENOY1.amd.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
 <20241129182232.14987-3-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129182232.14987-3-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: debe79ea-06e8-408a-89db-08dd135478ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZLuSn3fZouccCV8wef4C6SOMU04ERfNDaSUz02kaaG5oSHgEwT+r28rSI6M?=
 =?us-ascii?Q?6XHq1/2PEdse9UA1aqGoIFGylHBbAc1dqt/YKOD3hWQe1jPYZWRmoiAT3gM2?=
 =?us-ascii?Q?M1WNeZyl7XbISmL4c44J73F7MhL1LXMZYmbRZt0aAZNmf/35vzHR32vqVMOL?=
 =?us-ascii?Q?7VYRkbikwfMt45wdS8nWTJpA5pPMSPzZjsvqWO+q8EpbtGKTOosZwbrkSQJO?=
 =?us-ascii?Q?pmvgENiT3bsoQXOvv2VYWoamcH81+6vCOHZ5DqCG5Q0NYYBJrZP3O/47O+bo?=
 =?us-ascii?Q?h0t4dxAu2uCWinT2Q1vN/ZPBmhkBHdalrqFBOA31/SG2CDvUoarFUarer895?=
 =?us-ascii?Q?+7s8gu/f/zpEVkAiuo94e1tg7PFEpmpTWCzDoTM4PfbXNfdMR7dT81nn9B2m?=
 =?us-ascii?Q?YhJW8bXVNCqxLL7X8c9vIchQvJXIMV69xXOUD/zdp/RLUOgWopZDYouSaWSo?=
 =?us-ascii?Q?aZ4feU/1s3yN42jRE9prPT1aAB0lxQQet7Z14YvuI2nx7XjYhTq9DQkqyi3w?=
 =?us-ascii?Q?uiOK8C+Gk/piSssJaw1kbrQX6Ih+rKcMb8g7sTtgUCAx1r8UBoP1gPTlO5Xg?=
 =?us-ascii?Q?jFJi1J5okCPFPuE9fA0+DxG5L4yvVNmSOS8kBdu9ZyOlI4fDMiBn4gJVY/wt?=
 =?us-ascii?Q?G/iPEMnBE0sMHE+W9kkRJrGgcPFr6EJPOb3Fy18d1PXYQHm25aSwduEiOMVK?=
 =?us-ascii?Q?fgyjv2RdaFAf1JCtMGTAU45seaW01Pu3MdPSvnZ8562cZn9xMlGiSBbHICAh?=
 =?us-ascii?Q?xC2UsV7JZUzvZzHUZuHnS6lf++Daz/tVdilur5HQld90kMe+0amVMdti3xmB?=
 =?us-ascii?Q?zrqZU5aQLKRcBakg3a24tCwmvO0xLbrzyKCevsuDYObyGoe2TrKdUrwE+otW?=
 =?us-ascii?Q?+lZCkQVFN+hvQTPDRh8D5twA4hazHdNVqePTTFwNzVfWOmoaCoqLt6h5PIC+?=
 =?us-ascii?Q?m64BSBW2JgD0OTzWZE+ohsHne/3S8Y6mib+8AdTY2WHbmLObdthEKOf9JH4g?=
 =?us-ascii?Q?aNm1bIX4VDMlk1ZWE7qCon4/poen85hm6kkETpI3lxHWvRafzqEHEUdoVMFk?=
 =?us-ascii?Q?se+ueSKOp+aItko0XMf/tI2FgDx2/O3lhS20FLTSvSrKasjte7cs2ABLgJLv?=
 =?us-ascii?Q?GXAJxcgXQR8uO3Ec1HoKda1bYCa3gbxcDH6coXYigiuW2TzbOTfKGwDAgOnk?=
 =?us-ascii?Q?P8yHjXfOlUyLXXAWwQH3/zOg01aDVLdwSFM4a6fy6cTC1HarjVbQ9UfErufJ?=
 =?us-ascii?Q?XgyCLSad/jHdf2C5Nx/ggTjp82YKbuF84CIMceLSFI+kqUeZXXZeQB8EVPaM?=
 =?us-ascii?Q?QtaIoVzDCJoZ1MEwJcDbXQnLiIrLjp2RNCRpzD0o39GKqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+noawn8wjnCjiHaHEdgJGHmTzwi2q0aq9hJdsl1kudSUJfH8/q2xXmAlPTK6?=
 =?us-ascii?Q?bmCm3GPDCU/wL7Ao3vzadN6d8kMimLnaEO818XrRPqnTmWN1BHGyfepqTLcH?=
 =?us-ascii?Q?BOgSTE0ZxyCjB4tlX/SITBkoVdy3tPR+LB5OCg7dyTXdCSvN90nbwc7DKhW0?=
 =?us-ascii?Q?YmJR5yo0iO7+bjOeamQxSqEOB7hD5DUiRPfOuY2oaXGaYt0fOjliAIdj3zEu?=
 =?us-ascii?Q?UKLCJjpkGUhNUCEgsmLbOnXtlZGpq1RtK6E4XwgnUqusMXZWz9czVK3K6PxI?=
 =?us-ascii?Q?DYhEyIFHBGz7w84rKGE/rn4kYWWUkom/UA1zmLnuUtd/yenT48w0oancnjt6?=
 =?us-ascii?Q?DbibS4x30CEDmfYZEYY8DZpLQMTWP7GS8jIJSAngRFsMYmt/xQRTL5Nx4QHw?=
 =?us-ascii?Q?/L3LqlcaPMsyvMEV8CFupiS4ZVVRyrDsnSRXkqlt7NxSVy8Jlkp2MmWIAKwt?=
 =?us-ascii?Q?YMdkb47eFz9EHFAZoaidHYR76/ihXdPzeGhQiUbmcfMlH8YQbEeP976f87Iy?=
 =?us-ascii?Q?nAQGn7Bb8yc466/4Dp1G/IVmBC0WGZMRWVCKk1yigYqQIjAxtrFxGL49uwQe?=
 =?us-ascii?Q?i9v41qBRqRT15d/aL2jHvw+lbGffBvZ6G/t9Fs4+WqduLUP1kJ+sKgqYE9r/?=
 =?us-ascii?Q?yoDuIhlnLGNqWw3aJJo4APbKEzGvcBEcNOXQLte7rzZRjyTc0e3x9M6RMyYe?=
 =?us-ascii?Q?VbPMX1Ao/0qu4Fx+It45nhqSiRi1vdLotOE+awMz6c7aL5ZZ3RTcXurkf2PT?=
 =?us-ascii?Q?ljDDj0GwvFAOcAHfrvfwrjwhh3Iid79LJbsvJ4xr9xcKspiHz//49M0OfDX8?=
 =?us-ascii?Q?/iZD5fVUPzZYxYsSfepdazStt7Nmo4AfniCLTCKrwOr2P20vlFzRIGu4aW1u?=
 =?us-ascii?Q?9VUkZ0TtyhelIQ2EbbihEOS1eAdxdcdXf2bWtZmmwiFHLIhE9cT1mrSRVRb/?=
 =?us-ascii?Q?oE+i15JpZZOW+hkefOY80BJ26ubAJDixYc5Hrdnq+SXa2lhOz1ex76Qsx1G7?=
 =?us-ascii?Q?8dk3P0CpEK4Cl9t4JMhWYeU0PGIgdfN81CPzR/lkczrT0LvJ/eSlv+/6w6fp?=
 =?us-ascii?Q?i9cq7nGAOnrDFJLmzGyekKBc+J6eqKQpcg0P1U31bKYHc3tiGatFUyz5RT2o?=
 =?us-ascii?Q?HTzxox3QlODskUfcjoNDySurS5YN9L7ZgYs/yww2xqnFsJlXKnix5ViVnoMr?=
 =?us-ascii?Q?tJa8ktCWdlzQ94EySDnF92nRRxxthAxbPfFdT3oFbKpTMET+kO/h4LdR2VEF?=
 =?us-ascii?Q?2RP2j73LXJupqDjjpAQ6MvkDWQOOcd8U8wrownAR5ZENVOtkai4Y1GWw4pZB?=
 =?us-ascii?Q?pmu8P+TitDKBAX83EDmdfxYFVIUsGWOBT64DfBEsViNdV6ofPofMY+mNtJM/?=
 =?us-ascii?Q?Y3QT+TvDr9/6Fq/9CcH47I+Q4epA0nG4zm47S8rfmBfKfsPoIG6tYmdmFX+T?=
 =?us-ascii?Q?PDRCT8DjJx2bEl+qH4IuZ17TFe7RPt4rYkW7cPqYUUJMHuAHuLOt1FDpPj61?=
 =?us-ascii?Q?P+G2ywHQqwsN0Pdfzq9RZuh0UMbje3gNzxAPSWs5T7sKfm5dwutOwEjIZ2CJ?=
 =?us-ascii?Q?WsrKWcshUU+AjTLtph5w0b8DJvPo8qiUtcGl5iCS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debe79ea-06e8-408a-89db-08dd135478ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 04:39:28.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qkJTvqlTSF5stxMZqLN4VQipSZR18123sm3lSxifo8NGEI9EM35MqXRP0kL6xD0YZ0mBoUCbQCMspNB8gWrWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

On Fri, Nov 29, 2024 at 07:22:30PM +0100, Patryk Wlazlyn wrote:
> Recent Intel platforms will depend on the idle driver to pass the
> correct hint for playing dead via mwait_play_dead_with_hint(). Expand
> the existing enter_dead interface with handling for FFH states and pass
> the MWAIT hint to the mwait_play_dead code.
> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/kernel/acpi/cstate.c | 10 ++++++++++
>  drivers/acpi/processor_idle.c |  2 ++
>  include/acpi/processor.h      |  5 +++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index f3ffd0a3a012..8d7b8b02ddb9 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -15,6 +15,7 @@
>  #include <acpi/processor.h>
>  #include <asm/mwait.h>
>  #include <asm/special_insns.h>
> +#include <asm/smp.h>
>  
>  /*
>   * Initialize bm_flags based on the CPU cache properties
> @@ -204,6 +205,15 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>  
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct cstate_entry *percpu_entry;
> +
> +	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
> +	mwait_play_dead(percpu_entry->states[cx->index].eax);
> +}
> +
>  void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
>  {
>  	unsigned int cpu = smp_processor_id();
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ce728cf7e301..83213fa47c1b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -590,6 +590,8 @@ static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  			raw_safe_halt();
>  		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>  			io_idle(cx->address);
> +		} else if (cx->entry_method == ACPI_CSTATE_FFH) {
> +			acpi_processor_ffh_play_dead(cx);
>  		} else
>  			return;
>  	}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index a17e97e634a6..63a37e72b721 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,6 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  				    struct acpi_processor_cx *cx,
>  				    struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> +void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>  						      acpi_processor_flags
> @@ -300,6 +301,10 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
>  {
>  	return;
>  }
> +static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +{
> +	return;
> +}
>  #endif
>  
>  static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> -- 
> 2.47.1
> 

