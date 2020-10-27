Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88929ACEF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900490AbgJ0NOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:14:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46553 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900528AbgJ0NOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:14:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id x1so1185871oic.13;
        Tue, 27 Oct 2020 06:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FVHw0e9SUzKx9pLi7k3pNny5RbxCRXgmoDZK2DUReA=;
        b=ASyKqCCKA1Qh+/NJtSoW1fi/BSJCjZRLwjikgqECfyJ8MKEqLBEz85EbC0gjOGObdT
         941Hbxb8wfNoEjIbF+8BZXu+TNWyjOySb9U6N1JYFYkawto1YoXBWGbMayj5+ZZRZAnb
         OYiAUMmRCeJd3lU2xYvF2/ovZKocoifxvsiCL3ywMCIsdAgQmtk4YoFpaZu756VEg28i
         xKnE12Hn4bSYpnzCHt1VGkC4fc1kwG2S7wspJGparbCOyvdo+J6gItbteaUyL2dgbD3y
         LjxOAL4V7vodo8US/aWcm9tts3HZeVoQPvhM3nah/KV92gMNlKWodTNXKDVM1QtzKH5O
         Rg9g==
X-Gm-Message-State: AOAM531AJHs+tIJ2z1kQn7gA3pQwEEj1PlvfAjSGbJGtrh6svdx1e6vF
        VskzML663UQa7r/HVkBifD13B35Zb7B+eUVMC3Q=
X-Google-Smtp-Source: ABdhPJwD4C1/jaI/5vT56agxdm0f1gpngWQwcmS6thmFWt5tFyd4CTpBOkR88Eixl835iArv3dnhS2YofqvLiskuPL8=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr1417593oiw.69.1603804472465;
 Tue, 27 Oct 2020 06:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <2183878.gTFULuzKx9@kreacher> <1905098.zDJocX6404@kreacher> <20201027042559.hang4fnpyfd6yqu4@vireshk-i7>
In-Reply-To: <20201027042559.hang4fnpyfd6yqu4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 14:14:20 +0100
Message-ID: <CAJZ5v0iBr7naLmAHV7_jq1=wVqXPMOQaFQ-M_D6j_x3zRH7L-A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: schedutil: Always call drvier if
 need_freq_update is set
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 5:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Spelling mistake in $subject (driver)
>
> On 23-10-20, 17:36, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because sugov_update_next_freq() may skip a frequency update even if
> > the need_freq_update flag has been set for the policy at hand, policy
> > limits updates may not take effect as expected.
> >
> > For example, if the intel_pstate driver operates in the passive mode
> > with HWP enabled, it needs to update the HWP min and max limits when
> > the policy min and max limits change, respectively, but that may not
> > happen if the target frequency does not change along with the limit
> > at hand.  In particular, if the policy min is changed first, causing
> > the target frequency to be adjusted to it, and the policy max limit
> > is changed later to the same value, the HWP max limit will not be
> > updated to follow it as expected, because the target frequency is
> > still equal to the policy min limit and it will not change until
> > that limit is updated.
> >
> > To address this issue, modify get_next_freq() to clear
> > need_freq_update only if the CPUFREQ_NEED_UPDATE_LIMITS flag is
> > not set for the cpufreq driver in use (and it should be set for all
> > potentially affected drivers) and make sugov_update_next_freq()
> > check need_freq_update and continue when it is set regardless of
> > whether or not the new target frequency is equal to the old one.
> >
> > Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> > Reported-by: Zhang Rui <rui.zhang@intel.com>
> > Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > New patch in v2.
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                  unsigned int next_freq)
> >  {
> > -     if (sg_policy->next_freq == next_freq)
> > +     if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
> >               return false;
> >
> >       sg_policy->next_freq = next_freq;
> >       sg_policy->last_freq_update_time = time;
> > +     sg_policy->need_freq_update = false;
> >
> >       return true;
> >  }
> > @@ -164,7 +165,10 @@ static unsigned int get_next_freq(struct
> >       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >               return sg_policy->next_freq;
> >
> > -     sg_policy->need_freq_update = false;
> > +     if (sg_policy->need_freq_update)
> > +             sg_policy->need_freq_update =
> > +                     cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > +
>
> The behavior here is a bit different from what we did in cpufreq.c. In cpufreq
> core we are _always_ allowing the call to reach the driver's target() routine,
> but here we do it only if limits have changed. Wonder if we should have similar
> behavior here as well ?

I didn't think about that, but now that you mentioned it, I think that
this is a good idea.

Will send an updated patch with that implemented shortly.

> Over that the code here can be rewritten a bit like:
>
>         if (sg_policy->need_freq_update)
>                 sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>         else if (freq == sg_policy->cached_raw_freq)
>                 return sg_policy->next_freq;

Right, but it will be somewhat different anyway. :-)
