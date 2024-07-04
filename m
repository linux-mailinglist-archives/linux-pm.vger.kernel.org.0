Return-Path: <linux-pm+bounces-10603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3969275EC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471AE2817F1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C01AC435;
	Thu,  4 Jul 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM9/1U+u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C4C76;
	Thu,  4 Jul 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096001; cv=none; b=qHikNJF2lE/s3KZFrQ3YaeX2wM5mNA3SLpiGIKAacqNrfUTfMzTPaFjQV1iaJ07RMcuW2JQpcjBw5uNOP3vywnv6KC6+HSj+ui6K303YawRYx06CFWdN3ltueicVe53HClgzL/rnQsBrCP9JUy/vEgeVujYw3rAn+TqvJfNxQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096001; c=relaxed/simple;
	bh=Ol59wRsiQ2j9IWEiSxxfL5HPw8wR16SoFWRvc59G4tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap311DKy5eKZ44+P6X47ytz+xhkAmPTQVIMzJF2MiLOzQRQVRS+XH3QsxUsJbufRu1tbunTOKAhY1RSnVz7xeTlYwUotZvMczF+HjIA0G6vfHHRx9v6NZUQI8yuIeiDTU3DMm2T1AZhigTl7fpKxavZCyYNePZDr84HRiEC+IfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM9/1U+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08832C4AF07;
	Thu,  4 Jul 2024 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720096001;
	bh=Ol59wRsiQ2j9IWEiSxxfL5HPw8wR16SoFWRvc59G4tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RM9/1U+u9zb6ni6iEl7rMSfQaNseyNwAp5z6yLPlkhnc/MHEfWkuZHf//lBTpgUGv
	 hC/YL8FDc94dWPiMBuz+m2WHGfACwPKWCuHlyR+emie35mRLh2q7Gt/iwXmyr1LrgP
	 ckxXjUbsltr4jo9RnhORaw+DueA0nQk2lStJtB/B4jvsMqx2NvG4n/Hm3s5MRw658Y
	 Kjewb1V2nt9YdeFjYLguDWmWr1WWPLCJw2KgL78rpKatfH1QxWnoIzfeoWlFIbrK7/
	 sQbmkjT9AfuGsaDq6JL1fARhKffDA3PzdWjx3pIOrXVotS65cU1j5pd4CQpW4tV7Ln
	 K4MT0clDCh8Iw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25e23e0492dso101038fac.3;
        Thu, 04 Jul 2024 05:26:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAuLQz4cz3wCBkvdDb1qO6i4NKbtKXhC59YvdOo/quSV1E6QTQw0G4eZ2DBWYNxfYmyiO8OteVD6ugojBLNcCq6RxgRWfWw3lktEaNex+HpVBqTCgrmZ89SST8nlp9E5kXYeYI8Aw=
X-Gm-Message-State: AOJu0Yy2LKLWHPrCsdGJJOeqwktmoa3u5lXAJnknzyjK2GDeQjCYpIsx
	T8sC3O3B17Fik6248iJi6G1R2QEVV9LmAs75kQk80Wn/qga+dHvvY8W5P6+Y/TPkPfdTOcDwuDG
	+oLH4Gzm/gknXNVxT2CY45/Gamss=
X-Google-Smtp-Source: AGHT+IE0nlVQZC0eK4Kf15Rg9nA0DHs7RMKa3liL4gNSoysZh7Ye3+nogqNGp8r41o/wLW4/dast0CC3YEinfYYGrvg=
X-Received: by 2002:a05:6820:2c07:b0:5c4:5cbc:b1b4 with SMTP id
 006d021491bc7-5c646a91827mr1382273eaf.0.1720096000243; Thu, 04 Jul 2024
 05:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703083141.96013-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240703083141.96013-1-krzysztof.kozlowski@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 14:26:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCEE1z8jV-+iRgXgHr8SNkeGioUCEij7w_T+H0rzKtbQ@mail.gmail.com>
Message-ID: <CAJZ5v0iCEE1z8jV-+iRgXgHr8SNkeGioUCEij7w_T+H0rzKtbQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: constify 'type' in devm_thermal_of_cooling_device_register()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The 'type' string passed to thermal_of_cooling_device_register() is a
> 'const char *', so make the same in the devm interface.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  include/linux/thermal.h        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 3fb55060646e..4ea27dd25477 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1132,7 +1132,7 @@ static void thermal_cooling_device_release(struct d=
evice *dev, void *res)
>  struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>                                 struct device_node *np,
> -                               char *type, void *devdata,
> +                               const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *=
ops)
>  {
>         struct thermal_cooling_device **ptr, *tcd;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f1155c0439c4..f732dab20368 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -261,7 +261,7 @@ thermal_of_cooling_device_register(struct device_node=
 *np, const char *, void *,
>  struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>                                 struct device_node *np,
> -                               char *type, void *devdata,
> +                               const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *=
ops);
>  void thermal_cooling_device_update(struct thermal_cooling_device *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
> @@ -305,7 +305,7 @@ thermal_of_cooling_device_register(struct device_node=
 *np,
>  static inline struct thermal_cooling_device *
>  devm_thermal_of_cooling_device_register(struct device *dev,
>                                 struct device_node *np,
> -                               char *type, void *devdata,
> +                               const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *=
ops)
>  {
>         return ERR_PTR(-ENODEV);
> --

Applied as 6.11 material, thanks!

