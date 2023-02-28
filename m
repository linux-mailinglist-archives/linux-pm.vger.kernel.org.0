Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828716A502F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 01:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1Afm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 19:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB1Afl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 19:35:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0013624115;
        Mon, 27 Feb 2023 16:35:39 -0800 (PST)
Received: from mercury (unknown [185.209.196.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5FC726602E18;
        Tue, 28 Feb 2023 00:35:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677544538;
        bh=ckKngwgDm1uv8o/2VUrBVKZtDUgdeeUGANto7j4O6RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRxvhtrrkkAHy3EyOiiCZLFGHF/ger7GDuKxPPA87MqSJcVkLHoJzuupigQ63AGy8
         RcuB5ALiuX1bM01VOrqLDxZnd6B34eznt3WYf/x8FSuxrLBbJ60zB0OADdUMZl6FuX
         iz/BnLeJCdWSAYXTuVfUca+7lKFGx+xUFm9KX41vkxMyUxTk209si2/6fveClr4Y3B
         ECRHP54xCVT+S9YKxCeT6dZC+vyoL5hhX/emnagJtTHoGzm6lvgMGK6Lx6u90coDNi
         ogrw5TVvF2quUn9ByzjQPsnZh3UpXOWtyKllTgqMxCLWLU1i516zxMhPIw8ZaeQJHL
         vu0whEx0Y22cg==
Received: by mercury (Postfix, from userid 1000)
        id 0EA331061609; Tue, 28 Feb 2023 01:35:36 +0100 (CET)
Date:   Tue, 28 Feb 2023 01:35:36 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] power: reset: linkstation-poweroff: add LS220D/E
Message-ID: <20230228003536.lbpopfipujwush6c@mercury.elektranox.org>
References: <4927895.GXAFRqVoOG@tool>
 <20230213202542.aqsw6tzspo4nrq7n@mercury.elektranox.org>
 <CABwr4_sd-kzg90VrQQOw91XsTXOcMq6qkj=TNPy6YQDuA6QQuQ@mail.gmail.com>
 <20230213212200.fgtcfm333aunrxqo@mercury.elektranox.org>
 <CABwr4_vKxWKJsNDVF9yNeSSk4R3nDov-+qY5=nhp4ggr88EpAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrxfp7tynhnaqyvn"
Content-Disposition: inline
In-Reply-To: <CABwr4_vKxWKJsNDVF9yNeSSk4R3nDov-+qY5=nhp4ggr88EpAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mrxfp7tynhnaqyvn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 27, 2023 at 09:17:39PM +0100, Daniel Gonz=E1lez Cabanelas wrote:
> El lun, 13 feb 2023 a las 22:22, Sebastian Reichel
> (<sebastian.reichel@collabora.com>) escribi=F3:
> > [+cc DT binding people]
> >
> > Hi,
> >
> > On Mon, Feb 13, 2023 at 09:38:24PM +0100, Daniel Gonz=E1lez Cabanelas w=
rote:
> > > > >  static const struct of_device_id ls_poweroff_of_match[] =3D {
> > > > > +     { .compatible =3D "buffalo,ls220d",
> > > > > +       .data =3D &linkstation_power_off_cfg,
> > > > > +     },
> > > > > +     { .compatible =3D "buffalo,ls220de",
> > > > > +       .data =3D &linkstation_power_off_cfg,
> > > > > +     },
> > > > >       { .compatible =3D "buffalo,ls421d",
> > > > >         .data =3D &linkstation_power_off_cfg,
> > > > >       },
> > > >
> > > > Where is the patch adding these compatibles to the DT binding
> > > > documentation?
> > >
> > > There is no DT binding at all. So no documentation.
> >
> > You are referencing a compatible, so there is supposed to be
> > a DT binding for it. Note, that you also need DT bindings for
> > board level compatible values. See for example:
> >
> > Documentation/devicetree/bindings/arm/rockchip.yaml
> > Documentation/devicetree/bindings/arm/fsl.yaml
>=20
> Since the driver uses the root compatible string, I don't see any
> binding to document at least for the driver itself. Nor I don't see
> where a reference for this driver should be put if I documented the
> board compatible strings.

You should document the board compatible string for the board
(ignoring this driver). Actually that should have happened
before the board DT has been merged in the first place. Note,
that the examples I provided above are for boards.

Since you are only referencing the root compatible string, we
are good to go afterwards from DT perspective.

-- Sebastian

--mrxfp7tynhnaqyvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP9TFQACgkQ2O7X88g7
+ppYXhAAh5sN4p1ltqUgfyhuFRhOplD9tIPF+0B658hrc7xAKWH/k9w0YcxML3kF
avgcw5R9wE6iWBviWMg8N3StjkJuOIJV8QR1Q3KcigT5gJkl5zy3k3xG40/K2swU
2G+pAwwawNN+RAWFE6X4grJTxdnu+UDZyVLaE4Pxb5gtozRG59VVHFnwih/FKaUZ
VyhUz5Q1BUBYP/xqSgCDjtAHxdAS/+ehC/eMCb6uKKT4Py1SgfaK7QDDaCucyZtM
qWq5DG24BZE8N2G2OdE3/DkwZGSgBKd8VMxpCfQRK4qy72yaJC1vSzIJJVI/DYqB
KpkKsfatmR8Gkst/6KXeZXzFAGMH2SiWoIo8u2TAY/UV6sf69UqVQvLbnvJEDeGG
A6c+Oyesap5I1lh+3bnBQ1cAEJdS17v2mcrgibqWUGvPCscky+Nsc8m7bCwQjqTC
iblJZlOLlb7uYkEqGxpf2yOord4/19lY4FuVNkeSjlip+f4f0Q7WJQAL5OPg44vg
fqnZM16AwRIYv4Rqq3xN7JggTDExo0CJwuCE4K6NIiLF3hCR6YpncbQqtGkCMdP8
jgysfJckax2gFDK1UrvGWK8yrwNFTXkqOGyeYBOvIwYAT3ig08N391tl8CkhXg9/
rBUPAcX2IbPbynRNSGFmhBxBLSPb1jnP545Efj7lfzmNDF8WZ1I=
=Dly7
-----END PGP SIGNATURE-----

--mrxfp7tynhnaqyvn--
