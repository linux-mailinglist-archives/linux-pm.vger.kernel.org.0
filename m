Return-Path: <linux-pm+bounces-15029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235098C56B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07C81F255FD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327321CCB3F;
	Tue,  1 Oct 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQKkEate"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C4194083;
	Tue,  1 Oct 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807482; cv=none; b=j5U14i+f4XU+E5J7f+ZkEFdu6JtnA53rtqjuSy6zOzZwxNvyfb6llFDAYY5YMOHMFzWibPzbIDJH/Xy5gOF7sgYrlxZ1P4tvDXpjXo1KQrYM9hjp9cUvGnFguWf6OxdbhBLcUddUUcNCkhe6R1hm3mUseWS8quz46Fc9btOtN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807482; c=relaxed/simple;
	bh=2tk1PpL1DZ09dcBp6tnCEGsXYDa9FLALHb+6UNzOzgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeS142DIH/Y4HI/D2pW03Pikw+7yGMbbujTRJrNm23WZCgRaEoEb8gthDjIfrX6KJJIQ0gfk7yZOhs9Iy7RDIJYRGu0N/l2CaUcT8PrCCzwaS4I03KUdgdH4MkMxJI24Mq1vyQDBJnbvOQuZXsS6IVYXgJLP6hKg/wgkdRjsp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQKkEate; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BBC4CEC6;
	Tue,  1 Oct 2024 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807481;
	bh=2tk1PpL1DZ09dcBp6tnCEGsXYDa9FLALHb+6UNzOzgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQKkEate0N5vja8cnlVKCkyZGcDsOadL/GrC5VOCMAsKaJlX5Dfj6vTRhUgatearA
	 ABiX4Y93rq1vRH2kufQygARWvkE0y7ih9gcIjAqAUhbyd7akTfursAGlnaK5LruEft
	 bnweoqCkFVlfF6UAXzscUgHI/lbJjqhGxkUr+YBS17OAkb/eJJlpEZ1NtBUO/5FaXd
	 JSBlHEFoidWgRs4Mn/rIwURmnHRUEHMoAZn2vEWT+MiqSmt6/Sa/XCxfrGcx79t9/8
	 rQpaXrlZMPSnVsL8BCRXRAixyABQdb+mPN4c55bBaf5cj6M2SaIyFoLUsYktkclpvU
	 TAXkurPi5XXIA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e20de1d302so2835125eaf.0;
        Tue, 01 Oct 2024 11:31:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX5lhjAUrsUVnbPeeSkl/McReMD7u8QYEQUuFgFB1bwrKc5RL22Z9wWcczRarC5TdF+Wblj+RjN+NO8Js=@vger.kernel.org, AJvYcCXRQeniD0GrK/lw07PNBaF1OdSRlIyP9wokI75Bk3sEwPo2FLXsFP0/L8NaZHSIsiPuP0hIHNI77IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk+XtljrVYxSJa+UCj7DkJ91PM8aYVYa3qDLozt1GVueMrM8x
	mMuIesoP2zS59fOhBMUV2LQRfTqRmGjIzT5fi/GTeHY3E24tczPwBWyUVIcA4cH7/CQzdw/QWIN
	odCjsLw78w548U4Mh4U9t9OF4b8M=
X-Google-Smtp-Source: AGHT+IE2fKou/vy3MQNwqhzWobPpz2dXeNFsWUlf6kqsQzfiaJnKTG+dCtuITQruIeDcjUr5Zz9ZgzlsfmwvD2dyJjg=
X-Received: by 2002:a05:6820:80d:b0:5e5:b745:f73b with SMTP id
 006d021491bc7-5e7b1ccbe0dmr726796eaf.1.1727807480907; Tue, 01 Oct 2024
 11:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
In-Reply-To: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Oct 2024 20:31:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpdZBX5tJgdiOvEZbdRJ0kXxT6+uX=s++NG=dNrCMntQ@mail.gmail.com>
Message-ID: <CAJZ5v0jpdZBX5tJgdiOvEZbdRJ0kXxT6+uX=s++NG=dNrCMntQ@mail.gmail.com>
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Qais Yousef <qyousef@layalina.io>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:59=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and I'm assuming that this will go in via tip.

> ---
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm=
.com/
>
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index c6ba15388ea7..10faab849a3e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy =
*sg_policy)
>         }
>
>         sg_policy->thread =3D thread;
> -       kthread_bind_mask(thread, policy->related_cpus);
> +       if (policy->dvfs_possible_from_any_cpu)
> +               set_cpus_allowed_ptr(thread, policy->related_cpus);
> +       else
> +               kthread_bind_mask(thread, policy->related_cpus);
> +
>         init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>         mutex_init(&sg_policy->work_lock);
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index aa70beee9895..2ef1cb8626bc 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1172,6 +1172,13 @@ int dl_task_check_affinity(struct task_struct *p, =
const struct cpumask *mask)
>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>                 return 0;
>
> +       /*
> +        * The special/sugov task isn't part of regular bandwidth/admissi=
on
> +        * control so let userspace change affinities.
> +        */
> +       if (dl_entity_is_special(&p->dl))
> +               return 0;
> +
>         /*
>          * Since bandwidth control happens on root_domain basis,
>          * if admission test is enabled, we only admit -deadline
> --
> 2.34.1

