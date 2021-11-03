Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD14440F9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKCMDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 08:03:52 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:6209
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230304AbhKCMDw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 08:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isnfpFx3gYVG2B1J7WEyaYAf8idmwVuYssa5TX/RJTKrbFEJZIHC1M0SghTkcdoBWnSpCJx9yovqIllfQbCHXT6PysXLB4/+s0rokAiEubb4evvBgh7Vj/KpL3AvtisNxa63MBCw6DqQ4ERTckmXDYjP4caCNqUi3j/eS5jTDcoInmDeCvTtgPQlAAJTkUrmkQy3EO5ZKbVQBZ+72qLHknTJ6irWJvckNuH0o0uoHPx64tNyjTpCyPJgmjQkMsWEnlT44kC4asDJMm339Oh0dy3kHiAm5ABorX/Se3/js00AKjsEnmNZ/u13pcodZlGibJhHapfNW6pXxPelri3cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGFZlqyzSONSptzZW/kdjDQW+HJmvl+blbRqnT04jQE=;
 b=hPlKdE9qJZGMLZ6hm5u7Gz0aQ3M4mFqH55qtUfSVzn4f6Ac3kgCj8NJ9Cg8BGS4u2t9BaKR5J4JvnOgmCYpNiSjVHjgp7+RY9cCK/BHz4Cdt+tUUQXGAbXeLzwK/9mviHxqHqzlMO3D4D9aL/75JkY4IrcmsducVlc5tUcchAW0AX2CzcbzIUi84PBUOpJgH0rCa5qABo6y2/h9BAiveq71iRfWz/CLk1lDAjVN6gXNtGGT6gw0fQpmnyUlyTZk1lkRrj7ZCecv/fUABvhgUnwi0jZgetD5JWzfKKPiPLmfAUrH7SxXxrkUGZctBk4CHawQwCYepjjYYWG7Jpw57DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGFZlqyzSONSptzZW/kdjDQW+HJmvl+blbRqnT04jQE=;
 b=j6mbr8Ij36j3yTKT0+BkU4lnNy78WYqyoKqxJ7EHa9oX2HgbWNjKBl73KaDMbwqrSZAsR+SvhgJ2XTjb3q+re9bvWZ/7W8WpyOjokAaUUVOvpOn4EMCJ6nLME/rtdmEvcQlVz3Q4nLsh7DKMs5aBvpVvuEjk49hpv6C2e6BvvFs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1205.namprd12.prod.outlook.com
 (2603:10b6:903:38::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 12:01:11 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:01:11 +0000
Date:   Wed, 3 Nov 2021 20:00:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 08/21] cpufreq: amd: add acpi cppc function as the
 backend for legacy processors
Message-ID: <YYJ568GR/g0rYcT1@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-9-ray.huang@amd.com>
 <33fe4c81-76f7-2de7-6b19-1c6b233b49aa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fe4c81-76f7-2de7-6b19-1c6b233b49aa@amd.com>
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR02CA0218.apcprd02.prod.outlook.com (2603:1096:201:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Wed, 3 Nov 2021 12:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69dc52fb-5d9a-403b-7087-08d99ec1a0be
X-MS-TrafficTypeDiagnostic: CY4PR12MB1205:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12051F93D58972E57A6AA1EEEC8C9@CY4PR12MB1205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j40wm2iFaUpAYI/unUB/Utg4p7cKR6jRUGwj4nK2EckvzN4OrBYYXD2lzF0VynuFFI88nzeEPzAcpGsi7cpkL+tAKtEBthFVjKcICQ93R+pHf7otueIrXpyTzOqpW8abLrmA7U/+Bv+D4XIKRGS4mA13cxD/0bGei23E4vTrZrhlz3TBqCK9I9bTMsFyDBmKVsZazygvHJH2LpwWoAG3p8BJ6BgBr0MPt5znXXSXMV4NMR0cOiTYnanm05EjI67DpYf1pHqBddc8Cnrj/fshw6UK06z/+dY29/n6TyE03ADZaFpS4fvJQew3H14RLjyTbb3xoNJ3CzBIlywyUNeKdbyJVBhiC7JCU5XXGzrzXehVgIXv3NOIrSCIgGklxbYltO1QZEZLQ285etXpwmLzVuRxBWTJZGD5nkp9TMgrVyZcfBEpvK1KVzRmwAHTfEzPFwUglEueDRk2lSWg4MZNsbEyuBpx1Wu8odt7AYfLdRuidM7fRr9fI+2bKM0DTV5VUarB2QPYxUoiQsWaBb8kSECzpYNq/y8uXKAzbU1ow0PGoMzsiAvG82OWUKb10Gfc5Ci23SPANpWs0SHaWTdUg0M4u1mexjQhM+snlj9rcdCVHVTY8NfuiFgAlgb8mwTdLBtqeX6qRGukAcp+3fpouA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(508600001)(2906002)(53546011)(186003)(83380400001)(7416002)(33716001)(4326008)(8676002)(8936002)(26005)(5660300002)(6666004)(66946007)(6862004)(55016002)(956004)(38100700002)(66476007)(66556008)(54906003)(6636002)(86362001)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GpXZ4VfkwqsHVsP/fpWND2LzXW7pbtHyungcUugZtAPWXVsJzhVU7m5Wbh5w?=
 =?us-ascii?Q?YnRMMxL7qmPPB3nRyBXe9ujzjl02EJ5v5j2QwcA48xC4rpyWH+Gr9Nfo8SuL?=
 =?us-ascii?Q?UF+6dXISiHF/OrQaLyNITHfZWAYnIgZfU05lHRaj44OnuRSeHZOip+cErdbj?=
 =?us-ascii?Q?3BC3Zfg0ocAO6OoFMvJbajt5ofYMr+LhvCV8JND/EQ0s1+V1Od1pY/tEVmJP?=
 =?us-ascii?Q?hVdvgKUkD29LrG+hqLfzfHvYCQ2grNoWIf0LVFmcVSOeLuY+YDenpgA3KYSe?=
 =?us-ascii?Q?DS7OmHeoy1fqUXP76uBvW3Gbcbj+BYfOSz4werq4oncWevZ7ZCo44F9Nl3iU?=
 =?us-ascii?Q?q+1FZft+jMb/srMgQnbtXDq2pMYXA1yI3unB7qPm4hWgm8LZu7985gM+n09c?=
 =?us-ascii?Q?mF8ajFzL3nbvw2BaA+eh8ulSNIVjwoK0xqRitwOMtWRu+r5wklTIHne4MjOH?=
 =?us-ascii?Q?mACYSFlMHpLTTG5FVgkVTsG2OO94IlvfhQuRYST9HgKe/hRhuXV7Wzg0RpmG?=
 =?us-ascii?Q?BaqeOYU4UfFDPTPqSNd9epBcB+6izXq3T6CFtre+6AYdmIsR2Xjibe7+lfB7?=
 =?us-ascii?Q?vYdA31U5U2vByHhoZAhyUB2JJ452eEW2sxjSxpvnYQWphDW5ClzNXWrFO8pF?=
 =?us-ascii?Q?hAx/BAO7hY3qMJifIOrhxJvuQwXNPt8D4A07eSrE1L7Fo7Q6B+3/Qx+bJCc6?=
 =?us-ascii?Q?pCpAQMkjquHzu0bokgjyxm1QrqHyphrHUq5O9WDQsAbX2MH5KS5s4HjHOh2P?=
 =?us-ascii?Q?XMdSbzPgYyE5J9Mp6Y8/dsexPvGkC/n6luvTOfRe5bqAFWwUVR9L+crMvouk?=
 =?us-ascii?Q?XZLOJRtIJwjs6vYe23DhMWLJuq2dmLGmVFk84Ah1NPQfxj6CXMQTWjFLllja?=
 =?us-ascii?Q?ZHGm6KWfwV2Eoj6EApxD5T4oc+s1wRWikgQ/09O864CbaGwsIGeRdrwt3+cz?=
 =?us-ascii?Q?XTq5F20ZbgmPP7hPjDBu7el2xi9x86S8ox1d4+j9ClapPq4joq2TsXhu/an7?=
 =?us-ascii?Q?RwaxXKSYeulfH6buDoMTkMSqxEP2J4zSAaxZ3HvnczNjczx0t+xJsWVkElE3?=
 =?us-ascii?Q?95Z+UXiQ6GwIM+g31wf6Rn7xSDJpP1sR3Hz0jxK4b3cGibLBiwSTSMcyKG26?=
 =?us-ascii?Q?X0IRT/h4dX2Nbm6ndpUgRC0sAcI038OOimQROne+EYwYtl4MGAcnsD5sX+e9?=
 =?us-ascii?Q?MqBUs6AM23lEA/1CwMI8yedQSxeWmDTKGH5ZziMTRrcN++HTjeD+UaIb+d3L?=
 =?us-ascii?Q?DXIu3+wPToVgU+ERKQaykJjseP2RwKv4w3aS7qdXMP7zqecE/yhXkD2ZHcYA?=
 =?us-ascii?Q?hiasDz7vJxm7f6aV4riwNZtLmEZBbILzmnEDzp6tNTKYHtguUktrbW+zL4Qk?=
 =?us-ascii?Q?U+RXIE/MMRYYf1qTVZ0QvBrNrOrjPHzLw2BqrVzynJB6fwt8t6B+8JFagGcA?=
 =?us-ascii?Q?TyXrrTJ1JcIQFQG5UHnxZs7HS9FFhyIOS2p47KBMQXIHf9jEgTmnM195F4zd?=
 =?us-ascii?Q?4bdJ6FYzBnmOG5Ed7utHNMgDSjAkOfVJInnQt+ZFySfNcddOv21vb+Io1RhB?=
 =?us-ascii?Q?6lzXbLsCP64gia4j/oJsZx4o1D3QjnNPje/HNeVQFqkXQUmv4qxfu+wBIKL4?=
 =?us-ascii?Q?2bJoZQDfbUlW+umkLuE4KtA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc52fb-5d9a-403b-7087-08d99ec1a0be
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:01:11.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTKq/8IX6Yvvy5zthUWBJBmzGfjIfe3/GougVKqQ7V8vPsw3/YDW2Q+RAN0kIx1NJanG+eZHyKzTLwcf1JWC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1205
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 03, 2021 at 02:46:37AM +0800, Fontenot, Nathan wrote:
> On 10/29/21 8:02 AM, Huang Rui wrote:
> > In some old Zen based processors, they are using the shared memory that
> > exposed from ACPI SBIOS.
> 
> With this you present two different approaches for support in the driver,
> MSRs and shared memory. For processors using shared memory you use the 
> shared memory defined in the ACPI tables but access the MSRs directly.
> 
> Is there any concern that the MSR registers (defined in patch 2/21) can
> differ from what is defined in the ACPI tables?
> 
> Should you use the drivers/acpi interfaces for MSRs also?

That's very good question. Thanks to raise this. I consider the reasons
below:

1. We would like to support fast switch function, this function requires
the directly MSR register operation. And it will have better performance
for schedutil governor.

2. There are some differences between MSR and shared memory definitions.
E.X. CPPCEnableRegister of shared memory solution required us to enable the
field on each thread. However the one of full MSR is per package, and we
only programs it one-off.

3. So far, I received many issues which reported from community, most of
them are caused by SBIOS issues. E.X. Steven's SBIOS has additional object
which modified by motherboard OEM vendor. (Thanks Steven to co-work with us
addressing the issue). Using the MSR definitions directly is friendly for
more platforms.

4. I would like to keep the cppc_acpi as common for ACPI spec, because it's
also used by ARM SOCs. And won't add x86/amd specific things in cppc_acpi.
Using the MSR directly can be more straightforward in the amd-pstate driver
like intel_pstate as well.

Thanks,
Ray

> 
> -Nathan
>  
> > 
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 58 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 53 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 55ff03f85608..d399938d6d85 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -73,6 +73,19 @@ static inline int pstate_enable(bool enable)
> >  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> >  }
> >  
> > +static int cppc_enable(bool enable)
> > +{
> > +	int cpu, ret = 0;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		ret = cppc_set_enable(cpu, enable ? 1 : 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> >  
> >  static inline int amd_pstate_enable(bool enable)
> > @@ -103,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
> >  	return 0;
> >  }
> >  
> > +static int cppc_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +	struct cppc_perf_caps cppc_perf;
> > +
> > +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > +
> > +	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> > +	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > +		   cppc_perf.lowest_nonlinear_perf);
> > +	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> > +
> > +	return 0;
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> >  
> >  static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > @@ -120,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> >  			      READ_ONCE(cpudata->cppc_req_cached));
> >  }
> >  
> > +static void cppc_update_perf(struct amd_cpudata *cpudata,
> > +			     u32 min_perf, u32 des_perf,
> > +			     u32 max_perf, bool fast_switch)
> > +{
> > +	struct cppc_perf_ctrls perf_ctrls;
> > +
> > +	perf_ctrls.max_perf = max_perf;
> > +	perf_ctrls.min_perf = min_perf;
> > +	perf_ctrls.desired_perf = des_perf;
> > +
> > +	cppc_set_perf(cpudata->cpu, &perf_ctrls);
> > +}
> > +
> >  DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> >  
> >  static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> > @@ -346,7 +390,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >  	/* It will be updated by governor */
> >  	policy->cur = policy->cpuinfo.min_freq;
> >  
> > -	policy->fast_switch_possible = true;
> > +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC))
> > +		policy->fast_switch_possible = true;
> >  
> >  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> >  				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> > @@ -397,7 +442,6 @@ static struct cpufreq_driver amd_pstate_driver = {
> >  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> >  	.verify		= amd_pstate_verify,
> >  	.target		= amd_pstate_target,
> > -	.adjust_perf    = amd_pstate_adjust_perf,
> >  	.init		= amd_pstate_cpu_init,
> >  	.exit		= amd_pstate_cpu_exit,
> >  	.name		= "amd-pstate",
> > @@ -421,10 +465,14 @@ static int __init amd_pstate_init(void)
> >  		return -EEXIST;
> >  
> >  	/* capability check */
> > -	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> > -		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
> > +	if (boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> > +		pr_debug("%s, AMD CPPC MSR based functionality is supported\n",
> >  			 __func__);
> > -		return -ENODEV;
> > +		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> > +	} else {
> > +		static_call_update(amd_pstate_enable, cppc_enable);
> > +		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> > +		static_call_update(amd_pstate_update_perf, cppc_update_perf);
> >  	}
> >  
> >  	/* enable amd pstate feature */
> > 
