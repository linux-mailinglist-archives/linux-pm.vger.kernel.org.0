Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27099232A84
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 05:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG3Dlf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 23:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgG3Dle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 23:41:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9EC0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so3456624pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwTsd3u9TKrgBcA6Qz/hEukqNQY4MFVBnr/oej/t/jY=;
        b=ZJ8AcR0wT+TC/a+JqYHcv0gv1nV8vfoW4iv/UpEC/ZTJBVuFOqoHHa7HwpIbs5FnDJ
         iy6pMxHeC4okSPnbrvgsvfpzMURTn6uadjCYqvKB19w8zvHGDTeGDoahVg9A/Yj+wfQ7
         +WgLnaiHd7JLW282RzqxcOU1d/6C+2zSx8m0ci1wdlYkybL/M1jWOrLIg5ZOnZZ3dFAn
         Tgb5HsY5j3j1UkElntS5xp6e7u/f5ShEG7Vm8EBU4/pWU6NpFRwrdD1rnEOpNFcjKkNM
         HA025/k3T+9KoNQXWUgrMa1vXhxdIejoHXYckby2Ib81n2ase0Wh+zC0t9qqKUKzTIq9
         UIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwTsd3u9TKrgBcA6Qz/hEukqNQY4MFVBnr/oej/t/jY=;
        b=d3rbzyzAwTzytYrT/YHduxRKo2DimFSEt2isnZ0/ob2bKL7qVPzW7wmt2Cdw7EBRue
         t8l8a0rduydgyN2Nmvgsz7Su1hDKwzYj8oBlZQA3YiH0DnF3C07rfc7rp0dYwu5JEyLs
         E+Xk8jiNI19CGzaTWMt8dGOS4bZTvSPLpwlf6CueZ0DvjwuqEQq3o7mLNdtbgYx5TFkf
         zH45f/VVaf+WgCaNTo0TKtU3BUBWiQGWxte8tM9o1YlZhlhEv30PpvuWGlveDRcvZqyz
         cf2GTyh/hos+yL8v0BjPmeasMxrW53ryMtDEeSNwZHDyJxn9TEVemQcmDFuO3s6sQ/mZ
         WVUw==
X-Gm-Message-State: AOAM531C52BbxX2yuq7QR8iC7CpQHYQc4rEKu0+biPq5RUbrkBoxcFyr
        ZnOBO8PJvpuh3DYrKzGM4S9Iug==
X-Google-Smtp-Source: ABdhPJxQQF0rlpXk1DGDtLCYG0sOy3hlhmmFVvQz0dYBui/t3MnyfKQhdZVqeLiAv8MS6n38S5pqgQ==
X-Received: by 2002:a17:90b:3685:: with SMTP id mj5mr12980659pjb.123.1596080493101;
        Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id y17sm4049374pfe.30.2020.07.29.20.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 20:41:32 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:11:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200730034128.k4fmblfuwjcmqdze@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-2-ionela.voinescu@arm.com>
 <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-07-20, 15:48, Rafael J. Wysocki wrote:
> On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 036f4cc42ede..bac4101546db 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2058,9 +2058,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >                                         unsigned int target_freq)
> >  {
> > +       unsigned int freq;
> > +
> >         target_freq = clamp_val(target_freq, policy->min, policy->max);
> > +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> > +
> > +       if (freq)
> > +               arch_set_freq_scale(policy->related_cpus, freq,
> > +                                   policy->cpuinfo.max_freq);
> 
> Why can't arch_set_freq_scale() handle freq == 0?

Actually there is no need to. AFAIU the freq returned by fast_switch
can never be 0 (yeah qcom driver does it right now and I am fixing
it). And so we can drop this check altogether.

-- 
viresh
