Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8903D13F9B0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAPTm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:42:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38914 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgAPTm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 14:42:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so2132058pjt.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PFk9Ww9wHyG/mGKuMkvNxlgsu1IrcTOB3b5gPJlm5Ns=;
        b=POCZQAy+iwGnHOKPR8OvVPQsopftG4tZaYrk/pzjtQELHQG/VDMfN8I4P1LbP0KaF1
         n6gQTY9alExU9jYzgebtFaInDr2k4FgVphM8ajj4VABjeUL4iOU/oK62hYgfkwCfqVFd
         B0NWHdMS4BaYqTaOaJ7q+PFXvYxNzqxJTCyX7A8Qz4xfGtxwqclA5xZWHZUYvE+8TWDL
         QxCmb4+hH85eeUk5Gy9M8tPFX003zbY2DN/OJfSvRW/2HA7oeM3FoPJqPsTuN7qf0UA0
         ja58UNwK9DuHeQcPIPoYdyJCYlT+e9JY3uRaS8UDwHDdtxekdgG85VZNTUlTCkJnqnlP
         0Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFk9Ww9wHyG/mGKuMkvNxlgsu1IrcTOB3b5gPJlm5Ns=;
        b=hKXtYNWfpORWr9yM3AsjFJ5LvwAe3qpjVJGO1asWsGZJ85+59GNl0J7WuBA0s21APz
         mfijVVk1cqOW+8oMftS4u3m4Rb3kMKQOWazrVV52U692gHDtkM5Nqpin/d1bmJ1//DjL
         51mSqHhyZH4KcGeaU+g8Ie5g8ciS4CgtrJMn9soT5Odb5oyVznwr0iheIsiMOKrPLXB1
         DOwnk053Ob/SwCW/8JpTEKS5370NrSMKJinFNCd3/1VBAvb/xXgAPqThrCFDXKih8YBp
         rtOPJO9gBJzAVsUz5NqMEglpjOLTzF1VD+P5QAiKct/P/BRPSumKAu5FfRltHhhj7Xo5
         qmaA==
X-Gm-Message-State: APjAAAVMIuStQQ07O2pnQPXI4Rmbf+xZYBVGeb+Xwq1JWkaKqSfzg8tf
        cvtFpzx1k/zNfnDIy7CIE5PUHg==
X-Google-Smtp-Source: APXvYqyfzdH6AdQ3U0a7W1IHpaCVKTHGEmR9j0qB/e7Mxj7850qWW4OV8jMGqyXEMwtEaOmvHrDkOA==
X-Received: by 2002:a17:902:b58d:: with SMTP id a13mr25541359pls.283.1579203746544;
        Thu, 16 Jan 2020 11:42:26 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id y6sm25729361pgc.10.2020.01.16.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 11:42:25 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:42:21 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200116194221.GA208460@google.com>
References: <20200114232219.93171-1-pmalani@chromium.org>
 <20200114232219.93171-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200114232219.93171-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant, Hi Lee,

On Tue, Jan 14, 2020 at 03:22:20PM -0800, Prashant Malani wrote:
> Add the cros-usbpd-notify driver as a subdevice on platforms that
> support the EC_FEATURE_USB_PD EC feature flag and don't have the
> ACPI PD notification device defined.
>=20
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v6:
> - No changes.
>=20
> Changes in v5:
> - Updated the IS_ENABLED() check to check for CONFIG_OF instead of
>   !CONFIG_ACPI according to upstream comments.
>=20
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
>  drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..d0c28a4c10ad0 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
> =20
> +#include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
> @@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[=
] =3D {
>  	{ .name =3D "cros-usbpd-logger", },
>  };
> =20
> +static const struct mfd_cell cros_usbpd_notify_cells[] =3D {
> +	{ .name =3D "cros-usbpd-notify", },
> +};
> +
>  static const struct cros_feature_to_cells cros_subdevices[] =3D {
>  	{
>  		.id		=3D EC_FEATURE_CEC,
> @@ -202,6 +207,23 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  		}
>  	}
> =20
> +	/*
> +	 * The PD notifier driver cell is separate since it only needs to be
> +	 * explicitly added on platforms that don't have the PD notifier ACPI
> +	 * device entry defined.
> +	 */
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> +			retval =3D mfd_add_hotplug_devices(ec->dev,
> +					cros_usbpd_notify_cells,
> +					ARRAY_SIZE(cros_usbpd_notify_cells));
> +			if (retval)
> +				dev_err(ec->dev,
> +					"failed to add PD notify devices: %d\n",
> +					retval);
> +		}
> +	}
> +
>  	/*
>  	 * The following subdevices cannot be detected by sending the
>  	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXiC8nQAKCRBzbaomhzOw
wmOVAQCmOfXEIqYrEhqII0PhhILhzQoQbL7FnSHrZAA7Glms1gD/beJW7RUQ4vJQ
sytu0LNykPKlEOZFifYLnTyxRqm3VgM=
=83lm
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
