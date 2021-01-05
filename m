Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA22EB4DD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbhAEV1O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 16:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbhAEV1O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Jan 2021 16:27:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 728A322D5A;
        Tue,  5 Jan 2021 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609881993;
        bh=0h2EnmcGyrtAyDKIV/nV5AQlooTxVMooHJEnIT20PW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/P6hBRVV4mtIfq5IHmonZDv3B5ECo0nGBqlJG7qOAnFzlfARclH1h/hDjkWIYVFU
         do1VpSx/FZSMNiZj6XOSEnuTDK2rWRX23n4VI3JC3meTguoPw608V8QBBbLsZ9ylyk
         xLpNQ4Wi8hF9AN6bgrz7p/YrWEhk0MY0gJxzxy38kPn5Qr59src6NpisU6VjzUL0C0
         JTgjMvFlnKfyUnCUjTmPNTNQsi9kCICkxR4N49YqDBOSUSuYq042ixIwnKhKIRCaH1
         7vTOIqkS8HSgPv0X5kTuZ7Q2u9R82LsQkKy88HrMjewoD2lK1fnwMkOCD3tu4dGmiE
         d6zUH5/3WvagA==
Received: by earth.universe (Postfix, from userid 1000)
        id 589323C0C94; Tue,  5 Jan 2021 22:26:31 +0100 (CET)
Date:   Tue, 5 Jan 2021 22:26:31 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v9 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <20210105212631.2meujp37e5jqp7eu@earth.universe>
References: <20210105202949.14677-1-r-rivera-matos@ti.com>
 <20210105202949.14677-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3arhu4mpg74a7e7k"
Content-Disposition: inline
In-Reply-To: <20210105202949.14677-3-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3arhu4mpg74a7e7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 05, 2021 at 02:29:49PM -0600, Ricardo Rivera-Matos wrote:
> The BQ256XX family of devices are highly integrated buck chargers
> for single cell batteries.
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>=20
> v9 - resolves two warnings issued by kernel test robot

changelog needs to be below --- btw.
(so that git am does not pick it up :))

> ---
> [...]
> +	ret =3D bq256xx_parse_dt(bq, psy_cfg, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
> +		return ret;
> +	}
> [...]

If you want to change psy_cfg, you need to pass it by reference
and not by value (i.e. use &psy_cfg here and a pointer as argument
of bq256xx_parse_dt). Providing psy_cfg like this creates a copy
of the struct.

Did you runtime test this version? It should crash when accessing
the properties because of psy_cfg.drv_data being NULL.

> [...]
> +	ret =3D bq256xx_power_supply_init(bq, psy_cfg, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		return ret;
> +	}

Here it's also better to just provide the address of psy_cfg
(but not strictly necessary).

-- Sebastian

--3arhu4mpg74a7e7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/02YQACgkQ2O7X88g7
+prDHRAAkb4EPnHdqNjOJuOVDe8q+gjbcmkrmVCuG5XEroOtaDsIfsirdgRBasIl
aKm98jle9WyUZcRMTpyPrTPwN9Vpkp7kk19cCrEhwHC3AVc8BQTN50mcJRSUNqNy
4golBeaqv2p+h3DpNYLXFwbftwGmMkwv1X3KjveteDFTv6ERse8i6pmqKPB7cSQk
ITUXloAM0gQh2FNdF+VTUUVDy8x+y+EyhGBSuPFYS+WQjSGVh8sM2xD5vEDSoEIb
li3ZJEJh5hvUjESuZxmgoMVityw0GK0yPHRqFoLy3n6qx906MmwIYGbEmaLXKGBb
yLUwf9UYKITTqUaqAps4OQc8hMvIWgMXJOUIU5naVrlCAJfFQexDXctMONngU+1X
FKzHogqHTvTo6P63DM7uyY3xrBfOWOYwkdSqAfcn7Q44tJcme98ThPFMxRz4jYax
YBqo3UO8OrkchhJO/3+WgyaMWL6vdL0RNXf5BjhibjHTfk0HEo+nU6TqBWGEW0Ev
PenTSoiHMYVqwQ7End2OnNgw3Se8ziy/jwNRNMnNpKQoG67HVSqQh4eCPozMvJQm
w4vh4WwoMKdBHSfOv3jB7YROmtTpkVGMaG8Ox99EEw4J397TeLQynifw2AMDZpXk
g9dQ5LzDYhTLcaRdJazUxPbXKQ/AzpJn+hYl7Yd/vYwdy34Fk40=
=2tBC
-----END PGP SIGNATURE-----

--3arhu4mpg74a7e7k--
