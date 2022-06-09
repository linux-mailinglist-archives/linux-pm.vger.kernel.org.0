Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6F5454BB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiFITO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFITO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 15:14:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACC2DC204
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 12:14:57 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26EAF660174E;
        Thu,  9 Jun 2022 20:14:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802096;
        bh=+xps/8VKuhxVuPhqQ19daACJ/zrzjgWVgBLFMxeCblE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7pR8HCx1v8YTmNFpI2O45Bl6L0s/0SCSe4D/42eeyMe7Qu68v9c5KOocBlBB5JSE
         HKTaTqVSM4cuLHRE7mt2GeB1SFKWgRaZ3uLU6x1SWJ9lOm1SiM99qCGm54P3fHhhpT
         Kt3TIFkm7khsdlHMonRw1OBnaMTLU9iSq3e+5HuKmmssg5bkQcExn4X+PdsrTA9a6z
         XC1wWz1vEXocwnQiODn0KfH5++yVyhP4l8jUxkQpMrjdHgRAYYeTqgIy6bf/3hihBJ
         WAnxVoZGrBe5aW0PyEfzqz0xCODb8EM+rY/e8jiEOPcP56H6vY6Fg4xBB2zwNPR8iW
         aWCDw5/0oli/A==
Received: by mercury (Postfix, from userid 1000)
        id 1B1F810605B9; Thu,  9 Jun 2022 21:14:54 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:14:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dorian Rudolph <mail@dorianrudolph.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Fix boundary conditions in
 interpolation
Message-ID: <20220609191454.ye4de3lcki6kyf4n@mercury.elektranox.org>
References: <4ca23609-11f4-881b-6676-83ac80dff254@dorianrudolph.com>
 <CACRpkdZJV4FjgVMmRU+vr1wkcoRuMG+FS69QMC1iPTjz0qwwvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaxynkfgwoqbrorp"
Content-Disposition: inline
In-Reply-To: <CACRpkdZJV4FjgVMmRU+vr1wkcoRuMG+FS69QMC1iPTjz0qwwvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xaxynkfgwoqbrorp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 15, 2022 at 12:09:56AM +0200, Linus Walleij wrote:
> On Sat, May 14, 2022 at 5:23 PM Dorian Rudolph <mail@dorianrudolph.com> w=
rote:
>=20
> > The functions power_supply_temp2resist_simple and power_supply_ocv2cap_=
simple
> > handle boundary conditions incorrectly.
> > The change was introduced in a4585ba2050f460f749bbaf2b67bd56c41e30283
> > ("power: supply: core: Use library interpolation").
> > There are two issues: First, the lines "high =3D i - 1" and "high =3D i=
" in ocv2cap
> > have the wrong order compared to temp2resist. As a consequence, ocv2cap
> > sets high=3D-1 if ocv>table[0].ocv, which causes an out-of-bounds read.
> > Second, the logic of temp2resist is also not correct.
> > Consider the case table[] =3D {{20, 100}, {10, 80}, {0, 60}}.
> > For temp=3D5, we expect a resistance of 70% by interpolation.
> > However, temp2resist sets high=3Dlow=3D2 and returns 60.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Dorian Rudolph <mail@dorianrudolph.com>
>=20
> My arithmetics were not with me that day. I also copypasted the error :(
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Fixes: a4585ba2050f ("power: supply: core: Use library interpolation")
> Cc: stable@vger.kernel.org

Thanks, queued to power-supply's fixes branch.

-- Sebastian

--xaxynkfgwoqbrorp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiRq0ACgkQ2O7X88g7
+ppAFhAAj+9inmcwT90urAqBdNswCFizdl1FTGZ0h/VM/Uu8CWlAbs/4xBXZeOHe
Eld5mHRiqg2TBs2wJAFsliQV90uBbDDSQ5PYRHXNsDSIu0owZeY44FTwIKhhBms0
ctLDLok0+pk68o4GFn4+InbqUOCeKgz8HwccE/6M/+o2T9lZ84S3CPpyXWc14I20
l57MbIemq0DwuRtUjlbZxg4pQa6L7W6NrzAkTa6cyXNgV4XeKi2l4FzjkL0Ee0JD
OqS51iIZy8tZh0c1i1I9RNCZaqMbUZoK1vSkJG5+N5ktLpcYwCavlGGH9V+ZzgMl
r5M+I3OW2vm04vLqocXpVdPyxQOpxfFpLgk4xeNyLw9d0D9i2x6Ig0pU9wog0d0q
0JNHAWy0KCcT+BFxxzLymhRR5eL9bOL0Lu9+Uc7lRCwkV34OB7cJcaXvKfMzmg0S
IZaMzLfDxzx5g/N5UkYEvnZHw8xn50Ime4VX8vtCQd1MKPHiUvQbuP72OAzKTsGb
Y0N/XOXz+BVdS8A/PK+1TmoSX+88xHu2Ul0OEkesD96O0IYiyPgFcy3t24olts7Z
K9NQ0a9YIyi+6UZVbKOhHSvvt7lSkpo+1u0NerHa3dcP3ytjjYiBPH6W4tA1kaC7
Nq8W1bfIOMNmPnBZpjfaXAg9jiyfMy62N047nE7sLRik41Nz/fc=
=auKc
-----END PGP SIGNATURE-----

--xaxynkfgwoqbrorp--
