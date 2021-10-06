Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1EC424047
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhJFOle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 10:41:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239002AbhJFOle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 10:41:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0DA641F44C2B
Received: by earth.universe (Postfix, from userid 1000)
        id C142F3C0CA8; Wed,  6 Oct 2021 16:39:37 +0200 (CEST)
Date:   Wed, 6 Oct 2021 16:39:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <20211006143937.llr2ggbkqwhecxk3@earth.universe>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7yxtbxqwslgxnf3"
Content-Disposition: inline
In-Reply-To: <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h7yxtbxqwslgxnf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, Oct 06, 2021 at 10:10:36AM +0200, Hans de Goede wrote:
> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
> > On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
> >> Right, force-discharge automatically implies charging is
> >> being inhibited, so putting this in one file makes sense.
> >>
> >> Any suggestion for the name of the file?
> >=20
> > Maybe like this?
> >=20
> > ---------------------------------------------------------------------
> > What: /sys/class/power_supply/<supply_name>/charge_behaviour
> > Date: October 2021
> > Contact: linux-pm@vger.kernel.org
> > Description:
> >  Configure battery behaviour when a charger is being connected.
> >=20
> >  Access: Read, Write
> >=20
> >  Valid values:
> >=20
> >  0: auto / no override
> >     When charger is connected battery should be charged
> >  1: force idle
> >     When charger is connected the battery should neither be charged
> >     nor discharged.
> >  2: force discharge
> >     When charger is connected the battery should be discharged
> >     anyways.
> > ---------------------------------------------------------------------
>=20
> That looks good to me. Although I just realized that some hw may
> only support 1. or 2. maybe explicitly document this and that
> EOPNOTSUPP will be reported when the value is not supported
> (vs EINVAL for plain invalid values)?

Sounds good to me.

-- Sebastian

--h7yxtbxqwslgxnf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFdtSMACgkQ2O7X88g7
+pqYuw/9ETeud96k8dEZUiTR9ToSDsei2vPP3p7UoYGzdLUGQHlVJByy5xFZ8CeY
kvDmQ9tmEO2yHy1ObIwFwlhJhocGveM6RL0qaBiGRfOz539dUgZ3syzOj+G58RPw
Nb2Ta4ZyxdtxXQ7+7KXqflx6WIYbkYphfsoWVrueDxE3qh2yQkjK+I/ZzEyuBZwV
6Uj1io/7GeZrEuc9l6sWxRJodfTFFYW9QaX0Bqduxt7grO87sG7+7u6tD+BrSk8z
6END/kqnhSezSLeKJzPS4FE8IZV03LWW/A7nP4lbRdo3CQOqRl7JmL9UhhQBz+T9
1bQJPiUtM5JYmQ1z6202VdXRandVFeeWZMcpCsE/JJxU1u70dI5YJoA1qq99gyvp
aDGTWOxBR8zU7yORmZIGG+KtPBDs3lrJfaxHorKrgeZ9/nMlzgGIv9pAoOHiITA2
hnc8cavtKkf/oTd5cOOH7Ieevc9kxlBr1sVYgFVGZjkuEjWZ1ld9ZiX2wI0C08vK
8vgKfrtiMzVZDZDVO+9WVYPfiluNa+Rd/bpRgM97vMr9sXL114M8Z8Rr1Kqv4bF0
40VNrTunhMAYOpXFon3Yg3VuGjTKtXrB6tdwu3bHAEo5APm3vkkr68yKd6SdkR85
QsoTcGMFDz8sTrpQY5GvauqYbufLAtrn/8tinmk7je55w8b8EuM=
=ZHXY
-----END PGP SIGNATURE-----

--h7yxtbxqwslgxnf3--
