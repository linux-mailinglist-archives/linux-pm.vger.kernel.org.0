Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A654B2D12
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 19:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiBKSn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Feb 2022 13:43:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiBKSn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Feb 2022 13:43:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33D337
        for <linux-pm@vger.kernel.org>; Fri, 11 Feb 2022 10:43:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F21D11F472CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644605036;
        bh=HzE8XoWHXUugPq7RNO8OMt/s2YfLphh91Crggz3sR24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlXelJnnewM3yGoM0MdyWNME3xsmJn0AcS6HvUfLVzFCRnQiA+iHvzfYZX/yacmZC
         Zmv2O6tPO/l0kqy3vGcO/q4uVvUl/7BUl0PApoNys3Hoqs2uhkZUQ5soRvJhgxz+Jn
         GVMA+WngrhIAjYuIcIf0Ax05EtyvZ/sHiVg2Tgp68hFFH+hvnTDIYiNTHn69Hvawra
         b7/KKhOP7EzMSBE710ksDVDN4Lgkslv6564Ji42CdsAh7GIRZYFjweiNi6s94lxrGM
         cLQ5YDIpyN/05WWwEcb+9f8I1gn6mRozlPH1UblRE+2lLasUAzj27BMBErdvWMULDo
         xfzs1E7npZvqg==
Received: by mercury (Postfix, from userid 1000)
        id C3C951060908; Fri, 11 Feb 2022 19:43:53 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:43:53 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/8] power: supply: bq24190 updates + new ug3105 driver
Message-ID: <20220211184353.4x7th3lap3ik4uxf@mercury.elektranox.org>
References: <20220206183543.51200-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wfs6kuznyu4hiuvn"
Content-Disposition: inline
In-Reply-To: <20220206183543.51200-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wfs6kuznyu4hiuvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 06, 2022 at 07:35:35PM +0100, Hans de Goede wrote:
> Hi Sebastian,
>=20
> Here is v2 of the series of patches which:
>=20
> 1. Modifies power_supply_get_battery_info() to also work with non
>    of/dt device-properties
>=20
> 2. Modifies bq24190_charger to use and apply more settings returned
>    by power_supply_get_battery_info()
>=20
> 3. Adds a new driver for the ug3105 battery monitoring chip, note
>    this chip is not really a full/standalone fuel-gauge so
>    the functionality of the is limited
>=20
> The only change in v2 is using the correct "upisemi" vendor prefix in
> the new ug3105 driver.

Thanks, queued.

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
> Hans de Goede (8):
>   power: supply: core: Use fwnode_property_*() in
>     power_supply_get_battery_info()
>   power: supply: core: Add support for generic fwnodes to
>     power_supply_get_battery_info()
>   power: supply: bq24190_charger: Turn off 5V boost regulator on
>     shutdown
>   power: supply: bq24190_charger: Always call
>     power_supply_get_battery_info()
>   power: supply: bq24190_charger: Store ichg-max and vreg-max in
>     bq24190_dev_info
>   power: supply: bq24190_charger: Program charger with fwnode supplied
>     ccc_ireg and cvc_vreg
>   power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be
>     higher then the fwnode values
>   power: supply: ug3105_battery: Add driver for uPI uG3105 battery
>     monitor
>=20
>  drivers/power/supply/Kconfig             |  15 +
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/bq24190_charger.c   | 114 ++++--
>  drivers/power/supply/power_supply_core.c |  93 +++--
>  drivers/power/supply/ug3105_battery.c    | 486 +++++++++++++++++++++++
>  5 files changed, 643 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/power/supply/ug3105_battery.c
>=20
> --=20
> 2.33.1
>=20

--wfs6kuznyu4hiuvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGrmYACgkQ2O7X88g7
+prJEA//W/4CaIM9V0uzed/ANKRyfSazZrktOT1+eGRqElNNFkHOXQEq7Ji4moFa
GQ9fTlYVEtenEdd5A8Vw4NYHHUkS6s0wI++7dyFaP3g1CuFl6QpawaxRAKTRSNKA
SdoQo0sBjN+jzrLSlI81KtbLLi47en/KqnDtwyqRnhwxgHb3e8J9+it98DHCtbCD
Lmcs+Qh6ZAAHCrf08/G1dB9UdVjd8bHM0/E6Jy5Yo6hokezcJYWxOK3DKwT9YLGB
zjbrmvlA6W+HXJpEisIdrjkneIQF/oZLtatDPPnVurCSDcUlnSyVDipPjwopMdIE
3IwV93jlpMnrUVFITDxi9Ihsjl7TulO18ZJLKb+3DeV3fTbggob3+HhzIqBag5eW
JXm354jaSPaYsA4U/GzWrM00Ub1fwMG779MNKXfKpfO+kFDv+lAieckloI8tjWdf
ginSnyRk8f/UbLXOU28QeWJba2PsD/j7P3EsktbNfw6nnPPpJHVOwXbUq0Aub8Pw
ZrHqbR/B9AcZa9CIQIP4oU8WLENEQmgWOWNMUmPIB5BgUq4izyD1shF2jhRFAZ4B
kPFZjCw/1YJGaH3IxVstc7uy8MK1hUkwxe+YNVWT5HJ1wHp1QtFFGF3rF2Tuompq
4jwXs9YDPEl9xldZP+Mq9WZVkQkqIdv4AJ90ZUKHJMsLdaloxX8=
=nELZ
-----END PGP SIGNATURE-----

--wfs6kuznyu4hiuvn--
