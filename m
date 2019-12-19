Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87AB1267E3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSRTO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:19:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSRTN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:19:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2CDC528E9F9
Received: by earth.universe (Postfix, from userid 1000)
        id 1B6663C0C7B; Thu, 19 Dec 2019 18:19:10 +0100 (CET)
Date:   Thu, 19 Dec 2019 18:19:10 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] power_supply: Add additional health properties to
 the header
Message-ID: <20191219171910.wbx4ry6hgip6g4fm@earth.universe>
References: <20191029200201.24483-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfodonbtdmwl44qm"
Content-Disposition: inline
In-Reply-To: <20191029200201.24483-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rfodonbtdmwl44qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Oct 29, 2019 at 03:01:59PM -0500, Dan Murphy wrote:
> Add HEALTH_WARM, HEALTH_COOL and HEALTH_HOT to the health enum.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

This needs to update /sys/class/power_supply/<supply_name>/health
entry in Documentation/ABI/testing/sysfs-class-power. Also it needs
to update power_supply_health_text in drivers/power/supply/power_supply_sys=
fs.c.

-- Sebastian

>=20
> v2 - No changes
>=20
>  include/linux/power_supply.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f737e7d..bd0d3225f245 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -61,6 +61,9 @@ enum {
>  	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE,
>  	POWER_SUPPLY_HEALTH_OVERCURRENT,
> +	POWER_SUPPLY_HEALTH_WARM,
> +	POWER_SUPPLY_HEALTH_COOL,
> +	POWER_SUPPLY_HEALTH_HOT,
>  };
> =20
>  enum {
> --=20
> 2.22.0.214.g8dca754b1e
>=20

--rfodonbtdmwl44qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl37sQ0ACgkQ2O7X88g7
+po14xAAmDxEnXqbxBAs2CMJUrQnAZA00F70xGwzaZ0QDJPRm2fa5ug0GIWlnN8G
DVRucn9lsg/PfWcWSXV0lLqh1zIHYMKuyeRzxeQs4Q3cY6ZTf4nwDzlVGBZfVmKD
zCrJF64eoaYKXmdaB7AB/AJFE52hHDdceu781UB+4OTI8uukXYxy0iFgYBsD5w2o
y4oLQ668ZnQHIY0Yi6aqpT3ym60SrAUQsdQdt0jMv1k5PkfkLcHBq0YxxHTPxIRO
d7aY8Nkj9LzET1//SBONnigJA8hgl3LJmc8aIlQFK2uQeTyMVLmcc2CwaInXjWvP
0zJ/TGua4qOMwD6Cb4g50Zhy4IxJlnnfwQ4Ur1jSDhMU/Ljrx0vgRQqyFwY/0S7C
TNYY4VB9lWq+LlovKiNiw2uhIM13YLFxB2sRfmjJGDZd9xF6jl/I0Oij1PVpNQ6C
1fU6wmJm7ybvEheX2mbTOCqCKaKCwVVvY5HYauS74FfFGaLxONDqTz/Ccy+WrVSM
el+bRnS4M1o7guL+ZjApUTmBguMPnbcNprvGcEYmMDliUXUpeeKJNoh137iS1RPA
3VnmtgkxOmLVHh2CSsvC2fEPeB9JIIWWykZ7YX6W7y2To3SPVV2Ol4tx2DzxnqHW
bckeQ5UYGRTo2PFVEsRtcqWBXILOeo2wQnEaCAdXe0YuKuzMY0s=
=J1KW
-----END PGP SIGNATURE-----

--rfodonbtdmwl44qm--
