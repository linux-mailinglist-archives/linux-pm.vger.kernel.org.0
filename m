Return-Path: <linux-pm+bounces-18681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A329E674F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F81418842D5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C784195FCE;
	Fri,  6 Dec 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rM7lbAjl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD22F855;
	Fri,  6 Dec 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466779; cv=fail; b=N2WW5aphm/qfTmCKp0ueAY3qhQf523zlanCFxlCuYIIwVByJR27J/hcBzL2pDdkF7qNnqRTJeBpjFtw4h1hTYETwus1nBJa910MV0hag7M7ZBbanbYyyc7Ys6JDVMVhUzsSLhHSLRRNnHu8Gt8RTyK+iktPaulAZYwLH+/6AuXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466779; c=relaxed/simple;
	bh=RtBHbdNPhqrzYA6hVqwg5gF9biRQNjQ/LzK7L3sr0aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7eTGQdyczxJIsmq1mAUp4XfkjxwTJDgE+fjm3td48IZSIX1g6spDoWCl2mRkR3LmiRrQG6yfBVrm0kxTnMuJsLGbTT+T8MuVDJ0DkXsAfs2xVpL8Qjc+Hb95N2drHx9Z/0bHv8gOi6LVZKjsdQUEBDZ0S9RPX3s5eEFGI59JQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rM7lbAjl; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+flM/Is12GcqBD4riHnV4SO0zApGT4+BlaYugSkBt6IK/nRdlUTB0Y1xgEQGPp64frOuL7EpG5VXC+FQcPSFeVx7dpnMyyQ18jyY55XV/eG/A+J4KEYjWkkKxlEMHdWPjMk6+OZhVnVtP6mY1v7MU8aKmJ5fBHDTRdemK4uLDzje38fgO2MHETX0FVG7aJhA+f+pQmFaQiAAOqwvf28uPdAVj4rB75DEVaxjow89q+GO+HTn3SLPsc309iH9hMVrplMOrYY9xiesXGvOGyFl+UJBRfbS3CytYLzUxZdrwZx0AXDJo9bn4ju2WLDdyETSGIQLoEzn2SedOAHSs1qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2yv1LDPw+6gH6qJgBqlJ5Zn+w5BtzT0zxtd7IA+NOo=;
 b=xsRzTJkhgaYRSGepATv77Iw1yXibq34QS5kq6HxYfgls0bM9peuUlKBOQ7gzn9g9VdYDnFhRRtkKED+FHcTcqHMDtlab2XebW0iLWxboGl6RsmMZAMftjZwHDFTm0ObLBpFGseobRRbvil4DNXIBskkb1EJQ0/ksiKdsrNGl5yjMwh0+5CV7DvL3M8tT9c7g+JQAXPIMqkm6YmRv+q0ndyexdenWMjrWsre9rzfa90XX2jiIG4JKhem6zB8DkR6WSkz3JFmvr4GTnNavsGA2THfnqR0WYzSfhxZe7+qySw69E13dRgEQudNFeLOoIaOpf00h3XoFhBtIsXow4jFIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2yv1LDPw+6gH6qJgBqlJ5Zn+w5BtzT0zxtd7IA+NOo=;
 b=rM7lbAjl3T+95v2UK2BHWim5xYqSFlxzNgvvFdxLJsiQjsJ5ThrbOzwDImJa7bL7Ee5HnmQEFcKvq5F2MKBMlCNSm/qpwx+QR44M66fJvHR2kkk/F/+VPwYU6aYg9uZr7PHZJR2S+jr+E9njSDIBR4gKnJ9SCbWYYsemnWnf1mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.23; Fri, 6 Dec 2024 06:32:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:32:54 +0000
Date: Fri, 6 Dec 2024 12:02:47 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 07/15] cpufreq/amd-pstate: Only update the cached value
 in msr_set_epp() on success
Message-ID: <Z1Kaj7zUiYcgCGUj@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-8-mario.limonciello@amd.com>
X-ClientProxiedBy: PN0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0369cc-ec4f-4483-4b3f-08dd15bfd0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXs0zK/24/UXapsEwONI6uoEdMPpa5XPLh44s4uMv9zv6Ukb5QOkKoJHo4NN?=
 =?us-ascii?Q?6v5gjhHJy1GjTL6Jsn/GSjrdUYENpSX3D9GqpzgZNv7H37eBMMOFUi/S9lvD?=
 =?us-ascii?Q?fD4Wd82p8+MVSK6n7K8e0FaUhbiuFLG3mR08yHXHuKTo7bFpdN0iZQZIk60X?=
 =?us-ascii?Q?k0Vg7G3VSNYIES6LMrBtUxwpzbPe1lY82iDstBaU+IjlE5Y7dphX5szuXP1K?=
 =?us-ascii?Q?xo/D5SngfotKIRzzkLisjVD6Joo7V+Q23oaChXZGOFOf1WGR3eqPD/L6ZINK?=
 =?us-ascii?Q?e5Hjh2pHoq0Hs+Dj55ey0L5InJ09JgSgcu5JTG7jYb210XolFhUtojRKnB9b?=
 =?us-ascii?Q?p0ZXtYu35+FQaNpI/BkWKv+0nMWf7jgr6kVa8vadUQGo+RzKbLwnG1TRqfhJ?=
 =?us-ascii?Q?QYyCPj/gm4ch64G3Zrp5KASqr/eeui3Jc46ve4X08dvYCzfETcguTD45P2kq?=
 =?us-ascii?Q?ea3GhszKQyzbJuBn/PJoluFAqvL9hF3k34wi2pVVE3Yl+ARdCgZzdt0LSbJu?=
 =?us-ascii?Q?i+1fE/0E86K/dKAv6WFos+OcoPMKuv1xgNSqzGzl3qI8zR8tXX4bo+ZZoCQA?=
 =?us-ascii?Q?xrKHBqLCjDtpV6XYPg5nJ7jMTMjEkiXJLutZZSkWbrVC3gO8mbS3Q9C0ftew?=
 =?us-ascii?Q?UmSBaKMse0whL1JMcgm6yPOzCz21i8ChNw9OQAOStnHiN/EUYWDzDsGNTZG/?=
 =?us-ascii?Q?ffnJbty9nVfCsReQwPFIsz9Wkv3jY6rsH2wtE0YIeJiNjhCbEYCqniZcoBTe?=
 =?us-ascii?Q?JSekkY9ur6lCxrvFFBEy8dJAfMlglmawLOnDnGYGLZz1isr34hcJ1DZw1XoZ?=
 =?us-ascii?Q?bCV1ucqKYDAC6d501xaa0gGa6sO1VwefxyCzJZ5S1Mfy8xMTUGS8LyzwgDOx?=
 =?us-ascii?Q?dvU1pQDPQxAyogxe75pg1g9TvcpNKEB9xNv0ksNySysVBM36qmf5yzjpUuO1?=
 =?us-ascii?Q?8RHxZcrsbA6B3ijPEXOPMy/n7uHFr9dGlUqQmiA81vtiptyx0bwVjl9MjeA2?=
 =?us-ascii?Q?iyXYrTgjPxpPHRE9ZajLDCX8EMXbF6cGosqVhXRyLt9t+GxSrbV+4C13l+Rs?=
 =?us-ascii?Q?yrClNIYOj7w+VlrKJzg21nU2gEv1drbv0KPPF57zqiChhR/91AIQHGhmMnBI?=
 =?us-ascii?Q?LN4AljsJmtJBZMIsftjQ7PNoHgbq0qPcBZfT2F4uFXxROq7p4DBq9Y/RvQMj?=
 =?us-ascii?Q?JO3EQYe9OT7C8W/36HrARABTkXfI5rmjJhE/v8BkuZPWOIIiGFpGi8Hawyw0?=
 =?us-ascii?Q?QsPPwXbjmlx+lIKxM1d/XiTRdbFylVGRFNM1J+WyCmfs5435T+xpLzZR57d2?=
 =?us-ascii?Q?J2Qv6tGhBqWFOgeRDy4vpiy0bjySpm9ENFWN69ipcvPDwKqQqVLe/aRhEWS8?=
 =?us-ascii?Q?2AvcWcM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZGquuEiSc6R9FUsun3X/5NnUwzQindZzCjdip2PGsTcOp9YnlfbDvPrsfBP?=
 =?us-ascii?Q?8e/qg0CMNruAUSzL5lmX4h7w6fr5jO+GnR09QvVSex/mOjSFWO7itOwqQhfj?=
 =?us-ascii?Q?HF4zOHs/5MKI2xpy/Kp04JQzfn0ubKBrkSF7I/7L9RYGaMEQoolldPEUWtQP?=
 =?us-ascii?Q?fL9ANXtMSCXqOO6Ru/ykMEFrBwOPcsvmU0JHSptlGiH300PucSS20pMvVBml?=
 =?us-ascii?Q?xpY5n5OD0rZZX9W4eSnvz3NkHkNuA1kDoDcjdgxkgcez15d/Ta3ybSYwab42?=
 =?us-ascii?Q?cbJaCk7NAKbd3qmrZRqjJ+J0KNt5MDTPaeLDFhzSeq09NkJQVnfFxTBq6+G/?=
 =?us-ascii?Q?/PeKU52T+Md8NIf5engnktXn5b3CeHE0ddGa0R+r6i2p/a/3D289K/Vl0dk5?=
 =?us-ascii?Q?JDLiVvsTIzyMCHzEaAMPsF/5ET8Iup3hyoQdIPqx1Fn6+P9zwu5e4MUCmOxh?=
 =?us-ascii?Q?sSqVqApPzQw547IEPk/jSrP49hwbSTL+Oadkf4/Anm0XNKlBACRV3DFkBy1v?=
 =?us-ascii?Q?KMS3wePc/fcc0MCNbyl6dzEPhNQdfDHmJgT083iW85S3c8ocdCbhGdsC7WMw?=
 =?us-ascii?Q?keHesGo7T1u+NuBonlGahGDCjTUSgLNM+M3pjabz/5EyXC60LlsU4DKKwHlw?=
 =?us-ascii?Q?HjT6tzUy4C2Rkq/yMfnD1K42ti9V9G08lAFuuvSt2wAyve485pQuvZsVj9J0?=
 =?us-ascii?Q?0HAP/MCPaqG+0hN9KzftdmN71h7qrFg/7Xut8aaB6cTYhD+2tyVUnFhzuZNi?=
 =?us-ascii?Q?E2fT/f6LOo07/KQ7RoE33orIk4zUX2I15njm7Mh1Q3Zh8F5pBv7QNGwjRHle?=
 =?us-ascii?Q?j7WN3ShrdTcIxNcoI/YsWRz3E1ijbqat13ecNmrvvC9PymqNcEhqxnxF2wAX?=
 =?us-ascii?Q?nOIHGEG7IPh6cjH1kuKudCw82CvPriN9DmaqFrXwoNSSduh0DwUGEQY2ec+F?=
 =?us-ascii?Q?0SOj8HeeGpDy+ZofzAp73Lolfd1xNpAzmSCYspOHXxT3bvF7KBmj/eun/cmN?=
 =?us-ascii?Q?gdDf87019RFgqirnNIPGkzQg+m5H239lrC4w4rhK87qpy+aximc0ZZgAqdUc?=
 =?us-ascii?Q?ipSuPGUEryM8lVoDslCaZRoFA1/YhN1ur10k0nYAZYZR5nnIo1xecp8sO5DS?=
 =?us-ascii?Q?dzjR2NnRoYPTs6sd3EIuBQUdesVfcbc3aW+uPjzSZFWI5GlGcMqY17jTZlxa?=
 =?us-ascii?Q?/L/ds1fOYl15ozBvxvO/ExOuRbmrQ/5psDzZ6sJxLrUlVmjM1DNfmY51QLYz?=
 =?us-ascii?Q?TfITARyLMahY8T3L2WXmIPGjZIwKmpjJS6t8Z0F8+Hi1JlGCBuZ7Q1fn4nqY?=
 =?us-ascii?Q?ZoUPVgtuAQRpylzhQcAjbMYlpxmkvRTwMQFdcH9Lq/DGu0TbgFZ1Ndbaq/ji?=
 =?us-ascii?Q?CS/CLpNNhYoK5THUXfaex3TIMphngJzwnRa0c1SI65I/03asdDSXJOPsgYZ1?=
 =?us-ascii?Q?g49fQ+TT0y3vMSoqUA/SO7n57kJyEdH+erbpHaERucE2OkyFroQICICii7rv?=
 =?us-ascii?Q?PUXz+PKzEXbM5TsNA3mlDxmyy73v2e7sv7rXcSZ8jfW1F8SjxV5boEafDCuq?=
 =?us-ascii?Q?UCjHjOJzagpAFV8235i+/012aotYpiDPCaAN5iQf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0369cc-ec4f-4483-4b3f-08dd15bfd0ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:32:54.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCqJkYUQPlj/IdHm6N+cDMhNzgUDbnapjauvmwKmyc3dq50ZQ5Kcd1ttkq5MZNsaYZjikWnsMONPnAxRwoHSJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

On Thu, Dec 05, 2024 at 04:28:39PM -0600, Mario Limonciello wrote:
> If writing the MSR MSR_AMD_CPPC_REQ fails then the cached value in the
> amd_cpudata structure should not be updated.

Considering that the remote MSR update can fail only if either the
cpudata->cpu is invalid or if that CPU is not online, this is the
right thing to do.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.



> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 14bd6faa3d730..ce70d1bfa55d0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -278,11 +278,15 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  
>  	value &= ~AMD_PSTATE_EPP_PERF_MASK;
>  	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> -	if (!ret)
> -		cpudata->epp_cached = epp;
> +	if (ret) {
> +		pr_err("failed to set energy perf value (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	cpudata->epp_cached = epp;
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

