Return-Path: <linux-pm+bounces-22454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC03A3C392
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD6A173AB1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB841F419E;
	Wed, 19 Feb 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2UmZFbhv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB81E885;
	Wed, 19 Feb 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978769; cv=fail; b=X73uK01A6VMQOxWCv9HB3UZ7NRMhm8cKcHkcagq25PHLgMTNeDJk/Cm9RpFeyyfYUsZPzim+sR7Hd7TIkh7nEO3L0gkTnyGaOl7yrQaCdVd3glGe15af4rF8z9TjmxUZshuKf4Qi9wo/fmnDYl39+3LUOwF31Zxbo0kg7P8GmMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978769; c=relaxed/simple;
	bh=VsRN+WCYdRx3JSFKg20CVnSKzEceso6YyF2WVJ/Ak10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MQ9brojbvOS8M41hFAj6and6IdIRQE2ZQmUqF0wdeHG+mBRlHblXbZ4riqjO8+Qwfzl+n4mwFBkLtvWvzLtgdcUfij+kjUbK8+aDv61LcfUjcSk9g56PlyNkFlgrbzZxTv0HR9kyxQx4ghwOcCSUUMCtX3WMt7JCCNEvhSiUcU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2UmZFbhv; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0ufXBU6H7AFxDoRac8UjY09nTYRNqXOpsdeQWO0Kco+MIydAKyBx0+08JIhhoLdfPRU1jLQGS/44DYoMHhfLS1zZFHgcxWXH7E0t6cNivAcKBZeXaht4sOh1MCWWMMn6bwBqBNwwnngB40spiDeAgKEhmz4+i5NhVdEI8NFAyt0rwqJdMsyP6sTOOBdhFZ5vvXw17LZ8Zb6MtCPBLUkKOgsBVmRcbj0n6Dre0SKfGqnB59qYKeWYsLH9aBVcZOAWl0AKdZH+qjC58zbe63Q6PvtSV+iyHvMzcg5GIk8uss7f/MdBjVpy7gLogdRmcEtJkiXPciMEjMHUOzdZ8cFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRIQBEaVLEF431nq4fyGm3rrcj2s3qdaoEK6N5RUWJo=;
 b=mnKplg7fw0TSDzllvzeVxA8B7CZfF7mSR/99YeAO81OYihQFYgVTllSeItwqxaCd3Z4HLtWeb1IZh4Z4M7hqKieBXDcCJka6RzPwqovFEHIfadGbPEhAXsA9j7emuQWGI1N/SOYd82NFM44QhSbktvg7+smO+19d7o7CZwXgX2cXWBR/6NY0Yn7rGEGl8RsqsI+yPx9TbyHtMkKnoYMUxwNz9Gw1TqwWz6ludjllPaX7qDecq9tcgXVr6f1xzLEke+4TerZvSgHnl2pHkA/GjWq7dTP7yS8Pcg+4AthJXTqH9qq54GegoC1goNjIxRmZskdkdNPoRvw1Z85R2XEb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRIQBEaVLEF431nq4fyGm3rrcj2s3qdaoEK6N5RUWJo=;
 b=2UmZFbhvTlgne13HTz4Vm9Yy+bdaoIg2vuPtqK56d8YHrxmHpJo+xO28B+MI3vSG6AYlOBTOtW9KkRSxtHc6CvAA44QfLPTgDLSADjHUMORTEVemCNH3rfFyccIwvVqHfn8gxOc9cPCIA7Mm+/F7Gp7oLmBINuCCs58j3EgxDz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Wed, 19 Feb 2025 15:26:06 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:26:06 +0000
Date: Wed, 19 Feb 2025 20:55:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 17/18] cpufreq/amd-pstate: Rework CPPC enabling
Message-ID: <Z7X4BfEAbRwCg2Dg@BLRRASHENOY1.amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-18-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217220707.1468365-18-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: b4905b0d-592a-48c0-221a-08dd50f9ba29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6AIN4/lHhtxUXBCTND22Fht3bUD1dDIVUXryrZa3hFQjUnH0OuEnbKtT5/p?=
 =?us-ascii?Q?oXNRQkL97plae9qDNu24CJZ3vk9XT/lBbbh1lGybVjrfWNqBC1/90+zL5Zn7?=
 =?us-ascii?Q?UYKKa0dHMBPpeMvAwPBUmNk+sMQyLe9lYzA1G1MPixIlAqU9SRMn4jo641vh?=
 =?us-ascii?Q?QLi4U+MYrGIJVOC6ym6MSnX3NtMZ+cNCjBWJ7ORx4GoG7I2+mKjLFjxvuRob?=
 =?us-ascii?Q?J1YH2dnlpypdM23CR2iwBxuWfuNuGazFGMcZV92uqRi0iauMMwdXWFuJkulL?=
 =?us-ascii?Q?4nz0HYKkaDRylb9cos2ySPj7/rCc3TvqrSuOnVdTuLvpPczQfPpeQt4LewrP?=
 =?us-ascii?Q?p+hdX4yp3TlpZheM4c5SvvSnOtClIZaZcW9ARDFxhN4SW6xqKMD2lirRfrJn?=
 =?us-ascii?Q?PFxhAPwEchNr6II28+8gVXi+tmFqnvkRv0G/cdZl8Sw2b5Ff2qerwBKn04V0?=
 =?us-ascii?Q?AW9BDJr92+SEUmY3g/4bcjdzrGbN481esiQolhCIXMh5oaeP93gGDUnj+PJe?=
 =?us-ascii?Q?Id4MB2+hiTaRS6o7TS3Z4D9GSGvxfjusdiMjXt8+hYEGe7PXU0jfqztuJMKs?=
 =?us-ascii?Q?6i+VYMhFrkVgKSqvEzJ3Dq5SlSVQZf2ir2eY7tyBBAb4zH0hx5BMJE9GgQIJ?=
 =?us-ascii?Q?4XLfA7rg+bd/lktPnkmykOKkxTRzdtIwbtxM7P0U7d9Ul0/jRk7zpp3nO5/c?=
 =?us-ascii?Q?4Mgh8V+KHXpOny3GEcAo4hdursx2d4EANN/xwz0hA6lRi+7VnsIv9TBMmJ9H?=
 =?us-ascii?Q?ELW/w1J8NaPD10UhJDEToAP2QVEQ8rGB6x4h0LCG7HrNVdLlSkIbq/umhVms?=
 =?us-ascii?Q?ASuRGQmz+Ul3f3sQUAP0RD6rtrzUwUQTWaKeIjleYuy9JajPb7qPDPEg+lGP?=
 =?us-ascii?Q?BVsUvfXE1c4xyN+9tAyMhr8SXaXxO3cKfy6rq7D+KFF9N6HzAVY1Hm0rePyi?=
 =?us-ascii?Q?2Pgz/W3omfPk5vJL78OLJ0nKye++Ft83qbFQ/kS0LKW18k8GQTrNqyZ+hrJr?=
 =?us-ascii?Q?ljjCMN6b+buU+3g2y16fGs9E1+PrOduL4ljfPoXqpN11BqYpHXc33hRgW8LR?=
 =?us-ascii?Q?+sNjc/Nzuf09RJqxhitoRrCX6yKFiQrNwR3+gy2dUlO501jRPubSdV8LJcjS?=
 =?us-ascii?Q?aRfx08HmvvK46kQi5qJLkDYI5eKOm3T/uMn1e6xA9zAizwV/k36xr3rzUIrk?=
 =?us-ascii?Q?J0oLPqd2l0mo0s6gLp46Mw1YsbF2/scS9lgSksD5SXlGm6tDR7hs2QkzTG6O?=
 =?us-ascii?Q?llftEkZ9zLXl8uYELn/FHOkKr73tXIOjQ2KeeU84QGonCpaa4ABDIlnyNwFY?=
 =?us-ascii?Q?S0qJPwzST4bBsfjWrFd4aeV5sfUx0D8bQAfohxpjkV2p18/EpevPEG/yQzZA?=
 =?us-ascii?Q?rugCCfZQ9uO+Z1mjk+t7KR6ZvGwj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFHmJNJ+T/lMhp7283vXX9EaEj9xofTrezZvsTJjQie9LKcrQPtLhGG3Y7o7?=
 =?us-ascii?Q?RjIPxHL2cmvynwupKptwY+2zV+/Fat6NDaleVrUKDoVApnchsfaHsMh9NP14?=
 =?us-ascii?Q?aj8fsjC0PvGltbJa9yDKboMP5ZER+LttV435NRiyd9eKZepqzPkl9s3jfKfl?=
 =?us-ascii?Q?n09n/8FhUu9J7PrKuYRCDiSR2OmpCCodg/YwzfOItJZ1csg4Ib3zRHEHC75I?=
 =?us-ascii?Q?zLJJt9rJ/tu/1ZG8WfMo8EZz3fakGH6uVZuXtiKVLnrEKPLUY6dueXe60C6h?=
 =?us-ascii?Q?12TYgwumwS20wuSaetKtSdKBrnYyTAbF7hR4Jiw5GIC9WFrwv+nch+KRAs8p?=
 =?us-ascii?Q?RjuM7xnzlNahSsvmiUdfp2yy/D7zR3tFx5gDnx59qHg1zvL57V7BhgAEVFXx?=
 =?us-ascii?Q?1ytgKOdRdfyx7+lVj0QQ+To6M/OIKt8juJcbdGqT2f4Vu4U+ufpkg4oPdAqN?=
 =?us-ascii?Q?yccBqguZxkU16Wzt/+B3eHxml/HtHOIpE8I9R452cbEgvvTg3eV3sUTprfI5?=
 =?us-ascii?Q?kzALlZmCrvq0YQvrclyHESakNxqL6ETrshoYWPVI9FVB07xP+sesfWRSr4fS?=
 =?us-ascii?Q?SgCAK4gYK/9vzJLCpLtZ0avJ68RYAfKRhPsACyGCW2o0XMU+XDR63AZmjTFx?=
 =?us-ascii?Q?AUdLNyM2/vADyRPQ0U8s2pYmzhO4UwvEb93oV+Z+H6fYm4cpzPIuU2ElhOEH?=
 =?us-ascii?Q?AwE48izQqiRMk+BNDmcnH3yCRhQ4LSMUMaSAVWIfi1NFfWlnjiXcbq9fo8CP?=
 =?us-ascii?Q?fNgRv3USBHiZ72QtS2tPyz09bLARjXlSA+IEeZcNdNTXhCwCqSCWMi23yWy7?=
 =?us-ascii?Q?gpLt8L/pXQDL/XatJ9N7iC4i3ccaCUcaFwujC1q5pgK7zws4zrSxxjww2bxW?=
 =?us-ascii?Q?3ptrY0C7+Oa9jhTaWz/s64g+cdhWSeKp091gvLyYkIPrnvcqpRT0gppiWDMk?=
 =?us-ascii?Q?w5JR6c00PCVGyCYsCBgFOc4J5plA0ba8B7rTPh8Xp6h2zbuSCXH1tihOdOU3?=
 =?us-ascii?Q?LZVqrslHhELj6Q74XmQleK9bPOVzZ+M26D/uV+xzU52BZqVqMtZHIzEgK4ge?=
 =?us-ascii?Q?DmYQhY8v/J0cXAdK2T2euBuXoemleSqKZrxXSJnAx9FpEyF7ZWAQqyvnY32g?=
 =?us-ascii?Q?VGrhlcKeWgXEz30ACpxfi/GmYzqMsT2mMiihrgbB3Qf3C6LFwoeaC99dq/UI?=
 =?us-ascii?Q?paz78/K4ohYPBx7yJXMp4U+berBcR9tsauwZWW8oq7N4/bZt0XovyxkuAotg?=
 =?us-ascii?Q?DMnq/ju+N7DQJ07yHF13zkKrCu1RDdweTvMhSO2GN5jcbrS2gv0Bu7riWHry?=
 =?us-ascii?Q?bFXMQjT69j0vTTWJmtOZNL/TL5DP66u5Uwt+E/c6UHP0wD36KFb+x2ioWw+J?=
 =?us-ascii?Q?XyvUM8c2hKuvMy3XagFoqJ0ppLPDyaKXxrvFBXalFrLnEHjJleRua8TM7d3Y?=
 =?us-ascii?Q?JvG7DRq2JYeCB3w9r5BNUtyv1/tWeTfrtI/ZZ6+3m+oHql8QzT0PwDSOS3vu?=
 =?us-ascii?Q?CszoUSIHx42fT0Gw6CaUL2j91UARiNCDOgKFOb3x/aDQMVD0EqbDJbjLA7+m?=
 =?us-ascii?Q?Kyx66+5eGPV8T/w2k6ZRe+FkGWDeCaY0gkxclJgY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4905b0d-592a-48c0-221a-08dd50f9ba29
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:26:05.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XlGorz+3CNmEtuNEX1yt6UR6p7jjdfbrvRhS1jQJEkbVvQo0Egslu33+pj0C26Z7qz9lUoAmksIlRJUZ3GsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

On Mon, Feb 17, 2025 at 04:07:06PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The CPPC enable register is configured as "write once".  That is
> any future writes don't actually do anything.
> 
> Because of this, all the cleanup paths that currently exist for
> CPPC disable are non-effective.
> 
> Rework CPPC enable to only enable after all the CAP registers have
> been read to avoid enabling CPPC on CPUs with invalid _CPC or
> unpopulated MSRs.
> 
> As the register is write once, remove all cleanup paths as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Fixup for suspend/resume issue
> ---
[..snip..]

>  
> -static int shmem_cppc_enable(bool enable)
> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	int cpu, ret = 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	int ret;
>  
> -	if (enable == cppc_enabled)
> -		return 0;
> +	ret = cppc_set_enable(cpudata->cpu, 1);
> +	if (ret)
> +		return ret;
>  
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> +	/* Enable autonomous mode for EPP */
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		/* Set desired perf as zero to allow EPP firmware control */
> +		perf_ctrls.desired_perf = 0;
> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  		if (ret)
>  			return ret;

We don't need the if condition here. There is nothing following this
inside the if block and the function return "ret" soon after coming
out of this if block.


> -
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
>  	}
>  
> -	cppc_enabled = enable;
>  	return ret;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>  
> -static inline int amd_pstate_cppc_enable(bool enable)
[..snip..]

>  
> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	int ret;
>  
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> -
> -
> -	return amd_pstate_epp_update_limit(policy);
> -}
> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> -static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> -{
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		return ret;
>  
> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> -	ret = amd_pstate_epp_reenable(policy);
> +	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);

Previously, when a CPU came online, the callpath would be
amd_pstate_epp_cpu_online(policy)
--> amd_pstate_epp_reenable(policy)
     --> amd_pstate_epp_update_limit(policy)
          --> amd_pstate_epp_update_limit(policy)

which reevaluates the min_perf_limit and max_perf_limit based on
policy->min and policy->max and then calls

      amd_pstate_update_perf(policy, min_limit_perf, 0, max_limit_perf, epp, false)

With this patch, we call

      amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);

which would set CPPC.min_perf to 0.

I guess this should be ok since cpufreq_online() would eventually call
amd_pstate_verify() and amd_pstate_epp_set_policy() which should
re-initialize the the min_limit_perf and max_limit_perf. Though I
haven't verified if the behaviour changes with this patch when the CPU
is offlined and brought back online.

Rest of the patch looks good to me.

-- 
Thanks and Regards
gautham.

