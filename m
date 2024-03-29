Return-Path: <linux-pm+bounces-5708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916918924E2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 21:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4811C285A22
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503013792C;
	Fri, 29 Mar 2024 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK1mp5/C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065B713A3EB
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742828; cv=none; b=jPoHmIqTe5KgcuIDMyLlV2q8njYxniky9Z59wEMrhz/uWvWDATIUh0IfsvboaFVs6jGy7NVX7QeixR4poWUH2dO9+FB6+/9CPVZILWZrRvHfr0x9f/wLGU85cPboUNQH51uzn26taO8m5mLE1hroNWsSoHPE1nMApWzqxoJDcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742828; c=relaxed/simple;
	bh=r+skzr39WHsIjKxfCdEB1wP9cYEVHafh3tgtF3jsYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bex/D06uRWNhL/ePxXZsMBgtMqSb9y2ogRiWRio8BSuLVVsqJDQXsW+HenLzU45LFW1rNDQiKkTnC8GjvQuS6jvIcWDMuCw7uF1teYlOkCrsWPamrBfaIWsUXXqBrJGoM5pry66WsoIPQUhiVJnlZGy23FnIzZwleghs5cv72YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QK1mp5/C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e062f3a47bso164945ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711742825; x=1712347625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDr8xhMZUheX/5ZecGm1BMQwFFY+3gvYNbb5gMLJkNo=;
        b=QK1mp5/CtRSdXooM5aAV2mrYNcxaWW0nZZv2VAbvAzWaTqhIAvu/iLbCuKUsbBKL6F
         hUPSgef9B6dT+qMChRZrhrzhn4cEcyOZTSk+8VHHw/TG5xoeNR1+89cr0FQ65+D9ZvKf
         ZpYMlFMdTNy2ijWdlyRzM9DR3topdeRL2MbRutF6TLUmRG1Gt/tCEl1FOHa8WCBER4rt
         HLjxov/REWy/HLq6/kTWlXz5K7oPnLIHlr/eHM7qOVzP6tzCqjrZHNr2mm1S+OO4alWC
         +sBTv00dFjN4Q9uVEVsD++LSyyNIjoWgl/UvYg3QU/Oe1+NUZg3x702WOl9m1or8wenR
         Ecuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742825; x=1712347625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDr8xhMZUheX/5ZecGm1BMQwFFY+3gvYNbb5gMLJkNo=;
        b=uUNSL1qEyIFI2DR6PZbCL+ryCv+/0UDA4+E3+UlOEgnP7HAebWCAMOXk3wzZOsgGxD
         WoXTbt7ccgYGBQm9VSGUU8pinGPBStlFuLH5nP4yGk+3IwZ0Sf1RqQcKK3mqaPY9y6NA
         EIE7bvwkzxsWtS5nqhYSveyVyyC+uRFtcY35a+Iv3Lmlz3r7fU0HiKqHPJEwWRFn9k2a
         0H8jG0er0icsOwVmMyCop1ttD2J7r+rqVOr8aDCi9H/IHtAkD5o6ZR5drF2QgdC2RmIZ
         4VNidID/+9JEogT8k7JwLOWe1xQ7lHhaIVjxxswyioAiVB0JqWFYteNGcnYhAWz+Vto4
         pzyA==
X-Forwarded-Encrypted: i=1; AJvYcCUAU4ro5pF7DL2qq7IXanYpXLmjm4kwQyKYXAnU+5hBvtPfFCosSqkaIm9ZZeAAFw6PIQs4sj9qURhR02R1vXjjyRIgUCWeMiE=
X-Gm-Message-State: AOJu0YzeLOySueQBisXxkRqo5WODFhkeIsKfaCRjWWKXWjLkdodj9SSS
	SLVnR91voKC5+DPnFUU8kpCPl7tDjwtS3M8VmzQjTMJ0SzqqZitenRScQN/M4A==
X-Google-Smtp-Source: AGHT+IGMLxqzzhs4v9bSN/YjCcCDoK6g4QOUmlamOwMJWvwcjj5C6K6sQu5s1XxRg26cbCTWTPr0Ew==
X-Received: by 2002:a17:903:2a8d:b0:1e2:3991:9e9 with SMTP id lv13-20020a1709032a8d00b001e2399109e9mr127629plb.0.1711742824876;
        Fri, 29 Mar 2024 13:07:04 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id k92-20020a17090a3ee500b0029b32b85d3dsm5950236pjc.29.2024.03.29.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:07:03 -0700 (PDT)
Date: Fri, 29 Mar 2024 20:07:00 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 03/18] rtc: cros-ec: provide ID table for avoiding
 fallback match
Message-ID: <ZgcfZDZQzLppMLqw@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-4-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XjzV9UcZACHbcmst"
Content-Disposition: inline
In-Reply-To: <20240329075630.2069474-4-tzungbi@kernel.org>


--XjzV9UcZACHbcmst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:56:15PM +0800, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>=20
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>=20
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/rtc/rtc-cros-ec.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> index 0cd397c04ff0..f57462c7b2c6 100644
> --- a/drivers/rtc/rtc-cros-ec.c
> +++ b/drivers/rtc/rtc-cros-ec.c
> @@ -5,6 +5,7 @@
>  // Author: Stephen Barber <smbarber@chromium.org>
> =20
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -392,6 +393,12 @@ static void cros_ec_rtc_remove(struct platform_devic=
e *pdev)
>  		dev_err(dev, "failed to unregister notifier\n");
>  }
> =20
> +static const struct platform_device_id cros_ec_rtc_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_rtc_id);
> +
>  static struct platform_driver cros_ec_rtc_driver =3D {
>  	.probe =3D cros_ec_rtc_probe,
>  	.remove_new =3D cros_ec_rtc_remove,
> @@ -399,6 +406,7 @@ static struct platform_driver cros_ec_rtc_driver =3D {
>  		.name =3D DRV_NAME,
>  		.pm =3D &cros_ec_rtc_pm_ops,
>  	},
> +	.id_table =3D cros_ec_rtc_id,
>  };
> =20
>  module_platform_driver(cros_ec_rtc_driver);
> @@ -406,4 +414,3 @@ module_platform_driver(cros_ec_rtc_driver);
>  MODULE_DESCRIPTION("RTC driver for Chrome OS ECs");
>  MODULE_AUTHOR("Stephen Barber <smbarber@chromium.org>");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:" DRV_NAME);
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20
>=20

--XjzV9UcZACHbcmst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZgcfYwAKCRBzbaomhzOw
wkkJAP9uw5For6wPwr4GzdwUm99XHEIiu6p+9R90edx5+wBIGAEAybvPs21S+b1Q
hvvSe/ggXrdw3GKXX7kJCrnS+V13Qgw=
=SMyH
-----END PGP SIGNATURE-----

--XjzV9UcZACHbcmst--

