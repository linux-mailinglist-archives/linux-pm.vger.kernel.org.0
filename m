Return-Path: <linux-pm+bounces-33425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE23B3C13E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B44581426
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C32340D80;
	Fri, 29 Aug 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m072KRW0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33B33EB12;
	Fri, 29 Aug 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486377; cv=none; b=DxmVEHd9QpawsOCTNHrMqPvh4kW/Yme7PgHgtxOeyP7K2n+V5feFbWVfVgMR+Y3wpI7OFFZrjb8pCkGKLKTdilXpQtSVLUywK4ieWm+e1Sf+BAWMf8pFYPTHQvZPybBPlWVbpQo0ReFv0lCAbSEOiGEyZ/eJzepNN9MuvxU0HuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486377; c=relaxed/simple;
	bh=uu7yRW77iR6GInnTDZ4J2LNBPTUTsArmEa3vOBJ6JYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mA5aNhiAjxCNQUMA2xaMcezrFIWS62T3QKjqt4/DmWEoJZwzMcufgx+Rcxsi/o8Yy/npKBP1NX5SD1vqBhg1yyB2vD7Eclg6b70wIqSesRnv9u2Gydmc68u2Wl3KkVnpVNKkjFMe8y6sH7z5qcUuLoQn823wsaI0Jk2M94iZRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m072KRW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6593BC4CEF6;
	Fri, 29 Aug 2025 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486376;
	bh=uu7yRW77iR6GInnTDZ4J2LNBPTUTsArmEa3vOBJ6JYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m072KRW0Yk8Csvuo1LOg1WBWq+QqwkvnSTHp6JQ+srzirfg6h/MgDmIQ7QFdxmNzy
	 CuprLUPgATNC83tE0DiMAg79XXte39M+QiR2D0VtMaUjk5iqnUWLM7cFRgzzU8TdhU
	 gU1gFJ/QgHjK58W/LN3kuRtJtZqx00xiTUzu+dNtD+J/YQNy/iAJJ3e8eyGF5tiGCP
	 +FLCZG9oho1S76HRxYOJA0wreELsWNZAgg4CYqJKwqhkLCkSETbVQvMGQfmk6wtorB
	 wZ0fl8gfe1LSvOUQtPICYoiRmE5sg1xRBH/yctDLnIvqnqV6r+vDwOCKpULqfPDh1t
	 VMEk+pFttowvQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61e23ec2538so502040eaf.2;
        Fri, 29 Aug 2025 09:52:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlUC4xjjIW2epkzn1myB/gtU+6aLHj2T8kkef3REwX89IPidBRVKxe0EfBj1pkvX3eicpdZY5P6CcVsu4=@vger.kernel.org, AJvYcCUv7uHE6wEjI+ZYE/oOZ11wjSZi9g139yeh6m6SSbiDuF9ckZ1DMB0paEDlfFw3iASGq/milDy6Emg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrvWwU5d0+1/LijHgkEk55naD/o7l7E4r/0+Uc4D2xu18T6Cm
	x9Xhv/7yrcvPMCnkHD5eKaPTRYeSjT2jhDh2REZS/nzTt3Fvr1wqn3xdutBf0H6R+O9JVDteK1w
	Y0MujMB37cF3GhNzT1nep6ZC5fLLVP2c=
X-Google-Smtp-Source: AGHT+IHC2d66AIGmzUObGmval9MMPo7XP1zYjZkTfQ5f+3RwrbVvozRQOfyyeS23AcO3/h5HK2w16//mTSddYrc6HZ8=
X-Received: by 2002:a05:6820:1606:b0:61e:1d70:766e with SMTP id
 006d021491bc7-61e1d707bf4mr2720834eaf.6.1756486375729; Fri, 29 Aug 2025
 09:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829084440.579727-1-rongqianfeng@vivo.com>
In-Reply-To: <20250829084440.579727-1-rongqianfeng@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 18:52:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZ+4Ze2t8pw1MPUqzFYFr7g7h6Y-f=gwsmUgbvSThYGg@mail.gmail.com>
X-Gm-Features: Ac12FXwIE4z-CuWp-rfigtBSHNKbXG9geMp1m-DzNGIswGhdjpojQUCJ3fqOFHw
Message-ID: <CAJZ5v0jZ+4Ze2t8pw1MPUqzFYFr7g7h6Y-f=gwsmUgbvSThYGg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:44=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Change the 'ret' variable from unsigned int to int to store negative erro=
r
> codes directly or returned by other functions.

You need to say upfront that this is about speedstep_get_freqs() specifical=
ly.

> Change the return type of
> the speedstep_get_freqs() function from unsigned int to int as well.
>
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants.

Which isn't really a technical term.

> Additionally, assigning negative error codes to unsigned type may trigger=
 a GCC warning
> when the -Wsign-conversion flag is enabled.

Is the latter a motivation for this change?

> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/cpufreq.c       |  2 +-
>  drivers/cpufreq/powernow-k7.c   |  2 +-
>  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>  drivers/cpufreq/speedstep-lib.h | 10 +++++-----
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..f47096683abb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_=
policy *policy,
>                                         const char *buf, size_t count)
>  {
>         unsigned int freq =3D 0;
> -       unsigned int ret;
> +       int ret;
>
>         if (!policy->governor || !policy->governor->store_setspeed)
>                 return -EINVAL;
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.=
c
> index 31039330a3ba..88616cd14353 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,7 @@ static int powernow_decode_bios(int maxfid, int start=
vid)
>         unsigned int i, j;
>         unsigned char *p;
>         unsigned int etuple;
> -       unsigned int ret;
> +       int ret;
>
>         etuple =3D cpuid_eax(0x80000001);
>
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-=
lib.c
> index 0b66df4ed513..f8b42e981635 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -378,16 +378,16 @@ EXPORT_SYMBOL_GPL(speedstep_detect_processor);
>   *                     DETECT SPEEDSTEP SPEEDS                       *
>   *********************************************************************/
>
> -unsigned int speedstep_get_freqs(enum speedstep_processor processor,
> -                                 unsigned int *low_speed,
> -                                 unsigned int *high_speed,
> -                                 unsigned int *transition_latency,
> -                                 void (*set_state) (unsigned int state))
> +int speedstep_get_freqs(enum speedstep_processor processor,
> +                       unsigned int *low_speed,
> +                       unsigned int *high_speed,
> +                       unsigned int *transition_latency,
> +                       void (*set_state)(unsigned int state))
>  {
>         unsigned int prev_speed;
> -       unsigned int ret =3D 0;
>         unsigned long flags;
>         ktime_t tv1, tv2;
> +       int ret =3D 0;
>
>         if ((!processor) || (!low_speed) || (!high_speed) || (!set_state)=
)
>                 return -EINVAL;
> diff --git a/drivers/cpufreq/speedstep-lib.h b/drivers/cpufreq/speedstep-=
lib.h
> index dc762ea786be..48329647d4c4 100644
> --- a/drivers/cpufreq/speedstep-lib.h
> +++ b/drivers/cpufreq/speedstep-lib.h
> @@ -41,8 +41,8 @@ extern unsigned int speedstep_get_frequency(enum speeds=
tep_processor processor);
>   * SPEEDSTEP_LOW; the second argument is zero so that no
>   * cpufreq_notify_transition calls are initiated.
>   */
> -extern unsigned int speedstep_get_freqs(enum speedstep_processor process=
or,
> -       unsigned int *low_speed,
> -       unsigned int *high_speed,
> -       unsigned int *transition_latency,
> -       void (*set_state) (unsigned int state));
> +extern int speedstep_get_freqs(enum speedstep_processor processor,
> +                              unsigned int *low_speed,
> +                              unsigned int *high_speed,
> +                              unsigned int *transition_latency,
> +                              void (*set_state)(unsigned int state));
> --

