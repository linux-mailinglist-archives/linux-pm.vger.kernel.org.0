Return-Path: <linux-pm+bounces-36645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C8BFB8BD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D201A05403
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33D30B521;
	Wed, 22 Oct 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvLXCjZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A121328B7B
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131258; cv=none; b=Br5kWsySAbqyX/nvAFHpGHoJ9U068v7AECNDCJCTFm8lbzt9m9nUdOuL05Wjvbp+FBqkE0eZIBABPUd5tWoQ87tE4ofTqALbNXtepMWvMZiXOr3WiRXva/0ywBER244sgT4oKHPqd+nS7y02PjZ1qFo/uu08oD93ms/zFC+9id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131258; c=relaxed/simple;
	bh=NF6e/3SUl/mK178rTaB2eKW0q0VirZfspZzm5JQSfYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVPNMGSm+ghJHaMJXSiDnJOCXfkqylmPLg6Z07JAQPQqITi7dvR3LMy9XANwILMjp2VfxRc6k6c4wvZvakDnkb5i+McRusSSPVvJ4aqqZUOr5/IBrIkKrPIsB/nOq66f8bHMD6o0D1niWJ37mwq8NFK03P/1pveUt34NZhmoNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvLXCjZt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78485808eb3so52112847b3.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131255; x=1761736055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5H2hOYHrC6k0KzLWWZQ6pqjMN1sq2+E7LMIYVsMxic=;
        b=ZvLXCjZtpmQOoxUHrdpzbyT9qlu9PqNgcaMl/88hmEhg6lonFsAe5xUl74Cbt67x8L
         LCgEBLZAhtIQ0MPkhPv41aZaW6ooUyAK48gSv16jJpl6Qw5bfzWkqCSqmGjL7iKQBg/6
         DduUslsFpyQGkzseVEOKZ0ayM3pRfpABf4ZyYVwLAMOxiFatX/RLj75jjdIFgDZfZTyH
         1w+rXTMpFjfu48zxGmpiLlprLGWY7/O3dc+J8ff9VJPLQoHFt4ijOEy5rgez+8WqxacP
         phZqMlB8xuiZ+uysYR8UprE/SXqg3qIImO4ZKZUgvJRIAt3GwTAZDPRTg6yd1LPRlrUc
         87sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131255; x=1761736055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5H2hOYHrC6k0KzLWWZQ6pqjMN1sq2+E7LMIYVsMxic=;
        b=cZeEokXvC0Le5IP1sia18S0LIYRvaQZ66upk66LBirQyo3s2HX9Bq9RfJ4ITtnxIlg
         XUmuH1Xy5arnLuPOOOWwUGd4O721vtfWtLFgIydqpe98NU1E1eJmbGYLfDI27efb5X5H
         7pjnZDGGX4WCFjDaeHs+yXkkLujNT8Dq+MBXMzQOR3pJP43OqRd90rJ5xLQNItxHuP7U
         j/gY3E69I/VH86Z8gQJpORsedzUoyq5GHDlY+4FKchfihFwZ5KwrmuFkSFGbwOw9BmHB
         iCvK7nMsjAKriIASfVkuizCE7gat5KkkKBN7hzx6nAzNwHehaiV/hebjX7o9F5AU9ACx
         cp3w==
X-Forwarded-Encrypted: i=1; AJvYcCXKBx9hefZK/tpFO4Boe1ZEZTag9j7OHwtg2rSsHqLv21y2IPINkzMxrdWZYNGWNAmy03YnjqfRew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpS3VfVmQgJ2G6TWhF5LnOiLAd8fww0D9vstFjwOduA5uf/YYD
	yIqLjTRfM+pKYhM2LLecXxP5RJj6clgc/vkZ0SyTdHyh9CbhUPvx8wjSxFUO+XmFSOVEXHLM4lF
	oSZ4dkloIB7VTZWO01ewusTisWkGaIOc5hn9VTv6GFQ==
X-Gm-Gg: ASbGncux8AZjVyvGMeYLlDszjDe1rWn9iIzcRm4JXK95nAaEk21IMJMtZQmq/qk9HJn
	c+Ery8tkFgcq46DKNkTU0IsK0Tz+lAvm2YcOnCS49w9uorHAgoDGM04Qsx0j+CrshT99ZsUukId
	1AKzJsgcHQ9sZzUh5Ht2BD2POHu8URauCJyRjpBzk8H67mkGk5mmydxki8EiRDHgoDVD5Be9Vdp
	kjYvJ3IkgqvHg6dqh7F/8CVb0PXx9WsBL0iWxcKAtZcW4hl6WzUfzMJHZwhHQGm17vUYhLo
X-Google-Smtp-Source: AGHT+IFJ1vqYp3EqzVjhqjgkltJtdC0F8S0mc4Lwhfr9E90fNJYBhrJvwPxKs+vLQCTJSeMcdqP1qkhWadhCQNPbGBw=
X-Received: by 2002:a53:a0cb:0:b0:63e:e9b:6220 with SMTP id
 956f58d0204a3-63e161d9a5emr12477946d50.47.1761131255117; Wed, 22 Oct 2025
 04:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org> <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-8-7b30797396e7@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 13:06:59 +0200
X-Gm-Features: AS18NWDVrbFCkhc03fhqCT8wIs3nWgG9ruif750F0ANB4USSH-3L9fEAVcRT1Po
Message-ID: <CAPDyKFq2esPos=D-eVz6w1VXq=4LYi6fx54K4TvsUi4JqUJOaQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] pmdomain: samsung: selectively handle enforced sync_state
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Unconditionally calling of_genpd_sync_state() causes issues on
> platforms with child domains as the parent domain will be turned off
> before the child domain was even registered during boot.
>
> This in particular is an issue for the upcoming Google gs101 support -
> all operations on child domains registered after the parent domain
> misbehave.
>
> Add a flag to the probe data to be able to sync_state conditionally
> only, and enable that flag on the two platforms currently supported by
> this driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---
> v2:
> * use bool for need_early_sync_state (Krzysztof)
> ---
>  drivers/pmdomain/samsung/exynos-pm-domains.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 638d286b57f716140b2401092415644a6805870e..15a1582aa92103a07335eb681=
600d9415369fefd 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -20,6 +20,7 @@
>  struct exynos_pm_domain_config {
>         /* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
>         u32 local_pwr_cfg;
> +       bool need_early_sync_state;
>  };
>
>  /*
> @@ -69,10 +70,12 @@ static int exynos_pd_power_off(struct generic_pm_doma=
in *domain)
>
>  static const struct exynos_pm_domain_config exynos4210_cfg =3D {
>         .local_pwr_cfg          =3D 0x7,
> +       .need_early_sync_state  =3D true,
>  };
>
>  static const struct exynos_pm_domain_config exynos5433_cfg =3D {
>         .local_pwr_cfg          =3D 0xf,
> +       .need_early_sync_state  =3D true,
>  };
>
>  static const struct of_device_id exynos_pm_domain_of_match[] =3D {
> @@ -179,7 +182,7 @@ static int exynos_pd_probe(struct platform_device *pd=
ev)
>          * reset during boot. As a temporary hack to manage this, let's e=
nforce
>          * a sync_state.
>          */
> -       if (!ret)
> +       if (pm_domain_cfg->need_early_sync_state && !ret)
>                 of_genpd_sync_state(np);

The call to of_genpd_sync_state() was intended as a temporary solution here=
.

Potentially, if we would be able to distinguish what PM domain that is
causing the problem on the Exynos platforms, we could set
GENPD_FLAG_NO_STAY_ON for that genpd instead.

>
>         pm_runtime_enable(dev);
>
> --
> 2.51.0.788.g6d19910ace-goog
>

The above said, $subject patch is still fine as is for me.

Kind regards
Uffe

