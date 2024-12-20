Return-Path: <linux-pm+bounces-19556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C3B9F8C7F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 07:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E6B7A2F19
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69E4155743;
	Fri, 20 Dec 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hKNs30B3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C301422A8;
	Fri, 20 Dec 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675408; cv=fail; b=aSL33tlJJzKf/BYj/64PWQlTrNyTpy+6i9AxTduZIOWuvv5ddl3X7URDVgOUeep5ygRabZMKfdT2ED/JOLGvgZX7D95JI0IwwKA8NWG2xZQbmLALSWI/5uGaSZ2/yYsBqBQdtzqDxNLQ2URxLuan/2BlV3dbq16Kk+zyuoYUaQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675408; c=relaxed/simple;
	bh=ZoYoyhqareim4vXQxJiQ9r/1N/wf3AUu2KNTKaNzQl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtvvuNXEn0mpEKafhRg1v7Nn16CVE2qr5JGrthGFYSc+Q85aay524sVPjUx22D6yBLnuchexxUtjw0ht4wzAxy9D3iJNqlECg73cuDKt4sxpgI5f2xu7yD20VFx4/+VvIPnzcqhLvT9h8L4CevPnoTAUJ5CXGTk5xF0/NcGARfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hKNs30B3; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt2mik7u1O4VN1sKctF5KGrLf6rmRRDnUUfuEFLEiPsj2H6n7AWmil17hkoLl2JZkSUi0nNAO6VwBRy/aTyClf7i5LYJmj1Eeq1UZupX2H7ktEF08iunlZq4OEH7CEljq1t4G/HJNMUA+IZU55TvS6TCcrdJz09+P3z3FDGCK9sRFn+JQa7RUA0t4Z2ljkt7BxlTSUjWsbCTzTXzdhGEhDU8b9zoDwbydcq/cx3tS4K0RTnV2+vAJNk4MBLaMI1H7fS7TJ0N0rVipexvlWMAqKUtBgLIaklxk4pdycM1hiXwpN8PmB6K1YFhwbbeUAIiczSpTxKMTDK34TE9F/7rig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DlDS9sMD6ZHU/jbbYIOIX/3yUI/MCjvFCCJZ5+BO+M=;
 b=UqaRXdisVtt7xpvTmNWp2hiLN5P1NM/vPg9jsDqMEIvC3dlmr+1tNgOpvfddd/Opm0x65W6kXANWVmwQuL6D0kYq1kNfFMErQ8ehLVHz1K2oWPFl1qp4CBYDyrVxjPzZZsIrLqjbpbtTeTKZgTeQ2OyMEIxbQB8NbZPSLUaKLmQvXm402BNlnrckX8BazOtLjxJzUn7nrRLnnorxWDS+R3kTNMNdr38Z9fiA6PWbiMXlzQK58lwYNNiSfiSLNMSx3fFYcQHbM4Lk4Whq8timuc15mUIdZvVt1Imbh/ZbhI7zra9NXLynHklKBvpx2bqI4w2DZwmKXgx9+fFy/Pvpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DlDS9sMD6ZHU/jbbYIOIX/3yUI/MCjvFCCJZ5+BO+M=;
 b=hKNs30B3I3fysxDjSFPTvwVnxYwGONHdlzI4Hu/OsREipdD6uDYo6+0Uu/zd68S6zGJKrrPtRNbSC1rcoI0n95Z5R0+efs/rDlbJmDAYi6rh0j35XQ62n/douqYYyHGiKgUiyxe3ivXP4PI3AdmyzqFqWmLlU2nHTPXKBNeyoVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 06:16:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 06:16:42 +0000
Date: Fri, 20 Dec 2024 11:46:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
Message-ID: <Z2ULvwb1hePiDmwj@BLRRASHENOY1.amd.com>
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219192144.2744863-1-naresh.solanki@9elements.com>
X-ClientProxiedBy: BM1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef881e0-9a18-4d99-bd1a-08dd20bddf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxmYDiBC2EC0/CTckSX2oM487Wtctxl974cm3QAgkWKq8js7TuAAxYhCp+XP?=
 =?us-ascii?Q?lISxlFlaIoPo1m/lTbsD/CTnfQS6Vu+r/xkAsQ37FRBwXrx2hKd9jVcN8jlr?=
 =?us-ascii?Q?51wLUIt+y5s1gzZxISBrGZ71dWCHHfIvHjUvQm9SBHyiMG+iXIsbW6Kz2WrJ?=
 =?us-ascii?Q?/xAxYhSQ6AC0Rh7h1aOrN0JFhc1u/BOWdEKE1ibkAPFqUGYYiRgxV4kADy+Y?=
 =?us-ascii?Q?L21pvjLoidyzD80h577SRDpFs/vcW5FulCQ4AxjcgGWHQdtvP6PD+7vBz6iG?=
 =?us-ascii?Q?N4t6Ygl8RWkp9VtZxYmKBnrduw3gB2wHEveZzfloc45/qRvMqegv+xcICzzA?=
 =?us-ascii?Q?sTEMNwRSh3NP06mMZaayxSMXAeO/Iaao1V2lwyJ8IkatK3IwonQqIsm/u3H0?=
 =?us-ascii?Q?dyGhwcY1a6vwzbx9WVy6v7lZ1npECpZBtzUfH//B67/GFr8L0lEPIZP25ezQ?=
 =?us-ascii?Q?WHb2ILrZg2UGX+SzaOmqSUszrBtAKF9Wy1rx6Jn8osBoefAubH75spkCI14S?=
 =?us-ascii?Q?1KeIetmuUpH5jSsFWhJjcGgwX+yVruw/nFHo8yRJSlkbmxcyXPnDtx1BDBwi?=
 =?us-ascii?Q?oCRnSU2fFut9W39g6dI2z7TJdUz96wIdKXyfxFviuFPhYPRyIPHFlILwurJa?=
 =?us-ascii?Q?UuJYln5VlbEWtFkoijYIyPSPcZTGioBRkg1OV6EmNBfEJE1iXMyBFSb0aGcl?=
 =?us-ascii?Q?XGldn5fMu0uZUgMLMM+ivKSaGKThHtDKD9oGhjo8tpQy414KLXEGAy3BAyFV?=
 =?us-ascii?Q?2r2snP0mnGT6utd8xPZDj5xRgY76mkFpG8YIThoCiknB/AbbOdq5AMvCekYG?=
 =?us-ascii?Q?fUaH98dk7ItnmtLfwmOhKA/oAxSH/07SnXdjZc0PYY2wX+605fqkEUQcMHwc?=
 =?us-ascii?Q?/Z6N9xnABin21B3odWwo1B1QCAuIKyFxb9t36tCa3VzpGJalR/a+L/tJzaEs?=
 =?us-ascii?Q?0LV+UvldMpHKIZMtdiZzlkrF4/TxndichTTkr1HlTIofbaLD69rWCtBS7Mzy?=
 =?us-ascii?Q?nK6aSXmB0scoR1JFf3vZQhq2HjdNrU9+PMSF326QcZeXhwIPe/5aoux2/S0l?=
 =?us-ascii?Q?o/meMq7lwpFBU98IJfvLUsp3IvWAW2HFg7SlOcYfuCl1stHvfP4/ZmUf0G0x?=
 =?us-ascii?Q?t65apiCQR+kEfY/FX7GoGvjakCjxKx6G2zEmLVrrYvqMW6VmoWYOtzuYVlwH?=
 =?us-ascii?Q?HrG55WgHWyluJ7L55s70UEnGskVsCCbBgY4IEDQP+1/abO5qZSPieyR4HG9I?=
 =?us-ascii?Q?g9251ZoACIjp9z29APLZIzqzDyzkOB12beaBLgTEQO9v2Nd8cfgaQWHin643?=
 =?us-ascii?Q?/6txS+4T/ALGovD4BJQCcrTMtrN61JE1UQxy3t5NpsMolQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tq4iy7Nu1ctAKNgYHdtXpy0+wipgecllUz6x5qVTia0U7xA19A7GdXtJm5yU?=
 =?us-ascii?Q?R2SZgefdyPtFDzczPuygHUjXKTIh49JzzmJihqGR6tyQ4ML4x1Ps8uN1TYPG?=
 =?us-ascii?Q?mlaD1DbnTj5EknPwslH+oGDHtnP7eZmtQxcq/gxBJU+L6neplprw62i+M51U?=
 =?us-ascii?Q?hlATJtcVZcG5dSyOzmswlxxtNX9FloiWdFC2H5U1AE/KSd4yocKbMTI4wL7L?=
 =?us-ascii?Q?S7I2m1zBNbPGYLX3XZWHTdlbj4rkNSk+NXzxo1NdZ4zSbEXH0V60kdPDqk72?=
 =?us-ascii?Q?G397WVKjTbguhsd1sC4uMmm42qPHif2RVl+POXde4yB+jUY9xiCVpzmOISpI?=
 =?us-ascii?Q?zcKUeVjJv4FnifOVo1C4ONVK0KuLnfqRzUIsjyTBfHbZOqkTQZz96i22fVZz?=
 =?us-ascii?Q?av82/aFlDjNPcMxNOik3b8YMETInSdD1XumUV3T99ug9PtCP2j0nnfkiYcFp?=
 =?us-ascii?Q?I2IhJx9S+AEPjrqN0DJ4DnSk+SagP/3ZQJaEWIEBv+Bncr4VKLR5Y7t4/OAp?=
 =?us-ascii?Q?2oCCAPH/uFAmyOy6L0Z0j/XnGaTWPlr3CO1ZVY8acjJJ2iIMP902K9Vjsljv?=
 =?us-ascii?Q?7jOJT52xdOzY6xQroXdjYcMj+K3EmExQySYmCoTKFGbmd0D1cprXqWczEK2v?=
 =?us-ascii?Q?vzpax7JFH4Q+bllsESovUXJAetQAIa2i99+DsIi5pIjQQKbTMNqO6oRFsGY8?=
 =?us-ascii?Q?VDuSZ+PN1fOeEoddEy9+9mWMzWmkxchFuvQsiszImJBydn02l5RD3O3zI5qP?=
 =?us-ascii?Q?vouOqGdvvO06WftPl8Fk5ECMswV9u8NqlmEflEXK9FEhgfbguMeVQ9tfTkLg?=
 =?us-ascii?Q?oOtVD5LKLWnUEdet6XKsa7EYeAFOeF7poJ3Wdp1goLbNTdytdMxwhmyNN/Lz?=
 =?us-ascii?Q?OoFEwp0Jj6yoaczvGs3ep7xooEG1qlQluHGGgsUrlM2IhPHTxxWDvukAHruR?=
 =?us-ascii?Q?MG3ZXS3ULZhELlbIEUFF+B3NpzGp4c9AI15WqQGiTfL4LUkXHXFl8rGATti7?=
 =?us-ascii?Q?DmyKajEzr/UexoZG6E/ifbs0OYVp9N+40mSPEY/UQTmGAhhe6GeOxLZjgkdu?=
 =?us-ascii?Q?ZeuSU+FfLx3bJTuIMAwPbHJatVO2BPnBMX4c+1zEz6uM5/MsLiBAMm78ao3R?=
 =?us-ascii?Q?ucATDr1Q5GUMAnpFvaq3+TQvtgZCKyL85n7kZbX51hShPNnJfvegB7NTDqjC?=
 =?us-ascii?Q?12B5CEoJAb+Y1nZ9hGJARZnUf07eR+8Ri2iWb0OiF+7z/3J3LzqoLlG8WM5+?=
 =?us-ascii?Q?B5I4Twp7DpZwGp4QTETYvth/TbydJAPW8qvl6+GIgjDRa8xBMJv1IXSJ1Rva?=
 =?us-ascii?Q?Yj9E+a79/eg7onA0Pf7uLLGGfIZAzT2LCjPjQbrw+odV5gKjHLqZZniWisEQ?=
 =?us-ascii?Q?31Ji5ot/besl6E1KeFdWTPUsDp1QtlJ3s8AVdzHcpjevngyZaqmQ1pdgQmVn?=
 =?us-ascii?Q?sEdGBk2a6NCtpGOEI5IjVIWJxtVz/k6VMafZ37YUGFzSu5OAhjIdOukVyWnq?=
 =?us-ascii?Q?EwZK75wnA1wTtqL+/CzpcfgKahlMyI7cQSFrU44vhHsp0mdyK3ggSTpESM+p?=
 =?us-ascii?Q?Bg6NczWj+FPBLRiJgkSVjcgzevPLwRrsJFAL8ma3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef881e0-9a18-4d99-bd1a-08dd20bddf22
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:16:42.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMqRof5LcqMC0VXoxCHipijDLHMqJji5jED+TPbw1E+hvyVqJM2NLs29Bvf07abyEVUN6dLR6v+Lzc9gFivI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On Fri, Dec 20, 2024 at 12:51:43AM +0530, Naresh Solanki wrote:
> The previous approach introduced roundoff errors during division when
> calculating the boost ratio. This, in turn, affected the maximum
> frequency calculation, often resulting in reporting lower frequency
> values.
> 
> For example, on the Glinda SoC based board with the following
> parameters:
> 
> max_perf = 208
> nominal_perf = 100
> nominal_freq = 2600 MHz
> 
> The Linux kernel previously calculated the frequency as:
> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> freq = 5405 MHz  // Integer arithmetic.
> 
> With the updated formula:
> freq = (max_perf * nominal_freq) / nominal_perf
> freq = 5408 MHz
> 
> This change ensures more accurate frequency calculations by eliminating
> unnecessary shifts and divisions, thereby improving precision.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Changes in V2:
> 1. Rebase on superm1.git/linux-next branch
> ---
>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..02a851f93fd6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
>  	u32 min_freq, max_freq;
> -	u32 nominal_perf, nominal_freq;
> +	u32 highest_perf, nominal_perf, nominal_freq;
>  	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> -	u32 boost_ratio, lowest_nonlinear_ratio;
> +	u32 lowest_nonlinear_ratio;
>  	struct cppc_perf_caps cppc_perf;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);


The patch looks obviously correct to me. And the suggested method
would work because nominal_freq is larger than the nominal_perf and
thus scaling is really necessary.

Besides, before this patch, there was another obvious issue that we
were computing the boost_ratio when we should have been computing the
ratio of nominal_freq and nominal_perf and then multiplied this with
max_perf without losing precision.

This is just one instance, but it can be generalized so that any 
freq --> perf and perf --> freq can be computed without loss of precision.

We need two things:

1. The mult_factor should be computed as a ratio of nominal_freq and
nominal_perf (and vice versa) as they are always known.

2. Use DIV64_U64_ROUND_UP instead of div64() which rounds up instead of rounding down.

So if we have the shifts defined as follows:

#define PERF_SHIFT   12UL //shift used for freq --> perf conversion
#define FREQ_SHIFT   10UL //shift used for perf --> freq conversion.

And in amd_pstate_init_freq() code, we initialize the two global variables:

u64 freq_mult_factor = DIV64_U64_ROUND_UP(nominal_freq  << FREQ_SHIFT, nominal_perf);
u64 perf_mult_factor = DIV64_U64_ROUND_UP(nominal_perf  << PERF_SHIFT, nominal_freq);

.. and have a couple of helper functions:

/* perf to freq conversion */
static inline unsigned int perf_to_freq(perf)
{
	return (perf * freq_mult_factor) >> FREQ_SHIFT;
}


/* freq to perf conversion */
static inline unsigned int freq_to_perf(freq)
{
	return (freq * perf_mult_factor) >> PERF_SHIFT;
}


> +	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);

Then,
        max_freq = perf_to_freq(highest_perf);
	min_freq = perf_to_freq(lowest_non_linear_perf);


and so on.

This should just work.


>  
>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> -- 

--
Thanks and Regards
gautham.

