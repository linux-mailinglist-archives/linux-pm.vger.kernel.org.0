Return-Path: <linux-pm+bounces-18679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF29E6748
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EB01882743
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFE1D5AB8;
	Fri,  6 Dec 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpkCmGHz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925ECC8FE;
	Fri,  6 Dec 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466312; cv=fail; b=LmQBv93DnBRCVTeevNEivHtwMX4j102pQ+lzfAj0uWPLTvhyGvNZOlJAc6TUtXtUeZ9KMBStm5qMIa9gsmgsMVHNg147QrytoeJpKm6fhp2Quppmt47X+Mjf35dJe26kfxTfn9zuNynJ83n2koKjrVLtA30142LAuyvvb1bzoWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466312; c=relaxed/simple;
	bh=PHTsUF9+9/fyYwy3Qom07BU6t8SmBGMcWzK3vZZT15A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CA3i3HCL7ln54dYos1tGgTdWRAzUqEY2qslz2CM8QVbxeHnOKlZk4/1or023dBxtzLDb6phZmrhL8ku9Z6mAwdcJHb1VwIr1SGYx37gSDG+Whew3Cl+kd86SJGtkLNOstSpxo5fFsT8QOmRkox56+6Cy9/Uwq3H9AHuI8VD0hRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpkCmGHz; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajnrz+DBIH663H8yuBrHcbHdVHpyRJyjP6NPXNfsAFQyGWt6iqdKZi+qsqAYb00E5q5NIF3pnzQOdnUva3qbDaSpY9We1mEepVdzANiZ2VIoqQRXCNZx12eXRmh8UbD+rSd/CxelS9rS/zJDCG8fEijbK1Dx3xCOQIrYNC+AzE0Wd9oGSyqAmV5z0Bw4ILDWd9xHFeQC4HZw2ozwYrEg3TvF1lL1mHr2i/bfXyHn9XdT43vFLOlM8wbQGjyQKO9EC5az6IJNBM7ZcMTII/ll1lqEL7aSu77pn7csliDmKHd5mRT+hz2Ush4Nr/NrOS1MCIlJCxZVFAD1V6Rq3dzSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YClHXOlQQTTdTz8OaDf6O8WC0X8rjmOT+FtTr3ucYY8=;
 b=E3oaD8kJgfip2YesyP6zgLd5Fz1Fo0z5jjNl1VcJB7ZxhP69q9i97sW74mW30T/DxqXh/44JcGacjjhVvKuzSfwrslXyFGf9rt4emz/W4kR40j6YJD3aX+13TFuVasJw3XpGAJX3mSneCOndjDrWe5QxkTlsKDNaZUiMFg2MuAYXsHy6r0n3YmpE4T2iZXTV72x+XkSL5miY6PgcUjXWQVXp1NE8VRADkrJ3IpOEqp84hnjGwZruYleZEaKBjXtVWwpg0CxcFd3Sqmgml1hu9FtiOuAlLfuxzaxGfW5c60a2Zx8XKyUl6i5VwxF6kW08NwBEKptMREGltfW7SgA79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YClHXOlQQTTdTz8OaDf6O8WC0X8rjmOT+FtTr3ucYY8=;
 b=wpkCmGHzg0YThY7IkagjWaAMwIjqX1yka8tTRa+qhTMyYAf2BAYgwsSU8HTj3asfkN/gccaqFzMha6o0b6hD6he+6bCW5ihL2OapivFbsEVoP/pDx/KPUYkVk4Sj7z3EjIJgx+Q4/zVfyn/ZOkziHMdg2YcH0+9kjkprWYTmQbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 06:25:08 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:25:08 +0000
Date: Fri, 6 Dec 2024 11:55:01 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 05/15] cpufreq/amd-pstate: Store the boost numerator as
 highest perf again
Message-ID: <Z1KYvREbwjWspe+/@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-6-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ded253-6fe9-497d-072b-08dd15bebabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eY4/j7z59L1WRN+73JnVNho7YkwGX660QOdLvndhhXsVI2bal9hmqRwcXCug?=
 =?us-ascii?Q?qRQl/+jpi63kCY57eAonfR4gOpJH+yOIDistZrS7WEBD//St/fjKofG75gzQ?=
 =?us-ascii?Q?tluHKeXkJ3mO4KM2AsUrDEeITqJ3QQH7lbdugY3F/2aT9u6ubQoHq47wvX0u?=
 =?us-ascii?Q?5tB4aBUClgW92rVA5E7esqJzOMXKyAmmdPRTLSXPf+SpFtbrVj/4npN/xvIc?=
 =?us-ascii?Q?i/yC2f6/ltsfYxo4SsfRwwIKwqKFSkGONrKvUN8TU4m8oD25GKztswnEG0et?=
 =?us-ascii?Q?Ivr7gocveh9S3hU+7Y+AP2LSqi7V5qd+xCiHs3r6IiA12MXlEZpV5OqPGH4+?=
 =?us-ascii?Q?b3Bb/zeakFUS3xDW2rP1cefPB09mwdbyDn3mfehNStQmFBZiDSpSU47atnXO?=
 =?us-ascii?Q?KOHP0xu4YIFZFInofFXN9YO82fs0RkxYCIEQoP9u7ZAXwNHyU6lCcFacMsvC?=
 =?us-ascii?Q?2TR5pQkMLaYxJoz4VTD7wfSsSqsicA8QEG8bwfTKVsgK/uelQOh2qYXTYxYe?=
 =?us-ascii?Q?06WpmX/g3WHcp469R8DsL5UJ+27t0qHK3c1MF+i0pjP/u7XN1ESiv8i/Wq5Q?=
 =?us-ascii?Q?kmwTewuW6fulJuLcv0r+l+Ue1Io1nmTntvJnhkjwRPU004jC9KGm5FPeQWiU?=
 =?us-ascii?Q?txDxWjiJf57hDwX0Yftw1CDriih7oExHHd6DzZgbb08zotcUGYQYBRP6jJci?=
 =?us-ascii?Q?f+NEDYIXKaMCBRYKqhpSaV8xkXKT4aZMAYBkUm78bketwdJePlX+avACT72A?=
 =?us-ascii?Q?ox4mvV3qACPyiKOJyuzIjwumKSzOAxeZWij33XDfUU/28geNUOvP+RGsXjm1?=
 =?us-ascii?Q?uw+FFFNqYtYI2Eo7LDKLB7u2jhtricgO6Hq4DAY9Yisggkjt0lUJAxREAort?=
 =?us-ascii?Q?6eD2tPckTfQAFvi3L8ICjeYqlb5TvAAZTPdi1tvRuRlmGnPfP9xPBs3y589R?=
 =?us-ascii?Q?V5yYUG8zzbw9O1lRfdek+ngOq/OSsnJe1TW7tfR6sHzc/b57rkU/9vSrdxym?=
 =?us-ascii?Q?6mzGp5z1a7n+hydg1xh/1FTiwdTAU1Ofe5t4mFsVnkBCsoRhvUJ7eN0knYrQ?=
 =?us-ascii?Q?LgZZH/BUIgoSHP4EVa2Tvc/SsbsUdB8P14871oMc5NRtYGkui8onBMzYSI89?=
 =?us-ascii?Q?SXeLwYHg9lZbWS3hpB0SUI0V1cB2UrlJbQhwHCH63bcn/yoWAXFHiKiKFm3F?=
 =?us-ascii?Q?msZjsk+v0UGCY75IhoIwqa9wTtreX9aIgaNZe/c+1b8HYpXEk0+rHHR20XE4?=
 =?us-ascii?Q?R6eJpJTnQkcTub5cZiT9QtLaxmNL+3PbVEwZ1SOccAQzYUkYcZQzGnbwS+Hw?=
 =?us-ascii?Q?IdLPWH8PlH0LHt3TDKibMd9I6j3R3WQaa8BqX8UhFMAP6O/f5p06SA/OS+Sm?=
 =?us-ascii?Q?YWDVFaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZ7hjRiAShr7QCysEm51aYaqvg5T1R7LU4eZfZTdBR9OSY3o3Bhl6DjX5JOw?=
 =?us-ascii?Q?sN1gcPqZr7S8egB1G9/bwwzADjZrIhXbuUdshCUWu+A4GNpq5bkiGeWLgy4Y?=
 =?us-ascii?Q?Epd+4TSkKgdMUIn0EYC5fUgPu+L/DWckCpiw+Jrmj9DzP+4z6CE1eWtS0pfo?=
 =?us-ascii?Q?FKZnmUTp4Nhoe4B4Nu1CpSv/iRJQQqJ07m2O2yrGs9q5wrTqQR376Ibnkpbc?=
 =?us-ascii?Q?9vGkdNnwXNHu5JPkLidjJCAN5LgB0Ft1/fGpc9lLR5W7cFQKcuDPXFJdic3u?=
 =?us-ascii?Q?y23YKNIdF6IEUYRJqXjeKsuBS+qC4zqkEq+hyYo1V/4KgdOPpmsbfgD+IEDz?=
 =?us-ascii?Q?v/UpWSV30zYkonYqI4nNN0v/tW3PDkIi47I5hBeLIeghrH6QEvKl60wuF5+Y?=
 =?us-ascii?Q?n1Tf55qVizWhQDbE9XyvgEZIjYbosn+GguWJJT+rC5WxxkvNhLsojgGy7uQB?=
 =?us-ascii?Q?oomLFq9Bz3C+pY7acGRWsODxR8fWxfghjxm0+IOkXXqrOMz+OYdFJL+r6R4g?=
 =?us-ascii?Q?SD5CYjWur4lKS9+6ZI3AmobnB6bRZBGhH64eaKXcw4kWZ3MrPUJhzteAxjN6?=
 =?us-ascii?Q?9m9YqeBDBLsCOZ9iyoMPFkoNblt3j7PoshMmO32/jOm7+ZDBTTTHQo7EBYEV?=
 =?us-ascii?Q?iKxqK2PMZsj8AF7LWckb2/Z3awWBwJ89Tjuyh+pM5+xklc+j9S3KWAfSDWlZ?=
 =?us-ascii?Q?1ECNfCFKPVKNVfRNdtVEAPo41HCcl48tTEKWZZNkX8OfAcLYMG90x1J9QaEz?=
 =?us-ascii?Q?U7VtEnEgx+wqhsquHVvA5b+oJoFF632WyKkBsmVAYfUMEtKEaDn9yadIhezI?=
 =?us-ascii?Q?Rbp0N3uRILYHjpmXJtOYbSxnqcgzI8dhGBQK9Ns1+QgQ/XsCO0BXd/xDN3C4?=
 =?us-ascii?Q?BZBQhXFW+fk6fHrxUrKcJiGX4UiVUf0fSTBUHgR/RUyo0O99VdOLnEEWgrbb?=
 =?us-ascii?Q?pA7Jl09nPtMeqQKPaLSZCJwrhk5QIYRmPBwBZuUsdyt/wA8SKrqz8ZBopMFe?=
 =?us-ascii?Q?/inaNaxnL3TnOs3wLM2VoZGPaKQkkL84S0hMvF1TJbBqAm68DpZ2QXHM8yLH?=
 =?us-ascii?Q?Uza7fDYT/G13OHvD4sJG5df/blUaiP81Q18pVY00ZIR/JzF+mnCnJr41K+Db?=
 =?us-ascii?Q?BlgjMNn04kIVX5hA5bVls2KGXb+IQkJ6u3j8pJ1eRx56qbQ+dW7/fTUdwjv1?=
 =?us-ascii?Q?d9iaR061fP6AyGe9xnXYMaJp+GL/xsz8MQ3TvfvgLkmx7ZdX4q3Gq8ZXVdj9?=
 =?us-ascii?Q?ZX/5OXmDEmvlArOCHzvgBkzlBKGdx9Pv+SjDkHstdS4jPfK2krpgKBOhTOl8?=
 =?us-ascii?Q?k8X+fCyz78d+NZTpbOfL0xLu0q0hntKH/OrxRc3Cy1hDnRs9VJx/3p9XANek?=
 =?us-ascii?Q?nTl0kjGI0+GEHjGjkmVVEJKxFDMqWRjP5HBCLDNeDpHYlZ7fu59AQprxwRls?=
 =?us-ascii?Q?xNzd115AjNhe9PWitojGjLACdh0wHqbyxr4YQbmf9ti5f37yFmo214zXsir4?=
 =?us-ascii?Q?jgKmmaXG1pKHMShed9YUMyx3Rh+9ttP6SilweOJN6VsRAi2DMKnzVtRR3so8?=
 =?us-ascii?Q?vSrS4OiBZOxfNaOivhOrWakvHhL0Ud/FBccOr6rQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ded253-6fe9-497d-072b-08dd15bebabc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:25:08.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYHu8AigtuzCWwHDDal4K5dvxiRBg30Q+l20yIJxJO/Ky8ArO7GnLGBSfEinuiiq7WdWP4KuCRkZZ6SJdCM+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483

On Thu, Dec 05, 2024 at 04:28:37PM -0600, Mario Limonciello wrote:
> commit ad4caad58d91d ("cpufreq: amd-pstate: Merge
> amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
> changed the semantics for highest perf and commit 18d9b52271213
> ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
> worked around those semantic changes.
> 
> This however is a confusing result and furthermore makes it awkward to
> change frequency limits and boost due to the scaling differences. Restore
> the boost numerator to highest perf again.

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.


> 
> Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  4 +---
>  drivers/cpufreq/amd-pstate.c                | 25 ++++++++++++---------
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 210a808b74ec2..412423c54f258 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -251,9 +251,7 @@ performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
>  In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
>  table, so we need to expose it to sysfs. If boost is not active, but
>  still supported, this maximum frequency will be larger than the one in
> -``cpuinfo``. On systems that support preferred core, the driver will have
> -different values for some cores than others and this will reflect the values
> -advertised by the platform at bootup.
> +``cpuinfo``.
>  This attribute is read-only.
>  
>  ``amd_pstate_lowest_nonlinear_freq``
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dbe014f3c2beb..738f63d70546f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -408,15 +408,19 @@ static inline int amd_pstate_cppc_enable(bool enable)
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
>  {
> -	u64 cap1;
> +	u64 cap1, numerator;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>  				     &cap1);
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> -	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> +	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->highest_perf, numerator);
> +	WRITE_ONCE(cpudata->max_limit_perf, numerator);
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> @@ -428,13 +432,18 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>  static int shmem_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u64 numerator;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
> -	WRITE_ONCE(cpudata->max_limit_perf, cppc_perf.highest_perf);
> +	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->highest_perf, numerator);
> +	WRITE_ONCE(cpudata->max_limit_perf, numerator);
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
> @@ -920,7 +929,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
>  	u32 min_freq, max_freq;
> -	u64 numerator;
>  	u32 nominal_perf, nominal_freq;
>  	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>  	u32 boost_ratio, lowest_nonlinear_ratio;
> @@ -942,10 +950,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
> -	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
> -	if (ret)
> -		return ret;
> -	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
> +	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>  	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
>  
>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> -- 
> 2.43.0
> 

