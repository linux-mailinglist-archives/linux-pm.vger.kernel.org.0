Return-Path: <linux-pm+bounces-25551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCDEA8B94E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379E87A5459
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92A8F6E;
	Wed, 16 Apr 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxpyoaPp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1A1EA73;
	Wed, 16 Apr 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807107; cv=none; b=PXCLZpyEVENNNzUSAczgZ8lEgpmnP4wucMgUoyVDhgZhHht7VvDhQMRQrM36HJ3mDAecT8vjh0BjFwOsATSi2FdByFLYj25WusypoSUXMt0iza5XoOcVsTTZjVvYLxplAdR2dudkBkYc3SmtzyoQQyX3DPczjuc4aAL/VQYHTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807107; c=relaxed/simple;
	bh=e2jsaT9Hpx0nLzusrdALRb7qSNpHZu74C3f13s3ykLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY8LLCRPbi40Fa3unDk76TSyrAd/YdUWNIMhDP+YN3zh43y7qCwjT6pv4YkhgEJyXcFuu8o0PDmIK7OYGAcW1hY7eHxxmVaf9wC8mv9CIW9mF8+1DESziBAl8ZR/7kvOTJeOAc7yUAGwTaBCrBL/2V6lU0WIs7F5P917JMfOiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxpyoaPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6582C4CEEF;
	Wed, 16 Apr 2025 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744807106;
	bh=e2jsaT9Hpx0nLzusrdALRb7qSNpHZu74C3f13s3ykLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cxpyoaPpswv+BBYg3BTNt4paSHZdX/y6zXjZtyIGBur8/Ypkomz0LvFQbDFxhLSSE
	 qe4SxOaphJ0zJNN87RO/mXhokTfwADcE4CccP55ug5fDKUnx6tER5rZ9A4oAsiaBtP
	 jvuPQAIGir1UuGyBa0JVFzP3+GRnTHbhtOF++yRHJ05pgwU8NaKd9PCqDMwXLn62wO
	 RH4f972Bbz5adjFVCzyHQhLYGBplvu3vq8MK337ly7DnNMR/34sWVUl/RRp2ZS0aR2
	 6OQJIrllBts1j+pxJ0hk6II1CZ2AnzXpHxNJ9Ct9lOxfcQRk8Bn4fV5R9ooCFd2gKU
	 mGzDk4HIepQNA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601b1132110so3562379eaf.3;
        Wed, 16 Apr 2025 05:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7GZhYU40VYOnEUxy63vpaXFmpB8CPegB0hsDahTtnSflW5zQu8H5oOe+YJz31Jbcvp734S615Vu8us4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FhHVl7yNg3FTQYt9PotXEUo9juirMYy3AiyQQzsCCm441O1J
	u1IAO0R9E56HQDyX89xril3hn1LUqBZl01koEmzL+oyAoAOklfdyRVHHKmyP0T8sj8OyiCb/jTb
	Oovw1oSvh+paOwknSqZIOi0hkj6g=
X-Google-Smtp-Source: AGHT+IETwOeJKz8MffKyQGEt2IOXMo8vtNSMoKWv3rj/PSxaMq7FzWI9nfEI/3xMAt9AmXnXzn5/bmwZx/ENmiFpgEw=
X-Received: by 2002:a05:6870:469f:b0:2c8:34df:8c4f with SMTP id
 586e51a60fabf-2d4d2d58f1dmr851905fac.37.1744807106079; Wed, 16 Apr 2025
 05:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <87665307-1be3-465b-ab7c-3bf908b45217@huawei.com>
In-Reply-To: <87665307-1be3-465b-ab7c-3bf908b45217@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 14:38:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g2+Eu9Nv0gha-806_wOiPQCrtLJikNmMoCo48tt4QvsQ@mail.gmail.com>
X-Gm-Features: ATxdqUHkPG7KKcYS4BVGlyiYX4Y-Ib4zlyoNnChSd6W3xOgeASruxAbVaS7enXo
Message-ID: <CAJZ5v0g2+Eu9Nv0gha-806_wOiPQCrtLJikNmMoCo48tt4QvsQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Nicholas Chin <nic.c3.14@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:47=E2=80=AFAM zhenglifeng (A)
<zhenglifeng1@huawei.com> wrote:
>
> On 2025/4/16 13:29, Viresh Kumar wrote:
>
> > The boost-related code in cpufreq has undergone several changes over th=
e
> > years, but this particular piece remained unchanged and is now outdated=
.
> >
> > The cpufreq core currently manages boost settings during initialization=
,
> > and only when necessary. As such, there's no longer a need to enable
> > boost explicitly when entering system suspend.
> >
> > Previously, this wasn=E2=80=99t causing issues because boost settings w=
ere
> > force-updated during policy initialization. However, commit 2b16c631832=
d
> > ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()") changed
> > that behavior=E2=80=94correctly=E2=80=94by avoiding unnecessary updates=
.
> >
> > As a result of this change, if boost was disabled prior to suspend, it
> > remains disabled on resume=E2=80=94as expected. But due to the current =
code
> > forcibly enabling boost at suspend time, the system ends up with boost
> > frequencies enabled after resume, even if the global boost flag was
> > disabled. This contradicts the intended behavior.
> >
> > Fix this by not enabling boost on policy exit.
> >
> > Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_c=
pu_init()")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> > Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
> >  1 file changed, 3 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpuf=
req.c
> > index 924314cdeebc..85b5a88f723f 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
> >       return false;
> >  }
> >
> > -static int boost_set_msr(bool enable)
> > +static void boost_set_msr_each(void *p_en)
> >  {
> > +     bool enable =3D (bool) p_en;
> >       u32 msr_addr;
> >       u64 msr_mask, val;
> >
> > @@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
> >               msr_mask =3D MSR_K7_HWCR_CPB_DIS;
> >               break;
> >       default:
> > -             return -EINVAL;
> > +             return;
> >       }
> >
> >       rdmsrl(msr_addr, val);
> > @@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
> >               val |=3D msr_mask;
> >
> >       wrmsrl(msr_addr, val);
> > -     return 0;
> > -}
> > -
> > -static void boost_set_msr_each(void *p_en)
> > -{
> > -     bool enable =3D (bool) p_en;
> > -
> > -     boost_set_msr(enable);
> >  }
> >
> >  static int set_boost(struct cpufreq_policy *policy, int val)
> > @@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
> >       free_percpu(acpi_perf_data);
> >  }
> >
> > -static int cpufreq_boost_down_prep(unsigned int cpu)
> > -{
> > -     /*
> > -      * Clear the boost-disable bit on the CPU_DOWN path so that
> > -      * this cpu cannot block the remaining ones from boosting.
> > -      */
> > -     return boost_set_msr(1);
> > -}
> > -
> >  /*
> >   * acpi_cpufreq_early_init - initialize ACPI P-States library
> >   *
> > @@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_po=
licy *policy)
> >
> >       pr_debug("%s\n", __func__);
> >
> > -     cpufreq_boost_down_prep(policy->cpu);
> >       policy->fast_switch_possible =3D false;
> >       policy->driver_data =3D NULL;
> >       acpi_processor_unregister_performance(data->acpi_perf_cpu);
>
> Nice!
>
> I wonder why this cpufreq_boost_down_prep() was needed at the beginning.
>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Applied as 6.15-rc material, thanks!

