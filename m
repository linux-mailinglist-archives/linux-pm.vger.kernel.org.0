Return-Path: <linux-pm+bounces-5788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BD894E17
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D7F283537
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6253815;
	Tue,  2 Apr 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G202nPmq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB751C4A
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048340; cv=none; b=uNi5zSfm9r+kg7XihR7aiogg2mPRjFQp7GkNj2YpH3GM6Tk1/gpukcVWF8pnqgiCVyeO166XMSDUhDOHguVkWMp3yqmS/sO8PFIUOc4K0TwLZq7aURtSsCuWg0qK2uPWuLLg+E+IvllGoYfGCK91famMFA2rWD4Z2V8AvLWCSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048340; c=relaxed/simple;
	bh=HNm6Lh879crSqV0ZGzaJmrt3ssAvgX20Rq/oXJRJF9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta2kf/arxFNJEq/qOk894Yja/UhJrB3QCf/PQ8t8iqjv7oG4LmDheL17AwlYkXVc22ZAv3RnYEXXB4Mn/kxn9czif4X0QE9TjjVZdt99ykIJbjOoxvEYJJWxsojzEpCvu8t1LVNWCxyeiUjtrirBQTpt7sLYcpodBkA3qkDcduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G202nPmq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so51122251fa.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712048337; x=1712653137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EQziKXdKEAMdx/dPCGDP7jmLVDHvzi4KCtf8hrHXHs=;
        b=G202nPmq3BLahFpIpsyBtxc0Pe2+9I2BcQONef2a3bgNkiBlgjsCZJ2cZkpstvoeLS
         528rrTC6yUBa/gd8930W/PWBbGH3ps0xN0Lvn3ta6QLfjTmKdDK51rLvjT+mBqQdBjGF
         axw+CumeE7Bhkud2qcXP6aU7SgnRKr4zqco/7mmGteybc8mofF74j7eCy4MlEjN/ssQV
         HOmdB+2zY3P/viMU3n8kalzI131B+tibh+JZi7COXR/3Nn8U4/bXyw6uGNG/xSy16Srw
         UUckBu+4ufvwMKgOqOa1lCR2tEtMI9YiaVRYblXRiT5m1RFvZ+KR7im58F6JdYdce+Ys
         nUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048337; x=1712653137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EQziKXdKEAMdx/dPCGDP7jmLVDHvzi4KCtf8hrHXHs=;
        b=ADZPxCW7yhH9QTvXvn9pyqdk0+ucWkEUu9AiFwtFbFQBJ/OAOyEsQ0eJ4yeoAPPAlC
         SwbgYk4dymkm0HXmrAYmEcuElbwBFcZ0k4R344H8vi1gX260d+Wi4KHPKuoSPpjd1roA
         KZ1Uw8UzQhjLu9dRmOeMo2JoWnDJRDoiG2/FC6h3tFHY8zW3UhbMgQPuZqJRg9rQp+t6
         sHvThXcMFcxeGu6wsosBNZ/7TKoZpGG3ql9HxsfAtZEUaj98/ZNpI7QeUvTpRWNP/NaW
         OO+ngkp3eiBXXizK7ZVGdEPUvdgF/t66oyIY66LaZpDpje3WC0rEuWsqWNUacn62J0iG
         ay+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUch7WRRRPw/cGpWyBAElTGuD7OlL0ZSEzlcu9BLEUTvULuDyJzcAwb5GPtF/BpBACh8s9DOjolYtaBZLgRxxtRllneml37FqU=
X-Gm-Message-State: AOJu0YyE9TOKvmxVlRz7q1BE1mZQ01AeQaTQRcjNWyzBb9GqI7eeAkSh
	UQJzmeK2Lst+Hr9mjRF+SwlKHpE06MdohWW/26pQvuhE3ad4brf+JEGaDqDEGQZQc5mcAbn04Ve
	fwMQL9IPKYdQbpxoC8TnJ14Cv7Q1D3ppbbx6YZmz2GlVgMTYx
X-Google-Smtp-Source: AGHT+IHgVoVAQjY0SVm1Am+geVCD8kGxkvgjD4vTaFUHh5+1OWnpBP+5APV4hCgBud/LOc79OuLkSI2vz2dPlk4j4wE=
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id
 l25-20020a2e8699000000b002d46815fc6fmr7057550lji.30.1712048337278; Tue, 02
 Apr 2024 01:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401030052.2887845-1-tzungbi@kernel.org> <20240401030052.2887845-3-tzungbi@kernel.org>
In-Reply-To: <20240401030052.2887845-3-tzungbi@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Apr 2024 10:58:46 +0200
Message-ID: <CAMRc=Md+v=zWGa=pYUzKkBMipJj_NgYW08XTfvdCFyErOVdvYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] gpio: cros-ec: provide ID table for avoiding
 fallback match
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org, 
	hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org, 
	chrome-platform@lists.linux.dev, pmalani@chromium.org, 
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org, krzk@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 5:01=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.  Also allow automatic module loading by adding
> MODULE_DEVICE_TABLE().
>
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1:
> - No code changes.
> - Add R-b tags.
>
>  drivers/gpio/gpio-cros-ec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpio/gpio-cros-ec.c b/drivers/gpio/gpio-cros-ec.c
> index 842e1c060414..0c09bb54dc0c 100644
> --- a/drivers/gpio/gpio-cros-ec.c
> +++ b/drivers/gpio/gpio-cros-ec.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -197,11 +198,18 @@ static int cros_ec_gpio_probe(struct platform_devic=
e *pdev)
>         return devm_gpiochip_add_data(dev, gc, cros_ec);
>  }
>
> +static const struct platform_device_id cros_ec_gpio_id[] =3D {
> +       { "cros-ec-gpio", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_gpio_id);
> +
>  static struct platform_driver cros_ec_gpio_driver =3D {
>         .probe =3D cros_ec_gpio_probe,
>         .driver =3D {
>                 .name =3D "cros-ec-gpio",
>         },
> +       .id_table =3D cros_ec_gpio_id,
>  };
>  module_platform_driver(cros_ec_gpio_driver);
>
> --
> 2.44.0.478.gd926399ef9-goog
>

Applied, thanks!

Bart

