Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8381F4146
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgFIQph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 12:45:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51122 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgFIQph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 12:45:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 850262A0313
Received: by earth.universe (Postfix, from userid 1000)
        id 2545F3C08C6; Tue,  9 Jun 2020 18:45:33 +0200 (CEST)
Date:   Tue, 9 Jun 2020 18:45:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Mario.Limonciello@dell.com, y.linux@paritcher.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        mjg59@srcf.ucam.org
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200609164533.qtup47io2aoc5hgl@earth.universe>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <20200609154938.udo7mn7ka7z7pr6c@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elc5oav6xzcv43cc"
Content-Disposition: inline
In-Reply-To: <20200609154938.udo7mn7ka7z7pr6c@pali>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--elc5oav6xzcv43cc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 09, 2020 at 05:49:38PM +0200, Pali Roh=E1r wrote:
> On Monday 08 June 2020 20:36:58 Mario.Limonciello@dell.com wrote:
> > Can you please comment here how you would like to see events like this =
should come
> > through to userspace?
> >=20
> > * Wrong power adapter (you have X and should have Y)
> > * You have plugged a dock into the wrong port
> > * Fn-lock mode
>=20
> In my opinion, Fn-lock mode is related to input subsystem and should be
> probably reported via input device. For a user, fn-lock is similar like
> caps-lock, scroll-lock or num-lock. Also fn-lock is provided by other
> laptops and therefore I would expect that kernel provide fn-lock state
> for all laptops (thinkpad / latitude / ...) via same interface. And not
> via dell-specific interface or general-vendor-message interface.
>=20
> Wrong power adapter sounds like something related to power subsystem.
> Adding Sebastian to the loop, maybe he can provide some useful ideas
> about it.

I'm missing a bit of context. I suppose this is about connecting a
non-genuine power adapter rejected by the embedded controller?
Support for that should be hooked into 'drivers/acpi/ac.c' (note:
so far there is no standard power-supply class property for this).
Also printing a warning to dmesg seems sensible.

-- Sebastian

> And plugged dock into wrong port. This is probably dell-specific event
> and some interface for "vendor" messages from kernel to userspace would
> be needed to deliver such things.

--elc5oav6xzcv43cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7fvKYACgkQ2O7X88g7
+ppc9BAAimtl9m9AQ0TWGS8hVWKz3JFaPVxqbJgv8Pl8QmMyPgJDkqEMgERgQDg9
nuCrDj0HmhyFnPwnO5SZ8nJRlbS28voErRIbkp/9tYa5mLSXp/qWheG7vpV6dtlh
NjwHszhlDaUQogT12i7ueTwUNjqwV2m+iwVkkrGl53xr7hJMHIaghMcI2Ze9ukpg
f1fJvrmAtQTPQMon3KL95kyA4AGuBfk86Df2vNldAqZL++U61vgssFeWKaY0i49v
W0D/Qr3UsEwANGRFAuJkda0uv2Cs+os2bqubvl8I0Z9fMv43BaVrWH8gCdWqC3pD
qKFe7mzhtPqcSFDSfIWsBCcoMWSuJFqNcK29BUxa+SIxVJttdY/O+KvSPXG26u8u
nwVValPBD9OGBp5VWIBY6Wl94uf+jqNpnfk1fv1P9Jm4gGXu26t1f0scPN5B6FNI
QMUOOHw0oElKX9ltcLlN94bhImpd43U0fVEmVAgNpSEU5JGj4hSg2xj3JI5Iu2GL
QZGGwPASkcYm2YMMKcW7ZqpNmjqXsI3kMoILmglWYDelPa7xlq0gjuVQUcO57h18
KVCiFYJ4cLQb95Y+E8VmnJKD1q/tRdi+7GLrX2BGvYYFlWq97r/3Gczw448QpscO
f2FLYt+5ZQ4F63YDZiE3ng6tzBalKnD1+OwHXhmlCg0BtHSoQGY=
=Kp0K
-----END PGP SIGNATURE-----

--elc5oav6xzcv43cc--
