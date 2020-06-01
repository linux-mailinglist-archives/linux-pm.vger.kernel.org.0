Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243C1EB163
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgFAV5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgFAV5S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 17:57:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD184C061A0E;
        Mon,  1 Jun 2020 14:57:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 16EE92A24B9
Received: by earth.universe (Postfix, from userid 1000)
        id 921263C08C7; Mon,  1 Jun 2020 23:57:13 +0200 (CEST)
Date:   Mon, 1 Jun 2020 23:57:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
Message-ID: <20200601215713.kefq72upysjjlrwm@earth.universe>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200529162704.GA3709@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdj3sjeruhoqdhgk"
Content-Disposition: inline
In-Reply-To: <20200529162704.GA3709@amd>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zdj3sjeruhoqdhgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 29, 2020 at 06:27:04PM +0200, Pavel Machek wrote:
> > This patchset improves support for SBS compliant batteries. Due to
> > the changes, the battery now exposes 32 power supply properties and
> > (un)plugging it generates a backtrace containing the following message
> > without the first patch in this series:
> >=20
> > ---------------------------
> > WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4=
/0x104
> > add_uevent_var: too many keys
> > ---------------------------
> >=20
> > For references this is what an SBS battery status looks like after
> > the patch series has been applied:
> >=20
> > POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
> > POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D10800000
>=20
> Is that correct, BTW? sounds like these should not be equal...

(Some) GE batteries have weird values stored in the SBS chip.
For example manufacturer and model name are swapped:

POWER_SUPPLY_MANUFACTURER=3DUR18650A
POWER_SUPPLY_MODEL_NAME=3DGEHC

I carefully checked manufacturer/model name when writing these
patches some time ago and came to the conclusion that the batteries
do report it the wrong way around.

I will have a look for the design voltages (which are not modified
by this patchset), but I expect this to be another GE specific thing.

-- Sebastian

--zdj3sjeruhoqdhgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7VebQACgkQ2O7X88g7
+ppwnw/+OxP+ohJdLekmFK9Z6xByRmB746XuY51AvyPxPn1i+6BYCNYiF9BH1H6H
NigPpmlgaNOPVVAQGaB67rlIAEVFgOM893vY6BQEWqK8kf/cwGDy0z0OyMvQIct2
j4seRHmom2gfHWsmrZIsD1O1LO3ENwkIMFXBDt1r/Km5UPdChoQ84qdGpIWbBQKC
19AnKoMaQSERyZZne2vHqBmDDmnxo2P7burzUhPSMV2h//1XXeW2s1uEZiKie7xn
5llxeOWHScN50sS7V69ZFjMSYYN5poLsk4KyQhJo0WnMZIY0G3+gO8BK4UbncsOy
jBSv1iEnGRnFt2f3Sfn6Jn9Dq+nSJCY95S/Ho4aPFcdUsaGApnJcTkAF9xxMfugG
i0kFZLvUCThcwOekMZvxjZjD5tk0cWQlJ1HNMwsBO9ZVXOFBSMiL8QY/f2VdF70n
kQ7sEgdAHelkgVrrsynWY0GcBqH9/QdUpFxu3xwUqb4kVV+DB0K5ZCzp0Iot9GQR
I3w4MB60c6DJ9xAbrRr5+WcX2IT+GvzzS0boe/yw7rq2thVcsrzBTvPlPNqmj3l8
m5ML0+rCNDzHsRzfyKavXrkf0OLW+tIAn7m+7HbOWM/2xf4tsBKVHidB7Zkr3bEi
ml/3Ht7zNUy2MDWNWOPu8PWqNjW637qt1cxd38lhCtFdxsbMII8=
=mJgM
-----END PGP SIGNATURE-----

--zdj3sjeruhoqdhgk--
