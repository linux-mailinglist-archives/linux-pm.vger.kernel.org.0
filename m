Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51DE211A5B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 04:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGBC6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgGBC6V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 22:58:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C99C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 19:58:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so2584121pfn.12
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 19:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8E2WLP76UAor8xyXwaGyeONvKVqPzozF3LQH+sB25g=;
        b=XtIkoZARBOOxbFgd0psranRYed5UO5Ohw7Nqe6Bo4BHy8xLmycgS8rT3VKuJglyBl1
         OqfUjPceX+p4nMczyVNpTmtES0rWxBM2kOhz8k2BEKSy4Y2yslLmtx2rQwTmgvc8iCBz
         jVaadwMvRIbdAkCwvC2tU7XFvNT9I6B3Pts4Kdaw2HFcxFk66kcrTqLLbi/ez4Fte+Ud
         XJ82xmXu/Xu5yZlintdAeQv81OekuVCa4IiJ8npmgDiMF7RJgyPpEk/ICclIlgx3O3ZS
         UvKbIhfVjR5GFdW5TEEJoY7xqSVHqcuHa3nBiM/xX4ih5+Obfvz7hA1sLaQaKbIEUKOj
         LGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8E2WLP76UAor8xyXwaGyeONvKVqPzozF3LQH+sB25g=;
        b=U7JpKaLOyIea+2gHvDEF7sTVvKuAKN0cOMjF96Okm3s+oy+LT63ERYbGeH4qer0TCP
         c42xBEWOn96uS5BRwXC8COshK9LGCRhUcbnRu/oMJPJeaxpPwM9QH8QynhC4Zuep1Myb
         3SbnBtNKciv9dXc6TIzCKlt5M7I6tjHhww4NWNaq1bYI4shMK8CQmDL8zXqdl0Zp+UGE
         5VeDY+Wyn1uAKj4aAWHr1Flv2SpfiQjJi0X1ie7RIiWA5U+app4qZzjkp8UFFScWnx4b
         NWJzikeFg+r64dX51hy3qNR6fau3MS6OzkHnpKUcsWc4BlV+tiOaHIbnKPsQUBLBUk3m
         kA9Q==
X-Gm-Message-State: AOAM533+5EKbnVBDRGC32JtvhFpTc4Q5JoGcUdeJbk+dJetzOY2atd9G
        qDpzQz9KrmqCguKiRhQPCI7EDw==
X-Google-Smtp-Source: ABdhPJyKZTp5tmDq4Zq7ijoSaWuh2H5kvp93fGeQNGNbfqzUu+TQxqaDaNYLDI0kO4mP4uhmzIQvlQ==
X-Received: by 2002:a63:79c2:: with SMTP id u185mr21742987pgc.84.1593658700948;
        Wed, 01 Jul 2020 19:58:20 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id f131sm7271323pgc.14.2020.07.01.19.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:58:20 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:28:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
Message-ID: <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7>
 <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 18:05, Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:
> > > I will rather suggest CPUFREQ_SKIP_SET_FREQ_SCALE as the name and
> > > functionality. We need to give drivers a choice if they do not want
> > > the core to do it on their behalf, because they are doing it on their
> > > own or they don't want to do it.
> 
> Well, this would go backwards to me, as we seem to be designing an
> opt-out flag for something that's not even implemented already.
> 
> I would go for an opt-in instead.  That would be much cleaner and less
> prone to regressions IMO.

That's fine, I just wanted an option for drivers to opt-out of this
thing. I felt okay with the opt-out flag as this should be enabled for
most of the drivers and so enabling by default looked okay as well.

> > In this case we would not be able to tell if cpufreq (driver or core)
> > can provide the frequency scale factor, so we would not be able to tell
> > if the system is really frequency invariant; CPUFREQ_SKIP_SET_FREQ_SCALE

That is easy to fix. Let the drivers call
enable_cpufreq_freq_invariance() and set the flag.

> > would be set if either:
> >  - the driver calls arch_set_freq_scale() on its own
> >  - the driver does not want arch_set_freq_scale() to be called.
> >
> > So at the core level we would not be able to distinguish between the
> > two, and return whether cpufreq-based invariance is supported.
> >
> > I don't really see a reason why a driver would not want to set the
> > frequency scale factor

A simple case where the driver doesn't have any idea what the real
freq of the CPU is and it doesn't have counters to guess it as well.

There can be other reasons which we aren't able to imagine at this
point of time.

-- 
viresh
