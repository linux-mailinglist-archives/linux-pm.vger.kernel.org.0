Return-Path: <linux-pm+bounces-23606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF94CA56116
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163B0176D4B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235A1A0728;
	Fri,  7 Mar 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H0PGyE4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1741A239A;
	Fri,  7 Mar 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329945; cv=fail; b=ktF1yQE/umM6RPnIG0mGv85cS2h1ilSOwDKcOCOidsDTJ1BgbvMInMfrk5taITEC0+vnXAIQ1yvcXTek58+Q44DR5KczzXcauqM/jR35ZAwxuVsh+K5B43RdMf9Hui66T2czZpVbEuGr9lz23mcvAaA6/f5wcXGqegMmH2VUge0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329945; c=relaxed/simple;
	bh=aKpozd8/Pdkb9Q5qw3oP3/3lyVWYDEGIN6Y1I0wPuRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNb4/NgGydkTDByZL5hbKIp+bGxTky+iz4T/cDD9l/PFSF2wzIDjDITtl2a/1luPRhm6gIdqhO5oP1uDZxDNwonTkMeWnC1eD+up3kqTAIPto5Qy6e9I1bEWZDTyUZbPtHALl/b7bW5q/isCkppnsMnYP51YYHKd3mNz6zzYrKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H0PGyE4j; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYQ23/CkSr7VKcSeGc0WSV1+gvsud2Y3L93Zdvz2c37bsdp1LX1QTG8cSLD2RMmwsJppb+STrJfELf1NHX+7YCgbKI9pt1qfCFugWdkJ2mWjmJX3can/C8UZa/k+0Aa5hw5SG0pfn6yhEsxbummPNyazKqJAUR9aHyOBtMLDv1eVquYy4UHLVUrDbrLKmgEohWJwfu/mnlnmqHO9VI6ywgFSU1SW19Fj3sUcIXMSktrfkY/gtwWce5AqXLffvSAxSjz5LqlPgfx2kVuhkTTl/ekqhhelXDRV9pHb0Bu3lR4yAyjiCMQIn4wk1uzqPgiooiuDOX+jwGXr7HdKA9qiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yAXepEnDi9ZabvtoMtuTtO0sORRcH2q9CDYkFWRcxg=;
 b=cJE9MItV9X6GgmIc/hONcIHeE+3m1TP9ZVn/MyAeOjajF8Ir2YDBlO+2B57ciR4FaiNy9ExSoQLYmqFYm/KGFIRNuo+gVWqCmlGuTQihuFb6cwRhXAXEPuCRLdZEzCNM/Cdjs6omxh0oYD/2K6NeWa5yZRLuGBafJfhnZEpLFMQXvNrXFLeNnmJfzUxwn1kTiyW3Iogj55XULi6ewrbE15kgj+WKEZnvyXuw4v8IBiOLd5C5YEX2hwdCn4SifgyEPP2bAD7atsTTx7WsSXrIAu0XUefrosorDJn3EspkwfwLGyMopWEryXSnI0RlBicwoW75OUlqyEhQDG7y14M9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yAXepEnDi9ZabvtoMtuTtO0sORRcH2q9CDYkFWRcxg=;
 b=H0PGyE4jYoAj8vZ9nPOY/DZ3BVmsdTWxZ/NrVFB5I5GOe+gU67m+x2oWATooQUMJG41G441139PVNAmKX1Gavzin5zYCBVHbPURLQp/Flwu/UsmvKNkUjDc8amwcmM0Cg9yXL+1lUeTV4GxPjzoDdLq0B4awyFzDJtNxka9gP7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 06:45:40 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 06:45:40 +0000
Date: Fri, 7 Mar 2025 12:15:31 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy
 performance preference
Message-ID: <Z8qWCyb8Jexb180g@BLRRASHENOY1.amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304152327.1561017-2-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2da08e-d6c5-4a2a-b53d-08dd5d43acf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?peEcxJX2W0ZOgk5HZ1Ub8soc9I1beVv5QVvGZTr+eWUriQ+6MMboOEvTfRN9?=
 =?us-ascii?Q?DRAQ/HG/uKgIUmbTT0R/hmowKt6zjd6rF2bNDco4vzN/9HWv8ubulnYArPX+?=
 =?us-ascii?Q?IgGS6ImmJ5XzHEJO9cLfln555en+zPvL0nAYVUZcYIhyEWWoLgt0LrMMN2cB?=
 =?us-ascii?Q?Xiunjo0A+uKGHX0htSmW5qLleziZwECIB2sP4rmW73g/QQ82X6wjk1KamEbz?=
 =?us-ascii?Q?JToJVVoT21Qtbj6Rxfu1dqz56yR5PoqQqaK+dRQLqfW3+BLBZ6IfnuSGLb/m?=
 =?us-ascii?Q?5yefxuj5hrHwVrA/4b4G26s+X6NprP3hNSBJYkKOsUDK00U/qvUUIPjoNnr2?=
 =?us-ascii?Q?37TgeohjmCoMajFCJiVC4UwKYfFZXcVx+D+OqGhEhf8Mq7vgMgKSIVvT/zLp?=
 =?us-ascii?Q?XyQgy75R27jgKUd2BVBCdBEVMunwkWR9NDxLbV0YzYchn5URNdNzK3JgaCu6?=
 =?us-ascii?Q?6nQR3IPUnSMD3RYkIWDVyJnurxXRnfxmc8lLF8Z1qLHyPyIAbqsr1cmKbA/K?=
 =?us-ascii?Q?S6NL14uSTKVR7NutLFA+GC305xbEedQBmMiq43owSNaP761dEdDsh5Ws6ePS?=
 =?us-ascii?Q?o51Evvk6VwMZRMUeYJAmQELBojClse5EC49yg/hKPwSiCB3kqL7Qw3PfT+zq?=
 =?us-ascii?Q?g4OCOo+V7zAXHqTp8gm3xBPNjxcXKR85f+/nmDBLe80OJQO0CZtSPb9jl1R6?=
 =?us-ascii?Q?SYoNNUvTYD1GoaN01cxttxHZp9DIFJhDpNU4hdxAJ4CKcFbBlgih7FLr8Loh?=
 =?us-ascii?Q?UNjoEO6JnU0oekojL1Zf0n2boRMrVnD9HEYRKrmjFXShkivrgKQUyBIyx5tK?=
 =?us-ascii?Q?7UHka4jbMmss4gLRU1tavOjjT7UP3KLqfldVtMJ5Ts/g9MmokdgBWo7p3OLn?=
 =?us-ascii?Q?v0ZU+1vMjOxB8Gky1zJwDRKGMfct2Kd6NlSUaFGFxkfoweTu6IGY1cf41RSG?=
 =?us-ascii?Q?ul7BWEmillRuA1rdmY8vIcEYtMSN47CHXNdw/PK9TUf1z2rxt5nu2BeVSzNh?=
 =?us-ascii?Q?HbGNBkW/9cto2zp7VK7bIAhmbN+G1dLl6d1tC2fiowDP+bIw8V4iJko9m2Aw?=
 =?us-ascii?Q?LrGfUTfc8dFtDPUe9O24ANy5oNJmrNY4PGN5tg9gxu9dI3DJwM+16NfIoGJz?=
 =?us-ascii?Q?XSlJiJs60arTIgW6vrW2HqG4DgyIw5n4curP3Jisqe9Bx+oQM/VSxkinipbF?=
 =?us-ascii?Q?nvVKL2hOR0eXLsBIeMu6+KzVIfH1/SwgyzJb3oJRF3P3SiPSMomdWPvJOdvB?=
 =?us-ascii?Q?U1kpLo3FDO9uBo/PSI731pZgNyK6chIQf4ixEpoezch+1JNRqlpXguO9e4ln?=
 =?us-ascii?Q?b03IYlJ0QAiDRo/KaY9rTxBfir41VQtt6SaVznyFoZ76YrwLTdQ+bqUp81qT?=
 =?us-ascii?Q?Rlfy0nN0LM/Dq4+tgI5rwvbrDlZ9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2Z2hF04mH/O30E3YZhitZWmAoEMXw5LWM0tb24dG3pc/Krp1pS+iYQqjhxF?=
 =?us-ascii?Q?hc/lQw5Z/UZfa4oGgSBmN+1yIq0GAr9X3nNeAQOcmzm8EUGk0TkdyecqVVmm?=
 =?us-ascii?Q?F8v1gPE1uz8jQJ+SZ/6/A09BAy8hSHMg8A79MOocoqSPACMhyW45G6FkTmuR?=
 =?us-ascii?Q?B6LLxezlyc1FaI8kvmW1gN3PobmYLHzPWkplIa3hxLJDB8dFoTkeE75seOd2?=
 =?us-ascii?Q?lWcsZgQ3eWKk0mcvmpghE8i/yhF/WcvDHZX2VUDU0VXJTKqBTSpQbz//ugJE?=
 =?us-ascii?Q?7BE/ija+PFYldrrtyjgvl5+3/iNtwPX+lwY0NSkbFUWda2ZYvMtlslbN6bVN?=
 =?us-ascii?Q?NXCi8lzjQv3oOPC8mDWH21w+Kp3eC2RrucaWKuedykrUy5S2UTyVyf20t+Sc?=
 =?us-ascii?Q?zbe7umq4H2TGhBsuBdLNuSn/GqH3y2EqKIrcCdLPfiwHER8OzSvo78TQtMtX?=
 =?us-ascii?Q?eoIGGoBxGoP3Fmqv19cb7kYCq6VswJ1kGp8eyXmgulBDr2jAxNjpdJZiezsk?=
 =?us-ascii?Q?mc+rmKHsN0ecD2dWgayXyxZFH7VetPAHtZpwY8WqO+4NjwQdJ0+EyjzhT0ZF?=
 =?us-ascii?Q?wy4jMJBoJifjQQbbYpjnz+8UNIbNfhj2XHOV8hkMh4njIyfYZpsOavwAPZ9q?=
 =?us-ascii?Q?BMUAZIDZybGwTPnP4EcbFVeSKAw2r5ui8CnkTfDnZXIVreaQMU6joLcc8Lk4?=
 =?us-ascii?Q?ZIEd11mVkl9xb7nhqCKI5ZlzTzmMWCfamQzChOYY6/BN3pACRgrtRL6ajcBQ?=
 =?us-ascii?Q?5wQewPn1ZTG1iXEF00c3KWpTTxs6e7EzDGAI7Tv6Hjd0SbbYqO3PUzYv3GLi?=
 =?us-ascii?Q?AuA4jE5HpB+rITwKpXJNxwG8QU3f/io1rl+P1Qawnew9s4G9pdWK03dWpiJD?=
 =?us-ascii?Q?E4OHXN60SY8o20Lnda53aKercK4r9y0gvSMRG9nTGOxNsxzOQYzM6MehWscp?=
 =?us-ascii?Q?ohHXSjtHsor1hBNS0IPmFTFtySF1Jym4aVgCALFC+XLLllhG53OYnW2o/Go3?=
 =?us-ascii?Q?x89U8YuqyR2bCD6HfFSY8me68uhy0Ra4d7kpvwIsTdrAgqqEqXE1qrQd/bTE?=
 =?us-ascii?Q?IRr/i74K0aMBAsP+cl3QROnX2sGh888dVkqIP8Q4f1GocVdJT1JZpuoqVjHA?=
 =?us-ascii?Q?SPCQdBDHfyEe1tvieYbtIYnfb26sHf9HlrrdYNFBF5vrssQpn5p9E/nJtX2z?=
 =?us-ascii?Q?C5mQA1VITZAtKH0OSbr9RLgJJEC+pVXMB5vl5UoSEWFIYZkvtco+yL51R7Te?=
 =?us-ascii?Q?f05I2eLg4l+4uFTkeRC9GKecWBmMHRaTk/qccy/axZQVos8tDGb6mu/EuHTS?=
 =?us-ascii?Q?gsf6ZI89fHT6DUKOLaPaWMSyhYYhfd5OwOUo7holn3RQGbOd/K9Vb5db4Zn0?=
 =?us-ascii?Q?kPkXcEUXz9KCJu/EYo19n0EcbzRjnJlDCEsmn0zFjPY1l7t3n81KfMW44hFo?=
 =?us-ascii?Q?E2Ntcf5efCgpsaFZOUSTyaUVhOf7RLzz3wgE9R1vFZr4gDdXWElltiPS8BcU?=
 =?us-ascii?Q?p6E0bXTukzhlzcK2uf8+RuirDqnw7zMlqoUN6K746bJVmbPjpvVI+jE7z2r7?=
 =?us-ascii?Q?vlFG0qikf8M7H9nLS2taR2D6mxOkOXfxTHwsLDw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2da08e-d6c5-4a2a-b53d-08dd5d43acf6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:45:40.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgE6bquUZ8LkdbFcuTZHU5PNTFn1qLwnBEI7BIxYlCKinM2lsj6wlhiZbDWi5dHWQLbVcWrnQ9x56oBE515yyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

Hello Mario,

On Tue, Mar 04, 2025 at 09:23:23AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Dynamic energy performance preference will change the EPP profile
> based on whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust
> EPP values on plug in or plug out events.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Change defaults to performance (AC) and balance_performance (DC)
>  * Default Kconfig to disabled for now
>  * Rebase on latest branch
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |   5 +-
>  4 files changed, 155 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 412423c54f258..2e076650dc77c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst

[...snip..]

> @@ -311,6 +311,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> +Dynamic energy performance profile
> +==================================
> +The amd-pstate driver supports dynamically selecting the energy performance
> +profile based on whether the machine is running on AC or DC power.
> +
> +Whether this behavior is enabled by default with the kernel config option
> +`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
> +at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
> +
> +When set to enabled, the driver will select a different energy performance
> +profile when the machine is running on battery or AC power.
> +When set to disabled, the driver will not change the energy performance profile
> +based on the power source and will not react to user desired power state.
> +
> +Attempting to manually write to the ``energy_performance_preference`` sysfs
> +file will fail when ``dynamic_epp`` is enabled.
>  
>  ``amd-pstate`` vs ``acpi-cpufreq``
>  ======================================
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 97c2d4f15d76e..c5ef92634ddf4 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -68,6 +68,18 @@ config X86_AMD_PSTATE_DEFAULT_MODE
>  	  For details, take a look at:
>  	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
>  
> +config X86_AMD_PSTATE_DYNAMIC_EPP
> +	bool "AMD Processor P-State dynamic EPP support"
> +	depends on X86_AMD_PSTATE
> +	default n
> +	help
> +	  Allow the kenrel to dynamically change the energy performance
                    ^^^^^^
		    kernel
		    

> +	  value from events like ACPI platform profile and AC adapter plug
> +	  events.
> +
> +	  This feature can also be changed at runtime, this configuration
> +	  option only sets the kernel default value behavior.
> +
>  config X86_AMD_PSTATE_UT
>  	tristate "selftest for AMD Processor P-State driver"
>  	depends on X86 && ACPI_PROCESSOR
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e98ef41083ba1..f00fb4ba9f26e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -36,6 +36,7 @@
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
> +#include <linux/power_supply.h>
>  #include <linux/static_call.h>
>  #include <linux/topology.h>
>  
> @@ -86,6 +87,7 @@ static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool amd_pstate_prefcore = true;
> +static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
>  static struct quirk_entry *quirks;
>  
>  /*
> @@ -1050,6 +1052,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> +static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)

Can we rename this function as amd_pstate_get_dynamic_epp() ?

Because the values being returned may not be
balance_performance/balance_power.

> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (power_supply_is_system_supplied())
> +		return cpudata->epp_default_ac;
> +	else
> +		return cpudata->epp_default_dc;
> +}
> +
> +static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
> +					    unsigned long event, void *data)
> +{
> +	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	u8 epp;
> +	int ret;
> +
> +	if (event != PSY_EVENT_PROP_CHANGED)
> +		return NOTIFY_OK;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
> +
> +	return NOTIFY_OK;
> +}
> +static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->power_nb.notifier_call)
> +		power_supply_unreg_notifier(&cpudata->power_nb);
> +	cpudata->dynamic_epp = false;
> +}
> +
> +static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +	u8 epp;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		return ret;
> +
> +	/* only enable notifier if things will actually change */
> +	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
> +		ret = power_supply_reg_notifier(&cpudata->power_nb);
> +		if (ret)
> +			goto cleanup;
> +		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
> +	}
> +
> +	cpudata->dynamic_epp = true;
> +
> +	return 0;
> +
> +cleanup:
> +	amd_pstate_clear_dynamic_epp(policy);
> +
> +	return ret;
> +}
> +
>  /* Sysfs attributes */
>  
>  /*
> @@ -1146,6 +1215,11 @@ static ssize_t store_energy_performance_preference(
>  	ssize_t ret;
>  	u8 epp;
>  
> +	if (cpudata->dynamic_epp) {
> +		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
> +		return -EBUSY;
> +	}
> +
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
>  		return -EINVAL;
> @@ -1154,10 +1228,10 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	if (!ret)
> -		epp = cpudata->epp_default;
> -	else
> +	if (ret)
>  		epp = epp_values[ret];
> +	else
> +		epp = amd_pstate_get_balanced_epp(policy);
>  
>  	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
> @@ -1165,6 +1239,8 @@ static ssize_t store_energy_performance_preference(
>  	}
>  
>  	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		return ret;

Isn't this unecessary given that the next line is doing exactly this ?

>  
>  	return ret ? ret : count;
>  }

Rest of the patch looks good to me.

-- 
Thanks and Regards
gautham.


