Return-Path: <linux-pm+bounces-4132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D785BEAC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A4A1F24766
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190196BB20;
	Tue, 20 Feb 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hppiNdG/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1406A8D4
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438936; cv=none; b=SEn4XwdjXvTydqnYbRLRSRcODqLFWWbBmAIixOEG2LxDbqGz1gtUX7o4lCrLzYc8UnphupJYu2iUUXnlMuCibO9uYyLLTRRLzgGynlD5LhnPh5TIhpRkV22kz+UvJmu1rbuSAQdqtNm/Fsi3jWtcIn2pDtyM/VCqZ7bm5Jx807U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438936; c=relaxed/simple;
	bh=jAw2zftbgBAJKSrekDaII6VYyxCwwnVK69YNBjgCFjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja6KUhgN2FxOHJhaSGLYoLsw5177WKdCqZFgKIn5Z8uLkq3aTvMHmGCS+INaBGUq+X/txSd1sOVZqufnfH7Cll81xMD0RA8RFIDD8CeI15sSeQNboKL2mnT4wvFJ57+2/YjQKAuEzyEvHitLDDCJ7ygD8w9MBU8m8bcbzXkwueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hppiNdG/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so3081552a91.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438934; x=1709043734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBoCun9C06tVXA8wZQBtoO6pNvn7N0rtBPsUqAq+yXE=;
        b=hppiNdG/2PZVg4ZIIrL8BrJr9fE5V4CPQm4nFkptDD6Fmw5sWN8/sabT37ghC4AZJT
         8lEe2bd+Pf4Q0cqhkMjPRH940ppBZdP/YdRTx3MXvq5p7iGQuB8M4ivMXAtrKADyY/ME
         lAl5jJ083XbeFWSiLquBmu1j9EHZiMjZ3D49f64qd2xL/oGQkbKP7ugKpgfKCT0mbqMl
         U/xlwXA9oSXsUbyPXK+ur4EqWG4z6aN0qP+RpMS8LAPWwomCnC3n6b70l4McTEhkM6Du
         5f3/L+AMfNfQ/oFQrwbOhoDUri9+NHvlWlFdqidlpxS1Jee9WLejFYKJUrR6BVOSG9JH
         knYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438934; x=1709043734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBoCun9C06tVXA8wZQBtoO6pNvn7N0rtBPsUqAq+yXE=;
        b=DJ0icyjeNTuH1CHSutedBnTeBYJebZ+VbEflv7wJMJtUhn1JC/d50JgoZJOQ7PGiw+
         Z5p/cP0uQwAcqNtQZk/G4PG4uy4WJu3GouensDg1bam0s2v+J58pSsQSEdQ/NyPnilUo
         OI8u3ydpkXqKvT6m07S+T6o+cmg+A0qGKBm0ZQPQ/VQl9toz4+IaQ9hun0F5Uz4yXaLf
         QVdOdgEefLUrQ1viVeuKh0PuqaNTliEV/QUIl2l6CF7UOhjQnnN99zS/h+rEhcVWlQq6
         zxRQRVBFZaCbVt7MencnwGDva/YaKVjOtkWMCBiBGLEH1OsPKb8j9gC3iE3SJN80KULF
         QV9g==
X-Forwarded-Encrypted: i=1; AJvYcCUJpuLxRfl4085KC3K9BGTFrUDd4ERdrXgANGtrskzVR5Qi4ObBzhgCUF+S20XvKDsVXTO4t6jasSyQTWPHe7rf9Ys8TyGiBxM=
X-Gm-Message-State: AOJu0YweNp3OOuQHT/ditaFkYMc6JGUq9r0KtKP5GgNGbteJp3pKwuG6
	NrOHpqvkH6XRoUv76bqYQTSUPGF1vF5GOKFD7e8U0uUY7W9Meo3Z/oiI9pSFxRtce6JR43IKMmf
	z5JnUzkeUyu3trTo7tJTV3BNPjvh6sZz9VdakDg==
X-Google-Smtp-Source: AGHT+IFvO5zHZP2am1JSDTjIy5GjXf4oDweY/JpnM+jBH/YIWxTOWYQqtadZC/X+MVB9tx0aiSAWQYW5bjgZOemKtn4=
X-Received: by 2002:a17:90b:3555:b0:299:b570:bbd6 with SMTP id
 lt21-20020a17090b355500b00299b570bbd6mr3792421pjb.28.1708438933728; Tue, 20
 Feb 2024 06:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205022006.2229877-1-qyousef@layalina.io> <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>
 <20240220135745.h5mlvutle6wn6eim@airbuntu>
In-Reply-To: <20240220135745.h5mlvutle6wn6eim@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 20 Feb 2024 15:22:01 +0100
Message-ID: <CAKfTPtDC0w-gdb15pmCDr7tS9gmTeT4qAugTSviO+g9KebNvzA@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 14:57, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/14/24 08:32, Vincent Guittot wrote:
> > On Mon, 5 Feb 2024 at 03:20, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > We are providing headroom for the utilization to grow until the next
> > > decision point to pick the next frequency. Give the function a better
> > > name and give it some documentation. It is not really mapping anything.
> >
> > The renaming makes sense.
> >
> > >
> > > Also move it to sched.h. This function relies on updating util signal
> >
> > I don't see the benefit of moving it the sched.h as it is only used by
> > cpufreq_schedutil()
>
> Hehe what's for me the reason to move it for you it's the reason not to :-)
>
> (I believe you meant cpufreq_schedutil.c)
>
> It doesn't make sense outside of schedutil, does it? I can't see it being
> suitable for consumption by other governors for example as it is not generic
> enough.
>
> And the headroom definition needs to evolve. And the tight coupling to util
> which is a scheduler internal metric will make it hard once it's part of
> cpufreq. The headroom IMO is a property of the governor.

In this case make it part of cpufreq_schedutil.c if this is the
governor that can use it. I don't like sched.h because It gives the
impression that scheduler can play with it whereas it's a property of
the cpufreq governor

>
> We can defer the moving for now if you insist. But I think it's inevitable?
>
> >
> >
> > > appropriately to give a headroom to grow. This is more of a scheduler
> > > functionality than cpufreq. Move it to sched.h where all the other util
> > > handling code belongs.
> > >
> > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > ---
> > >  include/linux/sched/cpufreq.h    |  5 -----
> > >  kernel/sched/cpufreq_schedutil.c |  2 +-
> > >  kernel/sched/sched.h             | 17 +++++++++++++++++
> > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > > index bdd31ab93bc5..d01755d3142f 100644
> > > --- a/include/linux/sched/cpufreq.h
> > > +++ b/include/linux/sched/cpufreq.h
> > > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> > >  {
> > >         return freq * util / cap;
> > >  }
> > > -
> > > -static inline unsigned long map_util_perf(unsigned long util)
> > > -{
> > > -       return util + (util >> 2);
> > > -}
> > >  #endif /* CONFIG_CPU_FREQ */
> > >
> > >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 95c3c097083e..abbd1ddb0359 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > >                                  unsigned long max)
> > >  {
> > >         /* Add dvfs headroom to actual utilization */
> > > -       actual = map_util_perf(actual);
> > > +       actual = apply_dvfs_headroom(actual);
> > >         /* Actually we don't need to target the max performance */
> > >         if (actual < max)
> > >                 max = actual;
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index e58a54bda77d..0da3425200b1 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > >                                  unsigned long min,
> > >                                  unsigned long max);
> > >
> > > +/*
> > > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > > + * continue to grow, which means it could need to run at a higher frequency
> > > + * before the next decision point was reached. IOW, we can't follow the util as
> > > + * it grows immediately, but there's a delay before we issue a request to go to
> > > + * higher frequency. The headroom caters for this delay so the system continues
> > > + * to run at adequate performance point.
> > > + *
> > > + * This function provides enough headroom to provide adequate performance
> > > + * assuming the CPU continues to be busy.
> > > + *
> > > + * At the moment it is a constant multiplication with 1.25.
> > > + */
> > > +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> > > +{
> > > +       return util + (util >> 2);
> > > +}
> > >
> > >  /*
> > >   * Verify the fitness of task @p to run on @cpu taking into account the
> > > --
> > > 2.34.1
> > >

