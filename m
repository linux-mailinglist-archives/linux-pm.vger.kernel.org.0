Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8B4251F7
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhJGL37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 07:29:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhJGL36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 07:29:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 701B21F44EBA
Received: by earth.universe (Postfix, from userid 1000)
        id E3DD03C0CA8; Thu,  7 Oct 2021 13:28:01 +0200 (CEST)
Date:   Thu, 7 Oct 2021 13:28:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas Koch <linrunner@gmx.net>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <20211007112801.jqc4xyht5rn5wt4j@earth.universe>
References: <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
 <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
 <20211006162834.ujxfcn7jjrdl4kjx@earth.universe>
 <9ec694b7-48a9-5d86-0970-daefdf204712@redhat.com>
 <10fe30d4-f076-0612-002b-8bdf4e0a1fd5@gmx.net>
 <cdc45a93-dd17-4ff1-8ce7-9002ae6ae23b@t-8ch.de>
 <48c9dd0e-ffe7-6ee5-c201-517392269da5@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5y7eyfgbxqcs5dr"
Content-Disposition: inline
In-Reply-To: <48c9dd0e-ffe7-6ee5-c201-517392269da5@gmx.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--t5y7eyfgbxqcs5dr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 07, 2021 at 07:56:13AM +0200, Thomas Koch wrote:
> > > > > On Wed, Oct 06, 2021 at 05:27:22PM +0200, Hans de Goede wrote:
> > > > > > On 10/6/21 4:49 PM, Thomas Wei=DFschuh wrote:
> > > > > > > On 2021-10-06T10:10+0200, Hans de Goede wrote:
> > > > > > > > On 10/6/21 12:06 AM, Sebastian Reichel wrote:Ack
> > > > > > > > > On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede w=
rote:
> > > > > > > > > > Right, force-discharge automatically implies charging is
> > > > > > > > > > being inhibited, so putting this in one file makes sens=
e.
> > > > > > > > > >=20
> > > > > > > > > > Any suggestion for the name of the file?
> > > > > > > > >=20
> > > > > > > > > Maybe like this?
> > > > > > > > >=20
> > > > > > > > > ---------------------------------------------------------=
------------
> > > > > > > > > What: /sys/class/power_supply/<supply_name>/charge_behavi=
our
> > > > > > > > > Date: October 2021
> > > > > > > > > Contact: linux-pm@vger.kernel.org
> > > > > > > > > Description:
> > > > > > > > >    Configure battery behaviour when a charger is being co=
nnected.
> > > > > > > > >=20
> > > > > > > > >    Access: Read, Write
> > > > > > > > >=20
> > > > > > > > >    Valid values:
> > > > > > > > >=20
> > > > > > > > >    0: auto / no override
> > > > > > > > >       When charger is connected battery should be charged
> > > > > > > > >    1: force idle
> > > > > > > > >       When charger is connected the battery should neithe=
r be charged
> > > > > > > > >       nor discharged.
> > > > > > > > >    2: force discharge
> > > > > > > > >       When charger is connected the battery should be dis=
charged
> > > > > > > > >       anyways.
> > > > > > > > > ---------------------------------------------------------=
------------
> > > > > > > >=20
> > > > > > > > That looks good to me. Although I just realized that some h=
w may
> > > > > > > > only support 1. or 2. maybe explicitly document this and th=
at
> > > > > > > > EOPNOTSUPP will be reported when the value is not supported
> > > > > > > > (vs EINVAL for plain invalid values) ?
> > > > > > >=20
> > > > > > > Would that not force a userspace applications to offer all po=
ssibilities to
> > > > > > > the user only to tell them that it's not supported?
> > > > > > > If the driver knows what is supported and what not it should =
make this
> > > > > > > discoverable without actually performing the operation.
> > > > > > >=20
> > > > > > > Maybe something along the lines of /sys/power/mem_sleep.
> > > > > >=20
> > > > > > Good point, but something like /sys/power/mem_sleep works
> > > > > > very differently then how all the other power_supply properties=
 work.
> > > > >=20
> > > > > Actually we already use this format in power-supply for USB
> > > > > types, implemented in power_supply_show_usb_type().
> > > > >=20
> > > > > > In general if something is supported or not on a psy class
> > > > > > device is communicated by the presence / absence of attributes.
> > > > > >=20
> > > > > > So I think we should move back to having 2 separate attributes
> > > > > > for this after all; and group the 2 together in the doc and
> > > > > > document that enabling (setting to 1) one of force_charge /
> > > > > > inhibit_charge automatically clears the setting of the other.
> > > > > >=20
> > > > > > Then the availability of the features can simply be probed
> > > > > > by checking for the presence of the property files.
> > > > >=20
> > > > > If it's two files, then somebody needs to come up with proper
> > > > > names. Things like 'force_discharge' look sensible in this contex=
t,
> > > > > but on a system with two batteries (like some Thinkpads have) it
> > > > > is easy to confuse with "I want to discharge this battery before
> > > > > the other one (while no AC is connected)". > Ah I did not realize=
 there was already some (read-only) precedence
> > > > for this in the psy subsystem.
> > > >=20
> > > > Since there is precedence for this using
> > > > /sys/class/power_supply/<supply_name>/charge_behaviour
> > > >=20
> > > > with an example contents of say:
> > > >=20
> > > > [auto] inhibit-charge force-discharge
> > > >=20
> > > > Works for me and having 1 file instead of 2 is better then
> > > > because this clearly encapsulates that inhibit-charge and
> > > > force-discharge are mutually exclusive.
> > > In fact they do not reset each other on ThinkPads. It's possible to
> > >=20
> > > 1. set force_discharge=3D1 -- discharging commences
> > > 2. set inhibit_charge=3D1 -- discharging continues, force_discharge r=
emains 1
> > > 3. set force_discharge=3D0 -- battery does not charge, inhibit_charge
> > > remains 1
> >=20
> > But in the end there are only three states the user cares about, or?
> > (inhibit, force_discharge and normal)
> >=20
> > So when selecting inhibit or force_discharge the driver itself can rese=
t the
> > other option so the users do not have to care about the internal state =
of the
> > EC.
> Correct. It works with the three states Sebastian suggested because
> force_discharge overrules inhibit_charge.
>=20
> Whereby for user-friendliness I would prefer Hans' strings
>=20
> >>> [auto] inhibit-charge force-discharge
>=20
> to Sebastian's numbered states.

LGTM.

-- Sebastian

--t5y7eyfgbxqcs5dr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFe2bsACgkQ2O7X88g7
+poEYg//Tn1LYFLfhnpqSfcx4VaYYX284i3QPw460nGqriANNa0gEwsBFzoIHVib
7UTtVF2F+V8SsFmoJ1oC4X8s3kImlGisUvltf0IBFQyAPsDtomhpvM2P5CJXkICN
b//TUlrDcM3SrTFwPvAZBdd1eW7ivE/mdsEsSrZPLVqmPL5pVgCGkyo2wGgAy1G1
/7zyPX5DZICIy0NbXRn7NKXe035tWifwpFx2sJf4q8aAdq8EEaQqAxCR6YRpurBH
H1/tXUD6s3Jzov+JzwikotQv+h2VXcs2ef6Z3ikgTsWdkr7H+8fC2wd1fmLPheuU
8wJ+QqLtVji4eL7PfK3oyXNi9fg1ssQh4uSVffpKWMD8yvnFYk1B8J/DhqMu8MXW
6i5fx8RlevAYX/ohbwjjAVlLig1QvESOavuyv6DOwZ+BOodVpI5sFvW8bz7h/YLj
rpX/nq/VStAxoTSDxjiIT8ki2br/soxG5WJeYD575qkpKugIem9waMo4I/BwtOJK
9675MjO9TPBe30M7DRK7y/9wgjrJSqjSneH/ikij1ydH5XAo8qTVsoUpwjujFCG0
n1G95iRzIKdjXjgM7hvkZXPbe0KBct+0/MgQdHpA0Qv8ome198mqojsljTgvPRFL
zVhQoDw5LAuHvDLlpePN8pga1RK53AgZdooqQeGbLLeEjG5+/MU=
=Yh3j
-----END PGP SIGNATURE-----

--t5y7eyfgbxqcs5dr--
