Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85CE33D90A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhCPQUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 12:20:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbhCPQUt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 12:20:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CA8041F448E2
Received: by earth.universe (Postfix, from userid 1000)
        id 170383C0C96; Tue, 16 Mar 2021 17:20:45 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:20:45 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 16/38] dt-bindings: power: supply: tps65217: Convert to
 DT schema format
Message-ID: <20210316162045.cvvb226rpzxbovdl@earth.universe>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-17-sebastian.reichel@collabora.com>
 <CAL_JsqLn9Mo_hTuCEPapNz3cFHbC8NKHH0npYrnV+dC85pBAsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ngwdsyabcyyz24v"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLn9Mo_hTuCEPapNz3cFHbC8NKHH0npYrnV+dC85pBAsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6ngwdsyabcyyz24v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, Mar 15, 2021 at 12:33:23PM -0600, Rob Herring wrote:
> On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > +  interrupts:
> > +    minItems: 2
> > +    maxItems: 2
>=20
> We've lost info that was in the original binding. You could do
> something like this:
>=20
> items:
>   - description: USB charger
>     const: 0
>   - description: AC charger
>     const: 1
>=20
> (Usually the interrupt values would be out of scope of the binding,
> but I guess here it makes some sense.)

I initially did this, but it did not work. I see the following for
dt_binding_check (dtbs_check triggers the same):

Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.=
yaml: charger: interrupts:0: [0] is too short
	From schema: Documentation/devicetree/bindings/power/supply/tps65217-charg=
er.yaml
Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.=
yaml: charger: interrupts: [[0], [1]] is too long
	From schema: Documentation/devicetree/bindings/power/supply/tps65217-charg=
er.yaml
Documentation/devicetree/bindings/power/supply/tps65217-charger.example.dt.=
yaml: charger: interrupts: Additional items are not allowed ([1] was unexpe=
cted)
	From schema: Documentation/devicetree/bindings/power/supply/tps65217-charg=
er.yaml

Seemed to be a limitation in the validation tool, so I just dropped
the extra information. If we do not want to loose information I can
add it to the description, or should the validation tool be fixed?
I suppose it's kind of unusual, that the binding can provide the
interrupt line numbers.

-- Sebastian

--6ngwdsyabcyyz24v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBQ2tgACgkQ2O7X88g7
+posBQ//a3+906hJN289fW54K77xaJLrURzAQs//Ec4Sb+pN8GZZPn/5pmxq0six
BU2kM2Yeco46Auc28UTS+i9QZT3cYk2CcbVk+X21RhSh93RL7qRHG4/vS0D7tMM8
jOduH5HMogDcgOkr3kg3INoQvO6fZ3Zw7ho9y31yyAQAN91FJkJPbZ1orv1makkc
ea4z/FM2W5H3W8Svcz8ofIaxh0p3kkLrzjznMDjMDSqa+5oNhDGAUT4fKVL58j8A
5F93GSAgJeRaHUUOlBem60QsNIFRrtEsXK22bajZrh3zj/JQJ4H4a6LNvkMYJjK1
dzL9K7nkry2sx2CLYfaKPXtMWAvdqcKlW6wqMIuYptLSz1dXf94SVJS4W4Oet3zO
NFlPHKqnJ9rlokLdcA8Tmow1HqVw8HAwzvbeeOOJlcP1h9p6DPpiS4HSgcouwmOF
zwxpnj92STM8IEOrzKT/ATl91sTJ4mzDVNCCet6ZwzowYBUk1YbARxMZVoaULEVo
kVBXywJy5zR190ZOE50Hcwi9DZM6q2MGvXeJ6SiC4Pc5KO9ujAGzHd5Bt7W1oHye
+kkzVQnIr/NYIgjpF0q7x4/vaQYbdu5FOPKIIm7ZEK4f1r9J9rm3eGmY/qOdS1RK
TwLeaRxtcNODO3qhqLhC7unlgwZXsjFcBiiHpbdHlWUNBrDjAq4=
=vqDY
-----END PGP SIGNATURE-----

--6ngwdsyabcyyz24v--
