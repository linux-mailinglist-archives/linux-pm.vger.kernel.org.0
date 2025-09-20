Return-Path: <linux-pm+bounces-35093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C5CB8C66D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBCA7A28AD
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A62F617A;
	Sat, 20 Sep 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e28VyjiN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8134BA2A
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366231; cv=none; b=Kekn7mfyN58qw0x+uja9kFLBfXgVs3l0AO3DNg5KGnbPqqjaJ6KKSj6yBU1JnUgKxD2WwnTEAvLGQn0DxWnvPuyKpVrpmgNzlgPwdkVIvfICOAQKqmFfOBek4C6+/rexESVvdjFI151Oqwx27EgGcQhcvsZR54nl3/oD4PUZtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366231; c=relaxed/simple;
	bh=oajWz/Pk5//uqUY2wQW5300sN6tGzd7WzqJWxKlkJmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fllFYf9MO8LTRFCjd6fjwIFPEeVlwYthEnhogL0JaBW4pTkdJcYQhviK47xYeTrRoUIurHTVkBlUOaqB7sU+6pVfBpKIBtPBcAuisKQzqBJ+cfJPM/trg1BOE5NmEmQ8x/g+uzyLj0pCXaaIeRPLsinnqXzx4qsmvVrw/GajvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e28VyjiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F8BC4CEEB
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366230;
	bh=oajWz/Pk5//uqUY2wQW5300sN6tGzd7WzqJWxKlkJmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e28VyjiNSIAS0l/4H0ncXv5azpGYAcRh7Joy3yn/A0H9VPuLYXL4F0jV7Xr4FSAfJ
	 hLAMhuJIp0DNYryTyjOwGVAkHxyciBL5C3jpWSKeYN4HLHHjcJcs0MMGHJus6LlxxP
	 ZrQr/UmIdQgySWMTJ0zuZ2gMqMxwStCCiGeGDmRpABz1KhgcGHX4JrFrTDPfMghUIG
	 Fo/GBM4szakiUPRboDt0TwhFjwUV5whPpb56igvIH3Q+cRC5rSyHfc6saZp5qdU60E
	 Gr6GYbqFzPGgczvCgIKcZua6PucMNx6p4CO1OJf85WBHFLcD7n+mmnTcupFLGlDMRx
	 SJErwThrh6zvw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-330d1565844so2015247fac.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 04:03:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuHn7azPknKnPv/JI8yjQ0lPbt8/NYa6bzGfdFtX5XgfudxZO9lI82x6fEYXiaoZzpg+mxIZfvZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mJUhOa3aTK89pzpdsptaHkKgkfNrq5gvLJXF3yVg0mPzyhZr
	JafxwTfksRxLxpcZ+jG4xnPBpAIILy5f3Fh8R3Bvjyx93d/JYr83A/9e93LRdum/rBIOfEMo9l+
	jHLrMlnwioYIOBGcbWkZHCflNaAD3N3s=
X-Google-Smtp-Source: AGHT+IFo5wLTIp9z4ZtxJcN2+S7aBhlvWJYB1uLZuzmKp6vzgq+f7gKV3PHe2XmRoIhwfYQkopZtFPS5z+RoDTQIyQM=
X-Received: by 2002:a05:6808:4fd0:b0:438:4356:b533 with SMTP id
 5614622812f47-43d6c252629mr2757924b6e.29.1758366229809; Sat, 20 Sep 2025
 04:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85e3df99-7ba5-4654-9148-5fff25ea0e5a@arm.com>
In-Reply-To: <85e3df99-7ba5-4654-9148-5fff25ea0e5a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 20 Sep 2025 13:03:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWTtQWVJ1VkC9AH4jtCLWFhak0adaiE0Yq=ZwVo+fscA@mail.gmail.com>
X-Gm-Features: AS18NWBP1spJEghYNvK9qzPaRQ8BzYpKBwjGyM3qU2Xj-HbouQM7YfpOWK6PtAM
Message-ID: <CAJZ5v0hWTtQWVJ1VkC9AH4jtCLWFhak0adaiE0Yq=ZwVo+fscA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Initialize cpufreq-based invariance before subsys
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"zhenglifeng (A)" <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:15=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> commit 2a6c72738706 ("cpufreq: Initialize cpufreq-based
> frequency-invariance later") postponed the frequency invariance
> initialization to avoid disabling it in the error case.
> This isn't locking safe, instead move the initialization up before
> the subsys interface is registered (which will rebuild the
> sched_domains) and add the corresponding disable on the error path.
>
> Observed lockdep without this patch:
> [    0.989686] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.989688] WARNING: possible circular locking dependency detected
> [    0.989690] 6.17.0-rc4-cix-build+ #31 Tainted: G S
> [    0.989691] ------------------------------------------------------
> [    0.989692] swapper/0/1 is trying to acquire lock:
> [    0.989693] ffff800082ada7f8 (sched_energy_mutex){+.+.}-{4:4}, at: reb=
uild_sched_domains_energy+0x30/0x58
> [    0.989705]
>                but task is already holding lock:
> [    0.989706] ffff000088c89bc8 (&policy->rwsem){+.+.}-{4:4}, at: cpufreq=
_online+0x7f8/0xbe0
> [    0.989713]
>                which lock already depends on the new lock.
>
> Fixes: 2a6c72738706 ("cpufreq: Initialize cpufreq-based frequency-invaria=
nce later")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..58e3839a2140 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2953,6 +2953,15 @@ int cpufreq_register_driver(struct cpufreq_driver =
*driver_data)
>                         goto err_null_driver;
>         }
>
> +       /*
> +        * Mark support for the scheduler's frequency invariance engine f=
or
> +        * drivers that implement target(), target_index() or fast_switch=
().
> +        */
> +       if (!cpufreq_driver->setpolicy) {
> +               static_branch_enable_cpuslocked(&cpufreq_freq_invariance)=
;
> +               pr_debug("cpufreq: supports frequency invariance\n");
> +       }
> +
>         ret =3D subsys_interface_register(&cpufreq_interface);
>         if (ret)
>                 goto err_boost_unreg;
> @@ -2974,21 +2983,14 @@ int cpufreq_register_driver(struct cpufreq_driver=
 *driver_data)
>         hp_online =3D ret;
>         ret =3D 0;
>
> -       /*
> -        * Mark support for the scheduler's frequency invariance engine f=
or
> -        * drivers that implement target(), target_index() or fast_switch=
().
> -        */
> -       if (!cpufreq_driver->setpolicy) {
> -               static_branch_enable_cpuslocked(&cpufreq_freq_invariance)=
;
> -               pr_debug("supports frequency invariance");
> -       }
> -
>         pr_debug("driver %s up and running\n", driver_data->name);
>         goto out;
>
>  err_if_unreg:
>         subsys_interface_unregister(&cpufreq_interface);
>  err_boost_unreg:
> +       if (!cpufreq_driver->setpolicy)
> +               static_branch_disable_cpuslocked(&cpufreq_freq_invariance=
);
>         remove_boost_sysfs_file();
>  err_null_driver:
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
> --

Applied as 6.17-rc material, thanks!

