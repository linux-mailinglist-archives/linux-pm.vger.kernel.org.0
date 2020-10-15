Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888DE28F63B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbgJOP5L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 11:57:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43593 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389713AbgJOP5K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 11:57:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so3326028ota.10;
        Thu, 15 Oct 2020 08:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4GgpJhvEPw5RrmkaieTPcF/Ng6iwVy7UMFgWDDaTjU=;
        b=TJTDQ36rTUSbUG5hOOlDHPE0atfzD8ymRTXloqoWPFI2RNEzhC21z/g8dRzHsqthbD
         QAu0RN+Lnje3WQ6l26b64GcX5PvuiTV5Hx3tfr+R90oCqvepTQjJyWreR1uX6wAlNlDl
         5pRCAsCG0vhOuLbskdfr/yMcOUylfh/N/SpMqP+eh4lkUvnH06DA3TgfShcLXm31IFKR
         9fazbrsYXbTleuDK12Ks1iCEOVzCfBC5taJtu0BLp0sBWRWkvo0Z0UftgXLNTQj6Zkqx
         6FuBLYZp29lBFw+3iYRmUvOHe7bK70iWVwcZfpRFXvEFJmgufcqD0HusPXoC6a0m4xhl
         axlA==
X-Gm-Message-State: AOAM531pWBPEG8wetuMCr1rHgAPQAVukG5jQudc4VtVJZe/qdYXb1zYZ
        XXbKYmn3OBIdCVKUtzGPOMN7wI8nLNqpgjXqsZ8=
X-Google-Smtp-Source: ABdhPJyoltGbkt59n4Bo3l3lomRSlxR74vdWZMPehbXbYcmhXPVPGK9lsyyM/iMmR5AAB2q/h2XA+bsJcjxkwerJJsY=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr3254584otq.321.1602777428385;
 Thu, 15 Oct 2020 08:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus> <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com> <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com> <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
 <20201012220132.GA1715@arm.com> <CAJZ5v0hMtPARYezJEZqeUZBsyaSggQvtvvfEvONhz6Z=Y32bhQ@mail.gmail.com>
 <20201013123901.GA4945@arm.com>
In-Reply-To: <20201013123901.GA4945@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 17:56:56 +0200
Message-ID: <CAJZ5v0gDfzFpJTLYMD=HsWKm5ORpx=398v+3q9DDoBbAh-aEsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for cpu-perf-dependencies
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 2:39 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Rafael,
>
> On Tuesday 13 Oct 2020 at 13:53:37 (+0200), Rafael J. Wysocki wrote:
> > On Tue, Oct 13, 2020 at 12:01 AM Ionela Voinescu
> > <ionela.voinescu@arm.com> wrote:
> > >
> > > Hey Lukasz,
> > >
> > > I think after all this discussion (in our own way of describing things)
> > > we agree on how the current cpufreq based FIE implementation is affected
> > > in systems that use hardware coordination.
> > >
> > > What we don't agree on is the location where that implementation (that
> > > uses the new mask and aggregation) should be.
> > >
> > > On Monday 12 Oct 2020 at 19:19:29 (+0100), Lukasz Luba wrote:
> > > [..]
> > > > The previous FIE implementation where arch_set_freq_scale()
> > > > was called from the drivers, was better suited for this issue.
> > > > Driver could just use internal dependency cpumask or even
> > > > do the aggregation to figure out the max freq for cluster
> > > > if there is a need, before calling arch_set_freq_scale().
> > > >
> > > > It is not perfect solution for software FIE, but one of possible
> > > > when there is no hw counters.
> > > >
> > > [..]
> > >
> > > > Difference between new FIE and old FIE (from v5.8) is that the new one
> > > > purely relies on schedutil max freq value (which will now be missing),
> > > > while the old FIE was called by the driver and thus it was an option to
> > > > fix only the affected cpufreq driver [1][2].
> > > >
> > >
> > > My final argument is that now you have 2 drivers that would need this
> > > support, next you'll have 3 (the new mediatek driver), and in the future
> > > there will be more. So why limit and duplicate this functionality in the
> > > drivers? Why not make it generic for all drivers to use if the system
> > > is using hardware coordination?
> > >
> > > Additionally, I don't think drivers should not even need to know about
> > > these dependency/clock domains. They should act at the level of the
> > > policy, which in this case will be at the level of each CPU.
> >
> > The policies come from the driver, though.
> >
> > The driver decides how many CPUs will be there in a policy and how to
> > handle them at the initialization time.
>
> Yes, policies are built based on information populated from the drivers
> at .init(): what CPUs will belong to a policy, what methods to use for
> setting and getting frequency, etc.
>
> So they do pass this information to the cpufreq core to be stored at the
> level of the policy, but later drivers (in the majority of cases) will
> not need to store on their own information on what CPUs belong to a
> frequency domain, they rely on having passed that information to the
> core, and the core mechanisms hold this information on the clock domains
> (currently through policy->cpus and policy->related_cpus).

Strictly speaking, not quite.

In fact policy->related_cpus is a set of CPUs that share a common perf
control HW/FW interface which may or may not match the boundaries of
clock domains etc.  That's what the entire cpufreq needs to know and
cares about.

AFAICS your scale invariance rework patches were based on the
assumption that CPUs sharing an interface like that should also belong
to the same frequency domain, which is reasonable and that's why I
didn't have a problem with it, but if you were really assuming that
policy->related_cpus must always reflect a frequency domain, then I'm
afraid that you were not going in the right direction (the
one-CPU-per-policy with HW coordination example should be sufficient
to illustrate that).

It is correct that drivers generally don't need to know about the HW
clock (or voltage for that matter) coordination dependencies, but the
rest of cpufreq doesn't need to know about them either.  If that
information is needed for something else, I don't see a reason to put
it into cpufreq.
