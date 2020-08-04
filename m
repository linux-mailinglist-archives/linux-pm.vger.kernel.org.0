Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651FC23B4FC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHDG0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHDG0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 02:26:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222CC06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 23:26:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so22264875pls.9
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A9XNvvJrivb8JTq4QeaRMps6wdVFfMtg1N723IohrT8=;
        b=zxYJy5Stx156yltLhRTP9GhksOd2MBnMjQpwNHIWQHQ+Bp0htv+64wpe8tUrSf0uZs
         hVkgWk9tJ4efrQQwpZQYthBB3iRztK6b2ZapTTKQO4YHrYqaEeyEKFB5uy06yJtm+8+o
         fqvcdq+db54bYb0vstHJl+Sc//Nqkzq6bskXZ1FO8n70gd3tlL/HzOh2fOFycF4zjNEN
         e1EgUUW9riQTWujTLwvwcmPSzDqntaiYxvyDIpaB0Z2tm789PN2WgcLE1j1ussb/jF1T
         Ck0QfuEI3IVeM9jBBUAD3THtIPMYfKdzdHjs1MSuZxzPQ4Dj0T7+SgJVNOy3UYtYY5En
         uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9XNvvJrivb8JTq4QeaRMps6wdVFfMtg1N723IohrT8=;
        b=IjsvI7ywCEIOAvBBe9IEq6uPprisOtnnYQreLKbfXMPEntgJKlNtQ9gnpMwoM1pvOV
         rDxUMw5WlSzk20f1CcNWWVJeorsqZqfCAAfOa0ecRC8Q4oA/qbw+flBuT85zg1nMDYxY
         8FV0xBhiqM8o9ixqS9RcdJWOpp1HzSJ7lHtpao4wuFzZBfka+53YxC5SxgdgJCtF+GeS
         tEEfOxMU7SmRBInzOKb7SWz5XnVb7h+s9+gSyNs/0gHwQe7dWiiZKVot80B1WSIOgEZz
         Bg9blhjM1UFz/dnlv1w/RuB6oEAM9zNT9OLJXwB6AZjC2jH/9tku4qksnissoZzig+Hs
         GJoQ==
X-Gm-Message-State: AOAM533vv8RgJ1X4TVkIJxmIwM4heWyZEVAfFdx7Uf09MUd5yjxLB+ZN
        nmBgnvgbPbA3UA+2BnmL196/Bg==
X-Google-Smtp-Source: ABdhPJwuBFWBOL0wZlYQZdtR9A7iPgxvlw2yl0HtQ9dIfmTb4jJy6WHJGuE2cnhX9J0PSHYJUr+dPw==
X-Received: by 2002:a17:90a:bc04:: with SMTP id w4mr2645937pjr.99.1596522376172;
        Mon, 03 Aug 2020 23:26:16 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id z29sm6992161pfj.182.2020.08.03.23.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:26:15 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:56:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on
 transition end
Message-ID: <20200804062611.6jpra73hmhybdw3i@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-3-ionela.voinescu@arm.com>
 <20200730041334.cjg5mc5xpopd2lst@vireshk-mac-ubuntu>
 <20200803135838.GB9512@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803135838.GB9512@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-08-20, 14:58, Ionela Voinescu wrote:
> Hi Viresh,
> 
> On Thursday 30 Jul 2020 at 09:43:34 (+0530), Viresh Kumar wrote:
> > On 22-07-20, 10:37, Ionela Voinescu wrote:
> > > While the move of the invariance setter calls (arch_set_freq_scale())
> > > from cpufreq drivers to cpufreq core maintained the previous
> > > functionality for existing drivers that use target_index() and
> > > fast_switch() for frequency switching, it also gives the possibility
> > > of adding support for users of the target() callback, which is exploited
> > > here.
> > > 
> > > To be noted that the target() callback has been flagged as deprecated
> > > since:
> > > 
> > > commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> > > 
> > > It also doesn't have that many users:
> > > 
> > >   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
> > >   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
> > >   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
> > >   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,
> > > 
> > > Similarly to the path taken for target_index() calls in the cpufreq core
> > > during a frequency change, all of the drivers above will mark the end of a
> > > frequency change by a call to cpufreq_freq_transition_end().
> > > 
> > > Therefore, cpufreq_freq_transition_end() can be used as the location for
> > > the arch_set_freq_scale() call to potentially inform the scheduler of the
> > > frequency change.
> > > 
> > > This change maintains the previous functionality for the drivers that
> > > implement the target_index() callback, while also adding support for the
> > > few drivers that implement the deprecated target() callback.
> > > 
> > > Two notes are worthwhile here:
> > >  - In __target_index(), cpufreq_freq_transition_end() is called only for
> > >    drivers that have synchronous notifications enabled. There is only one
> > >    driver that disables them,
> > > 
> > >    drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,
> > > 
> > >    which is deprecated.
> > 
> > I don't think this is deprecated.

Heh, maybe I misunderstood. I thought you are talking about the flag,
while you were talking about the driver.

> Sorry, possibly 'deprecated' is a strong word.
> 
> As far as I knew acpi_cpufreq was recommended more recently for K8/K10
> CPUs so that's why I decided not to create a special case for it, also
> considering that it was not supporting cpufreq-based frequency
> invariance to begin with.
> 
> We could support this as well by having a call to arch_set_freq_scale()
> on the else path in __target_index(). But given that there was only this
> one user of CPUFREQ_ASYNC_NOTIFICATION, I thought I'd propose this simpler
> version first.
> 
> Let me know if my reasoning is wrong.

Nevertheless, I don't think you need to mention this detail in
changelog for powernow-k8 as cpufreq_freq_transition_end() does get
called for it as well, by the driver instead of the core.

-- 
viresh
