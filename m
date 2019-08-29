Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFEA1B0E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2NL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 09:11:28 -0400
Received: from sauhun.de ([88.99.104.3]:38986 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfH2NL2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Aug 2019 09:11:28 -0400
Received: from localhost (p54B33070.dip0.t-ipconnect.de [84.179.48.112])
        by pokefinder.org (Postfix) with ESMTPSA id C78242C001C;
        Thu, 29 Aug 2019 15:11:24 +0200 (CEST)
Date:   Thu, 29 Aug 2019 15:11:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Zhang Rui <rui.zhang@intel.com>, Simon Horman <horms@verge.net.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nathan Huckleberry <nhuck@google.com>, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
Message-ID: <20190829131124.GA2437@kunai>
References: <20190613211228.34092-1-nhuck@google.com>
 <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
 <82458318837ed1154a183be0b96337fc7809c645.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <82458318837ed1154a183be0b96337fc7809c645.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 04:52:20PM +0800, Zhang Rui wrote:
> On Fri, 2019-06-14 at 12:52 +0200, Daniel Lezcano wrote:
> > Hi Nathan,
> >=20
> > On 13/06/2019 23:12, Nathan Huckleberry wrote:
> > > Clang produces the following warning
> > >=20
> > > vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a
> > > negative
> > > signed value is undefined [-Wshift-negative-value] / (ptat[0] -
> > > ptat[2])) +
> > > FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~
> > > drivers/thermal/rcar_gen3_thermal.c:126:29
> > > note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x)
> > > <<
> > > FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18:
> > > warning:
> > > shifting a negative signed value is undefined [-Wshift-negative-
> > > value]
> > > tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> > >=20
> > > Upon further investigating it looks like there is no real reason
> > > for
> > > TJ_3 to be -41. Usages subtract -41, code would be cleaner to just
> > > add.
> >=20
> > All the code seems broken regarding the negative value shifting as
> > the
> > macros pass an integer:
> >=20
> > eg.
> >         tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> >                                  tsc->tj_t - FIXPT_INT(ths_tj_1));
> >=20
> > thcode[1] is always < than thcode[0],
> >=20
> > thcode[1] - thcode[0] < 0
> >=20
> > FIXPT_INT(thcode[1] - thcode[0]) is undefined
> >=20
> >=20
> > Is it done on purpose FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]) ?
> >=20
> > Try developing the macro with the coef.a2 computation ...
> >=20
> > The code quality of this driver could be better, it deserves a rework
> > IMHO ...
> >=20
> > I suggest to revert:
> >=20
> > 4eb39f79ef443fa566d36bd43f1f578d5c140305
> > bdc4480a669d476814061b4da6bb006f7048c8e5
> > 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144
> >=20
> > Rework the coefficient computation and re-introduce what was reverted
> > in
> > a nicer way.
>=20
> Sounds reasonable to me.
>=20
> Yoshihiro,
> can you please clarify on this? Or else I will revert the above commits
> first?
>=20
> Also CC Wolfram Sang, the driver author.

CCing Simon Horman who worked with Kaneko-san on these changes.

> thanks,
> rui
> >=20
> >=20
> > > Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of
> > > Tj_1")
> > > Cc: clang-built-linux@googlegroups.com
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/531
> > > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > > ---
> > >  drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/rcar_gen3_thermal.c
> > > b/drivers/thermal/rcar_gen3_thermal.c
> > > index a56463308694..f4b4558c08e9 100644
> > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -131,7 +131,7 @@ static inline void
> > > rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> > >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> > > =20
> > >  /* no idea where these constants come from */
> > > -#define TJ_3 -41
> > > +#define TJ_3 41
> > > =20
> > >  static void rcar_gen3_thermal_calc_coefs(struct
> > > rcar_gen3_thermal_tsc *tsc,
> > >  					 int *ptat, const int *thcode,
> > > @@ -144,11 +144,11 @@ static void
> > > rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
> > >  	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it
> > > unscaled
> > >  	 */
> > >  	tsc->tj_t =3D (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> > > -		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> > > +		     / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
> > > =20
> > >  	tsc->coef.a1 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> > > -				 tsc->tj_t - FIXPT_INT(TJ_3));
> > > -	tsc->coef.b1 =3D FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
> > > +				 tsc->tj_t + FIXPT_INT(TJ_3));
> > > +	tsc->coef.b1 =3D FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
> > > =20
> > >  	tsc->coef.a2 =3D FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> > >  				 tsc->tj_t - FIXPT_INT(ths_tj_1));
> > >=20
> >=20
> >=20
>=20

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1nzvgACgkQFA3kzBSg
KbYx+g//f5G/Zdl+qgCmmyNNWXxl8l6bbTgwmYs9qlm05wSREnJW80SFptJOOmVX
105JuRkTrXtoUnAmCxF/Z55HYly0hG4s0HByxuALCLpb3j+rcU+G0hdXrSdNICRk
tN9HkHzYmKGszT5yaZY2EF730nUnpv71Pc4Z3wTY/H+5wz8uDv/6mW4IpcYM3Tnr
9ueuEBNYWwGiR/29dGwgaVnh0f/nIZllMEQbuYKeCxRuY58gqQFA9Ng5bEDfNFHV
qR5n9jKoQetVx3zacipFHYjwv9d1rnAfHonBmvp5FjkZ/5/U0EBhkeouPxFTIRuW
u1e2DzblJ1hGPHyVlwrl5294e9bujd6iVEMetJZnEU21n6aGb3lenQnYy6ER6cUB
J6Pg9fnwoGFYH9WUkQwQ8V1tLO1zRf2SvJexYZmQK40n/D1M5oUUqfbTBd7wwofv
WvXAkuVfACXvWiLVhOtlGGIX+C+IRlvdbl1L/12eAT2PW28k+aUzV7HHxHykfGjW
CgLj4Kli7gsQO2NF4hQcG79FZDTnx/FPYGGT0U1SUaLfBBnYMOZ6HJbko4TJmnII
FrcgDCPNHS/yGT/PcOM1XfqXwMlODu1aeneScG8bxbZT46iWRFDS7PL0zH8qrDr0
aCtkS4xv3uPyh6A9+o8Qpg/XEmoPpmZO1Z2bNR6B8wcYIuv3YDc=
=a7UP
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
