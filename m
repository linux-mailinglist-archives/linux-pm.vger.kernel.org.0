Return-Path: <linux-pm+bounces-3921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9185501C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318FF28E0B1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF2126F17;
	Wed, 14 Feb 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+rcH8Gi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523496A002
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931349; cv=none; b=Sx84QFObkHC/7nmIXjHPcLwj+hWhgBqzzUUR/dvAucKcLDkZQG5diqBE7raWcF8mrCYO3OwWCFIiBd8b6J/1CCCQLfDIszmsZykrjub08hlug0cs20x2J6kVD+kawwI8vh0srjVhowy9CBgA3nUs8sbkoOASUGKgRgvxoSBo82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931349; c=relaxed/simple;
	bh=W11xoHjWYpOlIFvCUlTEoYUvCFSB4r1v8f/OHKLMzUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvjePkxfap+sMPydgVkmyeMgCRIKqId4gdwMpLSWxV5glDypH4og51MY9xfbGub7SxZoFOAlYw5YO1Vx0pgngc8hI58q4Z4YfLrnmrUIvfoGuO5jF6ZeJjtnOtyt1PPPMOo5j9GNlPNPjXAlJeF8IQgu6RWqS1ZLL0Y9UAlBJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+rcH8Gi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dc949f998fso551304a12.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707931348; x=1708536148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0uq0XOL+rqmT2qCSrqkVhQlASOn9CgRE95m/7HlUY=;
        b=t+rcH8GitgEbZ6DkuAEoLcCnutheaKUbKOJRkCy+r9ZMsGlxEQQ9/kN7P5QoJNb0FC
         SEJpdlNejLyanQxqK7f4sD6+9JneGDswo4Ddl5ByAgmQK0E6ou6HLAmLMKUSOARzMCcF
         iIc99HAJI+Y8VqOhpRLNcs0+cKf07JdeL2VN9CA+R0uNCCw+K13OKaITWHHpP2hd++vK
         FJtZbD2cMDipIS+FKdHZP8JH7iTrgWEtsMq6BcjtufzOKK37EyELwEJLWWBNm/8zg5sS
         p0fvdSDXUG0WZf4DsDaQcskj0bXQsK34NUcF7RCVUr9Ter6Fpq8psYErYY3U9mPvyIre
         6hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931348; x=1708536148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw0uq0XOL+rqmT2qCSrqkVhQlASOn9CgRE95m/7HlUY=;
        b=JlpG9V3L74HimXPzTtVvns9Pe6lnusgzgtlw1n4V6GB51bkwreWcM8FetOUNz/EISi
         BOpwF/gIvIy+VeaoRKNRBnGnmBAESKfEPwUxaBWZ+OD+D2qUy/SEdDYah9GlB1ySM3bw
         9+fGCOBhwEM0NEbd4MvtUjibDLUSJ5miAtQzuD8pOZtNOaMS6FZJWj09Bv0R47IWt5S+
         6g5mS2lNwnKZyAkVw3An88EEk+kOZPHwUVxE39k7JRZq5KRjpZi5A9Svxw/yvw9swyDv
         5hCNeNS+XO4iOkYO3hxHo93ncfQU67HPnotN1dr9Vs1lXzYo+WLS8cyl+ZATNtiK7lzl
         fAAg==
X-Forwarded-Encrypted: i=1; AJvYcCUsaDvOmgzJ1LhTlxuXXL6ubmtA+TCiUPxsFvYSYfSBZDt34gVXIlm2P/RdgJAlFG42WDbsfJTOHv/8M6pH3iDXxOJI0gVvxIU=
X-Gm-Message-State: AOJu0YzT/94mwYfTC1ko9P0WGyyAqOzUJUPdK6PhJTsH+NaeQgzv3m9C
	cKccyDv5bMtCnNSEGqtbi9o+ks5XfjyYfoyYy0FWLm+1KoP/XNrYoJE5TwZk5DBBV32FI4kW9na
	xJCDabByhFIXwHXHWjWPS8v1M8ZUzbnfzLAD0sQ==
X-Google-Smtp-Source: AGHT+IGCg02LZzb9GjZUSdHHKMRmPqcl9IPmyeg4O7sO/zxB5ZdEVTGCTrev55XmJj8saaqidomAD1zz+ZftzWufKjc=
X-Received: by 2002:a17:90a:701:b0:298:b2d7:77b5 with SMTP id
 l1-20020a17090a070100b00298b2d777b5mr3280805pjl.19.1707931347673; Wed, 14 Feb
 2024 09:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
 <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com> <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
In-Reply-To: <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Feb 2024 18:22:16 +0100
Message-ID: <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant case
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	wkarny@gmail.com, qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Sasha Levin <sashal@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Shardar Mohammed <smohammed@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 18:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> > We have also observed a performance degradation on our Tegra platforms
> > with v6.8-rc1. Unfortunately, the above change does not fix the problem
> > for us and we are still seeing a performance issue with v6.8-rc4. For
> > example, running Dhrystone on Tegra234 I am seeing the following ...
> >
> > Linux v6.7:
> > [ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
> > [ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
> > [ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
> > [ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)
> >
> > Linux v6.8-rc4:
> > [   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
> > [   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
> > [   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
> > [   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)
> >
> > If I revert this change and the following ...
> >
> >   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
> >   f12560779f9d ("sched/cpufreq: Rework iowait boost")
> >   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> >
> > ... then the perf is similar to where it was ...
>
> Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
> completely buggered.
>
> Please tell me why we shouldn't just revert things as per above?
>
> Sure, the problem _I_ experienced is fixed, but apparently there are
> others just lurking, and they are even bigger degradations than the
> one I saw.
>
> We're now at rc4, we're not releasing a 6.8 with the above kinds of
> numbers. So either there's another obvious one-liner fix, or we need
> to revert this whole thing.

This should fix it:
https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/

>
> Yes, dhrystones is a truly crappy benchmark, but partly _because_ it's
> such a horribly bad benchmark it's also a very simple case. It's pure
> CPU load with absolutely nothing interesting going on. Regressing on
> that by a factor of three is a sign of complete failure.
>
>                   Linus

