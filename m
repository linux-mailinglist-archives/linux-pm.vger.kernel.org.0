Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6B1C2891
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 00:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgEBWY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 18:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728530AbgEBWY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 18:24:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27BC061A0C;
        Sat,  2 May 2020 15:24:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B95BA260157
Received: by earth.universe (Postfix, from userid 1000)
        id A473F3C08C7; Sun,  3 May 2020 00:24:23 +0200 (CEST)
Date:   Sun, 3 May 2020 00:24:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 1/4] power: supply: core: tabularize HWMON temperature
 labels
Message-ID: <20200502222423.5xevejzk5pgwgyiy@earth.universe>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
 <79bec8125df260bdae294345bd7773dc3dd9c434.1588345420.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqlsj2lv6kyqliyz"
Content-Disposition: inline
In-Reply-To: <79bec8125df260bdae294345bd7773dc3dd9c434.1588345420.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xqlsj2lv6kyqliyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 05:11:18PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Rework power_supply_hwmon_read_string() to check it's parameters.
> This allows to extend it later with labels for other types of
> measurements.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
> v2: split from fix temperature labels
> v3: remove power_supply_hwmon_read_string() parameter checks
>     as it is internal API (suggested by Guenter Roeck)
> v4: remove unreachable() as it triggers compiler bugs
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index af72e5693f65..f5d538485aaa 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -13,6 +13,11 @@ struct power_supply_hwmon {
>  	unsigned long *props;
>  };
> =20
> +static const char *const ps_temp_label[] =3D {
> +	"temp",
> +	"ambient temp",
> +};
> +
>  static int power_supply_hwmon_in_to_property(u32 attr)
>  {
>  	switch (attr) {
> @@ -180,7 +185,20 @@ static int power_supply_hwmon_read_string(struct dev=
ice *dev,
>  					  u32 attr, int channel,
>  					  const char **str)
>  {
> -	*str =3D channel ? "temp ambient" : "temp";
> +	switch (type) {
> +	case hwmon_temp:
> +		*str =3D ps_temp_label[channel];
> +		break;
> +	default:
> +		/* unreachable, but see:
> +		 * gcc bug #51513 [1] and clang bug #978 [2]
> +		 *
> +		 * [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D51513
> +		 * [2] https://github.com/ClangBuiltLinux/linux/issues/978
> +		 */
> +		break;
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.20.1
>=20

--xqlsj2lv6kyqliyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6t8xcACgkQ2O7X88g7
+pqaGg//cdk2UQ4FUDhA8eBirpDK//KybE93ZvSCBpIgllJPwKs25hQc9xy5VUx5
q/0TJ3dnAzD/myVFcJym0hUj2E5UV18ewvuUVBfK/FRLCLTg+uI2Vyb0IfF52OBp
UdcsrhhopftWiiBSJHfnsR9IWJfQvG1+gEPgFaAeDYegJmRWGCxx5qimYbLQvIx5
Rzckpv5igmJj6+ePJ67NgmRNokmrB6jG1FPpjUBs8fsRGDfcCWzs7AT0KZu9E4Kp
O+Ge+pEkrafYhEyTAz+1hx6kw5kjUiAVfFjfHxEPW50mDmvcO7UPxCWk9eyEA99Z
IxQTGlEXUk+4E2jWS1SmBurPdfyMoGl3rGMKTBxQ83V9YBvnWhQXxqbIRFVSmoKH
+4Qoxfgrt6/qaX0dkgXjabakaHrn8s1hNrsjirHahURTOrTbjLNV2+h9Ejp1nqi0
ZWiz+2M7zc4TPPb3KGkX7db49pOtKqGJhwUfNQ95c0IVscoX7lR6ITfaxSrdv4ci
5xe00m9vE87JhDU6yJSzaN0JSwvk0ZuhHCk6+t9BcnHS+5TZAbb6CzPl9AlyfrnL
mn5u0GVsI5AfbBHbEPAecGd3tKF19N4vb+eZWH42Na+LSzLbaBdQb64SHa3r5n6N
DOVU8y1Qk60tTxzPlZ2JIfO325yskrYnDCtfaJ/g3IJX3dVmiYs=
=BpIr
-----END PGP SIGNATURE-----

--xqlsj2lv6kyqliyz--
