Return-Path: <linux-pm+bounces-14080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002ED9767F5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 13:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8A428540B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F9190079;
	Thu, 12 Sep 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoRJBYLi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170F224CF;
	Thu, 12 Sep 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140843; cv=none; b=M72pd2ESNGvBgvmHmR2BHXWC2Yv2I3eNjMiQrexh0obvhFZL3Mf7tRaGPTaNnKw7TMncypU3Fwla44+bV1weccwboJ/IlaOJHQB+NeJS978DD0GTzQkvHd+teEvWMfC7TDWIDKrRFoJlXgBXZ7WJoyozS+5p5YKg7IDOHwDYBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140843; c=relaxed/simple;
	bh=E9iWqBBsKTyRQym7PTkz8rCTACYBy/adJ1/ujdivEY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1I/plSLeLJ/+8DV7jcCUJBEQf9BDNePzIE7r7x6GHXdCkytgdz15fUX2aP9rASMiWH0FoTqkHQJCND+5qU9Qc5eQyqZ1SNiDdwCCHmmA8hWXuZDVA1mowXM0xnhzk3+kefqb1ZemCZri3lyCnCwlAHXFri3N7+bXAPhe0PzV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoRJBYLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F256CC4CEC4;
	Thu, 12 Sep 2024 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726140843;
	bh=E9iWqBBsKTyRQym7PTkz8rCTACYBy/adJ1/ujdivEY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HoRJBYLiu7K+eHj7RRisbR6FjTkMq9cGHxDy1AuA5y1EL7+hY0xN3DGyd+FDmAjpM
	 /1/QLwi4OJ1SoVocvc9gkNtqXMxMiKSvsY1pxKi8vwmBfFO6kjlG3LTOHC/9EzWVue
	 cRXNZTEvLVjINYfJTF3LE0siCVjQNwKR6S2NK2lRfJfXA4/Fald9aPPqX7s2tvhksb
	 4OP6OEe7M84Z76+/Mw64mCFMUrhCzpIz7EZ1xc1ByOhih5+LPKA1LrHYyzYEHSue+4
	 ufdo3IrdWFDzC8YSqd1ej7JzIdZ+DH6T+j+NVRrchq47BVIlKNYGuZpqINIsrbZV4A
	 FxIQLwWqprP7w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-278279a3a39so395126fac.0;
        Thu, 12 Sep 2024 04:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvkOamygL5k+vDQn55yDggaaQ1m+QSeDzlMQw6mV4lhWwIEVXVGfVIlkgtpzVFlutrZuO7364r6K4=@vger.kernel.org, AJvYcCXxAO+FAWE7AK0G8/O/R9cFsAwALMvg7qn+CAbuFUXQ4j/jqnS0CAfEux59QbDcFTaUREAfmHoOZg9o1ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHYW6O6lvpkdfKFENVdUvqPdlc78DAO4ifUtHpbKovu9EkWLt
	jnigoqn+96YBgRB9MOpoSjLgKDc9VmT1OHZ0ztvLBdXQIOnVf3Ld2voTqbMrQAovDvfAEZZYNbv
	vjrfm27T3CsA4C7rZve/MpRclPb4=
X-Google-Smtp-Source: AGHT+IGRI15b2rce7iEfqbVp0JwmRC0WFhUwAfzhbjaOLB/cliqAZLEZieIAOu1ofedCQ/CSE2p3+DvqzwgdAFolR1A=
X-Received: by 2002:a05:6870:71c5:b0:277:f399:705b with SMTP id
 586e51a60fabf-27c3f0ede91mr1339323fac.1.1726140842301; Thu, 12 Sep 2024
 04:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <6e4a4605-f6c5-4948-ac38-c4ddf4990754@arm.com>
In-Reply-To: <6e4a4605-f6c5-4948-ac38-c4ddf4990754@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 13:33:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieB4hppC8fHnjhNNpfFZzEL4Y96irSTmCmavXCid2xtA@mail.gmail.com>
Message-ID: <CAJZ5v0ieB4hppC8fHnjhNNpfFZzEL4Y96irSTmCmavXCid2xtA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:34=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/28/24 19:45, Qais Yousef wrote:
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> >
> > At the moment we send them when load is updated for CFS, bandwidth for
> > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > sent in a short period of time and potentially be ignored at a critical
> > moment due to the rate_limit_us in schedutil.
> >
> > For example, simultaneous task enqueue on the CPU where 2nd task is
> > bigger and requires higher freq. The trigger to cpufreq_update_util() b=
y
> > the first task will lead to dropping the 2nd request until tick. Or
> > another CPU in the same policy triggers a freq update shortly after.
> >
> > Updates at enqueue for RT are not strictly required. Though they do hel=
p
> > to reduce the delay for switching the frequency and the potential
> > observation of lower frequency during this delay. But current logic
> > doesn't intentionally (at least to my understanding) try to speed up th=
e
> > request.
> >
> > To help reduce the amount of cpufreq updates and make them more
> > purposeful, consolidate them into these locations:
> >
> > 1. context_switch()
> > 2. task_tick_fair()
> > 3. sched_balance_update_blocked_averages()
> > 4. on sched_setscheduler() syscall that changes policy or uclamp values
> > 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> > 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> >
>
> Actually now reading that code again reminded me, there is another
> iowait boost change for intel_pstate.
> intel_pstate has either intel_pstate_update_util() or
> intel_pstate_update_util_hwp().
> Both have
>         if (smp_processor_id() !=3D cpu->cpu)
>                 return;
> Now since we move that update from enqueue to context_switch() that will
> always be false.
> I don't think that was deliberate but rather to simplify intel_pstate
> synchronization, although !mcq device IO won't be boosted which you
> could argue is good.
> Just wanted to mention that, doesn't have to be a bad, but surely some
> behavior change.

This particular change shouldn't be problematic.

