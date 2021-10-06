Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D124242A8
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhJFQae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbhJFQab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:30:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4598C061765;
        Wed,  6 Oct 2021 09:28:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 882471F44D20
Received: by earth.universe (Postfix, from userid 1000)
        id E96623C0CA8; Wed,  6 Oct 2021 18:28:34 +0200 (CEST)
Date:   Wed, 6 Oct 2021 18:28:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <20211006162834.ujxfcn7jjrdl4kjx@earth.universe>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
 <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uis4nyvfw5i2c7cy"
Content-Disposition: inline
In-Reply-To: <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uis4nyvfw5i2c7cy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 06, 2021 at 05:27:22PM +0200, Hans de Goede wrote:
> On 10/6/21 4:49 PM, Thomas Wei=DFschuh wrote:
> > On 2021-10-06T10:10+0200, Hans de Goede wrote:
> >> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
> >>> On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
> >>>> Right, force-discharge automatically implies charging is
> >>>> being inhibited, so putting this in one file makes sense.
> >>>>
> >>>> Any suggestion for the name of the file?
> >>>
> >>> Maybe like this?
> >>>
> >>> ---------------------------------------------------------------------
> >>> What: /sys/class/power_supply/<supply_name>/charge_behaviour
> >>> Date: October 2021
> >>> Contact: linux-pm@vger.kernel.org
> >>> Description:
> >>>  Configure battery behaviour when a charger is being connected.
> >>>
> >>>  Access: Read, Write
> >>>
> >>>  Valid values:
> >>>
> >>>  0: auto / no override
> >>>     When charger is connected battery should be charged
> >>>  1: force idle
> >>>     When charger is connected the battery should neither be charged
> >>>     nor discharged.
> >>>  2: force discharge
> >>>     When charger is connected the battery should be discharged
> >>>     anyways.
> >>> ---------------------------------------------------------------------
> >>
> >> That looks good to me. Although I just realized that some hw may
> >> only support 1. or 2. maybe explicitly document this and that
> >> EOPNOTSUPP will be reported when the value is not supported
> >> (vs EINVAL for plain invalid values) ?
> >=20
> > Would that not force a userspace applications to offer all possibilitie=
s to
> > the user only to tell them that it's not supported?
> > If the driver knows what is supported and what not it should make this
> > discoverable without actually performing the operation.
> >=20
> > Maybe something along the lines of /sys/power/mem_sleep.
>=20
> Good point, but something like /sys/power/mem_sleep works
> very differently then how all the other power_supply properties work.

Actually we already use this format in power-supply for USB
types, implemented in power_supply_show_usb_type().

> In general if something is supported or not on a psy class
> device is communicated by the presence / absence of attributes.
>
> So I think we should move back to having 2 separate attributes
> for this after all; and group the 2 together in the doc and
> document that enabling (setting to 1) one of force_charge /
> inhibit_charge automatically clears the setting of the other.
>=20
> Then the availability of the features can simply be probed
> by checking for the presence of the property files.

If it's two files, then somebody needs to come up with proper=20
names. Things like 'force_discharge' look sensible in this context,
but on a system with two batteries (like some Thinkpads have) it
is easy to confuse with "I want to discharge this battery before
the other one (while no AC is connected)".

-- Sebastian

--uis4nyvfw5i2c7cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFdzq4ACgkQ2O7X88g7
+pqPDxAAjKz/S74Q8ycLaWU2x9Z+jC8akx7/vbFdHMR18hK5W+yyJUZlO5U94856
AQwtJD0KU2vJmUxoaZyG+BVlt0l55Jd3xNnYX3rqjWvVxbBMPCd7FHxvbCFKwhvh
rKcVlWwUbCX9L/w9c5BUxX4X1gPOEdfhScoiTqdjlF3H4c5Dw1g3x2jQ3Kcr9ayP
UruFqrCgWLC6oQaiccX2E+4iJtNgjudyIXy+y53T32SjIZIaBnsCjPc1jvbWi1bz
ZadbCjij7w4VlA/VfIqIxmNvnK8aJPIukJvXbCFjbBFa85/aX5GsFzdbbj9N9tYx
ZhJ3DOnArxxTkjnGaDv25yGRts7BirYRgb7fLwnSGrutFpGX8/mt26W5jSeZZOCJ
U6cpiPce0sKP7ihNoKhc9cYXbETHEFN1jMmtGZvmHpFexF9oxO77lgFWzN/fmeKX
PiTu2Dk4R6N8EShw57jA3c3GFsfziAY0qAgrzshixBsk4iOrXJrAzT+ANkMUQ0Ic
SStuly/JtQYwHq9mKpeV2mufV2vLtEX1PfDUzK4v+vkmGGwGmeHeBtELqD1G4I52
EZWqBOd9zKjRT3Wg/n3JrfIQGr9pr1BuQ/MzjMrL8R+3lcnnOw5WY14DuH6obA9f
F4BC0FZ1nS2e6JzlPkyjTZqlu3D8/UqXrl5V5n3nJ3qbAyF/wbo=
=I/Qa
-----END PGP SIGNATURE-----

--uis4nyvfw5i2c7cy--
