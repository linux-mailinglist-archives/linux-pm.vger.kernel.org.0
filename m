Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D565DA67C0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICLqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 07:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfICLqa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 07:46:30 -0400
Received: from earth.universe (host-091-097-188-078.ewe-ip-backbone.de [91.97.188.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1802087E;
        Tue,  3 Sep 2019 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567511188;
        bh=hjXB5zrAlbTGRagxVZE7j5GOOPzJkb7UeLQkAGA61YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRaArMa3l3ntQ50WqO+vNR8rBmdA49vi3zMTbSZxD+4MfqDPHkhWK/DP1oAyKSY7i
         QJ3tR5oCmArTs2l9KjDCXnX+Nse6ZlL865H8heuEqXwUt6n28TXajf5jbSrNihQkDy
         rnxuaUduxU3CzRGAhZgiMbNbWQuCwK+IPi4B7xbU=
Received: by earth.universe (Postfix, from userid 1000)
        id 0A1173C0CFA; Tue,  3 Sep 2019 13:46:26 +0200 (CEST)
Date:   Tue, 3 Sep 2019 13:46:25 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
Message-ID: <20190903114625.pdbs52h3vv7hr2sx@earth.universe>
References: <20190902150336.3600-1-krzk@kernel.org>
 <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
 <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
 <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rm6mpfm2xfn242zu"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rm6mpfm2xfn242zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 10:00:12AM +0100, Rob Herring wrote:
> On Tue, Sep 3, 2019 at 8:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
> >
> > On Tue, 3 Sep 2019 at 09:14, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Sep 2, 2019 at 4:03 PM Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
> > > >
> > > > Convert the Syscon reboot bindings to DT schema format using
> > > > json-schema.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  .../bindings/power/reset/syscon-reboot.txt    | 30 --------
> > > >  .../bindings/power/reset/syscon-reboot.yaml   | 68 +++++++++++++++=
++++
> > > >  2 files changed, 68 insertions(+), 30 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/power/reset/s=
yscon-reboot.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/power/reset/s=
yscon-reboot.yaml
> > >
> > > > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-r=
eboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.ya=
ml
> > > > new file mode 100644
> > > > index 000000000000..a583f3dc8ef4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.y=
aml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Generic SYSCON mapped register reset driver
> > > > +
> > > > +maintainers:
> > > > +  - Sebastian Reichel <sre@kernel.org>
> > > > +
> > > > +description: |+
> > > > +  This is a generic reset driver using syscon to map the reset reg=
ister.
> > > > +  The reset is generally performed with a write to the reset regis=
ter
> > > > +  defined by the register map pointed by syscon reference plus the=
 offset
> > > > +  with the value and mask defined in the reboot node.
> > > > +  Default will be little endian mode, 32 bit access only.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: syscon-reboot
> > > > +
> > > > +  mask:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Update only the register bits defined by the mask=
 (32 bit).
> > > > +    maxItems: 1
> > >
> > > Drop this as that is already defined for uint32.
> > >
> > > It also doesn't actually work. The $ref has to be under an 'allOf' if
> > > you have additional schemas. A quirk of json-schema...
> > >
> > > > +
> > > > +  offset:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Offset in the register map for the reboot registe=
r (in bytes).
> > > > +    maxItems: 1
> > > > +
> > > > +  regmap:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description: Phandle to the register map node.
> > > > +    maxItems: 1
> > > > +
> > > > +  value:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: The reset value written to the reboot register (3=
2 bit access).
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - regmap
> > > > +  - offset
> > > > +
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        value:
> > > > +          not:
> > > > +            type: array
> > >
> > > I think you could make this a bit more readable with:
> > >
> > > if:
> > >   not:
> > >     required:
> > >       - value
> >
> > I do not understand how does it work (value is not mentioned in the
> > required fields so why checking of it?)... but it works fine.
>=20
> What's under required doesn't have to be listed as a property.
>=20
> > > However, if the tree is free of legacy usage, then you could just dro=
p all this.
> >
> > One of them - mask or value - has to be provided.
>=20
> Or both, right?
>=20
> Actually, a better way to express it is probably this:
>=20
> oneOf:
>   - required: [ value ]
>   - required: [ mask ]
>   - required: [ value, mask ]

Looks good to me.

-- Sebastian

--rm6mpfm2xfn242zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1uUo4ACgkQ2O7X88g7
+ppzuQ/+Mm+oWf+fmnYvUJtDmORKgyTJp1OBcKig4qxPW9n/Izdh2SPEE9D7TQ8m
ah+S75p/HMZjTAyBwvqS3JaCiOyJZwgPeUuFZaqdDJXTzmSY9/w9iP9taSTq8y3L
Q2j/c9kb2F/5fSjBv/h6bA8Tpd+Sxp9g13PLiHAwbTPerNdc82OjFeiGZieURxpo
6thT8M2rssCuasjW53rF+MmdXEdqVW9qSpQC8CqRfQc5iaaYZZB9k/3fJxR2cWH7
uBz38jC0xbWWoS9Rh9uGwAlXx2qG6Re3YX2jiH1FXNYmVsP1FJBjkMbsY3ZhiUGf
gzTKBCGZXNJOY6Nq1oyfhb5cQIMuddDUw7XMhy/k59Pe72cwSrDk6qxzXgEDYNVc
3w8LXWXJBMGTNR2+JlVpybY1ham5VQE5cM+uOsbpqHFhUWG6orMLfHY6TPBvXeE5
4l2CBH+gSUb2j/2BlLVQ2gYPcU2Q0EZ9kNkx90zPZW96MWYOOJ4lrHJWqaHrEZ05
aIexGNoVeQQAJdEN6wN4OinBo8qAVwXMJmQtDDrkjxGx3w4MOOnK2Y3qy4pzbZkR
GZwZOXBgAhq0MrR3IjLagPyp6OUgm5BpMP9YajHFGuUKTJCoUmxqskPyi5Gdg/Y+
CniPzO+lL/K04tjWoOcEjIM4b2ecgYyrd6gHpzZOHSAYJqkzsRM=
=qj1A
-----END PGP SIGNATURE-----

--rm6mpfm2xfn242zu--
