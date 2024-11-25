Return-Path: <linux-pm+bounces-18090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5448F9D88F5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC3C162661
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1318D625;
	Mon, 25 Nov 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Rz0I9g1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26404171CD;
	Mon, 25 Nov 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547753; cv=fail; b=qndUUYl2946+OLT2MuWo+nJAFhzXrlTE15M63r8Q043NrFKQQ3h5kW6vMtfiJA5WmaB3Y9vUDyJ+H1pQV0j2RYdnHNAXl2BjkyWL5+FSLSC/PgtyMUjtTnBzBD8NrRbQoAp3ToVN3RzVkCCjxPnWWZhgx1u72MUTUcNdbbDpf08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547753; c=relaxed/simple;
	bh=xYqp9lIQGyCilVIfaTJVu5U87DBDbMpm4qOPZxSwWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8GGskxa0M/L8meuZcCMr3gSNwoSE16TzIXb5pfwTBFO66ZdH1veJBjjPNGokRlDRFsej6c++PxFI/p6HeXz1gAYWF5qDZeQ87BS2lyoQsIH4D2cULysydcCBMvL8knOgg3DxTwo00XJ0WVWgj9Tp1mdoasCglXY/2kdJif4tV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Rz0I9g1; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veHJosIyF6hq1f4Z7dLpwGLnOw4yK7dhtXRNerctLb99nWNPdpWRmrVUi1IKEQ/cNjEOHMSKPbZoX85fhOLTwxr953xrLvGavFdV4yCGwmMRpB3tBmfgxbHrUTG/q8Vq2kL6N2IrEUiQU5HLelm+a+P2YBCbb+4F0HHZ4IKhQiFDfwxftvruXyGVlTSmuTADE5dZx7OxF1s/0dd01Yaf+bfE3GIwuhd3oAcQns/XopasX50TPn8T5VJiQoK0SmqWyGYHJesF9EQjZ0QGpfMwOKW1DIXXgDTjbyDgOg3/UQC+Mg6EhI9yWEyZYNCKtL3XZCZbE3nMNuclEBwi4EZO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2EsVBtPjd536DajFg4CsRzz95Ay+ijzPKCftU2e/hw=;
 b=enn6sXxyKx6vrLcKDu3OsOqehWZ8hRTaLbfzsSBPV8+JNFt9h+hyDwQ9uSeVprqcAUSRaKl/4PiE48eqXTJdrhiRftQ1v2Re/P11y3BqkJHpvOqFh5s4QLI9OygbtGpcHBx9+qJo3ewiWECcp6jFxfqxjE4TYBWokH1c5ioMwVQZmdxwBZdEiuLweDplcEKtvdxJwROnXZxinaphvtEO8vcbwqr1Q4O3ImMemCc+DsQ4RYHoCISuqBw/iU542uNF0e0bASzUS+miHx0VJq6c5rx8MD77CmU1OJNmY4oQ+V6uSYzCl5Lh2ZXUOihhV+WHArjTzIJK/K9KCJtQ1/UG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2EsVBtPjd536DajFg4CsRzz95Ay+ijzPKCftU2e/hw=;
 b=2Rz0I9g1xmkjJKkBPzIUVGgg/d3tc7PiXaMnOKlLwEMSn5IzxZ/Pgr4fG35HzWLogUMOtAIEliTaCjbn19hKymSj55BPh7LnzLDWscPKXpPG24pU+fsPd5hllebF5S8LtPmRiSgXvq01ko+1+5TQxZsciZw6YaaICQN1n+y0zyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 15:15:49 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8158.019; Mon, 25 Nov 2024
 15:15:49 +0000
Date: Mon, 25 Nov 2024 20:45:41 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, tglx@linutronix.de
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
Message-ID: <Z0SUnYECQ8ePq1q9@BLRRASHENOY1.amd.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7d9106-1e85-4f9e-6ff9-08dd0d640b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euP594N7rhcBwMpvqGhf3sJY75J34KGFPs4z1JUMjWbYCRmZq7uHbUw7JVNx?=
 =?us-ascii?Q?RKg/104z6YOQsB7/QFdndLywRs43Sjj28B6jmEqKh+ZQJVi25BkStF8lkFwH?=
 =?us-ascii?Q?i6wPxAp6m5XaRA8Ofe0Gl9p2udEcw1CBuUVzHCBCGeauEkX9Cf4BXNNV19nV?=
 =?us-ascii?Q?fIrwqCuwI0EeW2VcWhDZqQUPa7wAmt2DlcJLe/aHPa/RBVB6/450F934fAub?=
 =?us-ascii?Q?Y46HZ+IslUbdYguBy2ayNHFmS2NYJwEiizrcap/SeD9HguYsQ5Osezk0glKl?=
 =?us-ascii?Q?kT8Pqrs8oO0hsZP3SsiHSuHmlcjp0hZpASza+zIDzUK1uytJhRlxGInf2bW/?=
 =?us-ascii?Q?mETCNwOxSlSghIj29bUQxxUzuLq0ZCOHlxSlEXxGaFJLAMSghKKzvWMwUvkQ?=
 =?us-ascii?Q?czNkfulbpx6E+DxG4dJUg0gAq4E89C0Yr8DBs0qS/lGLLJeW0r5iU4l5ch8t?=
 =?us-ascii?Q?Mxe2KEdMFGy/hv68Qin0dmG3YCKdgW3UYOZzZgnynhfd+sVwjxakVVOyrrNg?=
 =?us-ascii?Q?aTyGfprbixP8fXNgYmFxzmkwDCsdJpHjjCgbVpziDirWZhZXvlN2T9AO2/+U?=
 =?us-ascii?Q?gtjyaJBHjzbvOliFrhcOSn33Fu1dcZZjv9Fdfx/PwhdkNSR8Mpt8lWWM0MB0?=
 =?us-ascii?Q?Nmv8qrVHcsIyQjoVNrIZ9VFZmiBxssXkMUzU+Lr9Qf9ADlVgML6uTFgzA4aH?=
 =?us-ascii?Q?4NelN9jp3REq0scK+PltjAx5RIdBH+8P27VOYAKljwCJmU+9WQ07lNglZMZU?=
 =?us-ascii?Q?Rzv0/B9FOwiIZwBcQA70NBllRJ2q1RrjpO8FeW9NQgKNdnA9rR0/JLI74eIO?=
 =?us-ascii?Q?E0pOCnXWRLAJX9n4umlOUHGY1cc6USJHa3Pjb1GZ03ANfUsi3E2v8R07B/iO?=
 =?us-ascii?Q?LQHGz4UQL1jGPKXcxJAgjHriDZR2QIjt4ELl8ICNeLLNxB1ZUJTQDn1WMX/v?=
 =?us-ascii?Q?62hlrdMxUbiRoxtVLt+CKIutK0Gt5sb2L65om6ZG1xL9qtXp9BWgDuNC2rrb?=
 =?us-ascii?Q?Bu9Bhup1XcpKUyMO5PK3+5P7vgvpg0BSCQfDbbD+HLkNrVZQoAv/Uo3EZ3DU?=
 =?us-ascii?Q?/9jEAahV0py6ExwVeE1E6uyiAPWCJ+Rf7W9MANVmCA6WR55/fYbXn+EAkklv?=
 =?us-ascii?Q?Fa03qvUZthK+fbYq+FAIFLESdBC5QWZnyOzu4GEib6wYhmBYaxlQ8f6pm5mN?=
 =?us-ascii?Q?D3jjhIDfqRw4imgFmzQFMN5NeU10s/AAVpTAxTQEoh4yDfpngLxrWAhd7DnN?=
 =?us-ascii?Q?MWEazddqc53iB0Mj5ANZgzW+agmGcXHDfQ7Mk2UHRPS+NiADXKWnXnMJwtEC?=
 =?us-ascii?Q?2wXF5hSxj9yfNvnmMHhEPIwYeBs44UDFVlrV0raDCmdmzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrPOnu5wz9ExL7DhVmNoZb3r9MfvWaABQeJ6TQEBGQH/T4Hebv2FT069VbXL?=
 =?us-ascii?Q?FcH//R9SKv3PSvb0ndckdtwKXLxj+U0t4okrtBJ38vCYJ/tcFc9zwYrdqsU3?=
 =?us-ascii?Q?q93ILM1B/FX1FjIkpYQKpyLy4fD7KIPfm9Gco9Gn9uTb/3TX8xcisvIDEewB?=
 =?us-ascii?Q?feIafYQAJiIh+1jmN9Eu9oVEsMR1qlEuBX9gOdjXuwLpBPyw7oYjU+e7g1ke?=
 =?us-ascii?Q?Qw0+eKItq147WPdeSNcUPhkfqtMOOBuKaPAlVnwhIzwJk4Yvija4OxCebvN7?=
 =?us-ascii?Q?i3BLJyLgjeIEYOWXDazC5OrdhtWyv4M7PZK4ZAmajz/MW+2WfOIAg8K1xdGy?=
 =?us-ascii?Q?CSNc6EntPMUWuPy74uzARveV3IpHWjBL/n2+KOPoSPKyWB/gGPcxSLZNZz5u?=
 =?us-ascii?Q?X1XoG4ABo1NhZfmSpTHtLSTJIhFux9MCe9PBT110v/CI41xl0G0XYBZHJedO?=
 =?us-ascii?Q?cEtrQCtL6EkED5h8gN9Ow+m9nWs3vTXAYjgg4jpk9nVMGijuMfpTQFnDrzA4?=
 =?us-ascii?Q?y47SmEuEToX2Q6FEoLQCZ2hMjbH535E1tKyZLOKZwh6zkeYrNQhnjhsBOFMn?=
 =?us-ascii?Q?nIbcZIBmiRsFBCTIRPXRV/Bm32SJ6LsdBbSiWy6+b4qaxESiPMjbbVKdrJf9?=
 =?us-ascii?Q?6Pdrt3iSUGVeG+JLzVPb3m1f5VBMsdVmG67YJ4b7ni8RV+0R/TGEsgj6SuEO?=
 =?us-ascii?Q?mGXNfklYFGK9qkSdJiAmcBFsCRZl5C5zTqobJpmYDcNU9YA6qQ/tYZHHxa+d?=
 =?us-ascii?Q?YBsss2PYGWD7MSZOyGxPEaq6Tcjow3KKOVPRyTXeVHpGkK8HPGALZn1WIlyq?=
 =?us-ascii?Q?aXyinCwsPfB99Nw6vXxely+IRhEBI/HO0KdE1UDcoFTbYJLaGcgL3xyPa6du?=
 =?us-ascii?Q?qVhios7hib5HUwcmFzteBNfdUY7xunYm9AagUx/Yp5wsalwRzevbHb1O+9T0?=
 =?us-ascii?Q?E3isedrChTuMRz47ID6zB//wTh8PWg0Svwc9jWREneIEV+j/IzpbP4z5wfZq?=
 =?us-ascii?Q?57bjybL4RXpxUNR6fWPnhXnQU1VXVQG//9+s+q53bpzwy5vKSw4Hx32BqKOU?=
 =?us-ascii?Q?vKe7gZDdFZvetoXPpH/ZEM2/2Tm3YxvK4/Cr+a5d+8rXuxJM7rPepGAUOAMb?=
 =?us-ascii?Q?EeG0QjGMWahDjDjNZygW5U1iB3ykcpC+qvUx8ZfM+qiuxpw5bdkj5whAMzep?=
 =?us-ascii?Q?225Lp+TSu75FYZbYSoa8Cm6IMzxbtTxpRD8BueRL1tjJ01NJ9TDJbRpRSxYD?=
 =?us-ascii?Q?z4Mc+f64Pop/nVaoq/kBfudXNEKquJCHcR+LxCFjbL8A7XUCF4yDmwad4Bso?=
 =?us-ascii?Q?veOd1dJPLBzTkkuKL04a4UdVg66IUfJG9BbhYmB9WBPvpjjp6z4UfADVmEN0?=
 =?us-ascii?Q?svbx5aPa0GPsYR/dsFipzz6C/tGXcTveQbcuwrnuFSi/kYhMgH9OMNeh1P6Y?=
 =?us-ascii?Q?ibOInSn3vvlAxgaqGN1rKVFYCFYgvC62O2Bav0hr7HSQAR/vBi47TGOvpdXR?=
 =?us-ascii?Q?krUfp0KbjP21jhV8Em3dlWiiiXHLs8AHgIN3KFsDVfDpQc/RTPd5M95g5n7X?=
 =?us-ascii?Q?Fok6iF8eYTGonTe9nTXSUw2OQBlI+Tmjlat5fqvX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d9106-1e85-4f9e-6ff9-08dd0d640b47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:15:49.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhxaCWXY9JU2CApmnMYV0f/K8aUhwD+sGBo0xr213oLfcSwD6/1RmvW9JtstkvVw//NTE5ZgK02EnWFb1ghJpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

On Mon, Nov 25, 2024 at 02:20:28PM +0100, Patryk Wlazlyn wrote:
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

You can drop this patch. It is very rare to find a platform that
supports FFH based C1 and doesn't have a IOPORT based C2.

--
Thanks and Regards
gautham.


> ---
>  drivers/acpi/processor_idle.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 586cc7d1d8aa..4b4ac8d55b55 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -803,7 +803,11 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  
>  		state->flags = 0;
>  
> -		state->enter_dead = acpi_idle_play_dead;
> +		/* AMD doesn't want to use mwait for play dead. */
> +		bool amd_or_hygon = boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +				    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON;
> +		if (!(cx->entry_method == ACPI_CSTATE_FFH && amd_or_hygon))
> +			state->enter_dead = acpi_idle_play_dead;
>  
>  		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
>  			drv->safe_state_index = count;
> -- 
> 2.47.0
> 

