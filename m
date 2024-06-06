Return-Path: <linux-pm+bounces-8700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230988FE39B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881961F213E1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FF17F4FF;
	Thu,  6 Jun 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jaitW2J"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9B17E91B;
	Thu,  6 Jun 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667770; cv=fail; b=BzaWZQ9iiKJqXyqMG8ttui+0lf/weA4OzaewbdSvLc5AP/Ke9hkqAlE8eSAthPhuN4Qzhj2vpz31ZrHu0IamQpnHT6E+3ar8Gv10aFZs2xqehukvyCn9WUYVkjvwNlLbA580+D1hk05G6AGTbTV2rzCY4RrkFLOLpqM7zaI4Los=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667770; c=relaxed/simple;
	bh=w/f4CBZatkxAqiM4JEpmJ2QtHhp+pmwiSnezxydCBV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOTuo3IFNaBe5ooBZ8JYYG5cLAsHbhoeDIafq13lvg6LonhMQtPFLqDPfw2K4/D/a+5f+YifnJIwrtLUy9/uB9IT3qegR1jGdJxvrx5LdwbNVGRZ9vFnR9OfEqSf30wHyvzYCprqxMcr+OfKHbYemVNGTm1kzCFcX7aj4qnhYWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jaitW2J; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXGIrs1EG1r3UD7D9ewgwzohm5mQWxpcfgpJjnAT9BESXLzzN6bLHn9i22YKrUqpJotuPttv5ZxwtyChHuwZG0JqCXFEP9P1V4ird+ZNlHgUQkK3IwKuLqiJdNC0WsVR5LIMdIgGJ1v04ZhGT983zTPJ48umJa5JSUSsUPSz2olVwR1KqYGZzZoYKMFXzKyYlMpPCpfbAGiOYGh8KTM19kFQao2hmK2EtTfRKmpbpuaSQK4JJEN80GnQMfn6GpsqBjmX6MgOLwjf1/3f4B+M/nNFd/UILru4Pqca/WeVpVEbKq1ULnty6LooNHwAo1cDdljEiwTjz/RwHh+XUrNYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LII8kCsryPHovEq5ouzRBCIgL/YN+Zn2L6NWu7ae9vw=;
 b=PxbGeYoUr0egMhCsW9jHwOBGf/HUXWeqKzLriCTZ8H+YlqYhter69N1OTF3Vu7NYR+SykTaIdACrvqxwjBBcYICeqGmE7j+bsVwUIArlofYFr029nEBL6IQVmpPnYoeyRulvD9nkmaTgAdRyBDzB2buLcKdwOqrVOOm/lu5TihrUXbtY2cda5dh/tLhNKQJhLDO/KM8bIJrId3vJX+ReTRIC2WF9AaGu8buzeWf+0YSIvaIZbuehPIqd7w9kbJB4M6dvdsf5LAA5QTdOMVh67YRScjl/ganBxug8BSlPp31ReTr5iv03kyMAuafxiGmmgPoS2a7vSh48CvlPtrCRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LII8kCsryPHovEq5ouzRBCIgL/YN+Zn2L6NWu7ae9vw=;
 b=5jaitW2JYPsBjkxEDPCHksxlkOz7pbuR6+g4QWOYYEE1A8ouBEfc/r5zzFK9N7xR08pqMf6kKl3UJ293J74DEeuvh4jLM4ORuLAsFlD++GdK2mvMOz2JXZxFRpX6sjEF399ANxEhr5SNDMdTIW8HWLY+FvGa2VZjfNKKIbms8eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 6 Jun
 2024 09:56:05 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:56:05 +0000
Date: Thu, 6 Jun 2024 15:25:52 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Message-ID: <ZmGHqL93i2GDHsWb@BLRRASHENOY1.amd.com>
References: <20240603110741.24818-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603110741.24818-1-abelova@astralinux.ru>
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 26de2025-96fa-482b-bc6e-08dc860ee190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcuQ/b9VfzH0I7fPfG1zVkFsuJzp845AxIoxdLAbWSnKL0tJSrdSiaNu1zfd?=
 =?us-ascii?Q?VLe0pGAe+exmFsMROqVSY41ndSywAtx3FcK+TfFQMehAK5XSHyizafwJ7Go5?=
 =?us-ascii?Q?XfwWseeAks/U413YEh/D8eZ3b5aqSmh+kZznobHAMat46ww7wmv27IRMmCVc?=
 =?us-ascii?Q?BUvZr5WIyiIyMRA3uagqxwm/PbiW9G2w1ahx+yc+3UqEI0++DcAmZDbwR0sP?=
 =?us-ascii?Q?1V22ss+NniBL4/1t8rtjMklhm55R+Z4i3wLBGjqt56DqxNHAhoL4MhijcSGf?=
 =?us-ascii?Q?2+OUnLmmJmINEWpNEi/o3fxNY2pxmkB7r4w4GT+1+mg3GX4HutOF4nzsNlzT?=
 =?us-ascii?Q?MKamEq1cO5XaxBiAsJOGeCGsSSW0zmqk52wrrhayZpdFDwWZUl3vfz32dRi9?=
 =?us-ascii?Q?cVjQ3euyslsanqeeZH3TdEYygRZF+eXihy+hPwWpPj4MDNxZn1gELUmPXO7f?=
 =?us-ascii?Q?vqISJYEOQhXCwcXP3FTqWJyEsjTAea0rp8Nl1yLoGlIYapqzotU6hj4y3ZL5?=
 =?us-ascii?Q?4GLK33ikq8vkhwWgKEunC2g9yP0WLWSRW9yV0f3B+RfslX5RCwQ1kt2hgIhy?=
 =?us-ascii?Q?zIMFRADZTfecc5kZ+bNfnthrFfZuTPgrzVg69kQBQ1H3Un1CBq12e3c83x6t?=
 =?us-ascii?Q?zvFWVbPiJuWkgb1X6K7o7wXXcm/tHhQhONLDNbW/SmugThfd56OR67ui0+7E?=
 =?us-ascii?Q?5pO45xVOC1WgG4DYNZLs8pQqvkA95CGs7OmUdgxfgNYK2ZJE4C+c68MC55Lw?=
 =?us-ascii?Q?SsYf2rpXqzWMWeEbnRdDVp80oihTbMz/4pfXsYIHO3SewrzJdcsDjEUT+K+f?=
 =?us-ascii?Q?fKvB35dnTdu6DIilBDvLMXTBTw5KuG/343QcSG41BrzCs06dhqtk5gamlRjP?=
 =?us-ascii?Q?czSHNmwA+tpV7YHhGDqTdM0RMrr4xXhJBFhnjvDQHAgW8/ERJx2jVzokUbr5?=
 =?us-ascii?Q?E+bpTRy8+S3c70/cAOhhXId83l7YiAnrcRiGNJT0AGIC/07LN8DyMGbdTYbh?=
 =?us-ascii?Q?Kk0//BhuWIBthDzUg7fgFlrGBzbng1t+V5rg+GTixBngS/xITWMh0POo40Zd?=
 =?us-ascii?Q?N72/fLaIdDD8fEbTVuVXkRgzuXQ+iAcpEPqES8nRfhQbUz8hASGAcVLnmIBs?=
 =?us-ascii?Q?+3w9WWLWTI5dF0g0ExbW4yLhI7FbpUpNb8tccVsMrmB5+4C5PH3dMl6zNL4B?=
 =?us-ascii?Q?zeGFMJx6q3JO46KRv3I4tpuFmOaXkQ7OLVaTvyV42RyhcQrPbjBEP2st37k/?=
 =?us-ascii?Q?hi2Sxvas0SbDhttOWsVDH0juWH8YlGM4/QJVQlns770+kNXacUeIUE4vTCVB?=
 =?us-ascii?Q?PJ0ojinBw6h1HZ8kiticpKZD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qW5Crb7APehtMGePoIprGXtEqdc8giqOe8vKazR0FNEQ0b60OzpfTSwEj92B?=
 =?us-ascii?Q?D3A4xMtVmUlIIqowgTkE6e4KQfTQm+ysl7D9YrW/NuCifBBzlxHyN5OLrJvv?=
 =?us-ascii?Q?6u/rNDfR4SlWSXu/3n1+VOS3r8qSJZY60c3psD1OaPWIPEFfFA79iwyNq2bn?=
 =?us-ascii?Q?Q/vusty6buvtmaAYMwfuxw9f0KAG0LUfu+X7uZFi6nd/EB9lH8oBAA4unhFG?=
 =?us-ascii?Q?ihSMkceJ91SOmQ9Pr9DjvVh+dzL3oAoSEaD4nBiIq644N0j0bU0V6yBO7d20?=
 =?us-ascii?Q?TMBrwvDIBjpsfoSXtJ+fpuoXfkRLq/swRIlV+Vw4hapux6rxYizrjP7R/VQc?=
 =?us-ascii?Q?DHEXaWSSRq4oJkoQdTEySa0F+6E2028AqAoo1Dy/BJ6t64RkT7mKWJDHA/pL?=
 =?us-ascii?Q?2BOyL5WP9C32yq8w+jd3gCuTLGNio2QzsB6mrNgBomAsZ2U7drgRQdjpGINM?=
 =?us-ascii?Q?aUz6R5VIofkw1+eNHBIMICMnuVwF5tPLqDe13oJI8C3HBnKnZKnFHiZpl8TJ?=
 =?us-ascii?Q?qrTFL4jyKk0p6y4tPi3Y/4YmRCWSFEwksVzgQWi9wPh9bp1f6+LoYrAV7tc/?=
 =?us-ascii?Q?BO/74npjPN0Z11Kj+G2skjwGOUSQQ8XbWDhsnqftY2HBlehgrb3NNrbE+w5a?=
 =?us-ascii?Q?thuT7/NNdGBpUVFYyxC2+76X9BMkeSYL5SCOmmy1Jy4p2RUVF1fUZdy5MxGu?=
 =?us-ascii?Q?fqnwx2ZRSPNSIOdhQ221UV1XJJtcej3Lt0IUvwovApXJJMqoThSmTZvlT/au?=
 =?us-ascii?Q?0Fl9VsAiXulB7jd5HxjgoX9HSoaxbm62ycJlTvtiTorVOUFDGVviyfwGwyWA?=
 =?us-ascii?Q?2JPpD0Zrolv+AKjITQDW8z9GInA1vP4uML86jlJZ6HNw4f2Rke7TNQvZvllF?=
 =?us-ascii?Q?myon1wCQm97h/JQ7Bh7EQJ/ODQ2tiAH9m17J5nK685rI1wTPIyl740yrW7Wl?=
 =?us-ascii?Q?rQteUWmR5rDfUZLYVzUBU7br3A2D3xKEWbXX5C07ZzFasnxOqL1Y/X0KG8OF?=
 =?us-ascii?Q?lGcSbUDuO6c5W0AgJSAJCsZURiCFVddI8j0nB3An4T1rgqKLmGM/ExirONcC?=
 =?us-ascii?Q?LNUMWV3UFrK/btdotZVDWbutwF/hwYn3YD58IstCC/iG4AaEjnb9aP/Z+FGf?=
 =?us-ascii?Q?xm5lo2ETPpcJjLkjHLZbq7Ms13JHMBZ4ftYvN/Qt8666PLtcWdK9kUn3bzBD?=
 =?us-ascii?Q?HcJ7A86OpDTN8Kp6DnVyr5QXRhgU9IsDKW7eX4hGt5c0IwoMSC2OV+VagGHM?=
 =?us-ascii?Q?X84chBz7+oZdpSWtGaX2vfjAV4BoLN1zHoduZXQ0EmltPwin6cSe8On+I522?=
 =?us-ascii?Q?e3UTfjthhmUsn0yjKumRVsI8PbsPdRk6eQL/h4qGaqInXX6D1llXQdi5Adzl?=
 =?us-ascii?Q?KKyfbIOuBvvWE4gEFNo2ohlPkR4sltnyiBwHc6ckNl0HGHTqRemTr5IJfcEz?=
 =?us-ascii?Q?wtemncGhu5M/JlQVzL/C0KkxaCrcbjtjHeaHX6Un9p2XqMrDweldxYYRKbYV?=
 =?us-ascii?Q?iCLPuAmX/L9Ah2CBJGk8vmoVneqdlyOc1UK7XE3UNu+eJun/CrOjhPyzdLlv?=
 =?us-ascii?Q?GfhjOXybXHYFiDGkjz+QsQoOvcTMexBjaL90cPrZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26de2025-96fa-482b-bc6e-08dc860ee190
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:56:05.5492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgM3ryxZlRAP6uwqbh/3uHQ/ALt/8+KUXA4pvK05d5VhR/KnPLHYzojgJ3XhoBCQ8nhyjdm6Zen/ARSpPYSCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

Hello,

On Mon, Jun 03, 2024 at 02:07:41PM +0300, Anastasia Belova wrote:
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Thank you for the patch. Indeed we should be checking if the policy is
valid before dereferencing it.

> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1b7e82a0ad2e..672cb6c280a4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -621,6 +621,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	unsigned long max_perf, min_perf, des_perf,
>  		      cap_perf, lowest_nonlinear_perf, max_freq;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;

This patch mixes code and declarations. While I personally don't
prefer that, since we have moved to using C99, the compiler does
not complain, nor does checkpatch complain.

So is this ok for cpufreq, Rafael?

Or would you prefer something like:

	unsigned long cap_perf, lowest_nonlinear_perf;
	unsigned long max_perf, min_perf, des_perf;
	struct cpufreq_policy *policy;
	struct amd_cpudata *cpudata;
	unsigned int target_freq;
	unsigned long max_freq;

	policy = cpufreq_cpu_get(cpu);
	if (!policy)
		return;

	cpudata = policy->driver_data;



>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	unsigned int target_freq;
>  
> @@ -777,6 +779,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  static void amd_pstate_update_limits(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return;

Ditto.

>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u32 prev_high = 0, cur_high = 0;
>  	int ret;
> -- 
> 2.30.2
> 

--
Thanks and Regards
gautham.

