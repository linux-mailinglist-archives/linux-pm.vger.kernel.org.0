Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD2201345
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393003AbgFSP7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 11:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390420AbgFSP7k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 11:59:40 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5066421532;
        Fri, 19 Jun 2020 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592582380;
        bh=UdAAVUQMEBiEpCD4MXsZgJzJtZHLX2UhG3YcmAjq8Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5qb+Okl8HpMGjMLT4z2sVV9LbSenYCJ9N27jRxc2bqEvTgdGjehWYBHUH7YXZID6
         k3zcODj0BLcgAmrNLlTz87J0vPhxT+UC+Y3xYBwBh4yNl2cE+B0ofAq9ikmcrAP565
         mUlyb1xWBrfMwSSDmYJgYI/IFKfQlEV5tlVFk6gI=
Received: by earth.universe (Postfix, from userid 1000)
        id A7D123C08CD; Fri, 19 Jun 2020 17:59:38 +0200 (CEST)
Date:   Fri, 19 Jun 2020 17:59:38 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document max17040
 extensions
Message-ID: <20200619155938.tpyeerqdn7dqcvw4@earth.universe>
References: <20200618101340.2671020-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dees7qf6ak23f6zn"
Content-Disposition: inline
In-Reply-To: <20200618101340.2671020-1-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dees7qf6ak23f6zn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 18, 2020 at 01:13:39PM +0300, Iskren Chernev wrote:
> Maxim max17040 is a fuel gauge from a larger family utilising the Model
> Gauge technology. Document all different compatible strings that the
> max17040 driver recognizes.
>=20
> Some devices in the wild report double the capacity. The
> maxim,double-soc (from State-Of-Charge) property fixes that.
>=20
> Complete device reset might lead to very inaccurate readings. Specify
> maxim,skip-reset to avoid that.
>=20
> To compensate for the battery chemistry and operating conditions the
> chips support a compensation value. Specify one or two byte compensation
> via the maxim,rcomp byte array.
>=20
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
> v1: https://lkml.org/lkml/2020/6/8/682
>=20
> Changes in v2:
> - add maxim,skip-reset
> - remove 2 byte rcomp from example, the specified compat string supports =
1 byte
>   rcomp
>=20
>  .../power/supply/max17040_battery.txt         | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_batt=
ery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.t=
xt
> index 4e0186b8380fa..3ee91c295027f 100644
> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -2,7 +2,9 @@ max17040_battery
>  ~~~~~~~~~~~~~~~~
> =20
>  Required properties :
> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
> + 		"maxim,max17044", "maxim,max17048", "maxim,max17049",
> +		"maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
>   - reg: i2c slave address
> =20
>  Optional properties :
> @@ -11,6 +13,18 @@ Optional properties :
>  				generated. Can be configured from 1 up to 32
>  				(%). If skipped the power up default value of
>  				4 (%) will be used.
> +- maxim,double-soc : 		Certain devices return double the capacity.
> +				Specify this boolean property to divide the
> +				reported value in 2 and thus normalize it.
> +				SOC =3D=3D State of Charge =3D=3D Capacity.

Can this be derived from the compatible?

> +- maxim,skip-reset :		Do not reset device on driver initialization.
> +				Some devices report extremely inaccurately after
> +				a hard reset.

Same question.

-- Sebastian

> +- maxim,rcomp :			A value to compensate readings for various
> +				battery chemistries and operating temperatures.
> +				max17040,41 have 2 byte rcomp, default to
> +				0x97 0x00. All other devices have one byte
> +				rcomp, default to 0x97.
>  - interrupts : 			Interrupt line see Documentation/devicetree/
>  				bindings/interrupt-controller/interrupts.txt
>  - wakeup-source :		This device has wakeup capabilities. Use this
> @@ -31,3 +45,11 @@ Example:
>  		interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>;
>  		wakeup-source;
>  	};
> +
> +	battery-fuel-gauge@36 {
> +		compatible =3D "maxim,max17048";
> +		reg =3D <0x36>;
> +		maxim,rcomp =3D /bits/ 8 <0x97>;
> +		maxim,alert-low-soc-level =3D <10>;
> +		maxim,double-soc;
> +	};
>=20
> base-commit: 1713116fa907cc7290020f0d8632ec646d2936f8
> --=20
> 2.27.0
>=20

--dees7qf6ak23f6zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s4N8ACgkQ2O7X88g7
+ppQsw/9H03iCYsTY1HV4fuj+8NGhTz2RFdmtvWWLNqO7xOGtiHld3HXBVSzeyoT
9KFGMqY7m5zMJNwq1z2xHeEjbBz70ufd1BPFmqDqj9MdD2eO5N363WCWlTKNGJSU
rhcV7ESr/h5RVAvUcUv/KRukIxADyWS8udoO82ohz8vwZzr+FwVxJ8kmhTx2AGWd
ocwT25ck6MElRsO2p4xRXffGQtmmzwz5hJ0x9rtT6S/Nenc5GY0+RWbKMHFcc/qb
Er0/7nFxEhAh/whlqXn28VTc5ncCZzQjDO/0q5wOee47sZ5ulcaxTS8EIzQtEHOz
sMgLJKvU0slLwO90OCD5q8Qu4Innlva+P2Ez1XeQE2qXXGrtf0hIAGOzhV3Tdf1F
LmlX1RHxtPpMAg8MgsaU+M+YrJ1GR7lV77TnJFDdAWiapeoWGDpI0WHQGRkh15kw
/Wie2A739WJNCLyUIoI1ka3wTdGJO/BgbemvEmDrqY0wZqX5L/Zry6RAzna+s5Rg
D58GjiiETtCYzszcRFsUlV8xdT8bTmMGeE/aHj0ham3Vid1W2jn71nctaMMGLel4
coMIPxKZqyEa7Qv8jUHwio8rwxBhdkvM47p1Te6BNJADPexhhMadunZhGVUTFHXh
t2178P5UkEqXC3l0HdkikgxRh7XeUkXnKKmiHLg9lobTWQc93I8=
=nB5j
-----END PGP SIGNATURE-----

--dees7qf6ak23f6zn--
