Return-Path: <linux-pm+bounces-23343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B430BA4D2D9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 06:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D015B16EFBE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 05:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9971F4179;
	Tue,  4 Mar 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bkz6nk2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C106EB7C;
	Tue,  4 Mar 2025 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065123; cv=fail; b=i7m3uDQiudsM+WT2izzVjDi8Uf4rYOupYC/TGjEXp0vjjOrpJW/YO+ETvwDR/9qIfhV7I8Uttma033ZY52wWf0rPRHnuKd+QcURnVGhumlj2hHkXgc1MrinA3gQ8TkeEvWiWo0rGvI6c6VCTR5PBs6knf1u49JUeqEZ3iYj61/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065123; c=relaxed/simple;
	bh=fN8IbJiXcp5mEX047eHrU3TUj67X3gzqMKmTZMCh8s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPxF4RG3vkOCDReywMr023nF3AUiwRIPrtHOJ72Y6nu1U04zT7gIjo9LMmNaaHqZX2+VHe05PQOxsnsZGim/kqH/m0Fn6JXCb7NgDzyltjrYynrz3UlowCTOgKgz3c0oaLIT0f3FnuG81TVVVL1AI+URRFnDX4IuIzLM3z4oYOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bkz6nk2+; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWG4Z1XLaWhZChwztXIDqNvYiGrJn99hyLgfrFPNA7vNqozDCWBqpLer994mR3sWe3mfUqFeYF6gnwgUV8+5n9zNn/7SCHDWxBL2DFHfe9ZewtmERZmO9JUD1C6VG2y3lw2wVOt+7sRF6D7psSlB8nFvVdok+t21arW3NGifTNE0fJWXzE3836dYotC5Inc/0kj0M50G/pr90dcMbFa91Q681xWq4r+IRmCNcBEmZYwMeKAK4ek7dVPLtjXYxW+YyUUuutcrQFWlkC+ydLGFkKMcVdimGpdbO9ULC4GkmAr2tn41z8P4eXn53AO/65yvap+36wxtkcgbxELeM/24cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0egIaUu7O+Ogqwt8/xDTDbvcWnWNBM8MKWvAiPbE58=;
 b=t3IG92JqUeLKC+BJVC72JlARkfQVfj9omTOzPcfSogUAeyOhUYwaCSqUhHzyCCEro99CGvFqUtoA9+eON6wuonrAuU1cdp8CLPwZBiUxcRAMZQLCHiSdm+IdxG0HSodw9eMcFUktGUzrRpQA1CqP2GtbOWIa6eZhIl0S7/sxxgISVg89g//jFmK9fgEfHRW+e9F0mp8fkEkNTQZd+vjCuFDzp9CxLyeFEc5reJRhxmuI6BFRpC/ICR5JkWUq8aywdoTOf//kA8iEnFB8rUZ75uLH0Jhfzh0KdsQdkRqNVFbbANgNdPNGi9tlSuZy3PYx9sRBD/zYA6LGMR0w8uHypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0egIaUu7O+Ogqwt8/xDTDbvcWnWNBM8MKWvAiPbE58=;
 b=Bkz6nk2+Tj2drT1JAKskQyopWWjWSoBYaxh/wP5ooMjtNos6y4cyOP7sFAokau8Un0RhyP2IwzOxQsri1J30+um+oCytXWZbYttRccsqmu4zScJU8pk32phfoMV6cxwqLVBJLnOyRKjlVlRh3CDWSewP1gZARzPFESLnDb1SOYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:12:00 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:12:00 +0000
Date: Tue, 4 Mar 2025 10:41:52 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 19/19] cpufreq/amd-pstate: Drop actions in
 amd_pstate_epp_cpu_offline()
Message-ID: <Z8aLmDL++IAZdlAZ@BLRRASHENOY1.amd.com>
References: <20250226074934.1667721-1-superm1@kernel.org>
 <20250226074934.1667721-20-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074934.1667721-20-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c7ff4f-2e83-444e-e447-08dd5adb17bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/onAlXYhYxQOgvgNb2uxzWqeYfK2SIzvEBRfQ5hdwc5v3U0gsZqYT6F4ntQ?=
 =?us-ascii?Q?VzTJ+zJOpC9fx+xHvhwaetTzLoavArvENTPw5u0xp7DoCe0XxuL+51feGX4J?=
 =?us-ascii?Q?jETMfujMP0ySxp1LSHUt1ebKCXgWXP6w0ZDAybj62RNNZPDvS/AduF6UF6F4?=
 =?us-ascii?Q?QRcsVbM3OMYQjdkVFbJ+fn4aMb8PNb+VWlPa6N/YuICbiXxv3gN2MFbAzHnY?=
 =?us-ascii?Q?lKLkC+yOrnkhZwVl39LWgHCSuVzfJfNovJBeNUjnbxtSRTnk0bACBUClf0VX?=
 =?us-ascii?Q?uWnlQtqXJLB+u3jZ6pfbzCuvLuQqSMhqoutbIGR5wG5Lp6D+X8ua4hG4gNfs?=
 =?us-ascii?Q?dUfUFpu6C0P6pnf9YUHAYR4/D5tekUDzEVx2pNOXFaOqOhRfrAvtsUdcIi+/?=
 =?us-ascii?Q?W6L+83kiwsJfODA4Ep/r5HKCB49sFaaG5lHkFUu4Kf7n+PaM3oSovtUkZw/s?=
 =?us-ascii?Q?fg+89T7G9RAibZ6GtXsJP/lItx3rCMTHht2dempMWQb6Bmy5TsPq9rcCNFmU?=
 =?us-ascii?Q?yGdM0L57WU0vZL6pPcrTs/4h49oZqDGX8nfWxJTdOrfdHkiHG3uTay7BrsQk?=
 =?us-ascii?Q?0khh5+NtmDfM/XnGcDl3QjPSqoaZ+4+Cw2jWxIoLhgdDRiyn5c34IJY7r9W3?=
 =?us-ascii?Q?GuTWt7BFzbBAbXuhzoHo6C0cnWHXPU1+T3ncE+23yYsvrzD3XhfVFnN8SvsY?=
 =?us-ascii?Q?OJkdZgANDML2tXBinzcWU/QrL+E3Am8Tu//ciGjib1Na9rQJlU8lNvkkHJQU?=
 =?us-ascii?Q?ba3c8phDyI4aF61JWlsKHHQiD+madnZQwdoHj27KvmkNeoPksVIGHcIR7aPt?=
 =?us-ascii?Q?bQgfKC+N/HXIHr726CWIDKp60Cxnmar5aC7QyROrQ4OKJoq2U08QWK5G3saW?=
 =?us-ascii?Q?ponIzdzkwRoObUSXZIQsE6YcBSZIZhMHoJM0GDLb0Wvj+8e2+tBKft5tKmod?=
 =?us-ascii?Q?B9F0ocYnHuG6cEBokOMGTR+73p7YejJG03pTdP52dWlwZWUJ7n/0z4LvFpqh?=
 =?us-ascii?Q?qTKGqs666EpogIXOkv6PU4w4s9QFyk/8fpebuCrNkKqDpnqdjZRBggwVc6gr?=
 =?us-ascii?Q?2a3HxGMPhhQSUDBs1jAowU+k9N5j6L+jreJCBE/pKhHUhjw7rYOSflly+2yH?=
 =?us-ascii?Q?1TKkeBOPnVlIVFe/jH44X6pfTzQWAiY693QdYUX86diaTViU7AcM7p1N8fZB?=
 =?us-ascii?Q?CawnA+HSYwSkgWfhQNPUaGRLDbrFdIJI7pjaWgqdlbkn+rCebjFWUR+g9sAP?=
 =?us-ascii?Q?OhHvb2OK8M756tixkiIxG3mNpDChIgvTn+0T2HikSR55QnMbwU4Zq2Xyttgn?=
 =?us-ascii?Q?qrgPP+ITVonk+eoWQuHT3RvFVskB8DtYXThSgS+lCOsCSNVq9vhshKf5kLUh?=
 =?us-ascii?Q?8W4pmmUK1PfYEd1ZKgzomBsw4X7D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUyexJc/jYbAjbiJ51Lef8aD5LSbYhVb1RPbTYz4Nwn1BHyfT92ILrU/Kqhk?=
 =?us-ascii?Q?ilCyyPG0mq+KcFDQamKSpKb551RNNxZ8m5r9JnXKlFiU5jj8IgEtek+hQw2E?=
 =?us-ascii?Q?YlFMzN0mul5CH1V2G9oBFCfglMiZe44jRCme3KxUlDh9/Pwn1m4zdgAQ4L5i?=
 =?us-ascii?Q?O/l3tFjRMkFYrlC44QVZrZONbndXyWnQrufNLH7EazC+gjEpI6Uej8E+3PuT?=
 =?us-ascii?Q?l1XbSHTw+KY88O+D9rC+RXB3RHSBV+zUhsSt812T4FCOXORucvIDhC9v8yea?=
 =?us-ascii?Q?Ct1PM39FERHRgrzMZ+HVijEkdipm6LJINA7/lvX9bq2fS+tJuaWec3mRzCKv?=
 =?us-ascii?Q?TMCb/cmoFA9cjWB54vLnogbWt//TNlUljh7Q5pUorLFZIi9/in6MbeuGCKbW?=
 =?us-ascii?Q?aQSaOdUIQKHmB62ReA2+hyyhefzN1UoBIdnrRaRfh+7mjl07qzM7IRx1TLi3?=
 =?us-ascii?Q?TNndapCq/bL8iKHRVwMNJU8NJuR2RaYn8nG1cVg6yR4YTAfP7Q0HqgCnuTH3?=
 =?us-ascii?Q?jEfHl1mUUDYdeoCaa/ybfgH4qcmQDgwBRMA6ADrOFGjgdc03OpGvKAHTxIAq?=
 =?us-ascii?Q?virUnRctve69di4MukJZ/6WDGqfuPZclIMaGLxCJh5ZlN8NXKwWOb3as/VNx?=
 =?us-ascii?Q?xSnSQmyjmeWzalBNfY2kYvP7jArO0ZC+Lkw19jb1pzWabZ32NWVU/McNOigh?=
 =?us-ascii?Q?RpM9VZAkgLQOB6mfc9SzWV24egtq9VZQ7DGzupcXdOb1mT3RqCTS3zxed2HV?=
 =?us-ascii?Q?HHxajfITyKOfbhIfhC82Ja1DsYzAdLcptTSTG/B25M3BG646fVWKR8NOT3M6?=
 =?us-ascii?Q?NStgEytVJp5ZbynyDkXFDMahPs6ZfUo2ng5CCDGdiaZJDfx3iXidcBJJSuaG?=
 =?us-ascii?Q?r7ght9k8z5rUkWF/7LPVkD86N5MOx+5UrjX+wVdkly//hqzfajDVl56uA6C7?=
 =?us-ascii?Q?gla6JJbryPMlKY7P0Ti3uSUdDPit6uollLJyqFEbNsrMLH6A6p++3Eo1lY3H?=
 =?us-ascii?Q?FS6VttZuJ8EBBBewEu8egPRRaIjRHbikFulQsfBMs2EVvcY9AblOSeLLi+pQ?=
 =?us-ascii?Q?zn5tjwktjYvb3hxu7O6+hNRlwB5ponRZa5g99JXGM+ubMjmHsSb5g3OXIkRK?=
 =?us-ascii?Q?+lBrr4cA39Aavq6f9FKSENMg1R4jplgXTptBL4jmd587FG7lCyx6iuwFvkiB?=
 =?us-ascii?Q?c80xWusM9EE87FCgIIuwPRKg6JlGUjkucFoZwaViaNjVaayzaJsecTl0DHBf?=
 =?us-ascii?Q?wFmJkBEsLoQmhph7mlEgIKlQ+lhoHHPHlzMFcnkkxxxYSef2TyXdWtxkQ9W3?=
 =?us-ascii?Q?RC3kNGEFhGYrKR8FfUVC8om25/SyRVtbd6c+eY2BbTGsxRMnlz2hCH0vG5jp?=
 =?us-ascii?Q?coLXDVFTcSo07ijqz5SryGXxDq4tMIPK+GVwwEFd0JN0BdxTJjCQMRj69k7p?=
 =?us-ascii?Q?rUpHEzIVVMfm9SaZ3ixRojimP9PRy8oelGIwcT1JY4i9m+ffZlVGcHGPu6G3?=
 =?us-ascii?Q?xWFczmLfm9xvPKDRAS4BzQZhEAI9LEtAfNAXRk8jel+WefnScHEqq6Lu6hog?=
 =?us-ascii?Q?G6oeX3dToD17nVc6QnD3412u5ksvmD4Wl0Xl25BC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c7ff4f-2e83-444e-e447-08dd5adb17bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:12:00.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CTag72ZAKB3zPK5wJVGD/KXY1kwuvgDBiXK2QBcoEBOUcQBsOrUq8w/nurBe+QOAqTEakc4cnXMCdi/94cmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

On Wed, Feb 26, 2025 at 01:49:34AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When the CPU goes offline there is no need to change the CPPC request
> because the CPU will go into the deepest C-state it supports already.
> 
> Actually changing the CPPC request when it goes offline messes up the
> cached values and can lead to the wrong values being restored when
> it comes back.
> 
> Instead drop the actions and if the CPU comes back online let
> amd_pstate_epp_set_policy() restore it to expected values.
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>  * Reword commit message
>  * Add tag
> ---
>  drivers/cpufreq/amd-pstate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 24a1f9e129b61..4a364ae9b56a1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1580,14 +1580,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	union perf_cached perf = READ_ONCE(cpudata->perf);
> -
> -	if (cpudata->suspended)
> -		return 0;
> -
> -	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
> -				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
> +	return 0;

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

>  }
>  
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> -- 
> 2.43.0
> 

