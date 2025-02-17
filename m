Return-Path: <linux-pm+bounces-22198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED62A381DB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172D67A47A7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88B218AD8;
	Mon, 17 Feb 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSjOg/XT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE8194C8B;
	Mon, 17 Feb 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792062; cv=fail; b=kz7cy0aRJmsBfCPk5cRxdXv6rlex9pWsu51+ipcxrzYQ6/sYQwKZgXNAmbeIIhb7HqYOjKBwb8O9dV+i6AztBBtjkoCdPQkwdwCHUXYRikByespekjKp6JkHUk+Mn29Sn0wVrKLcX9E3LRoaQgWJ/BJlGNQYpxyshwF284i090M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792062; c=relaxed/simple;
	bh=qHv8yvxs5fVzdpG6O/LVdy53eC/WAdKmVbOGU5ELb2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwlE0BzZaLXC6Kdvj7rxZe3MmSpKCrY000Fk8EodDIUwaX3WC7+fBS8XReyz/1oI15L7Cz4dMHbwpwvdSHHpLAfeVh3MJYAlKIwCtpABhdpNKGm/5GzuRDhIyGZ389fTpJjGNKdi1QwNjQ6cQGkWfILmzJ/NCgSnGAKVxQJUiAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSjOg/XT; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5ee9WWiE8/Q87zfL/B/SqtYXvlQ0IzLCuc134DZO6aT4BxN8eaLUlValvG9Mperx0pE8DheSxSdluTAO95VLWSv+0t5EYBp+W9tPlzubMN89ndgTlPA14X161Z8cZxcoaHEvWcjeAq90NxBmex3BxBiZHaHhHDR5sjbCTIfjvtZSioMBSgfUwtQ3YGNUPp1VosgpE4FfDtSJKlTOEDSeB1PJ3nu5+W4TQXKdTw3yZUXDhQAM+TP3wAP2A+1tg5NtVdx2rqef3cmvQw391UYxmWk3dOMwTE0kTi+p1upQiWfadLpxdcDj/ncECsQcUITAMwFsJv2FjgAIpCpmPIWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hozL5nXWJITqyH1/NL2PiEFUwAU0jwsdzFhOd9GRZU=;
 b=YU6L6H3vBtp49qrBvaSUBT8lxCQecZjQcZamkmNsfuU5Y54lwb59FiPIXuQRvGVfhtj6IMz5Ts34HRZc5yBeZpKQYPVo5jg16lpanUpxT1XxulQyBiyRTadXaYMtZez2Gf0FOfL18QRysI9NSpU3WIr3FFeLfzJ2wR+3tvanGgL/reJ6gbyimNBdogp6BLeVBIvRHh6MVtRXXHpV7gk6hQyPiAdkjNapSXu0SytCl4djcY+BryEgW1Jh+AwhQVktWPtoIj+zg6qeUi7EZKKOUvp/W98DcbcJK5ssuDIaGzdXxNTAaCoGo28qHIPHwgwBg7NgKAEiCfkJl5i1xwtaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hozL5nXWJITqyH1/NL2PiEFUwAU0jwsdzFhOd9GRZU=;
 b=hSjOg/XTQa9T/J6kxpspfuaol0yI+Q/HsAd8tyNWWYzPlHnSeULz3WhcunC1nVp49xT0Z+6Y+SRGuXYs+ZVEe9Quy4s4Sm7M6IALHfwwCM0RB25CJz8a/RMQXuHyXvcWzIhRjLoteK+EKGfF4yHKcD1nTaWcUbmbkR/UepKUQ8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Mon, 17 Feb 2025 11:34:17 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:34:17 +0000
Date: Mon, 17 Feb 2025 17:04:09 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 08/17] cpufreq/amd-pstate-ut: Drop SUCCESS and FAIL
 enums
Message-ID: <Z7MescMK+rIX9QtK@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-9-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-9-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a14b9-f7b0-4836-658e-08dd4f470352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jFgsQVhZBf9XcQ1AGpvqTVRBv2+dePy2QldXDlwUIwcB6oTmjeyjoJtAcmz?=
 =?us-ascii?Q?wqANXDokxBvGbA0fAUrcuhge9XMqR+krh9yNeg7cPFa+AjEqbZ59VH+/+Wwp?=
 =?us-ascii?Q?pIK85DbLkjzWRLyP9oaslxZKW1Nh7iXtyhfabD7Cl5lU/MogEtxjfSGW5waP?=
 =?us-ascii?Q?sPD9sOo2jgTA9vwovLNe4p5MgJlRkyo68yglXgYvTKfHxrI/9kev3eCeqQBJ?=
 =?us-ascii?Q?F3arcsN1euR2x1VVGgAmwrpf1hwvwIIMUXy5HF5mALxKuKa+3OoOMHeHSduu?=
 =?us-ascii?Q?Uq1qoY/uKJF4MsES/EQImmVfc45yrB3HWBKwwpNjxBAHHbXcBZZ5rmL/9U+F?=
 =?us-ascii?Q?sXYFYpE384eY+uHjZ3oyAuPYDdGGPjD4dTBfBw9qeiIMO/mcFIZ0+vP5+LNk?=
 =?us-ascii?Q?cptjhoPs278jaeBsf1c7XznOh16y3ojV+J1x/S7fWPM65ydSZ140N41MQuCw?=
 =?us-ascii?Q?11Rk6s8fznWDw7ZvyoQuJ5Yc9MCiMH7kQ7ixB/lRdesd6JCZYaZ8Szn2Vr7v?=
 =?us-ascii?Q?VBAJRnqtBz9LkLHMGuQ5+m/wgb5aoRmR20OvaQerG49S0Xk6a3Eyk8dV/BMy?=
 =?us-ascii?Q?o9DLK+mrc0Hm9URY5UOiSkE01T0eWcAtHY/fwlej/NChPNea+o2NJEd/dXTh?=
 =?us-ascii?Q?4/JUBj86E5UKe79v2uDALqFGZP/8QeZkc238Fw0cy0RXv0CDDbbeCuN7lj2B?=
 =?us-ascii?Q?yXMfHanz4UiZJ0uZBfs8G3q7f4YUY1VWj4c3rqD00pi5tHF5GMLsn0ftDZAP?=
 =?us-ascii?Q?cmeNttdnzmxNKxQy1QWbXao57nILVvAp/DhYFdKmxQV7tKHzOmRzoqxe+XY/?=
 =?us-ascii?Q?SYbg5y8Q0S6W6vDnd7AxtgI+z2FhiUnSpsMtCFaZnTxPHgbQh3/Muh2Yf3CD?=
 =?us-ascii?Q?9s8oG7ZvAMqQSF69ZUn8c7NbQP3d7513plhmQ2ms7wKG8XgBEpYdT2gLlC0R?=
 =?us-ascii?Q?kmbDn8Qo2wqbumiMZ1VrkDSTUG9D4w+CE9X1R37ll9wW7uHbHHoUNoGeZLYV?=
 =?us-ascii?Q?l0uzTWDpjFsHRwE6zgftIxQqG+XGyBirYwkWgDQZwa1rjnVpFAa8HfbWnyq9?=
 =?us-ascii?Q?J4hxZTyVHPe4VOJg9QlkUYDLw90ATxevtO/pbtvLvuECwPisrgvt38+Hdy8I?=
 =?us-ascii?Q?MT2LDmBySUd7SkPaPktLyEEBYklZPZnyDabVH3Pl0bqs/A+xldaFBji7k4AB?=
 =?us-ascii?Q?HWZfQCZm745/uJJkjgl91E6Zh/gQYcQY6ZWGsWzpyUeaq4gDcMVVpLG/ziK3?=
 =?us-ascii?Q?q3ZMZ+Fvh317t1N7hHJ84crvoHYWsoStVdw9OzRiHcex154ExvaLHvROojhU?=
 =?us-ascii?Q?DYmTz067fuwYwTS7FYBqh/GBgCz2B62tw785sN1lL27cxge9E2e6h1K6m93x?=
 =?us-ascii?Q?Ng9rYjUM8ljJ/QSN0xJhajrX5wkJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svNH6z523WgcYj2EIIM6nEvQHsOnxY4uqov5Ko98ZOmV4hVJhihFjdU0bdxb?=
 =?us-ascii?Q?ipC5UvVH1zYXDxZwj6ZELi/Mt2hcwys4f89cRVtXl+PhWZeWM800s6PyFX8X?=
 =?us-ascii?Q?/rwhdZYMRNlt/AkUPqLqx6/FhwuoSmoRdVjhB8Pe2gZR2EYglNf6NhwSbOiM?=
 =?us-ascii?Q?GXKs0ad7+sNS6orrbiQmBIOSKaALr4OqJD6l/fmA2CVDFuCAgvPWgj6zZa5T?=
 =?us-ascii?Q?DkeUtKE0s5Dc6HaWX2q+nlWbSgIin5VqzKyl3NekSJFkAsiI5bFPyGEjxbli?=
 =?us-ascii?Q?xSPnQ1VzwHOGzC0Vw2//4YUQT72wYpt5/GzgpNO33OfIQVNmm1YvCUJQLMwl?=
 =?us-ascii?Q?QuxFLTR/Ya339IoLa1SW3v8rKNqMOjkUoKvG2XFOxBq61moFk0abyBYokrrN?=
 =?us-ascii?Q?FIkKD+8OeOV4ZXE4pFEaly8iZtqwnnFIxn8C6awcRmiMgovjZP42hctvy4RX?=
 =?us-ascii?Q?tXy6NFMJHdn/HAtFwFpg0DyaWbUZhXb06zjkMFPHPfUh0vjwHKilbekT/tx+?=
 =?us-ascii?Q?ELmBcNp1XJtjhF9KNrVKvNXreq80ck5Zf5RP0+ru94dgzMvrxYRm9QH/1SSP?=
 =?us-ascii?Q?kyyxcuQXrTnjtf3I/OBN9NB7Q98gaC8mdfOSXkOIvSBLhkgQXHWP+hz9ur3o?=
 =?us-ascii?Q?+cqKaXC57tNTClL/MyZ6u67CyeYKfLmhnV/oatHVXPSqOEmJdhZtDRL2e52j?=
 =?us-ascii?Q?OEeSbrfk1UNtNvuGbJX8uF9Yqfx9SL0AK1M1xzakJbQHTf+PJ4Rncob1EGw0?=
 =?us-ascii?Q?/GBPgUbiicgGCOfyP/oSCJtMtaMiwpoim/SLgsb8EO91qByAw/aCGvSqj4Fc?=
 =?us-ascii?Q?iSphr+j84NwbxQvcxKk9SbHVpJhB36YwuGwmGs4tCoOA+0pbvKQdWkvYRKF4?=
 =?us-ascii?Q?dZWCWhBPzhSPTyawwMfkctvAmzFRuDh558jFrCddi0qkyl/1cgS50FKzgaSh?=
 =?us-ascii?Q?3xkcZsqFFVY0KZDDv2bCdMpGpzXKzdpMBxpQeQww/GjuBjCa03ohP64d/EGT?=
 =?us-ascii?Q?rCUHNQWrnvXlNwnYOyD0r5s6wiosgD7XGO2xdc4Z3+WL83GcGserpRwddt4I?=
 =?us-ascii?Q?vYFWUUrl8gcD0msm7rKADAx4ce/E3oMtQt8qiLVPwAU9qzrX0g5s7pBtrzc1?=
 =?us-ascii?Q?+TBEIxLV1gLs0PGJ9HwhtJ2x1cDatOBE4VllUuWFmuzRtJTnbvrwJ3MuJSZ7?=
 =?us-ascii?Q?1rqCENZnBOhBHNC4Uoy+VBiW9zRamZN8ammEAQ7kM32cZsFASqket5AoHdNS?=
 =?us-ascii?Q?ztYa7ymp5Ju7tqx5Ajp6WG8sm932WkuKtAeNHZMmw0+Z9nh+zc/wKz9+Zbmq?=
 =?us-ascii?Q?+Q4HJSGtXfgVTfjXUyWnXXPKjQrJf+66T7KCcKK/ScCF2Zt3fntu6TZTYiTG?=
 =?us-ascii?Q?ErR2fwZTAAdZL9pct0s1ZvRDzcv8kRRuThW4q8BH1OF51H2BiDU1MYeJEJA7?=
 =?us-ascii?Q?daJgvXJrFasN8jqSrpx1j76RIq5cmBipsQR65O11MlNdwCAxEqWrytAfgkCu?=
 =?us-ascii?Q?/B47JH0ip/v/Ek7STa0W2ciQhj5io5mrZRhGETa2+0q2nMY7+yk6Xuos1GlZ?=
 =?us-ascii?Q?ZaCK2jn2+4BbWgmdBaRz5YTOd5HSERkCkhIF4Blx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a14b9-f7b0-4836-658e-08dd4f470352
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:34:17.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOoz9XO+OzErFn0RkhxcDkvGQElUCh3sGEmtFuVKfE+pZmLeT8jK5xw5zHUXgYKcdsxJjMcjeQjHyJ68wCXZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Fri, Feb 14, 2025 at 06:52:35PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Enums are effectively used as a boolean and don't show
> the return value of the failing call.
> 
> Instead of using enums switch to returning the actual return
> code from the unit test.

Yeah, having the failure code in the error message is helpful.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * new patch
> 
>  drivers/cpufreq/amd-pstate-ut.c | 143 ++++++++++++--------------------
>  1 file changed, 55 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 0f0b867e271cc..028527a0019ca 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -32,30 +32,20 @@
>  
>  #include "amd-pstate.h"
>  
> -/*
> - * Abbreviations:
> - * amd_pstate_ut: used as a shortform for AMD P-State unit test.
> - * It helps to keep variable names smaller, simpler
> - */
> -enum amd_pstate_ut_result {
> -	AMD_PSTATE_UT_RESULT_PASS,
> -	AMD_PSTATE_UT_RESULT_FAIL,
> -};
>  
>  struct amd_pstate_ut_struct {
>  	const char *name;
> -	void (*func)(u32 index);
> -	enum amd_pstate_ut_result result;
> +	int (*func)(u32 index);
>  };
>  
>  /*
>   * Kernel module for testing the AMD P-State unit test
>   */
> -static void amd_pstate_ut_acpi_cpc_valid(u32 index);
> -static void amd_pstate_ut_check_enabled(u32 index);
> -static void amd_pstate_ut_check_perf(u32 index);
> -static void amd_pstate_ut_check_freq(u32 index);
> -static void amd_pstate_ut_check_driver(u32 index);
> +static int amd_pstate_ut_acpi_cpc_valid(u32 index);
> +static int amd_pstate_ut_check_enabled(u32 index);
> +static int amd_pstate_ut_check_perf(u32 index);
> +static int amd_pstate_ut_check_freq(u32 index);
> +static int amd_pstate_ut_check_driver(u32 index);
>  
>  static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
>  	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
> @@ -78,51 +68,46 @@ static bool get_shared_mem(void)
>  /*
>   * check the _CPC object is present in SBIOS.
>   */
> -static void amd_pstate_ut_acpi_cpc_valid(u32 index)
> +static int amd_pstate_ut_acpi_cpc_valid(u32 index)
>  {
> -	if (acpi_cpc_valid())
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +	if (!acpi_cpc_valid()) {
>  		pr_err("%s the _CPC object is not present in SBIOS!\n", __func__);
> +		return -EINVAL;
>  	}
> +
> +	return 0;
>  }
>  
> -static void amd_pstate_ut_pstate_enable(u32 index)
> +/*
> + * check if amd pstate is enabled
> + */
> +static int amd_pstate_ut_check_enabled(u32 index)
>  {
> -	int ret = 0;
>  	u64 cppc_enable = 0;
> +	int ret;
> +
> +	if (get_shared_mem())
> +		return 0;
>  
>  	ret = rdmsrl_safe(MSR_AMD_CPPC_ENABLE, &cppc_enable);
>  	if (ret) {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  		pr_err("%s rdmsrl_safe MSR_AMD_CPPC_ENABLE ret=%d error!\n", __func__, ret);
> -		return;
> +		return ret;
>  	}
> -	if (cppc_enable)
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else {
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +
> +	if (!cppc_enable) {
>  		pr_err("%s amd pstate must be enabled!\n", __func__);
> +		return -EINVAL;
>  	}
> -}
>  
> -/*
> - * check if amd pstate is enabled
> - */
> -static void amd_pstate_ut_check_enabled(u32 index)
> -{
> -	if (get_shared_mem())
> -		amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -	else
> -		amd_pstate_ut_pstate_enable(index);
> +	return 0;
>  }
>  
>  /*
>   * check if performance values are reasonable.
>   * highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0
>   */
> -static void amd_pstate_ut_check_perf(u32 index)
> +static int amd_pstate_ut_check_perf(u32 index)
>  {
>  	int cpu = 0, ret = 0;
>  	u32 highest_perf = 0, nominal_perf = 0, lowest_nonlinear_perf = 0, lowest_perf = 0;
> @@ -142,9 +127,8 @@ static void amd_pstate_ut_check_perf(u32 index)
>  		if (get_shared_mem()) {
>  			ret = cppc_get_perf_caps(cpu, &cppc_perf);
>  			if (ret) {
> -				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
> -				return;
> +				return ret;
>  			}
>  
>  			highest_perf = cppc_perf.highest_perf;
> @@ -154,9 +138,8 @@ static void amd_pstate_ut_check_perf(u32 index)
>  		} else {
>  			ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
>  			if (ret) {
> -				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
> -				return;
> +				return ret;
>  			}
>  
>  			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> @@ -169,32 +152,30 @@ static void amd_pstate_ut_check_perf(u32 index)
>  		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
>  				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
> -			return;
> +			return -EINVAL;
>  		}
>  		if (nominal_perf != cur_perf.nominal_perf ||
>  		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
>  		   (lowest_perf != cur_perf.lowest_perf)) {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
>  				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
>  				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
>  				lowest_perf, cpudata->perf.lowest_perf);
> -			return;
> +			return -EINVAL;
>  		}
>  
>  		if (!((highest_perf >= nominal_perf) &&
>  			(nominal_perf > lowest_nonlinear_perf) &&
>  			(lowest_nonlinear_perf >= lowest_perf) &&
>  			(lowest_perf > 0))) {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, highest_perf, nominal_perf,
>  				lowest_nonlinear_perf, lowest_perf);
> -			return;
> +			return -EINVAL;
>  		}
>  	}
>  
> -	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> +	return 0;
>  }
>  
>  /*
> @@ -202,7 +183,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>   * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
>   * check max freq when set support boost mode.
>   */
> -static void amd_pstate_ut_check_freq(u32 index)
> +static int amd_pstate_ut_check_freq(u32 index)
>  {
>  	int cpu = 0;
>  	struct amd_cpudata *cpudata = NULL;
> @@ -219,39 +200,33 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
>  			(policy->cpuinfo.min_freq > 0))) {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
>  				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
>  				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
> -			return;
> +			return -EINVAL;
>  		}
>  
>  		if (cpudata->lowest_nonlinear_freq != policy->min) {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
>  				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
> -			return;
> +			return -EINVAL;
>  		}
>  
>  		if (cpudata->boost_supported) {
> -			if ((policy->max == policy->cpuinfo.max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> -				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -			else {
> -				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
> +			if ((policy->max != policy->cpuinfo.max_freq) &&
> +			    (policy->max != cpudata->nominal_freq)) {
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>  					cpudata->nominal_freq);
> -				return;
> +				return -EINVAL;
>  			}
>  		} else {
> -			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
> -			return;
> +			return -EINVAL;
>  		}
>  	}
>  
> -	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> +	return 0;
>  }
>  
>  static int amd_pstate_set_mode(enum amd_pstate_mode mode)
> @@ -263,32 +238,28 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>  	return amd_pstate_update_status(mode_str, strlen(mode_str));
>  }
>  
> -static void amd_pstate_ut_check_driver(u32 index)
> +static int amd_pstate_ut_check_driver(u32 index)
>  {
>  	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
> -	int ret;
>  
>  	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
> -		ret = amd_pstate_set_mode(mode1);
> +		int ret = amd_pstate_set_mode(mode1);
>  		if (ret)
> -			goto out;
> +			return ret;
>  		for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
>  			if (mode1 == mode2)
>  				continue;
>  			ret = amd_pstate_set_mode(mode2);
> -			if (ret)
> -				goto out;
> +			if (ret) {
> +				pr_err("%s: failed to update status for %s->%s\n", __func__,
> +					amd_pstate_get_mode_string(mode1),
> +					amd_pstate_get_mode_string(mode2));
> +				return ret;
> +			}
>  		}
>  	}
> -out:
> -	if (ret)
> -		pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
> -			amd_pstate_get_mode_string(mode1),
> -			amd_pstate_get_mode_string(mode2), ret);
> -
> -	amd_pstate_ut_cases[index].result = ret ?
> -					    AMD_PSTATE_UT_RESULT_FAIL :
> -					    AMD_PSTATE_UT_RESULT_PASS;
> +
> +	return 0;
>  }
>  
>  static int __init amd_pstate_ut_init(void)
> @@ -296,16 +267,12 @@ static int __init amd_pstate_ut_init(void)
>  	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>  
>  	for (i = 0; i < arr_size; i++) {
> -		amd_pstate_ut_cases[i].func(i);
> -		switch (amd_pstate_ut_cases[i].result) {
> -		case AMD_PSTATE_UT_RESULT_PASS:
> +		int ret = amd_pstate_ut_cases[i].func(i);
> +
> +		if (ret)
> +			pr_err("%-4d %-20s\t fail: %d!\n", i+1, amd_pstate_ut_cases[i].name, ret);
> +		else
>  			pr_info("%-4d %-20s\t success!\n", i+1, amd_pstate_ut_cases[i].name);
> -			break;
> -		case AMD_PSTATE_UT_RESULT_FAIL:
> -		default:
> -			pr_info("%-4d %-20s\t fail!\n", i+1, amd_pstate_ut_cases[i].name);
> -			break;
> -		}
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
> 

