Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A83CD2F0
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2019 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfJFPe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Oct 2019 11:34:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41622 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Oct 2019 11:34:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id g13so9004763otp.8;
        Sun, 06 Oct 2019 08:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpRvHMhSkMtvUwP1xP8/zh4CxYzgsJIcKXMPh4MXB5I=;
        b=i58kjVfVKjGd3BbwnOUKbseZHmTIJBtMynuuBQPkeydjhcypJwGCfi7RhRqvyLImf5
         65yJoShSfyhlRCkzb8q9xOa0/f9oLcSom7VJMnFJxc+Vsyel7UCRD0yobCqRP2F7KWcS
         LHAUCYXmlGme9RqvZUgyolnHGWm1PeINZG7SS7TlcWQVdDJ0bEo4CxldOq1XvOb0sMIT
         LstBxU7sUf1aEdllCdwgR7faO7WqYWPZ6Ui39WmfEyYycTBHUugqxyojomVbZj2eZM1f
         L76U0HC3UjdocIuFTPRem28HsqZuzSoAV5ne36/3XSB1blz5mfwdnXOS9Nb6grxWyv1a
         MbsA==
X-Gm-Message-State: APjAAAU78FHYFy7r7ZLfZdoOjPVb7yakfHfgmb4NJHVhBeQcpiZQcQMN
        eeFDf4xrTkoCAi3MM6ZvUcwqqQu4ewFL+oPcu10=
X-Google-Smtp-Source: APXvYqy7q9sgfYqVSnfVVCMqi8eFd+CXpG3crmh1bySZ1WRxDy/+xj4KQY858higSaFglUZMBcoHU4ytn0DeV2qEv8c=
X-Received: by 2002:a05:6830:1504:: with SMTP id k4mr4873638otp.262.1570376066195;
 Sun, 06 Oct 2019 08:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <001601d57487$e1029ef0$a307dcd0$@net> <000f01d576df$a6b87a30$f4296e90$@net>
 <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com> <000001d57c54$db31f8c0$9195ea40$@net>
In-Reply-To: <000001d57c54$db31f8c0$9195ea40$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 6 Oct 2019 17:34:15 +0200
Message-ID: <CAJZ5v0jo-KQouuE3P51THvU33kViBVtDq1WknBFx+FWUY0e=ag@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 6, 2019 at 4:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.10.01 02:32 Rafael J. Wysocki wrote:
> > On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2019.09.26 09:32 Doug Smythies wrote:
> >>
> >>> If the deepest idle state is disabled, the system
> >>> can become somewhat unstable, with anywhere between no problem
> >>> at all, to the occasional temporary jump using a lot more
> >>> power for a few seconds, to a permanent jump using a lot more
> >>> power continuously. I have been unable to isolate the exact
> >>> test load conditions under which this will occur. However,
> >>> temporarily disabling and then enabling other idle states
> >>> seems to make for a somewhat repeatable test. It is important
> >>> to note that the issue occurs with only ever disabling the deepest
> >>> idle state, just not reliably.
> >>>
> >>> I want to know how you want to proceed before I do a bunch of
> >>> regression testing.
> >>
> >> I did some regression testing anyhow, more to create and debug
> >> a methodology than anything else.
> >>
> >>> On 2018.12.11 03:50 Rafael J. Wysocki wrote:
> >>>
> >>>> v7 -> v8:
> >>>>  * Apply the selection rules to the idle deepest state as well as to
> >>>>    the shallower ones (the deepest idle state was treated differently
> >>>>    before by mistake).
> >>>>  * Subtract 1/2 of the exit latency from the measured idle duration
> >>>>    in teo_update() (instead of subtracting the entire exit latency).
> >>>>    This makes the idle state selection be slightly more performance-
> >>>>   oriented.
> >>>
> >>> I have isolated the issue to a subset of the v7 to v8 changes, however
> >>> it was not the exit latency changes.
> >>>
> >>> The partial revert to V7 changes I made were (on top of 5.3):
> >>
> >> The further testing showed a problem or two with my partial teo-v7 reversion
> >> (I call it teo-v12) under slightly different testing conditions.
>
> Correction:
> There was no problem with my partial reversion kernel (a.k.a. teo-v12). The problem
> was confusion over which kernel I was actually running for whatever test.
>
> >>
> >> I also have a 5.3 based kernel with the current teo reverted and the entire
> >> teo-v7 put in its place. I have yet to find a idle state disabled related issue
> >> with this kernel.
> >>
> >> I'll come back to this thread at a later date with better details and test results.
> >
> > Thanks for this work!
> >
> > Please also note that there is a teo patch in 5.4-rc1 that may make a
> > difference in principle.
>
> Yes, actually this saga started from somewhere between kernel 5.3 and 5.4-rc1,
> and did include those teo patches, which actually significantly increases the
> probability of the issue occurring.
>
> When the deepest idle state is disabled, and the all states search loop exits
> normally, it might incorrectly re-evaluate a previous idle state previously
> deemed not worthy of the check. This was introduced between teo development
> versions 7 and 8. The fix is to move the code back inside the loop.
> (I'll submit a patch in a day or two).

OK

> I do not think I stated it clearly before: The problem here is that some CPUs
> seem to get stuck in idle state 0, and when they do power consumption spikes,
> often by several hundred % and often indefinitely.

That indeed has not been clear to me, thanks for the clarification!

> I made a hack job automated test:
> Kernel  tests           fail rate
> 5.4-rc1  6616           13.45%
> 5.3              2376            4.50%
> 5.3-teov7       12136            0.00%  <<< teo.c reverted and teov7 put in its place.
> 5.4-rc1-ds      11168        0.00%  <<< proposed patch (> 7 hours test time)
>
> Proposed patch (on top of kernel 5.4-rc1):
>
> doug@s15:~/temp-k-git/linux$ git diff
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index b5a0e49..0502aa9 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -276,8 +276,22 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                 if (idx < 0)
>                         idx = i; /* first enabled state */
>
> -               if (s->target_residency > duration_us)
> +               if (s->target_residency > duration_us){
> +                       /*
> +                        * If the "hits" metric of the idle state matching the sleep length is
> +                        * greater than its "misses" metric, that is the one to use.  Otherwise,
> +                        * it is more likely that one of the shallower states will match the
> +                        * idle duration observed after wakeup, so take the one with the maximum
> +                        * "early hits" metric, but if that cannot be determined, just use the
> +                        * state selected so far.
> +                        */
> +                       if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
> +                           max_early_idx >= 0) {
> +                               idx = max_early_idx;
> +                               duration_us = drv->states[idx].target_residency;
> +                       }
>                         break;
> +               }
>
>                 if (s->exit_latency > latency_req && constraint_idx > i)
>                         constraint_idx = i;
> @@ -293,20 +307,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         }
>
>         /*
> -        * If the "hits" metric of the idle state matching the sleep length is
> -        * greater than its "misses" metric, that is the one to use.  Otherwise,
> -        * it is more likely that one of the shallower states will match the
> -        * idle duration observed after wakeup, so take the one with the maximum
> -        * "early hits" metric, but if that cannot be determined, just use the
> -        * state selected so far.
> -        */
> -       if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
> -           max_early_idx >= 0) {
> -               idx = max_early_idx;
> -               duration_us = drv->states[idx].target_residency;
> -       }
> -
> -       /*
>          * If there is a latency constraint, it may be necessary to use a
>          * shallower idle state than the one selected so far.
>          */

This change may cause the deepest state to be selected even if its
"hits" metric is less than the "misses" one AFAICS, in which case the
max_early_index state should be selected instead.

It looks like the max_early_index computation is broken when the
deepest state is disabled.
