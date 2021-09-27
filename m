Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D156419469
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhI0MlB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 08:41:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhI0Mk6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 08:40:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B4AC31F42764
Received: by earth.universe (Postfix, from userid 1000)
        id A3E1B3C0CA8; Mon, 27 Sep 2021 14:39:17 +0200 (CEST)
Date:   Mon, 27 Sep 2021 14:39:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v4] docs: ABI: sysfs-class-power: Documented cycle_count
 property
Message-ID: <20210927123917.lm5wborwlh2uhbzi@earth.universe>
References: <20210916125321.10823-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isiby32j46dul4cu"
Content-Disposition: inline
In-Reply-To: <20210916125321.10823-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--isiby32j46dul4cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 16, 2021 at 02:53:21PM +0200, Hans de Goede wrote:
> Commit c955fe8e0bdd ("POWER: Add support for cycle_count") added a
> POWER_SUPPLY_PROP_CYCLE_COUNT "cycle_count" property to the set of
> standard power-supply properties, but this was never documented,
> document it now.
>=20
> Link: https://gitlab.freedesktop.org/upower/upower/-/issues/152
> Reported-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> - Document that some drivers, such as e.g. the often used
>   drivers/acpi/battery.c driver may return 0 when cycle_count information
>   is not available
>=20
> Changes in v3 (aka the really really typo free version)
> - Fix typo in "cycle_count" in Subject
>=20
> Changes in v2:
> - s/Possitive/Positive/
> ---

Thanks, queued.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index ca830c6cd809..f7904efc4cfa 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -480,6 +480,19 @@ Description:
> =20
>  		Valid values: Represented in microvolts
> =20
> +What:		/sys/class/power_supply/<supply_name>/cycle_count
> +Date:		January 2010
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the number of full charge + discharge cycles the
> +		battery has undergone.
> +
> +		Access: Read
> +
> +		Valid values:
> +			Integer > 0: representing full cycles
> +			Integer =3D 0: cycle_count info is not available
> +
>  **USB Properties**
> =20
>  What:		/sys/class/power_supply/<supply_name>/input_current_limit
> --=20
> 2.31.1
>=20

--isiby32j46dul4cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFRu3UACgkQ2O7X88g7
+ppOUQ//QOFgB01rZYQJdyg1It0L5oEXpZCaBw1xh6ejLofW5hqoObkT9ez6yNHu
tXRdRyqE1qAy4FQeMPzR6xS7vpbhzjMHYXM4I8zYUGj0HQBqLY6XxpVTtkez66HY
VT3sLxUnqcTC4QfPkHERaGzmz3dyt2gOU+1j1EZpAssrhIxDK1plOhjQqK//mmV0
a5jCAtW/2NdZ5lTJKcDobv+/v+BiEPqfDXYbTMsmf9lNmJP6574s9sDIC2+T7zMF
OjqWdQFWQ0vVaZRQR2/3TsWj5Guv5IzGHg7dV4pq/BYEj+AfeYx3kgisXQvrZwGc
h7R55Vs1lhbL0FyMo1o2VgQwFf4MdBLUzbNgCE67G64huV6PAJgIPj7JCMc6BnIF
9UqjeqS7U/MJTaNOY3vyxl570jjjAbcOdV3x0xH5vB3Wo2fe7jnOaPiXGwKB0P9T
/tC+13c5NhL9SSUwyBX3P61nIamPLNh9DNWX1tKVOAozGtmUFxjA2NOdWm2fvEVI
niDiGB4pyqtZOeWR/SwLvAXxrUyFRFdmKU+dCJ6uC8ofr5NfACH0ABMcqFa3rN54
4Fc4AX9W6w9X6BKW7VBjqAgtN4junqY2NyanF5LCTm7gQUxpY0/ZcKTD+6LL5HqF
xhOltcRCy2LbGOBP+gKVeK1joAOwNGuk2np+HCPgtde0lwZaRs8=
=eU8L
-----END PGP SIGNATURE-----

--isiby32j46dul4cu--
