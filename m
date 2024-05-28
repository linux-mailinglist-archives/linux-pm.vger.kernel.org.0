Return-Path: <linux-pm+bounces-8217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAD8D13E5
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 07:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98AA1C20F91
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4384CB2B;
	Tue, 28 May 2024 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="virDnalO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896B50297;
	Tue, 28 May 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874201; cv=fail; b=o8JUKMfPRfCRq3u2/xveFk/X+HA4KqMgMf0G8X6jINfVyHYz6COeZ6NXLtl60beD7/Dfpc410+6kpcG+iJUweGrBEOQRF+blm36T4DPGhLTd8/5kcLGE94eotRqivPHSB6DFZVeSkJaGfZd/NvaknGlXEi60foz3WxvLAnBJtPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874201; c=relaxed/simple;
	bh=RTPxD6XLreYjunjDsXN/FpCgbgFeYk6Yfz+Sk5ND+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUT6aDqWoykPyH4SGenudTKhh1qMo9YgUM6P45rM42OHOfVAsJVKWTK4ehddMPOrBWXgWL7v9L/AihMMxwtw/gFPq9EcA0LTTYnuMgjBky4BhPaMvVj+bV2H7wRzh76EuGoJhlt8+2GgkcOn+Oog6/vQe0ZadOgCOTcYQseQNu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=virDnalO; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMnH3sxdYLU/RjqI4yV61MC7ej9Yit82Ea2iqVrOKNXBz4OlhpOMcFljHeA1iJqvU4lsSksUFqkDWlx5Jnb0LcMecEQG66EduimE6ptO39JAuFCH0YdqheTTJ81M6RROzordd8B+u1U3bEUq5/s0W/G62R9cwe/fv/yiiQlLbDG/X6e0ZRPKSPBAb9yCtL0SGONRg5XePaTdZwd7c3aEttp13dh3fB10N9AK4S/Ze05p/5UiQDh5jE6oIIvgLt6me4fRhzFTkET5u77KRUneo2t5XGptDrunO6tdx4dVZQ5wGbWN1WBIgl1gOQCUTjq++QgX2RPfFYm6SifQ7l62Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdY/FA19jr8wppRSZqT+VJWNG+/kGt7UWgyP+GE7PMI=;
 b=azAGUhN/OoEXRUSsN521ND7DPoDqEX34MZdrqPsQvBEThqM1JZazYqO2y70/FimNrIX2QuTIAM0AKlwQHw30xn6+AvefaRQJJ6T/G6e+N9EnZVlInSAgoBmmho8AI+/6jZKh8/XmC/40ygTpG6e+/72FKvZejDPvfAL9n4BJAEiaRHnVdHQaW2Egu2hm0rV75TmMS2+clKqvvjX/IimBgUMQdZAaRNUtqSR3BoVucv2CZ/gO6rJ793sffhWMHYIAkPcWTTa/l4yt/IKYsK0sE9FvfETjMBTZz1uumKqWL/HXUzGGwBblaYoXiahNZGPzEO2W2R+gdjlZJeEZoiIeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdY/FA19jr8wppRSZqT+VJWNG+/kGt7UWgyP+GE7PMI=;
 b=virDnalOlF98eJi16oU6neIKMOyGe9qxAsiT0Ep7CKSlJfqsCAdyihC6tBDgsJwoF+LjYlmVWFaSygjmPm9NlZMO7H9lBWaw8TJt4DyElySvrDFX+kkxcv1GlOZAtbSLmJbpcWZfyE7OMXrCOfkzTNe+dqyGI7C0tlemoFpqUIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 05:29:57 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 05:29:57 +0000
Date: Tue, 28 May 2024 10:59:52 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: Mario.Limonciello@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cpufreq: amd-pstate: optimize the initial
 frequency values verification
Message-ID: <ZlVr0Ff49DRSTn2R@BLR-5CG11610CF.amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
 <c7bce101b2d7d107ba3c89779fe6800060e8edc4.1715356532.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bce101b2d7d107ba3c89779fe6800060e8edc4.1715356532.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1468ce-0435-4969-28e6-08dc7ed735ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+f5PLXiGI6EoiviiyyPJVNAGbiTsb2BRzu9CRSa2bZ3Xaiz+D9OTDb4usOEB?=
 =?us-ascii?Q?LnXwwVKWNtohoJw8xsdCm4Y/+VhgaVFBWLXsHxXpFtDlHKP5I5yeuIt+0bzJ?=
 =?us-ascii?Q?HRdyBe3eCO5fBJshwcTpPpDlfM+MRli1x0lYxk8ZwoMqyzIX/la5K54YbknE?=
 =?us-ascii?Q?+npdAHvAX5bCNwJql5TZ1bQO9yTy41onX7Hnx3vVRsJN2FouVOB7qdHrvrOC?=
 =?us-ascii?Q?ZwlI4WmhVbIXxTYwz1TZdI7s0ZZ8QRBCfPukot1sA0qX1ws0Y0LrMQzfcYtK?=
 =?us-ascii?Q?beRJI3sb4PCZkjl+Wp3dgzVD9euTtQDSEuBIhmF+K9Uv4ilZehh4cCSMfxEX?=
 =?us-ascii?Q?a1PWbcwU8VzQ2ekg4M9H1iTvzcolCbpAr5dcFKNlDL+duA1PDuryzpDRsOvL?=
 =?us-ascii?Q?wTDjEzid0WgpomQTJ9EUjf5GpscAfCbaMafPiyWG0hv2fiXRfYpYkoqf/Jtb?=
 =?us-ascii?Q?uyqHCbJWzeWzz/JfdcpEPFqYUoD1Vz23nacmMpDp1sNjAkYdOcL7lSjXB729?=
 =?us-ascii?Q?LRiSttR2nFuKJfxOk7kQOXNYq6gL/7dnIqXRYPqgQB/ul0jXbdXoZq4RkdC5?=
 =?us-ascii?Q?0myjpFj13dZQZnZm2W70qq1R26+KaB31BFiveM0VL3stcBGAjO4B+SKcCao+?=
 =?us-ascii?Q?coG+uRST0HD+NbuXDsRArAXoiFCfBAmhKKubA3nXNnAhs3KFZsHEigHpdhzs?=
 =?us-ascii?Q?GVVE+FzRTsgbPHvp9bWOSKZhLkBkH9X5youFrsvSZ/6eVNYuAnGsNEdIFDC+?=
 =?us-ascii?Q?23rePqUOLSH62FjHMJoi01/hxduYt0CZvZuxijjAyv76S0ENRxqzvMgmLeTy?=
 =?us-ascii?Q?ibnL2NiX2+kAcNZL5XkkCu3CkdS2boDYqfU+YIZoSTxKO6SalSTfavoOXuI4?=
 =?us-ascii?Q?8PNMo+W8B5bLMPVNnNPaFljOQoZtFMRHYDBVN04aG6tJX+PgQh99pBw7/LPe?=
 =?us-ascii?Q?KhX7pmrZfPAE0N6Owr36IjUUbqImRIOl1xnW7ljSrRZT0bf1G8+Wd5mCJgIF?=
 =?us-ascii?Q?aXbKHWZEP06txcmDyLYbUuEjfk+CeiMPXnVK0W/tiDILew+I8lwtS4/Z++4G?=
 =?us-ascii?Q?xMOvjT8lwH1/3N2QNuXxGd/lJDFzf6378ANoHIhRGlIQYE6/dIgeJGMrPvcn?=
 =?us-ascii?Q?nExXVfccRFAEIrU/xmIAbAKMv/BqRch7LBp1ZTvccAMn3QmNRdjpDpRkks3N?=
 =?us-ascii?Q?vOKITEKgXZs4eCEV589+rmr8qx5e5wn8vziBvBPJdBvetoCXbuGt6w7seZWJ?=
 =?us-ascii?Q?KlFeHY+2e57r0I55MoDMV++eSrOgzrw/iM+wHObGiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7EB6kJ1gO63zEhlmFjflsSL7lf7e1/V4Zk36e/jT0HJAFO4cValQrrti0dR?=
 =?us-ascii?Q?PGko6UdiR1Th1tvC8BhqYAY5TXrGwEOEHNQEFgLa1I5DiErjDbWr+yNLiW/u?=
 =?us-ascii?Q?Oq0h+XXLsy2hDEhpbgz9Ad78SOdeqFKae/zZLVyB7y466jinhC2OjWn1jFDX?=
 =?us-ascii?Q?SftuA4emVfHM5JNRBizt4pcNZ+42HVGq/4KNUI0RBxB//EP4IcVnRrgQnGyB?=
 =?us-ascii?Q?VfEX17OpUwW3f4pjELF6gubwj+c6oD7xblDnT/PKvYx+J0Ai/ZEdxLQ/rP90?=
 =?us-ascii?Q?ogvb9wDEVdNkbjtwedsbLVyjE9jlCRueTO3INOEe7v22yFCUNwNvuQ43Pl56?=
 =?us-ascii?Q?jF8vC5gH5e0w23D0INdNNbMF2xsYkrL40NOjpm5IYahkyq2OK9wROCIB5jfj?=
 =?us-ascii?Q?URLeiCYwjYXlNIO/Z10WS187o4+La7CYXVdzpUH5icbkh4oQEt5XqBmKd0DD?=
 =?us-ascii?Q?xqnI69I1alFg6bcDcaVDjdRR+7BYZTqHH2rvATmBSHTTI5RATimEARe0mAS1?=
 =?us-ascii?Q?W0sE4ooezMCmP9X7sFQqKnTr6jQ+s0OfOg71VFBdiogrmGBU5CAYsi8r8pVe?=
 =?us-ascii?Q?xwqCUumfBtxGzR9b+aIIKyzueknxsHMzHQE+JAOWc8oKfQAuNqjs14vBu7Of?=
 =?us-ascii?Q?xRIQvkyK8h53xoT1DgOSrzwpHAl+dH6QeimLJZfC1N0kbJAmh8m7valrA0iH?=
 =?us-ascii?Q?ml9rqNJ+5qQDTwL9Z7UlF56H6D0g1nnT8lY8KtdYXcz5uEJhyg7YnL6YOc7f?=
 =?us-ascii?Q?5MAJDHQyJjHFJQheAdQJICp2mkVSilexD9fTzNRpXgfgd6Jz4sE1mmIGVBz8?=
 =?us-ascii?Q?PinNRjEIBhEve2Zv74fwP/ZyFR0mie+WxoEkrE7o8mVpx45UTo37PiV/8who?=
 =?us-ascii?Q?0T/pI+kE/32qssK+1SwQD2kCn4c0TdOK8ww4GTZcSPnzx6BgkEkGTEKSJauM?=
 =?us-ascii?Q?1Ubb6RB+xexvTNvpQK1BuvS7t+ukGXhG2cKVC3U39S9A6U0v+6R87QRgcC9q?=
 =?us-ascii?Q?98O85tg0XU9inc5yuyC6T/hZnLh4CAhrLA1gknp9McMykIxeuiHHWdA2Ooe/?=
 =?us-ascii?Q?cJ1X/VpsxpW8YpuQUxczshjYWO/NPvSBesQyiKHXMEV8mzm/d8k7udqlM2W0?=
 =?us-ascii?Q?STcqi9JyYoOiMAQwALFGZSDZys7dP34++JQUHYtCd9ixF1h6CO8mqBofVYj1?=
 =?us-ascii?Q?jcuQ04brJMbS7cmVS63Muc5FkFjOxF3brU+k6yspYMDiJmNOACVLW4Oau4KK?=
 =?us-ascii?Q?6ydJYGMe0+Wc2DB2GgL6a/nA3wIBQ3Cra9dVQM/CwxtSP27u2zBEos+Xj+o7?=
 =?us-ascii?Q?1K9zQrdE/KqyH9Dg/DePkNtAIFoTAyLDWRGGvG/zfSWdA+pbjBteUi5GaPLE?=
 =?us-ascii?Q?MQmV+EDVCu9+SKTeYpkze99eNNErJo3IoQlXr1dmUzZY2H9iWxN9cjXYJZ9H?=
 =?us-ascii?Q?AVhXwhfE8fIkR9aaVMuR560xFIN4Me+lK+UfrRFmNgT/0Oit/Mv8EuLY8OAq?=
 =?us-ascii?Q?zYPTqQWU30IOC/px20CAZ7pJ1rNsFNY0O7j4XHnilL9OcSNGWN9QBDiqqfQh?=
 =?us-ascii?Q?LbZAWIPfDyuHRKL6KRJ3iwXjDlV+aKCQjOO7z8et?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1468ce-0435-4969-28e6-08dc7ed735ec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:29:56.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNBgIzAG8eLN16WRgx8KgIilIlgqlCl0deCpCq97/9L/LRwagiOGs4pWqQcB0AxJuZdAno3+XsW/pwbZwvc/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

On Mon, May 13, 2024 at 10:07:19AM +0800, Perry Yuan wrote:
> To enhance the debugging capability of the driver loading failure for
> broken CPPC ACPI tables, it can optimize the expression by moving the
> verification of `min_freq`, `nominal_freq`, and other dependency values
> to the `amd_pstate_init_freq()` function where they are initialized.
> If any of these values are incorrect, the `amd-pstate` driver will not be registered.
> 
> By ensuring that these values are correct before they are used, it will facilitate
> the debugging process when encountering driver loading failures due to faulty CPPC
> ACPI tables from BIOS
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Looks good to me.

Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a342b0c0140..614f6fac0764 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -889,6 +889,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>  	WRITE_ONCE(cpudata->max_freq, max_freq);
>  
> +	/**
> +	 * Below values need to be initialized correctly, otherwise driver will fail to load
> +	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
> +	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
> +	 * Check _CPC in ACPI table objects if any values are incorrect
> +	 */
> +	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> +		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq);
> +		return -EINVAL;
> +	}
> +
> +	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
> +		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> +			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -927,15 +945,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
> -
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> @@ -1388,14 +1397,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
>  
>  	policy->cpuinfo.min_freq = min_freq;
>  	policy->cpuinfo.max_freq = max_freq;
> -- 
> 2.34.1
> 

