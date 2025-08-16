Return-Path: <linux-pm+bounces-32464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EEAB28BD9
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83141C26142
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F623507F;
	Sat, 16 Aug 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZ6BRHb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05821D3E2
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755332726; cv=none; b=A8rsxzji0oHoZd2ju5hcJfF1HhJXsccxOyctYfkRuRPSpKVkSxJxCV4dDIu/1NQFTqVXHpldzb1/oKAHOR+iYd5aGEGC+h2rWRQ42QZQO7sGKnh/8qbPeVPSqdnVUYsMVmra9PVl4HyDzg2rQcbqMbDahn6WUjvdaH7L45Mc8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755332726; c=relaxed/simple;
	bh=p+HcVR10ta9/uaaYclCChxgtwY4bqG6Q0PXNzlAtXHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqQt7+be6E+twZnQMogAxBExggCATKxve3ZbaN0HVzX82bwkEZqwZRO1AAA3XjZfalW/v0vpnd3+YQgQon3AewLoRbuE4iR6H2YFyoUqjuJog+6wLsqu1cIxwMim3C7vPs+uJPV7klNy/uwO/1LmNiXV2exOcPTKR0O4kE0rok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZ6BRHb/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0bf04716aso149471cf.1
        for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755332724; x=1755937524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcKVYqJUUq15Nb/o2vZGlw1IVIH6lK7WPKjHZ7oVxTo=;
        b=HZ6BRHb/ztUjG6Yv4x1DYqmiJYl1uhXlqOu8ypOuIU+JqRuKy9vLAanfdVVqr75FjF
         4gBBRzXWj90BbytjcKHfMQlafRuYSzv9ziYKsFZWbLtfA3cyqaOYTFLc6pB2db+mQqpd
         VAqNKg2sJcxUvqNcJ5tzQuHs1G0HK/3GbXWCOd67nqR+xPKF93bn6HIHdilaCplCy1w1
         eYjW2aYIqoZ0qfvwYtyCUWlX+PSNUMfOwYTQFCNR6H5op6HEZt6hCKsyiw97QKzIX1v1
         DGLBg7oz0JAQWS4jPprBuMNGkG8hlg5qBM2Ryfo7W4Jq5i2w6+OtE/0JLW/euvT7q0eD
         JWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755332724; x=1755937524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcKVYqJUUq15Nb/o2vZGlw1IVIH6lK7WPKjHZ7oVxTo=;
        b=admmV8hn2SWqQHGJzL587kT/orLPMbXBycnGUoX2L+gCXdBApUKhvfUzEH8tpjlRMN
         T5xvYP36AzLShPKAk9JGjo9sm1FQ94nPwu4K6eQJvC95B8rAX/cM5kA51RiQYsktqbGl
         vLHex34mixzb2CHL3v0hadgMPBmP4bSuXiRiccIqlM9q0khQ5aBnNcomTU7PEWYyOM3k
         rnm4WFDxjrT2SU0y8hp5hI8sdqIbQeaKlfzgCugJCAMcXYJd7D2LlQjk7rvpsoL8R5ZE
         Y+BDVcyLytEjeQv7CuJUi6JGnrxCOrn989oo/r8l8/SVHveObdSbVwAQNJaGBbBKj56C
         Btow==
X-Forwarded-Encrypted: i=1; AJvYcCWldSkfPkQoqLrEJd7m2bT5JX4+wCPra+4q8aqQgLkpUJAjG/C3z3RbARROil7iHDDCLeCp4CWTvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQItETzj9CMsO3HWs8kpQAZLO90bR990AXKF55IvdmODXGTSq
	P+abI65TN4swEv6zeYnR8TQ88KZch3zSOOpgaiaKyJQI6F3Dw9+FYWruOl9MPnzm9nRxvTQzD26
	s57kAavDMcMU0VxonWMO3OrEAMPiFjCzrsBaR/QNw
X-Gm-Gg: ASbGncvRussFfwQZCubtcVgUlLiGvxXXomo+f4ewMoYJsioYKZnKs7hn6Be3tiTyrUS
	ysNd9p5oQwkS+vxgkumV7kLyr+p6P8yS4lYmTPfk6La4pUsYU/OzAayHUmVaqULhWxodZnQYJrk
	JqyLB0zj/ghIH9zn90O9y2TP9eMTphcE7yxT7qDJu3EoFmQC1b/bQegBoytQmo0JeXv2+s4G4R5
	mLII9X4DJYxBiKB6wscdvo=
X-Google-Smtp-Source: AGHT+IEQbivhj3tl+6o8LMgkOExG/JUNcGy6VeXofwQfI4D993PMUyWCBHesPgvEVq3iyGxc9aHIA4hyPXlnpCWM6mI=
X-Received: by 2002:ac8:58cf:0:b0:4b0:9c14:2fec with SMTP id
 d75a77b69052e-4b129efd3a5mr3441311cf.8.1755332723849; Sat, 16 Aug 2025
 01:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIso4kLtChiQkBjH@arm.com> <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com> <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7> <aJo5vP_mfBn_vxSF@google.com>
 <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
 <aJpMHkrWJIyHtHL5@google.com> <CAJZ5v0hXUoqmxwjH0CN8gGDj=qnC3ZWrJc5VarkqRfh=0SCUWw@mail.gmail.com>
 <aJ7B2labaxza9duY@google.com>
In-Reply-To: <aJ7B2labaxza9duY@google.com>
From: Prashant Malani <pmalani@google.com>
Date: Sat, 16 Aug 2025 01:25:12 -0700
X-Gm-Features: Ac12FXz-buK8Ymw1j9cj9Q2HpIKhfRfUYsvg-_hreoqsYarB4FEIuJ08Ueg7hFk
Message-ID: <CAFivqmKyRnz-uE8TO+0H26os8uPjL_vcMHiPME3Q5yDu3Ph=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Beata Michalska <beata.michalska@arm.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 22:13, Prashant Malani <pmalani@google.com> wrote:
>
> Thanks a lot for taking a look at this, Rafael.
>
> On Aug 14 13:48, Rafael J. Wysocki wrote:
> >
> > First off, AFAICS, using idle_cpu() for reliable detection of CPU
> > idleness in a sysfs attribute code path would be at least
> > questionable, if not outright invalid.  By the time you have got a
> > result from it, there's nothing to prevent the CPU in question from
> > going idle or waking up from idle.
>
> This is a heuristic-based optimization. The observation is that when
> the CPU is idle (or near-idle/lightly loaded, since FFH actually wakes
> up an idle CPU), the AMU counters as read from the kernel are unreliable.
> It is fine if the CPU wakes up from idle immediately after the check.
> In that case, we'd return the desired frequency (via PCC reg read), which
> is what the frequency would be anyway (if the AMU measurement was
> actually taken).
>
> In a sense, the assumption here is no worse than what is there at
> present; currently the samples are taken across 2us, and (theoretically)
> if the difference between them is 0, we take the fallback path. There is
> nothing to prevent the CPU from waking up immediately after that 2us
> sample period.
>
> > Moreover, the fact that the given
> > CPU is idle from the scheduler perspective doesn't actually mean that
> > it is in an idle state and so it has no bearing on whether or not its
> > performance counters can be accessed etc.
>
> The idle check isn't meant to guard against accessing the counters.
> AFAICT it is perfectly valid to access the counters even when the CPU is
> actually idle.
>
> >
> > The way x86 deals with this problem is to snapshot the counters in
> > question periodically (actually, in scheduler ticks) and fall back to
> > cpu_khz if the interval between the two consecutive updates is too
> > large (see https://elixir.bootlin.com/linux/v6.16/source/arch/x86/kernel/cpu/aperfmperf.c#L502).
> > I think that this is the only reliable way to handle it, but I may be
> > mistaken.
>
> This is interesting. I think it may not work for the CPPC case, since
> the registers in question are in some cases accessed through PCC reads
> which require semaphores. I think it would be untenable to do that in
> the tick handler (but I may be mistaken here). It's easier on x86
> since those are always just MSRs.
> We could probably do it for the FFH case, but then we're bifurcating
> the computation method and IMO that's not worth the hassle.

I looked around a bit more and it turns out arm64 is already doing something
similar to what you propose.
It takes a snapshot of the counters every tick, and falls back to
arch_scale_freq_capacity() for another non-idle CPU (checked using idle_cpu())
in the same frequency domain if the interval between snapshots is too long [1].

However, this function only works some of the time; if the CPU hasn't had
a tick in a while *and* there is no other non-idle CPU in the frequency domain,
it returns an error [2].

Moreover, cpuinfo_cur_freq doesn't use this (it reads the frequency directly
from the CPPC driver).

(I'll abandon this series if you still believe this is an invalid
approach; just thought
I'd get this bit of clarification in, for my own understanding).

BR,

-Prashant

[1] https://elixir.bootlin.com/linux/v6.16-rc7/source/arch/arm64/kernel/topology.c#L285
[2] https://elixir.bootlin.com/linux/v6.16-rc7/source/arch/arm64/kernel/topology.c#L336

