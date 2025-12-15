Return-Path: <linux-pm+bounces-39543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6248CBD78F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F1D3047930
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10433030C;
	Mon, 15 Dec 2025 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH/8abIb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB7330309
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797134; cv=none; b=kAa0JuxrPoFFQpG6Gmy4l8qJXn69tgaeLzRfdgAaF/eQoyQJYyCUf2xo6bjAVxa3NCG5WKWYAsaGf8M6quvgTEUADl941iJYrp/KVkKjIKdoAEx5eaJksmAexMCSJXpvo/I1ewzChLfSywoZkv4YtnhuusMbVM/gRPCNqbA7Bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797134; c=relaxed/simple;
	bh=PfyeLEgI6Wzc6o2hbREqBJyP/hoLKlVKC4Tey8dRMWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE8Mj56YW3JDSdkYhQRtzD2UbV3rdarO+f9Mg3+pWLCWRrXQFOzd4Fuo7XiJcLwBvH/fYTNCg1VhxBTa7mcN+fx7vkU+9zXQhPBsEPyiCoybCviDD/5O0xVCpV2sK107e3/ElesJAxFabgLMV2R+XscSncgrs3KORfq5AUwjj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH/8abIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C108EC4CEFB
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765797131;
	bh=PfyeLEgI6Wzc6o2hbREqBJyP/hoLKlVKC4Tey8dRMWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gH/8abIb888eXzKc5+UnrJtBkuQQoc8dLfX2sIn2OD97GS+zNSaYwt37kfrP3Es5X
	 zdpIm/Rp8bCQFeCbFy/AROWZCL251Ty0lW7c0tZB+KwVj+4Wo7Y+ZpopMOPUggm6q8
	 NRZ9DaHA5ByJAXP6/dQf33lHznLM8qFCAfJ9iCbm+JGqdjJc4V1psB9cNEZPH1E0hO
	 jbHYUWGzWv9/qeoXd8kiBYwOlI/pHH3aX+j6IMJuq4gVa5XeOWSlz3E3XTx4JiXeRl
	 w01K5aoAZSY0XytIYQdd/Np2jPCXr3M6Fz8a0M8UWq/ybV/CU+vxUKKVabwCXaYVh1
	 C2WMsbeIhwKBw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6597cf49101so1947705eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:12:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+Ng3FSF0gJ1WvOb9fefSQUN+En8cB6RveeixnS1At0Mtdnvd0sbMaZJYOpj5QdTtvwXnpkv+iLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLc4jIbK4XevGA9VFlG/TVpVOxodw0w2+CLEoBoSoml3y5WWmG
	7BT2XgSamCN2Jpc6mBY5o350oDEhFcUOVTlkE/k18oQIcpW/neEPVJDb5U9Q4mHJWEdotOAsUEt
	4+FyWOgcCmagj6Kd+lBjjrOoxv9wuNQw=
X-Google-Smtp-Source: AGHT+IGZT1oNvB00Vs0bo+1zSzNBqfaw6T6Q5aS4m9jK/Kze3wHdZKUoJCgVLJBOELGz/mfBFrHcJOmixXKZ8YRAhzQ=
X-Received: by 2002:a05:6820:1623:b0:659:9a49:8ea8 with SMTP id
 006d021491bc7-65b4523bfd8mr5105858eaf.44.1765797130168; Mon, 15 Dec 2025
 03:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215044919.460086-1-ankur.a.arora@oracle.com> <20251215044919.460086-13-ankur.a.arora@oracle.com>
In-Reply-To: <20251215044919.460086-13-ankur.a.arora@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:11:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0imk5kdqunNGvK+6_BPh2_k89RPPC8B4MDDF1GLZrUhLQ@mail.gmail.com>
X-Gm-Features: AQt7F2rG4xuAbbsQmykYUcenlgwWyBYqZnb2M67LAaRf0_2PJQ6JaqpYbcxHgdI
Message-ID: <CAJZ5v0imk5kdqunNGvK+6_BPh2_k89RPPC8B4MDDF1GLZrUhLQ@mail.gmail.com>
Subject: Re: [PATCH v8 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:55=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
> The inner loop in poll_idle() polls over the thread_info flags,
> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> exits once the condition is met, or if the poll time limit has
> been exceeded.
>
> To minimize the number of instructions executed in each iteration,
> the time check is rate-limited. In addition, each loop iteration
> executes cpu_relax() which on certain platforms provides a hint to
> the pipeline that the loop busy-waits, allowing the processor to
> reduce power consumption.
>
> Switch over to tif_need_resched_relaxed_wait() instead, since that
> provides exactly that.
>
> However, given that when running in idle we want to minimize our power
> consumption, continue to depend on CONFIG_ARCH_HAS_CPU_RELAX as that
> serves as an indicator that the platform supports an optimized version
> of tif_need_resched_relaxed_wait() (via
> smp_cond_load_acquire_timeout()).
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>
> Notes:
>   - use tif_need_resched_relaxed_wait() instead of
>     smp_cond_load_relaxed_timeout()
>
>  drivers/cpuidle/poll_state.c | 27 +++++----------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index c7524e4c522a..20136b3a08c2 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -6,41 +6,24 @@
>  #include <linux/cpuidle.h>
>  #include <linux/export.h>
>  #include <linux/irqflags.h>
> -#include <linux/sched.h>
> -#include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
>  #include <linux/sprintf.h>
>  #include <linux/types.h>
>
> -#define POLL_IDLE_RELAX_COUNT  200
> -
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start;
> -
> -       time_start =3D local_clock_noinstr();
> -
>         dev->poll_time_limit =3D false;
>
>         raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
> -               unsigned int loop_count =3D 0;
> -               u64 limit;
> +               s64 limit;
> +               bool nr_set;

It doesn't look like the nr_set variable is really needed.

>
> -               limit =3D cpuidle_poll_time(drv, dev);
> +               limit =3D (s64)cpuidle_poll_time(drv, dev);

Is the explicit cast needed to suppress a warning?  If not, I'd drop it.

>
> -               while (!need_resched()) {
> -                       cpu_relax();
> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -                               continue;
> -
> -                       loop_count =3D 0;
> -                       if (local_clock_noinstr() - time_start > limit) {
> -                               dev->poll_time_limit =3D true;
> -                               break;
> -                       }
> -               }
> +               nr_set =3D tif_need_resched_relaxed_wait(limit);
> +               dev->poll_time_limit =3D !nr_set;

This can be

dev->poll_time_limit =3D !tif_need_resched_relaxed_wait(limit);

>         }
>         raw_local_irq_disable();
>
> --

