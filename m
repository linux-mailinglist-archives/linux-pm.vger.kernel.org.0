Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC7F211A65
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 05:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgGBDBw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGBDBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 23:01:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D06C08C5DB
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 20:01:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so12733651pgb.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKKNTT8pA7O67OgNnb6AO36mHyhlEaO/ODFH5iFbjNM=;
        b=AyPvqL65OszIANNa7RlNshUwuqXqnecC2UHRKr86/uKOpMUOnrbqLv6opCoAQKswM6
         Pl2gA51+SZatHMckdbShLpCeyUmv2Pc1U/SF+LahGtpUL388m1BGXcwfCo9+LqXMZjS4
         MrDxTwYyrKfekyqv4Q8sfXCxtekavD8aEsab+UW1SHkECbb9qUqpv2mfFNMZJr1hZfhU
         XKJgRcApRCDlIqyeFgBvMyj9tpbtd9sgGciUslcYXXhzTByuq3bgcFXM4Rkt/JMO44qf
         cbj5QU0LmcNJ/2arl3Tbk6oApjgcqm0zRWTPdvHhmWgYHILCKSwwBoNEzS7vkmJlgvFF
         WnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKKNTT8pA7O67OgNnb6AO36mHyhlEaO/ODFH5iFbjNM=;
        b=MvZ8VhC54U7bq6oh63Qc+eUC8mwLkK3Baw52/14ZxxXbyJNPlYYOi+LeuIh3WBCdmG
         l4MhCXxju8HTeGIP1MBpShGoYrZJbMcUxdchLTjT7e/busuCfJfGjbapsdReWFyMukZK
         Y8YKIhevt45BkFyztQiMnI/WUe3hO1PDIHC6v/T4Lt3fpAqDSWgcMnt1wULHe3PhiMOy
         CMWyEIVPeKfMZM8zIw815pdOZ9twti38wjgHc3bDCZjYn/gaXf4kesguKauqLFqFZTiI
         zTPZd0NTlODmjR/tzvNghBfsp7N9AsA+fsj1/eOn17+Nol7R+7kr8iUrkg6o4WSKSbQS
         tj9Q==
X-Gm-Message-State: AOAM531d3p50Q2YMmUl9bNHExuKdGMs16HKGx1xWYKYvkR31OxwdE3fU
        MCwgcoTbNJymYYKy3me/5D/dcA==
X-Google-Smtp-Source: ABdhPJytc/nypcLQUyeT63p6HbP6YUj+inG3XCbmjU0TcqNuXgIHHVJCJoyU67AfhCoXcQzQiN19mw==
X-Received: by 2002:a62:140f:: with SMTP id 15mr25885220pfu.50.1593658911615;
        Wed, 01 Jul 2020 20:01:51 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id r6sm6628604pfl.142.2020.07.01.20.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 20:01:50 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:31:49 +0530
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
Subject: Re: [PATCH 2/8] cpufreq: move invariance setter calls in cpufreq core
Message-ID: <20200702030149.stwqpozhrspjz7sp@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-3-ionela.voinescu@arm.com>
 <20200701095219.gxrkowtukosnfmwp@vireshk-i7>
 <20200701152751.GA29496@arm.com>
 <CAJZ5v0gg4CtixKXEWG4agPATJxm5NZ4bnNVsqt7mRpwZS0Nygw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg4CtixKXEWG4agPATJxm5NZ4bnNVsqt7mRpwZS0Nygw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 17:51, Rafael J. Wysocki wrote:
> On Wed, Jul 1, 2020 at 5:28 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> > > On 01-07-20, 10:07, Ionela Voinescu wrote:
> > > > setpolicy()
> > > > ===========
> > > > This callback does not have any designated way of informing what was the
> > > > end choice. But there are only two drivers using setpolicy(), and none
> > > > of them have current FIE support:
> > > >
> > > >   drivers/cpufreq/longrun.c:281:    .setpolicy      = longrun_set_policy,
> > > >   drivers/cpufreq/intel_pstate.c:2215:      .setpolicy      = intel_pstate_set_policy,
> > > >
> > > > The intel_pstate is known to use counter-driven frequency invariance.
> > >
> > > Same for acpi-cpufreq driver as well ?
> > >
> >
> > The acpi-cpufreq driver defines target_index() and fast_switch() so it
> > should go through the setting in cpufreq core. But x86 does not actually
> > define arch_set_freq_scale() so when called it won't do anything (won't
> > set any frequency scale factor), but rely on counters to set it through
> > the arch_scale_freq_tick().
> 
> Right.
> 
> So on x86 (Intel flavor of it at least), cpufreq has nothing to do
> with this regardless of what driver is in use.

-- 
viresh
