Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55EB5215
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfIQPzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 11:55:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfIQPzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 11:55:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so3306296lfa.7
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaYBjBB2ciR2FZbasZb6pweK9GCwJkoOMmn4LHV+BHQ=;
        b=LWAM28RJdpsodjhvi9CY2qESRcdr9tSPL6P3lrcUVSuIeDJ2fOTBvd42az3X0wqS4f
         xFUoxTyUjfcVx0AlrPJ25NGRr5jtU+7Db/ymeP4WHLUosTGAykZY2IGKEtA9EG+e7/6H
         hMBTdO1/WocsA3vnU31M55/2AlKK+dZVyWprCxBks2YDTZZ4OtLJw+zEAbp+Y2v/1C5z
         onvtCwzlUYtQs2yzh54yoPmUFarfEZ78zNgDKQl2AOO39cGvemeDZEuB6I5koiTEsMY0
         gTPjBHF+LRRu+xcKmsW2WFfkZttcGMdYqKweHOt4j16mbRYn3XrWB86glKBTiYUunDZJ
         MCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaYBjBB2ciR2FZbasZb6pweK9GCwJkoOMmn4LHV+BHQ=;
        b=sFs4P4IxZ9HYniZ4MEnH45CtvcGtK+XdhMEAlZX5gbG8bu5ULAElMqLe/nAI2beGlr
         vprhy8maGJ0U40bCvq6V0oKRGHiNKB9YmK1JyH1yJWvnMNCsGFvx+jw9NAUfOH5DnYxE
         yxtWYql5xNcweMPfMLbkXbo+o4pUYEQivwifad6Ls6l73AOKK0a3z2e79g8cUpzbideP
         PqAtVEsVVpuRwGlzJAYQVFmGajGt4etvJ11GSxDOhqfi+GAq+4TEga7nZ+abHEsjlUEG
         S00DpFGeP1SHZGI2iqf+rxs+C1RYRBuFwuE/hjpe2TfbSN0znCHFBpeY1Viwo2R8fh4y
         6hrg==
X-Gm-Message-State: APjAAAUcBJn4WhX73KucjgkhqhgZcjNT52GOevIRpo6BdLI+6K20eRS0
        BR5BjQonHTHnb6tFRC/Cwn4TJlp33YnH3FG0l23MBw==
X-Google-Smtp-Source: APXvYqwoToHg7oUESjS5k4c81wnsFbGwws0kecvhdMQKJi+gLMp4KU7pTyRkDPLtkp1xV18DEbEuOTDxJ4rVe/GsbMo=
X-Received: by 2002:ac2:5203:: with SMTP id a3mr2437460lfl.151.1568735742321;
 Tue, 17 Sep 2019 08:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190909024216.5942-1-ggherdovich@suse.cz> <20190909024216.5942-2-ggherdovich@suse.cz>
 <4226d5f460604a8130f8079b74ef3fb1d60009d7.camel@linux.intel.com> <1568730426.3329.3.camel@suse.cz>
In-Reply-To: <1568730426.3329.3.camel@suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Sep 2019 17:55:29 +0200
Message-ID: <CAKfTPtDRCBBkogYrWtwrZxM-hs=x8HrpK3N1pABDyAAMv8edAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@suse.de,
        "Cc: Len Brown" <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        viresh kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, qperret@qperret.net,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Sep 2019 at 16:21, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Hello Srinivas,
>
> On Fri, 2019-09-13 at 15:52 -0700, Srinivas Pandruvada wrote:
> > On Mon, 2019-09-09 at 04:42 +0200, Giovanni Gherdovich wrote:
> >
> > ...
> >
> > > +
> > > +/*
> > > + * APERF/MPERF frequency ratio computation.
> > > + *
> > > + * The scheduler wants to do frequency invariant accounting and
> > > needs a <1
> > > + * ratio to account for the 'current' frequency, corresponding to
> > > + * freq_curr / freq_max.
> >
> > I thought this is no longer the restriction and Vincent did some work
> > to remove this restriction.
>
> If you're referring to the patch
>
>   23127296889f "sched/fair: Update scale invariance of PELT"
>
> merged in v5.2, I'm familiar with that and from my understanding you still
> want a <1 scaling factor. This is my recalling of the patch:
>
> Vincent was studying some synthetic traces and realized that util_avg reported
> by PELT didn't quite match the result you'd get computing the formula with pen
> and paper (theoretical value). To address this he changed where the scaling
> factor is applied in the PELT formula.
>
> At some point when accumulating the PELT sums, you'll have to measure the time
> 'delta' since you last updated PELT. What we have after Vincent's change is
> that this time length 'delta' gets itself scaled by the freq_curr/freq_max
> ratio:
>
>     delta = time since last PELT update
>     delta *= freq_percent
>
> In this way time goes at "wall clock speed" only when you're running at max
> capacitiy, and goes "slower" (from the PELT point of view) if we're running at
> a lower frequency. I don't think Vincent had in mind a faster-than-wall-clock
> PELT time (which you'd get w/ freq_percent>1).

Yes, I haven't really planned to have time going faster that wall
clock but I don't see any algorithm problem at least if that would be
the case.
There will be a reduced maximum delta update of clock pelt but that
will still be large enough

>
> Speaking of which, Srinivas, do you have any opinion and/or requirement about
> this? I confusely remember Peter Zijlstra saying (more than a year ago, now)
> that you would like an unclipped freq_curr/freq_max ratio, and may not be
> happy with this patch clipping it to 1 when freq_curr > 4_cores_turbo. If
> that's the case, could you elaborate on this?
> Ignore that if it doesn't make sense, I may be mis-remembering.
>
>
> Thanks,
> Giovanni
