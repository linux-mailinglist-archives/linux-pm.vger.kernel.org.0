Return-Path: <linux-pm+bounces-27013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D56AB283E
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FAF18967A6
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EF256C82;
	Sun, 11 May 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2LGlqVl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F71A23AF;
	Sun, 11 May 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746967450; cv=none; b=P2W/FTJYUJ+1MDBRAilwyVD+TjS8jj2S0HRw9nNJ/4JEoyNlIhoiSmh9J8wDuUqEDkjGdQ1Cwi1LyDYB1T8/Hc/UB6CxHfIw/29QwIGiHn7yG2Fpvx7rkz1fYcJ0jnZ2MGBeSC6uCdzaZK21j6481qkRiV5+AdNDAszXZ2vGnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746967450; c=relaxed/simple;
	bh=ieeeP50KxIRPc6k4myprKZcuCqXDqPKC0i38JgrrD6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERTKyiMwwX3JZqwpFhcC/YWSrIIMeKz29pky3IuFaM4MOcre3jpraWOkdDzoWq8f128n9YZC4aC8G0cIsdArIZjPPkwRhX+BLluW8mKg+8Ud4dB/yEvo1EjB79R1luAwH4dDkZQdsPC50SeNr1iZebJZWLbkZAMk/kw3YeWjmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2LGlqVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB8C4CEF1;
	Sun, 11 May 2025 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746967449;
	bh=ieeeP50KxIRPc6k4myprKZcuCqXDqPKC0i38JgrrD6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M2LGlqVl7zYdQjBZC7IwrFcMobbp8fJ6S0xIRgRXmhYqW3p8JGeg87od7IzU4NY/w
	 CsmfKhub/beA2/BAwXA3okWksn1j/tfKXzP8rpdeUb1Zmd9hJHKdExRATHBqJdJkFA
	 2QO4PgxxZRjGLz2awtJyoIBon3Cuzl8kCFYl3guyoH+QgDTktDjLuKXhe9A+iYC00d
	 HcORdA+KljNoWX19q33/KIlF3loTPnIIiM4vL0lB9MukNXTA1tGIQuFu4IgSrd2DcB
	 imy601hzXembAxJtLTHWpJn/5RTxWuEfepnNoSE62qy4wZ2u2eN1YPRb0NY4qZjlwv
	 uC/PA59+EvrXw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2da3c5729fcso2900942fac.0;
        Sun, 11 May 2025 05:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcAqHgiMufhmYhvVJoO29mupXsgr5S2IEHqvC92unYy17MQnr+hY91uFMUVLKPK0Vs5GCprSqmGh3wIp0=@vger.kernel.org, AJvYcCVhMwO8PUUACI4m28W8J4XBv76s/YWpqzYYJkYNU8lCpLteemqGDWYAuML+5aLpN2WquCUa96mpcFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/871d01uiz9ewCn9HVVy6qEk4H3WIsmIht0Gop1K3Ra6eZyL
	MFUcyrD4JW0I9C9iSMsyW3ahTWAByiRtkv1rh/Cu50yxo+Kp9X49q7o85D13jf5Pa94mj1qUb1H
	POHFWezaYyJN+QLRuzLubqVAjiJw=
X-Google-Smtp-Source: AGHT+IHNn3ZFWIt/tz2S/ZGHzi/yttKIbz/QcYdnxnQzbBXBoArQQyDZniuR+3bZTNKJ6JE3GjjWzDqKet0gs9vQHtY=
X-Received: by 2002:a05:6870:d248:b0:2d4:d9d6:c8d7 with SMTP id
 586e51a60fabf-2dba44fdb59mr5640986fac.31.1746967449171; Sun, 11 May 2025
 05:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208021350.5931-1-pleasurefish@126.com>
In-Reply-To: <20250208021350.5931-1-pleasurefish@126.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 11 May 2025 21:43:32 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2wmoxzM_63baBON+adntMZhR_i4d1DPwBpg7=p+6_Dzg@mail.gmail.com>
X-Gm-Features: AX0GCFsTxbO10H43_MHOZ22yKo2XBPcoTu10_SjSr6z9O41ilzwSdBLIMUul_1Q
Message-ID: <CAGTfZH2wmoxzM_63baBON+adntMZhR_i4d1DPwBpg7=p+6_Dzg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix a typo in trans_stat
To: pleasurefish@126.com
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	ansuelsmth@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Looks good to me for this patch.

But, you need to use your name instead of 'pls' on following
Signed-off-by and author information.
I would like you to update your name on this patch and then better to
add the some patch description

- Signed-off-by: pls <pleasurefish@126.com>

Thanks,

On Sat, Feb 8, 2025 at 11:29=E2=80=AFAM <pleasurefish@126.com> wrote:
>
> From: pls <pleasurefish@126.com>
>
> Fixes: 4920ee6dcfaf ("PM / devfreq: Convert to use sysfs_emit_at() API")
> Signed-off-by: pls <pleasurefish@126.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 98657d3b9435..a0223c60f4eb 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1743,7 +1743,7 @@ static ssize_t trans_stat_show(struct device *dev,
>         for (i =3D 0; i < max_state; i++) {
>                 if (len >=3D PAGE_SIZE - 1)
>                         break;
> -               if (df->freq_table[2] =3D=3D df->previous_freq)
> +               if (df->freq_table[i] =3D=3D df->previous_freq)
>                         len +=3D sysfs_emit_at(buf, len, "*");
>                 else
>                         len +=3D sysfs_emit_at(buf, len, " ");
> --
> 2.39.5
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

