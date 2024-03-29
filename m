Return-Path: <linux-pm+bounces-5719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548A89252B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 21:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BEC1C2130D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630713C3D5;
	Fri, 29 Mar 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgGEKciz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45413BC16
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743613; cv=none; b=PAYp9rlXnaTL6fjXqGVKyv/R9gTusd0+D/arr0+9qR43DlJTkkfvCocYLOVRDS0vDpl1H/WB92cOjxLVcsx0u8xeCalwaGvvclhRPnvQN0tsR1ipKoG17Zc4loHloPA7u98u/mrIX1fnNBukj1q8nkM6U0SciHCd97HwBvq7fro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743613; c=relaxed/simple;
	bh=TMlSCVvARv+/QQk1peCI1QhFYmOokgWDjrBUu16e/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5tyxQfD0Xa/FDu73G6Q90WciULionn2y6tIY4a1kpdc0UNCSMVQJmE8QAXcENQ9KUaKKfSGxpmb7HAc1KJ3qkoWE/usXF106zpgAHPwYT0eZKqVW9yRWEJdU6TS3gzFTvu0/xy8MrQn7a+DCEfOrHjJGQV/iPoC5ATaV8G4DiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgGEKciz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dee917abd5so137475ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711743609; x=1712348409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dw2UKEsmEQ1dbfFsl/Q4xKQKdTjVuPNAKBUI0kl2qao=;
        b=DgGEKciz02pIzRVVmz5P0GXaxklmbiQn6PYAsspCjzfFz2rexYJi8LiszV0WE+FjLK
         fmT2U0KA7bMeoz29VjNEv7NbapFN2HlsNYq3xlYGi3whPUP6ddDUjMp9GO3LB9oNR1RU
         OAiwN8mt2EhBNCd7gKkgZWzbWnoK8tF3sqW9GveHTbNR//As8MCevTqQ9Z9g2jnFfnOy
         mXTt5y9eBdZ62DXG+5ooI992OdxhMLn8aPu2D82z8n0ZRS1/jKpxkwqH4OfhYXHIglXT
         5TeG2lRRy9qPlqti2pwe0r4S+yF10ae474lIZ0BLSb63Rxy9xh23r4SNb05PzSYiztA+
         fzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743609; x=1712348409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw2UKEsmEQ1dbfFsl/Q4xKQKdTjVuPNAKBUI0kl2qao=;
        b=WCZmIWab7lH9PdzWn5rbVIKvODi7eLJ9OYAb+DHpKFY4gJN6OVwwmiTLfWPU9ST0ue
         X/yTGsO5Up5BgSW58voxJehcgIhZim6lLIIH6biOUwbjmt6Z/O6X4ieJ2cW7G1i8paxU
         6s91+0krtfp4cR+WQZIfqM90LcJA6+0UP/4epZobFoMspmXp08TWL+aD8HRINHOAEhi0
         NBuuWF9nrTdEjrYD9pMjFRpDpHvRrHQlym4F5a+pwTfgi/368z2p58fh4fGFds/f7E2g
         FtBWu6mhjMvyI/yzNuzDucXKN05tjDZpvucU/OYBEkZCPJtUmygpsozChHPwcWRaNs34
         wptw==
X-Forwarded-Encrypted: i=1; AJvYcCVYRjVhbo7LAizhGFPyoTpYxY11eEIQVz/D4Q4/kxG79Db2OAbMZQqpUoORTDSFkE/s+XawGGwjg9OR2scxn+6+7hX7feE9Q0Q=
X-Gm-Message-State: AOJu0Yx58zRzitwRKu47uwU35/mkQZQwBg5+Yn2RCBAn0k3UMa0iskq2
	H72zVYyK+yqYiSCgNLSmxAFqH5BE9XO4G8yz5W0+skc4PM9wPuw0w+b0I+hkGg==
X-Google-Smtp-Source: AGHT+IEZytbvJa5yNZVS6rHrzZ0f3+OwdvhypA97X7iN+ES1iLWIZ7fwGbVEbMh3zlHPs2bYBDBciQ==
X-Received: by 2002:a17:902:ccd0:b0:1e2:4092:467c with SMTP id z16-20020a170902ccd000b001e24092467cmr72007ple.2.1711743608655;
        Fri, 29 Mar 2024 13:20:08 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090aa88b00b0029bacd0f271sm5499074pjq.31.2024.03.29.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:20:07 -0700 (PDT)
Date: Fri, 29 Mar 2024 20:20:00 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 14/18] platform/chrome: cros_kbd_led_backlight: provide
 ID table for avoiding fallback match
Message-ID: <ZgcicEucsO_vcVqk@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-15-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EXWDu5FgItCHGBBn"
Content-Disposition: inline
In-Reply-To: <20240329075630.2069474-15-tzungbi@kernel.org>


--EXWDu5FgItCHGBBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:56:26PM +0800, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>=20
> Also shrink the name for fitting to [2].
>=20
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
> [2]: https://elixir.bootlin.com/linux/v6.8/source/include/linux/mod_devic=
etable.h#L608
>=20
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/p=
latform/chrome/cros_kbd_led_backlight.c
> index 793fd3f1015d..b83e4f328620 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> @@ -247,17 +248,23 @@ static const struct of_device_id keyboard_led_of_ma=
tch[] =3D {
>  MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
>  #endif
> =20
> +static const struct platform_device_id keyboard_led_id[] =3D {
> +	{ "cros-keyboard-leds", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, keyboard_led_id);
> +
>  static struct platform_driver keyboard_led_driver =3D {
>  	.driver		=3D {
> -		.name	=3D "chromeos-keyboard-leds",
> +		.name	=3D "cros-keyboard-leds",
>  		.acpi_match_table =3D ACPI_PTR(keyboard_led_acpi_match),
>  		.of_match_table =3D of_match_ptr(keyboard_led_of_match),
>  	},
>  	.probe		=3D keyboard_led_probe,
> +	.id_table	=3D keyboard_led_id,
>  };
>  module_platform_driver(keyboard_led_driver);
> =20
>  MODULE_AUTHOR("Simon Que <sque@chromium.org>");
>  MODULE_DESCRIPTION("ChromeOS Keyboard backlight LED Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:chromeos-keyboard-leds");
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20
>=20

--EXWDu5FgItCHGBBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZgcicAAKCRBzbaomhzOw
wq0OAP400FBKzZ1bg529Vae52rOmu0AJp1mCnVBHtVPTH8qVHwEA+RXCK2NfrrFX
QgDUxhT14YgEhhADRBiy0dbP4DnQAg8=
=Ey5M
-----END PGP SIGNATURE-----

--EXWDu5FgItCHGBBn--

