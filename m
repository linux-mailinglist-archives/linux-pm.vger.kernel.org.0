Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2539408988
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhIMK4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 06:56:35 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:38688
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239431AbhIMK42 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q96DksjhLyw0rv4mtPemgxg81XEjll74b63OyG1o5t3AxrV5xC2wq06115dytmMJ2Sog73aNKS4ontWi3ZV2FVvEwdim4N8ktLWKMf6nX+uPkzxan0XkCnKSNXA1HPvu0iJQKbUYZf/0g/O0giQmlI7U+BVPnBNT+3YLm8xcoNdQbaF2fQS2o5Z+RgPzYMver5Vo9FdV9EPMyPMGjBopX92SRtgnpD0uaNcfq9fG3gSPc/ro3JXpZlgUANl0KkLbf1DvIYrHZGdKqcBkF3mB2smy5uRaHgmO4h5GV87uZG57tTMVu9x0RxXxVJqccXz2258It85XeIHSzvnapBWb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=T52LF87DwaErpvIDOdIpUrbjy+rMD5K7BsXmhRqKg/c=;
 b=htjB/dSmToBHhoLmJvrzII8e6/Y80ElBbJigUiLZNdvAsx8HvhQhCXpiyEM0XkALf4E7wgEs72uvcxJ69om2U1AJPOR0wPCJG4PmUX8Pg4xTopDoEWhgDQzKDKioMDGaNe/rDgV+Hadh2kvu/zu05APLCFd2hwlTYaG1wVA74dIfkMJgmUfGTscw2+hCEqFuUALOSCyGnam5iMd8qhqRJDWxeoH5CKaKEmr/tBf5gmATQAzvoddmfX8n9fRdGQPAoQ+tFvSL95FLJszshrbgQr5jlZvRcS/kktZ6hJIoHVsk+IZsypIVlXHO/zms1hf3zwD7QVIklob1ztgUpY1G/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T52LF87DwaErpvIDOdIpUrbjy+rMD5K7BsXmhRqKg/c=;
 b=TUHdhT8ptOTKKBAwVnAhoQgSyKeUnEVVq3erAv7+WhVrqKwFFfzon0I1HPGdfDZt2SjQ7WRWYNvBX8mZ+A1+IyLL0bPDqsvjF7wKbXv8GWnPAqrCqhNf0ITreJdFWETIeDNyWayiBNHrrRz9VPiNX+kKIcyDC+2V3onq3oMJGxI=
Received: from DM6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:40::30) by
 MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Mon, 13 Sep 2021 10:55:09 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::1e) by DM6PR03CA0017.outlook.office365.com
 (2603:10b6:5:40::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 10:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 10:55:08 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 05:55:03 -0500
Date:   Mon, 13 Sep 2021 18:54:58 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
Message-ID: <20210913105458.GC3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
 <20210913081134.GA3731830@hr-amd>
 <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e0475c9-de77-4afb-9a56-08d976a4f3c0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24739FCDE23984D122AD0BEEECD99@MW2PR12MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txlvVeu1Yp6Z+sWX1cqwEP7t4HNYf4cRXdBirJwHyP6defQzu6KMIqgOQkDRNP8szf0lfmT//iYE+5SHBn6VAFnokbtLSo6IyLrWtH5y6uOobfpaX5i91ymJiaQdcSUHdNHXJGeQOnEYnrXPuKFiP1TJ9zau59fqEAp1v4eBDDDl4xtUcASf8HCOQTL29rrn4bgURTwjVSgDKeh9dbrqsi5e5BGpPHgyuyvHg/lfdmnHxsTMbzCbSjaSNSe/8pXwKUGhaRehZW9bdSaFsxqIZkb4k4G6Jq+auRiikY65z+unxsGXZ2WL44YQU8hNbNsjaIe/O7dObaHVO8udWJMoxu76GKvv1CoPMZxXSE2gqJ+8bSPqerLiNLsvn08lVryDyyue/5mPExqALnJ4Y1T6DqDqf9rZt0I6wyMAzRv1VJakXaMd2I7hFoJjUxRGnL6JfTEf0dXU4Zmv8wEIEi8MYcVbS8Ks91F/KNF4v3/cd02GQYc/lXhwae72Ha/m7KVyEZju9gL05j2AHPkZGyp/XWiy47E0yuv/R2wQEp4q8PEiy6QTv2U1x4sa6iSe74UhcoIQMliOfj1KrqDgOFGPTBFa0Z5mEFzMA6iA7cp+mbraN+DSaPtso6tca2V5acZOpNDAfPCjox2mJgH+eMy6mN3EUS8E34ipq778UCAgICUMBETpvoYSREExHF0dT7pNFVFwBQ2RDcsP+YcK8N4ZPkmj2+Lzkgjwo+rhkeWp48o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(8676002)(83380400001)(478600001)(8936002)(55016002)(6916009)(33716001)(2906002)(86362001)(1076003)(81166007)(5660300002)(26005)(316002)(426003)(9686003)(82740400003)(336012)(70206006)(6666004)(54906003)(47076005)(186003)(356005)(16526019)(4326008)(36860700001)(82310400003)(33656002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 10:55:08.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0475c9-de77-4afb-9a56-08d976a4f3c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 04:56:24PM +0800, Peter Zijlstra wrote:
> On Mon, Sep 13, 2021 at 04:11:34PM +0800, Huang Rui wrote:
> > On Thu, Sep 09, 2021 at 11:01:41PM +0800, Peter Zijlstra wrote:
> 
> > > What is the purpose of this seemingly pointless indirection? Showing off
> > > how good AMD hardware is at doing retpolines or something?
> > 
> > Hi Petter,
> > 
> > Thanks to look at our codes again. We adopt your suggestion which raised
> > about two year ago that using the kernel governors such as schedutil to
> > manage frequency control for new cpufreq driver.
> 
> Indeed, no objections there :-)
> 
> > We will have two approaches (it depends on different AMD processor
> > hardware) to implement the amd-pstate driver. (Please see details in Patch
> > 19)
> 
> Patch 19 is RST and as such I will not read it. But I think you're
> referring to patch 6, which adds another amd_pstate_perf_funcs instance,
> which I seem to have missed the last time.

Yes, right. No problem. ;-)

> 
> As such, perhaps you could do with something like the below.
> 
> > 1) Full MSR Support
> > If current hardware has the full MSR support, we register "pstate_funcs"
> > callback functions to implement the MSR operations to control the clocks.
> 
> What's the WRMSR cost for those? I've not really kept track of the MSR
> costs on AMD platforms, but on Intel it has (luckily) been coming down
> quite a bit.

Good to know this, I didn't have a chance to give a check. May I know how
did you test this latency? But MSR is new hardware design for this
solution, as designer mentioned, the WRMSR is low-latency register model is
faster than ACPI AML code interpreter.

> 
> > 2) Shared Memory Support
> > If current hardware doesn't have the full MSR support, that means it only
> > provides share memory support. We will leverage APIs in cppc_acpi libs with
> > "cppc_funcs" to implement the target function for the frequency control.
> 
> Right, the mailbox thing. How is the performance of this vs MSR accesses?

I will give a check. If you have a existing test method that can be used, I
can check it quickly.

> 
> > The mainly reasons that we proposed a new amd-pstate driver, not use the
> > existing acpi-freq or cppc-cpufreq driver are below:
> 
> I wasn't really questioning that, much seems similar to having
> intel-pstate, but since you brought it up, a few questions: -)

Thank you!

> 
> > 1. As mentioned above, amd-pstate driver can implement
> > fast_switch/adjust_perf function with full MSR operations that have better
> > performance for schedutil and other governors.
> 
> Why couldn't the existing cppc-cpufreq grow this?

Because fast_switch can adjust the frequency directly in the interrupt
context, if we use the acpi cppc handling with shared memory solution, it
will have a deadlock. So fast switch needs the control with registers
directly like acpi-cpufreq and intel-pstate.

> 
> > 2. We will implement the AMD specific features such as Energy Performance
> > Preference, Preferred Core, and etc. in the amd-pstate driver next step.
> 
> That's the ITMT stuff, right?

Similar with ITMT. :-)

> 
> 
> ---
> 
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -79,14 +79,6 @@ struct amd_cpudata {
>  	bool	boost_supported;
>  };
>  
> -struct amd_pstate_perf_funcs {
> -	int (*enable)(bool enable);
> -	int (*init_perf)(struct amd_cpudata *cpudata);
> -	void (*update_perf)(struct amd_cpudata *cpudata,
> -			    u32 min_perf, u32 des_perf,
> -			    u32 max_perf, bool fast_switch);
> -};
> -
>  static inline int pstate_enable(bool enable)
>  {
>  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> @@ -105,13 +97,12 @@ static int cppc_enable(bool enable)
>  	return ret;
>  }
>  
> -static int
> -amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
> -{
> -	if (!funcs)
> -		return -EINVAL;
> +static DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
>  
> -	return funcs->enable(enable);
> +static inline int
> +amd_pstate_enable(bool enable)
> +{
> +	return static_call(amd_pstate_enable)(enable);
>  }
>  
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
> @@ -154,14 +145,11 @@ static int cppc_init_perf(struct amd_cpu
>  	return 0;
>  }
>  
> -static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> -{
> -	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> +static DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
>  
> -	if (!funcs)
> -		return -EINVAL;
> -
> -	return funcs->init_perf(cpudata);
> +static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> +{
> +	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
>  static void pstate_update_perf(struct amd_cpudata *cpudata,
> @@ -188,19 +176,14 @@ static void cppc_update_perf(struct amd_
>  	cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  }
>  
> -static int
> +static DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> +
> +static inline int
>  amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>  		       u32 des_perf, u32 max_perf, bool fast_switch)
>  {
> -	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> -
> -	if (!funcs)
> -		return -EINVAL;
> -
> -	funcs->update_perf(cpudata, min_perf, des_perf,
> -			   max_perf, fast_switch);
> -
> -	return 0;
> +	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +						   max_perf, fast_switch);
>  }
>  
>  static int
> @@ -465,18 +448,6 @@ static int amd_pstate_init_freqs_in_cpud
>  	return 0;
>  }
>  
> -static struct amd_pstate_perf_funcs pstate_funcs = {
> -	.enable = pstate_enable,
> -	.init_perf = pstate_init_perf,
> -	.update_perf = pstate_update_perf,
> -};
> -
> -static struct amd_pstate_perf_funcs cppc_funcs = {
> -	.enable = cppc_enable,
> -	.init_perf = cppc_init_perf,
> -	.update_perf = cppc_update_perf,
> -};
> -
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -749,7 +720,6 @@ static struct cpufreq_driver amd_pstate_
>  static int __init amd_pstate_init(void)
>  {
>  	int ret;
> -	struct amd_pstate_perf_funcs *funcs;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>  		return -ENODEV;
> @@ -768,22 +738,21 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT)) {
>  		pr_debug("%s, AMD CPPC extension functionality is supported\n",
>  			 __func__);
> -		funcs = &pstate_funcs;
>  		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
>  	} else {
> -		funcs = &cppc_funcs;
> +		static_call_update(amd_pstate_enable, cppc_enable);
> +		static_call_update(amd_pstate_init_perf, cppc_init_perf);
> +		static_call_update(amd_pstate_update_perf, cppc_update_perf);

Thanks again for detailed example, I will update to this approach at V2.

Best Regards,
Ray

>  	}
>  
>  	/* enable amd pstate feature */
> -	ret = amd_pstate_enable(funcs, true);
> +	ret = amd_pstate_enable(true);
>  	if (ret) {
>  		pr_err("%s, failed to enable amd-pstate with return %d\n",
>  		       __func__, ret);
>  		return ret;
>  	}
>  
> -	amd_pstate_driver.driver_data = funcs;
> -
>  	ret = cpufreq_register_driver(&amd_pstate_driver);
>  	if (ret) {
>  		pr_err("%s, return %d\n", __func__, ret);
> @@ -795,13 +764,8 @@ static int __init amd_pstate_init(void)
>  
>  static void __exit amd_pstate_exit(void)
>  {
> -	struct amd_pstate_perf_funcs *funcs;
> -
> -	funcs = cpufreq_get_driver_data();
> -
>  	cpufreq_unregister_driver(&amd_pstate_driver);
> -
> -	amd_pstate_enable(funcs, false);
> +	amd_pstate_enable(false);
>  }
>  
>  module_init(amd_pstate_init);
