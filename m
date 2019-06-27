Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8857FAD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 11:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0JwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 05:52:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37319 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfF0JwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 05:52:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so1650278otp.4;
        Thu, 27 Jun 2019 02:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2n+Gc7hO2AU1TLtw3/ye/KC5SAeP8IrV7BHFI2StPVA=;
        b=c7oFQ+8ELBrNPFwm1GudVMEILV0mFOd4LE5mcu6GZxbKp4WMRkCrrJzCUNyUqcvNiW
         p+p7HzWc7hUmWId06eqNKhohX5Sr7LIeBXptiqs4IYEPut4wfeib6kGNd5dhLpclYs29
         FBxpDQnrEpfIjW+nPE6gHMQ3NIB0gBe8gAeFUN7yDU2Ajcbpu09VZkXOMfVdmRE/Ep2M
         Rr+chyHn2chlYrjE8MdNo/QVshZluu5wPFn7hgzuQEYjn11tV6M4M56wv2xfEc+VTTTN
         EVdgvH5bZNO/oTqX5uK/Wpj8twuxy9mhehPNwN1Jq+qi4bAer0aEZfMHZyz+KcuiRmGa
         qU3A==
X-Gm-Message-State: APjAAAVDzp9scz6GLPjKvIl+MRnTxOovMpIUL+D/hON214Og9TbBaHwE
        jwlCK5cnCknQmzXunpxExcm4+uRBt/yjXSf8w4Fvrf8j
X-Google-Smtp-Source: APXvYqy5p1QYnxFFUJg6W1UKJdijrVQj91QwgDho/fzE0+8B24BvA7cQyBBIVhv4+JU26how5rfKiJHKnJZWbftrkFQ=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr2512472otp.189.1561629135333;
 Thu, 27 Jun 2019 02:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560999838.git.viresh.kumar@linaro.org> <88da7cfabad5e19a361fe2843e5ef547d50fd221.1560999838.git.viresh.kumar@linaro.org>
 <20190627050048.b44kitdfuenxnzfi@vireshk-i7>
In-Reply-To: <20190627050048.b44kitdfuenxnzfi@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 11:52:04 +0200
Message-ID: <CAJZ5v0h+1eZGsxgJ5G5OfJiWcyd2GEqxbiU6v4yy9uMvzoAOvw@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks
 with has_target()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 27, 2019 at 7:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-06-19, 08:35, Viresh Kumar wrote:
> > > CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
> > > kernel release commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
> > > issue").
> > >
> > > Probably the initial idea was to just avoid these checks for set_policy
> > > type drivers and then things got changed over the years. And it is very
> > > unclear why these checks are there at all.
> > >
> > > Replace the CPUFREQ_CONST_LOOPS check with has_target(), which makes
> > > more sense now.
> > >
> > > cpufreq_notify_transition() is only called for has_target() type driver
> > > and not for set_policy type, and the check is simply redundant. Remove
> > > it as well.
> > >
> > > Also remove () around freq comparison statement as they aren't required
> > > and checkpatch also warns for them.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 13 +++++--------
> > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 54befd775bd6..41ac701e324f 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> > >              * which is not equal to what the cpufreq core thinks is
> > >              * "old frequency".
> > >              */
> > > -           if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > > -                   if (policy->cur && (policy->cur != freqs->old)) {
> > > -                           pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > > -                                    freqs->old, policy->cur);
> > > -                           freqs->old = policy->cur;
> > > -                   }
> > > +           if (policy->cur && policy->cur != freqs->old) {
> > > +                   pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > > +                            freqs->old, policy->cur);
> > > +                   freqs->old = policy->cur;
> > >             }
> > >
> > >             srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
> > > @@ -1618,8 +1616,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
> > >     if (policy->fast_switch_enabled)
> > >             return ret_freq;
> > >
> > > -   if (ret_freq && policy->cur &&
> > > -           !(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > > +   if (has_target() && ret_freq && policy->cur) {
> > >             /* verify no discrepancy between actual and
> > >                                     saved value exists */
> > >             if (unlikely(ret_freq != policy->cur)) {
>
> @Rafael: Here are your comments from the IRC exchange we had
> yesterday:
>
> > <rafael>:
> >
> > so the problem is that, because of the CPUFREQ_CONST_LOOPS check in
> > __cpufreq_get(), it almost never does the cpufreq_out_of_sync() thing
> > now. Because many drivers set CPUFREQ_CONST_LOOPS most of the time,
> > some of them even unconditionally. This patch changes the code that
> > runs very rarely into code that runs relatively often.
>
> Right, we will do the frequency verification on has_target() platforms
> with CPUFREQ_CONST_LOOPS set after this patch. But why is it the wrong
> thing to do ?

Well, my point was exactly what I said.

The patch pretended to be a cleanup and changed the code in a
meaningful way (at least for some drivers).

> What we do here is that we verify that the cached value of current
> frequency is same as the real frequency the hardware is running at. It
> makes sense to not do this check for setpolicy type drivers as the
> cpufreq core isn't always aware of what the driver will end up doing
> with the frequency and so no verification.
>
> But for has_target() type drivers, cpufreq core caches the value with
> it and it should check it to make sure everything is fine. I don't see
> a correlation with CPUFREQ_CONST_LOOPS flag here, that's it. Either we
> do this verification or we don't, but there is no reason (as per my
> understanding) of skipping it using this flag.
>
> So if you look at the commit I pointed in the history git [1], it does
> two things:
> - It adds the verification code (which is quite similar today as
>   well).
> - And it sets the CPUFREQ_CONST_LOOPS flag only for setpolicy drivers,
>   rightly so.
>
> The problem happened when we started to use CPUFREQ_CONST_LOOPS for
> constant loops-per-jiffy thing as well and many has_target() drivers
> started using the same flag and unknowingly skipped the verification
> of frequency.
>
> So, I think the current code is doing the wrong thing by skipping the
> verification using CPUFREQ_CONST_LOOPS flag.

All right then, thanks for explaining it here.

The patch is a bug fix, not a cleanup, and it fixes the changes that
caused CPUFREQ_CONST_LOOPS to be used for a different purpose without
adjusting the original code accordingly.

I can agree with this rationale, but please fix the changelog.
