Return-Path: <linux-pm+bounces-22216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8BEA38666
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DC7A33CF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA021D598;
	Mon, 17 Feb 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lba/k3GQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2221661B;
	Mon, 17 Feb 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802684; cv=fail; b=cz2shN/bYi3IdvgEksEdDhhA3q7OZrNsMlWoLUJ7x4snA956zNtDe/sNVVuTxqyYjtv/BtMssubQrIvrDsBA2+f/0yzTezHH7or+5sCz1Duy8wW0n8CJb0ATb7Nx5R/46XQ+51HnWpgI1u0yNrFXFKR9A79IB+kg9i+zMO2tBJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802684; c=relaxed/simple;
	bh=0j+BcC/L/qY5kEJ5tN4Gx5nzJCjZpo8lYoKSgZ6hLTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zu4kyEFW+rriFlKtA4UF7u4UljHsFa9Z3QFG4YvyAeoq8ApYJLm9MZjh/tl+ZTiLMhtn48O6Nq4xZNbhmjBH8aUl/KBAmNbR0doy0hC+A718yXdJVZZrBvGhEnvSFI5nvVF1IJ8gV1kXLAr7qnTz0Z5+i+zxrGM6zjX1C0ykn3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lba/k3GQ; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcMvJkZ8Lq3MJ6bDaW7qUnb7Q18iqUo2nPIrC4oOE1e9W/vCLFZBT6Idfu7N0zYcghuS7ol7EERz12RZoHtKLbSs/QTVF7dvK4Q2KAxPVlu+PNRZNihMQcB/zyLEWtp2Bs0A/p4n9ylZNQugOasrinWgSIGF01YIOGiTCo1et20Xj82f2zbqshJRPKfnPITlSzru6AbT8AhkN0GBxk4NzCnRYWoTsrpvCQRwfcmyt5jyPo+aCoh7xLxw4zPu/DGTCd01LeaYHjWv5KkJrzxQfVaLUYAvdIFPMCNSe9dsguoN20erpFu8n7TpmnKeMo842c4aI9UDNRFu3zXsAXL0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up1OcEGNNmWzrh2dXxDEgf+po7JZOg6K3gxex89Gv28=;
 b=ELn617NWIPUkNC98MahbSmhkN3B4dfpbEqAB7jc05SCE8dvsZ57sDpfhIOgFUS4dasw9JFX681jGNFRqbOtbxip/kLUJCjJKVnreVj4qrOvBoqZsMErR9OgTvBiEnSCsNbExBDlrhwL3q2kgQQV+cNjPAmmDlXNXpZnhoowq3DlAHv402GPEizFkz9TLKSEB1fi3WevQ0oDhZ+1Vjkuwa0Vd/ksv+AO6lI10dRTQoNbK8sqOfc5vzKQCQlbPweAXpW614nund//iP+RZhBOcaaIJmwzWWzHhXJAbnhIQu5tF3jc58I4EjqYoEozeba42KhJtcsCIbt7N+yBkiZaDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up1OcEGNNmWzrh2dXxDEgf+po7JZOg6K3gxex89Gv28=;
 b=lba/k3GQJe3lZQ6T90HddCZA3GoHvl+HhI/cHlOBFC1D6/cYQJGi0Wt9WLDxq96QombsloF/XlEqi4XHFJqjJekVG51xrAIBfstVcJGwsE+CDRl85taCBvONMGZzxbb7Mtzg2tazh0B6MBKozsBsbpmTo+e5q0W4cQ91/PsLlSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 14:31:20 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:31:20 +0000
Date: Mon, 17 Feb 2025 20:01:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 15/17] cpufreq/amd-pstate: Drop debug statements for
 policy setting
Message-ID: <Z7NIMNK6S79fhAer@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-16-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-16-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d570f5-cd67-4aa0-e46f-08dd4f5fbeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ilD6AoMF+oC9eHpFbhZUS2X1B0MIIEz8WABES71jW9Mz3vri/Vcb9IpdfMxc?=
 =?us-ascii?Q?YYMSQKgTiwDGRYXAT7ykof1F/sy3p50472Gp/9DWqgL4h62HywilF9RJpCZv?=
 =?us-ascii?Q?WuZKzXG7Q8Zk5HIy734FdPJ8PMq/BvOwN3je2f5rJAchIf+HDDMzQw5LXOfq?=
 =?us-ascii?Q?GbuQSi2XxgJ+gtoZKAaqh4O6ng2j99+tD43IA5d7ZKJ7nIRKwCavJwDvKepe?=
 =?us-ascii?Q?6VC8f19ZIPiV343lATXldqeDiwIwHfja8AxHbSeKkIG1jslRBELQPpEg5vta?=
 =?us-ascii?Q?G9zUqiNKqR41aXG3Pm33dZiZTz2KlJLsekJO9zF8rnFZ/K3APSwA3KKIqD5+?=
 =?us-ascii?Q?2WQoiR8JaDw9ChaJ9n7sMgKXl0h44oGfOtA2+3zA/l+5cY0AUW6hmyhwQnvj?=
 =?us-ascii?Q?Ep+56ZPfmOxMiVn0F7iAh6GCQiUMB1QXb6Y/FwrlkLpzLZq5fJrr7BlSPhqk?=
 =?us-ascii?Q?RRmbBp3mUZg3BlRetsVaNgc6piO2QUL/3LaNGbd0BhtQcSNiqD6DhEfigwPX?=
 =?us-ascii?Q?B3BAm+470Ev7Gxg2DQW0tMkH7GrAIKLLCwHYY5QvKb8WeSR2FwQWtr/Lz+OE?=
 =?us-ascii?Q?QlYa7Yf+gAozUGAkbZYrqe1yme2YtrNBtYpEKRLHEbBp+7/fa+YHKwH7MmFr?=
 =?us-ascii?Q?WmnJQhOyGLvR/frXUj1gLKxxxpZx1ykcT+FBrrugpotk5sgZSVZdL1ZYuons?=
 =?us-ascii?Q?4me1AnmlFKkFJCTQwHk+cje4Z0rMpVTMU02IvV8qQBnopTy5bJVL1XQGtMB+?=
 =?us-ascii?Q?TN55kFNql9h2JXJF9VjfDNm8UCwovOn3onBVxb1Q5tUlrrfQWXMgpayW4Hcl?=
 =?us-ascii?Q?u/TiiP2KLC96Y6zm1xLw4rjHy8T75vrEwbwG6caY9nlA4dFq/LKXoD/v5+27?=
 =?us-ascii?Q?IoQXpSIsBVQRAgT3fOPu6Es5AbqG6pFag4h41beEp5MJ2hKsRILIZ9UQUE16?=
 =?us-ascii?Q?dHxynzx4FX6vxZ2xbZ65doKLUV0nQLzWpWqNBs2P1d4c3Eq8jeq0DpdOQoFO?=
 =?us-ascii?Q?HUjQUbQf38eWV9uwuIJIAFcJgdLf8KuNpK3HIfGcbFgJsYZYm7CoB/tkOy8g?=
 =?us-ascii?Q?BzjX+IqaxUCmze3r865RUmL9+1MfQng6g9shlcpKvocJong9wthXc0ow2eLT?=
 =?us-ascii?Q?zSr/juGPdR6RcxHIOAC7Oj24XeNyoLF/qsNozbA9sMy8djxdbfEh+6Tku0T/?=
 =?us-ascii?Q?Tw1vrTbXKqjiikmg+vHiiwAb7y3HRVjGJ/bfD7WGnbgbTy2SPzjIecgdYZcJ?=
 =?us-ascii?Q?uIRLExN6AaD6e2RzXeWFKU0CedhD4UFgAU5vYPWeu+qs6Zh9U7b0vtBZSJvF?=
 =?us-ascii?Q?h8CEn0vbMWUrpaAr6Oum7H4dKaEf6zPG0FQQStuEranNVhhA5eMnFl5AKjq8?=
 =?us-ascii?Q?Nvo/7vUpnka4cO30qKnt49c3Vv9z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Qyvu5tTR7Kktfu7zPpH+h2ejlbqult5MfP7/lUiTzo8VpuF6OGKAGY5Gqpy?=
 =?us-ascii?Q?pyZqyN9hUCa15yUQJU4pwqyIdHofUqmXSm17gMYmzpSBu96cAbDRS3c4e3Bz?=
 =?us-ascii?Q?QxlXKB9fH1J4OHH1eWsVYkkKX5FNJfpmxxZz5rfCcK2cOEnf0umU3p1E8U5t?=
 =?us-ascii?Q?Z/cBhmJ/soCc3RpD9EpQvoSx2xpyu6y4wwq9khscWp5mvak+JSdrOQlDfXV/?=
 =?us-ascii?Q?s2eHyO5Bz3OTyntdcq7Tj0gLnGMuoo7rE0bBdyzbjqM3cS47G8aiexhMLTOp?=
 =?us-ascii?Q?ipPfT9A1l7ArBFoat0y4ZIF8sKUUDh+DKG2KodFl47qdOfqkInrpA1Ijjbxt?=
 =?us-ascii?Q?TlUXX5QUSHVsotMk8y1bXB5MMNa8N+n4heuBz9omWHRYagcl1KIpbEZgm3dH?=
 =?us-ascii?Q?R1dyXH4IpXh0eVTk/qzufS88h4UJ25d/lpGtvWMs0b+wLHfaKTQ+OdnhHZ/d?=
 =?us-ascii?Q?5lf3X7VstB2mnDWXFg8MtOVNKkpH5lCtebLxyiDCHE+yKM/lqEgImOdX7xUB?=
 =?us-ascii?Q?VVqxDIqjPGCp5eFrpYIvorOtLg51ioJT1Y4//PB8dpbijeP4QaHdf/+glAja?=
 =?us-ascii?Q?nUFJyew6SQtPEeodDDtywRtX5nHRLS+M4ODSV7gHGptq6KslgKTW6d05g741?=
 =?us-ascii?Q?rFPDGy/IHOhpE6QZqCdA5Zubn1U6Y7cDDdr4641z8WCVjuljzR0Zeh5cdtop?=
 =?us-ascii?Q?LlneWtqLGrjqt4XZmNWLY2LcolhSI2ww1vLRneQauU2D+SGVMrUGXkrDnWoF?=
 =?us-ascii?Q?dJOZOj3JQU9c1BapRJiwgUNLBQ3NIGUrUm/wHIL2KqtPPO4UZo2Z8p5Zil9c?=
 =?us-ascii?Q?OuEZ0dkvJ2a2HvOeefGXP4pN8cp92qTmZDqgZijVfUgzi6qZbIPq+Ax6dYmE?=
 =?us-ascii?Q?gjYnMj11rX1CnkhW5qIBFujyAZlwBQcb4wEmLO1lx70GIZCueaankFAs1H8v?=
 =?us-ascii?Q?ZjTk01nuAPxw2/3emFa72+oRmjASOTi0yuVClygTSZwLx4a3gw4zGaHtQopO?=
 =?us-ascii?Q?/4X0E9FczNzVZJMuOPh/z6ApLf3GyiRBVy08IYxDtcZP1WdkCNkbWI12BRWp?=
 =?us-ascii?Q?65dBSWlFQYFR1kry6WJQWD/Ap0q25ZWt2OkUMhmzMbD0CDe/PI6UF9FEo5/V?=
 =?us-ascii?Q?N8MGzvVJ2goozrspqqYK2qr0njYWnWV2q7Q41vF/CyO7CqQOS2o5pkbvixxs?=
 =?us-ascii?Q?Dmrj7pdgaz7fIGKwHo1NUJ4sOpGxbB6ALeJ90qtf1wsjO8GWiYtzMFfeRM8f?=
 =?us-ascii?Q?ZpsHSgkv5zsMfah4hYaLGAN1kSoKotd9JgtwtHxNyf/z6FRs0rTvIRnAKcqc?=
 =?us-ascii?Q?gvjjBnJ9cPGeNnD1t1O991BJXN9lbHLHcQSCkemuDM9IKUETVDHr+iBckDoF?=
 =?us-ascii?Q?GlEiJxvBdyhlPB6A7qZV/mivtYanizFZwWqoiaP5s2B+xrbFKTtigNQS/NyS?=
 =?us-ascii?Q?mEG8NSliB9AEucLGOdf5uHdZbSvfu0/sSLoNbZ1p3eY6Jj5l2XihPq3D+xsI?=
 =?us-ascii?Q?pQpXgum4r6cniXIg0c2ppp08KpN3aosQsbdEu/g1An5jSDcfjHlFqh24qIPG?=
 =?us-ascii?Q?VEi6cDgPdTzCtMc8n+AkMUthBFekPUPpBywlzi1W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d570f5-cd67-4aa0-e46f-08dd4f5fbeed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:31:20.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0WYwGNBrTMIEGIIiAebYvm8aHK5j6CU13Tvlgd+2VZJH6m4fHpDj9u8DD9uLHAQ4YHkLjI0x1qf9O9tQka/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

On Fri, Feb 14, 2025 at 06:52:42PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> There are trace events that exist now for all amd-pstate modes that
> will output information right before programming to the hardware.
> 
> This makes the existing debug statements unnecessary remaining
> overhead.  Drop them.

Ack.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fd2b559f47c5c..b39bed12b360f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -667,7 +667,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  	}
>  
>  	cpufreq_verify_within_cpu_limits(policy_data);
> -	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>  
>  	return 0;
>  }
> @@ -1632,9 +1631,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
>  
> -	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> -				policy->cpuinfo.max_freq, policy->max);
> -
>  	cpudata->policy = policy->policy;
>  
>  	ret = amd_pstate_epp_update_limit(policy);
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

