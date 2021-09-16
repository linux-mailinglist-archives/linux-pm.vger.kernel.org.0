Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D640D857
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhIPLUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 07:20:54 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43731 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhIPLUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 07:20:53 -0400
Received: by mail-oi1-f176.google.com with SMTP id w19so8544739oik.10;
        Thu, 16 Sep 2021 04:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VON8Nnjp5qusGMwNpGbLM9r+qCW1152X1jYimNaZ8w4=;
        b=JOR5XIE7JsV66nKW9hyNXOvrlARmr3lo+xhyt45Z4P8RNN/hM5dXQdqruofCFBIRjE
         0RDMVj1I/XOnUCgAI3ALvRd61GlDHBQsX7EyMjJ+4zAkq++EqrofX5ylw55IWpOhUUXo
         1GLOKXlZxD4IML2THd01VOPGpatLRSBzLu8kwTjYOm7oKJ+sFWtcYSxkWQz0KxIBG5z/
         CvJRfE9ollPm+Ksn6hFe5glyy11J1fORQKmkv/mQEB4nG0f8qsztPgLDG2pDyEffO29x
         f5aUfPddghYaQxC8dQiHVoZcKG+MRnOFgRpvr3aZP4rXu+j9amRNBTBXmYWhkkOpkqLU
         OLDA==
X-Gm-Message-State: AOAM530MssaQcveJr5xfJwkaKr5cYiFPb3qKyr1oRwjG5kp+3SqVEN1S
        ycWsOVvXjlWGQEb0QJBEb6HKkQHmxcESX+mhkTk=
X-Google-Smtp-Source: ABdhPJz9ku/9gW7GHbzapbxZ4TYzzIHJWDeMVSP7XWt2WMgcjo8aa2KCZbOtMfb7YNp/QioJa8tAezYHjHjE9hP5YUY=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr3304022oie.71.1631791172836;
 Thu, 16 Sep 2021 04:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210908150001.3702552-1-ray.huang@amd.com> <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net> <20210913081134.GA3731830@hr-amd>
 <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net> <20210913105458.GC3731830@hr-amd>
 <YT88cJCetaGHUItH@hirez.programming.kicks-ass.net> <20210916100947.GE3755511@hr-amd>
In-Reply-To: <20210916100947.GE3755511@hr-amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Sep 2021 13:19:21 +0200
Message-ID: <CAJZ5v0i7OHBmQL-WdaiBsYaO2J6kCqW=YzA8jU6nQBJ2nw0JQQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
To:     Huang Rui <ray.huang@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 16, 2021 at 12:09 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Mon, Sep 13, 2021 at 07:56:32PM +0800, Peter Zijlstra wrote:
> > On Mon, Sep 13, 2021 at 06:54:58PM +0800, Huang Rui wrote:
> > > On Mon, Sep 13, 2021 at 04:56:24PM +0800, Peter Zijlstra wrote:
> >
> > > > > 1) Full MSR Support
> > > > > If current hardware has the full MSR support, we register "pstate_funcs"
> > > > > callback functions to implement the MSR operations to control the clocks.
> > > >
> > > > What's the WRMSR cost for those? I've not really kept track of the MSR
> > > > costs on AMD platforms, but on Intel it has (luckily) been coming down
> > > > quite a bit.
> > >
> > > Good to know this, I didn't have a chance to give a check. May I know how
> > > did you test this latency? But MSR is new hardware design for this
> > > solution, as designer mentioned, the WRMSR is low-latency register model is
> > > faster than ACPI AML code interpreter.
> > >
> > > >
> > > > > 2) Shared Memory Support
> > > > > If current hardware doesn't have the full MSR support, that means it only
> > > > > provides share memory support. We will leverage APIs in cppc_acpi libs with
> > > > > "cppc_funcs" to implement the target function for the frequency control.
> > > >
> > > > Right, the mailbox thing. How is the performance of this vs MSR accesses?
> > >
> > > I will give a check. If you have a existing test method that can be used, I
> > > can check it quickly.
> >
> > Oh, I was mostly wondering if using the mailbox as MMIO would be faster
> > than an MSR, but you've already answered that above. Also:
> >
> > > > > 1. As mentioned above, amd-pstate driver can implement
> > > > > fast_switch/adjust_perf function with full MSR operations that have better
> > > > > performance for schedutil and other governors.
> > > >
> > > > Why couldn't the existing cppc-cpufreq grow this?
> > >
> > > Because fast_switch can adjust the frequency directly in the interrupt
> > > context, if we use the acpi cppc handling with shared memory solution, it
> > > will have a deadlock. So fast switch needs the control with registers
> > > directly like acpi-cpufreq and intel-pstate.
> >
> > Aah, I see, you're only doing fast_switch support when you have MSRs.
> > That was totally non-obvious.. :/
>
> Yes, I should have written a comment to there. :-)
> Will update this in V2.
>
> >
> > But then amd_pstate_adjust_perf() could just direct call the pstate
> > methods and we don't need that indirection *at*all*, right?
>
> Hmm, yes, if we use amd_pstate_adjust_perf here, we won't need to call
> amd_pstate_fast_switch. I saw intel_pstate had adjust_perf and fast_switch
> at the same time, would you mind to let me know how to distinguish these
> two use scenario on intel processors?

The ->fast_switch() callback is for the use cases in which
->adjust_perf() cannot be installed, that is basically systems without
HWP enabled.
