Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013C64087AC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhIMJAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhIMJAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 05:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E9C061574;
        Mon, 13 Sep 2021 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BaoOxrwu5E23SEQ6dsWokySsSCjybnIYmKbwEMlwcWM=; b=eVF7y5ItxwijRhRkZ8CGq6I8gN
        VcvlddNSNkN6kP6LbPBR6cFdepvkFVBKeT42j3hibnrHRoQZdZbx7K/6UBqd0dHYZcxQIpiKCTjvh
        EvdiSCW53J4QhKm7GMqoulwM8pV1hgSV0XT85qwSPCupgFwMkcOGx4gGpjyM1mxOmuuypc+wanKXR
        YINY3jKGjmIkn7HLI6Wyu0gRKUSfFUkGO0s6gaTosx5cpgg7XhwcL1J2OlcgbWXmcILdvXoKXNGii
        V0zlYvUoEX4JTZraC6SKnvTyKhwu+xoHfXMaybHfOn36qwjMsSkRQI1DFVVeMmR5Ad6rtfxy3OURE
        3Rt1olgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPhlJ-00DL1O-R6; Mon, 13 Sep 2021 08:56:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03E39300093;
        Mon, 13 Sep 2021 10:56:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEC762BD97FE2; Mon, 13 Sep 2021 10:56:24 +0200 (CEST)
Date:   Mon, 13 Sep 2021 10:56:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
 <20210913081134.GA3731830@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081134.GA3731830@hr-amd>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 04:11:34PM +0800, Huang Rui wrote:
> On Thu, Sep 09, 2021 at 11:01:41PM +0800, Peter Zijlstra wrote:

> > What is the purpose of this seemingly pointless indirection? Showing off
> > how good AMD hardware is at doing retpolines or something?
> 
> Hi Petter,
> 
> Thanks to look at our codes again. We adopt your suggestion which raised
> about two year ago that using the kernel governors such as schedutil to
> manage frequency control for new cpufreq driver.

Indeed, no objections there :-)

> We will have two approaches (it depends on different AMD processor
> hardware) to implement the amd-pstate driver. (Please see details in Patch
> 19)

Patch 19 is RST and as such I will not read it. But I think you're
referring to patch 6, which adds another amd_pstate_perf_funcs instance,
which I seem to have missed the last time.

As such, perhaps you could do with something like the below.

> 1) Full MSR Support
> If current hardware has the full MSR support, we register "pstate_funcs"
> callback functions to implement the MSR operations to control the clocks.

What's the WRMSR cost for those? I've not really kept track of the MSR
costs on AMD platforms, but on Intel it has (luckily) been coming down
quite a bit.

> 2) Shared Memory Support
> If current hardware doesn't have the full MSR support, that means it only
> provides share memory support. We will leverage APIs in cppc_acpi libs with
> "cppc_funcs" to implement the target function for the frequency control.

Right, the mailbox thing. How is the performance of this vs MSR accesses?

> The mainly reasons that we proposed a new amd-pstate driver, not use the
> existing acpi-freq or cppc-cpufreq driver are below:

I wasn't really questioning that, much seems similar to having
intel-pstate, but since you brought it up, a few questions: -)

> 1. As mentioned above, amd-pstate driver can implement
> fast_switch/adjust_perf function with full MSR operations that have better
> performance for schedutil and other governors.

Why couldn't the existing cppc-cpufreq grow this?

> 2. We will implement the AMD specific features such as Energy Performance
> Preference, Preferred Core, and etc. in the amd-pstate driver next step.

That's the ITMT stuff, right?


---

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -79,14 +79,6 @@ struct amd_cpudata {
 	bool	boost_supported;
 };
 
-struct amd_pstate_perf_funcs {
-	int (*enable)(bool enable);
-	int (*init_perf)(struct amd_cpudata *cpudata);
-	void (*update_perf)(struct amd_cpudata *cpudata,
-			    u32 min_perf, u32 des_perf,
-			    u32 max_perf, bool fast_switch);
-};
-
 static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
@@ -105,13 +97,12 @@ static int cppc_enable(bool enable)
 	return ret;
 }
 
-static int
-amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
-{
-	if (!funcs)
-		return -EINVAL;
+static DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
 
-	return funcs->enable(enable);
+static inline int
+amd_pstate_enable(bool enable)
+{
+	return static_call(amd_pstate_enable)(enable);
 }
 
 static int pstate_init_perf(struct amd_cpudata *cpudata)
@@ -154,14 +145,11 @@ static int cppc_init_perf(struct amd_cpu
 	return 0;
 }
 
-static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
-{
-	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
+static DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
 
-	if (!funcs)
-		return -EINVAL;
-
-	return funcs->init_perf(cpudata);
+static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
 static void pstate_update_perf(struct amd_cpudata *cpudata,
@@ -188,19 +176,14 @@ static void cppc_update_perf(struct amd_
 	cppc_set_perf(cpudata->cpu, &perf_ctrls);
 }
 
-static int
+static DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+
+static inline int
 amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 		       u32 des_perf, u32 max_perf, bool fast_switch)
 {
-	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
-
-	if (!funcs)
-		return -EINVAL;
-
-	funcs->update_perf(cpudata, min_perf, des_perf,
-			   max_perf, fast_switch);
-
-	return 0;
+	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+						   max_perf, fast_switch);
 }
 
 static int
@@ -465,18 +448,6 @@ static int amd_pstate_init_freqs_in_cpud
 	return 0;
 }
 
-static struct amd_pstate_perf_funcs pstate_funcs = {
-	.enable = pstate_enable,
-	.init_perf = pstate_init_perf,
-	.update_perf = pstate_update_perf,
-};
-
-static struct amd_pstate_perf_funcs cppc_funcs = {
-	.enable = cppc_enable,
-	.init_perf = cppc_init_perf,
-	.update_perf = cppc_update_perf,
-};
-
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -749,7 +720,6 @@ static struct cpufreq_driver amd_pstate_
 static int __init amd_pstate_init(void)
 {
 	int ret;
-	struct amd_pstate_perf_funcs *funcs;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
@@ -768,22 +738,21 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT)) {
 		pr_debug("%s, AMD CPPC extension functionality is supported\n",
 			 __func__);
-		funcs = &pstate_funcs;
 		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
 	} else {
-		funcs = &cppc_funcs;
+		static_call_update(amd_pstate_enable, cppc_enable);
+		static_call_update(amd_pstate_init_perf, cppc_init_perf);
+		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	}
 
 	/* enable amd pstate feature */
-	ret = amd_pstate_enable(funcs, true);
+	ret = amd_pstate_enable(true);
 	if (ret) {
 		pr_err("%s, failed to enable amd-pstate with return %d\n",
 		       __func__, ret);
 		return ret;
 	}
 
-	amd_pstate_driver.driver_data = funcs;
-
 	ret = cpufreq_register_driver(&amd_pstate_driver);
 	if (ret) {
 		pr_err("%s, return %d\n", __func__, ret);
@@ -795,13 +764,8 @@ static int __init amd_pstate_init(void)
 
 static void __exit amd_pstate_exit(void)
 {
-	struct amd_pstate_perf_funcs *funcs;
-
-	funcs = cpufreq_get_driver_data();
-
 	cpufreq_unregister_driver(&amd_pstate_driver);
-
-	amd_pstate_enable(funcs, false);
+	amd_pstate_enable(false);
 }
 
 module_init(amd_pstate_init);
