Return-Path: <linux-pm+bounces-35253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01743B97042
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 379264E1E91
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5F27E041;
	Tue, 23 Sep 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKTppViZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30C26CE0C
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648340; cv=none; b=gNLAO8G8PqfV6flg1Me1rHom3/VK5J5s94QhLdkNDizxXAYuQsmlMIvrxXSKVXJq8qisrXDnta4gIKzrMjQou5Xkd0pVC3yahX7UUzbQlYJMTQynGjlYKmfJarY9w+05uk6qe7iFMKZhFWWfZRN7VMqjsP9mbMJ2AevhwEYG2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648340; c=relaxed/simple;
	bh=dOD7OpTIW2H2VVKvC6JdmNQs5QBtldi4OjUg5JlmREk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aob8F1yGrPe+OVXHzQaJ5PmHdVA72tqBBWICfmmkV+bwNc61v8zotPyjCHo5HNypl46acm3/aoHqxdajApGANRVnzLZMQEPv+nDQQSE+OIvUCVFAbgFYxMxuG+By3cxglejjC4qvcz+shiJBCzScYX1DhJo31Emcq01DPvm1s4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKTppViZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F8EC116D0
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758648340;
	bh=dOD7OpTIW2H2VVKvC6JdmNQs5QBtldi4OjUg5JlmREk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hKTppViZp4B2qr5knHAxOWMlz26WZruqQhBtt0Z1g/c2EcMk8QY9ZDOIwwdysm6jw
	 1TEPf0WZohgouwSt5aVK40aJwxznaFmr1LoK9jAkgKaKJ97E6KrW3W1yBwG7LJ+elj
	 RD8ToNt8a5tuchfketCs/wDG9TdRbwBRQKGYbVWFb4bL49Bbdm0lxmJ0skEzjkLPK0
	 87y/NFwAjKD/H0rpEW+iIIMcpsNCp88IPv5XI12J2ylfwIt2IyyGFyrvNRaA1jkZZj
	 muLz0XW0X2/Q6MkypJrWRu6q6u2hhBix41asOVXHByo/RH6XHvs5UMd2iu/9evOJK+
	 z7JfN6fUXXSIQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6218fc7c6b7so1372011eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 10:25:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4y4JuwvWrjA/6TUDU0ywepz3pV15MlFrO8e4/MgsVbK59nZAKEmL4qM5yXpFPyZFXfNfG6PAC6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPpd0B3J4A7HMJqiRUaf9cW5I4mUOpz1jgc87Y9qg1yb31on9
	hgmWO93KIWEgYgz3XdBnea2aciQAPsrfggmQLVPOx/som99dMODTo2ZvLPZgO5QWN8KpIsYvNUc
	Y4VJVQg+NGB6r7S3NXIHMVjnWTunJQcE=
X-Google-Smtp-Source: AGHT+IGvNrZTyQamZK24GG/JurUnwjuMB+JRX03X1mJufE9fQ41Buy4VlB4bNVT07oEECrAkTX2pokBAYYYp2GUM6kE=
X-Received: by 2002:a05:6820:408b:b0:635:f914:9a53 with SMTP id
 006d021491bc7-635f9149ca1mr608795eaf.6.1758648339273; Tue, 23 Sep 2025
 10:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
 <aMLaEwBHwiDhgaWM@localhost.localdomain> <CAJZ5v0h3eWw3B15SamchCVWfxfEEbOOgjm4ZbmkTt9ijZvvHMA@mail.gmail.com>
 <aMwgOJc6Hq17uFzj@localhost.localdomain>
In-Reply-To: <aMwgOJc6Hq17uFzj@localhost.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 19:25:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j727j13rDRhMk5HHR8WqhWqo5ySdyjSXctZW-Rizur3A@mail.gmail.com>
X-Gm-Features: AS18NWBFxD6GYPEXJkj2m91EzCe9kkIjacfwxG_91qu89FaxX05QTpJRT6rwtBA
Message-ID: <CAJZ5v0j727j13rDRhMk5HHR8WqhWqo5ySdyjSXctZW-Rizur3A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 5:07=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Sep 11, 2025 at 07:07:42PM +0200, Rafael J. Wysocki a =C3=A9crit =
:
> > On Thu, Sep 11, 2025 at 4:17=E2=80=AFPM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > > So, when !tick_nohz_full_cpu(dev->cpu), what is the purpose of this t=
ick stopped
> > > special case?
> > >
> > > Is it because the next dynamic tick is a better prediction than the t=
ypical
> > > interval once the tick is stopped?
> >
> > When !tick_nohz_full_cpu(dev->cpu), the tick is a safety net against
> > getting stuck in a shallow idle state for too long.  In that case, if
> > the tick is stopped, the safety net is not there and it is better to
> > use a deep state.
>
> Right.
>
> > However, data->next_timer_ns is a lower limit for the idle state
> > target residency because this is when the next timer is going to
> > trigger.
>
> Ok.
>
> >
> > > Does that mean we might become more "pessimistic" concerning the pred=
icted idle
> > > time for nohz_full CPUs?
> >
> > Yes, and not just we might, but we do unless the idle periods in the
> > workload are "long".
>
> Ok.
>
> >
> > > I guess too shallow C-states are still better than too deep but there=
 should be
> > > a word about that introduced side effect (if any).
> >
> > Yeah, I agree.
> >
> > That said, on a nohz_full CPU there is no safety net against getting
> > stuck in a shallow idle state because the tick is not present.  That's
> > why currently the governors don't allow shallow states to be used on
> > nohz_full CPUs.
> >
> > The lack of a safety net is generally not a problem when the CPU has
> > been isolated to run something doing real work all the time, with
> > possible idle periods in the workload, but there are people who
> > isolate CPUs for energy-saving reasons and don't run anything on them
> > on purpose.  For those folks, the current behavior to select deep idle
> > states every time is actually desirable.
>
> So far I haven't heard from anybody using nohz_full for powersavings. If
> you have I'd be curious about it.

There is a project called LPMD that does this:

https://github.com/intel/intel-lpmd

> Whether a task runs tickless or not, it
> still runs and the CPU isn't sleeping. Also CPU 0 stays periodic on nohz_=
full,
> which alone is a problem for powersaving but also prevents a whole packag=
e
> from entering low power mode on NUMA.

That's not a problem for the above because it uses "isolation" for
taking some specific CPUs out of use (CPU0 is never one of them
AFAICS).

Also, it does depend on idle governors always putting those CPUs into
deep idle states.

> Let's say it not optimized toward powersaving...

Oh well ...

> > So there are two use cases that cannot be addressed at once and I'm
> > thinking about adding a control knob to allow the user to decide which
> > way to go.
>
> I'm tempted to say we should focus on having not too deep states,
> at the expense of having too shallow. Of course I'm not entirely
> comfortable with the idea because nohz_full CPUs may be idle for a while
> on some workloads. And everyone deserves a rest at some point after
> a long day.

Right.

> I guess force restarting the tick upon idle entry would probably be
> bad for tiny idle round-trips?

It wouldn't be exactly cheap in terms of latency I think.

> As for such a knob, I'm not sure anybody would use it.

Fair enough.

