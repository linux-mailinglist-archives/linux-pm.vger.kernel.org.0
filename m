Return-Path: <linux-pm+bounces-29708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4EAEC0A4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D33B1F64
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772E2EBB8E;
	Fri, 27 Jun 2025 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+mrC+KL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8D2E92DE;
	Fri, 27 Jun 2025 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054810; cv=none; b=YDm87H0p/TmaRe0lFrf3Lv/i4/F/YjUUKnGZ4kSZ9jlNeDmFod7qau4glC+yW1peUB+IlaadIvKSsSvZofUuCmjFuJVE5Tu3o8OPqjKDtYWxDFpSEMtUd6JSqqUU4k+H7BFAonznCOSJmQmCRbAB6iyWf5uVQouICwEB1ZslJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054810; c=relaxed/simple;
	bh=lUbLy6tr9MnS/fi2ZDpmIKBjVm+IUSQ0Zz6ho5toUrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy5SXvrHabVk+rwAF1Y2VsvzqC27V2u3IbWlKcwX/sDb1mcNK4JJifXnEV79OXSG5ERPzyxdWBhi6EPC1tz6q8Dzc2F0wnkqEK/VV2TGxstLxj/rn+M7Q8/UP+dbIu+SoVdVEs5cM60hdFlBFMr9q0/FwE7c32HOZKsJ9NinPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+mrC+KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1DC4AF09;
	Fri, 27 Jun 2025 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054809;
	bh=lUbLy6tr9MnS/fi2ZDpmIKBjVm+IUSQ0Zz6ho5toUrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c+mrC+KLh31qNeCNDOTO8RPmXFMEFmLyJul0NpQ0avnGtjoqtduBZ9cyB1RLVJZGv
	 q6PZC+xDQKo3K70aaSuyybqLr/wmlyxv4lnW+wQLm2ZRqtyAL0oWJutDQxQW1snGUd
	 NvlGbljm9vpbdqa10nQZsrVheuzHLagDReDEIsz5aHUaXJRWZgSVwHsURVH3eANs7W
	 J4M8RHJEw3zLBuN3lOgdZ8AGeDkE1qQTYciB/AyuUMduZENqsN3C/boi7/S20N5rwf
	 2x+GQClJckDlQB+ksSCngyjDevP+a9uYC/C8AI9BvH96yGT6QD9cbKxdHFqklSch1l
	 qU2TfdfhI4UXg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4067106dd56so180533b6e.3;
        Fri, 27 Jun 2025 13:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdq1+x5VC9s4UqUgDhmwLXMMT3nKLe8CxuiAhTdJOIZqcvhYXJbxqJNLCCq+r60TfPjVK7zzQDKZR/jXE=@vger.kernel.org, AJvYcCXrmJSsS+9CKqyR/KnK2QuV2DOhqDpRRobXBozPQ8gR/5CL0mVJJbiW1HK1l/8S0vnuMNCc5bt3xsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0xrHBk6QrGNkPg5m7KHOmlWRU8sc5wOSCV/ZU50WrE+3WfT7
	oErdOuS2ugjwYTTvr/TdZ6pY3aes71cFpFbAtXT9KzMnetGYmPeDCwBtjrQyAknJ6KjtubrBL/B
	ssgKXvvhadcDJOcGJSZ7/3J6KOp2Hvb8=
X-Google-Smtp-Source: AGHT+IGr9fjpnEvMmJFVTLGYuArAp7XEjDxEvn1wO3Cm2PhSG7OZFGWMSl1IpyB5qTC5QvjNIiEYG7LqUE1ES4mt4X4=
X-Received: by 2002:a05:6808:3193:b0:3fa:7909:2716 with SMTP id
 5614622812f47-40b33f0be05mr3396451b6e.39.1751054808977; Fri, 27 Jun 2025
 13:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618231632.113471-1-sivany32@gmail.com>
In-Reply-To: <20250618231632.113471-1-sivany32@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 22:06:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXPten8QwruK_Dqzvc0izLCfecMPBWMMoP8cnG4mDY0Q@mail.gmail.com>
X-Gm-Features: Ac12FXx4lWajtq8ZPMViem2NaL56OASXO8y0QG0OJOivv_f2HGM3Nw5I6TL8YFo
Message-ID: <CAJZ5v0jXPten8QwruK_Dqzvc0izLCfecMPBWMMoP8cnG4mDY0Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: dtpm_cpu: Fix NULL pointer dereference race
 during CPU offlining
To: Sivan Zohar-Kotzer <sivany32@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, elazarl@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:16=E2=80=AFAM Sivan Zohar-Kotzer <sivany32@gmail.=
com> wrote:
>
> The get_pd_power_uw() function contains a race condition during CPU
> offlining:
>
> * DTPM power calculations are triggered (e.g., via sysfs reads) while CPU=
 is online
> * The CPU goes offline during the calculation, before em_cpu_get() is cal=
led
> * em_cpu_get() now returns NULL since the energy model was unregistered

But energy models for CPUs are never unregistered.

> * em_span_cpus() dereferences the NULL pointer, causing a crash
>
> Commit eb82bace8931 introduced the call to em_span_cpus(pd) without
> checking if pd is NULL.
>
> Add a NULL check after em_cpu_get() and return 0 power if no energy model
> is available, matching the existing fallback behavior.
>
> Fixes: eb82bace8931 ("powercap/drivers/dtpm: Scale the power with the loa=
d")
> Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 6b6f51b21550..80d93ab4dc54 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -97,6 +97,11 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>
>         pd =3D em_cpu_get(dtpm_cpu->cpu);
>
> +       if (!pd) {
> +               pr_warn("DTPM: No energy model available for CPU%d\n", dt=
pm_cpu->cpu);
> +               return 0;
> +       }
> +
>         pd_mask =3D em_span_cpus(pd);
>
>         freq =3D cpufreq_quick_get(dtpm_cpu->cpu);
> @@ -207,6 +212,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>         pd =3D em_cpu_get(cpu);
>         if (!pd || em_is_artificial(pd)) {
>                 ret =3D -EINVAL;
> +
>                 goto release_policy;
>         }
>
> --

