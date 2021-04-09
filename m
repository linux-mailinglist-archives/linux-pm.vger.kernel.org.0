Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7C35A033
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDINnc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 09:43:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhDINnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 09:43:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 86B221F467A1
Received: by earth.universe (Postfix, from userid 1000)
        id 613083C0C96; Fri,  9 Apr 2021 15:43:15 +0200 (CEST)
Date:   Fri, 9 Apr 2021 15:43:15 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCHv2 35/38] dt-bindings: power: supply: ab8500: Convert to
 DT schema format
Message-ID: <20210409134315.tjgd7nvpo4tru2oo@earth.universe>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-36-sebastian.reichel@collabora.com>
 <CACRpkdZerDHY0EsZxqadbbWaCCjw7nkOE8VOGPhoL-Rjwp4Bhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ohqhuaygyq2szeg"
Content-Disposition: inline
In-Reply-To: <CACRpkdZerDHY0EsZxqadbbWaCCjw7nkOE8VOGPhoL-Rjwp4Bhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6ohqhuaygyq2szeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, Apr 09, 2021 at 01:28:05AM +0200, Linus Walleij wrote:
> On Wed, Mar 17, 2021 at 2:51 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
>=20
> > Convert the binding to DT schema format.
> >
> > Note: The battery node does not have a compatible value and needs
> > to be described from the binding file for the PMIC. That has not
> > yet been converted, so I kept the information in plaintext for now.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Thanks for doing this Sebastian:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks (I already merged this, though).

> Long term I want to get rid of the "charging algorithm" device node,
> as can be easily seen that is not a real hardware device but just
> some mockery to get a platform device up and probed. It is actually
> a library. But for now we need to keep it around.

Yes, the ab8500 charging algorithm obviously does not describe
hardware and should go away, just as charger-manager driver.
Optimally power-supply would provide a framework for this.

The battery node on the other hand does describe hardware (the raw
battery cells) and we have a common binding for this nowadays:

Documentation/devicetree/bindings/power/supply/battery.yaml

(At the moment it has neither properties for the chemistry nor
for temperature sensor position)

-- Sebastian

--6ohqhuaygyq2szeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBwWeoACgkQ2O7X88g7
+pryfBAAlLZTxzPZTIprclehAIr7GtqVvIw4jYjbGiwvJHAUaNLHhI47YFtEajlh
7ArUmph2VE3VtQcCUgDti/xcJLKWQQX8WsB11K4DjnAFgX5uZwcXmTmHxUhB2WS0
4Eloa35jMNdQZEsMM8vNroVTy71XQtxmPJZqBTjSsfpP6SPNoEZwhusF7j9E+Y51
eYLnDnXrs9Pof+WW9bkVR0Ub5WB9CU6rDYq1DzfZ46rtZu29Fj63bhj+A1OXJonO
fNtuSMMzM/aBkZeXA1n5Gp4B4c61IHNfjSiJYJD/QdQK0CaaGQOyLMb1bn6BfYG/
HZJx8/n7VbnrIa+W8Meb1lgXqVZ1p3cLcHn2apWTdo5XfzVrJEKHogBFINFRZhFu
UIsNHMUP4mLJUj8R0SM5SBCKKjV/+hvyO9tMQ1cpktJkdBD4vIohcEh8B9JWtVqv
hK4iVugySBaaNENIu9KQMMK4Y+2tTBUsO2qrkenq8CvzLbARWKTJJ/bj8WFZys+K
KNmaQIPIEnC16QIQukTY0RtwWFtZf9s2C5ukAskm0t91AAwlqNfeF6i5YM+RrIEg
3gBiJHK87nwRXu5JvxFAiVKu39+etfahVxLP30xzcazxtweB/5c4vxjwo8xyacgN
iVeM+YEseTkGipuiLGVBRQmA7jyuCng0zltG/C2eIgGs1cxNCKo=
=6v6Y
-----END PGP SIGNATURE-----

--6ohqhuaygyq2szeg--
