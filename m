Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC66952F4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBMVWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 16:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMVWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 16:22:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B269C1CF71;
        Mon, 13 Feb 2023 13:22:04 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7755F66018CF;
        Mon, 13 Feb 2023 21:22:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676323323;
        bh=V3oCYb7iJAqfIMEu7bB0QT2oRO87zVlxv7V77Q7aGGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkHAdDVdYtd8qok49XV7vsqTEe/IFSCpYtIXIqn7bx2kFBuFGgSm3911r5F+H7UcD
         DrR4qSXURq+pSq8ymKZxruxQ9qn3kTOJ7hf9+YX9hR387UI9Hr8CiLjhf8or2DgeLm
         XE/Z7tho/khSDKwFK9WgfaL8w5ww6ocR4aaEQ1GHq4G1nt+a+m56pl6gWUw6N1ledx
         bISQq1n/oRkfomI0EwR3t+/W7D+yZsPwKlWkuWtoV8e4cNNSML0+sEFNmqA9i1UbYZ
         Mg9sYEGDqqYE+eqHGb5gZyW/njFG9UhCULlSj2a4FuD/AevKI67/mUnRPITvS5EYc0
         Q7L1iLIK1+YMA==
Received: by mercury (Postfix, from userid 1000)
        id 5110810603FE; Mon, 13 Feb 2023 22:22:00 +0100 (CET)
Date:   Mon, 13 Feb 2023 22:22:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
Message-ID: <20230213212200.fgtcfm333aunrxqo@mercury.elektranox.org>
References: <4927895.GXAFRqVoOG@tool>
 <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
 <CABwr4_sd-kzg90VrQQOw91XsTXOcMq6qkj=TNPy6YQDuA6QQuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucpbk6tv6e7m6c6q"
Content-Disposition: inline
In-Reply-To: <CABwr4_sd-kzg90VrQQOw91XsTXOcMq6qkj=TNPy6YQDuA6QQuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ucpbk6tv6e7m6c6q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc DT binding people]

Hi,

On Mon, Feb 13, 2023 at 09:38:24PM +0100, Daniel Gonz=E1lez Cabanelas wrote:
> > >  static const struct of_device_id ls_poweroff_of_match[] =3D {
> > > +     { .compatible =3D "buffalo,ls220d",
> > > +       .data =3D &linkstation_power_off_cfg,
> > > +     },
> > > +     { .compatible =3D "buffalo,ls220de",
> > > +       .data =3D &linkstation_power_off_cfg,
> > > +     },
> > >       { .compatible =3D "buffalo,ls421d",
> > >         .data =3D &linkstation_power_off_cfg,
> > >       },
> >
> > Where is the patch adding these compatibles to the DT binding
> > documentation?
>=20
> There is no DT binding at all. So no documentation.

You are referencing a compatible, so there is supposed to be
a DT binding for it. Note, that you also need DT bindings for
board level compatible values. See for example:

Documentation/devicetree/bindings/arm/rockchip.yaml
Documentation/devicetree/bindings/arm/fsl.yaml

-- Sebastian

--ucpbk6tv6e7m6c6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqqfUACgkQ2O7X88g7
+praABAAitmjw+F3ZhPPmyiVOofVoNYXBBqmO4lS8IZXd+Hi/5bYfSB40l1hDfn0
WoK4pKVb4d+s6hoEKf2e5hpL/eUk4nOFZHqNoJowQaRPJreUcjmdmUN2s66uo7Ky
z72510IDt4tFmuHa9GnyK8dkbb0KUtwkAgk/7PwYCRmzuJT83tKTcX38u2pokU11
F+6GnpI0I01wv7ye88YVIx5HIdo+ZQ73BdqcNsQ2mZGFJmZMizfm4dmaGhsY6unt
uICW5VpqPWUT/np0+mMNgeVTmIVvhZ+kXZFkyp/hmt3IWPZf9o+JHq+OofQ1PfTl
AdIVYkXNHI7UVT4VC4lQHMIsxs1gfhg5WQCIxLar7AmZVUn0t1wnc2KUHiQaQVop
es4mWFxCh9SCSZvss8DTRNYZDVifVmKKe/6HHWRGadEkKWBix21XSo1BrYS8ZrZV
S4ekoCfuQjiFh8/NFlvxQtHfWOJGkVNW3E5Cmlo2nKFCbCsg/A9rWz8VOTyDrSUN
hte/Hq6DJ5Wn7vgYQewxcil2wfNHFe28vFQpWa1XjPr0JrhBNSq55mRkE2SWqCPm
N8a2zT/8C9RFsNxjmm25p7EmUG82xED4O/9cuIhjNNp5YVaIu3NGNha0GMN366lI
ohtADW6qqO34ltTorjEPpfHp3+/f0PdmXQ7D4p5uZUiFntFBalg=
=cM/0
-----END PGP SIGNATURE-----

--ucpbk6tv6e7m6c6q--
