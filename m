Return-Path: <linux-pm+bounces-20893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F406CA1AAE3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87A63ABE00
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D901ADC77;
	Thu, 23 Jan 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBSZOFpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E118872D;
	Thu, 23 Jan 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663046; cv=none; b=lejp3EwTKJfNiibfKTgfyhPpvjZaPcqEGMTgVyBDS3ZDGm6Z38SbLFttI5iW8+BJpvVAujmCy63YrwjdLX2nnpnINZGEQFtWtGl+IG/MvGtt9xsopDiguoh4JuNe/3A/qgp6od0CWLfuv7eNC4HhRhA4krPVVSHRw8upHG3xZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663046; c=relaxed/simple;
	bh=qL3PJ7U4L6GLdQsWeJfgNaoIGfeOFzKldfjTjUPrhMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML7H+BNV4T74AdDHmUIdq/TMsP13IwpkrciFTU0YX7skrQ5hFar+ZtVxDzBZVL2nE3JStbJDn3iansUDbOwz0Y6Vr/MXLs8/3r7TcOjyLdH8pP8C4WbrGWaJxSESBjZPdqUEcx/rgXRpNcS5FeyiZ6n2ZAiFYUthH09KY6m7tvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBSZOFpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A6C4CEE2;
	Thu, 23 Jan 2025 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663045;
	bh=qL3PJ7U4L6GLdQsWeJfgNaoIGfeOFzKldfjTjUPrhMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YBSZOFpOcM/aSFnoESUvlnSZfCjMuznPJcmYy3ngp5yvI3ZlCNGtKsKMUGoEy/ful
	 Ohk6KW0M85iNxVKq1ch5LiMieFMyOnrj9zRiialsmcttpTSZ0a9KJhQ8jxfjICY1Xd
	 zSTF0ZqLfPbsRP+v0OzZvz7eseEQfxj3hC8qqIOzXUjxKnAZuVzbg9eEep047tQ+3g
	 yMXWmXmuwok6PEjfkc9H27UoZtXAmPCln4U4c4KGDH3WVQfyfcMBPg6Y0DQ08gpl5x
	 Ak22GQN1m1R17esJwz7O6rcMs1iQaNR1V5NuF7VhoRhFblSNclnv5pUlZfW5NOGXpJ
	 Ju2ccX9Zb4orQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eba7784112so762826b6e.2;
        Thu, 23 Jan 2025 12:10:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5xmeK988VQEAEKM4WooFw4H5nR7/75bZVtIj3RUj0ooKXKtengT/1ewE4n6k9i13BcHqSDGHS85o=@vger.kernel.org, AJvYcCVAniJBh11hgPUOgWTE40kbQi9vd4VIirPoqBNvUan7bsolSjg/xzsmEKKB+Y1WojecV8vvxUnjyrIzVyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypQfK42SKcDzgKvecwT59iwoNKg6XzH6noIfoh/Q2ObYJKd1F
	LV1MXvy2YhY3MGEDxLc/4UJarr04eHrlkcOLzyqbp/WfO+vfVVYtAjXivqzqsbPvMXZMXkj4DJ+
	cBzyIxAvvrfCOqy2UrYwRuLVoWNU=
X-Google-Smtp-Source: AGHT+IFB758LNltDOV/4VqAtC8tPEids+QnSGbTsIm4MaOgW98uNReIWuBTVAFzRQySF0e6R0K2nE8XV1nO3X4iF6nI=
X-Received: by 2002:a05:6808:4e15:b0:3ec:d34f:4c6f with SMTP id
 5614622812f47-3f19fc55c98mr11800107b6e.15.1737663045140; Thu, 23 Jan 2025
 12:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a8deed4-7764-4729-a9d4-9520c25fa7e8@arm.com>
In-Reply-To: <5a8deed4-7764-4729-a9d4-9520c25fa7e8@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 21:10:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hyMTFq6P-oZ34Ds5q=stDR=B2jLt3Qo0QQAo3t3Cu+Wg@mail.gmail.com>
X-Gm-Features: AWEUYZklJ1hsdmzrW1ZkMjH3iCEXddrCfU9LydoViSkicH5yMdGrY8EzfrxiQ2U
Message-ID: <CAJZ5v0hyMTFq6P-oZ34Ds5q=stDR=B2jLt3Qo0QQAo3t3Cu+Wg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 11:10=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> - RESEND: pick up tags
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v2: https://lore.kernel.org/lkml/a4a70646-98a4-4b85-955e-62d66ba68927@arm=
.com/
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm=
.com/
>
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 28c77904ea74..a81444501158 100644
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
> index ff0e5ab4e37c..8230358d2b90 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1139,6 +1139,13 @@ int dl_task_check_affinity(struct task_struct *p, =
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

Applied as 6.14-rc material, thanks!

