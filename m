Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962B8123C8
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEBVBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 17:01:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42512 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 17:01:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 815DC2804F8
Received: by earth.universe (Postfix, from userid 1000)
        id C4E233C0D1B; Thu,  2 May 2019 23:01:38 +0200 (CEST)
Date:   Thu, 2 May 2019 23:01:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
Message-ID: <20190502210138.ekrjvg4jex5x2tbo@earth.universe>
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
 <20190416071941.GB14538@amd>
 <8d1f70a7-46d6-f278-f58c-6a7e7a644d46@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwdv5qwmkpp26lsd"
Content-Disposition: inline
In-Reply-To: <8d1f70a7-46d6-f278-f58c-6a7e7a644d46@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vwdv5qwmkpp26lsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2019 at 10:42:30AM +0200, Enric Balletbo i Serra wrote:
> On 16/4/19 9:19, Pavel Machek wrote:
> >> This patch exposes a new property, similar to input current limit, to
> >> re-configure the maximum voltage from the external supply at runtime
> >> based on system-level knowledge or user input.
> >=20
> > Well, and I suspect it should expose input power limit, not input
> > voltage limit.
>=20
> Oh, ok, I thought we were agree that input voltage had sense after had so=
me
> discussion in v3. Seems that no, let me try to give you another example...
>=20
> > DC-DC convertor efficiency normally does not much depend on input
> > voltage....
>=20
> As we said we have a heat "problem" due the internal voltage conversions.
>=20
> Lets assume you have a linear regulator instead with a Vin range from 5V =
to 9V
> and we want an output of 3.3V/1A
>
> For 9V:
>  Input power : P(in) =3D 9V x 1A =3D 9W
>  Output power: P(out) =3D 3.3V x 1A =3D 3.3W
>  Regulator power dissipated: P(reg) =3D P(in) - P(out) =3D 9W - 3.3W =3D =
5.7W
>=20
> For 5V:
>  Input power : P(in) =3D 5V x 1A =3D 5W
>  Output power: P(out) =3D 3.3V x 1A =3D 3.3W
>  Regulator power dissipated: P(reg) =3D P(in) - P(out) =3D 5W - 3.3W =3D =
1,7W
>=20
> In the first case the regulator needs to dissipate more power, hence the
> temperature is greater than the second case.

I would be surprised, if a linear regulator is being used in this
place :) That would basically render functionality of higher voltage
completley useless and a good reason to always limit to 5V. For the
generic case I agree with Pavel, that control over the power (voltage
* current) is the better choice. Still I believe it makes sense to
have a control knob for the voltage available, since some hardware
designs suck.

For example the bad hardware design might be the remote side,
that has issues providing some voltages and this would make it
possible to debug that.

-- Sebastian

--vwdv5qwmkpp26lsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzLWq0ACgkQ2O7X88g7
+pqzKhAAk5VXBCW5KI1uBgScQTbWw/6eWgTGX9m/vUX5YVUhvRBfVg0h4l6HmOJl
bbg71lCAGtp0xS0h9YPxuU1MrrLW/HlnbSdz69/WB6zPeKbYx3Wn4v/3M1UnbcCf
HE0svSdJhyFY0Iyo7g3VMiJRjDesw1ceUoVHDSD092o/H4PECMuFFqqFnCes4j3X
Fgaztk2H6EEpuJ7cmov/266hmL59SsDBx05O0Zk2ezVku1eoYh4BHS1stt3jMOZj
xbTo7Meq0oIra6EpB1jdKh7DAkwRNkaChlLuXJdZZ6VkmULCQtQ6K91/mG3qg9rR
MEbPJDGuzbB+zqYoCLVHEc7ykhgxiAuWoXTe9NB9rR9JfQATtworXuUg3M715/Id
D52e7xbLMR1CGxPKeybUmg+oJE6dUDnGSwRHnTFOL222hmE5hvEXI8i0dNUV0dqQ
s2aqeMaagd10jWmdDazKYGC6xGj616XqNABKwo0QzKaWprhhtF6qE5/EyBtywECX
4V3KoF3H9a/47hj9dXEy3BHsqHE4j9vfUuT5GxTHtDaEYiR+ZmOamixd6m3jrkL6
zc6dNZV5Sa1I39Ofi4F/Wu+ds2kP3Akm8HlvAzic4i7CjeYbcTuP9WuPvtZ5Lt/U
x6zMXiOOMlghHzwmbrFkn9DRSot0Pk00QBFFU5F4HEm89utFRHE=
=wEeJ
-----END PGP SIGNATURE-----

--vwdv5qwmkpp26lsd--
