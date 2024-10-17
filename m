Return-Path: <linux-pm+bounces-15830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA19A1A06
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E631F25086
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 04:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C54174EFA;
	Thu, 17 Oct 2024 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sIJYH8A4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832679FD;
	Thu, 17 Oct 2024 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140503; cv=fail; b=I0S45LA5hpZYhnec95X4Sir4PEho3AXtPJER/+qrtZeKDjsEAtd6a/KZKbFk0+z3WqTk8QHPHBS9n9j+UUKv1jf3YATkYFTse9grXrDE+gv3seUPoSH6XuAtrEEgbbS7POa2fwkOJ6tNIomcNPs5xSqXdFzCtigls+30UocPFXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140503; c=relaxed/simple;
	bh=f4HQc2NPju8uMrg9l2NVpyr+xT8HeWzsrAQmnEVDq5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfKOkOae70IihWULC/wlEoqUx5zdYF/heDcyExIDHMdFivL41I8wrXlP2C19l7FZsMl/6xX/0JrF/TMtfo6FK/9wbgk+ZFYNeIYk9ZfPbt3+0Qu/cmMIZp5eXu5B0LLNC8h96uOdQQge1n0/sKrXDSGXT1hfIwyxhPkGIOHeaas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sIJYH8A4; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDj2Eh74LGETQ3ZUeaOxyRAagM4aX8BpaayDVKl0+WHkkIKCEeHE3QYnozgkmPh7bSn+0zLF2fALD9FAlfq7Bl3jyn/khDib4cvaAEPv0fYqBJBgRWERTt49K5WwUSuHCE2U8X2SNTUV3/H5oQ6Lw4SbtxOvqqbdCU/wzFPh6DSNBTv1LQWOzyQhdGrKZ0bGwgqTo5uvX2l2FfjI5VJd/gfo0aDu6kumCZQrr4CShHs0eYmf2UcZH2auThg4mE3DhQHuIMLd1T7ixgJ1l6jY458hlNkP8/dMv29kGnADuAKzLlnzfKeFrs8IkmXgyQWel9ee6Gbre2nyu9wyRcGBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05YzKui+5sgORSNvhSS4GanAfcUobAGVJc0qk1Gnkss=;
 b=wmsGA/9qf4nfd6C8q5YUc5jGu7qmnkEd1vjeAQBDoS0eVbt/vPupMUYR/We7IDz2aYM+KnEO0LeKZyWvv1LibYhjaq1mi5sHWP8B6sIfg0lyGh78Fey+r/swB0m/I+cQKxKeFw2L7p8JFxO5Zc1DegMFLWIF7/jritgyt2JqQKJuKzoCtCH+1vYaYi3OrrvXpl44neJjicDaWzFYFQOLzSa+EGpJo+X5mFVKT4rJ3pICQ1WGs0lUolTgEW2rDKKyK7a1FkRE/p9R77ok0Ior/4e3f2UVk5vk6HCN1E7B9vWdp8QD4CqiSj07CsC+JaFSrHcVstA58CKvP8DxcEJJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05YzKui+5sgORSNvhSS4GanAfcUobAGVJc0qk1Gnkss=;
 b=sIJYH8A4/3qsnXaGO3iYyJhfWaDHh9P0sXFsDXvHUhPk6nqlFsFTDN0nOB/kDqPepLDAYL9sb+K+N/ClIspsxhbuAdua8bawEK/kIy9LZ7PUKzBUAwKOaYcoz8BPSGDpF4dtb51Ilvtcz0sdoYwL2g/ywkq3aYfYhwI95pYcEmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 04:48:16 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 04:48:16 +0000
Date: Thu, 17 Oct 2024 10:18:07 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 04/14] x86/msr-index: define AMD heterogeneous CPU
 related MSR
Message-ID: <ZxCXB3GS0J5Q32V3@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-5-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ff2103-000d-4124-8bce-08dcee66ea2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YF591e4T3HkVM90optZjLqD/YKHuIWml7LaECOzYXaYMkqLBLNKmESZDg5o8?=
 =?us-ascii?Q?YegDFZ5kRq9Qwumtt+ywyd5mQg2hZP07VMbTV05TgHa7xsqbz5TQmADAZnAE?=
 =?us-ascii?Q?Aq4ydwRKbnJ0MXtihk8R2dG4oqzops30DOaxCdtp3fEGarThQYZwgUSvvtaU?=
 =?us-ascii?Q?LHMbCWZLR80aLlPy9aixfJ4n+maKuIelWaCIjbAMBnq8uzzq0p6w/LU1ci4H?=
 =?us-ascii?Q?xt0DOP0XggDOqkf9tAk92yN81jPvM1hmcVGbrS6+JSxLPlvmcFvJBKm1/u3n?=
 =?us-ascii?Q?AceUd/k1J9DkYIYXfmI/INrGVxTNCQVVOjGUgM6182FZNUkqK08v0lm9o5qT?=
 =?us-ascii?Q?VXeDbabIHwh+MR4tb0Wu69AqmhroRsgq22SbDELaZORm3pa8Qjd1GyzQtkwF?=
 =?us-ascii?Q?LdxSQpoPN3kjPTto93aWuvRqx/I7Qrfno4E+TXrPwuAu9MEyW2o3ozSf/5AX?=
 =?us-ascii?Q?M540x1AXIh+Tft92yNryj+720VpocC5vxcZRxQk6Cka2x6gaE8oyiJL+OCKf?=
 =?us-ascii?Q?p15iYb73iUEyR1Z2cXTlho7w8LfthKVs28HiktEQDPmdp6rU4lyF3vef9Ime?=
 =?us-ascii?Q?MvsSyeOYfr6Q2cwrEWCnQkHeEPFNF9j8iQ5VBA7qePzpLkWlV05uuPKcAYgy?=
 =?us-ascii?Q?qo1PEeYXO7aLd+tpEgQTNlquKZxMtVefxrg9r1YaadIDyoopaK38XGfhl1Kk?=
 =?us-ascii?Q?mEmSxpU7j5OEWVE/bdApUMjkbKD9JW7kuIDH4fH9r6UXcmivYKwQ69iX/hC7?=
 =?us-ascii?Q?M2rzM3Jhjpa4mQwvfF+mgOZc5Rq0l1NK5CIryk3dwn8PbKgJfyj1vuEkjAco?=
 =?us-ascii?Q?Fn6Gd8JPQPOoPP/HvbS0AyuKa7KQ7B8rtGhhpxR0AiC3cPsjzZSomXbM/GJP?=
 =?us-ascii?Q?7dlyUjZBZ9YOiMnk/Wq3+IHgNQBNtuRmpxqwR3NU/EMuek0Lsr4bfdmA2jnD?=
 =?us-ascii?Q?rJdiQnLuGmPz/vzagqCcyU2ABoWZaZ24aAXNlSub+l0xApUHi0DJYC9kkIIP?=
 =?us-ascii?Q?zogzQkvaVrs0vf0nIx2EEnok+oC5x/bzpcjyMIlbkR753PGQIlibpYTTo5rL?=
 =?us-ascii?Q?YdGopCzCes+L2Kd/ek5nfKXBcr1oD54QeQPJnBLeScnEv9aSfD5OBfJbuCw5?=
 =?us-ascii?Q?uHpfxxZA/OA4LpK/9A4YP7TLvvr0xlCXnpfJlch/rfOJSpkJ9YAKRK+y2Opr?=
 =?us-ascii?Q?Z9jbnx4ptr406bXHgBD/gUoPftWspGC93IiVegMeQaO/UAw9NsLG3A79PrY/?=
 =?us-ascii?Q?L/4YxKEp1IO5eXI45Wu9gaSgkAUeN0AiNRj28mbEz7bnfvlhkEagSR6xvk6d?=
 =?us-ascii?Q?2Jm8sAi5QMdOte+eZgjBmG+/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYyf1gcb1q4kiqcGaDekaP3HTyEzTT7/hHhg3yQSdaGnW3BJGMoQN7jQZALQ?=
 =?us-ascii?Q?0NaRetLECV2qLeX1v6eAaV7YA68g2DEDMgU4ykXVlx+dk2DRdWaHDMbk+E3R?=
 =?us-ascii?Q?lIIQZTHS6FvUpy7ZjSTK4tRrm5FWUbHMLr/jA+RT0w2sGyw8Dmii5kPzvs5Y?=
 =?us-ascii?Q?8ef6qH3XDglFIkEvop13f+9Av0684pT9f7nF7/Yt3y1iRJ9I3zJ9ltqb+mVS?=
 =?us-ascii?Q?dMmy9GGXaK3pbDa2SPFfjC4H1/maLooqnk3N9P0YkcD503CTDnVPaAhPAhoL?=
 =?us-ascii?Q?LyDO/LmYPxvy6pGoINAc4aSrfWotZGj3YhPF2YWsv/hoEs5ArdpdW0gnpAkE?=
 =?us-ascii?Q?bNnwQpXIfCy90Xmf4V1VeUvRLhoh3HN7fdEPNzt+ClXXCMD2kubccAyxQ1cQ?=
 =?us-ascii?Q?4XABqMv38P28O17t3DJEQyQMx9ZJ75Qn0TClMi2jLMSF3CJYcq69KmB6aM2K?=
 =?us-ascii?Q?M1Hrh6bf2DRI51U4WeA1gF234DvNupJQLLkv14mEkawH10YOAksGgl9s7S4V?=
 =?us-ascii?Q?21ox71ikOV461lpSuESMjx3wTq336y40MM1c7V2kcBKf09fb32xFwC+i5APN?=
 =?us-ascii?Q?D05YnEdV3jpvfHJKMwzEIob3nm8hGG+m2v3x7qzt8j6z9SEJUxxwbmVVzhLz?=
 =?us-ascii?Q?YqNU9Jy+viXTT0X5diIWZdA3+P2i+fpBtCiArAnfvWi8N4Hv1DLhUTN1dL4K?=
 =?us-ascii?Q?UF6P0XNX94q1BG9xPSASSGnkRDz4Lqyxf3AEnFyx6Az9rp2lwpvIMg1xb6No?=
 =?us-ascii?Q?fvbAIRUAU2B8QfGDDOWB0HWpf0rZcWBfIrA3ZRdCnV1gQgDU1HUgeYsd1n1l?=
 =?us-ascii?Q?WGJmNGtb5SYEpAPNh8yRP5HTLsB4qvhaR8E++8L/KpIZ8VZVl6VE9Zhf9Kcq?=
 =?us-ascii?Q?i2lpp844ev+4XZMK8y8wNNkHLmxXBDH9icE3LLFL874+C7eaR7Auf9VhgUJg?=
 =?us-ascii?Q?EhCo4xYn6gpS7gU6izeNSnHdopGJSZ/rJDurb6ibsAZBAaJsXVunKrqSomMW?=
 =?us-ascii?Q?pe5Cq+hpeLkrfi6fX4FBHbx6Leu2RNNBiQsiIoEk9iS1uj3y6yGZg0Jqd6si?=
 =?us-ascii?Q?22JeR3xY4nA9E8k8jdEqChvrm0yj9+Ivd7BhN6AWBhMxP8RPPifkOmxsWexL?=
 =?us-ascii?Q?0nzTKmluQuUFlB7LBy8gpeZy16BZV6v+cxaom6lYprCvr3EsuOsdLhikTlRx?=
 =?us-ascii?Q?fb6jB49P4Uos2ejlPfVruB4YjOKm071qw2QwrnfidFcoggssnxmJcfO9sHGF?=
 =?us-ascii?Q?xj/lscCmeJGVNC1mW111HiwR4rveKMEcEngQIHXjsKs+GDtHzWzV1BqXiDA2?=
 =?us-ascii?Q?16e/xyE8Tbyh2Zpr5DU4k8fFixHbg75DSUBR3CGo1r3BpVWGWvBGZ2gY24LG?=
 =?us-ascii?Q?h1ZxvVcpj6epQ9+aJd4hUILfuyae2oc6oxgNTHRBQOVuXG9s8S5DFh6ujeMc?=
 =?us-ascii?Q?+ZLzZovAYy2RTgL4oq6S+URzK/QYlOgHu/IF3rLWZK05c4QuxywMU//hW/UT?=
 =?us-ascii?Q?gmSfH5rYDYHem7oF+OSPLoowj009SUgC2TPcGbjRsRsD6bq3xqrQxfjwqJnY?=
 =?us-ascii?Q?xHjEIYTJs8XSKkDD6vmKJhcIPgDr8OfzStGnB0QR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ff2103-000d-4124-8bce-08dcee66ea2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 04:48:16.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Tu9YlxYyDIBmCci7jlM0uVjF2Da3l56FPm2Gcavg2Dd2++ckkvmOuhIkgFmFPVhgrI0ZamSxXhJ+DB5qMFJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

On Tue, Oct 15, 2024 at 04:36:35PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Introduces new MSR registers for AMD hardware feedback support.
> These registers enable the system to provide workload classification
> and configuration capabilities.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  arch/x86/include/asm/msr-index.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3ae84c3b8e6d..0cd5ffe50f4a 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -712,6 +712,11 @@
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
>  
> +/* AMD Hardware Feedback Support MSRs */
> +#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
> +#define AMD_WORKLOAD_CLASS_ID          0xc0000501
> +#define AMD_WORKLOAD_HRST              0xc0000502
> +
>  /* AMD Last Branch Record MSRs */
>  #define MSR_AMD64_LBR_SELECT			0xc000010e
>  
> -- 
> 2.43.0
> 

