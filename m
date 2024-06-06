Return-Path: <linux-pm+bounces-8717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C248FEF72
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 16:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F96AB2A4BB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA03198E63;
	Thu,  6 Jun 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NOjgNZdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68368196434;
	Thu,  6 Jun 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684006; cv=fail; b=eeFt5WbbafEUmMuJRKwclFJzWMiXA7IaryehybkWBkVUyGjOaZs/y0HyAAnzpyfm/kFZG0HvfGSfHvz/dN6Bp5RaeHGALmqTujiZrkHNHWaDVJRdoPmyTS6nnTf3J31MM1NxIpeTUI1tbJEF9+NRxtwPlwXgtGVYI5X1rdeAFJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684006; c=relaxed/simple;
	bh=dFoW4C4abpK5aCa75fZtLULyioYrOsfG824uaqvBmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sCwDDv5a8TLPDCsMz95bSiWrZVyx2FSqwQ6eAcEU0JzgrauLPYkcsHoTGa7N7AMBslZ4itSrCfozCbwNTDYbnEXoOqgtNUIRlECs2apM31PXxBRHWQxsG7PCc60Yrb7uZ/6DD0jDB1tje7Z9eG54kS0ghXDfrOMtURE11DhOxig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NOjgNZdy; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L50GLbnAoQEO81rYFCt/YnlNm8RqfsMfo82qhUpudxt/HujRWd0AOkImH1o+kcF9ALAOEe0HJay6JwKWg+c2kNNnjAgrodBC6Rvcpz5AX6iVO7in9iVfR40z8nfkBCBUd8u96Ei4jIEbOxr35g3aTAbz75Wjk3SUsSxUJ0u/82lVSiFWSmAUv2xrWO/5Hu05sR9G4D/qaKO4RWDLtaLQLzNKoRjjkINg+Iii9VYl7wSp0gUUqEQ9vuTYVQ7xoZVjt6u6M9Hf6eyjZJPrlE1zoqHzG8tZlWMfz7M8bPbVDDPqkRC2dlDJNDug+cUfIl5lNATqdpoXuScrTA+jEa+D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC3slpgj1kouzUayNtNO/leJrkxf8VUmGan+9USMktA=;
 b=kCvgVfO2zuoIYIh3vsHiazS+D/TytTdejl9uYX9V5sBAhpG2cpmI1d3YS4+OvKRQey9PMXXHKxwGZk31Hn8HVVWw1kNaezjiEMicP69g4Fehziutxh3cs1E4PBjhy4xy32YP9ihYLDYEOVSYJaoyiaFXXhS2lKpSdNoowVnocGCyQd2EFjlTyDZM1OLqhjQnImBI8ISLmGyulXEPLu8Ip1r0Vr0H57T7pWA/P+oC3rE/o4EHA5na0u+mZeHcrk3fUxN/3XY/vy/jUqWQIpjzQH8PWzgfCxS7jyvXpaFkw8UZw5S3aQn95VRmDlxQdgC0qt8YGKa/qPfz3Huzrq7oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC3slpgj1kouzUayNtNO/leJrkxf8VUmGan+9USMktA=;
 b=NOjgNZdyMK5JlibL8rg12H0pL9CPJ0EmKMAbNr5inpEazBKm/AluDZpFmWYI+riJLBvU17b4x0iOM8bHqfgnxIMLMrPhDiSDfQ96DQQFc9BI3/KnECrlaEkJF2AuFNSTUsVyieOTXiJIQ8oAAQMnzgFTQzjknHuFYEsot35vUnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 14:26:41 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:26:40 +0000
Date: Thu, 6 Jun 2024 19:56:32 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: Mario.Limonciello@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] cpufreq: amd-pstate: show CPPC debug message if
 CPPC is not supported
Message-ID: <ZmHHGLbWbwIzel0z@BLRRASHENOY1.amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
 <e6132ee6b6e3c3db5cd9c1e8adc0777881bd2cbd.1715356532.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6132ee6b6e3c3db5cd9c1e8adc0777881bd2cbd.1715356532.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b7d18-7f84-4e72-3383-08dc8634ae7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfBqlMuSBRiG2CKwUx9hNeQ1/Ab8dN1LpkvxWeBTXPRclhMmCMbC29QDS7Sf?=
 =?us-ascii?Q?tCgGck/0XQsQDxYWLBSjY2sKPUZtKe6m1ici/q27bSasVPAIO4CTHQqyrJzj?=
 =?us-ascii?Q?t/fxB2ga3dkyRda765AYk5i2jy+Dyvp1BZzrhcw6WEnmZnONG0mNBtqL6ICP?=
 =?us-ascii?Q?1dHWK970NMSLE97LaPtCSjiLfFDj5jTTzuLYbARFZEOsrbUY3NGvqsZEgIMQ?=
 =?us-ascii?Q?CZvWYwU9NfwZvm7go7miKDkwP8UJo4bmelPmh3CiM6joFock441Om9XopHnO?=
 =?us-ascii?Q?ssRPggCLkX5y3Y1OJbZ/jGF06Ys11g/+dYhm1WXnmiJfJA+uytMVcdXZ+3wP?=
 =?us-ascii?Q?JnW/gOjUBZjlYHpfBBHDi2Ix0ODefLQIQ8qyf30npAPUurHFed6KVyZV71N9?=
 =?us-ascii?Q?wfs39k1/fYgiuw7PUrg+37U7F79q//wW9JQ0PyQ5KdqGnXcD4wfaUe1o49l9?=
 =?us-ascii?Q?b42KZFO3ZgPIVguhPcFW98jpxOQeeF//wjq7LYU1h0rg1mN9//jEBhg/6NFq?=
 =?us-ascii?Q?sLZu9H2feZtOpQbWNxF9ovdHLGXJewOyl3kC+esFBJlJXoq2zmT+FgK6G6ln?=
 =?us-ascii?Q?puKhKnbtMMAkN9MqsuSgUhLCAEp67incLD/IyLEZb0hWVJkC7FwMDKW6a1Yn?=
 =?us-ascii?Q?RgaEUlhw74ZwFJ6mAePhRhusmBDb/Zyx9pEGT9gsS8efG4iyCLq/3ZKRnRHT?=
 =?us-ascii?Q?hgSOgmvNvJxDHfXLQG4wdBcIYQpg0u9sDSYDo+KZk7r4575MofEZZtswNm9F?=
 =?us-ascii?Q?te7KmP8DCwsalsnIKLsmyl3KBztJgpvTBhEf+B6XRM1zpd1t16rg9ASdMisa?=
 =?us-ascii?Q?RR6x4G4UFcPKR2+4kq4kWkulCUZWuhaIhWHtlf2lf2S+vDXJ37lK/dyPsufE?=
 =?us-ascii?Q?9g8ICuSjUFLRQCOoWWLcsZYCkWtmCP5WfmRjK2gni9LBaNtQ8CvLwJPRSJpv?=
 =?us-ascii?Q?scCp36g/mWiMgu3JD1jr+NydlKN18oMYN2UhDpvTmnxtl5RXq5+VCGII0UZL?=
 =?us-ascii?Q?1QF2IKb1uWwI1xjjTWZcpwz1xIcUT5kUwzCCu60f3pth0aQWE5ttJiW/yCMB?=
 =?us-ascii?Q?ZpimUd0LfEmcGWHoiGNW/8uwBWeNYOTdOqvZOeh6thT0WloczsX+7ZaWdAiW?=
 =?us-ascii?Q?gBc1xkg0Oq5WqMnzS5F0uwDSy6nZyJEQePN9o/gMMTF9TJ7KupK+u68eVnFr?=
 =?us-ascii?Q?N7q8R1e7SQwV8ZwWZVHXvdLkImx+D2CKBK4a/ZWcfjfBo6DL0FFDrJco2Ebr?=
 =?us-ascii?Q?wnFBN2Nu2Tj5k1CDY2S7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsxEErxDCkHP3V+V1UMpn0cwp/cip51n1Rx58Pfal8L5Mso5P2+QFw4J2rJt?=
 =?us-ascii?Q?lSg/5/+LZn5Uza1E/AZ9JvR0l+4xg0gwM4IuZgn1n91lArZ5ACdcaSW7XmTw?=
 =?us-ascii?Q?QVMwHCutv2zszYsOlAyERJgFVo10luITBjHX3aa8OiNTQhsTpav8D/u8bYzV?=
 =?us-ascii?Q?m3gnkY3xgifyCCCbAHxbKBTXQrQE31dKtXMuEk0T7MfVTfWj2VPEbsVHSZaF?=
 =?us-ascii?Q?FNeJOMygePg6E2DdbVmd/2Rn9ZTx7nTlqlcRHIEkdsmxh4NNVocptYd/N8BN?=
 =?us-ascii?Q?3lfDFOlIFS5uH+hUKkXtIC6mV44ETd9qBSjinXpVCpifVmFEyWIk9lo25eiV?=
 =?us-ascii?Q?Ra7AuBsRt5dyiR9VYNXXlWmbjFIrJtWdm4jbWVkCBdtQMBsxb3QDUtFcDlwP?=
 =?us-ascii?Q?EHGewWgfWnfMewX/JB3QMH5LcaAgUfhtMGKi3u3FWXqOb5AimsVfJJcLAaS7?=
 =?us-ascii?Q?7pcQZMwjHmj5eZ7e9NFFnfAB21kliVlrSnn/cpP1040Og7WwpbYlUC6+8eBo?=
 =?us-ascii?Q?J12BsVTwj+jbEUSfCdr4VHTqX+K9qLMkDw615wd5WtJ9+OhbHEI+3HwqmsQo?=
 =?us-ascii?Q?QggOYUWiY09it3lQv05Hzzeu99cKGrBjAIhsQENG7neRBlgeMclBzCyEAGAu?=
 =?us-ascii?Q?1vvb5+LYKokEJCmuIk6DaS9RbyMehnBMG1kbT6MmDoirNpRixH7lKVgVjmbW?=
 =?us-ascii?Q?8fjwQm4m9VwqMTr9hSQ1i68Jzf0hK8wbE3wnDCxMljcm6v4khIphGPDlzph3?=
 =?us-ascii?Q?bZumxUO6+/1o0t+gWtFqtRwDOW/5243Cmfl7nXIR692rPLP/IRUwrul5ggT5?=
 =?us-ascii?Q?W13y8nq15CjFe+RvbAkf00vo3DBTtqqjDAOPaKxg1A1gP3ISO0fOKcAxGiOG?=
 =?us-ascii?Q?FUvAouLD5NHcofwMXVhWIqAkcHzHoYcka55rS1KBsFasS16yNoUepAVg2rXj?=
 =?us-ascii?Q?QPpRe2HZUnGmuV7LINrIIi3WOSXq3y/RCAVCUOWx57jW9+wX+b55CF/aK/1R?=
 =?us-ascii?Q?CFKVHZkvj9eilEyXYwZZyq+01eMfELvg7Wo7/dvMheMjrvdz/+R04tIr6lRS?=
 =?us-ascii?Q?SJyY88uvuyQSSAffVQQA7hpXTmN+5wK8LAhKbFVFI5+XkegcBC9LtaHx/Dm6?=
 =?us-ascii?Q?5MbZdfukx4mqKoIsR/f4W9SO56sOgSaGcJ6Zt58D4ooPGQS39p91sJMIzFjU?=
 =?us-ascii?Q?uEr2ycZ+HgYdoi4tz7WZpTHfHKKiTZt8aGlCm/74dDmxF6LfYjWY9SbT32iN?=
 =?us-ascii?Q?5COw5M3dAa07YjDstCAXO+ynnq8NAG1lB5Nk3DCaEogbpZpMA4C0ObRSS+Nj?=
 =?us-ascii?Q?d6JINXlnDDefXfrr+7s5pFxRhxHUi3HZQruzfkQd2chEupD6t5S+o5eFJB31?=
 =?us-ascii?Q?usRFSfp09M/Lko5lpUcm6L5Zo8QPVMzC6oZyG8BOzlQ15+x+64MGREZzqH1t?=
 =?us-ascii?Q?Ec2cDQRLt/RlVnmh94AFg46Wnvcl9m1dL1oj92tJg6JMlOZFmNmQLzwuInpU?=
 =?us-ascii?Q?Q6bNKPvhrHxRnRqOnsqkdMS2R2AGJboQDJDSKQQ6FOAsJnFQeiG2cPPU/LeY?=
 =?us-ascii?Q?5eAE0qQzP+X1SgQaqhI/IJKu+b9E5d+MtPy2NAnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b7d18-7f84-4e72-3383-08dc8634ae7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:26:40.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+lUNFST1NGfliucy14sWH4ZMp/CH7LTG6/bXh574loC9nunX88F7gPE07lwy37/MKvTOUen7MX2f36C+txkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

On Mon, May 13, 2024 at 10:07:21AM +0800, Perry Yuan wrote:
> Add CPU ID checking in case the driver attempt to load on systems where
> CPPC functionality is unavailable. And the warning message will not
> be shown if CPPC is not supported.
> 
> It will also print debug message if the CPU has no CPPC support that
> helps to debug the driver loading failure issue.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-pm/CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com/T/#t
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ca22e94f3f3..3109b46fb02e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1701,6 +1701,20 @@ static int __init amd_pstate_set_driver(int mode_idx)
>  	return -EINVAL;
>  }
>  
> +/**
> + * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
> + * show the debug message that helps to check if the CPU has CPPC support for loading issue.
> + */
> +static bool amd_cppc_supported(void)
> +{
> +	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
> +		pr_debug_once("CPPC feature is not supported by the processor\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int __init amd_pstate_init(void)
>  {
>  	struct device *dev_root;
> @@ -1709,6 +1723,11 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
>  
> +	/* show debug message only if CPPC is not supported */
> +	if (!amd_cppc_supported())
> +		return -EOPNOTSUPP;
> +
> +	/* show warning message when BIOS broken or ACPI disabled */
>  	if (!acpi_cpc_valid()) {
>  		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
>  		return -ENODEV;
> -- 
> 2.34.1
> 

