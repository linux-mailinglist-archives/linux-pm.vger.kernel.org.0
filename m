Return-Path: <linux-pm+bounces-18985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B331A9EC4C5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EDA168938
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F01C1F08;
	Wed, 11 Dec 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEyfhzQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B11B0F01;
	Wed, 11 Dec 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898616; cv=fail; b=RBo4BJzokg9lwdUjpbaR2nIQrP5HCzF+LrbILh+Q18ey7pw5eJVZw0VAyhtW41JDaP8V8lD9gHYYkV/th9eeeyMeJbEOEZSqpU+/OsqpODoQab0GX+I+sVMmpLjmMBse1wgPyIvqUBE8obuuXqPS7Mlj0d0kL/73d/RwV7q7rac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898616; c=relaxed/simple;
	bh=ALdbzLSvGjGijv5C505uJMbcTnpqAvO/A31/vzCjon4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mHMvuF3s8il5Jpf+cuHeoTZXJFrOOfCPp2qezddA2b1Duw70FTRww4p6bw87n2p6tyqdjMGp8Y6ZGFkAl9QAY0mW40iogmha4f/FwzNmAkBuSDz2tSrWm1DtzBkzRcnvT1NQrTx4DDAWmoK4epa3M2jXaZBktTEKX82q1hv7wwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KEyfhzQa; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX/mbW5ohOFEB0jUiu1x692+jpRrorVmhSqyHz2iyK2LYq1fjryOCX4WcLbn7AnKxfUNxqoNZ3cdrRrjCLBWluBAXH7CBt63JxXMoaikLhZ0ggmiJ8f0BZZr3FaJzTRIRdGgL16jjJirbaLa4CnQlWYjdyfJiyqwuB2mMirDQJwCX63Qoc4hvb0eprdI8udILps6FU1rh9erYLXAH2RCPyex3RoonRWXm1XINBaJOtEHewcaWlErzhBW+yTYGoFwP0GJnQjDzd/aYDjvg90PYRrpfF2j/GqpP1PMw2zEUct6PkOH9921MXL5KibtmMtHnOdRAY6WUATW9uLd6+GuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEex5AhBb67/hEA0CNwXGITDPOLHRSuc3voPeVpHZbY=;
 b=wq2TWResxVvJHk9ccFDhsvSghcY/Z0Ilj5iGTg7SmNYtwnNHFZnM65sFqqxQW4DfJkTF1pPw6cCW1z87gBMMUyFmExtNp/0XXV+4/9KJbehBIXdwciwdttNwo6Oc/VMuafZKQuSezdEi0RsVcz0aCqeKk/Eim0kpGQbGvZSGR//ac1MDxAp/EB3HRNhHDN9qPygns2Z4+f14tfYbN3jHjNx3pOAPXFCWKN+rOfxTVpIfn6GxloJk+3GKFS2g09ltlzbQwQFkO6Bmijd5YmEoX3BpN9142/FbRzOuW6TxZPRhG8nQgkHzlLzva20W2y0jwl5zGSQB4XAC05wem62UZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEex5AhBb67/hEA0CNwXGITDPOLHRSuc3voPeVpHZbY=;
 b=KEyfhzQaqKTJIobapEpRoWxC43+XK7NGuLDj6U8mvOUyGLrpoLU+0Tn+pNk6JUP24M1+wv9u0a51Mg8BHfxywKIO5mPFH7ozv1oIqilEdRBchrm3Dn8zVxC0FL7r5n4SrO+CnD8vDD05MP01X3WubhLhq5pd+VttXokIvSUi/SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 06:30:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 06:30:10 +0000
Date: Wed, 11 Dec 2024 11:59:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Detect preferred core support before
 driver registration
Message-ID: <Z1kxZStQDIexNQ89@BLRRASHENOY1.amd.com>
References: <20241210032557.754-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210032557.754-1-kprateek.nayak@amd.com>
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed62c45-6a54-428e-f234-08dd19ad4325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpZyRWNqs7mAcQkhTvI/YO/AU1DrxxgKQBVTHr73Yzo8qicXIYKIDBEIVzpy?=
 =?us-ascii?Q?PdmXC7ZVASkZa4X9Ac5RN6k0IhDvRzHVEZ/6bubS+dt9f/dpFu1AkHr1ch0p?=
 =?us-ascii?Q?miO6xVy22y7s65/m+CzbRrSSZ4wbc5U83g0cmu7H2SUDH3t4kDz/VILf5s0l?=
 =?us-ascii?Q?eeB12+6EvMDf9yvshXaemdWkBawtTv86ZLH0vAoIbLNkwmsETyDBuFCpoxmV?=
 =?us-ascii?Q?zzbMLlGCcCIvDmGguxtcFc4AoBHhU17ppnrL9kfJQeyRcrzeaw6pwuuGvV84?=
 =?us-ascii?Q?7Sv1x00yP5gB8WN39R/0B0pHvQzwRq8WgGoz0Dhfdn0JZh6a2rfyPF3kw2v6?=
 =?us-ascii?Q?ymr2OSWe3kECVYsCkZa87DUTxq6HnmoiXVq6nLWLkFcMqC4A2Jhl2X6XMVBI?=
 =?us-ascii?Q?iBtT87qy+is8ZqqJ6pxNHE2mUiwL7qFlRsWPJA3QXF32DrvBgNKnyMufwKil?=
 =?us-ascii?Q?lLOjP53fnzcynrTfyEmzGlIbOPcQyxmvhLfWiU5O0hJuiHUj/E41fEWJgQJc?=
 =?us-ascii?Q?JjOCCcxD11tllmWGZ44U0VDW3sDMICM9kJtjLK50n8U4k1gWBO3Y29tHRlFC?=
 =?us-ascii?Q?AltFnRUATOzWft+/0bTQa1JHxmE0nN1jFdQNJj4QKr3QTp/H+w9tXx870TMn?=
 =?us-ascii?Q?boIR6nQK/ZU4KSibvwNiKAGuJ9qo6A6r4nF4QQi4pa+ux0DUgW/RdfALHOg7?=
 =?us-ascii?Q?WdWIGcEGkPhcV8kZ/w5v8cJup3QRq7XMGr1jow/wSPr8F7IJmMy5C1Z0zo/f?=
 =?us-ascii?Q?SkvwYzePyP5sklWG8rBhzd3Duxxi2lLokQ7dta72SxeX3Ti7DgNYovgQ1bPa?=
 =?us-ascii?Q?RqeT5GN3gL9ydAateclGW2GJoE/qIuEywgV7uqp/VnNI0hrxMEzTsylaTmKQ?=
 =?us-ascii?Q?TUed7R55A4nndeAfxNSu1YushF99qJMfpXR4Vgq5VhEUGdJQ3nK2xFoFMvuX?=
 =?us-ascii?Q?zkqquO3iyQXMNjQON4wYk61Rzvi0IIJ7sfdq3Vvkg04pH7Ft3EQaeF+JgT49?=
 =?us-ascii?Q?ap9lpUXQhk2U8VP0M5o9w6M4e2d4KVXwI8Emwsj73WU8BMRInQpeWJCpJjRZ?=
 =?us-ascii?Q?eYy6T6zKMsbHgzHbs0jmuJwtK+ZPN8W0HAkGJ4xCKRM5eBL/KHDPdkVuzVIY?=
 =?us-ascii?Q?qcXT4l+svlfNGdfhxzdoY8xfVxi01sM5MzpPJy6KvnbUPc+9Ul0yxh5UnsU/?=
 =?us-ascii?Q?di0HDA7CkOMPJFfhaM7rfo0sOexFHyT8j6VlpPXAkeTU31OacumKEcKCLoUU?=
 =?us-ascii?Q?YGiOrJvl4JGSvewJCDcesiw1l8iPt5sgJoi9sTIwyXyMFQSpJek+VIOZ8hbV?=
 =?us-ascii?Q?xm8kvugVPhvxIquG30lS0t3rjdAFhQV0C0SUb45Mn16p2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xNYwsFC8YuBloGuWo3wWJ6A7i79jNI7JrB7PLOF67ErZCviN8FmLbW6wW7f/?=
 =?us-ascii?Q?yV7x9lRwBtwm2QpFgomIB7vjkQzG6DOiysQYuD/IDkalU8/JL7ylWejMpZWd?=
 =?us-ascii?Q?lQi7foKIqALQkUC6SGMOO7zV8mc34cqtAnkzd3WPUzR0rWDPVtl2loxB323Y?=
 =?us-ascii?Q?b7/mUHatK5ARGDTepNrBdP6oZCvU1pgVkf6eGxY5dO5dIVsIBHN41le3lcpv?=
 =?us-ascii?Q?Ukd9oHTEcR7p5Ko6fiv8Em44VuzZscefDWJUmf+HBZWmlXT/xvL64LAg0r+r?=
 =?us-ascii?Q?rqRthQ4G+AU8sEDo8GiU4sTPUBCfwiAWN0j7eTba1yN3CbhevUUOMXfdbd8v?=
 =?us-ascii?Q?iL6EWy7USktXvuSSPWAODZEmGutYK+0rR7kXMJmiReFAt3vVsLHTRINCLZYs?=
 =?us-ascii?Q?PdWSWrqTDZcZv+NKa05NJf+MaUdIEFEREUX+8BOBxwkvkguFongCfGDCwd2n?=
 =?us-ascii?Q?AQj9DsVclO0FZA4kLBsivt47eYp1VBK7zoKeWnZhfIWJ9beG7LdJo6A7QKl1?=
 =?us-ascii?Q?mP7l6uYZRqBIsqzVK387Ei02tuBjxrla/p84SG7euVPctqRCNLlzZwIPsMDS?=
 =?us-ascii?Q?SehLXMLqry6OB16BdRL4M+EnNZZ5KeFKXVuBHildWblIPArcOIyFXj1lt8Ew?=
 =?us-ascii?Q?lZPiUe7rU1bL9zpZuPADYG3oWXATwWguRojmp5nY1yBwmJi1q29iGfgJdM+o?=
 =?us-ascii?Q?t2A2nZ18k5cwmj7Rc/h71dP6Oz0RnMAzvxgspGSuJyoGqA8opxgs5pzlGlLr?=
 =?us-ascii?Q?RQeXYKvZEa6wmCEpXN+Zdpv68heP4jhRyJexYnftvHu02Rt+HAkkHfEo2XGq?=
 =?us-ascii?Q?WE3V6YUwRcmJgocfRkuSo3QRtrzu1l9jR2CqqxqTtIdm5VRLUiHkrwni14si?=
 =?us-ascii?Q?c1EcncTtjuDEbUtVWDP4CiycdTPeH3qjhtEssWB+/Ux4bhM7hWGgfZNxj9Y/?=
 =?us-ascii?Q?tla+tBGQBZtYOCEl8kaWSjTOuZcGHT3ZgZ3k94rDvawxih6zspRdxvP/9+HH?=
 =?us-ascii?Q?khRL+JrY8aPfo1JMrE6eBfym+9RpBXIGYtCXSLO7Q4/vPngO9EW4Dzv6XYDa?=
 =?us-ascii?Q?BdZ+Rq3B8srjupaSCt0yZvoec3gRBsPqZMUxwHh2ofgKeKDzjqTJcGYZlLlm?=
 =?us-ascii?Q?GS6iKxaj5pkB/vGCZU7t+LTt25ckv9IYuaYXerKPcn4LGu1lACMgQnTNhlj+?=
 =?us-ascii?Q?ZglmvP2GzHg6bNSEiL6f57qcQi7ahn2HgQUIyZedcTAH/uL62RvRH8TwDkQR?=
 =?us-ascii?Q?o6eN2ClUrFlLaluBKdjIOiWsjoe2OxTdXuFaBeDwGTKHkZrlHvzk9psBbrY/?=
 =?us-ascii?Q?dxr3Ul9Jg6RSbGXUtIAP/KE1kMFLRqSzEfH74K2mcYhI4B8cIlauT6W0eol1?=
 =?us-ascii?Q?U7FD/AfkX5gVwORno7Rkmjd+N62/VhTDm+A8vTbJkWvLmT0gDuxAVG0atuie?=
 =?us-ascii?Q?x6sGyFpdQNGahf0UFCi3M9L5CTHyT/dq/cORT1zA1dHPG6q4WD6l4nqPrUOB?=
 =?us-ascii?Q?hpg4NbEYfk0CPqxqRP2i2/xEDPpaqtTdhSKA0q0xTI2WQl/eC+FqH3FBV6mV?=
 =?us-ascii?Q?B0h5jt4Qf1+wfMY0sPwykNPUYGClMtaZhclLanfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed62c45-6a54-428e-f234-08dd19ad4325
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:30:10.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/TwzZI+bBVq9y5ajfENn+Eacc3PewGT9UI9FOAKCzLQo/PCfRbLZEUc7AyCFmZZwGw7RdQLPbnPGhW/Uq5g+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686

On Tue, Dec 10, 2024 at 03:25:57AM +0000, K Prateek Nayak wrote:
> Booting with amd-pstate on 3rd Generation EPYC system incorrectly
> enabled ITMT support despite the system not supporting Preferred Core
> ranking. amd_pstate_init_prefcore() called during amd_pstate*_cpu_init()
> requires "amd_pstate_prefcore" to be set correctly however the preferred
> core support is detected only after driver registration which is too
> late.
> 
> Swap the function calls around to detect preferred core support before
> registring the driver via amd_pstate_register_driver(). This ensures
> amd_pstate*_cpu_init() sees the correct value of "amd_pstate_prefcore"
> considering the platform support.
> 
> Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
> Fixes: ff2653ded4d9 ("cpufreq/amd-pstate: Move registration after static function call update")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks for this fix.

So, the test for this is to check the `sched_domain` flags for
SD_ASYM_PACKING on EPYC, right?

We should add this to our test harness to catch any regressions in the future.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


--
Thanks and Regards
gautham.



> ---
> This patch is based on the latest superm1/linux:bleeding-edge and was
> also tested on v6.13-rc2 upstream release. Following is the behavior on
> a 3rd Generation EPYC system with and without this fix:
> 
> o v6.13-rc2
> 
>     # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>     amd-pstate
> 
>     # cat /proc/sys/kernel/sched_itmt_enabled
>     1
> 
>     # echo Y > /sys/kernel/debug/sched/verbose
>     # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
>     ...
> 
> o v6.13-rc2 + this patch
> 
>     # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>     amd-pstate
> 
>     # cat /proc/sys/kernel/sched_itmt_enabled
>     cat: /proc/sys/kernel/sched_itmt_enabled: No such file or directory
> 
>     root@yamuna:/home/amd# echo Y > /sys/kernel/debug/sched/verbose
>     root@yamuna:/home/amd# cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
>     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
>     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
>     ...
> 
> System was booted with "amd_pstate=passive" cmdline.
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 66fb7aee95d2..cb03f7d6575c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1862,18 +1862,18 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_set_epp, shmem_set_epp);
>  	}
>  
> -	ret = amd_pstate_register_driver(cppc_state);
> -	if (ret) {
> -		pr_err("failed to register with return %d\n", ret);
> -		return ret;
> -	}
> -
>  	if (amd_pstate_prefcore) {
>  		ret = amd_detect_prefcore(&amd_pstate_prefcore);
>  		if (ret)
>  			return ret;
>  	}
>  
> +	ret = amd_pstate_register_driver(cppc_state);
> +	if (ret) {
> +		pr_err("failed to register with return %d\n", ret);
> +		return ret;
> +	}
> +
>  	dev_root = bus_get_dev_root(&cpu_subsys);
>  	if (dev_root) {
>  		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
> 
> base-commit: 1f2f221668b210107f1277901bb757f1d77de842
> -- 
> 2.34.1
> 

