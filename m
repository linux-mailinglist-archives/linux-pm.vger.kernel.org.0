Return-Path: <linux-pm+bounces-28963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8FADED1D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A61716C2C8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9D28640B;
	Wed, 18 Jun 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7H9MyIT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818C2E8DE0
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251435; cv=none; b=MqLHnFxctWEbj2IKUQ0UJO3IB5LOiGnAWogW6Iq14M/s0+wXit8wJojEU8vMWKtoenO7KMoih7rY3xzuZDe9u8pTzpVo0B9afeJ8s6jsItWzUwCiYIEYX851yM43ci7isiI7uxGnEuMNu151WSQIUafJu3QcVhrWGIT46OxPQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251435; c=relaxed/simple;
	bh=3FYqq38fif/LxKqKHUHq3crgrlGF8y09qgJq5ooSqws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddxyT4ElYzpGUJpxCEjAX/ibUTZ1LaBau6sBeb4GOx2SeymZq/55loxynjfPQ/dHV/ZMQGGRDL18rRLY97hukPr5kWQFF1oDGwy59tUv34YONcUqeXLeNul4/9P1SF0vISf7O6ssGTlUDQEin4p0plyi4PAG97tfX2FXxwK0yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7H9MyIT; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e81f8679957so6165613276.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750251431; x=1750856231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImV2tWTmsy2q/yEr+1DaD06Foo/cyEMhoVGfzs5E01c=;
        b=b7H9MyITUwy7yCriEiLoOO2l5RI7y6VMfnXqPYBZAxRaJfkOCg2GY//y9VFsQB0V6O
         0vPcYb5Jy3ALKPNu9iPhZMPrv601Hd0//ZVH/TkU4GKxhPymQyTOFLagRCw1w6XlWSop
         Y0S8b3dtAo9uMx9P4mn/uMWWNrF+/7CCocwr/UOY8ozpqBwnDusriN/rZIexYv8bZtWF
         /kKRk3kcxJq9rkaiV/9s6W2ZyIxDeU3vjSk2H0L78iJnjDIXplks6z5ISWxqsW+IevC0
         qTaE6AdQGpPMVxVmumNTkz3DBjPdV4XZaQWbyhDT62+zUdceA4MiTgcxaHWjUbTvpSpg
         sq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251431; x=1750856231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImV2tWTmsy2q/yEr+1DaD06Foo/cyEMhoVGfzs5E01c=;
        b=b6iEWMDxa47Ys2ba8oQncquOOdtbwMRANUmqO6CIYUhLVZFdnXjYk3VrWJoVmw3XpZ
         GSyPp+RUCk67wbIZCEkgpXT/W+Q6F1j90FFz5tIegA2kNs3vF/Wh+0Cz9HjgsoMN9qzR
         ppRcurLjrN2OxyrDvJDsyEVafoSU8QpcUc2uqEyLD+7AtGwtUntX3kjBl5PhmEESkQFX
         7HNV1pGgZ1WutPeaDUZRRRWj1XshLfqPTrylcBsiYMdADtP+430gBB7zma+wWSJuG0B4
         yZhoUP8B1jm8qFXOPRhG5jKi1gcy+B3l2Ppiu2P9g1f9EsuqFtHobcWAj4Tt0K86OL20
         0ZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2W8adW6ay/2ttnN8KDVOZTYJ9eSeIy7oZIw0l1QroI7MwPa9lEfcSjY1ORwlJhpuL31PSyqnUqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdTrrkrRwQSmVLeAxEwykA9WqOpkxXrrjKiFjJPHIwq/bXTDK
	zSNQXd5GIaTfjKAyhBiREyIKwrCqYxETgzEJfroMCnrB78ynNHKueSfC3bhMsHlOxMdHsbK7hQh
	OGYXZnKO0rqua9gm5Z3FLw3fj8ZPLC1A7MbzthjFkdw==
X-Gm-Gg: ASbGnct0ulLU41IfJ6hnVwFXpsAM36fH795ooaf9gMpuwTJk4k7jEMHsvxGxhYboV8p
	TMeSaNRuRhK0wCFG9o86EwtnSMDEdo9ChEcb395TEAOnIZZsGaJo7PJfaLNyAqTHHhPgF06hMnn
	efYRJca4BcCecKDBcN7+RbNOgu7edQ4C99WmKJBzmnvRELIcWJRu1vUw==
X-Google-Smtp-Source: AGHT+IEyQuheTBiE1KNn6YZq2gnYBnep5nmoSzdbAY5+FjuWnU41fcajc0wk6HzHKqHouIVNOHfqKE34E1wAn8AbOSo=
X-Received: by 2002:a05:6902:108e:b0:e75:c2d7:53d6 with SMTP id
 3f1490d57ef6-e822ac5c6e6mr24203748276.13.1750251431566; Wed, 18 Jun 2025
 05:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Jun 2025 14:56:34 +0200
X-Gm-Features: AX0GCFtmn4waDQnDGcBuyuBWKSA5kWVg6aNQw87L31M-o6t6ciEMxOkcF-FE8sw
Message-ID: <CAPDyKFoPdqfz-3+XAMpg23VzaLUZ6xXJvmknQH7pjNZLPq6eAg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: remove code clutter
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 11:08, Lukas Bulwahn <lbulwahn@redhat.com> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> There is no need to introduce the boolean power_on to select the constant
> value for state. Simply pass the value for state as argument. Just remove
> this code clutter.
>
> No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 2a213c218126..8fe1c0a501c9 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -22,27 +22,21 @@ struct scmi_pm_domain {
>
>  #define to_scmi_pd(gpd) container_of(gpd, struct scmi_pm_domain, genpd)
>
> -static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
> +static int scmi_pd_power(struct generic_pm_domain *domain, u32 state)
>  {
> -       u32 state;
>         struct scmi_pm_domain *pd = to_scmi_pd(domain);
>
> -       if (power_on)
> -               state = SCMI_POWER_STATE_GENERIC_ON;
> -       else
> -               state = SCMI_POWER_STATE_GENERIC_OFF;
> -
>         return power_ops->state_set(pd->ph, pd->domain, state);
>  }
>
>  static int scmi_pd_power_on(struct generic_pm_domain *domain)
>  {
> -       return scmi_pd_power(domain, true);
> +       return scmi_pd_power(domain, SCMI_POWER_STATE_GENERIC_ON);
>  }
>
>  static int scmi_pd_power_off(struct generic_pm_domain *domain)
>  {
> -       return scmi_pd_power(domain, false);
> +       return scmi_pd_power(domain, SCMI_POWER_STATE_GENERIC_OFF);
>  }
>
>  static int scmi_pm_domain_probe(struct scmi_device *sdev)
> --
> 2.49.0
>

