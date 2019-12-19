Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC212679B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSRE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:04:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSRE3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:04:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 63C77292B37
Received: by earth.universe (Postfix, from userid 1000)
        id CCDED3C0C7B; Thu, 19 Dec 2019 18:04:24 +0100 (CET)
Date:   Thu, 19 Dec 2019 18:04:24 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] at91-sama5d2_shdwc shutdown controller
Message-ID: <20191219170424.lx42pzdysqjwzoal@earth.universe>
References: <1576765674-22070-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cbfgrqhlxasynysk"
Content-Disposition: inline
In-Reply-To: <1576765674-22070-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cbfgrqhlxasynysk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 19, 2019 at 04:27:52PM +0200, Claudiu Beznea wrote:
> PMC master clock register offset is different b/w sam9x60 and
> other SoCs. Since there is a need of this register offset in
> shutdown procedure we need to have it per SoC. This is what
> this series does.

Patches look good to me, but I will wait a bit to give Nicolas
and Alexandre a chance to review/test the changes.

-- Sebastian

> Claudiu Beznea (2):
>   power: reset: at91-sama5d2_shdwc: introduce struct shdwc_reg_config
>   power: reset: at91-sama5d2_shdwc: use proper master clock register
>     offset
>=20
>  drivers/power/reset/at91-sama5d2_shdwc.c | 75 +++++++++++++++++++++-----=
------
>  1 file changed, 49 insertions(+), 26 deletions(-)
>=20
> --=20
> 2.7.4
>=20

--cbfgrqhlxasynysk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl37rZIACgkQ2O7X88g7
+ppKTQ//WW4FUtcXIE3pmAzAQCHDm6oLLp1IgXG6CBKRP9apk/d5HxS1lDCRwC7M
lK2MQp23XVxO6dhUTrAaC51//Esv4qrouga7pdnQT1ruYXGuCP9YivvENv4WZYQK
qLpFCFeK853DKEbh6R/vqWAhTxcZeeFLjs51DpCFDNGGBP6A09CvrvodAaAf/NBH
NteprA/W29YjYoo1WImBALdgiaB2kMH9dzXTJhRHjvEjkMCg+KNe9GC0A8t5n5TK
0UXa7NxJIun5ISzJKzZYFF4qxAlDE7cY2mfBA2YKsL/UdE2CaM/k4gGB55eMv5Q4
m6h836d5Ypq6Xt1P3cQgB8wr4r+p4W5oxA7dosSTx487H7QRcrSUkZ4vhBp8/d5O
kL0vuD8qdViMyVE9klommHijvKTxdZdKxG2bxZxMUljyhjmlEAs8bQule/Og2Xzp
NqubWnlofcOyGZpSiBIvPfzfaWmRsZdWByxTnXl9Im5NUIivQOMkpeP48lVCNPa3
KMWGHIvUxfNvVL6dEuh73O2FXctutcmt9xYKlyl0V5p+mhQRyKWR5nSiAnEUBV2p
uLanxn+IitxK7tLZ5n6DEjQmGk1g8vxAoA7h36sjhK6Vt7M6ruZI5EE8O2rfwbmb
j4DKfsU8zxj8hyHKFIbkrMsJJNZuAZmStjY36J5M8Cpzbc+vRUI=
=Rjmv
-----END PGP SIGNATURE-----

--cbfgrqhlxasynysk--
