Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68A422C5B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhJEPZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 11:25:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhJEPZY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 11:25:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9AAA41F42D67
Received: by earth.universe (Postfix, from userid 1000)
        id DA4A33C0CA7; Tue,  5 Oct 2021 17:23:23 +0200 (CEST)
Date:   Tue, 5 Oct 2021 17:23:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: power: Bindings for Samsung batteries
Message-ID: <20211005152323.kyxzytgmj2kfegwd@earth.universe>
References: <20210806090050.3510671-1-linus.walleij@linaro.org>
 <CACRpkdbdgdpg7CNQ+s4SkJBOsWfuOOWmXTar+cx2Eu_Wt5qNfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajsvss6txycmr5om"
Content-Disposition: inline
In-Reply-To: <CACRpkdbdgdpg7CNQ+s4SkJBOsWfuOOWmXTar+cx2Eu_Wt5qNfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ajsvss6txycmr5om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 29, 2021 at 09:09:47PM +0200, Linus Walleij wrote:
> On Fri, Aug 6, 2021 at 11:02 AM Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> > This adds device tree bindings for Samsung SDI batteries.
> > Everything can be determined from the product number so the entire
> > battery is just a specific compatible string.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Sebastian: can this be merged? I am working on corresponding code
> for Linux to populate Samsung batteries from compatible.

Thanks, queued.

-- Sebastian

--ajsvss6txycmr5om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFcbeYACgkQ2O7X88g7
+pqtAg/+Id3bovx0nIoDu8y+vWG0FkDe/f5Umy/tlsu+a2uk/VVvq7OibuJXKskI
czGmbl/touUa+vN86XyeDtZOWkfPBX+FjzaI8ywyc/pI5ZemHBLZzkdV3T8OmlQn
DjiGD25dchFjVAF4usgQPVn7rw1bgH97R6c1xKVj4/dQqG5hAMy58YsJek43Bhcz
sEr/q6XH2ZggV7x4PmvJty2gZdcpGYexykTARYcdvxiYfg48C1ptiUlyLXHnWgDy
OFFtVKtEYW+Bh7V5HIPklG4yVf/KmVQzlwmO0T88TE0rns24XiHI++wxLh3GYfpx
D0eVVWhfYeyTOL1IoxpgF4YPQ5nuPwZ5HnkI9BgGfaDw1hCT/dkAJfcYJ4VRmAHj
X11+QLOy8YdDPd3hobfNxaJRZ0QzCBW4qBpYJ+hu2xCsvL5dlchxsC3MEoez3RnV
UolSAR+bao8Rer07+qj9pfDj7AnKrNY0YjCGz23JdKqk5xFRA8eJkXsMwLvAp4wQ
jOhE3Rj3dS6fNVEXRH5l8pMlGfFOcmRCvdn5EbWRdf34kL2Lb6GdTKisGYm8s0fO
xv5Sss5Oqqr4FmLTmxU7HLSdJelOZB/5L0afktxbV/RFaTb6CoRKJCquwUdASpT2
xsbYaJWzmLP9Bu9PX14LI1ux5rRACtarVUjSGzsU2tVKYjX0zMM=
=vwPQ
-----END PGP SIGNATURE-----

--ajsvss6txycmr5om--
