Return-Path: <linux-pm+bounces-22215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA1AA3866F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FA1898849
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA83224895;
	Mon, 17 Feb 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DdlMxHgH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155622256E;
	Mon, 17 Feb 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802637; cv=fail; b=DkhhuF1XxVVL8kcSQaOYRS4VsqxptcRMHmdYuEQXROrIA9n7YPY8NV31FSgXdbNiH/mweDUoDa8FfX4L/Nd3uEJ1Z9kJi2owgu3GbJTiQ8PFNphJOMuaoTxsAcHLPgJKbVWhKpRiKHpJTRei+bqphBYqgU2+0ZETiZ3Bg3RxOxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802637; c=relaxed/simple;
	bh=WzyACpNWpXuPvausHOLvarDW6cYMjxfNXNYZeHEzIGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqXYpM13UaoBiq+PqowewigMTTVp95U+wjTBu7QqKBuRAoh7tdyo+827/vmoUGQfI/u5KWgDoJsGfp0XAY18SkPcAuHPVFFFsT2oEAxRXDmu4RSiHF2yGkXwMacnqAezi5w93OKQs0KSIMupdAQc09bVodumBQj1QrNtRESIFX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DdlMxHgH; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImnEJJqxoLATloPripxsf7+9A+zc3nOwMntHM/2GNxk70gorkCB7dfbPxJPBIlFU2WJ5tnTuLpFnT2oNmj6m6pgd4nlXMclTtAnxdcRud3r6KeIlE/4MHZcZtqmnzn18b9TUoVFMW5kBUtRKXYlbAqMIJXQYANskkEgEEV5EjnHHXHvjcnEZP/BNqgQx4EINnC6c1b4w1zKa1m2Q9hjEHCDiqcUqLG4DzRhB2yeKsco9A/D4DrLrvuH9bp3l4kCLi57qjLA11WwCHRAFRk1rwwlKaCoXcox3doV8+COguLB+rDRaqw0KWqGalgwi2WPECmPVm3cRJ8k4Xp3mC40B/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNQ2U1IizZxoqZmY0S2APoWcQA4wpaav/Z1kAehet54=;
 b=tw93QJUYNwmrBojp/uaicKB/e9BTatksICraFrrSRJnZJVuTXLUqX5h6043krgeqjotuOoh7s5QNzuPuANymsS844RXAHhay1A4Ig5jWlyRaRd0zA/1Jjnk2Y3YaZWW2K3oTAIuNh5TLJdAIuGza69HrDq5d/Az8fqfe5JZBKNqXwGZWKlLDg9vGcS/ovdEVODkPbmX/1RqLmSpR0jYd6IyB1IN3NF8lM1a0yxSknseTc+B6jWpEmt7UOjCUgKRLUBV0xZedsx+bw6oVFxEd0nah5IDD1DtvLblsJOFjwquC2X1itzOU2yoCmoIX+q1HQVlWPLMiJl67fIErpkRajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNQ2U1IizZxoqZmY0S2APoWcQA4wpaav/Z1kAehet54=;
 b=DdlMxHgHqJDD4JhpITqEg69Tfi8bqWlGID34mNsaI/NP5yAYcVBFnuvNaxVJu7evj+qunwT07Pcud4KxrK67iMdtBtyXa3jrKAdB2cdFqD3IA9PR8lwSARRXyh12KKIiFhvWx1USJ/bor/7Zd5PbH0VLUDqPwsC3x1BHd2AkhJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 14:30:32 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:30:32 +0000
Date: Mon, 17 Feb 2025 20:00:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 14/17] cpufreq/amd-pstate: Update cppc_req_cached for
 shared mem EPP writes
Message-ID: <Z7NH/xTQgyLE1sY1@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-15-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-15-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a413e6-dddd-4baa-6593-08dd4f5fa279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Tn5difDi+XUhcj4Ki8TBB/rJrfy4Fejf08twBqRwrzc6TrsWXTxV43Meqrc?=
 =?us-ascii?Q?PmoYs281ESB8zxKy8xseQMDuKUxkYwJAoZRwI6urhRFWuj+WOJGVXMWXYQYK?=
 =?us-ascii?Q?3GwwK/BV1jrFPtrqZFyCmebRGHiyEvuHg3nutRqMm14Ivcrv8johneIJrpqZ?=
 =?us-ascii?Q?MiKMjizPMnBL2SXmw+ip7fd5nX/R/ctaSHtPc2c8zEL3vVlB0xNHNlPJ5f3K?=
 =?us-ascii?Q?DOK5/HHkqdfgSoEyJtTT4dvZuz4W+8TgOKB74TIPwuP22PSkFNsjOMK/AQNF?=
 =?us-ascii?Q?BjUPKidOmj+xeP58x6VjUKe6rsLyK7BzxXPKfFI4ml3+6oH1+f/qAeFehz78?=
 =?us-ascii?Q?lBVQoQNga4dNmMpiYGnXPOMvAFKmotyn+3d3wbJWu2blFblPfd+fZ/ODvI0+?=
 =?us-ascii?Q?PfE7uf9qPZAius1LBy9/Q5i3MQksGcN5R0oK1+P4IDcVgee4qJgEhbXB7GbA?=
 =?us-ascii?Q?foWiq+iEPL7Mm7dHDg4v3xnr57l+2HPmRGQmM86NHixCxSqW7gJf/whm4uJ6?=
 =?us-ascii?Q?cp+1w8jTpV3VDL2rl6bQERB2kDN8JdtyvO8Ex4u5C/HrhDnEdvccEoBwUR8n?=
 =?us-ascii?Q?HQsCF0lb43mERNy8Z5XvLhh3fBNI8D9a0nzK3hCJ36QiXPqYIQ1UEb8Cp0gL?=
 =?us-ascii?Q?Y7klvhm2DI6aWCQNPJ46lOExofPYFWQo2s5uhEZQjSB52x/iwP8++MopiVuf?=
 =?us-ascii?Q?iNk4szqWMSZDtygckG0USLDVKjs+tMu9x7fjIfk90WYVi8wnsWc/oJiMFIAT?=
 =?us-ascii?Q?e+hJqWOs5CST2Lj4vmn7Qwj3mh91yNQcY5i1bZeVHQ4mHFJhXJMF7TLHUqgg?=
 =?us-ascii?Q?dOk8sx84xXTJWLeFX4e3d9CpLwiU91BhCSfsfV0lf/s3I+5R4CeXyoeGvQDf?=
 =?us-ascii?Q?QUoQNWF0Q/qQRtdNmfcq85oRjYGWo3pmAmDyi06oN2oLVJkiii7j5pGEXsAC?=
 =?us-ascii?Q?E56oMolEAOJCXDzC/FdlUsG/bE32lXWr1rlhseKvic+diLhUmKuJ5TIWVtaM?=
 =?us-ascii?Q?22E3Ty5ZuWLoTPaQsCd/DLviHtVHnZVCmYLQ+JFplXTgAVTCle7CWD1G6Dqw?=
 =?us-ascii?Q?ljh/lc7cLZ9mL7u5BhIt7CUEdzVfFRWfmaZse7PEdGO/vCfgKsc+mVYj7E7I?=
 =?us-ascii?Q?/5yxiNMfkyiodtY3jWFtlb5RcyqG0yvOK7FcUkUNxoRocgiy13dFMGJrroNv?=
 =?us-ascii?Q?gbxRJjHYcJi/7T2tDfqH72Jd43oGQRSEioqhRTIONnvSP2l4+ORmmkevDhbu?=
 =?us-ascii?Q?FfA98qkmjPOpf0lrLGrW1WCbHZAnEkPVnvEOndllEP8tIYUz3ziPgzFcZgNS?=
 =?us-ascii?Q?MXHrZdPZPpjGHtrUU8FrGvJobcFq2YsblV5tex1vlNzRvThzTL3n6SqJt2Zj?=
 =?us-ascii?Q?iYzhcsaacF514r3owgEZVsJEg25k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naZLxnvFdtzzC1/FXOTC/zKSJVGlYF40CQ1l+QCtWwTffn//G6KXGoTVutQs?=
 =?us-ascii?Q?KUAkRmB1LO7yiWPVr/M8eBYEb7ryFNayf/jOPWSXg3+x5QaOvfk8aURKJx9r?=
 =?us-ascii?Q?UCUsHku1EM/cX6dA+MgDB6N1/VdyMDj2tvoe0BEPZEJdhTKh8+fdicEAFDcD?=
 =?us-ascii?Q?isIO3tHkzPOu2e9o0QBYulZ+VZ72UaeU3pv9Cbo4+U7qqgoYdhwP0QH0k/IZ?=
 =?us-ascii?Q?DX4SauOSB+FFX70Q0XI7yn+rCjc6ItpzRhcNAVAejwbJ+45Vfb+b9+b8OJep?=
 =?us-ascii?Q?9j1C0A+y47wdeCJXOlEzjByVuExQDnFKKecEI1hzQOSDRaPYnT86EnT/IekK?=
 =?us-ascii?Q?9xwjL/VsMDBY8LAeNrHQB3FqVTw28YQ1FivWJIDSSkRMAwv/HIWGu1W60Bcn?=
 =?us-ascii?Q?OtmVRY0IplNn1LYsWzTTs+p9OiNcsqZygnV2ZPEeZCwLspOu7xcObHlOjXEP?=
 =?us-ascii?Q?r758qwElWS+qA8+by1w+a5GT2Z7srv5zVOi776/83RpEdW1IRtyfyXn5U4/U?=
 =?us-ascii?Q?6SAPIWLhX+BLCjOY/t3qxQjvcQ38fFdHQpzm4620wTZaBvUaZbo1xquL0iBL?=
 =?us-ascii?Q?rjBRFLFUZEsBl5TabZtXM2nNP4RPQZGgi7P1igV82qAh0xR0dW2rgePOLk+L?=
 =?us-ascii?Q?snsoYpSGCsaycmR+wyucP+bNjyrKOvojtX7Q0wYlBOt5RoGu3FBvmjhaBHIv?=
 =?us-ascii?Q?OFp0aIT8lB8DtpEBi006yaWbv7RaotqCHdDpD0bSN+/T88ZxQUcTgUCuY3Y7?=
 =?us-ascii?Q?1UW3hUV5+6kadFmLgD3VlHNeocvvIbdkgt3W4H50RuTL8OYF8XYVmg9v52MN?=
 =?us-ascii?Q?4k9IMzZW304ntAYw/iTnx34Xcsw/agb3q+nVnhrRLBsOY+jwXvKbUKAxn/Zh?=
 =?us-ascii?Q?kHXrb5BHGWZ3BAu8LE4/jbWBiMpDPSa9nGzacTDEflwAsGPtytHOoeo3vkxU?=
 =?us-ascii?Q?fxlloGflFgssMzWtj6mCIsHrzfJeCFxsrHRAfCDoiVTBoBNT9LUqO/CanvKR?=
 =?us-ascii?Q?CGwgBURGZCkm/4D9iq0RGcm8aWtZ4XS/flTD3XDNBMxqYh1svthXS2tz2NRx?=
 =?us-ascii?Q?lLtbkzu1O1r3yB1s+MclrwB0Nx+ZdsIvLxIniP57A5tyAw2EVXTerPW63J8S?=
 =?us-ascii?Q?YeY6NBhvd/iaH7eyFAs0cSRjYjkyxAnL2++5X0FZWPI4VSpQPMJ6uALZVIlq?=
 =?us-ascii?Q?C1hPkCuJXzCYBe/GzjbFXYRzVx2bArXT3W+jEpq6vfGlp3/ZjXWABdl2RhV1?=
 =?us-ascii?Q?eJFOAUUM5Hx4Lx4Ir5yUvxPPhwg9T2sQUQFlnrAjUVcDCfk4EweTx8nBQpzf?=
 =?us-ascii?Q?Cwemf4NNqSsWmo0KQT79vOe/l+gwH1grRaqti0WBqT5p5TEKZdWLKHRR9dKu?=
 =?us-ascii?Q?1CNYEk1grn2ccITc3U/uSvLLWJxewhMrpDJ0fmbi/PVqpTS4tc5OGVkhUQck?=
 =?us-ascii?Q?0gTcSxzwAhpo9FeMc5rA5t2RlcvyW584vjjMOd7q+6WtylnndvhGSrM0d2EZ?=
 =?us-ascii?Q?3Mhcyx633MuDFXXudX9uq2NcIGWkZM25NAifAmifx2k7j1ygs/vEzjlE9huB?=
 =?us-ascii?Q?1RA0J2ADtFIxe3T/tU6SdhaKfq0wOeNe74tI9hxW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a413e6-dddd-4baa-6593-08dd4f5fa279
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:30:32.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDX/AijQNmuGBAZeb48amHfQAR30I3zjy9wQvE/Ilq1/AaB0RenB8KxRkaCToVfbnH+RHx8dui/NBxxdcuQxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

On Fri, Feb 14, 2025 at 06:52:41PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On EPP only writes update the cached variable so that the min/max
> performance controls don't need to be updated again.

This also paves the way to get rid of the cpudata->epp_cached variable
which you do in Patch 17.

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>



> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1304bdc23e809..fd2b559f47c5c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -336,6 +336,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value;
>  	int ret;
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> @@ -362,6 +363,11 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	}
>  	WRITE_ONCE(cpudata->epp_cached, epp);
>  
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +	value &= ~AMD_CPPC_EPP_PERF_MASK;
> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

