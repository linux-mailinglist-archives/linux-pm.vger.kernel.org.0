Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF321408A96
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbhIML6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbhIML6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 07:58:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A42C061574;
        Mon, 13 Sep 2021 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ug9DySFxoOZyEdHs8+gifEeoKIDne0VZ90M+2UYmmSQ=; b=LOlC4gUgQZKsTgDnQImNVgz6tg
        FTzSTizKeuRT+xMMbdfTAJmFRIgqH6N5uW7rZQ/lgvcCnbf+Goy5E8K285YoEYVNiskgfGO1NWGFK
        HacqTR2TMELZKlBTEh5F8Jte3ecd368NLWPDun1aRJUK2E+oX1jSmtR72rQQgzz9foIeT102WnhzT
        6SY5fMdp2tvFrgZoE0Xcz7xzQDUCZBDnKpY6KoS+aEfhj5mRSVPdDpeUSkqK5pjyeG0r91XG5avtl
        GO4UHqrr9yVIvDa9Ji/90vHZTjK6Reum6iu/4Sls5fgIQTfK2DvWUC3QF2lewWKxfB41SnZ8EGK6h
        TgGAb7Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPkZd-002ocN-CI; Mon, 13 Sep 2021 11:56:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77EF43004DE;
        Mon, 13 Sep 2021 13:56:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0FB2BE7CB97; Mon, 13 Sep 2021 13:56:32 +0200 (CEST)
Date:   Mon, 13 Sep 2021 13:56:32 +0200
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
Message-ID: <YT88cJCetaGHUItH@hirez.programming.kicks-ass.net>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
 <20210913081134.GA3731830@hr-amd>
 <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
 <20210913105458.GC3731830@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913105458.GC3731830@hr-amd>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 06:54:58PM +0800, Huang Rui wrote:
> On Mon, Sep 13, 2021 at 04:56:24PM +0800, Peter Zijlstra wrote:

> > > 1) Full MSR Support
> > > If current hardware has the full MSR support, we register "pstate_funcs"
> > > callback functions to implement the MSR operations to control the clocks.
> > 
> > What's the WRMSR cost for those? I've not really kept track of the MSR
> > costs on AMD platforms, but on Intel it has (luckily) been coming down
> > quite a bit.
> 
> Good to know this, I didn't have a chance to give a check. May I know how
> did you test this latency? But MSR is new hardware design for this
> solution, as designer mentioned, the WRMSR is low-latency register model is
> faster than ACPI AML code interpreter.
> 
> > 
> > > 2) Shared Memory Support
> > > If current hardware doesn't have the full MSR support, that means it only
> > > provides share memory support. We will leverage APIs in cppc_acpi libs with
> > > "cppc_funcs" to implement the target function for the frequency control.
> > 
> > Right, the mailbox thing. How is the performance of this vs MSR accesses?
> 
> I will give a check. If you have a existing test method that can be used, I
> can check it quickly.

Oh, I was mostly wondering if using the mailbox as MMIO would be faster
than an MSR, but you've already answered that above. Also:

> > > 1. As mentioned above, amd-pstate driver can implement
> > > fast_switch/adjust_perf function with full MSR operations that have better
> > > performance for schedutil and other governors.
> > 
> > Why couldn't the existing cppc-cpufreq grow this?
> 
> Because fast_switch can adjust the frequency directly in the interrupt
> context, if we use the acpi cppc handling with shared memory solution, it
> will have a deadlock. So fast switch needs the control with registers
> directly like acpi-cpufreq and intel-pstate.

Aah, I see, you're only doing fast_switch support when you have MSRs.
That was totally non-obvious.. :/

But then amd_pstate_adjust_perf() could just direct call the pstate
methods and we don't need that indirection *at*all*, right?
