Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5C2DB039
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgLOPjJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 10:39:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46235 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgLOPjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 10:39:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id w3so19724302otp.13;
        Tue, 15 Dec 2020 07:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hqd4yxV9bNWLklx7MUA8d0AV28BGHOGA0Jz2gfaRP9w=;
        b=Kz87IhZRtdB6bEZn1ErC6/YpL9tjlawlyN2AJCEdXX0761WPD2divB0lrkdzmZBl03
         ggoCWjWim1S8iazYEPeoCn7PN43vXjqHcuB44WH8bK7aGXvHmVF/Z4X5eiOQVwZCHBDM
         3fEAOKFdcbPxVXmOFxjQtcE0mDh1OW0xzunU5nTFV6Mydms5Gv/S4hlZuZNxrfVs/AuD
         wI6WaNVePGfSeQmw8ItZcwqrAnKlcSffooSnO/Fg5oY/E6KH9WyXnh1zmJh+Eew+F2W8
         X2gm7aj15oAfuARnC759T9Kh8FiN87svMCEQ7Obw36ykRAmnxCJe/288yK51aohZQT2Q
         AxRA==
X-Gm-Message-State: AOAM533VHmZ7SrTDH47O/DRCqlMGOGiqxvdCiVrszxPmYoUyaN3oxa6m
        wQEyogbOpImIeIzIEdlbTr0DcaZT6I+22LaZsuQ=
X-Google-Smtp-Source: ABdhPJzSW9IdJA8pduGO8EinZhKo9k4mgoV2r11qrVuGbaTGG1Zg96X4H9auxyJMn4Arg5yprwBSpvJGSi768ydXiyU=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr21697142ota.260.1608046708570;
 Tue, 15 Dec 2020 07:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20360841.iInq7taT2Z@kreacher> <146138074.tjdImvNTH2@kreacher>
 <20201208090207.sz4v43bwvm7yugrb@vireshk-i7> <20201215041636.yfgyswqjslg4hlff@vireshk-i7>
In-Reply-To: <20201215041636.yfgyswqjslg4hlff@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 16:38:08 +0100
Message-ID: <CAJZ5v0jz4=nCfn8+UyR_2PKpL5hNKe8EpamWBjyxmGxwSdzs3w@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] cpufreq: Add special-purpose fast-switching
 callback for drivers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 15, 2020 at 5:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-12-20, 14:32, Viresh Kumar wrote:
> > On 07-12-20, 17:35, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> > > beyond the current target frequency to the hardware and there are no
> > > provisions for doing that in the cpufreq framework.  In particular,
> > > today the driver has to assume that it should not allow the frequency
> > > to fall below the one requested by the governor (or the required
> > > capacity may not be provided) which may not be the case and which may
> > > lead to excessive energy usage in some scenarios.
> > >
> > > Second, the hints passed by these drivers to the hardware need not be
> > > in terms of the frequency, so representing the utilization numbers
> > > coming from the scheduler as frequency before passing them to those
> > > drivers is not really useful.
> > >
> > > Address the two points above by adding a special-purpose replacement
> > > for the ->fast_switch callback, called ->adjust_perf, allowing the
> > > governor to pass abstract performance level (rather than frequency)
> > > values for the minimum (required) and target (desired) performance
> > > along with the CPU capacity to compare them to.
> > >
> > > Also update the schedutil governor to use the new callback instead
> > > of ->fast_switch if present.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > Changes with respect to the RFC:
> > >  - Don't pass "busy" to ->adjust_perf().
> > >  - Use a special 'update_util' hook for the ->adjust_perf() case in
> > >    schedutil (this still requires an additional branch because of the
> > >    shared common code between this case and the "frequency" one, but
> > >    IMV this version is cleaner nevertheless).
> > >
> > > ---
> > >  drivers/cpufreq/cpufreq.c        |   40 ++++++++++++++++++++++++++++++++
> > >  include/linux/cpufreq.h          |   14 +++++++++++
> > >  include/linux/sched/cpufreq.h    |    5 ++++
> > >  kernel/sched/cpufreq_schedutil.c |   48 +++++++++++++++++++++++++++++++--------
> > >  4 files changed, 98 insertions(+), 9 deletions(-)
> > >
> > > Index: linux-pm/include/linux/cpufreq.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/cpufreq.h
> > > +++ linux-pm/include/linux/cpufreq.h
> > > @@ -320,6 +320,15 @@ struct cpufreq_driver {
> > >                                     unsigned int index);
> > >     unsigned int    (*fast_switch)(struct cpufreq_policy *policy,
> > >                                    unsigned int target_freq);
> > > +   /*
> > > +    * ->fast_switch() replacement for drivers that use an internal
> > > +    * representation of performance levels and can pass hints other than
> > > +    * the target performance level to the hardware.
> > > +    */
> > > +   void            (*adjust_perf)(unsigned int cpu,
> > > +                                  unsigned long min_perf,
> > > +                                  unsigned long target_perf,
> > > +                                  unsigned long capacity);
> >
> > With this callback in place, do we still need to keep the other stuff we
> > introduced recently, like CPUFREQ_NEED_UPDATE_LIMITS ?
>
> Ping

Missed this one, sorry.

We still need those things for the other governors.
