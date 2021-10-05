Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF5423330
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhJEWIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 18:08:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbhJEWIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 18:08:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3C3371F42D7B
Received: by earth.universe (Postfix, from userid 1000)
        id 95A1A3C0CA8; Wed,  6 Oct 2021 00:06:30 +0200 (CEST)
Date:   Wed, 6 Oct 2021 00:06:30 +0200
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
Message-ID: <20211005220630.zurfqyva44idnplu@earth.universe>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvbhbwzdfpbbgvp3"
Content-Disposition: inline
In-Reply-To: <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cvbhbwzdfpbbgvp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
> Right, force-discharge automatically implies charging is
> being inhibited, so putting this in one file makes sense.
>=20
> Any suggestion for the name of the file?

Maybe like this?

---------------------------------------------------------------------
What: /sys/class/power_supply/<supply_name>/charge_behaviour
Date: October 2021
Contact: linux-pm@vger.kernel.org
Description:
 Configure battery behaviour when a charger is being connected.

 Access: Read, Write

 Valid values:

 0: auto / no override
    When charger is connected battery should be charged
 1: force idle
    When charger is connected the battery should neither be charged
    nor discharged.
 2: force discharge
    When charger is connected the battery should be discharged
    anyways.
---------------------------------------------------------------------

-- Sebastian

--cvbhbwzdfpbbgvp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFczGMACgkQ2O7X88g7
+poKjA//bbFnQErO9t1t4eu5bRpb53y9zW02ZnoekvAIwqpZBA7JzIWdIpmG99NC
YGq4BmTUZQR/rKV1Xq8pK8ecfmxPACXfz07ewGgom0s9fQSKL7h8kJhMn5l7S8tU
YQgRJd+J87VW5cgUwGzSg8mxpwr3BNvq+un27/ukmqyRrlqNswn0xwpQ+vz91wu2
6VcOsbqtrdlh1qarJgf9n3bJw2oeTSE9wKxGl4Q1h5W8fiwJLiSAk3X70bEtYiCy
PHux1QhIbxC+21DHkk6wsZyeVy5vtXYnXRwWWoL/E3eiNOHaG3SmrLHavhN1fEx5
okpV19oC2zej6mTlDV0D4p4fI/wQXnmC5pGVzWsm7Pz0s+qJHmpheOVP2YyQB94p
Yv/llnlM+PfCTzuIK6sjZNnieY8QzG2BWuDh75gbGAVD2QeG53bHp8NvLDS9sBPc
LZwZnjMN824AKHiKtE7PDLKSKQ2dHcFXTIPSuxsYz/D1RLZBYCpx+XhlncwFnlD1
do0pAgVkBExeMPTZot4o5DFOr7uQgtI4/WQSsSpso0fDstlYzw0+gIvruoTyNVbp
fR7aEbep6ixTWrngsnaON5vvDhd1zsY9erzI4jPGIto8Ma5r1yNN6x62CjSYwJS+
8ypxcSNhUKLPirskN1AORKT+Chem7wSD85lfT/1GVrkoaVYVsZA=
=KjJe
-----END PGP SIGNATURE-----

--cvbhbwzdfpbbgvp3--
