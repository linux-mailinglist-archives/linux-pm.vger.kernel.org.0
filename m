Return-Path: <linux-pm+bounces-19041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA89ED238
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520A6286962
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448601DDC13;
	Wed, 11 Dec 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAYnPKfE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1691A0726;
	Wed, 11 Dec 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935082; cv=none; b=JD/2rRDomTCLkk+KStTOD7snAEjzId3+VHGhRbH3i3HKMoJpA2zp8yMZ7WdZ+bKSP9vNjARD9V5d1YMbDOTa6axnPQRWDXtnBnD3FYMkqtYt6xjf8JS6u/umCU36Qfb5l5MFONK9lYNEFSKhpSiA7S/EGBTsbjs3escBDhB5Cgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935082; c=relaxed/simple;
	bh=DzNg1nNLOV9YY7qmQrhnK+BjmPKWYZ1MzCRkhHn3zh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT3XrTjBXRA4maD3a1ADfVK9mtdjkKGDo1dxySF6HU4tl46A30NFPvT7qK9sDpEU5Sx2lIC0Fu11iVEVOTJCSknS2vLTbBEwMuhCRXhYJVoJnRvuUDaEg0aTzYTSMfiZpVlFKoKnbLKuSpd4+wSOWhrbUv5MWmQWX+XPawdnMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAYnPKfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988FC4AF09;
	Wed, 11 Dec 2024 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733935081;
	bh=DzNg1nNLOV9YY7qmQrhnK+BjmPKWYZ1MzCRkhHn3zh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TAYnPKfEp8L6bNBl/klNCPKJgj7h9rtD9JmO5vF4L5lr73DB9TjYb0mbcBrYvhPac
	 RLlpV6eSsgGmGbwGwHHhN4flJIEarIvdt+mPuGfz2+FqOH/DmW33uRR9vn3V+CuKaR
	 gtfO21aSx0n7qV7FCNDB4hExug4qXKNIBu+E0f+VfMJBJNKrVU994FnGBGQP4uisZS
	 DSdilrRWAdYz60KffX/UxCm4oAmnKBFyV0UpbY4YNOGsoVWTnrYfIAxSwUfx19wS7s
	 2kyxcZBc3NyhkgkmFvWwFkdTj6jwStUrGkvp+8F3B9FuDsYoeiFgrlW9u5JM99kpIV
	 /iYl7SkVdFHGw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb38f8a178so1822620b6e.0;
        Wed, 11 Dec 2024 08:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5K3n6moVqSrqdexefKjKyD8vGI0URgwrLg4KO/eghGhN/mfBNjOfQ7WLaXoRqyY5E+Ivjd9RJ2Dw=@vger.kernel.org, AJvYcCWdIyFnvFDxwzGp4GSQ+VjP8aGNbRpEle4YU16PcfWsZ0g4yQrGxoOLQxMrFEeVTIs9SoKwbba4KsqDi+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBE+NN0qK0Tgz+ovLQapUG0G6RzKmG0MNmVzxoODa0nIAhzYSr
	b37u9wkeOUsW9QeUXtpVwVqbrg+TDxTkTqiajnMK5LsjINpfznBBLp+0sNZ0/c/Yp0a8TvzqefE
	m5va2gqyOo7tB0mSXXbkcrC1RLIU=
X-Google-Smtp-Source: AGHT+IFfjn+qK73VeeYnFxJyHVlSrPDqk36Sv0Ll2N3awPW/zMJXLwupa8aX5qehdXFr987t2GSxogY4M92VTQrAIy8=
X-Received: by 2002:a05:6808:1590:b0:3ea:6533:f19d with SMTP id
 5614622812f47-3eb85d4c4c1mr2313847b6e.30.1733935080728; Wed, 11 Dec 2024
 08:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
 <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com>
In-Reply-To: <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Dec 2024 17:37:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com>
Message-ID: <CAJZ5v0h5yt5z=dHLJjQhQQChsnr+krcxzBdb6VXj9W4gMY_PSA@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:25=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 12:29, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Make it possible to use EAS with cpufreq drivers that implement the
> > > > :setpolicy() callback instead of using generic cpufreq governors.
> > > >
> > > > This is going to be necessary for using EAS with intel_pstate in it=
s
> > > > default configuration.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > This is the minimum of what's needed, but I'd really prefer to move
> > > > the cpufreq vs EAS checks into cpufreq because messing around cpufr=
eq
> > > > internals in topology.c feels like a butcher shop kind of exercise.
> > >
> > > Makes sense, something like cpufreq_eas_capable().
> > >
> > > >
> > > > Besides, as I said before, I remain unconvinced about the usefulnes=
s
> > > > of these checks at all.  Yes, one is supposed to get the best resul=
ts
> > > > from EAS when running schedutil, but what if they just want to try
> > > > something else with EAS?  What if they can get better results with
> > > > that other thing, surprisingly enough?
> > >
> > > How do you imagine this to work then?
> > > I assume we don't make any 'resulting-OPP-guesses' like
> > > sugov_effective_cpu_perf() for any of the setpolicy governors.
> > > Neither for dbs and I guess userspace.
> > > What about standard powersave and performance?
> > > Do we just have a cpufreq callback to ask which OPP to use for
> > > the energy calculation? Assume lowest/highest?
> > > (I don't think there is hardware where lowest/highest makes a
> > > difference, so maybe not bothering with the complexity could
> > > be an option, too.)
> >
> > In the "setpolicy" case there is no way to reliably predict the OPP
> > that is going to be used, so why bother?
> >
> > In the other cases, and if the OPPs are actually known, EAS may still
> > make assumptions regarding which of them will be used that will match
> > the schedutil selection rules, but if the cpufreq governor happens to
> > choose a different OPP, this is not the end of the world.
>
> Should we add a new cpufreq governor fops to return the guest estimate
> of the compute capacity selection ? something like
> cpufreq_effective_cpu_perf(cpu, actual, min, max)
> EAS needs to estimate what would be the next OPP; schedutil uses
> sugov_effective_cpu_perf() and other governor could provide their own

Generally, yes.  And documented for that matter.

But it doesn't really tell you the OPP, but the performance level that
is going to be set for the given list of arguments IIUC.  An energy
model is needed to find an OPP for the given perf level.  Or generally
the cost of it for that matter.

> > Yes, you could have been more energy-efficient had you chosen to use
> > schedutil, but you chose otherwise and that's what you get.
>
> Calling sugov_effective_cpu_perf() for another governor than schedutil
> doesn't make sense.

It will work for intel_pstate in the "setpolicy" mode to a reasonable
approximation AFAICS.

> and do we handle the case when
> CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not selected

I don't think it's necessary to handle it.

