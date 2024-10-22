Return-Path: <linux-pm+bounces-16186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864AF9A99F2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FF2283AE6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3FE1448E4;
	Tue, 22 Oct 2024 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4C4OtNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894312C491;
	Tue, 22 Oct 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578970; cv=fail; b=jYotMhfaDM2I5D+KvQXMfL9jVfKkZ7oOQHRt/Upgg0+kd/xSezUCY5WZ1ML+zmM5GMnOf2JeCf+Rwuq1lO3ign5s0puNwjf51nK+KfOhwTYjQbVd/imIGPAtO+f5tWBicGvv2C4F2tn57H1yWXdaZ8jPNjHHfIB03OR30DkHly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578970; c=relaxed/simple;
	bh=CjK9lN9nONI1aM73+dkY5YqlROT61j6oUgFm3yA3rkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=osP/4yXKRi9HhH87VihRDZcN2NHdYSck7cvBl4T31316fwXT9t3mttJDgcnZsEhY/MzY5y0g/WjYr51J3lxpEc1ghXBVcoxISqE5vdB9LGDIljRGgb6eKlVt62ToycECOZN2EdBn0j/+vdCNriaS6ruqTLQGnXaiHIx7/XtD8VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4C4OtNT; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E38m/pziLN0qzm0fdAWcoYGZfYyt+QP93y+LMLvZxrXPneVTnYYLAlF9BNBowKZDpkkPp/pMgZizrrjKoqPcv1hoR9q8q16OX8F9297pfzyQBK1W6vgoTkxR2ZIxrvtLlf/9uP8LUljn0WaBzj15JOsmBErWxJ2/EBd+kMD0fMrDEPncNxK7+ajZ54UWZJUxrNmZZWekb245InfuDEn1he8Eeg/UeZxl/6n1twwpQwQe+TOR04TNEBHAWoUy9deDtlzoPM32KnmOFtxgOYQnz9t8HLCpYPhnjRO752xDoHEOmtEK6kIopdRv95JcOwpeCuSWd+rxrsO/feSlgCN1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0S0Gbga0ID5abtFFw47M1poIVf1oUi1qwrWrM2UZL0=;
 b=VqugJ89nHTrw5aBafS32vYGwg0ZcuLGEAtVg/+adhOS6/ZRxdoa0tA3q2BtRykMrvovYa9cOsVCoJay/t4OFqb/ONDGQxj+8vk+4SMKp17V7VimW7h6TxwOWsXkJXR+JgFa+i6S4FtRhpzKdo9XEa2MXQOzqnoAGjbwZIF4gS8vKb8qbBFSPceTObPzXRvQxEc4met4YKshLlBBkyCuwkdpB+jhE8QAF92+aWUoi0NBV/hjgY5dVMupeXqyg/u8nneWRX9qTB/JRnkKPHPI922cWW71g1AYnR2v8I/UKdCO/YvTF9IKw/mdmCIRJe2EJu4xchU7ngYgZCpB9FLF0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0S0Gbga0ID5abtFFw47M1poIVf1oUi1qwrWrM2UZL0=;
 b=S4C4OtNT0vW9ROJO0fMBRMpjMfh4tPu5NgIBDXZt/+dbs8s/ysHtTUw5D+BzMDOBen5LWtdr4icDH+569dYJP5rw3j09baQRSe7RMv81ph2l+QvOKzZS/hodtnSHyRYGXbhiUWZuF8SXsPqsoUnexumUueVLhnap6xFirxLsSLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Tue, 22 Oct
 2024 06:36:03 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:36:03 +0000
Date: Tue, 22 Oct 2024 12:05:54 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 11/13] cpufreq/amd-pstate: Disable preferred cores on
 designs with workload classification
Message-ID: <ZxdHypzMIW5XW2nI@BLRRASHENOY1.amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-12-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-12-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c367fb-408e-4723-7e8b-08dcf263cc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ye+UGiuIs/3zkONS1PqRge4Hh9bj6BgCPIZwN65eP7t9ByNuvEaiDs3Y3MOx?=
 =?us-ascii?Q?e54XAZldUiXG0et1+vnPtkZpyKB1oFbZSvcMUUmMUR03xKL8ydquY8aaXR5x?=
 =?us-ascii?Q?+sy/jFY9oZD10KOyD4ArdJZElrRbvR6PmPx2If6G5Sn9BGEXYXvI1mPFtY4J?=
 =?us-ascii?Q?j7pl5ZBNsC5PYYg167LQ7g/B1RnReMykNX6cEAkR5U6BsmlJyv6yA6a/tkzB?=
 =?us-ascii?Q?kccGY9Bb8XpJOpYngwuS9g0HVTgNbPCPvAhHTeRNv4JVdk4kF5yZrw2FLYYd?=
 =?us-ascii?Q?QZpmBoQQg9l0l6WighsPd/IjXpUdmoRvln/K0FJc1Fwk7W5FILx2bBUQHayE?=
 =?us-ascii?Q?Lg7EVcSxjIzISCtBv2okhBfM/euGlOky4SCkLJXdFVYJM9KSIis8Q7rfYNPh?=
 =?us-ascii?Q?WwwMuZngjfsUzfn5FSTdrOzQTZlAdBN7PWfUYCQiztNGbEpq9T+RzzBoHbUe?=
 =?us-ascii?Q?yAJQKmnKDRPc02DVxLljM3Dxxk/D7NKEnwrjztazDFTzO4kfmSlPG0L4vOW/?=
 =?us-ascii?Q?OFBcidLyKxVsZ81XOx1ULqexm1Ty/0VCKKqk9fWeFYKYjLabO0Gd49LjGgCx?=
 =?us-ascii?Q?pdPMlWvUU7bSSjNu8iRfZNdwehB0eBUf1p2z6QY2nGKGCWIXNPIPsneUf/J6?=
 =?us-ascii?Q?9brpJBzs52OR4B4HwUZaEj4gJPt8TKClvAt28nEK3A1whVRGWxIO5suzutFo?=
 =?us-ascii?Q?u4tsbq3TfkU5iLaCPgZtU4MRPHOdh3LCHGHj9YouU3DL2KXYkeJIj5l/9qYy?=
 =?us-ascii?Q?w6NJAVALD7+Pp/quUk5gcKkX07GhARnnecC4traGuYXdHWaH3zIQn4JL1J8h?=
 =?us-ascii?Q?4gNkAZc6EKR/gEuc1j5+EWpccfmyc0U4Z0CRryv9tUIfCFNFPonKSn96bB0t?=
 =?us-ascii?Q?IzTSNzVZyAEQRE7TY0o+00BWiuVGfBxC6Y5iS9V2vqlZdUp3IBzMkvv+wiIt?=
 =?us-ascii?Q?dusaT26UZeYrYoX2wlq6m1SQtY78r0kM/wHp0Y+RmFnFb+OrWuvTOupS+On9?=
 =?us-ascii?Q?/S/TWyRM0rjgkuuarIjnL0FSqVEj8SlaFAp4E6mSEGFsl41u6PCnUgC5dn5c?=
 =?us-ascii?Q?VoI0ANE9W8A/SVcOV7o8kjzFflMTc3hFXNLdirICYUM1g79kT2p4U/RJWafH?=
 =?us-ascii?Q?Xu/tD0c1uPBMVByNQviqCdrcKIuQ3MbeAnexemOS2Nb5dyNFAqVYsHehNPXv?=
 =?us-ascii?Q?2YnVCXJbodFwNnptMqxD1mtDuzv0P8vwKryE9FnSVmMLgJ6v8ewcSlkgl8BY?=
 =?us-ascii?Q?wlg8GjHVZO3PFwqWICiuape1wqwG5VauBBcOBxbWUANq4HgvFqSQwBUI+Skl?=
 =?us-ascii?Q?+FqzFsPN8taTmwObFhx9sxdF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVp25Q228yzDAb5NIIW4bif1XzTWn0TKwfFbDu5+xgA6Ns7zYMAeGEiKw9RJ?=
 =?us-ascii?Q?H/vhZpU/6FvvpCkcK04y8LZZsyhS0oH/wJIoCoC57vT5xLE0t3iP0MXOzpsz?=
 =?us-ascii?Q?6qEAUuS1iMQuCJR8iMOcX+lU23V9gQlAs0wZJW6BRbZ58dFAtxq93qIWTWbc?=
 =?us-ascii?Q?mNBMV1Kyv959H8Bu6PuncOHkBLYkmu0g3xHoEHLHPaAoL4COdUC4/8k5GKha?=
 =?us-ascii?Q?03ha0v5IhbkzN7Rzg96rhZyChsHaPOyolb84xnqHS8VHMELC2kIcJ+lsY5qD?=
 =?us-ascii?Q?M0n9kGQOW+Wfj/KoV4kdkjpszjHCc5X4W3r1S/6HLGDHSl4glALu37SQI1GQ?=
 =?us-ascii?Q?L1XoOFuyFdIrJdeZKM0Zb+sHLl8FTqDp9RSSmwm96hPAL0Du9oSPNfTkLPzC?=
 =?us-ascii?Q?FXQVbkEhuJG+ObLFpRFn/GsHKnV3UXE37skSFjBge0blQOGZ92hLizjdbKKe?=
 =?us-ascii?Q?YW6OYPJCnkmUAodMqG/Q/QRPxc08qXnq5pV2HzXolWpzyZXuupwEIfl0kl0n?=
 =?us-ascii?Q?sxBOTKFo5aZK2kYAhYpUJSN1+A2iaMV0y6j5xMTVRw+UnTSKMv4Q5JhSu6i0?=
 =?us-ascii?Q?CYh0jU7wzz9AQUg01fiCCo1Jkq/3xQ7SxK7UM9bkpuK5uSV1MFZpGyzwPwOi?=
 =?us-ascii?Q?H4gtMbl6z8qQ5we0izNjPc4GYGSeczXT/5Bo5ttwu5NIrhl5b/YwSl8YSOoK?=
 =?us-ascii?Q?EK7jiLxAyow5flByaERvqPO5bJOWV+n0EeRxovePUspNmws6bMmWpa1Lpk7x?=
 =?us-ascii?Q?MIVh2FldQnNlu0KcKn5SJQc+IX89imlxpsEqSJVG9Yl6/liTKXjmR30KOlYI?=
 =?us-ascii?Q?27QZ+RTZGSGGsLGjO8PtQ6MSnPpGDdusJh09GQbFv/a9rPAYcj1w5OQ/G0/S?=
 =?us-ascii?Q?pvFEwrIjWyR5sCXNYPhGKFKPGCBhseLPVgdYSCpA6k9LMSzZWxvGzm6gF9G3?=
 =?us-ascii?Q?b4e2o6ykzJ8Y0I9NfYY/dF7pCVQ5VHK6jnjNYEg4qXxb/a03QRtTrv5brN81?=
 =?us-ascii?Q?/vyH2jtNbZqMMX5rmli9zCN+gqExHG/6HjcjFnWXYnk/sXigPsjAmLfdDVil?=
 =?us-ascii?Q?rzShUbFaAI+nPsl3Z67Dlu4vsI7LZnu+jeZGuuukLUMZ1KKOoMKTYQHbQTg4?=
 =?us-ascii?Q?1bfbLMhaNHfuwJ+C7p8GMQ4pRkizG60AONBY7ekGTc1HJoeQXzENcPzTFhf9?=
 =?us-ascii?Q?nKFPggXeKseMnqbzEwgKY41g+Lku+PDf6IvPZEJinADI4bXlCacGjeMvPIhj?=
 =?us-ascii?Q?7X2TXmhISLF+TUM3q13wHQGVG5ILXP6arq3ap2UfSrgPKiU16Y/NZr1LM8GD?=
 =?us-ascii?Q?OXnlBiUFGVlp7+sFV2K1svr6wvIkXFUCZMXEzObEOVH8TfkLXtqrBl9syi1f?=
 =?us-ascii?Q?5m38DgU5c2+lXck6vGXup/25PjHCcgDbS33pL9NStL10J2n86FoBO8zo/C8Q?=
 =?us-ascii?Q?ujJpbSvnnwcO5FFwrMWhd9DdMdhogdCkijS/lr5asNwol+cKhz7tSwEKkwpy?=
 =?us-ascii?Q?iE7tZ4yv9plst+zIugZ0gnSdU9o3CMMigdAGKxn33JfCTa93vwFpzc3XXhLR?=
 =?us-ascii?Q?QtsO9VH0QKhgSiRATgntwZCbVKEegCcCGbx9szzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c367fb-408e-4723-7e8b-08dcf263cc92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:36:02.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XLUOjjv8XGcU5kSA4xR3uFIHPXTzySnyVy9y7UPXxjFxxzGt4dRvMG5Bw3ZVIBffWJtJwO51aBQ4aKaefMyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

Hello Mario,

On Mon, Oct 21, 2024 at 01:02:50PM -0500, Mario Limonciello wrote:
> On designs that have workload classification, it's preferred that
> the amd-hfi driver is used to provide hints to the scheduler of
> which cores to use instead of the amd-pstate driver.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Disable prefcore sysfs file too
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2670bdcad6eda..4dea5a6f86c11 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -782,6 +782,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	/* user disabled or not detected */
>  	if (!amd_pstate_prefcore)
>  		return;
> +	/* should use amd-hfi instead */
> +	if (boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> +	    IS_ENABLED(CONFIG_AMD_HFI)) {
> +		amd_pstate_prefcore = false;
> +		return;
> +	}

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

