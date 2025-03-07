Return-Path: <linux-pm+bounces-23642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F026A56D7C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A33AA364
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E323AE96;
	Fri,  7 Mar 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uL8kXjXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269423A9BE;
	Fri,  7 Mar 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364564; cv=fail; b=RAAuX3VV9er7nNbUJTF1zTSzZ0hy/lVaumSHdzAyVQbsAjN2XQMBz/euvc1ui//MB5EW4CMG1yymO0YCF83jFm8o3mn2ox+PYyKe5msQLapMGQOW3HYm0Cbd6R+n7MMdKN9hZg1SS2z0GgipTFdW2BD0oHa2HGdeCQle2RTBjLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364564; c=relaxed/simple;
	bh=5Ini1ymuF9ZuVeQXHZjevq3tbxqsglPOm4YFyDnjrVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXhAWyr4J0NWY8aYA/yvMqr3Xoa7j2Tkro3OwUza9VgvAtkxbZN/BN1kKl/uqAT9cAv1yJygrl47G+Ef4d7Qw63mK4D0WLb49Ie2W+zZgJ9etf4EXCYlWIFJEouBjOourxen/TewYwB7XxquuE7mHTENbUbOhpIA3ufT6nHzHH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uL8kXjXx; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpL2xXwUde+x0KY4v8VVuSAG/+WM4LIyl3riQTlvu9ozIi13zlN4vIYHkq1PooWY3g92/ROJIQqJ6ZDdvonEE/GA3BDtXh28/cVFrpmmW2kSLa0w0Up/9gUbpjFPYl9zj5HX9PZODFrmxp6zb3Px8xHA31aHNBvsFlFS8NDZxGtv47qZP3CzoTTJXhfCk9ACw1SFOFHKut90eu4o1FwRUjC3aYEN0NU4VdZWnB/dClURB9Fq1bk/qkg9pA6ICepdFNo+WBlXNUfemCaqoXTmFgfu+6EiAhXuqOatzwtos91kRsb4bGJyoieleq+LiQ0lQKfwfq8pHQFw8we/QL54+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI6zhqI1XuDiYCgstXDMZnuGyObrlTLv3Q/NLVCtG8Y=;
 b=rlCtRPz0PYom41xrxXbBVcIu6tTultJz5bOQFRTDI0BBH+T3JjAtB7g9nVm5gIkkRKUDsdAr8LrOMWvND4ZsXIMqMa15DZexOA5SrOpk3R1V71am6RwMRWQ2Uz/UlXNjgg3msX+tFJGYllmUjIINviW4y1on2fp9k1UmK+MTZ2/HJ9hOmEGgKejQrQ0gLy332lMEV1tfcdRqaP6xvVbJ+47Z246FEjGqkOB63kPoZst2wLCFFZPgb7yfSrxe2mVReUvAeemjsxABkPR09/aVJx6ESJcqL/CJ322HbEcYMsJZLCZXIWkHZVVRM3sPF16dYxrl4MThKLC3CbZOyKjNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI6zhqI1XuDiYCgstXDMZnuGyObrlTLv3Q/NLVCtG8Y=;
 b=uL8kXjXx6tbMEKeLcuSW9Ny+ExDm27RsX7IZ3i0bmHZhO9J9EK6lwTyOnchYPyq2vWpB7lt91eOyRacMSJiDaK4Fp1r8dVBBW7rgMHUNU51fGkZOnuYObmfKhb0ZcWReU46r5O2bpEbvmzCW6ePDgp5WmQNbMrid61kvVDkJMMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 16:22:40 +0000
Received: from IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::981b:541e:5b8d:a019]) by IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::981b:541e:5b8d:a019%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:22:39 +0000
Date: Fri, 7 Mar 2025 21:52:28 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
Message-ID: <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304152327.1561017-4-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To IA1PR12MB8240.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8240:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 451a47fb-2e97-4b4e-c670-08dd5d9447a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eoi4ydGosp93wN1LF70NG8WJFXcf+CpbZN2S4MarxQcNOaoxQSjApItn1zhI?=
 =?us-ascii?Q?I1Cij65C/reQPgcoXivpdUD4TX/B2mukNbIj7oDCZZR9m/hzJ9dej5NSraC8?=
 =?us-ascii?Q?Hpe/JPtNVoceb6bOmDaIBZWNAA7Bfcgs2jQD8rwBte1/Loh3r9Xwgv440r18?=
 =?us-ascii?Q?mKOZ0t2UmYhKcn6ZxMuR7iMfketVmqwvc8TXeKhteJ1CdWD6GcF7piftM7yq?=
 =?us-ascii?Q?T8Y3uxhBPZOaZsIjf0HySefA/qOS2alUErZEVN8+oKuuzOR/Zhe2i7U1CSAm?=
 =?us-ascii?Q?bV874dKtWi+aFt8wsHJt0LoLPbMp2pJ2nz5zUeIecQjtsCNZhY3CUS70Gode?=
 =?us-ascii?Q?kKNV90oAcOCkwB/2NrwEjz19Ruir4qt3Pp7NDQFj8QwKdMtC+o3RbVJ3KL3P?=
 =?us-ascii?Q?Fr7oTWQxsQ9QY8LkJ8IFE0FMkaos51AnPXXLChuc4EVSGVVLOR2zr1OrtIBL?=
 =?us-ascii?Q?c0Z+caq5U3jMt1y0OWkNhQfIYJgmkQr+V1dVudIrpFqUBf9SlA95u3SJ0+Em?=
 =?us-ascii?Q?+vzLig2o2u+KneT1MGnfwIkh+/L50LaUB8TjIFoz+w/FrQxwOwi67txBAW47?=
 =?us-ascii?Q?Td4ysAFKImPMpKzqwU6Tlpl5uHRrur2x9dgE8AHr6ZsWNYKt2xcrH0SDYxLG?=
 =?us-ascii?Q?HFanBqd4GfOPY+cxiAIhBJY0+vS1YioOSSGQpR+w7wNiOwlGvLK+qL7XwW5t?=
 =?us-ascii?Q?8fbNVxa09W5FsLb9Q3w3N3pXk5wHT7VeNIxPFlCs3ArI6L/MB7fiDN1d+g5y?=
 =?us-ascii?Q?XuDvuJE6NgTV4hIhwu/Zi/+UqRsdOg+Fc48sOFcVXLPb4Nvgr4TELMh4kGth?=
 =?us-ascii?Q?tJKmq9BoGHrK4yYD/+duE/N2w1YaH/gQbuJyOw+7jraVfYnkKUiFn5iWDcgw?=
 =?us-ascii?Q?ehM1qgOX0/HjPoff7B6NIK6eghZKFxbAKZJ+Rcd5xHv+OcPQWWosHsfmHYD0?=
 =?us-ascii?Q?ukwADChraVlUrPG9R8mzvcUsxSIyip/pvMSFSdcQM2wo091/igpoyFP248P2?=
 =?us-ascii?Q?X9BYBMs1FpD1TTjkA+WAhCSiZ2Ngdv61skmw5AycEFCNEajDDrgsKWHLWMFV?=
 =?us-ascii?Q?g2a78N/Z0rlhzn6h5dGsfkI40LnFUoQyMB9kKilgZIL2xDF+yVlbdO1/h8GZ?=
 =?us-ascii?Q?LC6T/JVE0NA8D1GdDe55PwJQsr27VJ2V19yG4MHkGVXB41k9Rrcx5vE6AtOn?=
 =?us-ascii?Q?WZCcrPaT180CRcV6yvENCbpGO9E1Bdv2T2dFWl1TVRiPF98DyYO5+jR7xr43?=
 =?us-ascii?Q?lgNHmqkVn1wvYz9ia0HShVZTNgMlGGyDb4LOBDteMJT+amzket5SxFbjDMGc?=
 =?us-ascii?Q?n+7Ejklp1yzDWHl77y5jbdl+P2Dzv9QXG18ym/tN4RfXXmlHxwJSl/OacgX6?=
 =?us-ascii?Q?F7jw9sHg++H14Jvd3cUBdpwdUVZZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8240.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWNIBg8Rc/X1N/693heeYag3q/eGfX017Sd/Sx6VEhkvRRRcGu11BF+SmZZQ?=
 =?us-ascii?Q?PZrJTzzmKOgLYMq5I7gi0YPMVdFiySnLeEZFlwVdvc5y5HumeMHGD7WAw7LY?=
 =?us-ascii?Q?kM8COafr6FhPh3fwwfT11o0w52IkfYJSqjUUVD7+n0pLM/KgMqynwy/Mlpy+?=
 =?us-ascii?Q?GaKcZpSrBcX5FtJ3hgFhVjgsoJBb+dCyf68u+g+W+fYGvLkEYp8zNfrxIT4U?=
 =?us-ascii?Q?lobPWt5zzLThRCpwZNXuLzRAjQkg/dZWtnH1KF5c2kY34h2u+fv3jcV04U+Q?=
 =?us-ascii?Q?zvMGFEcE6ZASoSXNftf45YkXJtEO78neIedWbzJrepIlk180bs1rDytmPvjA?=
 =?us-ascii?Q?G3RTf/rKN1YjIF+XSOMrzI2A/Bnjk/JkB+HYsmDCqZMyhBn90AsgpfJPNBDt?=
 =?us-ascii?Q?RDPIus4TXHSXs/MWav6faOE4zdo7n5PqmsG80sjnWYvKRHu45A2h4fwI/FS4?=
 =?us-ascii?Q?uZR4VPV0AxxiNhEVfqD3TtUet0stwjuAhJ9PDaLUl5ibfOudHhZFT0ttrgaQ?=
 =?us-ascii?Q?OVGRmifIfV0odY6aoalQNgbSwkHSsW+bT07jYskwJOZNZ/tFjJ1ONFk+sB4W?=
 =?us-ascii?Q?RBmqWhp8BvzR+Oesjrwm77dXBewUSsfmFOvRbfNhzbja2MNnMWUJ6J1RpOpm?=
 =?us-ascii?Q?HQC58/vU3gIVpIvctGq02JbB6VjknGbIPMKXod4xR60mJ3Hw37pG4HvOjVh1?=
 =?us-ascii?Q?OkPyZZhfGSn3Nf4bI4irD1Mjo5LnAP+v4zddQTXIoCIGfgOWIB6FpNq2Mc2c?=
 =?us-ascii?Q?aA5ZhAU/grXgB2jNoiiSpzGwmljti0bDFJID70LxhZShk8CA2YWNw4p9NBoX?=
 =?us-ascii?Q?XjgLnVBrs6A2lEP1G/iwnTkj3p/qM1kd4gcqYwCtGoOm12Zzi6d3IkvzEnF3?=
 =?us-ascii?Q?Z13G92w4aK6XexulKRR5ZJIyYEk6l+mhmLipd4/y8TcLj1ts/xO8JV4iljJc?=
 =?us-ascii?Q?CJNO0vj3FVtQ0dFC5GJu6m9D0RzdLxJ9uSbyEco6p6V6LJiIEZmxdt073yND?=
 =?us-ascii?Q?SIXDGtd3OZMAKdr1r/e9iITt2PVgsz7T8ex7oBKGzCyzwjHQbkw0AE6+x40J?=
 =?us-ascii?Q?mLn7w7C5b95WNt2HiUaQ8KFrUf3deNLDnKgIvHA5IDnuuulCcV07iikNdVD+?=
 =?us-ascii?Q?omZpJWJK9xhkPimEwm4g7iZPKNKCtZlnt9l/Qqi79VCT6hERW2yWkUwt9Fx7?=
 =?us-ascii?Q?wWt6UKj0e8DXzfmmkH2JuX7IZquMIeRJ6cdnFWQfqjZCsN5+deDDizDlZoj8?=
 =?us-ascii?Q?UAkemWNaALC6tGIDlVz5FhmrLJYj3JY0V8anDbaf76trDD/o6dw5P/pGqkIY?=
 =?us-ascii?Q?bPQqPuGKeqT3SdKj7OhZjO+X7dQZy9tPqx4R4CqtWCWuBjJh0DrzLoSccx0R?=
 =?us-ascii?Q?Ss79NAc7Bv0qthaYZUGGtYOTZ1WUNdoCryc2i4wjwgLnHCs2JUFc2LpATq9r?=
 =?us-ascii?Q?+RZ33hjwToHtnrW5af+sZ6nf2B+YygVhTVQu0qzXnhq2idTunwQubmQTAOnk?=
 =?us-ascii?Q?aBRr/bHe97CVpYBr4VpEGkqK/0pOMV7ZbkSw+bHJzN8dZEyzrXWTWgnXFerU?=
 =?us-ascii?Q?1UhHaa/nJEJeko9ftz9M5KzApuz1JLCe8p4+b7Ys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451a47fb-2e97-4b4e-c670-08dd5d9447a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:22:39.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyeQbI2AReAzQ2t/3wIGcqcW5xpplsvWloAcDM6UFAr/T0MYTlsUbXewzeuqP9yVAN2ighFS8x0GJBEDcmhvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

On Tue, Mar 04, 2025 at 09:23:25AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The platform profile core allows multiple drivers and devices to
> register platform profile support.
> 
> When the legacy platform profile interface is used all drivers will
> adjust the platform profile as well.
> 
> Add support for registering every CPU with the platform profile handler
> when dynamic EPP is enabled.
> 
> The end result will be that changing the platform profile will modify
> EPP accordingly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>  drivers/cpufreq/Kconfig.x86                 |   1 +
>  drivers/cpufreq/amd-pstate.c                | 142 +++++++++++++++++---
>  drivers/cpufreq/amd-pstate.h                |  10 ++
>  4 files changed, 140 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8424e7119dd7e..36950fb6568c0 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -321,7 +321,9 @@ Whether this behavior is enabled by default with the kernel config option
>  at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
>  
>  When set to enabled, the driver will select a different energy performance
> -profile when the machine is running on battery or AC power.
> +profile when the machine is running on battery or AC power. The driver will
> +also register with the platform profile handler to receive notifications of
> +user desired power state and react to those.
>  When set to disabled, the driver will not change the energy performance profile
>  based on the power source and will not react to user desired power state.
>  
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index c5ef92634ddf4..905eab998b836 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -40,6 +40,7 @@ config X86_AMD_PSTATE
>  	select ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB if X86_64
>  	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	  This driver adds a CPUFreq driver which utilizes a fine grain
>  	  processor performance frequency control range instead of legacy
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9911808fe0bcf..28c02edf6e40b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -105,6 +105,7 @@ static struct quirk_entry *quirks;
>   *	2		balance_performance
>   *	3		balance_power
>   *	4		power
> + *	5		custom (for raw EPP values)
>   */
>  enum energy_perf_value_index {
>  	EPP_INDEX_DEFAULT = 0,
> @@ -112,6 +113,7 @@ enum energy_perf_value_index {
>  	EPP_INDEX_BALANCE_PERFORMANCE,
>  	EPP_INDEX_BALANCE_POWERSAVE,
>  	EPP_INDEX_POWERSAVE,
> +	EPP_INDEX_CUSTOM,
>  };
>  
>  static const char * const energy_perf_strings[] = {
> @@ -120,6 +122,7 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>  	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>  	[EPP_INDEX_POWERSAVE] = "power",
> +	[EPP_INDEX_CUSTOM] = "custom",
>  	NULL
>  };
>  
> @@ -1073,6 +1076,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  	if (event != PSY_EVENT_PROP_CHANGED)
>  		return NOTIFY_OK;
>  
> +	/* dynamic actions are only applied while platform profile is in balanced */
> +	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
> +		return 0;
> +
>  	epp = amd_pstate_get_balanced_epp(policy);
>  
>  	ret = amd_pstate_set_epp(policy, epp);
> @@ -1081,14 +1088,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
> +
> +static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_get(struct device *dev,
> +				  enum platform_profile_option *profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +
> +	*profile = cpudata->current_profile;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_set(struct device *dev,
> +				  enum platform_profile_option profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;

So prior to the patch, cpudata->policy is supposed to mirror
policy->policy.  With this patch, this assumption is no longer
true. So it is possible for the user to again override the choice of
EPP set via platform profile by changing the cpufreq governor ?

Is this the expected behaviour?

The bigger concern is, if the governor was previously "performance"
and then the platform profile requested "low power", "cat
/sys/devices/system/cpu/cpuX/cpufreq/scaling_governor" would still
show "performance", which is inconsistent with the behaviour.


-- 
Thanks and Regards
gautham.



> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> +		ret = amd_pstate_set_epp(policy,
> +					 amd_pstate_get_balanced_epp(policy));
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		pr_err("Unknown Platform Profile %d\n", profile);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	cpudata->current_profile = profile;
> +
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops amd_pstate_profile_ops = {
> +	.probe = amd_pstate_profile_probe,
> +	.profile_set = amd_pstate_profile_set,
> +	.profile_get = amd_pstate_profile_get,
> +};
> +
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->power_nb.notifier_call)
>  		power_supply_unreg_notifier(&cpudata->power_nb);
> +	if (cpudata->ppdev) {
> +		platform_profile_remove(cpudata->ppdev);
> +		cpudata->ppdev = NULL;
> +	}
> +	kfree(cpudata->profile_name);
>  	cpudata->dynamic_epp = false;
>  }
> +EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
>  
>  static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  {
> @@ -1096,11 +1173,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>  	int ret;
>  	u8 epp;
>  
> -	epp = amd_pstate_get_balanced_epp(policy);
> +	switch (cpudata->current_profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		epp = AMD_CPPC_EPP_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		epp = AMD_CPPC_EPP_POWERSAVE;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		epp = amd_pstate_get_balanced_epp(policy);
> +		break;
> +	default:
> +		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
> +		return -EOPNOTSUPP;
> +	}
>  	ret = amd_pstate_set_epp(policy, epp);
>  	if (ret)
>  		return ret;
>  
> +	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
> +
> +	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
> +						   cpudata->profile_name,
> +						   policy->driver_data,
> +						   &amd_pstate_profile_ops);
> +	if (IS_ERR(cpudata->ppdev)) {
> +		ret = PTR_ERR(cpudata->ppdev);
> +		goto cleanup;
> +	}
> +
>  	/* only enable notifier if things will actually change */
>  	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
>  		ret = power_supply_reg_notifier(&cpudata->power_nb);
> @@ -1207,8 +1308,8 @@ static ssize_t show_energy_performance_available_preferences(
>  	return offset;
>  }
>  
> -static ssize_t store_energy_performance_preference(
> -		struct cpufreq_policy *policy, const char *buf, size_t count)
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					    const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
> @@ -1224,16 +1325,22 @@ static ssize_t store_energy_performance_preference(
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	ret = match_string(energy_perf_strings, -1, str_preference);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (ret)
> -		epp = epp_values[ret];
> -	else
> -		epp = amd_pstate_get_balanced_epp(policy);
> +	/*
> +	 * if the value matches a number, use that, otherwise see if
> +	 * matches an index in the energy_perf_strings array
> +	 */
> +	ret = kstrtou8(str_preference, 0, &epp);
> +	if (ret) {
> +		ret = match_string(energy_perf_strings, -1, str_preference);
> +		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
> +			return -EINVAL;
> +		if (ret)
> +			epp = epp_values[ret];
> +		else
> +			epp = amd_pstate_get_balanced_epp(policy);
> +	}
>  
> -	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
>  		return -EBUSY;
>  	}
> @@ -1244,9 +1351,9 @@ static ssize_t store_energy_performance_preference(
>  
>  	return ret ? ret : count;
>  }
> +EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> -static ssize_t show_energy_performance_preference(
> -				struct cpufreq_policy *policy, char *buf)
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 preference, epp;
> @@ -1267,11 +1374,12 @@ static ssize_t show_energy_performance_preference(
>  		preference = EPP_INDEX_POWERSAVE;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return sysfs_emit(buf, "%u\n", epp);
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
> +EXPORT_SYMBOL_GPL(show_energy_performance_preference);
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> @@ -1595,10 +1703,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>  		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
> +		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>  	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
>  		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
> +		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>  	}
>  
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 6882876f895de..b4c5374762110 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_AMD_PSTATE_H
>  
>  #include <linux/pm_qos.h>
> +#include <linux/platform_profile.h>
>  
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
> @@ -108,6 +109,11 @@ struct amd_cpudata {
>  	u8	epp_default_dc;
>  	bool	dynamic_epp;
>  	struct notifier_block power_nb;
> +
> +	/* platform profile */
> +	enum platform_profile_option current_profile;
> +	struct device *ppdev;
> +	char *profile_name;
>  };
>  
>  /*
> @@ -123,5 +129,9 @@ enum amd_pstate_mode {
>  };
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>  int amd_pstate_update_status(const char *buf, size_t size);
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					    const char *buf, size_t count);
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
>  
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.43.0
> 

