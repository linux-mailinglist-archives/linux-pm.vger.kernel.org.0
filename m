Return-Path: <linux-pm+bounces-13349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C2968816
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7771F2307B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB419C57D;
	Mon,  2 Sep 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="nVgQGO7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFA19C571
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281902; cv=none; b=OqkyqzJCjnjDz9y8JIznjWTiTw+vTPTlSzBmHTZmlB7MDstdYLUanGIaPqMsv4LsjI14YZD6o3t989LWu0bo1QWhZHi1nojZ/7JuqVno5XLXx3GfxFdPz6lV2eK5tOB8on20gm76BjJoHVJOW4AwhI1kg3kZE0KDDA/m1emICcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281902; c=relaxed/simple;
	bh=q96VyqN/0ySkCB+PIyJA7FN2MaTeZbJOnNfW8MS+37A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdTEM2G/x55CMEf9YKvaIn6zH4VAENPEP73XgVy8jRvYTkCxRh6Gj9i0USGVxEZPSZZlfYUWP4EAKb+AOf0vpNci7D9ljlPoYjwZUkqXp+JNatq8lClvaZZbTpv6ZHrTuMnwAHZ0asCT6Wif+BZEon9pS3ru4nanqpsGogEzFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=nVgQGO7i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso3538629a12.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725281899; x=1725886699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cR9cfhYSepdl+YX2QY2BUARaBieMmfjXY8jZwYs5OIo=;
        b=nVgQGO7iivrQ6EQr5n5NaangxB0ricUPuYDKXBJ3dF1R3YtP/KjsZ5Z7cItJtA1J2N
         +WS7+8wK3P5ky8jyxJS21ENmUcAgHo6Be9mCpRsLXNMd6W31Z1aAuu8cWsTxi0nqAQjA
         qKaN+s7eXGmttArUpmafrK9UvcuSrEFRlDKjMy0PyLdZTuesw5aJn3Tug3f/Z2guqXBH
         07tzbu8DESInsJzXjy3xibHzN2BZ+PCpRwilJmvsWx8bTBgexfZ2fQt+fexiUIed5L9L
         uIygil8y6OyXLYrzPE/wSGgEz6y49jJeRWq3N01bmeX4nNAnuCd9F7ya+VA1M22v0Tac
         pdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281899; x=1725886699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR9cfhYSepdl+YX2QY2BUARaBieMmfjXY8jZwYs5OIo=;
        b=MOmvyiaHJWK41e7i8UMqztA5al7WGDKoJnPaNjNnAxOS/ZnwkxUNl+e/wsu963VIRp
         8emYMuP1Wwh8L5UOZ7IGQnOJvkXaP3YAq+kOIpSqJeMAQimXEFbGU423faoWQQJXULsw
         HLtvLEi1QgaZ/dETqjopH47nS56GcXjP9mNZ3vWsu0D2I4bbWVVOlaHGb1q9dFZKIVW5
         E5CjGYhlfWfUUUTknUBlEdEBhZaR6HaDwdnGOYUL1/Rbms+CPFbxuAG+V3seCc7BZRgd
         gjw/w+vwivxpbl2YozgklY3uhMphLwg/wMshKoTsfcmH/Xed8uaiwSA/P1rP6cCOKzlq
         kubw==
X-Forwarded-Encrypted: i=1; AJvYcCWLy59c9CybXBGwwx0cGQCBHrmmn0YnYNzfnVbUizI3uDzRfXiEtlEu+9IMmE5OMICLOnffz099/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ikNpzUud8v/kI5TcyNt2BPdiNpjFy9Qyg1iu1+hAYvF9CSsZ
	AgeaEs+LI78pfU4Tfg8KWrSyDobVCdixaCYmX6HJ81/zjDQAqiqtIHACDyQhkis=
X-Google-Smtp-Source: AGHT+IHlH58uD98kUK0m8/eegTUlU87wVLPhG2mjSyCo7xehUKX9Qzii7s7RaH363XfrLJooW3C2CQ==
X-Received: by 2002:a05:6402:5111:b0:5c2:12b5:3b83 with SMTP id 4fb4d7f45d1cf-5c21ed33cd0mr10236149a12.4.1725281898768;
        Mon, 02 Sep 2024 05:58:18 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24372d393sm3139014a12.23.2024.09.02.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:58:18 -0700 (PDT)
Date: Mon, 2 Sep 2024 13:58:15 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240902125815.vu3s25ciib34eu3a@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu>
 <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>

On 09/02/24 14:30, Vincent Guittot wrote:
> On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 08/13/24 10:27, Vincent Guittot wrote:
> > > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > > > Hi Qais,
> > > > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > > > freq updates still bothered me so let me share my thoughts even though
> > > > > it might be niche enough for us not to care.
> > > > >
> > > > > 1. On fast_switch systems, assuming they are fine with handling the
> > > > > actual updates, we have a bit more work on each context_switch() and
> > > > > some synchronisation, too. That should be fine, if anything there's
> > > > > some performance regression in a couple of niche cases.
> > > > >
> > > > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > > > update request. This task will preempt whatever and currently will
> > > > > pretty much always be running on the CPU it ran last on (so first CPU
> > > > > of the PD).
> > > >
> > > > The !fast_switch is a bit of concern for me too but not for the same
> > > > reason and maybe the opposite of yours IIUC your proposal below:
> > > >
> > > > With fast_switch we have the following sequence:
> > > >
> > > > sched_switch() to task A
> > > > cpufreq_driver_fast_switch -> write new freq target
> > > > run task A
> > > >
> > > > This is pretty straight forward but we have the following sequence
> > > > with !fast_switch
> > > >
> > > > sched_switch() to task A
> > > > queue_irq_work -> raise an IPI on local CPU
> > > > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > > > with 1 CPU per PD)
> > > > sched_switch() to sugov dl task
> > > > __cpufreq_driver_target() which can possibly block on a lock
> > > > sched_switch() to task A
> > > > run task A
> > > >
> > >
> > > sent a bit too early
> > >
> > > > We can possibly have 2 context switch and one IPi for each "normal"
> > > > context switch which is not really optimal
> > >
> > > It would be good to find a way to skip the spurious back and forth
> > > between the normal task and sugov
> >
> > Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> > Relaxing this will make it less of a problem, but won't eliminate it.
> 
> yes, but it's not a problem of relaxing affinity here

If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
I am just this will be safe on all platforms of course.

But yeah, I don't think this is a solution anyway but the simplest thing to
make it harder to hit.

> The problem is that the 1st switch to task A will be preempted by
> sugov so the 1st switch is useless. You should call cpufreq_update
> before switching to A so that we skip the useless switch to task A and
> directly switch to sugov 1st then task A

Can we do this safely after we pick task A, but before we do the actual context
switch? One of the reasons I put this too late is because there's a late call
to balance_calbacks() that can impact the state of the rq and important to take
into account based on my previous testing and analysis.

Any reason we need to run the sugov worker as DL instead for example being
a softirq?

