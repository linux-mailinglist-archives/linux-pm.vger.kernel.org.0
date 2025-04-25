Return-Path: <linux-pm+bounces-26186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA7A9C543
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812B31BC2048
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257E23A995;
	Fri, 25 Apr 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYQ2pLQw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24A239585
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576480; cv=none; b=Ub25XpVVaQlIKAqWq83yDo12KMiWcthjNO6iadZy2vB29BGAdyYgm0XRKa0oI4T5hxsZ/Cw0iZoYKj+5hD16quT3pu78PWemXaWCwS162C7oGprG8UTDaw2JVSvfCJjYA7hby567tPlSqphnizKTRPHPy3ax5kN1hUM+70nOIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576480; c=relaxed/simple;
	bh=bea2MAWR2xePWrRZDSwx6U/cct68IawnA8pK7VpVqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOEgYfjQnYDf/txj53MV9RZP9mQ0GG+fZ0cHtoeqbGIFeCLnsO8T6rsx+Y20X8lKuxeU8z8QzYzUAz+dsit01bduO7sKjXZZYvej198a5eKZRgEwg4EOCBZImlzhlotTjf07UBbDHXgmTtGZICPFInbxcwl3lSAcD63iQMLF2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYQ2pLQw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e72bb146baeso1833034276.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745576476; x=1746181276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xtlWzmg2HNhGfo1n6j6VZxV97pQa994I7X0fglbPbg=;
        b=pYQ2pLQw7RRly8kASM2fnwPGu5txqC0V03JcFX+3sAdpNhASp1KUas1PdBoQkhV1Xp
         qUfvvfwyLbe/Yo71EZ46W6jntyzwIjKqwwOD2BaTYqRU1j7gv/uEy0BMDIWTT+y6Ltgq
         8E6bWn94SKa3MgIdSyfOpzt3PlSnLWeyeKtix/VoOpZNofc9j/3bZacJXYEQcCUg/YAD
         5OeImXyixZv2KQBruhIP7k9RHvXoBSOQYPoQgVGqxflI5J4vmT535yq1++ypzpBiTn0e
         wBa3h4uFoS2ESq6g8eCL0uEwiT3Wbji1DjN3DxvTmourvcfWEE+tj2gSiqnNk+Os4gd+
         ko9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745576476; x=1746181276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xtlWzmg2HNhGfo1n6j6VZxV97pQa994I7X0fglbPbg=;
        b=pF6KHZRU8eCu17rOnaZeryGGaWol0UVyDi6pDpAJ80oQfjFWwWllLMEAlxahGCGuv0
         JCmU1mYrf7tbcxmE0SWQWXej9DXLXvSKQLKo0evPD6w3QvdVivYQWT3d+WxX86IJmMqt
         ujhXePJ9/VvnnWJPU0dY26vfTfC2yQX9oUJWDaMrtL8q9j5aBCMD64lwJpVO0NSzSDh4
         EFLkgdvHkKWZk1Q+zC9gldJN4aSee5u8ZJ44gxYrx60H/zwvORlB+hxSFo2ciFvvBQr8
         zRd8VhzmZKqwg5YoOcdgxmPOdyJdvqVRgIai/lUM1yOXaZJ9XKI6CJ7znpeaSCBD9aGS
         r1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Iap6hVqty1oj7hnp7tv3owCs3zjHgqqssrMM1x8STC4RJ0arhoQXrNwaNfNBthuD4irf8YNeuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rf8cgUU4/4tpkCOHNm7rxoXSWBKxrIgIgL/7SPeCSMjMR0D2
	lAUyutHRB27v/cAvVHO8MjwOF1Qu7lTYqbJAzic08gWE7Q6P7MH61k8JBgJ8lmOI4DjFDar3zde
	QX50FZfyJOqIeXEynOD+bLxK2/quEgaVPRICzaQ==
X-Gm-Gg: ASbGncstcK5uulHsCjkJfXbpunpKjYivGi5R71r4ik/8/abMjlYUlBRmcCeRaV0yj2L
	olnxcsHwoSbYPqz8zWpe+BfiKSh/O002ZnwPghd6nfz1s5oMYddwRgceDn7vgjQY82yuXlA4kZ3
	6G9QgsBuhWxOOiN1df2xVN2aw=
X-Google-Smtp-Source: AGHT+IFwzWvVcQW2OIuOPuNm7S3wzxb/4DZpY2/AfSEZfPmecvdAWyRMS5KH+2afz+oKQvj6DmCUtklI/lnuHoLlgh8=
X-Received: by 2002:a05:6902:2411:b0:e6d:e8d4:681f with SMTP id
 3f1490d57ef6-e73168936fdmr2304939276.35.1745576476343; Fri, 25 Apr 2025
 03:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417074645.81480-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250417074645.81480-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Apr 2025 12:20:40 +0200
X-Gm-Features: ATxdqUFX3-aj6uGzZ6MjZfzJuyAtiwi1E0if2kOJDDTWutgbL5RxXK5HHoQxSiU
Message-ID: <CAPDyKFpTKxA1fvppkADP=XVbU5YroczNMfYtjELK_TyGR54f2A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Do not enable by default during compile testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 09:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> For longer rationale:
> https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
> ---
>  drivers/pmdomain/arm/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/arm/Kconfig b/drivers/pmdomain/arm/Kconfig
> index efa139c34e08..afed10d382ad 100644
> --- a/drivers/pmdomain/arm/Kconfig
> +++ b/drivers/pmdomain/arm/Kconfig
> @@ -2,7 +2,7 @@
>  config ARM_SCMI_PERF_DOMAIN
>         tristate "SCMI performance domain driver"
>         depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> +       default ARM_SCMI_PROTOCOL
>         select PM_GENERIC_DOMAINS if PM
>         help
>           This enables support for the SCMI performance domains which can be
> @@ -14,7 +14,7 @@ config ARM_SCMI_PERF_DOMAIN
>  config ARM_SCMI_POWER_DOMAIN
>         tristate "SCMI power domain driver"
>         depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> +       default ARM_SCMI_PROTOCOL
>         select PM_GENERIC_DOMAINS if PM
>         help
>           This enables support for the SCMI power domains which can be
> @@ -27,7 +27,7 @@ config ARM_SCMI_POWER_DOMAIN
>  config ARM_SCPI_POWER_DOMAIN
>         tristate "SCPI power domain driver"
>         depends on ARM_SCPI_PROTOCOL || (COMPILE_TEST && OF)
> -       default y
> +       default ARM_SCPI_PROTOCOL
>         select PM_GENERIC_DOMAINS if PM
>         help
>           This enables support for the SCPI power domains which can be
> --
> 2.45.2
>

