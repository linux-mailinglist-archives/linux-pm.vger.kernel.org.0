Return-Path: <linux-pm+bounces-19011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EAB9ECBA5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389DE285B62
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7223027F;
	Wed, 11 Dec 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMBJ15UY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467B1DA634;
	Wed, 11 Dec 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918375; cv=none; b=AlXWOlSakneUMcQ8QRqLbUE7S1DWmtDdHM42yC6OYvxxxYO6VfKzmihZ8+Hxzvy+VkW7daOxrNQAh+D1AKB0vNDx9xxGAgebneL8+yUuTGRlN4Lfz/y3iR1Pg8pSw/aLiQmHCeE58fpFj8vYvAYUqyyxqtaK/jA7iNZLfU8G5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918375; c=relaxed/simple;
	bh=MNkBA6TIZGvG0Roqh9owptn5qC3KsvWV8eG6jC0NJlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaZ4FwLl8UT4dQU3dOzJ9DD1umOIuzhwR+Z/J6i6jnpuap2Smukupd9KVKOUmIoBQIIiB85baTEu+pB9pdij7tCVG1vYvfN48G/XXzsLGzKlIh7RfXGnXoKwbsv+v+/anu18To+XYpf1n4i09LghHAXU/85Sdxa9YpRVXQ1wr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMBJ15UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7D6C4CEE0;
	Wed, 11 Dec 2024 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733918375;
	bh=MNkBA6TIZGvG0Roqh9owptn5qC3KsvWV8eG6jC0NJlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dMBJ15UYkDC/eYnczfESv5opqwm0EnpWmXVK+LMGDSqZ1P9Yn4z+XMvkr7iKWEUh4
	 t+yIjBQ9DIIjHnUQuy718busqMpZMbIqGneq0hIBH/kH0AzvQnnS7SfGkvonzMIIrO
	 plrfhenxeWU1/VfED2g4GvfM4X8k6RwbKK9pfV0BjPs9GP6GoPstULMGWYRi7Ws4A7
	 gHYHT6iJ8NNlAoYuuS3zA3AGzNlztbJysn5je6QBFTMXSRj8JXB3T8wcU0+/kO/NxB
	 V74o9NZCYQTZmaS6NRLtAvidYaubmdpK3KJBRpjWOIz3lCVDPjuS6DM906VM6uJi30
	 dyLRsHSq5BGFA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e0d4f2874so428337a34.2;
        Wed, 11 Dec 2024 03:59:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMQJFOnfTsnDtT5uV9ZP236qSRd+mDNKEjDvWW7Tdl+XyFxMlSOyynde5mhu5+16RotCIhDE/cSAA=@vger.kernel.org, AJvYcCW8ShasSgG7bQnBthY7Oh0NxwoqYq1ndkXgjYZqx1yttMf6Xl2PRfP+2vxeok+p329p7riAVlFz3c2Wgj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vozm6n0RZD/jI4OVgbxAj1BEBE9DuoBLN1Kfvn3NG32ScNE+
	Qi5ra9DLLvptZGv9fqDzVSj/emM1F+iAnqgDJugYRIm2KbjAhqClFTeD2eLxWcF8YTy/PVusGEK
	lNzaWKs2dL5/xrNizwyX7I9COVQE=
X-Google-Smtp-Source: AGHT+IENekl+hCD5HhEEY9wNj8jUl9RU7uJ+CBX7y3We2HOmIlquZ6N4zE+5e0b2LivS5aqdyboY6z9FE7cexSMSf9Y=
X-Received: by 2002:a05:6830:670b:b0:71d:f343:5f5b with SMTP id
 46e09a7af769-71e197e2e59mr1288502a34.12.1733918374423; Wed, 11 Dec 2024
 03:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
 <f16b11fa-bb2d-4e7e-81f9-80cf3a1f7a6c@arm.com>
In-Reply-To: <f16b11fa-bb2d-4e7e-81f9-80cf3a1f7a6c@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Dec 2024 12:59:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hyWN8hzw2k7JjO9Ap4Nx-sqpXYwzHQPo-dOxr+nxA4GA@mail.gmail.com>
Message-ID: <CAJZ5v0hyWN8hzw2k7JjO9Ap4Nx-sqpXYwzHQPo-dOxr+nxA4GA@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:44=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 12/11/24 11:29, Rafael J. Wysocki wrote:
> > On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/29/24 16:00, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make it possible to use EAS with cpufreq drivers that implement the
> >>> :setpolicy() callback instead of using generic cpufreq governors.
> >>>
> >>> This is going to be necessary for using EAS with intel_pstate in its
> >>> default configuration.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> This is the minimum of what's needed, but I'd really prefer to move
> >>> the cpufreq vs EAS checks into cpufreq because messing around cpufreq
> >>> internals in topology.c feels like a butcher shop kind of exercise.
> >>
> >> Makes sense, something like cpufreq_eas_capable().
> >>
> >>>
> >>> Besides, as I said before, I remain unconvinced about the usefulness
> >>> of these checks at all.  Yes, one is supposed to get the best results
> >>> from EAS when running schedutil, but what if they just want to try
> >>> something else with EAS?  What if they can get better results with
> >>> that other thing, surprisingly enough?
> >>
> >> How do you imagine this to work then?
> >> I assume we don't make any 'resulting-OPP-guesses' like
> >> sugov_effective_cpu_perf() for any of the setpolicy governors.
> >> Neither for dbs and I guess userspace.
> >> What about standard powersave and performance?
> >> Do we just have a cpufreq callback to ask which OPP to use for
> >> the energy calculation? Assume lowest/highest?
> >> (I don't think there is hardware where lowest/highest makes a
> >> difference, so maybe not bothering with the complexity could
> >> be an option, too.)
> >
> > In the "setpolicy" case there is no way to reliably predict the OPP
> > that is going to be used, so why bother?
> >
> > In the other cases, and if the OPPs are actually known, EAS may still
> > make assumptions regarding which of them will be used that will match
> > the schedutil selection rules, but if the cpufreq governor happens to
> > choose a different OPP, this is not the end of the world.
>
> "Not the end of the world" as in the model making incorrect assumptions.
> With the significant power-performance overlaps we see in mobile systems
> taking sugov's guess while using powersave/performance (the !setpolicy
> case) at least will make worse decisions.
> See here for reference, first slide.
> https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2=
022_Energy_model_accuracy.pdf

I've never said it won't make worse decisions, but whoever decides
which governor to use should be able to check which one is better.

> What about the config space, are you fine with everything relying on
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL?

Yes, that's fine.

I think that schedultil should be the default governor for EAS, but I
don't see why it should be regarded as the only one possible and so
enforced.

