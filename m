Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8394113CE4D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgAOUwV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgAOUwV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jan 2020 15:52:21 -0500
Received: from earth.universe (dyndsl-095-033-170-011.ewe-ip-backbone.de [95.33.170.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1AE2077B;
        Wed, 15 Jan 2020 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579121540;
        bh=YAMT4GqllrslSkD9BR0wa3v1n8fnVFdaxgMWcQCGiFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KR2jHDWtMzKMC7+luRtgc6uzI7E6RL2RYXkwvgtrQ/OrPejSuosrT52kbz/rj3h7x
         H9tGv4hgT3iLXADTCVU2fbGkm4lfGc7FrLM7D2TM9dT8btIuWYCs5MAzLvx99Ddg0N
         MfRSPDhyfWchBxm2p04Pi62WjWw3G2SuLTo4yUw8=
Received: by earth.universe (Postfix, from userid 1000)
        id 8BE583C0C7C; Wed, 15 Jan 2020 21:52:18 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:52:18 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] at91-sama5d2_shdwc shutdown controller
Message-ID: <20200115205218.wudf5dai2sj6pvvk@earth.universe>
References: <1576855878-13213-1-git-send-email-claudiu.beznea@microchip.com>
 <3d0c5a04-25fb-5ae6-fd3a-4049e293eab1@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yd3evbzfobjk36fk"
Content-Disposition: inline
In-Reply-To: <3d0c5a04-25fb-5ae6-fd3a-4049e293eab1@microchip.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yd3evbzfobjk36fk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

It wasn't lost, I just did not yet collect patches for the next
merge window. I queued the complete patchset to my for-next branch
now.

-- Sebastian

On Tue, Jan 14, 2020 at 10:34:55AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Sebastian,
>=20
> I know you may busy, I just want to be sure that you didn't forgot this s=
eries.
>=20
> Thank you,
> Claudiu Beznea
>=20
> On 20.12.2019 17:31, Claudiu Beznea wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > PMC master clock register offset is different b/w sam9x60 and
> > other SoCs. Since there is a need of this register offset in
> > shutdown procedure we need to have it per SoC. This is what
> > this series does.
> >=20
> > Changes in v2:
> > - do not use r5 as intermediary registers in at91_poweroff
> >=20
> > Claudiu Beznea (2):
> >   power: reset: at91-poweroff: introduce struct shdwc_reg_config
> >   power: reset: at91-poweroff: use proper master clock register offset
> >=20
> >  drivers/power/reset/at91-sama5d2_shdwc.c | 72 +++++++++++++++++++++---=
--------
> >  1 file changed, 47 insertions(+), 25 deletions(-)
> >=20
> > --
> > 2.7.4
> >=20
> >=20

--yd3evbzfobjk36fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4fe4IACgkQ2O7X88g7
+pop7w//bJTENOImq1Uw2WD17tRxI1UogZR6C7G3iQuBCimiyvw+QTNFwOzSmIkp
P6zhrTeWBvyfYHWOFGynGfA99ISNYf8Ok3mFxLI7ov44JIHJkSoHOcIW6OFjloDz
0G9Udiz88HCZ11gPIidfmhCdS5dLXmic0XCC/C1wiaVs1taJ358wQMStq5c4S7CE
7E+sM/TUvC4/Zx9g3zrW/bitFaqbWVPk80V3odBhl9FFh8i640xbiU+U8uQ/Leak
+J6K/BqO1uI2CVwU9d+NaADCUjSzQJelWM06PG21OkaFq8VFeFiRyxOtvStmQpDd
BXByY4HxHPlGdvhVwSE1+VBSxK+r+NbN3MESBK4rE9jisfPvxvWK8osx8jmoivDM
2VAHluRnUI4OS5Ab/HyxwcecX8tczdrTkmgCvK+EYthhqHZx5GPAKz2k4/qKq6Jo
6+SLbKg2l2tT7vxR+dGLRD4uie8QtQvxHwIReCT1oLXB3qDoWMRc7iqfx5TOQpm6
hYDjshmM2FhqU9+zJpxwXUC1KZUkiccvRpAPPfCyGN9vOEeaD2PLRRTGFrKBGTOd
sA0uh55hfIlwWVh/qNBL6CQs58VeHUgznbDX1C8B9zX3QGmEX0grP7n/Z933d8ZC
o/glSnVJ/+r0L0goB5p+J1PEv7WLs6jbplZXlngyP12Dg4+KZGw=
=F7P+
-----END PGP SIGNATURE-----

--yd3evbzfobjk36fk--
