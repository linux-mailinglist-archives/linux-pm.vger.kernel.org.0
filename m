Return-Path: <linux-pm+bounces-7744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFC8C3713
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2024 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC61B2813FF
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EBC4120B;
	Sun, 12 May 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="d5I/Lvst"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F514405FB
	for <linux-pm@vger.kernel.org>; Sun, 12 May 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527786; cv=none; b=cmQ6ChvskNMPtZQQ/1QrFEEC9NN+KZR2npM5ZOtiRKrgRZAgmBgIlpH2VRy7JEuvNsvBY3EbNY0CRktMy+YL7uwfR+mIlNbzZ+34mYWQk8FhVpbQaEjso0nTjeKSBIrOMLwI4uvLYsXok+Z4JSbqG9NAxV4f3t21OKRsN9wiRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527786; c=relaxed/simple;
	bh=4RtoKskPkzcF0LL91SvIcSP506czT0YJBI/jZVBpUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be8ViDRjdYHAa1ksRuNZq4PeTdrdsNuBOrtLoBHDg6O1zklVEUzflKVDIf1QyOehPsQeKUS9TC/XoEreUs4MtBq9RQ+3Zx7q9ewSO0gT6cuNjfw1uyLYeYr3X2MYRPvoRAaWmuHVpVlxsCSmZlPtF4hyoMT383/eaITlivWrtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=d5I/Lvst; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34f7d8bfaa0so2524417f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 12 May 2024 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715527782; x=1716132582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulCsNPhkK7JWi+tclLTU2fNAWwgtOLr+Kj0KyEHWc8I=;
        b=d5I/Lvstd+PxR0uKe8JMadr45EW39ox63U+ErJglqVA+mRvqMOnId009IZruNEHih5
         9URgPHFayJgU7F9ePVAifthrkkoZIcv7XDxDTWUg5OfkA8PhmRK44eV7b6qLMfjGD78/
         4YO6wClouGlUVakp5FIUz3YicAmO09/uUgZUDQkcvijfOi2vD+xdiw+zETQ0MKySNDqv
         ti9KlED4k9tbNLz/BAgAksyHym89f0VT1UgSxBzne2YrjzwGVMuIklg9CZWWKZiYVaxg
         sC6jO+VqI137EMZxSPKXfrlGnamY5V/0EXFMfuDfWoThCKXCc9Tl4psURpJnTswRZdb0
         UW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527782; x=1716132582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulCsNPhkK7JWi+tclLTU2fNAWwgtOLr+Kj0KyEHWc8I=;
        b=rDaiRIgYE59t9oEzkgWbtSrAR8WDRbQcsHx8bxUUSs5Olu54pZCt5PaRh6y4yXmS9W
         jaDrMc/9YjW53Wri8z1pbQobMy2pqEJ79h1cKuyyx2wrF+VW5oW+yo7AQ6XO9m+EK4eG
         UOWmFo9eZQuUt5U2ZoyOvgusuJ5EAypzic+FyM1zEl0RQsF6JfIT1IowFkbgHHGcAfi5
         eVfFc+1S3gJ7GYhcP0uDd4mWuUY0ghw893hjGpJ+yrRVxPZ/ZouzMz6asy6n12bma7z6
         upqExzhNN4YWLy95jJZ7C3zd1F6BhnMhO53hgJ42aS+3QLMnw59HsuKHL4kUl/qYvOOe
         4pHg==
X-Forwarded-Encrypted: i=1; AJvYcCVdiZc6r3vtV/qtlFpNkAEj6jDpr4EmgZtYgFQ6qOUhhkIhMVvVRS/NGo5wbM/n6sakQbEtQ6g8POEs2MWks+kkGJ6vz1WFWnc=
X-Gm-Message-State: AOJu0Yz/l76y7V0cnMKIW/xMHheqkzGqiGqvN2nwjYJnXagKxXIFml4T
	T1Rd+rByzfpgP36qhwNP27waqE0AQvXNxJ2rz2du9Bafr3cHn0z9HlxNdKa3GEc=
X-Google-Smtp-Source: AGHT+IFidXj0Jp6WwIXMOTr0NTyKKQh/6JrlZHr6gpW2TsGF40zRKnrhaGr2bg52AZ3q/wS9ek9uHA==
X-Received: by 2002:a5d:6405:0:b0:34d:9dff:1119 with SMTP id ffacd0b85a97d-3504aa63350mr5943715f8f.64.1715527781968;
        Sun, 12 May 2024 08:29:41 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a29sm9067710f8f.43.2024.05.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 08:29:41 -0700 (PDT)
Date: Sun, 12 May 2024 16:29:39 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
	dietmar.eggemann@arm.com, vschneid@redhat.com,
	vincent.guittot@linaro.org, Johannes.Thumshirn@wdc.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org, andres@anarazel.de,
	asml.silence@gmail.com, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] cpufreq/schedutil: Remove iowait boost
Message-ID: <20240512152939.uua2sritrwg4zobj@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <20240304201625.100619-3-christian.loehle@arm.com>
 <CAJZ5v0gMni0QJTBJXoVOav=kOtQ9W--NyXAgq+dXA+m-bciG8w@mail.gmail.com>
 <5060c335-e90a-430f-bca5-c0ee46a49249@arm.com>
 <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>
 <20240325023726.itkhlg66uo5kbljx@airbuntu>
 <d99fd27a-dac5-4c71-b644-1213f51f2ba0@arm.com>
 <20240429111816.mqok5biihvy46eba@airbuntu>
 <80da988f-899e-4b93-a648-ffd0680d4000@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80da988f-899e-4b93-a648-ffd0680d4000@arm.com>

On 05/07/24 16:19, Christian Loehle wrote:
> On 29/04/2024 12:18, Qais Yousef wrote:
> > On 04/19/24 14:42, Christian Loehle wrote:
> > 
> >>> I think the major thing we need to be careful about is the behavior when the
> >>> task is sleeping. I think the boosting will be removed when the task is
> >>> dequeued and I can bet there will be systems out there where the BLOCK softirq
> >>> being boosted when the task is sleeping will matter.
> >>
> >> Currently I see this mainly protected by the sugov rate_limit_us.
> >> With the enqueue's being the dominating cpufreq updates it's not really an
> >> issue, the boost is expected to survive the sleep duration, during which it
> >> wouldn't be active.
> >> I did experiment with some sort of 'stickiness' of the boost to the rq, but
> >> it is somewhat of a pain to deal with if we want to remove it once enqueued
> >> on a different rq. A sugov 1ms timer is much simpler of course.
> >> Currently it's not necessary IMO, but for the sake of being future-proof in
> >> terms of more frequent freq updates I might include it in v2.
> > 
> > Making sure things work with purpose would be really great. This implicit
> > dependency is not great IMHO and make both testing and reasoning about why
> > things are good or bad harder when analysing real workloads. Especially by non
> > kernel developers.
> 
> Agreed.
> Even without your proposed changes [1] relying on sugov rate_limit_us is
> unfortunate.
> There is a problem with an arbitrarily low rate_limit_us more generally, not
> just because we kind of rely on the CPU being boosted right before the task is
> actually enqueued (for the interrupt/softirq part of it), but also because of
> the latency from requested frequency improvement to actually running on that
> frequency. If the task is 90% done by the time it sees the improvement and
> the frequency will be updated (back to a lower one) before the next enqueue,
> then that's hardly worth the effort.

I think that's why iowait boost is done the way it is today. You need to
sustain the boost as the thing that need it run for a very short amount of
time..

Have you looked at how long the iowait boosted tasks run for in your tests?

> Currently this is covered by rate_limit_us probabillistically and that seems

Side note. While looking more at the history of rate_limit_us and why it is set
soo much higher than reported transition_latency by the driver, I am slowly
reaching the conclusion that what is happening here is similar to introduction
of down_rate_limit_us in Android. Our ability to predict system requirement is
not great and we end up with prematurely lowering frequencies, and this rate
limit just happens to more likely keep it higher so on average you see better
perf in various workloads. I hope we can improve on this so we don't rely on
this magic and enable better usage of the hardware ability to transition
between frequencies fast and be more exact. I am trying to work on this as part
of my magic margins series. But I think the story is bigger than that..

> to be good enough in practice, but it's not very pleasing (and also EAS can't
> take it into consideration).
> That's not just exclusive for iowait wakeup tasks of course, but in theory any
> that is off the rq frequently (and still requests a higher frequency than it can
> realistically build up through util_avg like through uclamp_min).

For uclamp_min, if the task RUNNING duration is shorter than the hardware
ability to apply the boost, I think there's little we can do. The user can opt
to boost the system in general. Note that this is likely a problem on systems
with multi-ms transition_delay_us. If the task is running for few 100s us and
it really wants to be boosted for this short time then a static system wide
boost is all we can do to guarantee what it wants. The hardware is poor fit for
the use case in this scenario. And personally I'd push back against introducing
complexity to deal with such poor fit scenarios. We can already set min freq
for the policy via sysfs and uclamp_min can still help with task placement for
HMP systems.

Now the problem we could have which is similar to iowait boost scenario is when
there's a chaining effect that requires the boost for the duration of the
chain.

I think we can do something about it if we:

	1. Guarantee the chain will run on the same CPU.
	2. Introduce a 'sticky' flag for the boost to stay while the chain is
	   running.
	3. Introduce a start/finish indication for the chain.

I think we can do something like that with sched-qos [1] to tag the chain via
a cookie and request the boost to apply to them collectively.

Generally, userspace would be better to collapse this chain into a single task
that runs in one go.

I don't know how often this scenario exists in practice and what limitations
exist that make the simple collapse solution infeasible.. So I'd leave this
out until more info is available.

> 
> >>>
> >>> FWIW I do have an implementation for per-task iowait boost where I went a step
> >>> further and converted intel_pstate too and like Christian didn't notice
> >>> a regression. But I am not sure (rather don't think) I triggered this use case.
> >>> I can't tell when the systems truly have per-cpu cpufreq control or just appear
> >>> so and they are actually shared but not visible at linux level.
> >>
> >> Please do share your intel_pstate proposal!
> > 
> > This is what I had. I haven't been working on this for the past few months, but
> > I remember tried several tests on different machines then without a problem.
> > I tried to re-order patches at some point though and I hope I didn't break
> > something accidentally and forgot the state.
> > 
> > https://github.com/torvalds/linux/compare/master...qais-yousef:linux:uclamp-max-aggregation
> > 
> 
> Thanks for sharing, that looks reasonable with consolidating it into uclamp_min.
> Couple of thoughts on yours, I'm sure you're aware, but consider it me thinking out
> loud:
> - iowait boost is taken into consideration for task placement, but with just the
> 4 steps that made it more aggressive on HMP. (Potentially 2-3 consecutive iowait
> wakeups to land on the big instead of running at max OPP of a LITTLE).

Yeah I opted to keep the logic the same. I think there are gains to be had even
without being smarter about the algorithm. But we do need to improve it, yes.
The current logic is too aggressive and the perf/power trade-off will be tricky
in practice.

> - If the current iowait boost decay is sensible is questionable, but there should
> probably be some decay. Taken to the extreme this would mean something
> like blk_wait_io() demands 1024 utilization, if it waits for a very long time.
> Repeating myself here, but iowait wakeups itself is tricky to work with (and I
> try to work around that).

I didn't get you here. But generally the story can go few levels deep yes. My
approach was to make incremental progress without breaking existing stuff, but
help move things in the right direction over time. Fixing everything in one go
will be hard and not productive.

> - The intel_pstate solution will increase boost even if
> previous_wakeup->iowait_boost > current->iowait_boost
> right? But using current->iowait_boost is a clever idea.

I forgot the details now. But I seem to remember intel_pstate had its own
accounting when it sees iowait boost in intel_pstate_hwp_boost_up/down().

Note that the major worry I had is about the softirq not being boosted.
Although in my testing this didn't seem to show up as things seemed fine. But
I haven't dug down to see how accidental this was. I could easily see my
patches making some use case out there not happy as the softirq might not get
a chance to see the boost. I got distracted with other stuff and didn't get
back to the topic since then. I am more than happy to support your efforts
though :)

[1] https://lore.kernel.org/lkml/20230916213316.p36nhgnibsidoggt@airbuntu/

