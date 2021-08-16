Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31C63EDC37
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhHPRS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 13:18:56 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:53780 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhHPRS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 13:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7uQYH/aXvbtf28rj/PHbNBpUcSyy2gaJTwpVkCfcodk=; b=Z1fgJ1H/kmGSZxB5ZFan5T3jeP
        +fyV4qCi72UUabaXm7ZYbILg79ugwNP9+jNwTfIU8K6WKGg+nusxQ6CpwVXlpuEnFuLPyKN7UGVOp
        pea/iX62tXQnWpz26oEzznXv2FNayLhohIXiBHuVylQQDzSFEvoKh+CWdygX3xj/RyHeChJI926KZ
        SW4Q7GHrveNJJJEO3NprIEt4Qnqku09G2gUNI2aVeBXYlhfifshg8y6tXFFKcBOZWT9ccQMuPj0Si
        RmA0rxrCaSTD2N4/akkiEj7Pj0GaNxCRoElJbeZ88W41RvxQNvwiEbxRd21Mz5OiaL51VNNl6Igpq
        fnyPm1zQ==;
Received: from [177.220.172.187] (port=3717 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1mFfKb-00GnpD-9M; Mon, 16 Aug 2021 13:19:21 -0300
Date:   Mon, 16 Aug 2021 13:19:19 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: bq24735: add watchdog timer delay
 support
Message-ID: <YRqQB0lL6tVv7wFa@glitch>
References: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
 <20210709142731.23418-3-bruno.meneguele@smartgreen.net>
 <20210813162914.p3mzc47ixpmdk62f@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+ovW7MO3Lc9bWcnh"
Content-Disposition: inline
In-Reply-To: <20210813162914.p3mzc47ixpmdk62f@earth.universe>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+ovW7MO3Lc9bWcnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 13, 2021 at 06:29:14PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Jul 09, 2021 at 11:27:31AM -0300, Bruno Meneguele wrote:
> > The BQ24735 charger allows the user to set the watchdog timer delay bet=
ween
> > two consecutives ChargeCurrent or ChargeVoltage command writes, if the =
IC
> > doesn't receive any command before the timeout happens, the charge is t=
urned
> > off.
> >=20
> > This patch adds the support to the user to change the default/POR value=
 with
> > four discrete values:
> >=20
> >   0 - disabled
> >   1 - enabled, 44 sec
> >   2 - enabled, 88 sec
> >   3 - enabled, 175 sec (default at POR)
> >=20
> > These are the options supported in the ChargeOptions register bits 13&1=
4.
> >=20
> > Also, this patch make one additional check when poll-interval is set by=
 the
> > user: if the interval set is greater than the WDT timeout it'll fail du=
ring
> > the probe stage, preventing the user to set non-compatible values betwe=
en
> > the two options.
> >=20
> > Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
> > ---
> >  .../bindings/power/supply/bq24735.yaml        | 13 +++++
>=20
> Patches for the DT bindings needs to be CC'd to the DT binding
> maintainers and should be in their own patch.
>=20

Sorry about that, didn't know.
Will do that in v4.

> >  drivers/power/supply/bq24735-charger.c        | 48 +++++++++++++++++++
> >  include/linux/power/bq24735-charger.h         |  1 +
> >  3 files changed, 62 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yam=
l b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> > index 131be6782c4b..62399efab467 100644
> > --- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> > @@ -56,6 +56,19 @@ properties:
> >        The POR value is 0x1000h. This number is in mA (e.g. 8064).
> >        See the spec for more information about the InputCurrent (0x3fh)=
 register.
> > =20
> > +  ti,wdt-timeout:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Used to control and set the charger watchdog delay between conse=
cutive
> > +      charge voltage and charge current commands.
> > +      This value must be:
> > +        0 - disabled
> > +        1 - 44 seconds
> > +        2 - 88 seconds
> > +        3 - 175 seconds
> > +      The POR value is 0x11 (3).
> > +      See the spec for more information about the ChargeOptions(0x12h)=
 register.
> > +
>=20
> This is missing=20
>=20
> minimum: 0
> maximum: 3
>=20

Indeed. Will fix in v4.

> >    ti,external-control:
> >      type: boolean
> >      description: |
> > diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/sup=
ply/bq24735-charger.c
> > index 3ce36d09c017..88f1cb1e9fee 100644
> > --- a/drivers/power/supply/bq24735-charger.c
> > +++ b/drivers/power/supply/bq24735-charger.c
> > @@ -45,6 +45,8 @@
> >  /* ChargeOptions bits of interest */
> >  #define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
> >  #define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
> > +#define BQ24735_CHARGE_OPT_WDT_OFFSET	13
> > +#define BQ24735_CHARGE_OPT_WDT		(3 << BQ24735_CHARGE_OPT_WDT_OFFSET)
> > =20
> >  struct bq24735 {
> >  	struct power_supply		*charger;
> > @@ -156,6 +158,20 @@ static int bq24735_config_charger(struct bq24735 *=
charger)
> >  		}
> >  	}
> > =20
> > +	if (pdata->wdt_timeout) {
> > +		value =3D pdata->wdt_timeout;
> > +
> > +		ret =3D bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
> > +					  BQ24735_CHARGE_OPT_WDT,
> > +					  (value << BQ24735_CHARGE_OPT_WDT_OFFSET));
> > +		if (ret < 0) {
> > +			dev_err(&charger->client->dev,
> > +				"Failed to write watchdog timer: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
>=20
> binding says '0' =3D disabled, but code implements '0' =3D do not
> change.
>=20

Well noticed. Will fix in v4.

I'm going to send a v4 without patch 1/2 because I noticed you already
queued for-next, so the next version should have only 1/2 heandling the
code and 2/2 specifically for dt-bindings.


--=20
Bruno Meneguele
PGP Key: http://bmeneg.com/pubkey.txt

--+ovW7MO3Lc9bWcnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEakAcACgkQYdRkFR+R
okPC1AgAj09+Wr7H2NHMWZiX0h/j6ZXkFrFrHC/ms+RLNnQaQv0kNUFfYcbWoMhY
UC3O9Y7l+QuWrH0noNvZeEg0IozCTAoou+8m/akoAn0Ya83SlnoGWvhZ/mcpZUH/
Rklt4Ra06UP/NyQBhAnE5+Gs0srANkUcuAcxSZB4JXoAoKAgKCaW+aDEv2jPW5w1
Fx66WsQ/788SKfpzl5J5cRGg0HvvJCjm9HV/GVv8lYY1VK80kLO7eu1lM7EdIYaX
Ej0BQ8AOTsHfqEgie73POpGkDz+CSGYAVOSS252Z6513tQ6rnTqb1SAVAFy0r8dw
R1UYk5hsZpBPaOPUTigAvbw0tZfdxA==
=yti8
-----END PGP SIGNATURE-----

--+ovW7MO3Lc9bWcnh--
