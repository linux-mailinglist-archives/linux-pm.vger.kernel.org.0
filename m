Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1933D9BD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 17:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhCPQqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 12:46:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhCPQqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 12:46:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 42FA01F44B4A
Received: by earth.universe (Postfix, from userid 1000)
        id 07E9C3C0C96; Tue, 16 Mar 2021 17:46:02 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:46:02 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 04/38] dt-bindings: power: supply: bq25890: Convert to DT
 schema format
Message-ID: <20210316164602.hupmcy2hjflf4za2@earth.universe>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-5-sebastian.reichel@collabora.com>
 <CAL_JsqKFJPSMyMbcrpnL1WgttHSP+3Q+U8bJ_m5hm=O0gEPe4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flvvchtw4vhvmjx2"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKFJPSMyMbcrpnL1WgttHSP+3Q+U8bJ_m5hm=O0gEPe4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--flvvchtw4vhvmjx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 15, 2021 at 12:21:34PM -0600, Rob Herring wrote:
> On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > +  ti,ibatcomp-clamp-microvolt:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: max. charging voltage adjustment due to expected volt=
age drop on in-series resistor
>=20
> You don't need a type $ref on properties with a standard unit suffix.
> Though it looks like there's some non-standard ones (-microvolts) in
> the series.

Ok. Unfortunately most properties in this series use non-standard
ones :(. Newer bindings using common properties have already been
written in YAML and/or make use of simple-battery.

Can we have a warning for this in the dt_binding_check? Maybe
something like

superfluous $ref for property with standard suffix

-- Sebastian

--flvvchtw4vhvmjx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBQ4L8ACgkQ2O7X88g7
+pomkQ//SV1SH4IZrBUvhr1PWPaxWITOE2xaWZpk+hDYHvGxB3p4aBSAzZbVt0Fz
ZgBHByvmNpHNBOdk9C9g288A+p4XfiR9yWpL4V9IHLvEr0Nh2U3k5Nwv5xokqpzh
xP62HCQNbMBMys+E0rrEHRC5395mX/c9A4vbVRoVHHbl3MUpili7Y4PxpYjAPj6D
CW+AqP76rZ6YKRMAg6/S6VEf/Mo0v8+GkA9alKpso6VFicUig7tFwnz+uap3Uzen
iVDmbhcv2wYZyszgKQlGrJdgeERTPoJF+1O0Ww2ZaLpEE6pJLo3ITXMIva9wkqQX
JIrEBaZmAgLbwM/lOwUbHzBBJTNyOKr/4ZAP2k94+xHdEJlhsYsktP6Jh3/cRHp8
Su26iiol/YYtKyA2DkTgW9UQORNgh9nbAZiNvAfs0FnT6deDnrXq+PwqcUqe7Bxm
7R7TszYXYnBuuEUN3m26rRrFU613wnS3M6aZBAwnfwf8JRGiNGwiAslMUTypu2Pb
LIVakKLLl3NSz8p8u21LIVo6g7E0cpY4714fUm3EMIRjuoRiuEQo3hXHOnMv+QC/
FxgBdmZGU62OAjvKJbTJpKaZ8YL3/L1jYDYPPha3CnVs4MNAKQzwBsYYDFwIgUY6
BpbU5wM23j3PI6qYzLIkjSgBxznsox7r0y8EtookMzJ0jDxZ/ls=
=B+Am
-----END PGP SIGNATURE-----

--flvvchtw4vhvmjx2--
