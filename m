Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA46639E39
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiK0XaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 18:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0XaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 18:30:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D5C77B
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 15:30:06 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 705E0660296C;
        Sun, 27 Nov 2022 23:30:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669591805;
        bh=BJ7P/p3AWmF64cl5cVl5CD0Z6xsxMD0Qg6lCsqgdHDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxJvjUgtsNOxrzsT48/rSgn0Id05dyt4NzPEEkhmJL8KARa7izPz3qmYXfqV1Kkt0
         NNxqTu8S0xPWnFMV0Onkms2iPeKAU+nbxXnpSuPmGj6nZdGnTRsDyzkIEu2OoUZUTb
         iRACz1yKgSfjthH1jGcGvXWUmQB7oSuxT6rUemzAkXA5Wh0gU7qk1OfPD6xayqtrst
         2BH42Gj+P+wxjX+zy8CeuPsyGUN8O69SX57tYRPF3SxEUPiLFZyifPnJ101mHHzCQE
         eCLkN4VMaFKbyGVNWROeKzPzaetWMdRVk+TQGxciddDjFnajabqdJdpj9hUgZSohRN
         vnl2lASdkvCJg==
Received: by mercury (Postfix, from userid 1000)
        id 70FE11060B70; Mon, 28 Nov 2022 00:30:03 +0100 (CET)
Date:   Mon, 28 Nov 2022 00:30:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/10] power: supply: bq25890: Only use
 pdata->regulator_init_data for vbus
Message-ID: <20221127233003.cbiw3bqb6dmfkfhx@mercury.elektranox.org>
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-2-hdegoede@redhat.com>
 <4c28094a-de79-cdaf-9449-eddd5039a004@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmyr3bt5ljsth7zi"
Content-Disposition: inline
In-Reply-To: <4c28094a-de79-cdaf-9449-eddd5039a004@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mmyr3bt5ljsth7zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 27, 2022 at 10:16:20PM +0100, Marek Vasut wrote:
> On 11/27/22 19:02, Hans de Goede wrote:
> > bq25890_platform_data.regulator_init_data is intended to only provide
> > regulator init_data for the vbus regulator.
> >=20
> > Remove this from the regulator_config before registering the vsys
> > regulator. Otherwise the regulator_register() call for vsys will fail
> > because it tries to register duplicate consumer_dev_name + supply
> > names from init_data->consumer_supplies[], leading to the entire
> > probe of the bq25890 driver failing:
> >=20
> > [   32.017501] bq25890-charger i2c-bq25892_main: Failed to set supply v=
bus
> > [   32.017525] bq25890-charger i2c-bq25892_main: error -EBUSY: register=
ing vsys regulator
> > [   32.124978] bq25890-charger: probe of i2c-bq25892_main failed with e=
rror -16
> >=20
> > Fixes: 14a3d159abf8 ("power: supply: bq25890: Add Vsys regulator")
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks, queued.

-- Sebastian

--mmyr3bt5ljsth7zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOD8tIACgkQ2O7X88g7
+pqZJg/9FtRsXxnMmsWy5fb+2bQCaGVXpZdeHJLoaB5k4W8WM1nb2XMYEGx2ptHX
uBE3fIm8GV4zYcVfCj699j+B9ie9DX7WSi6xcrqpgkbWG0S3yxMvkzDYtqIt4dIC
DRcIy6JXDbBWjzu5So6HfqucUw5xpe5Rf62lEOOdVsxjWDzqtNH4jIrAMxoxl5W3
4v8adzcWRcaC/IhRFxhFrb+yTNbnHKV4eKd0ktL6oALk0gGqNyL5k5uKGydLAgAR
0qUXfrMF/2WvugQojWmDF6HEBND57WMhL4EaPKV+e3mjm+f+dsr9sW9k8c3mlSP4
XUV7qC3YeuiZ5bS8o3K76wBE2XEHrzWdMWnqs8nnfb/J4juQZ600QICdTH2lxS/F
33QVvJOEHCmCVJz8u+jfP2pLbk+hDebR8TMvqKtt0O0+tlbr0ZVP2+5YO//qizzz
etzT1/+LU9FVmsmY3WwXPOWh/524CiSuqKC/D8qt1Byz3yPsX2xJVPwC6sveDrzX
++wuC9Iw/xU/lyp9fxC04DtI4lzkrvxPn+mQlWZ9x2R/k5Tw9/7vhH+qiIOODkZe
pBn1GjxPWF735BXGzxqLgtUGsh0VBccB1zLUxU5dCxO5OmWkD8UYyxPUM6UoE4xz
6eTYVpH8EqgW/Q+cnsijbUIgAJOOR8cushDrky4YBfSOYVeB1RY=
=lPVx
-----END PGP SIGNATURE-----

--mmyr3bt5ljsth7zi--
