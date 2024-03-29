Return-Path: <linux-pm+bounces-5723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446E892539
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 21:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40C8287FDF
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C613BC13;
	Fri, 29 Mar 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3pxZg9y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E913B58D
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743797; cv=none; b=g/nNZrMwxf+V/gviApAxQrum1aps9YtWyA4nWoEd7m5yctdPCLDtmKG503zma4qo3euXf7Bksyal9zZJTFiWe8tzZWVMSB4bVZQyvbM3eMBcXdwxZ8hgi4FRSUsCSZ3pm6UNERvGE5xred3MZKSKDUKRMKmVc0QWXf6jZFy2JfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743797; c=relaxed/simple;
	bh=VkyUGxPzPrKZfFXaNY77PCh9MVkCj7rwoCyNYewVKIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW6zo0T440koOc4q76oT3XRmJy90UN0wItGzT794ydFKYdVHjIWYu1umaX5w6yeFHi14m7Uf8G7wB4FFd3DqCbt2fFcodyB7wH+Hlwq8cPtmPPszS3yMBwrN2Thur/suhaO53DFMD8ZH6jrQMXpmsQMgdO73CQR+dMLrqqqN71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3pxZg9y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dee917abd5so137855ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711743795; x=1712348595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYuuDc1UrjHcFRqSoVGgtV+0yOfl9L+kGntncI1D1g0=;
        b=M3pxZg9ywyWlcZXHdi6j9BybRvMJooPLEFoSBy4EW2SFwd5+oRX4bVA8VB6VTFWqXx
         P2tj4U1+S20MltlJ70v5DZ8ME37pYk/Jfe+K4ci4FIlp5DYGxhb9B5hjn5gPvurbg5pQ
         yQ6bQY3nFT4xOrOIQkgEobmvtX31pzqCgM9cno72UCtsFYKEfnffw31fPXAMFVnTdMjj
         HVhlFsTyzI/MZeU+YYgpW1fL8Ap+MsG8gDVVosoHs3ZZAlg9bm+50pt5vLYuuH0Uvraz
         WOTp0kIvVsq4ih8DgYf+OyiccPV6JZ3cxyNSld0lAD2zPrLU9hl+b5FQILukBsod1fxL
         uykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743795; x=1712348595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYuuDc1UrjHcFRqSoVGgtV+0yOfl9L+kGntncI1D1g0=;
        b=VI8NeP+NZLapLwVJbx1jiOHMokg7h/yb0qJ4IgNvFezfa1ANCxsNa+exRSRWW+A6W+
         7vNMiNyfOEeFk6kx4dGWacD7bS6ZBFohDdwI3U8d4nYl2sLUd/YtHkLr1PIAm/ApJ7Kl
         C/D+uSy3j+i2ETq+eMFujb4xYtHBQ0ePHz4yhGa/iKc/+xRP0pnJIDcpIN0erotCiW1T
         SyaK72tYbXMr3RwCSgJKzHvBRdEcp8cGTif8bnqjWPqyA3poyVX/36VD8T6yavrIhkRu
         O0Pa7HQWekmt1WYK1mEwdPPKD9SgcjeSsqY3PLxq7oYFlOqdtHrofOJKODW7mxEn2FMC
         WaEg==
X-Forwarded-Encrypted: i=1; AJvYcCVP4bTCmOIoKp2tDVq1EuvOTLcqfqh5/GQa43toaJtyYgJyY0CVRQuJeM5djHGwcACZYZJQsgdyVBxLjbTjyuxk/TAJtLbhYpk=
X-Gm-Message-State: AOJu0Ywz7//4aj+2tEDJG3xUNkicRWDMSm6qTfN4s6lj82/DJmfy7NR3
	+yS3goN/S/Cl3bAVJzir0iJPk/T19Y3vBB3KAXTvkZ3EWsj20EwUopq4t5GrRw==
X-Google-Smtp-Source: AGHT+IHvn0nqKtbTLUczx8b9ivGiOUqI3uBM94lI6ODQwFeaMdSnffR810G0Ri5UnlVGIBY3mSBZgw==
X-Received: by 2002:a17:902:f54f:b0:1e0:e2c2:47f3 with SMTP id h15-20020a170902f54f00b001e0e2c247f3mr217682plf.9.1711743794601;
        Fri, 29 Mar 2024 13:23:14 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001dcb654d1a5sm3839491plg.21.2024.03.29.13.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:23:13 -0700 (PDT)
Date: Fri, 29 Mar 2024 20:23:10 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 18/18] platform/chrome/wilco_ec: core: provide ID table
 for avoiding fallback match
Message-ID: <ZgcjLj9weWwqvtf3@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-19-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NN08j5j8NnmF0xd5"
Content-Disposition: inline
In-Reply-To: <20240329075630.2069474-19-tzungbi@kernel.org>


--NN08j5j8NnmF0xd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:56:30PM +0800, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>=20
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>=20
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/wilco_ec/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/c=
hrome/wilco_ec/core.c
> index 9b59a1bed286..3e6b6cd81a9b 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/ioport.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/wilco-ec.h>
>  #include <linux/platform_device.h>
> @@ -150,6 +151,12 @@ static const struct acpi_device_id wilco_ec_acpi_dev=
ice_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(acpi, wilco_ec_acpi_device_ids);
> =20
> +static const struct platform_device_id wilco_ec_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, wilco_ec_id);
> +
>  static struct platform_driver wilco_ec_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
> @@ -157,6 +164,7 @@ static struct platform_driver wilco_ec_driver =3D {
>  	},
>  	.probe =3D wilco_ec_probe,
>  	.remove_new =3D wilco_ec_remove,
> +	.id_table =3D wilco_ec_id,
>  };
> =20
>  module_platform_driver(wilco_ec_driver);
> @@ -165,4 +173,3 @@ MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
>  MODULE_AUTHOR("Duncan Laurie <dlaurie@chromium.org>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("ChromeOS Wilco Embedded Controller driver");
> -MODULE_ALIAS("platform:" DRV_NAME);
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20
>=20

--NN08j5j8NnmF0xd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZgcjLQAKCRBzbaomhzOw
wn4sAQD1CpsNqowknTOlUVIhoHGxpEueNDKHe4Vzw+5F/F27PAEAxS+PxEJRIFrz
NYo97I9Ikic/3Zo89drm0AL8dD7gtAo=
=cQau
-----END PGP SIGNATURE-----

--NN08j5j8NnmF0xd5--

