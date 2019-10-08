Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F65CF672
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfJHJvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 05:51:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33296 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJHJvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 05:51:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so8229285oic.0;
        Tue, 08 Oct 2019 02:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTWQeRdbAy3yNwBYxrxnBzfQyj2S2eIHLnU9sLLV9Pc=;
        b=dppyD01aJxMOn93UIAhjiJFlSBL2pIJkG+T4CphPmkVYRGkdW2xVKn6AW/hopSEtnq
         9vUBbeziM/2zI1Pabr6k9GbyocThUHacCsVmi465eIKVOHfXeYiutbHbObs5SXFopV4R
         dDUHPsOcWAzChPqxUjv1v0VzafZKTYZp0CljUOov2GygBVD++jsIelODp0q2U+yzWG4x
         aQX2zOoesjS2Ehcu/3LF4YoAsopbambwK3r0cVSATvE8jvRH9j4CdC2nBWTWD7kqpwby
         QU/FRREwWUILD2puCXOuRPM4oK/l34ovS1Btr8B2SRol4RWStnV2Vbm0hbyQ2Uss1uW1
         jCXw==
X-Gm-Message-State: APjAAAVaFpRWU1X2tGaqdDLHJMwNC+PITSSF76HWiVkd5UM37/Z5TIrK
        jApMJdjUZqXxXsuIGQolGv6lHubhw07wjmc5FWc=
X-Google-Smtp-Source: APXvYqwc2KxXM43lmvZ97dI0n0GSTOgxhKyupGgCeWeBfk87jri4fpIXegBrjOEkcYVbCg1zHKXQgXNop3abDuRCBKA=
X-Received: by 2002:aca:484:: with SMTP id 126mr3089684oie.68.1570528302549;
 Tue, 08 Oct 2019 02:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <001601d57487$e1029ef0$a307dcd0$@net> <000f01d576df$a6b87a30$f4296e90$@net>
 <CAJZ5v0gu=rALS9ZLNMDT3cw_sT2m8XCKP6+AW3488x2Q9EXM3g@mail.gmail.com>
 <000001d57c54$db31f8c0$9195ea40$@net> <CAJZ5v0jo-KQouuE3P51THvU33kViBVtDq1WknBFx+FWUY0e=ag@mail.gmail.com>
 <000d01d57da0$8410f1c0$8c32d540$@net>
In-Reply-To: <000d01d57da0$8410f1c0$8c32d540$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Oct 2019 11:51:31 +0200
Message-ID: <CAJZ5v0gRSpNtwDXrRr9GW2O9ZQpM0yBdKfQDXLwsZua5692yUQ@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 8:20 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.10.06 08:34 Rafael J. Wysocki wrote:
> > On Sun, Oct 6, 2019 at 4:46 PM Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2019.10.01 02:32 Rafael J. Wysocki wrote:
> >>> On Sun, Sep 29, 2019 at 6:05 PM Doug Smythies <dsmythies@telus.net> wrote:
> >>>> On 2019.09.26 09:32 Doug Smythies wrote:
> >>>>
> >>>>> If the deepest idle state is disabled, the system
> >>>>> can become somewhat unstable, with anywhere between no problem
> >>>>> at all, to the occasional temporary jump using a lot more
> >>>>> power for a few seconds, to a permanent jump using a lot more
> >>>>> power continuously. I have been unable to isolate the exact
> >>>>> test load conditions under which this will occur. However,
> >>>>> temporarily disabling and then enabling other idle states
> >>>>> seems to make for a somewhat repeatable test. It is important
> >>>>> to note that the issue occurs with only ever disabling the deepest
> >>>>> idle state, just not reliably.
> >>>>>
> >>>>> I want to know how you want to proceed before I do a bunch of
> >>>>> regression testing.
> >>>>
> >> I do not think I stated it clearly before: The problem here is that some CPUs
> >> seem to get stuck in idle state 0, and when they do power consumption spikes,
> >> often by several hundred % and often indefinitely.
> >
> > That indeed has not been clear to me, thanks for the clarification!
>
> >
> >> I made a hack job automated test:
> >> Kernel  tests                 fail rate
> >> 5.4-rc1                6616           13.45%
> >> 5.3              2376            4.50%
> >> 5.3-teov7       12136            0.00%  <<< teo.c reverted and teov7 put in its place.
> >> 5.4-rc1-ds      11168        0.00%  <<< [old] proposed patch (> 7 hours test time)
>
>
>    5.4-rc1-ds12   4224          0.005 <<< new proposed patch
>
> >>
> >> [old] Proposed patch (on top of kernel 5.4-rc1): [deleted]
>
> > This change may cause the deepest state to be selected even if its
> > "hits" metric is less than the "misses" one AFAICS, in which case the
> > max_early_index state should be selected instead.
> >
> > It looks like the max_early_index computation is broken when the
> > deepest state is disabled.
>
> O.K. Thanks for your quick reply, and insight.
>
> I think long durations always need to be counted, but currently if
> the deepest idle state is disabled, they are not.
> How about this?:
> (test results added above, more tests pending if this might be a path forward.)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index b5a0e49..a970d2c 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -155,10 +155,12 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>
>                 cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
>
> -               if (drv->states[i].target_residency <= sleep_length_us) {
> -                       idx_timer = i;
> -                       if (drv->states[i].target_residency <= measured_us)
> -                               idx_hit = i;
> +               if (!(drv->states[i].disabled || dev->states_usage[i].disable)){
> +                       if (drv->states[i].target_residency <= sleep_length_us) {
> +                               idx_timer = i;
> +                               if (drv->states[i].target_residency <= measured_us)
> +                                       idx_hit = i;
> +                       }

What if the state is enabled again after some time?

>                 }
>         }
>
> @@ -256,39 +258,25 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                 struct cpuidle_state *s = &drv->states[i];
>                 struct cpuidle_state_usage *su = &dev->states_usage[i];
>
> -               if (s->disabled || su->disable) {
> -                       /*
> -                        * If the "early hits" metric of a disabled state is
> -                        * greater than the current maximum, it should be taken
> -                        * into account, because it would be a mistake to select
> -                        * a deeper state with lower "early hits" metric.  The
> -                        * index cannot be changed to point to it, however, so
> -                        * just increase the max count alone and let the index
> -                        * still point to a shallower idle state.
> -                        */
> -                       if (max_early_idx >= 0 &&
> -                           count < cpu_data->states[i].early_hits)
> -                               count = cpu_data->states[i].early_hits;
> -
> -                       continue;

AFAICS, adding early_hits to count is not a mistake if there are still
enabled states deeper than the current one.

Besides, can you just leave the "continue" here instead of changing
the indentation level for everything below?

> -               }
>
> -               if (idx < 0)
> -                       idx = i; /* first enabled state */
> +               if (!(s->disabled || su->disable)) {
> +                       if (idx < 0)
> +                               idx = i; /* first enabled state */
>
> -               if (s->target_residency > duration_us)
> -                       break;
> +                       if (s->target_residency > duration_us)
> +                               break;
>
> -               if (s->exit_latency > latency_req && constraint_idx > i)
> -                       constraint_idx = i;
> +                       if (s->exit_latency > latency_req && constraint_idx > i)
> +                               constraint_idx = i;
>
> -               idx = i;
> +                       idx = i;
>
> -               if (count < cpu_data->states[i].early_hits &&
> -                   !(tick_nohz_tick_stopped() &&
> -                     drv->states[i].target_residency < TICK_USEC)) {
> -                       count = cpu_data->states[i].early_hits;
> -                       max_early_idx = i;
> +                       if (count < cpu_data->states[i].early_hits &&
> +                           !(tick_nohz_tick_stopped() &&
> +                             drv->states[i].target_residency < TICK_USEC)) {
> +                               count = cpu_data->states[i].early_hits;
> +                               max_early_idx = i;
> +                       }
>                 }
>         }
