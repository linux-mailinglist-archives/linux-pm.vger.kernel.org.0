Return-Path: <linux-pm+bounces-5713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E636B892503
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 21:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D88D1C21DD2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A813B5A4;
	Fri, 29 Mar 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4T0aDZ9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2C13B2BF
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743222; cv=none; b=mMcsNshybvaDcbzYFKpwZ4AbaKKFh71XH182vmOe71Ky/Bz/Td/mv9sPjOZTEuUcTjYAvD4ks8umHWQL3E2HzxAEGK1hloYqdsApkgiissrziHwlabsKzDjguUL6ypeyIo7ck2FeGTvWCaFQIC+/qv7+XUmz824eN0saiXBAjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743222; c=relaxed/simple;
	bh=1CIhbiDhLdPetfy8JNPZBtZ4Bo5ffBYFYyqo2HebwIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tChSHyByfL662ygn5/hIIGMLK4m6jDPkAc2UqguTC6K+DEmCqPhIG95fEwNVjSbkBwiauEwM3rv3XBMkhb0j0ckyBZgu3MY0j6r8HTOzKPclyNjT4iS0FzTdWkX/nvG65O/j2svo3XBzPkKUNuMz/6YmTgEyG59kVrR2U3ZROzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4T0aDZ9F; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dee917abd5so136725ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711743219; x=1712348019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWs7zN/LFor0Uf4kjH3ZAhI6dar6SefwVzRPkQY1ryU=;
        b=4T0aDZ9Fm2QPaJAKCaVNYyyYAO+oyDf/nrd5B58/e1mrG6ymJjdu0p9xHdF87cThAs
         3RAAPY69k5SbPV3UYWlRqYm6jgc4nQGeRNq1w54wRd+vru99Kl5ub/sYhrCMWu2Q7GLH
         vPCJribBXYTwjVwKndWY4yzy72KeZ/0Hr5mRaTMS9f6pUH7le25CzRXFJCVA3nVqHaCz
         73V0sgP+D8tpLpkXdKiZmwytfcDJ4rH98SzvsfwUsxLP61A7Kodp5qVw0+uGHmtb8pUW
         vPZ7yUFmEYPwV1wiyrHTV2il0EMngRIcGB005kuDcoYv/YnlWj8zuONRE1DD8InHhi0M
         GVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743219; x=1712348019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWs7zN/LFor0Uf4kjH3ZAhI6dar6SefwVzRPkQY1ryU=;
        b=nGL0yM9r5vA6Ojv5tViNFeIWbyD6TE52GzF0Lf+yUQKIVi+r8LzUZagXO7HlC+YYbt
         OV69rlPQzYpRVmmozluzzO81OVLWBDSlOTALz7/cXjrB+TDGNXBeZjnboMElWGK+wAIv
         otVh3jJ2+rfB00rOY3xsfzcjUlbQRR938SH2NNwo+okZKUCK8CN99Fk6LESlmHnofskf
         E2RVlei0C/zg+WmF+TdXueq3QDxf8ippnD7OY7poh0796wGukJ/tjq27lvCRItbicUAl
         XY94bc51XSekv6iIcCmVgSl4gLcMFcXZ1ndKW6z4hzeWDB75WNvNtd6M+UNQ5hO8vbFq
         qrRw==
X-Forwarded-Encrypted: i=1; AJvYcCV0mtUogcIdlh8tGTfVpkIyQ8RC6ZbWxomuz9ekndS42Vwwy0Cr6vD3GOfdbkb4BMrS8LyVwdW9livo3qqdspT90+1QTo7rfKI=
X-Gm-Message-State: AOJu0Ywcosc7Z6Qt1O/ylsPaLQT/iLCDb24QdmFdjYWK0c3Gr+guJ75D
	rjaPsvZlYxDyccPVus7hQ5uBPO75rYp9DHLjz/ebalDt7NFsGvU7/gqDXRGpZQ==
X-Google-Smtp-Source: AGHT+IHsexnfMRJbpIHl9fmuE3u0hPgMNGbbB4LfvtV65/D832Ij+scd+b8wqjyQ7qu7XIMJR5vcbA==
X-Received: by 2002:a17:903:124c:b0:1e0:984b:6215 with SMTP id u12-20020a170903124c00b001e0984b6215mr270043plh.16.1711743218318;
        Fri, 29 Mar 2024 13:13:38 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b006ea8c030c1esm3371937pfd.211.2024.03.29.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:13:37 -0700 (PDT)
Date: Fri, 29 Mar 2024 20:13:33 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 08/18] platform/chrome: cros_ec_chardev: provide ID table
 for avoiding fallback match
Message-ID: <Zgcg7bAnp-tM_-oz@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-9-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wFqlCGmJIgYSWWvX"
Content-Disposition: inline
In-Reply-To: <20240329075630.2069474-9-tzungbi@kernel.org>


--wFqlCGmJIgYSWWvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:56:20PM +0800, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>=20
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>=20
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_chardev.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform=
/chrome/cros_ec_chardev.c
> index 81950bb2c6da..7f034ead7ae4 100644
> --- a/drivers/platform/chrome/cros_ec_chardev.c
> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> @@ -14,6 +14,7 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/platform_data/cros_ec_chardev.h>
> @@ -403,17 +404,23 @@ static void cros_ec_chardev_remove(struct platform_=
device *pdev)
>  	misc_deregister(&data->misc);
>  }
> =20
> +static const struct platform_device_id cros_ec_chardev_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_chardev_id);
> +
>  static struct platform_driver cros_ec_chardev_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
>  	},
>  	.probe =3D cros_ec_chardev_probe,
>  	.remove_new =3D cros_ec_chardev_remove,
> +	.id_table =3D cros_ec_chardev_id,
>  };
> =20
>  module_platform_driver(cros_ec_chardev_driver);
> =20
> -MODULE_ALIAS("platform:" DRV_NAME);
>  MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
>  MODULE_DESCRIPTION("ChromeOS EC Miscellaneous Character Driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20
>=20

--wFqlCGmJIgYSWWvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZgcg7QAKCRBzbaomhzOw
wvrTAP9XyHBI49KZpUJOqS3U6D/DlyctZOrtzWcMGwpPYLOnSwEAn6YA3cLIsuZd
54v611hE+7u8dPasuYmhfLU8nNUfqwc=
=mzdp
-----END PGP SIGNATURE-----

--wFqlCGmJIgYSWWvX--

