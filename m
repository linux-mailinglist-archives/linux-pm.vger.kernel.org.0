Return-Path: <linux-pm+bounces-35830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D7BC7595
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 06:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5123B0981
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 04:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F824169D;
	Thu,  9 Oct 2025 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="05cfX2nR"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D761A9FA4;
	Thu,  9 Oct 2025 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983125; cv=fail; b=p0l3KNu6Un/Pp2iW+JMsIYCoXawZvi/PqcQUu4kXnZQ1z8lA3i9enGo2qmzPUb3wNLzQ2URKeCsHaRPC5tmVSK/79qbv1/Ap1Ikv7txZXvLp3rppPwssliCRkoxqdEiWXMILbwPuhEhaehqOtpHPFr9eMfF5iEIth8WaNDyPNG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983125; c=relaxed/simple;
	bh=Zh+/58+/d6fjfBKt+fcx960jgts5o/2WTGU9zKgb/xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SwAYSlPFG2NF1FVZ+HDPrBEakzYOj2k4BxKfOOQ/IihUmYLnvmky4ELbKqFA8n6K8tRgpB6xzg46l6SAe37IBJEGalGNH3Xq/D2AsOrqNqCLrWR5EnKi62b1sNo3eHi5T3XnwuzWdx6xA50zfwSsLAlH3S5DV+Oc4nkVBLRcXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=05cfX2nR; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7IPfoAYzYmVpK0Z5pAGIF64W4sVgIUVF2gFpIwy/0fP59DToRRH+P7Da+wc6vtO27vCyYoS3XPwXPj76u+49fRwwzcDLyJ/yy4fixInsCerKMIwtglg8+/xZ3mNbJ+S6Bfb/n67r29QvNzmE5RkUbHXFdlOpW9ufGjSgVCCpjFTukwijBoQulJ76n8ZAhOGhFyyZF1VYfHMre1Df8R05f+I0VRbjfaewEyFoXD1DsJgQ3U/nQIOuvI7XBHzdT/Dv9eqWXosMpPOeE+IirAwZnt/lSF8jz32hHjQjZnP6srgXantADZcp1clKnxpEjVg9q2yTcWu7y8kByPEvHkz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzEiDxr87ZZ+HMnc3tKCfQpUGx/ih0YDw7kfljlja4Y=;
 b=zRWfnxhsaguO022a6adagobrDA+YvUDsz8icQKrHTjEhuN2rjPP5F8PkGGSSpgUfz9rmRf17wKjkXgOLeh2spRTa5zQ6C4UNRdy3y3wo5Zz5Q05i4oFYr25yE10h10cSsjGNEdmQxTOrEbJlpEUEDzfMXji8Cn9yW+Z7xgsRty8SeSesE8AZMTLbXcQBX/bg6tzqFAj2TbMp1KEHQsbMG+6QYHo/d/ZHuMk1nvL8jszwM9wnedTKNGzyXRulAjxsRrebPIMM9U+Huwzsz/MVP0PaYAulMIaaRRq2Nyo2l5oDM84tpHDGnafRsnK26djp+TtCaFGOLeVWHL1JcwjEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzEiDxr87ZZ+HMnc3tKCfQpUGx/ih0YDw7kfljlja4Y=;
 b=05cfX2nRJJfLqIZ2haZIlINlQcOWyVy4t68K4VWW1LAS7XCucD+qwtUxirpb78jgyaDvbRlt6c7XxXWFPeZb1aIlzD7L4G+XDa+iJA4uI2BL92Mm2FndAEYGDfkXIFFlqTR3TmQ2AQy6lXhjBMwtUxk2wdi0rrTYH2485zkgnT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 04:11:58 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 04:11:58 +0000
Date: Thu, 9 Oct 2025 09:41:49 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0
 after hibernate
Message-ID: <aOc2BcT9NUCO8HJp@BLRRASHENOY1.amd.com>
References: <20250923152929.1306578-1-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923152929.1306578-1-superm1@kernel.org>
X-ClientProxiedBy: PN2PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f5a8ad-8dd0-4c37-4fce-08de06e9fc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJwn+2eWxMOp7wEecEa5tyo/cTnwyzMKCekyfklyG+KLt8FFFqOjViR9Red6?=
 =?us-ascii?Q?b6/DlI2RrvA94lUuneQhEpAB97WlUHz9gBHZSzh8V+YR4eUKyet+mN4xQYx/?=
 =?us-ascii?Q?iOODZnkWRgALnbskrATmBup4C/YJi/lBOsU+dXLFWrX6Sh5bX8MtBbxSSuZ6?=
 =?us-ascii?Q?mfc95L+7C824UUI9KkueX6prUHYaecG9tvhraoTLet+tO5KztwDazMPaFNa2?=
 =?us-ascii?Q?vT/nnS8T0y+8ckgMKpGQMiowy52LICTmVyls6XgEooaLl/zi5Hi9X8Cq0fv6?=
 =?us-ascii?Q?Y8o/gvOY7jeCg1pEyuIPwvo1EAvybiNrZ238AhXvfm3djPTfEFoR8TNUeZRc?=
 =?us-ascii?Q?tuIzA/cCgeE0w0hWaEAejgqCD4PUx+JRDLf0Eyf2ABxwXXCc7mcEQzm0KXbi?=
 =?us-ascii?Q?SQIk/7lm24cTPcaz7fjxu+QeXCx7UVXrQQyCrjGD9OShaLxjzXNTDhcYBYIC?=
 =?us-ascii?Q?uNUtr5MBcDvWYtEBr205hfCI+tCWsaCbpKRiQ7p7VH2hDHsr2FYv0+gpl0bL?=
 =?us-ascii?Q?sEyrB/rF7hOFnX4QpPv2q7eNHqBtPTtSSMAl+rwfei/FvvVENR2X2+hFoM5q?=
 =?us-ascii?Q?U1juIBglVtjJq+UHzAAHjUyTW+2gDodFbfl6plTpbICKOjK466/+vIiAln63?=
 =?us-ascii?Q?YDJM4xHtcTu1MhZUv8TYmLdHkilhGiADMZ3fkLGksJubDmylG/t1TnkHHQNR?=
 =?us-ascii?Q?2GJpljTKChvjZtIQ7DRTzSDPv32B0+qdkB3b56IaF9rTvNJOyV529MO44A49?=
 =?us-ascii?Q?/0Dc1NuKWeh3xcPpreM8OnnfScpRf5mmGe3KGYgz4G8Tcda5K9yMq7E3Bwe1?=
 =?us-ascii?Q?bcWa3W1AtLEOFrKgUpL4UNyKOXyEce3gKzawQ0yhzxXP8m8+CFT3uRxXTRqv?=
 =?us-ascii?Q?shpRcOygOFJohWR2ajDgGE3QJXaAQlygyvm6atR4q7tYRzxf2ygK9IYZGVzN?=
 =?us-ascii?Q?O1L6m9f1AJlF7yN8jHnyFLuQRGgwz74zP6C1PNR/srHID/+3nwW168iJwlIO?=
 =?us-ascii?Q?w6DxpAaNUvcRPWdnC03L3GoGiqb1VAtib9DKUwP3gG1/EGaj5h+lDyhf1bnq?=
 =?us-ascii?Q?f6oi6LSr789x5fnKjFNRfwa8By4tJxEZamNC9azHCNhAcW1rdrKbBkhBWz+h?=
 =?us-ascii?Q?L2fQ0RmZBaoSJk9K5mOZcj4ci32vJPSbK0Wc8bHLCuc0rLECJQt7DHf0lYy4?=
 =?us-ascii?Q?vTDwTAEnAKO263O1VZRi8QTxizNP6r6X6FW5sHGb7OQW+vEX34o/r2TQwNzX?=
 =?us-ascii?Q?0M2dWea2RLzHJI5BnEzJGI87PfRZOw5x6kiEyQFX9ivBdqwocEo3mKzFCC7D?=
 =?us-ascii?Q?ODsRXIzf+s52PlpLX80Kfv4xIrEYAz45HQ90DOwg0D3IMmt/Q2Ag5PyLnDHZ?=
 =?us-ascii?Q?lQRQDhqW0dKNFb5A9YG6x6bm3k3256KiIGWhCjVI/2jBbfJtrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSxuOsG3uxGcSvTV/RrQgswe+Bx9dWYcnAwcUeYXcrQzjhcFOghuirJk65y3?=
 =?us-ascii?Q?1jt5gl8euuOLme3jWzjIpiAOcLa92Wc6mMAhaQdpQiP+wARSPF1n5hPSRUrr?=
 =?us-ascii?Q?L4UOhuZmESYZzoWcYrdhUNg+ZGLydURvlywsdnM8RPLMrzBHKgpGVx06Ty8Z?=
 =?us-ascii?Q?FsYk5jVlw5EqnnqUFmskGdcqxtZODMTNpgVG8XmSZx4hztBGKsNbxqXzAEQH?=
 =?us-ascii?Q?oXe42ERLXGayyGMunbGwnHqIyLTD522g+9ypid6jiY2C8dUb7KkhZgsj9f1y?=
 =?us-ascii?Q?8lOrc/rqs3xC0iJfeeT7bNSxk2qzYCwhi0hu5vsXncDQsbTdkkxOQJF6X5Wf?=
 =?us-ascii?Q?dwBRhSmSKsKwnpl57AFIDBshkrIdC/HowFqHOo/OO+pqx+z1RKj1yjN1StdZ?=
 =?us-ascii?Q?bofLCjFPlK2n2goTrH+6nVQS5Ku4uJR8pDzjcWcx+tooRezBFKUyO0HY8nWx?=
 =?us-ascii?Q?6/VDwV/Mo+00g59ZikZZ5rImGB7cJktdM0j7OYBdurzmjnFYcEglWw1ktGVA?=
 =?us-ascii?Q?cAm/MX0WphUwx2PfAqM5KKmuS99q+PdsF0rHnHyxA72vEYXndH6uR5kyCtsU?=
 =?us-ascii?Q?ojjYWlynHLg2iiImrx5AdJyG4AiqGMmNI5viZ+KwRteVa9II+GrG6ICFX3k9?=
 =?us-ascii?Q?4TuWnA267MfYRG0G+qCVBiELkIN3ST4wK7y+aRMC1VRvUkta4hxY7IwLhoom?=
 =?us-ascii?Q?X55qyWrkjB09GNEj7T0WylIiCcTU/FCLjBKLLXKsb3hULDFjKJlNEwY3sfpx?=
 =?us-ascii?Q?GTXdfql6DC0aG9yFZCvzrTpOqgHmf7fWTWu+BDzHC1kSjrj/YxGP2kDJAyBa?=
 =?us-ascii?Q?TviMmF/d+3THZ1ejX7SfO+Oe3lDuYGdc9kVO4GNCmjgw4wxf+gptL4mU0ARe?=
 =?us-ascii?Q?Zs68oiwzSNJzWnH74+GFxbONvo95e0x7ibMF7PMx04wLsYiSUrBjQyhZkMJu?=
 =?us-ascii?Q?IXPEF4JYBZI24N76/KbnzZ0An6tmkipoGLCIikHujaUvLYncDvie4T15k6ms?=
 =?us-ascii?Q?WG2U1qP1AuUXZZ2MuuetkBHuKCK5zzW4deHj3ULgmmztzvJnovklGlhpAlvr?=
 =?us-ascii?Q?p4oeKvRx4z1uejME09bC0+Bl5sU51nuIzoNuAWOV+IPbO+jfwIfWjIeVGACb?=
 =?us-ascii?Q?elNztiUJJtP3B/oNcvXDyPKsARuiUI4fFqm+AJ8HF8wiJXHf8ST4GkD72BRJ?=
 =?us-ascii?Q?+p9OqfiKdl6rDYIuJVS9xQtv6dyTm78SPXxBjNTDKmAuxQb8V8p0YcTdERM/?=
 =?us-ascii?Q?kFCDwtD4wsSDXmmRtlNWSfGLFicvajElRVavojv1KYCFwtgf3INB3OaFM0jY?=
 =?us-ascii?Q?prI6NDZiGsh1a9IkJZWf1se4ID0wUjWPmm/k7OAJU+1PrN8Akqv//75zH7qL?=
 =?us-ascii?Q?+D5CzwbajRHX0W7pjBzbV2iblBtc81OAW2SPz5qGsKQtKmiFj6c2k1/ri9xZ?=
 =?us-ascii?Q?44NYGCGYJaUTgEjSYJdT7h1fHVAttvkVX73HdwO92hmfikDw0tnpBjn5i3d+?=
 =?us-ascii?Q?n2K17TSbIO9FPMepDTpQo+JbKr0M5NPNFQdnJizZcBMXl4P++2cqfp1hzH3P?=
 =?us-ascii?Q?p+cyYarTvZGjiRN0oosYJcPAe/GlhQmUtL3BVIhf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f5a8ad-8dd0-4c37-4fce-08de06e9fc38
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 04:11:58.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFAfLpH9U35gcXqeTIA7PBFeo68BPrHVGljsXWZd8KMaQQqFRIQVfbdyZlEW+5vjDJ9/H9NzWuLXJNfjbqB6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330

On Tue, Sep 23, 2025 at 10:29:29AM -0500, Mario Limonciello (AMD) wrote:
> After resuming from S4, all CPUs except the boot CPU have the wrong EPP
> hint programmed.  This is because when the CPUs were offlined the EPP value
> was reset to 0.
> 
> This is a similar problem as fixed by
> commit ba3319e590571 ("cpufreq/amd-pstate: Fix a regression leading to EPP
> 0 after resume") and the solution is also similar.  When offlining rather
> than reset the values to zero, reset them to match those chosen by the
> policy. When the CPUs are onlined again these values will be restored.
> 
> Closes: https://community.frame.work/t/increased-power-usage-after-resuming-from-suspend-on-ryzen-7040-kernel-6-15-regression/74531/20?u=mario_limonciello
> Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Apologies for the delay in reviewing this.

The fix looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> ---
>  drivers/cpufreq/amd-pstate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9f3b9dc26ab5..ba2adea03db1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1617,7 +1617,11 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>  	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>  	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
>  	 */
> -	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +	return amd_pstate_update_perf(policy, perf.bios_min_perf,
> +				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
> +				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> +				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
> +				     false);
>  }
>  
>  static int amd_pstate_suspend(struct cpufreq_policy *policy)
> -- 
> 2.51.0
> 

