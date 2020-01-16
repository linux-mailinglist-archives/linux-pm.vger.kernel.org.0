Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9313F9B9
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAPTqD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:46:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAPTqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 14:46:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so10728950pfz.9
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 11:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qWxprvQq91HlSBYMtq4wuCeE12lVfFcZvqXvzWSRM9A=;
        b=EhvP6/2oQIZiZhj0JtyDkObGdHPS3i2JlXJcrmc81qk15Orbf/pb+MRAKKrL6CuZMF
         BrHaVrF2TcOqNLWlUJ2jYZ9UNNUgVI9TIoeJxFGtcR1tPMkPnuEQvGDVHfAltW91U4oy
         1GQIWGThIAHypTeiBaPKoIOwzQu2o2x+I4xWoVqYWjtDDEv6HzPcLhBUkQVZHuoSTz3q
         4tslyv+OHQfQBAjKAFaBjDQG4wLnqkCxj6JgHpJrEGOvSdGUZ+dE7XC7eukgLOA7ze6a
         NFKfBCfnXgth3YJmc0loFBLmjX5Y4O6ZAdil99N1qq1BCgj/2zNOalAX/5FQgoY+DGkJ
         n3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWxprvQq91HlSBYMtq4wuCeE12lVfFcZvqXvzWSRM9A=;
        b=ERgEQAYNtlT+BINzsRJKjuEsA3IXkehxg+K2iYOJdcMfBs+Kge7IOjo/1OHKATRL71
         P9pHq76sQ54hshzAKuGwMBy7kXnwHOq7RFaxCinS69VtDFlHtDmtXkeQkUoPFLaqyz+M
         j5qTpiN5H0veWwlCliOj1NLYlscN3UMMrDjtXDj4yrvWVCUNLUPFzH4YKVh/pl01WbMG
         /m2pwdn2xUg62SpsCQ+Cyels5Y0fvi8c1we2uj6CYlySg3yMBNUPhiBfVBjoxeUQrg9l
         LaJyXkY0s7cOVzWQ1+0pAupaLU9hkCFMjn7orQt98CQIyBtRh7RaQ7cv75dsUIwgdr4T
         bX1A==
X-Gm-Message-State: APjAAAWWCFPmysN5hKsaXYj5InGENIVgI+oxKuqAAv7CCuV7XicpyyKd
        Z6bJW0vIN3/aSyNttPnGIayV0A==
X-Google-Smtp-Source: APXvYqxxpbZtsuwbaotN9DqhWLw0w/DJQQR9yECLfaqtCVUUyED5cdd8vdKmS4yJPjSxRH8YOzqxSg==
X-Received: by 2002:a62:ee11:: with SMTP id e17mr39523857pfi.48.1579203961867;
        Thu, 16 Jan 2020 11:46:01 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id i4sm25516768pgc.51.2020.01.16.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 11:46:01 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:45:56 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jon Flatley <jflat@chromium.org>
Subject: Re: [PATCH v6 3/3] power: supply: cros-ec-usbpd-charger: Fix host
 events
Message-ID: <20200116194556.GB208460@google.com>
References: <20200114232219.93171-1-pmalani@chromium.org>
 <20200114232219.93171-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <20200114232219.93171-3-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 03:22:22PM -0800, Prashant Malani wrote:
> From: Jon Flatley <jflat@chromium.org>
>=20
> There's a bug on ACPI platforms where host events from the ECPD ACPI
> device never make their way to the cros-ec-usbpd-charger driver. This
> makes it so the only time the charger driver updates its state is when
> user space accesses its sysfs attributes.
>=20
> Now that these events have been unified into a single notifier chain on
> both ACPI and non-ACPI platforms, update the charger driver to use this
> new notifier.
>=20
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Only a minor nit. Otherwise,
Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>=20
> Changes in v6(pmalani@chromium.org):
> - Patch first introduced into the series in v6.
>=20
>  drivers/power/supply/Kconfig              |  2 +-
>  drivers/power/supply/cros_usbpd-charger.c | 50 ++++++++---------------
>  2 files changed, 19 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c4..ba74ddd793c3d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -659,7 +659,7 @@ config CHARGER_RT9455
> =20
>  config CHARGER_CROS_USBPD
>  	tristate "ChromeOS EC based USBPD charger"
> -	depends on CROS_EC
> +	depends on CROS_USBPD_NOTIFY
>  	default n
>  	help
>  	  Say Y here to enable ChromeOS EC based USBPD charger
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 6cc7c3910e098..7f7e051262170 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -8,6 +8,7 @@
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>

Really minor nit. Alphabetize this #include. This insertion should
be one line below.

>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> @@ -524,32 +525,21 @@ static int cros_usbpd_charger_property_is_writeable=
(struct power_supply *psy,
>  }
> =20
>  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
> -				       unsigned long queued_during_suspend,
> +				       unsigned long host_event,
>  				       void *_notify)
>  {
> -	struct cros_ec_device *ec_device;
> -	struct charger_data *charger;
> -	u32 host_event;
> +	struct charger_data *charger =3D container_of(nb, struct charger_data,
> +						    notifier);
> =20
> -	charger =3D container_of(nb, struct charger_data, notifier);
> -	ec_device =3D charger->ec_device;
> -
> -	host_event =3D cros_ec_get_host_event(ec_device);
> -	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> -		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> -		return NOTIFY_OK;
> -	} else {
> -		return NOTIFY_DONE;
> -	}
> +	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> +	return NOTIFY_OK;
>  }
> =20
>  static void cros_usbpd_charger_unregister_notifier(void *data)
>  {
>  	struct charger_data *charger =3D data;
> -	struct cros_ec_device *ec_device =3D charger->ec_device;
> =20
> -	blocking_notifier_chain_unregister(&ec_device->event_notifier,
> -					   &charger->notifier);
> +	cros_usbpd_unregister_notify(&charger->notifier);
>  }
> =20
>  static int cros_usbpd_charger_probe(struct platform_device *pd)
> @@ -683,21 +673,17 @@ static int cros_usbpd_charger_probe(struct platform=
_device *pd)
>  		goto fail;
>  	}
> =20
> -	if (ec_device->mkbp_event_supported) {
> -		/* Get PD events from the EC */
> -		charger->notifier.notifier_call =3D cros_usbpd_charger_ec_event;
> -		ret =3D blocking_notifier_chain_register(
> -						&ec_device->event_notifier,
> -						&charger->notifier);
> -		if (ret < 0) {
> -			dev_warn(dev, "failed to register notifier\n");
> -		} else {
> -			ret =3D devm_add_action_or_reset(dev,
> -					cros_usbpd_charger_unregister_notifier,
> -					charger);
> -			if (ret < 0)
> -				goto fail;
> -		}
> +	/* Get PD events from the EC */
> +	charger->notifier.notifier_call =3D cros_usbpd_charger_ec_event;
> +	ret =3D cros_usbpd_register_notify(&charger->notifier);
> +	if (ret < 0) {
> +		dev_warn(dev, "failed to register notifier\n");
> +	} else {
> +		ret =3D devm_add_action_or_reset(dev,
> +				cros_usbpd_charger_unregister_notifier,
> +				charger);
> +		if (ret < 0)
> +			goto fail;
>  	}
> =20
>  	return 0;
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

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXiC9dAAKCRBzbaomhzOw
wgvbAP0QtfwoVQChl9YxkK2n6Iv1H24tLRHYhDA8vVkTKEdGDAD/TAFa3CXvqngt
kVJ1m+pjWCdZBbCcTvmny2Q83xgp0QY=
=aP8I
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
