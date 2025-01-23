Return-Path: <linux-pm+bounces-20891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36964A1AAA5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A72618880D1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5618872D;
	Thu, 23 Jan 2025 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqFILXrf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0E155A59;
	Thu, 23 Jan 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661740; cv=none; b=SansJhcMB0XSB/+bhwP+3edo9ptlZhnp7kooPQ8SwbJjAIXp8zVI95c86bYumt1uMvsj4J0bb1ksjWdCMAC0T+kiY6k1OJ8CYPvOhZ3ZezjCKdr1o41wk0drvg8kzQMBVPH5tooD6r95/4wdgjQRhMl35Mztp1mLQxcp06gltHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661740; c=relaxed/simple;
	bh=b4vDZnBnRJMAExr0E30kjS5qChTkUb0rbppiv1HRSJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPFlGJ9k2mV7QQrpEAaXUv/v7v40HWfOHX9RYbaZGE6v2agncjD/rbD7wI0DTD0mS14jzT6OgVbkUqv/W0f1tt76za+l8RU37Fm/Dm0bBVNF7pKO4uH/JC5UEe0Ol+9n/527LAk+/jhtieh/HjwXh2gfzkj1D+DGovXLOKcnmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqFILXrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D9FC4CEDF;
	Thu, 23 Jan 2025 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661739;
	bh=b4vDZnBnRJMAExr0E30kjS5qChTkUb0rbppiv1HRSJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EqFILXrfuR2ZIidhuGa5elmndxPWGARZ4+4SUQ2LogGGqSbmkEFngJj3ERNUU5Axy
	 YYUlQPgrWtS8Bo+FycDGiEFlKSSOw1QJSLV1SkcYzR3JUh5wJOsWKDKhy+f9dHUYrm
	 7pLUtWpNp2N+2Y0sK8B4CyIWN9Oj9mVmr/pc6wO0nOggRziN+6xsno0t+ylDSmez+f
	 hHOhgGyHUHGaLZIo95ILsDiPy3DdHTK6ShflF5RwVdt51e0wRjNvkhkge2MoFni6GY
	 d+OtMIPxV+S9hN6vnPi6I9YS/z47Wg42UQk9TAYDVlKrPFiHJYy97CE2ilrI6E2Cfo
	 Fe1T5Gag59atw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb7edfa42dso706342b6e.2;
        Thu, 23 Jan 2025 11:48:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGJh1b0eXI23JaXiiLByoLQ6wo7CgPw+QgQ7PtQf3pyS3cbWsZaIpbh963m3SK3p42XLf2vBgnPmw=@vger.kernel.org, AJvYcCUg0I2jWu0jGyD7ijwIvrO4uqHdhclgxuV3+fPwUQLqKZVVWnc2UXJKHomE+P2fGCx3QdzHkNxrP6NAGVo=@vger.kernel.org, AJvYcCVdYJ5oGQzZqQCvm26KPp0BJpBeFA7V/N9Z/5N6mvOfXaA4tVH+ykxPAC9hr1+qYeXhDmb/H7al@vger.kernel.org, AJvYcCWFkkKFstd5AHcqiQaXLlYTpzmJEksdyAkpCI1tESn4DI1ZGJvPW9uUW4vj9XBYRa9WI3zd1yxXHQb4pRqqTAIcY/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA74q8x7Ooi4b3gOe4eMTcOdcKb4dSqEsY6+M62fPYIE4UkNNL
	2RuthEveBhzytxNw4IamC22R5ndND+xYUDmY46FUFEL8WOjPD6GZ5DZCBYt1zwrDBl1Aa8bs63X
	K/9oX2Y1E6jLF1+VsSvUwkD4RB3g=
X-Google-Smtp-Source: AGHT+IEn7eMjaHs+zmgjFd4WWVQahCuGuBBNarJzdEYSnQbw32rD83EbOPgQ6J9LSZlnM3ccjdpcf7atXcTLmBuPCOI=
X-Received: by 2002:a05:6808:4c88:b0:3ea:f791:3caf with SMTP id
 5614622812f47-3f19fc2ac4fmr14986057b6e.17.1737661739096; Thu, 23 Jan 2025
 11:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <236b227e929e5adc04d1e9e7af6845a46c8e9432.1737525916.git.viresh.kumar@linaro.org>
In-Reply-To: <236b227e929e5adc04d1e9e7af6845a46c8e9432.1737525916.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:48:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gz2WLtwJca5oAgZ23C+UmX18k9fvCbzRAEV6zZL4jiiQ@mail.gmail.com>
X-Gm-Features: AWEUYZkHJTFNwFesQmZCHaWO-zzZKYYgHYBBgsz-SFLTIOGI_LaSzdS3jIxf3XU
Message-ID: <CAJZ5v0gz2WLtwJca5oAgZ23C+UmX18k9fvCbzRAEV6zZL4jiiQ@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: s3c64xx: Fix compilation warning
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 7:06=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The driver generates following warning when regulator support isn't
> enabled in the kernel. Fix it.
>
>    drivers/cpufreq/s3c64xx-cpufreq.c: In function 's3c64xx_cpufreq_set_ta=
rget':
> >> drivers/cpufreq/s3c64xx-cpufreq.c:55:22: warning: variable 'old_freq' =
set but not used [-Wunused-but-set-variable]
>       55 |         unsigned int old_freq, new_freq;
>          |                      ^~~~~~~~
> >> drivers/cpufreq/s3c64xx-cpufreq.c:54:30: warning: variable 'dvfs' set =
but not used [-Wunused-but-set-variable]
>       54 |         struct s3c64xx_dvfs *dvfs;
>          |                              ^~~~
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501191803.CtfT7b2o-lkp@i=
ntel.com/
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Move s3c64xx_dvfs_table too inside ifdef.

Applied as 6.14-rc material.

If you'd rather apply it yourself, please let me know and I'll drop it.

Thanks!

>  drivers/cpufreq/s3c64xx-cpufreq.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-=
cpufreq.c
> index c6bdfc308e99..9cef71528076 100644
> --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> @@ -24,6 +24,7 @@ struct s3c64xx_dvfs {
>         unsigned int vddarm_max;
>  };
>
> +#ifdef CONFIG_REGULATOR
>  static struct s3c64xx_dvfs s3c64xx_dvfs_table[] =3D {
>         [0] =3D { 1000000, 1150000 },
>         [1] =3D { 1050000, 1150000 },
> @@ -31,6 +32,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] =3D {
>         [3] =3D { 1200000, 1350000 },
>         [4] =3D { 1300000, 1350000 },
>  };
> +#endif
>
>  static struct cpufreq_frequency_table s3c64xx_freq_table[] =3D {
>         { 0, 0,  66000 },
> @@ -51,15 +53,16 @@ static struct cpufreq_frequency_table s3c64xx_freq_ta=
ble[] =3D {
>  static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
>                                       unsigned int index)
>  {
> -       struct s3c64xx_dvfs *dvfs;
> -       unsigned int old_freq, new_freq;
> +       unsigned int new_freq =3D s3c64xx_freq_table[index].frequency;
>         int ret;
>
> +#ifdef CONFIG_REGULATOR
> +       struct s3c64xx_dvfs *dvfs;
> +       unsigned int old_freq;
> +
>         old_freq =3D clk_get_rate(policy->clk) / 1000;
> -       new_freq =3D s3c64xx_freq_table[index].frequency;
>         dvfs =3D &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_dat=
a];
>
> -#ifdef CONFIG_REGULATOR
>         if (vddarm && new_freq > old_freq) {
>                 ret =3D regulator_set_voltage(vddarm,
>                                             dvfs->vddarm_min,
> --
> 2.31.1.272.g89b43f80a514
>
>

