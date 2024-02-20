Return-Path: <linux-pm+bounces-4133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230085BEBE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 15:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C6EB22365
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAC6BB28;
	Tue, 20 Feb 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="OSY0egNP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A76A35F
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439311; cv=none; b=rPmYfFkWS3zlWOK2Lmw0GMH5qgrddwx8XCGtUM91DyfDMpWAdf3sHNfJmdS+6NGxBwFMaZOSLJQV2RhgNUzAGY8i1DdKphe1fs5qectznJjAHy/h+mRy6yPNxEDiXSXdSF3cvqGc5VGM/Pto+QZI3jZKvKq+sXYL7MURhgkNOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439311; c=relaxed/simple;
	bh=MzWOsEg0JyR/mxwiNq/7yMqDNjKh9bp94ctzwd6K/xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKRKXOr+KLDrOY1Wbl4ATue8HyIlVIKkNyAEI3s+SStkMBUQGxZJBP1L6bWL2nR+k7ypfLah/rxUByzLpl/PS6KqClGMKf3720mb6uVHJuZ7+q494iQ8w4qWD1V7ljwJlEShSycJyEnNmspg7OtzG4qFQK6xdcFMgH/7RSClAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=OSY0egNP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4126f48411dso4117315e9.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708439307; x=1709044107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfU0HjeFsG8DYeTFKiZ75ZrgNxasxEcw52Jxbh8n3a8=;
        b=OSY0egNPShjqG3zA2SaPo0QzWPCw1aJ1Kkrc54gneingLQkOGGzG2UZvm+Jv96TEQR
         bOnsA/XhOfii+gAto8ZT5yLhKxJ8VDPxLmGnAIk6IHZtxdfjSBJLy0/o5pYSxZrA+duj
         kc3Yh0s0/5lc6aUTK8uSAixiYhwSoSlaZoSzDIv1FDMAuHhBoXzEvWeNQkaGkBi9OQpe
         5+ELrKizDqY7YmuV8TFwZlZJpW5FCRbZY8V36Ny2aG9+6pLAtaBfZLaIrIQ+19EQHErO
         BzIay7evCp/l6Wto8+GxRFSb23ZT/xflRTU9YNBqWtaeQIyjtZfO/DPFlrtf9Hh3pIc0
         NVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708439307; x=1709044107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfU0HjeFsG8DYeTFKiZ75ZrgNxasxEcw52Jxbh8n3a8=;
        b=p57kgS9eDriOEW7gszJ4pYMclnHnkQs8sDIo3c6RgBzmwNG0bNkiOpE15Y2wWn2Y09
         FInQg5JAnIExkvCunuamUrm5Q8hSS1/x5X9RF4AWgh54MIJ3l+f3pxc5qTchlqTx0hG3
         vtEMKdtiDOWJjeQsbPwmCGvAyEi2Z1wkD8pF28P/bKFHmuOEopZUKmBGqXI7qzTIiUnU
         iby92EGWbQAGJJccep4Nf9gdHKt0TrSxTv4k8SdlgUvegAl+NqUJzhtaVNd+aYzz/NFp
         IZ0+d29sWZuwo9pbhDhfge40VC9uTL6/6geGf50qQMRSnPg6Vsx+QTLSInNAa3JUM/jA
         4gHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QePDDxX4V5e/5jeyskqsYvfV6fVmjwzivEjA0UAFLx6bnZWq74lJVsZxwXrrFgAilamm7wJdh8jKDrUJ+SQFLDUeh77P5VI=
X-Gm-Message-State: AOJu0YzN0FWcAaX5bRaOaOiCoHYXtASVYpaGqWMuKNHCFOdqnoW9EZ4v
	3ngXQBYCNgX8PYEZtGzDl9gWzHR9hDbsjoIc/FSWGmzbcnh4Fvag6psfF43BmnE=
X-Google-Smtp-Source: AGHT+IGxF48jyXEAnABhhXx5nHyta6YTjGe/ylJuVPWhY34q5T+h15XspvG+07uFBdgpUA0ggHMo4g==
X-Received: by 2002:a05:600c:3516:b0:412:568b:50b5 with SMTP id h22-20020a05600c351600b00412568b50b5mr8779049wmq.14.1708439307518;
        Tue, 20 Feb 2024 06:28:27 -0800 (PST)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id iv6-20020a05600c548600b004103e15441dsm15246471wmb.6.2024.02.20.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:28:27 -0800 (PST)
Date: Tue, 20 Feb 2024 14:28:25 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20240220142825.odzabxo3tnkhiepa@airbuntu>
References: <20240205022006.2229877-1-qyousef@layalina.io>
 <CAKfTPtBoapJtwD3DByd06CE07MD3eGhfJVyZ01cRLyKLO8fJ7w@mail.gmail.com>
 <20240220135745.h5mlvutle6wn6eim@airbuntu>
 <CAKfTPtDC0w-gdb15pmCDr7tS9gmTeT4qAugTSviO+g9KebNvzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDC0w-gdb15pmCDr7tS9gmTeT4qAugTSviO+g9KebNvzA@mail.gmail.com>

On 02/20/24 15:22, Vincent Guittot wrote:
> On Tue, 20 Feb 2024 at 14:57, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/14/24 08:32, Vincent Guittot wrote:
> > > On Mon, 5 Feb 2024 at 03:20, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > We are providing headroom for the utilization to grow until the next
> > > > decision point to pick the next frequency. Give the function a better
> > > > name and give it some documentation. It is not really mapping anything.
> > >
> > > The renaming makes sense.
> > >
> > > >
> > > > Also move it to sched.h. This function relies on updating util signal
> > >
> > > I don't see the benefit of moving it the sched.h as it is only used by
> > > cpufreq_schedutil()
> >
> > Hehe what's for me the reason to move it for you it's the reason not to :-)
> >
> > (I believe you meant cpufreq_schedutil.c)
> >
> > It doesn't make sense outside of schedutil, does it? I can't see it being
> > suitable for consumption by other governors for example as it is not generic
> > enough.
> >
> > And the headroom definition needs to evolve. And the tight coupling to util
> > which is a scheduler internal metric will make it hard once it's part of
> > cpufreq. The headroom IMO is a property of the governor.
> 
> In this case make it part of cpufreq_schedutil.c if this is the
> governor that can use it. I don't like sched.h because It gives the
> impression that scheduler can play with it whereas it's a property of
> the cpufreq governor

Okay will do

Thanks!

> 
> >
> > We can defer the moving for now if you insist. But I think it's inevitable?
> >
> > >
> > >
> > > > appropriately to give a headroom to grow. This is more of a scheduler
> > > > functionality than cpufreq. Move it to sched.h where all the other util
> > > > handling code belongs.
> > > >
> > > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > > ---
> > > >  include/linux/sched/cpufreq.h    |  5 -----
> > > >  kernel/sched/cpufreq_schedutil.c |  2 +-
> > > >  kernel/sched/sched.h             | 17 +++++++++++++++++
> > > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > > > index bdd31ab93bc5..d01755d3142f 100644
> > > > --- a/include/linux/sched/cpufreq.h
> > > > +++ b/include/linux/sched/cpufreq.h
> > > > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> > > >  {
> > > >         return freq * util / cap;
> > > >  }
> > > > -
> > > > -static inline unsigned long map_util_perf(unsigned long util)
> > > > -{
> > > > -       return util + (util >> 2);
> > > > -}
> > > >  #endif /* CONFIG_CPU_FREQ */
> > > >
> > > >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index 95c3c097083e..abbd1ddb0359 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > > >                                  unsigned long max)
> > > >  {
> > > >         /* Add dvfs headroom to actual utilization */
> > > > -       actual = map_util_perf(actual);
> > > > +       actual = apply_dvfs_headroom(actual);
> > > >         /* Actually we don't need to target the max performance */
> > > >         if (actual < max)
> > > >                 max = actual;
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index e58a54bda77d..0da3425200b1 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > > >                                  unsigned long min,
> > > >                                  unsigned long max);
> > > >
> > > > +/*
> > > > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > > > + * continue to grow, which means it could need to run at a higher frequency
> > > > + * before the next decision point was reached. IOW, we can't follow the util as
> > > > + * it grows immediately, but there's a delay before we issue a request to go to
> > > > + * higher frequency. The headroom caters for this delay so the system continues
> > > > + * to run at adequate performance point.
> > > > + *
> > > > + * This function provides enough headroom to provide adequate performance
> > > > + * assuming the CPU continues to be busy.
> > > > + *
> > > > + * At the moment it is a constant multiplication with 1.25.
> > > > + */
> > > > +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> > > > +{
> > > > +       return util + (util >> 2);
> > > > +}
> > > >
> > > >  /*
> > > >   * Verify the fitness of task @p to run on @cpu taking into account the
> > > > --
> > > > 2.34.1
> > > >

