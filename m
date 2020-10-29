Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338B329EA7C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgJ2L3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:29:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34488 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgJ2L3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:29:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id z23so2856462oic.1;
        Thu, 29 Oct 2020 04:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTmhVEmhArZSkMnL1kXTKJ5s2WgAdfUfIbxPkbMwj40=;
        b=BkxZG2DEeiYlhPc6UNRIFukZciMfRVwZYJT+SQwRlkjR3jCOd0O4yMZO5xOuajkc8X
         F4CnIx+MCPG527UxCG7Z1cOj52MwtEyFE9N77vYV2uTKtmPrdPkIsg/5AtR+DOngDhoX
         9guONs90W3Dxtde3eNHwnpypGscK+O7waa3CljA7SrH3JBPikok1hL8tFNDfyFcGmf9R
         4bO/yEEZRJKWCmWqR8jPraVw4Pjj1nNmblt+AybqcnYX3Ip+p2alVvFa+u39K2peT+IQ
         NYOHOlKkydcScEb1C6KCys93Rl8c3c3pPuDRnpfdNV3HhP8torhHRrysyIXmAemdDc5q
         +Srg==
X-Gm-Message-State: AOAM530m1/aqIF7vOQ3CZcBMU36zUuNrmuS10/08r8vK0+cZhq/Z47Nc
        4hcaUZHIIyDjIPyQJNODa0KxKRZaz8zEQrfZ550=
X-Google-Smtp-Source: ABdhPJy+1OwSqcYeXkvDwxUT547LCUyzFYtqQkoEYfYyGGN4u+tNaNTyKk4PF1/+5OBfIUmrBYcAluv2y0O48mgahkc=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2500125oic.157.1603970984766;
 Thu, 29 Oct 2020 04:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <2183878.gTFULuzKx9@kreacher> <1905098.zDJocX6404@kreacher>
 <4720046.CcxZZ2xs9j@kreacher> <20201029112347.prt7ni6jqu2w23g3@vireshk-i7>
In-Reply-To: <20201029112347.prt7ni6jqu2w23g3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 12:29:33 +0100
Message-ID: <CAJZ5v0gSkV3VRf2jgc5oOuoZMf8=NohEYSenDwFq4sNeDViz0Q@mail.gmail.com>
Subject: Re: [PATCH v2.2 4/4] cpufreq: schedutil: Always call driver if
 CPUFREQ_NEED_UPDATE_LIMITS is set
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

On Thu, Oct 29, 2020 at 12:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-10-20, 12:12, Rafael J. Wysocki wrote:
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
> > To address this issue, modify get_next_freq() to let the driver
> > callback run if the CPUFREQ_NEED_UPDATE_LIMITS cpufreq driver flag
> > is set regardless of whether or not the new frequency to set is
> > equal to the previous one.
> >
> > Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> > Reported-by: Zhang Rui <rui.zhang@intel.com>
> > Tested-by: Zhang Rui <rui.zhang@intel.com>
> > Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2.1 -> v2.2:
> >    * Instead of updating need_freq_update if CPUFREQ_NEED_UPDATE_LIMITS is set
> >      in get_next_freq() and checking it again in sugov_update_next_freq(),
> >      check CPUFREQ_NEED_UPDATE_LIMITS directly in sugov_update_next_freq().
> >    * Update the subject.
> >
> > v2 -> v2.1:
> >    * Fix typo in the subject.
> >    * Make get_next_freq() and sugov_update_next_freq() ignore the
> >      sg_policy->next_freq == next_freq case when CPUFREQ_NEED_UPDATE_LIMITS
> >      is set for the driver.
> >    * Add Tested-by from Rui (this version lets the driver callback run more
> >      often than the v2, so the behavior in the Rui's case doesn't change).
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -102,7 +102,8 @@ static bool sugov_should_update_freq(str
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                  unsigned int next_freq)
> >  {
> > -     if (sg_policy->next_freq == next_freq)
> > +     if (sg_policy->next_freq == next_freq &&
> > +         !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> >               return false;
>
> Since sg_policy->next_freq is used elsewhere as well, this is the best
> we can do here.
>
> >       sg_policy->next_freq = next_freq;
> > @@ -161,7 +162,8 @@ static unsigned int get_next_freq(struct
> >
> >       freq = map_util_freq(util, freq, max);
> >
> > -     if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > +     if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
> > +         !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> >               return sg_policy->next_freq;
> >
> >       sg_policy->need_freq_update = false;
>
> But I was wondering if instead of this we just do this here:
>
>         if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
>                 sg_policy->cached_raw_freq = freq;
>
> And so the above check will always fail.

I wrote it this way, because I want to avoid looking at the driver
flags at all unless the update is going to be skipped.  Otherwise we
may end up fetching a new cache line here every time even if that is
not needed.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
