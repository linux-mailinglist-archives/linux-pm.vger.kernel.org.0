Return-Path: <linux-pm+bounces-22200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415BA38215
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563EB3B5DDC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58328218EB0;
	Mon, 17 Feb 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UTJNTqvX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABF21B8E0;
	Mon, 17 Feb 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792384; cv=fail; b=sN7SYdZ/8LIKHI1WvC5eNbU2fBD3lM8neU32G255lu/1KaCf+Orc50sgpqDeR4t4mAPixx3vWs6wDMxfOxTCSMKY65ZQk1AdM3Dcl4dnjnYpujw/scFPBgYVamY6In9ea3odlaxNYT4GvbxZZuTgXOjvLq5nvsXylKpM1DyRfmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792384; c=relaxed/simple;
	bh=TPXMd9bmaR45ssx+cwdhLIvfXrbYOj7kTjIbXcC5cxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orysRFdDT2Nmy+oMMJZ7lAsWIfH09ley7MWPoqXUx1BPCDG954ShUCMant3foQLnaDxGfnLYoqncgIx1TMC9HsrBdCgVzDDw27lpTx5sC0cgnJ1SVdYWRFq2kjkW99vPmg2WZv5rCAGMdtKfbD7y70ZRYfhQppR80aO32NvCySA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UTJNTqvX; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p87Ol4dyV0jalkeixfiDvkxf8XcZpmc/Z8MVei6URzseF0rvtMmBf4nWKMX0++fY3q4aS5ARAGqfQor9C0a3je3jJxOEPkhwB9xFw1L5lDRBT+QNabCWAL+RAH0QxtRMHJtnwCQinb+okNnNMGtBuH6MJsYe6U2Zl/fPl9hWcyXb5PpEwVXmj3yVTeVBP99SRJLGAo4PAoFcQEpdqKMd77Lkc6WIHcnpjOxa8bX57ShjUgi6irPHt0l/QCMfkJAPbpldEe3FvjZ+hXtlM8FhrpMFbejpL7RWLGI0Yl6e6J63yNZgZ4z6cNpd0UowWxQNdeMgKSoZDKHuDqmmjJF81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrXFJt30Bx7Xl/3BBJP5k03/XpVfitjhiXoNnQ0sLAM=;
 b=B9I+dlRdGGG8JH63thkXk8smJAN3mvPZ2Kz2s81ExBbz4CcmoCqlOJpCP7zxePNya7C4SeFOOld0FVmLseUyZv6USwz8CFKLFvBifxjHOtVcZ/U9It90nEvRpsaLroQ/6VzVBg4mLzANjZoVpIMcghl/sJf3PejY7LyM8Wa/ugw/oRqzWdU+7lAyWcVitW5vSZUxfCDRUlztafN8D5WmD4yNA35YtPPbmLgEEZgAJ9WcsOnVlrg3sXbBAa9a5JS8qMV8JFw2KZhH+jHiKePefcx6yZ0qZM90tYicSevY/42WnqpdQbF68W2IMr8JEB2HM5mGA3F+AIC2tPWJulNr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrXFJt30Bx7Xl/3BBJP5k03/XpVfitjhiXoNnQ0sLAM=;
 b=UTJNTqvXWhzdGBrMtBBalXClC6nGWAekz/Tud17hK3tjG87fqsJP3BnDkDY5oBeFLOXF7HbQdj4eusxPmzxLLxOFJVOx9xBdHfY/8JVccWm7VF9uFpVmCVZcYyFddH4FMTlnO4RoXkQ5wch9msppLPMs8nTvaGMStbVjZDI2KNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Mon, 17 Feb 2025 11:39:40 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 11:39:40 +0000
Date: Mon, 17 Feb 2025 17:09:32 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 10/17] cpufreq/amd-pstate-ut: Adjust variable scope
 for amd_pstate_ut_check_freq()
Message-ID: <Z7Mf9PEVSEAnqV57@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-11-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-11-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d48895-9cba-4696-128c-08dd4f47c36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FnewIRbCN39TgtlbaqBOrlC1pwq7Jbv3dKbKO9Zt7GGhTaItSZHztIqBa2/+?=
 =?us-ascii?Q?1vmUQCp+I0VpVRbKPkesJervduEL1jUIew3UI9dI716XkjDIgZ5PaHQ0EVXy?=
 =?us-ascii?Q?5mFv50JPhqA/w+vR8TLOI5hU3ZtNwPY2kXFXNoSW9OAAahJRVmQjJGWAz+EM?=
 =?us-ascii?Q?aqrMq6cFXRKclscXU7P/fob4ND5YdaNYInvlhkSQ50uMAxpeB71mo6wQukJT?=
 =?us-ascii?Q?obb9FwBD7DjNWpz359CxJ82OWpzx8cq3621gXJJfZzYUYGjLOl1q8P7k0Bzu?=
 =?us-ascii?Q?fxkzLboWt0mwoT3qOhmvbBshv987fN3yESnpwYQiojn74TdBHq81LABEiwMb?=
 =?us-ascii?Q?HsFFzalw2K9s8zSVaAR6UARDMfpG5sOm3pwkEQla7RbMQsRrayE8ClWonzS8?=
 =?us-ascii?Q?/BydpCAHSDTTGkBjGDmhSKPrHrXVNgv3ppe/16deNn5FKjI/atGAk4HwRaUa?=
 =?us-ascii?Q?7wel9ZF1m5s/z01jsquwFVSUcpWfk3EhGMaG/XGrM6pA9bOBv/1JlmNgnNUV?=
 =?us-ascii?Q?sFyciluopKm5Djbt3pNiUJAvbTkqNhP1+nHjQXTHuccAtjrf29yRRdqTScUk?=
 =?us-ascii?Q?jk8uYg1WYV66qLXDWbuqoEAeIx7guabuKnl6Il+Unv/QUogFwqFllsZJmhHt?=
 =?us-ascii?Q?yiEQXQ+sCmleYxqCpG0wky8INu4hKFWChgLera69i6QZqHngrJ3H54JpZC7N?=
 =?us-ascii?Q?JthXaRupBRkR8f1lNcMwDXi+Y8afWo/xH9R7SkPeuGWRv1dz6GN/EE7z5wgc?=
 =?us-ascii?Q?HKPi4e6nMz4Be6cv7zM57iBHKdzkB2/zYZMcXWnuEzF0fRspbG9Ybw+lMXGx?=
 =?us-ascii?Q?C3D+g640SPaeE/ATEuA2yUrDFOJ+SEBsUUspWO7AFTefccIk4ASY733+NbxR?=
 =?us-ascii?Q?c1Mlk+lQ5M8e/7o9LnlN5G8MVmOeXZdw2x2TMCJk+SZeDoSPPw85lE98CFvf?=
 =?us-ascii?Q?pAViZM62j4guShI8GDyerOTSfV0h4UjuIUHyAnD3Sr1BBklILRyUFhytu1IE?=
 =?us-ascii?Q?iSAKG4LkFsf5SPx6kevCFHeztxVAEpWVdmFnv1ulbADWBXCX/+oDbeHPfnW8?=
 =?us-ascii?Q?5wXxrtRzYhvEcf6y2q/xLtOAob2nsP7ksuk2DHIAq0ZzloDphPp2XXdjFG1V?=
 =?us-ascii?Q?QBpYGImq8Yjkr4i7pmaUJZR+BanW4lfGAae0ES20/S4aHiLq4gWucvtC++oD?=
 =?us-ascii?Q?3zydxXO87iw9Ux7anCknc4l7NPzuMEXUDkhoS66GKNNNhgffhPBjBr8IJ2Hg?=
 =?us-ascii?Q?0kIRCawLC0sBnuMKT6Mep+2GJWmqR4FxPmXmk4nV0a0dzkXTtIQL9MTCxu8S?=
 =?us-ascii?Q?Y2sFlBJ6pCcaG3l82mgxQ02wCFN29fZD8QXaWhvfNImwW1XxvHlS8XylzJfE?=
 =?us-ascii?Q?KPTkET3TO9mRj7G5EqDyqqiOS9lc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WaFzzAQMeM+/S5Nb/HJNZk1gNhedAVug5u2b7olpjticSblcXyLse+k41Wzq?=
 =?us-ascii?Q?9D3Sfv8o7KfoMr24t3PQNvq9l+MnIXzgcIKJsBeRpzj2FKmDTYtM8grkXetp?=
 =?us-ascii?Q?ITIsH58uUB1l+i15n034UIY7nYAJutcsEYE59v9esqvuft5w62JE3cBqPMBd?=
 =?us-ascii?Q?eCzyJkJKZLs+I6OJk+1yekDZ+6QjpZxCTAP3mngS6GmAUXA9Rl3ybFXj4KDM?=
 =?us-ascii?Q?JfVoY3whuionFuXV6d7a7fBiSJ7ImTtgMXwVDBhdz3tZNoE5NfjL+0HyvZ6I?=
 =?us-ascii?Q?Ay53ZwAxgGUTJQUC60gbm7RE8BsO+0i6BRutp1+7LA1LkVJEvks06d8+5EtR?=
 =?us-ascii?Q?Es7vd2ksIpOReGVmg4rddn+gV9UHZeC3vjrxinYIXeNcV2fgVN/H1DdI2r/l?=
 =?us-ascii?Q?zSotkhWkpC8zRWbYR0qUWkbWiHcsANdWga0XX3ylyzLiallA4Yi0bmQ+iK6f?=
 =?us-ascii?Q?hdEl0RrujUC2CZwR8KM5X8hjGioNd6Xb/lnnXzNpIk/P+iN3FpYnwc21zauS?=
 =?us-ascii?Q?tpNDbGbB8ukeisBGxYp/IMb1VlH+dAcIO4atIm10QPhQBxzMJoiSFYUGOA4U?=
 =?us-ascii?Q?PDu1J46A7lMd7yXmclFtdAF72ocPh1f3LRhSCT1ChldQ+wJG6ZURZgZNLvTi?=
 =?us-ascii?Q?rAgTfWIPJmUrLatLIqHSI+lw5J03V85v9I8glU1HfypaA2xxJd9PiUkFvhXX?=
 =?us-ascii?Q?Q2BIZu8fLjGiOWJF5y22OB3fXdnuWkDuRujGUrce/9VnjxMlHkABx1wH6wKd?=
 =?us-ascii?Q?LjsB3PR9B8he9sbcoFpnbZEBuiXER20Dj0w+1GwTuG5n6LL6gj8RBxezvKds?=
 =?us-ascii?Q?+ASAf/7iv2O+DJrDBDY5/6k4xoRbEtMS/C2v5AWqsDt0R4dd+0zEh+P+Q9V4?=
 =?us-ascii?Q?2yGwV1G73EvumY21dGCcgJfDnC1rEVKmnarTWEy5QxB0Y5kOCXdwMnp2O0ru?=
 =?us-ascii?Q?OSan4z2twS6Zp9Ekebwzz9yPAJZ9KCfLao6MkaVi2SPvIcxjXPvkXbho3/8e?=
 =?us-ascii?Q?6QZ+iGW6f2aWLYkqWfasblQ+ntriEU/FCCeoD9mCU6DxCfsCb+yDSExPE4f9?=
 =?us-ascii?Q?jSNMd7mTNdmBrlNyBzzbFPo9RnE/a/1dGv7T2LgWKcM85uGzOZCKEV9f0z06?=
 =?us-ascii?Q?a9wLeaH3g4yP/euWD9mJUN364EShCJMyEv4QwGWxVqFriQfVZWq0JwqaqTLX?=
 =?us-ascii?Q?ywJnyGVfi3wMW+139p/hnGxR+T/pm2mowkm+UN6AfSaRKNy1BIJnlHeLg8tl?=
 =?us-ascii?Q?xycW16cXRuNCZSsRT/L09pqVPDs3mTqLcKSczgTJ2Y/LEQi+XpoXsMUjGX64?=
 =?us-ascii?Q?8g1GG6zkPqqE6DlMQRFUCvOYUn8wXki4IX/BboGABUECjRVSP2g+pJOnR83F?=
 =?us-ascii?Q?EWGgZyfB9MK0vXSb/ehQ9qNPKvekTEJrxSl0Uq54G/SaqjbU/SZP93IYOYPa?=
 =?us-ascii?Q?vopOtaMhWUsli+cA3DiHtPB4Tilvzg8DJAQgKlaJDwpopw29a3Kn3OtEEVjw?=
 =?us-ascii?Q?+bN3cLZDr5AS/cG0rENpoJfgLOlcxOv1+DTJlVN3F60n4aG0Xrs2W6i1Rqfb?=
 =?us-ascii?Q?OBHwf4xiUIG2wEPD8SZ4VgsD4gqyW48nO19OFfEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d48895-9cba-4696-128c-08dd4f47c36d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:39:39.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myVRK3l8AUNJpqRxHCZJXb7+mZ128Vpxyn4Eol9BOIL1cwyQxZhRyBRwWDD3Tu0e8bvhzv1cUvYvGwMWJZgraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

On Fri, Feb 14, 2025 at 06:52:37PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The cpudata variable is only needed in the scope of the for loop. Move it
> there.

Makes sense.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * new patch
> 
>  drivers/cpufreq/amd-pstate-ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index b888a5877ad93..9db20ac357042 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -186,10 +186,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>  static int amd_pstate_ut_check_freq(u32 index)
>  {
>  	int cpu = 0;
> -	struct amd_cpudata *cpudata = NULL;
>  
>  	for_each_possible_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
> +		struct amd_cpudata *cpudata;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

