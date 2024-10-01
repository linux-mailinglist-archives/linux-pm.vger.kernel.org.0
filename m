Return-Path: <linux-pm+bounces-15014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406A598B907
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F27B21CBD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BA1A08DB;
	Tue,  1 Oct 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awv9XCLc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46D1A08BD
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777669; cv=none; b=txL66q+QuAplLC5yr3jNnahe+0+ofmXh8/r86XwrSgYpXZ9BI8sL1tHqWmDY7AWm6D1pQRL3/3BVyXGMywkEUlBnP2jyJ68eB0hPldJUlOW4G0taLcQksEvytxatdLxds9Ob1qeyM+i3EsaaZflPQAn5bsJzRbnKmHbWUS/Vo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777669; c=relaxed/simple;
	bh=C9Z3BNLw6LfFJPLPyGgEm8h2Ama/2rQyMGSHUPjWohs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYMnmRKA8vVW/craeUH6bhsuGOyqZVViA9OgzBdOJU/DkJlUbYZ3rKtD6I1idS8r6dfmNtpwNj7kMDi+12wBBoJQcuno0bHeeBCRR/uBeFnnsgPOowHM8ncaepjjls6IDT1Qc9cvGytsFKimlIfYxIVcR9eNUJFvpxjIX3kFzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awv9XCLc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b90ab6c19so18358975ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2024 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727777667; x=1728382467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxgg1V9IIYjZBuF6K7HNHwUu/QxJj4beWplXFzMVBU8=;
        b=awv9XCLcZcUuMXPCWyr3f5pWzJ/K3YzOSRmi1mm/GZnNuj/bO+Nc0uA2c/7wKExy6A
         zhSRTfk4oi5gQAnWAoTiSC3BdVoqiYIHnZUg7QN41LhUtUG6lZGfzyALCvA4fr9tuT6V
         fzOb8sPJkUjWXpUtC5J/55GoPdymdkuD3FGzT6a4iGhBiN0pNsmWEsnGn10RHrcoPRjd
         JK5Z+Qy++xvf5fzTdCzszZXMgVWA6R8q6tR9c1pjiH03KAlOKbZYs1aTceEDgKspseZt
         7xPGfQ+CIUj3orYrdjeJYvVY12Txe05NsusniF53KjIgyGdEXPP0kg318T7xU1LJYESi
         Frdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727777667; x=1728382467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxgg1V9IIYjZBuF6K7HNHwUu/QxJj4beWplXFzMVBU8=;
        b=PB9miNYTb5bfi3HkLI5W/hWnmlDHkGyKSKl8+vugz1PKCIL05WFuau5FNeXQ/dlaWG
         vfeC4SM620kw1rSiWZDW+wYUKSPBirmDWaQxiSdIbBh6BW+pB0+4UuOlQE3+hCRzFRmw
         Dc7+tZqCXHgbUCNuYtYvwLynAaoL340sE6kOcyzgot0TTexp5xVvHeduBpdogjibHEql
         kKrjO/lGTx5wbPwTLOw+ZRWqDHyvN4/hAIqOZRauZaqnlK2C5dmxbTX6hVlhfUVIFHbX
         1dwFrHLuEcT1ZWw5kDZf7y3ch5HXYhWApVczPlOru9uhs7T7FEt49uIt7rKZR9fJwC+d
         R8nw==
X-Forwarded-Encrypted: i=1; AJvYcCUGROcTkEGuWiKtJy7xqFp9byEKHzNzKiucTG1rNML5uAwWmgMEP18vp+Ti6nNs4aakMUjhzpaGOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKNss4aijHLUBIHEccunZI/vmrWCqkaSL72ssHcndqQAlfjlD
	/tz34X6KpceCclLmj8J3/UKQtTnxvC869wZEMW614LsUso5S5xkWXFQIiTPQKW+QaFpoYfZ3XxA
	VKSvM/LmvPE5Sfg7KuTA1CFj+Z2P6cMjQV2UP/A==
X-Google-Smtp-Source: AGHT+IFAojq+hFFSbm6O7/pXPyOERGD3B3lbulOnL3rtAdpTiqzTE+pyZUDKRIKCN7iAQe4rHeQMfPLtKXjYsepmUpY=
X-Received: by 2002:a17:902:c94a:b0:20b:9b07:7779 with SMTP id
 d9443c01a7336-20b9b077929mr77225635ad.15.1727777666774; Tue, 01 Oct 2024
 03:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
In-Reply-To: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 1 Oct 2024 12:14:14 +0200
Message-ID: <CAKfTPtDOvbsOUa-nQgcv6BkEbDcmf4z3M2NtYoS_GCcMspXjuQ@mail.gmail.com>
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Qais Yousef <qyousef@layalina.io>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 10:59, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/
>
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c6ba15388ea7..10faab849a3e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>         }
>
>         sg_policy->thread = thread;
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
> @@ -1172,6 +1172,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>         if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>                 return 0;
>
> +       /*
> +        * The special/sugov task isn't part of regular bandwidth/admission
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

