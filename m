Return-Path: <linux-pm+bounces-14098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A68976E04
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C09A1F215A0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC81AD27C;
	Thu, 12 Sep 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVcj/0SI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40D126BF9;
	Thu, 12 Sep 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155723; cv=none; b=YML7EDr6Q+taREzYtZcLO57AkUSgp6Kg+H1kbB8x3k/fvVk8qpyw7uaTQ9+CLMbMxUmWxaIPZJDuosysI9dmeTJjLEhyAxudWNJjSKnFcDty7e/230dguDTkTskz/965i3d91R6eo8jz+OcjQsaQIEQxG3t87bz6tOCgfWUr+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155723; c=relaxed/simple;
	bh=itpT31jkLmdvvohf3458b3/YdZyoT0XRFQhv27nwFb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwV5kehp525PV7bmYgkjw2Xv00IMs/kC4XO5Y0B1Ci3IEN26L+iGjygqK39SQDBVfMk62oa8zZbWGwqcKmqdCmcWj9hyd9q1HSVkFRiOCNeK1pMg2+7lTUGFOzW7h1Q75s3+Qmyz7XziMr2l6PReW1CkAphRiezLG0ZCU3RXdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVcj/0SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24F8C4AF09;
	Thu, 12 Sep 2024 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155723;
	bh=itpT31jkLmdvvohf3458b3/YdZyoT0XRFQhv27nwFb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VVcj/0SIq2kouuIHC9V7tR0fCaZqZgQ6HwpHfd/pL0w25jH/pApuYmHeqjcfgZ660
	 GX4FTy7Gf4et3kdEgoosu2+9fM4d98kEXpmCEzRDmAjGVFhkwmuJkqioAfhtDqjPdw
	 LxPDg4wqJMadUQJHFel5e5RKejP7l66esf4eNmHb7gAGAQQlIeoF9MSE5oHTBMJCaS
	 oVCPGABA1tID+BUkNvbO2kWBdoLRvYGt1j/AYVruJ9dNLl2ozhlc7oucovL9Yizzc7
	 enP6W+ckTdj3aPngu896TURBJLggLFetdpO1ZSuNiTHveLrb2UpCLGvDV5/xcz0cj2
	 FjJOmNB2PryqQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277dd69d6d6so1079522fac.0;
        Thu, 12 Sep 2024 08:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCvbSDBja2i4Z2XyXRp6UQsjY0yE0d7hsG8snr1x6K3eFGS6S9u3spmnn6XXhw8NoE5TePppmhmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvGmr6uuog4a81GH4T5pJLEqOqTLkA+xw6Hsi/9pGYmyQDvSv
	csq3NLljc1VGhYCXxrp3pHxgY3SKZ5x6MHsqOdK2WMlnVjuDpOj0sd9yS7Gvt0bR0fgm4hj0aIH
	0DAXRMspea9auvhy1lIfeuFOxA+U=
X-Google-Smtp-Source: AGHT+IGDoeGEGPkbquL90K+0EPUlHdEKEz0aCGOlch8RVj96bj7GrqW4L2AmP/Bl//N+GfB14ibdvwqoHhD4XXXNi4Q=
X-Received: by 2002:a05:6871:6a8:b0:277:fa33:a19f with SMTP id
 586e51a60fabf-27c3ea11b7bmr1612963fac.10.1726155722261; Thu, 12 Sep 2024
 08:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
In-Reply-To: <480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 17:41:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Message-ID: <CAJZ5v0h_AFNe2ZynDseE7N_5U9DV4NnLEhw9w=ErGuBswfpWow@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/schedutil: Only bind threads if needed
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:53=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
>
> Without this patch the behavior of sugov threads will basically be a
> boot-time dice roll on which CPU of the PD has to handle all the
> cpufreq updates. With the recent decreases of update filtering these
> two basic problems become more and more apparent:
> 1. The wake_cpu might be idle and we are waking it up from another
> CPU just for the cpufreq update. Apart from wasting power, the exit
> latency of it's idle state might be longer than the sugov threads
> running time, essentially delaying the cpufreq update unnecessarily.
> 2. We are preempting either the requesting or another busy CPU of the
> PD, while the update could be done from a CPU that we deem less
> important and pay the price of an IPI and two context-switches.
>
> The change is essentially not setting PF_NO_SETAFFINITY on
> dvfs_possible_from_any_cpu, no behavior change if userspace doesn't
> touch affinities.

I'd like to hear from Viresh on this.

> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 43111a515a28..466fb79e0b81 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -683,7 +683,11 @@ static int sugov_kthread_create(struct sugov_policy =
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
> index c62acf509b74..7d4a4edfcfb9 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1159,6 +1159,9 @@ int dl_task_check_affinity(struct task_struct *p, c=
onst struct cpumask *mask)
>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>                 return 0;
>
> +       if (dl_entity_is_special(&p->dl))
> +               return 0;
> +

Care to explain this particular piece?

>         /*
>          * Since bandwidth control happens on root_domain basis,
>          * if admission test is enabled, we only admit -deadline
> --

