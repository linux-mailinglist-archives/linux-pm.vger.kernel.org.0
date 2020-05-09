Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FC1CBC0E
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEIBOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEIBOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 21:14:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561CC061A0C;
        Fri,  8 May 2020 18:14:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1D7E72A2EDA
Received: by earth.universe (Postfix, from userid 1000)
        id 635103C08C6; Sat,  9 May 2020 03:14:06 +0200 (CEST)
Date:   Sat, 9 May 2020 03:14:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, David Heidelberg <david@ixit.cz>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ramakrishna.pallala@intel.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: power: supply: Add device-tree binding
 for Summit SMB3xx
Message-ID: <20200509011406.hs7nj3g7f5pzetxp@earth.universe>
References: <20200329161552.215075-1-david@ixit.cz>
 <20200329162128.218584-5-david@ixit.cz>
 <20200410164905.GA719@bogus>
 <8c4ab1ce-1947-ab38-3f8c-9055406428e4@gmail.com>
 <CAL_JsqJgZaQux04vdkShX4vkmOK5T-H6tOXt7Da19jgG0P76-Q@mail.gmail.com>
 <687db60d-fea9-f157-d4ce-907189bb3cc7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trk2swxtlkihf4zn"
Content-Disposition: inline
In-Reply-To: <687db60d-fea9-f157-d4ce-907189bb3cc7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--trk2swxtlkihf4zn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 15, 2020 at 06:30:02PM +0300, Dmitry Osipenko wrote:
> 15.04.2020 17:27, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Apr 10, 2020 at 2:02 PM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>
> >> 10.04.2020 19:49, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> ...
> >>>> +  summit,max-chg-curr:
> >>>> +    description: Maximum current for charging (in uA)
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +
> >>>> +  summit,max-chg-volt:
> >>>> +    description: Maximum voltage for charging (in uV)
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    minimum: 3500000
> >>>> +    maximum: 4500000
> >>>> +
> >>>> +  summit,pre-chg-curr:
> >>>> +    description: Pre-charging current for charging (in uA)
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +
> >>>> +  summit,term-curr:
> >>>> +    description: Charging cycle termination current (in uA)
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> ...
> >>> These are all properties of the battery attached and we have standard
> >>> properties for some/all of these.
> >>
> >> Looks like only four properties seem to be matching the properties of
> >> the battery.txt binding.
> >>
> >> Are you suggesting that these matching properties should be renamed
> >> after the properties in battery.txt?
> >=20
> > Yes, and that there should be a battery node.
>=20
> Usually, it's a battery that has a phandle to the power-supply. Isn't it?

There are two things: The infrastructure described by=20
Documentation/devicetree/bindings/power/supply/power-supply.yaml is
used for telling the operating system, that a battery is charged
by some charger. This is done by adding a power-supplies =3D <&phandle>
in the battery fuel gauge node referencing the charger and probably
what you mean here.

Then we have the infrastructure described by=20
Documentation/devicetree/bindings/power/supply/battery.txt, which
provides data about the battery cell. In an ideal world we would
have only smart batteries providing this data, but we don't live
in such a world. So what we currently have is a binding looking
like this:

bat: dumb-battery {
    compatible =3D "simple-battery";

    // data about battery cell(s)
};

fuel-gauge {
    // fuel-gauge specific data

    supplies =3D <&charger>;
    monitored-battery =3D <&bat>;
};

charger: charger {
    // charger specific data

    monitored-battery =3D <&bat>;
};

In an ideal world, charger should possibly reference fuel-gauge
node, which could provide combined data. Right now we do not have
the infrastructure for that, so it needs to directly reference
the simple-battery node.

> > Possibly you should add
> > new properties battery.txt. It's curious that different properties are
> > needed.
>=20
> I guess it should be possible to make all these properties generic.
>=20
> Sebastian, will you be okay if we will add all the required properties
> to the power_supply_core?

Extending battery.txt is possible when something is missing. As Rob
mentioned quite a few are already described, though:

summit,max-chg-curr =3D> constant-charge-current-max-microamp
summit,max-chg-volt =3D> constant-charge-voltage-max-microvolt
summit,pre-chg-curr =3D> precharge-current-microamp
summit,term-curr =3D> charge-term-current-microamp

I think at least the battery temperature limits are something, that
should be added to the generic code.

> > Ultimately, for a given battery technology I would expect
> > there's a fixed set of properties needed to describe how to charge
> > them.
>=20
> Please notice that the charger doesn't "only charge" the battery,
> usually it also supplies power to the whole device.
>=20
> For example, when battery is fully-charged and charger is connected to
> the power source (USB or mains), then battery may not draw any current
> at all.

It is also a question of how good the charging process should be.
Technically I can charge a single cell Li-ion battery without
knowing much, but it can reduce battery life and/or be very slow.
It might even be dangerous, if charging is done at high
temperatures. Also some of the properties in the battery binding
are not about charging, but about gauging. Some devices basically
have only options to measure voltage and voltage drop over a
resistor and everything else must be done by the operating system.

> > Perhaps some of these properties can just be derived from other
> > properties and folks are just picking what a specific charger wants.
>=20
> Could be so, but I don't know for sure.

I don't think we have things, that can be derived with a reasonable
amount of effort in the existing simple-battery binding, except for
energy-full-design-microwatt-hours & charge-full-design-microamp-hours.

> Even if some properties could be derived from the others, it won't hurt
> if we will specify everything explicitly in the device-tree.
>=20
> > Unfortunately, we have just a mess of stuff made up for each charger
> > out there. I don't have the time nor the experience in this area to do
> > much more than say do better.
>
> I don't think it's a mess in the kernel. For example, it's common that
> embedded controllers are exposed to the system as "just a battery",
> while in fact it's a combined charger + battery controller and the
> charger parameters just couldn't be changed by SW.

A good EC driver exposes a charger and a battery device, so that
userspace can easily identify if a charger is connected.

> In a case of the Nexus 7 devices, the battery controller and charger
> controller are two separate entities in the system. The battery
> controller (bq27541) only monitors status of the battery (charge level,
> temperature and etc).

-- Sebastian

--trk2swxtlkihf4zn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl62A9kACgkQ2O7X88g7
+pr27BAAnAweg7Qzq9Lo0hr3uEUfsmVoN451+mcf9GIc1ld8kEb/7bcCWuirWqRD
/eVM0QNp2RF2dpIEpZLpXG/56gxHEf1hsZUNMC9ZtVK6nReHBJxyzt6vKbpiSKX9
ZXvvodLiUrFp1E6g/AmlpoOwHpe7uQY7npv5NpCWfBqodTGKbVzyhtgEIIXnFe+G
qxI7R/YTqtoifL1aA8XZGJfpBA0gAjFI6QodXJfYhpom0n6RpbPjFUp4XbgGE78I
WxMXiqEu8oXR31CrTklTvt9q/szJF6njztZzmrF8pxfLyGpJ879I74js6Kgcg/eY
uev0EQ+Qv9axcQ4qWHr9+FSvDvdhT99lp3peHCSRx4BbnobydskTeio7dw0oG2eY
PSMEyFMEbavJR/Ylnupuep3PFP1Dq++9IZ3LUmUUoNGISpaRJ2fMbapIii5zEtEI
PC4+LGktA/QFDnPhKyHpI8qXLlQniywQmSuDkSMVKRk7d0IYLQogTETnepW4xbkQ
iQdAf65XTg31IJAT8LF4YHorumWuVtiKx7VaQwcqrMfnrnX+6JIE+ManxY0X5P86
0CFUqVoXP9Ktr6I26Tsc0ZKmz0epkoAmSthpnZfHzOi56oC8s455sQzGO9Ew/PLN
mLNbGKmGB7QoPbUaQTY4lgOHGyNWA4UfZKmRo1h1w3Xy8oTBFmM=
=rBVs
-----END PGP SIGNATURE-----

--trk2swxtlkihf4zn--
