Return-Path: <linux-pm+bounces-25013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC2A82564
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603883B8900
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD2264FBF;
	Wed,  9 Apr 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy/e8tBw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F23261591;
	Wed,  9 Apr 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203142; cv=none; b=l44z33nUx2vnbKE7E5pUrH/SNrQjiMG/u6+wJ8/D2XyO/n9830sfsDrZYy9Kag6wOc96ho6o7u7XQH/iN0MwX5oUakVuzpzaKmlDHU82W547PB0MFLEOZakBeMFKegG/JpAZGb2aUeZzhJc0y1AebWRljpwGO5PNAKjQOcMdgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203142; c=relaxed/simple;
	bh=9j3BQXuTcVLq021FDJpbkiN8Ic00H5PJHGa7XG4Be3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPa06Xfbm0PVUviEnam/Iq/BCOFBp+hdTw1+/co0yMeYreIjQmrSK0t22gAT6dyCqmkHl2PEAK0HqBkE5A3qM+chHE2GRB/lCdNCLiKMWu5SaIDNtnAZKoUbQ/+SdkrYoVuFLi7OvSLqpN7xm3QU6DFWMbqCO5CPRI+kpL7/BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy/e8tBw; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso59253571fa.2;
        Wed, 09 Apr 2025 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203139; x=1744807939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnbe48AO71vHxLIqa6wKoIQjII3SgOedEce7jQxnB1c=;
        b=fy/e8tBwN5lipwDSirRS7p3toisWDrWdarqxBsBijOL9xLOyYUJWLpY+wz0ISuLdJp
         ygmudUVUv/qY5wGxoDTK6qEQdSl6HA4iQTFuF3ECLGWzLAsEfTHFubEQKDgcu1HW2z0P
         qKv/6hlKolu42y6MHZ0er9TJZSpnVwewZ+fNqCxffI666Oy16dsMF5IINUYKUCDBJtf3
         i10ljPb5GJ8vLjrmWStFzQ4tYwxtfKVMVfSQ8Gy2wwCESjqWiM3dqVAz7lLCif9S1pOR
         rm7nwd8qxShsEcIFfcn9eMALrhuiMavAa412k0t+4ULF1G6/GlemLk8M3hnLUDnlBWn+
         9o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203139; x=1744807939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnbe48AO71vHxLIqa6wKoIQjII3SgOedEce7jQxnB1c=;
        b=CgLZQ0SsDgOs3VlXARRCqvNXCPBt/0g7I7tn1QgsKBEinwyVP/MRn+TkGxcyBxyBsI
         FuuMytKWCthoRXlgq53fmxMoVR2taOeVWvICI79IEnRlEYrm3GN7oMMfHJZ1/EdXkh2P
         JMdOb6CKYBlvS7RcL1cG9RzDXoWceymia9t8XphdXHXrAynsdLkf7tCYwmYMXZ0DSt1f
         lHf9dPSS9yx9cONxuQ2S+ojgO9ktOmtP5zFR7eNUDGsap3YhzExV0kKk2EH6I/hpc9mf
         8nFN6jHMqbye0673bIevvjMXO1h9Bh5Kdkc07Q/Us8Zx9l5y8JmI5l/X0FiNtti/4tRC
         kBdg==
X-Forwarded-Encrypted: i=1; AJvYcCUsuqS0/6PihxJLrBYj1Pvnqu4SfMwh5jLUVty7lTFHNN91lQAGBJUxt0L/hdxoz7c/1KLngu0hGjM=@vger.kernel.org, AJvYcCXnldRQwZCu+0p5Stztpk1i/4WmwNZyEMLMcMgiOZnh/OKTXZe2YFp6uhwpPkqN4JjWurhulDPOhdrEA0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kzgiGU8u0qAVtwLpgLNoeABLcCRXJde6KDqn7saX+m/p1YGu
	yCOMOkx8o6tFOMJC+13F4XGhQDcDyM+WVDeEpobzDETwkQMgIaLF2C/BoshsAtluyIfLeUjyl78
	5HDXKIi5IqnwK3QN18bWWKp4oEpY=
X-Gm-Gg: ASbGncs4wEIZhHzhU6i+q4nVQK6/64KQcXQ25KnaBTZPPenaolXwxjviodvSXr3u15U
	DhNZ56t88V1fNWiZGlROMJD8i8z0YAG/xsvOSJCG7uYTSNgjskTVsaJcJgCNixiJrx53TR5u59M
	Zi5j1boB5QP8Z1eNsLL83Prg==
X-Google-Smtp-Source: AGHT+IGdHNOtvdCerY9pg8Q3eWXZ6Xsli0U3CirBEEFOA4oaaLZ/9WuOnbKqs9UCWS6SuAwXiGwGa9XbIxRoeJv+6i8=
X-Received: by 2002:a05:651c:54f:b0:30d:e104:a942 with SMTP id
 38308e7fff4ca-30f45078046mr7055251fa.38.1744203138983; Wed, 09 Apr 2025
 05:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409124542.47166-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20250409124542.47166-1-bsdhenrymartin@gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 9 Apr 2025 20:52:08 +0800
X-Gm-Features: ATxdqUHAqov07ZrNPtI7qo4io2YYdsdoXQrB8Z46RMN6AaIBAh08vSDcMkMStwY
Message-ID: <CAEnQdOoMBvm_T813t_1uuNsQxqro=zXwM6d2b=NOiihicUNHcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
To: sven@svenpeter.dev, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev, 
	rafael@kernel.org, viresh.kumar@linaro.org
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise - please disregard this patch as it was sent in error.

Henry Martin <bsdhenrymartin@gmail.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 20:45=E5=86=99=E9=81=93=EF=BC=9A
>
> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. scpi_cpufreq_get_rate() does not check for
> this case, which results in a NULL pointer dereference.
>
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`
>
>  drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufre=
q.c
> index 17cda84f00df..dcbb0ae7dd47 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
>
>  static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  {
> -       struct cpufreq_policy *policy =3D cpufreq_cpu_get_raw(cpu);
> -       struct scpi_data *priv =3D policy->driver_data;
> -       unsigned long rate =3D clk_get_rate(priv->clk);
> +       struct cpufreq_policy *policy;
> +       struct scpi_data *priv;
> +       unsigned long rate;
> +
> +       policy =3D cpufreq_cpu_get_raw(cpu);
> +       if (unlikely(!policy))
> +               return 0;
> +
> +       priv =3D policy->driver_data;
> +       rate =3D clk_get_rate(priv->clk);
>
>         return rate / 1000;
>  }
> --
> 2.34.1
>

