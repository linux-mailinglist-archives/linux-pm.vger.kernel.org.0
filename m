Return-Path: <linux-pm+bounces-18677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB839E673D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5A11687ED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096571DA309;
	Fri,  6 Dec 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="stBKsfjh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689417CA1D;
	Fri,  6 Dec 2024 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465807; cv=fail; b=S+7WOcGCBotzLjjpDzrO6St6pzXOpKvCxlTqG1QC8nnPcZ44dxAFXTczY/Lhma8hWR0uiHSmr5MzFDG/Wop4GfyRgRe+1ZGIrMHGNs5LwsF9H225NlwCzj6JDIIZpXosfJFXPE97XvYSeEexSbiJxUtfRZnC/zaMEC5v7nni3Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465807; c=relaxed/simple;
	bh=F6n9R6mzdL3tEG6hWa1CYy9sgPCkb+5+I9s4C3Vn1gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqs2NaG75PFpuVimBrJx3EUgSw5Zfy5tFr9XOyyWD7l+Lncq/2bErxg1p8zymsWVcTrKaDgoey1xytOo2+pdfbV07DktuvUFvFSh6gi6ft1YN1p3VrYiYz4w0F9p9qYzW/JE4Tmjv8LgLt1kuACnUlIFe0ycC4YxMJ2dug5GuJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=stBKsfjh; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PET+sVMxCA4l6qjWVTWnkh/6aqd5v0ETW+15OPumYuXqtYXxN/anvaHOUyaq/tXUMDoL4KGJ+BI5AiCpGQaJBvjMhswfrz1rKMLoaG8IfexFRxMAnJ/vMC4T3kL0QC8/BmryBddjfVzUYUXCCZ52XjxhL1CrpUfQqdKpKLfGi4HJBXJRHlbUvXekcd5RtKfLUmxGcXA8ji5DWLqqncebb2zSPdw0xkGd7QKYKOnOsVfCU5N6gUdy6Zf888g7DPpOM9dh3smmNmQfj0VqfXnV1HWTg7KxO3KtWgBjTBl9P9v9jmHbStF9lzSqJ8q4yty9dmjUvDZQEdFiSqCi1nFxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfTRTwYLaTxhhQOX7KZcu8AI8n4FOgJwspEziaadWRk=;
 b=Pkd2uNoXcmWH2yw+wHKRwckwMoxP21nM/qGRxXFVFE52Ha8a7IDH/lQIhTl0BHua+gHeCCLR4d3eS7WzX2ISufhsxooYfHRvKqBckeAxzOzxeMEFdvi1VLBvflEUo6fc2reaMFy/06d16u+Ay3ddQgWlciK/LRwD5ug7m9wDoEOQRJrJaysYM8KvmQ0PWf4jC+i3SzhU8NqeMMsDUCO2j0DvdIDrKNlLMUdGWEbH85O5krfszLDWFftGyDlBf156PjUeMWjWLV8pNNgr/yGO8W6Jv/zYh3kLJ37SbFIfF14AUYwiqCebdZ8olgIPrsH1MV4M8YFtDCrA1zkwz6ITDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfTRTwYLaTxhhQOX7KZcu8AI8n4FOgJwspEziaadWRk=;
 b=stBKsfjhgiCaZjv/oRgHZvMlMUnoFJlDp3j+bSSdaeHLBVD58wga4TLXGWQcFfyu5B3+swYcN7MTVPX+xGt3CqdNLUmKrUNKkzozzNvQ34wqu+kkARwdIIy5b0gjtDObGWciDPp+PetMYBWlYCxrZfHYAE8jvCNPe6h9Vt5KVcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:16:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:16:44 +0000
Date: Fri, 6 Dec 2024 11:46:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 03/15] cpufreq/amd-pstate: Drop cached epp_policy variable
Message-ID: <Z1KWxCmJ2KnrbSPH@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-4-mario.limonciello@amd.com>
X-ClientProxiedBy: PN0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b402f2-8d5f-45bf-8de2-08dd15bd8e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SK0xKhwpWHkwHAwyzTxdWb7VksYPjJe1tScym/NfeQzgchDtIjr5BfmAABRS?=
 =?us-ascii?Q?vCieF16T0Lia/na1tE3HpdXJ471n/ZylIdIwrCjpy64JBiJSrkk67QJgRJfT?=
 =?us-ascii?Q?8+LXR7YQcPrGfkkguG3Dor+mO+lebYJgwrxo2h5gkyjESG5iPp6cmMbkGVDE?=
 =?us-ascii?Q?aPoWLmV1Cg3A6gBukiv+ABmkYdUIkBqpwCeH0Gsvp9Lk9Mn7yE8BVz4k1gwG?=
 =?us-ascii?Q?2KVERkR/5mAx+C3NDIyFuTu+dXkLtmzybvRYEmhouWRSaH+5UnalV4eRzErv?=
 =?us-ascii?Q?slWGJFB7jHkCU/dPwk6oMri1ba/qIavaJuQVE/OqneQiCdBxktoPRSb+kd5Q?=
 =?us-ascii?Q?DmYOdqMMEmDQf/lLztXVD3Emtm32XnASh/6Yte1N4Wm9v1q/R4/UqqDRDAwc?=
 =?us-ascii?Q?fxiBwb+Yu8vd9+OWQvTQR2IylJKRhLrNXhGIbAURRfi7fakEOuwcKYUh+LhX?=
 =?us-ascii?Q?TNteSw8YPVURF9RkJRQJjPkgElqRUe+530uu0msdbmxaJtBOQzxXbQOP27Py?=
 =?us-ascii?Q?dJEnrt8HakTqklqpAX7a07J9iKFUZOlmrYXn61+qJtf3yWsO2hDhNqbESHTQ?=
 =?us-ascii?Q?RXS2dPJuw2J5Oq8J0pKrGq/v3VjmY64dXKz5VCzhOEre3sX5alNdgPJEqdUA?=
 =?us-ascii?Q?HYevOtN+r5bqatDUJy1Jk1HFdaO7y7XdLa3ywwo91Onv0D27bbHeH+b4u1t9?=
 =?us-ascii?Q?9dfoiIuoN92hhGO16poA+pFX9RO4yvoW8UsAH3q3xsO+ubBqMheMJ9O3w1Iw?=
 =?us-ascii?Q?KRHIg1PpQ7UuzvyAW3uTZYrFK+gamDY/BI22g/FM+cWyKNr/YxLzmh1/jKvL?=
 =?us-ascii?Q?tNRZ3wtDMSewYfDBZzFiQnOcC6rHbMwCK4Ml3g4SI0r10FS3fzHkAk0J+p1c?=
 =?us-ascii?Q?khdL0+jHXempvdgNjCXI80se79hfjkeRXJ9N3LsQfiAZoPUh/672UCQBqxM9?=
 =?us-ascii?Q?iJxGiX4uXEz40flCcvEwpc00u0vdvx8l0ZReOZTdJCDNeRttw6ab1PHJS98f?=
 =?us-ascii?Q?k5WQYkrLyGEL2mLUWiqIw0irxsQ+GQhjVbDifanFeRklii0FoiV5tD1sYTXR?=
 =?us-ascii?Q?8eGeyyI7W2Gj5IlzxTeKprv/mBfnjksA9Gca9RzJkxsFMGesgddunu/9eFy0?=
 =?us-ascii?Q?0u9cUfaee5+pNpIhPRMkh/s6/V/Jy92/mZMHSWk9NNq/h3uRXwrexHs/554m?=
 =?us-ascii?Q?5HlWc8DxaFMZeQvnBi93YM5zhiFG+3W9vb93M0Gce/kneB96B5vNMYF6cNSi?=
 =?us-ascii?Q?37F4CXl+lzKwSeUP2J0k+GUTGi7u8/QSCE+yvWv5XAx87bu4/2j1yoTxO+cw?=
 =?us-ascii?Q?ypZyANkg3QxoJJfOQIh1JYGkCbfmeFbMwusTnfbk0ULGfz7EupjtQOBOQ36y?=
 =?us-ascii?Q?MVfVohA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvjQEJ99GYPTiYhCp6zn9JCKTRz9OzDhwQP5L8r3Xo2LOGS5xh/Bmw4Ekt6L?=
 =?us-ascii?Q?a+mpYp2bpMpuPzy21qrbEnRJCMoheifPqLdaU8XaeqcNXlXbMFkkP2zyVXZg?=
 =?us-ascii?Q?lgw4DICLOttprNwLDqnjf472eefrHbVIAwCHFfR+GttpmDtXFDE7Y6yhIep6?=
 =?us-ascii?Q?hHhChqG+dxwvIcX1YvDnY/D6/ZcmH+hT4FMMVOHauhem4POhhbI/AglR/YjM?=
 =?us-ascii?Q?rD2vm11MDlK7LQKcUAnw2TcoAo8k1rTfqxH0y9SJjyugE5RNku74CIdNCLiv?=
 =?us-ascii?Q?jg12uP/jCUcvTr8ZnU4ICWOzAuuB7Rc3XBni6vfY/r231fGJLnocKL8yleL5?=
 =?us-ascii?Q?Y6CPRijyxlRoa7kNK/gB533j0hPzCtCerL3QMaOOR05W3i1rSEiIUa91niYl?=
 =?us-ascii?Q?SBl5QwoHh9O6AIH3oUswv7kQlwb2OzMX0jBTHy2p9nE7/hQiiCzXRa3Jac/g?=
 =?us-ascii?Q?vU7wu/ba9qzSrkxdIcaZ0uc3+9YcPUe0+szJZIOyS/KYYpXjFLGyuh81hzG1?=
 =?us-ascii?Q?t/ulSMveB5Y8ce+QfGfbfvmVIUWYs3Xnx0g1PtTO6URqbzif9K5usl+BPU48?=
 =?us-ascii?Q?9Bj+8cWKUX5gP6SH9Q1yCz5thKrA7vvMQ7vsazf+vN0zrz/tC9AcXogL07Gq?=
 =?us-ascii?Q?ipphRmJqZMQRsc7TFwz5Vt3MpjwpRR1a7TigIv7/5tN9O7C6Hx7geb2/idnx?=
 =?us-ascii?Q?kmCN9QTYUaznef2fYp2vW9SvYSwiQ5iDqYm9LpKG+DZLAUYk59B7qMLn7+U2?=
 =?us-ascii?Q?mCjfrgSzWpQmQJeYzZMJvZDBunE5Hc+ceWglsPEOxo77ugxKcyIA8bye7dra?=
 =?us-ascii?Q?zNEnRfHoEWFKmi0+7PxRx4yiJZNogL9RHS9KyDrOPJqwDR3810NtQzKHWI/D?=
 =?us-ascii?Q?Ls0QgaVpWxZBoA5TgU7oELWFTvk1JL1KOfok+1AX+H9LamqglvXJEfZ2fw1m?=
 =?us-ascii?Q?xuUXxI+f9xSZFpVwDbmf5v770+gUSySglDIr+zB3OGEDSg7yz0rmBoDXr5ht?=
 =?us-ascii?Q?EleqEzNNpIDu66xBukgvFcclNWt78rjf5CduScJDW+eNzwcpBdMcuWrhtGeg?=
 =?us-ascii?Q?cKctCw0GeQp7fYtOrL+N1xuH8nLX6wJeaBb3zXD+qKx62+UP211PG4fCva4Y?=
 =?us-ascii?Q?HqZh6yFVcSQmwIKcQGs9KXCnFIOXK2MWxrOllGFy+IZX/1gZQt5MSf2JYmtC?=
 =?us-ascii?Q?gp26tEpBMedLLABJyk/8+h25hJJBrnhd6DUQp4g4BfBAE3lyzCEaxHTUIoHY?=
 =?us-ascii?Q?TATS09pNmeLl1hVj6Kqtldsdkxypmnl3BkWrHWNAx6s0G1gMhqi8CSH9vdSn?=
 =?us-ascii?Q?sDtTVq3s12NjlLDU8xICH+AK+JHk2TGx/FY3WBhTimj3Pb1OW4/MPCVDv4Hp?=
 =?us-ascii?Q?VqJeLGj7empZVEoWzbTnml2BmvBypgji/CJIr22WuqsAv2yZGru7dtHUyW1V?=
 =?us-ascii?Q?vHBSRdRs+J3J1Ny5IlvU/q/DhHBS7+Xf51U0Zui0gbXvAjhQ92+8b+oeamlU?=
 =?us-ascii?Q?duhMf9A+FHY4kVahIPUXfE7sU7LsiI6oxY+d9jkigpsmgsytU0CRDYzFa9gs?=
 =?us-ascii?Q?gSL/gVDTzLNR/Gf4S1mr+2xLoVGdGBAyZPHKFKnY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b402f2-8d5f-45bf-8de2-08dd15bd8e58
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:16:44.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUfsXiihqHRmoQs1vhU555kL8eXkeqAPHlypvJ3TQlrT0YIN5olg9StWSzbOxQgV5h9z6dpJZMW0hItyxx3JVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

On Thu, Dec 05, 2024 at 04:28:35PM -0600, Mario Limonciello wrote:
> epp_policy is not used by any of the current code and there
> is no need to cache it.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.


> ---
>  drivers/cpufreq/amd-pstate.c | 3 ---
>  drivers/cpufreq/amd-pstate.h | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7eb013585df51..22e212ca514c5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1476,7 +1476,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		return -ENOMEM;
>  
>  	cpudata->cpu = policy->cpu;
> -	cpudata->epp_policy = 0;
>  
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
> @@ -1583,8 +1582,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	value &= ~AMD_CPPC_DES_PERF(~0L);
>  	value |= AMD_CPPC_DES_PERF(0);
>  
> -	cpudata->epp_policy = cpudata->policy;
> -
>  	/* Get BIOS pre-defined epp value */
>  	epp = amd_pstate_get_epp(cpudata, value);
>  	if (epp < 0) {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index cd573bc6b6db8..7765c82f975c6 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -57,7 +57,6 @@ struct amd_aperf_mperf {
>   * @hw_prefcore: check whether HW supports preferred core featue.
>   * 		  Only when hw_prefcore and early prefcore param are true,
>   * 		  AMD P-State driver supports preferred core featue.
> - * @epp_policy: Last saved policy used to set energy-performance preference
>   * @epp_cached: Cached CPPC energy-performance preference value
>   * @policy: Cpufreq policy value
>   * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
> @@ -94,7 +93,6 @@ struct amd_cpudata {
>  	bool	hw_prefcore;
>  
>  	/* EPP feature related attributes*/
> -	s16	epp_policy;
>  	s16	epp_cached;
>  	u32	policy;
>  	u64	cppc_cap1_cached;
> -- 
> 2.43.0
> 

