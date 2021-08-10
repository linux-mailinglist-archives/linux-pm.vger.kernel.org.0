Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479B3E5C88
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhHJOIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbhHJOIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 10:08:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D535C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 07:07:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k29so13680543wrd.7
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnhsN22T/Wy3BmQFqe6fY1qYL5kndnD8Ki55OXkIv84=;
        b=PFnMND/LiQSDMGTQc7wyZt3McaUEceGMY+LXW5W7DSgeHhlWKnd7+CQw3LwUggVh5h
         tcV9tTjYlwkU3nfOEypGRNFEKHRjTX7unhVKPKDcaZ/nbhbaJu2mqbQRYodgnmOUCboi
         dH9FnFIIOacUffFay8cnHILqzsqh+oXn3PQhteHnM32+/O2fk7bNSJh1fKo3+9jJxbGL
         v78NRKLZKHP6mfx5w2u6Pl6O6vLwNVSf10OEyLqxUDy3XOBhn9/2aflcj9Sf9K5iHoln
         rRCvRKt/0x4ukgkYiUqW244lzw0TSwh9BEnlRnaBTtbmJkm7C3j74JDFFiEW+EkmSfAV
         cJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnhsN22T/Wy3BmQFqe6fY1qYL5kndnD8Ki55OXkIv84=;
        b=rhPJ9+SGOEie3aBjuhmVF8+d+vIW9Qlm2cTdVTWmVweEo+erGWyOBS7Cc8WBlOkndt
         6BF5iBXIlVmWEIQ4vuIjky88t77HGvWxS9jHjJLqfAqgslIqY+9y8+bJocsaMTqHQaXP
         4n64kZt3LE/hL9+Rt/yEAQsPQoyPQKlTMm447zD7J6EUtI7cl2TcFz+jT68pHdoB2+0R
         EY1oTVZBAVakohpiNFt2i7c1ogxSXpVhU6mFx88XKxfmbjiTqRcDNRrCZtciFYoOdpR+
         V7Jlxvo1/SSd79GpHIfJww8As/vNo3I9Ij1n/YB4PD9f57BE3ECdwlJB9VfLLQGHvl02
         8Nhw==
X-Gm-Message-State: AOAM531mlBHQkTNWXetlYQT43wBHfsMeQy/xOpu71YyWQuxPNGMI39f1
        sM121cNbTa6nQ8Z0gs1kmUmoQA==
X-Google-Smtp-Source: ABdhPJzA5Baa5ighb0wLidXU347ovV5lY6FZ5W73o2T6dJx5Mj16yi38ep7cYWYIuuvD07llCpHoJg==
X-Received: by 2002:adf:d227:: with SMTP id k7mr2591958wrh.285.1628604474556;
        Tue, 10 Aug 2021 07:07:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e920:cedf:a082:9d02])
        by smtp.gmail.com with ESMTPSA id y21sm2968203wma.38.2021.08.10.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 07:07:54 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:07:48 +0100
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <YRKINFhDmYqvgxsN@google.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 10 Aug 2021 at 13:28:21 (+0100), Lukasz Luba wrote:
> 
> 
> On 8/10/21 7:13 AM, Viresh Kumar wrote:
> > On 04-08-21, 18:21, Rafael J. Wysocki wrote:
> > > The cpufreq changes are mostly fine by me now, but I would like to
> > > hear from Viresh regarding this.
> > 
> > I have few doubts/concerns here.
> > 
> > Just to iterate it again, the idea here is to choose a higher
> > frequency, which will work in an efficient manner based on energy
> > consumption. So this _only_ works for the case where the caller asked
> > for CPUFREQ_RELATION_L.
> > 
> > - The new flag being added here, CPUFREQ_RELATION_E, doesn't feel
> >    complete in this sense to me. It should rather be called as
> >    CPUFREQ_RELATION_LE instead as it is _always_ used with relation L.
> > 
> > - IMO this has made the caller site a bit confusing now, i.e.  why we
> >    send CPUFREQ_RELATION_E sometimes and CPUFREQ_RELATION_H at other
> >    times. Why shouldn't the _H freq be efficient as well ? I understand
> >    that this was done to not do the efficient stuff in case of
> >    userspace/powersave/performance governors.
> > 
> >    What about reusing following for finding all such cases ?
> > 
> >          policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
> > 
> >    The driver can set a flag to tell if it wants efficient frequencies
> >    or not, and at runtime we apply efficient algorithm only if the
> >    current governor does DVFS, which will leave out
> >    userspace/performance/powersave.
> > 
> > 
> > Now the other thing I didn't like since the beginning, I still don't
> > like it :)
> > 
> > A cpufreq table is provided by the driver, which can have some
> > inefficient frequencies. The inefficient frequencies can be caught by
> > many parts of the kernel, the current way (in this series) is via EM.
> > But this can totally be anything else as well, like a devfreq driver.
> 
> Currently devfreq drivers and governors don't support 'inefficient'
> OPPs idea. They are not even 'utilization' driven yet. I'm not sure
> if that would make sense for their workloads. For now, they are far
> behind the CPUFreq/scheduler development in this field.
> It needs more research and experiments, to even estimate if this brings
> benefits. So, I would just skip devfreq use case...
> 
> > 
> > The way we have tied this whole thing with EM, via
> > cpufreq_read_inefficiencies_from_em(), is what I don't like. We have
> > closely bound the whole thing with one of the ways this can be done
> > and we shouldn't be polluting the cpufreq core with this IMHO. In a
> > sane world, the cpufreq core should just provide an API, like
> > cpufreq_set_freq_invariant() and it can be called by any part of
> > the kernel.
> > 
> > I understand that the current problem is where do we make that call
> > from and I suggested dev_pm_opp_of_register_em() for the same earlier.
> > But that doesn't work as the policy isn't properly initialized by that
> > point.
> 
> True, the policy is not initialized yet when cpufreq_driver::init()
> callback is called, which the current place for scmi-cpufreq.
> 
> What about the other callback cpufreq_driver::ready() ?
> This might solve the two issues I mentioned below.
> 
> > 
> > Now that I see the current implementation, I think we can make it work
> > in a different way.
> > 
> > - Copy what's done for thermal-cooling in cpufreq core, i.e.
> >    CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the cpufreq
> >    drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
> >    can call dev_pm_opp_of_register_em() on their behalf. This call will
> >    be made from cpufreq_online(), just before/after
> >    cpufreq_thermal_control_enabled() stuff. By this point the policy is
> >    properly initialized and is also updated in
> >    per_cpu(cpufreq_cpu_data).
> > 
> > - Now the cpufreq core can provide an API like
> >    cpufreq_set_freq_invariant(int cpu, unsigned long freq), which can
> >    be called from EM core's implementation of
> >    em_dev_register_perf_domain().
> > 
> 
> I have to point out that there are two issues (which we
> might solve):
> 1. Advanced setup, due to per-CPU performance requests,
> which are not limited to real DVFS domain.
> The scmi-cpufreq (and possibly some other soon) uses more
> tricky EM setup. As you might recall, the construction of temporary
> cpumask is a bit complex, since we want per-CPU policy, but the
> cpumask pass to EM has not a single bit but is 'spanned' with a few
> CPUs.
> 
> 2. The scmi-cpufreq (and IIRC MTK cpufreq driver soon) requires
> custom struct em_data_callback, since the power data is coming from FW.

+1, we really need this to work.

> If there is a need for complex EM registration, maybe we could
> do it in the cpufreq_driver::ready(). The policy would be ready
> during that call, so it might fly.

I remember trying this, but ran into issues as well FWIW. I would need
to check if this is still relevant, but at the time this was introduced
we needed to register the EM _before_ the policy notifier is called with
'CPUFREQ_CREATE_POLICY', because this will trigger a sched domain
rebuild in the arch_topology driver, which allows the scheduler to pick
up the newly introduced EM data.
