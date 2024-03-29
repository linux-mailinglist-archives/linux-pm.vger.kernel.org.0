Return-Path: <linux-pm+bounces-5709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6F8924E8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 21:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B3FB20F37
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C413AA3C;
	Fri, 29 Mar 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iW1HuhrF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BF1E529
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742946; cv=none; b=HhDhQoVnhm0vBRVbmcl140xmzcoQtrzQ6lOdcjiq6T4YAVxGxCGDiEB+Rko8B93EuH4fHjiHgC1V5p3pCd4fqUD32+476Ki0A0wJwYim5bxGqPAZ8v/QuaIp9n3PP5E9Z8MOshb77xX+Tz/8bvi+I3QSflk6la3LCLdWdzjqenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742946; c=relaxed/simple;
	bh=kq4W84OOdXe0SAH1kwi4zfWhegD8EvP3wUxvTk2hYHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5IV+qyIlxVzNqsQDvTt8/kJUS+TffSMRhiWic499VxeYSdBcC9Wfcsu4hVYJ+ikz2dDuKd2C5m2I7lSEl1s7h0hRNImur0M6F42pjBtWxhMhHWlPKm7IzW4LnDHCjllb4nfuURAgEGDWL2O9ObkYYieISTDzJYnQq6GcRjaz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iW1HuhrF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e062f3a47bso165225ad.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711742943; x=1712347743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X51BRpaIR1rgIkHIXzIm1Zr/UOpT/8fzPdwE34KNRpU=;
        b=iW1HuhrF496qO5kBQCRFvE5HqWF0ssPJiI0U+LcTQY2iquuhwKTdszEb9ZKZpVGV9q
         u8hyMEZYXxuujtCaYHs3vUCaPvu5bLM2z9ZKRPf0h848ZGUU3Y6pY44ng+N6dkkKQAKR
         xxN42SOVyD/GxdiPsJbmagxXthlpO92AcgxeU9xvj0Mu7RGmYj0wiY/G1p0HsIzodDlA
         1y1s8AxmC8FXdb7FhhtFVjd2ExNM0/oj91tdhqTSSuFIP6k40UG7vlUPXhwnWE5n7uLK
         2RdeQDrj9VspXSXiT0AuT2hx38ECO5Ns6TnIlEKeUqWda7vKjFnBx4+1dYbpLmZXktAr
         biIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742943; x=1712347743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X51BRpaIR1rgIkHIXzIm1Zr/UOpT/8fzPdwE34KNRpU=;
        b=xUh/Dpn4G7SkbuEsWveiQnKRKP08TpiwKoQqRAgyUUglh6C2j/6wi5d73F+RsPObfM
         d9Eg/qcXW7m+9uHSiy5miQ7MldzsEdKAHXHlZFBDrHU8MGFudrRlQHx9SWR0gHhyi6Gl
         lozFOWV+GA0W9aeqOnW2WToqNh48oBbqFT9zf92MZJQ28aHSJsYiYoOHATCY7kCsF1qH
         QY7nXY1d+C0cSPRiUrXSMJQ0AO4xxonzO0wbUJZvWr5nPCyZII/LlZHn+w05LfUnisRY
         ZV2A0Tg9VTqcU0KBBDP9kABmHhWcQChBZa+zs+Wwo6GO5dt6NfHxvMpmSebKm9kpH5xv
         FBag==
X-Forwarded-Encrypted: i=1; AJvYcCUIXeVhLa54SuL80uyYGi5IVoNej7f//6RUWmQVU5UPqhjd4X58iXWiuAB3hSaQ5zXH6OEmGd0NoBHez3FwsPw535pBQawlDjQ=
X-Gm-Message-State: AOJu0YyMQcIB+hVce+Tu9QlCEHKjKH++SWZ62Wh5cX5vj3WNHxdP1gkM
	MxcifUOW98l8XSudfEYxTpD4ke+I/6TrE/bsjtUa4YTbNDiREDkm36gpxac7qA==
X-Google-Smtp-Source: AGHT+IEVROVN2L7PJvbq/CNuGxVo6y8aWUouVMsGMh1RaHF1r6lXWYFexksw0vPDy+coj2+ze5VoPQ==
X-Received: by 2002:a17:902:fc44:b0:1e0:d205:2d80 with SMTP id me4-20020a170902fc4400b001e0d2052d80mr271499plb.22.1711742942350;
        Fri, 29 Mar 2024 13:09:02 -0700 (PDT)
Received: from google.com (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902d5d600b001dba98889a3sm3837003plh.71.2024.03.29.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:09:01 -0700 (PDT)
Date: Fri, 29 Mar 2024 20:08:57 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
	sre@kernel.org, alexandre.belloni@bootlin.com,
	chrome-platform@lists.linux.dev, pmalani@chromium.org,
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH 04/18] platform/chrome: cros_ec_sensorhub: provide ID
 table for avoiding fallback match
Message-ID: <Zgcf2UAbEaPHdfRR@google.com>
References: <20240329075630.2069474-1-tzungbi@kernel.org>
 <20240329075630.2069474-5-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5eYOnsgA3ze6A0qN"
Content-Disposition: inline
In-Reply-To: <20240329075630.2069474-5-tzungbi@kernel.org>


--5eYOnsgA3ze6A0qN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 03:56:16PM +0800, Tzung-Bi Shih wrote:
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>=20
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>=20
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_sensorhub.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platfo=
rm/chrome/cros_ec_sensorhub.c
> index 31fb8bdaad5a..50cdae67fa32 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/init.h>
>  #include <linux/device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -247,17 +248,23 @@ static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_pm_ops,
>  		cros_ec_sensorhub_suspend,
>  		cros_ec_sensorhub_resume);
> =20
> +static const struct platform_device_id cros_ec_sensorhub_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_sensorhub_id);
> +
>  static struct platform_driver cros_ec_sensorhub_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
>  		.pm =3D &cros_ec_sensorhub_pm_ops,
>  	},
>  	.probe =3D cros_ec_sensorhub_probe,
> +	.id_table =3D cros_ec_sensorhub_id,
>  };
> =20
>  module_platform_driver(cros_ec_sensorhub_driver);
> =20
> -MODULE_ALIAS("platform:" DRV_NAME);
>  MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
>  MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20
>=20

--5eYOnsgA3ze6A0qN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZgcf2QAKCRBzbaomhzOw
wpTIAP9SicLM3XbjTEPorbtG3rbMhaOnePPKH5yjXBIFP7/qXwEAuss+4GxuEWd7
nS0Spbtmg8usgOxp39oCbGQ+ouuUiQs=
=oAeE
-----END PGP SIGNATURE-----

--5eYOnsgA3ze6A0qN--

