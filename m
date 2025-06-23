Return-Path: <linux-pm+bounces-29365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF671AE48FC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22FD1B61863
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA96279DDF;
	Mon, 23 Jun 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqaEEl5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1726D4E5;
	Mon, 23 Jun 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692936; cv=none; b=kvxKt3W4vBsSIAhJec7UBLcHRAHkuRFJQDBjxa0eswu2OzP679cDUDIuAjgmQcajX3pb9upxFOGViww+GdhTiDIv1gNr8MRuIn9bHoUegAnwCopXZbbtX0OgeHGOD3jp2s7icNZwl4arc7Kx5sd/e6UCbqsBCh4mf+I2aZRjy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692936; c=relaxed/simple;
	bh=myI9JGxkwnLWg5XpI+ttHaw7kFElG+eXHPzNOROEDek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCff5lP2Ggo6jLb4/LEd9izX4wo9Uf2342gtoLGT+e6sXNw7HsXgcn+JaYhzPTNE4pNRlmfSH/+gq9gvC8SLDhF28GbjldXEV3Vi6zJhVTsGeCViKl3YsdXN/nY6FBmVwLOt6YcNfPUj/bDrlEes/KyhqTj0ewMHe8kadZmYU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqaEEl5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1BEC4CEEA;
	Mon, 23 Jun 2025 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692936;
	bh=myI9JGxkwnLWg5XpI+ttHaw7kFElG+eXHPzNOROEDek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BqaEEl5qPjSIXkS+eULS1mwdfWQ9Zg3VOAoQgBbop1curxqErpjaUVlSaXCy/vt7E
	 8VLzM5vkni+Tw80KUE7q7xCN1fhszeGChKBqO/6mi003vRIuQO1QmQamWLSqPKdEA3
	 NJLs4rgBwVQEtMtstWegA6JlwXQV2opp32MKLW+2eoNPr3zR+ldha1dBrrVc0limsP
	 DibnSQH2rx66F3r8FY9/SLriFuPwgwr/fwNyodViQWyOWLmyGdZJo0cmVDcecIxIfA
	 /ZaNNG/CUftl0mv+p8FgBzcpNjT4YG5IM3V3kagO6F8iDaw2OQerN3gkjFKRoQlvxe
	 csU3HlSg9NE1g==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40aa391ce1aso981039b6e.2;
        Mon, 23 Jun 2025 08:35:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVE3/9xq+gA4LyexiRTaAqzI+6uSEnD9mrE3sGzc19lTnc5ApV2dl1feWhL0opaTAVA7kV9SH+l8V8aoec=@vger.kernel.org, AJvYcCXulMb/FquLH276HBaTmfivjUS2kDASM6vn7P5LWcOFBZFLiEvYXmYxb1pAo1eol1+jS57D7zXZJis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4bMwDZEByT8UmlkvtI5+kXuISsZZHhzpEyHjUvAYgd9H6tPe
	DMMpd1EXmm/pAY4BoLGMcGmOqnChZlMBmAoh0fJYLpHAjsD7xLY0lEy96I9QZdsE6hyMSaOerqg
	U1BK3bcAECf9q1uMHsUdC4PvJkQDzUf0=
X-Google-Smtp-Source: AGHT+IGCY55dEZ+EurAs1KUcKmjSaacHpI+q78BU9Xm6LdDSuXAGo6Eiz6Li3+bt+Z0r06nSeI5gpRngwZc+meRehU8=
X-Received: by 2002:a05:6808:1512:b0:407:9d24:af06 with SMTP id
 5614622812f47-40ac6f6db0bmr9972532b6e.33.1750692935330; Mon, 23 Jun 2025
 08:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-6-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-6-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:35:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jz9Bc82AnpcuGLyiu4zC4J6CzHVj7YRmaqhz71S4NEYg@mail.gmail.com>
X-Gm-Features: AX0GCFuE1g6UkSCXAnRPJyJHLehsKyEzNsYzhE62PqAbiAST5usw32-FimrLyBY
Message-ID: <CAJZ5v0jz9Bc82AnpcuGLyiu4zC4J6CzHVj7YRmaqhz71S4NEYg@mail.gmail.com>
Subject: Re: [PATCH 5/7] cpufreq: Move the check of cpufreq_driver->get into cpufreq_verify_current_freq()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Move the check of cpufreq_driver->get into cpufreq_verify_current_freq() =
in
> case of calling it without check.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c4891bf5dc84..9b2578b905a5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1800,6 +1800,9 @@ static unsigned int cpufreq_verify_current_freq(str=
uct cpufreq_policy *policy, b
>  {
>         unsigned int new_freq;
>
> +       if (!cpufreq_driver->get)
> +               return 0;
> +

This will duplicate the check in cpufreq_policy_refresh(), won't it?

>         new_freq =3D cpufreq_driver->get(policy->cpu);
>         if (!new_freq)
>                 return 0;
> @@ -1922,10 +1925,7 @@ unsigned int cpufreq_get(unsigned int cpu)
>
>         guard(cpufreq_policy_read)(policy);
>
> -       if (cpufreq_driver->get)
> -               return __cpufreq_get(policy);
> -
> -       return 0;
> +       return __cpufreq_get(policy);
>  }
>  EXPORT_SYMBOL(cpufreq_get);
>
> @@ -2479,8 +2479,7 @@ int cpufreq_start_governor(struct cpufreq_policy *p=
olicy)
>
>         pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>
> -       if (cpufreq_driver->get)
> -               cpufreq_verify_current_freq(policy, false);
> +       cpufreq_verify_current_freq(policy, false);
>
>         if (policy->governor->start) {
>                 ret =3D policy->governor->start(policy);
> --
> 2.33.0
>

