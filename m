Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974E42010ED
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393785AbgFSPbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 11:31:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393777AbgFSPbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 11:31:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DE1C12A54AD
Received: by earth.universe (Postfix, from userid 1000)
        id 651323C08CD; Fri, 19 Jun 2020 17:31:03 +0200 (CEST)
Date:   Fri, 19 Jun 2020 17:31:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Mario.Limonciello@dell.com, y.linux@paritcher.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200619153103.k4ewdaljqubcrvvc@earth.universe>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <20200609154938.udo7mn7ka7z7pr6c@pali>
 <20200609164533.qtup47io2aoc5hgl@earth.universe>
 <136a06e3-0f00-d252-ebdd-a76c8a575db8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="asks2luctm5jqxfa"
Content-Disposition: inline
In-Reply-To: <136a06e3-0f00-d252-ebdd-a76c8a575db8@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--asks2luctm5jqxfa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 09, 2020 at 06:59:13PM +0200, Hans de Goede wrote:
> Hi Sebastian,
>=20
> On 6/9/20 6:45 PM, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jun 09, 2020 at 05:49:38PM +0200, Pali Roh=E1r wrote:
> > > On Monday 08 June 2020 20:36:58 Mario.Limonciello@dell.com wrote:
> > > > Can you please comment here how you would like to see events like t=
his should come
> > > > through to userspace?
> > > >=20
> > > > * Wrong power adapter (you have X and should have Y)
> > > > * You have plugged a dock into the wrong port
> > > > * Fn-lock mode
> > >=20
> > > In my opinion, Fn-lock mode is related to input subsystem and should =
be
> > > probably reported via input device. For a user, fn-lock is similar li=
ke
> > > caps-lock, scroll-lock or num-lock. Also fn-lock is provided by other
> > > laptops and therefore I would expect that kernel provide fn-lock state
> > > for all laptops (thinkpad / latitude / ...) via same interface. And n=
ot
> > > via dell-specific interface or general-vendor-message interface.
> > >=20
> > > Wrong power adapter sounds like something related to power subsystem.
> > > Adding Sebastian to the loop, maybe he can provide some useful ideas
> > > about it.
> >=20
> > I'm missing a bit of context. I suppose this is about connecting a
> > non-genuine power adapter rejected by the embedded controller?
> > Support for that should be hooked into 'drivers/acpi/ac.c' (note:
> > so far there is no standard power-supply class property for this).
> > Also printing a warning to dmesg seems sensible.
>=20
> This is not so much about non-genuine as about the adapter having
> the wrong wattage. E.g. plugging a 65W adapter in a laptop which
> has a 45W CPU + a 35W discrete GPU will not allow the laptop to
> really charge while it is in use.

Ok. So how much information is available over WMI? Exposing the
max. input power via the power-supply API makes sense in any case.

> One issue I see with doing this in the power_supply class is that
> the charger is represented by the standard ACPI AC adapter stuff,
> which does not have this info. This sort of extra info comes from
> WMI. Now we could have the WMI driver register a second power_supply
> device, but that means having 2 power_supply devices representing
> the 1 AC adapter which does not feel right.

I agree. WMI and ACPI information need to be merged and exposed
as one device to userspace. It's not the first time we have this
kind of requirement, but so far it was about merging battery info
=66rom two places. Unfortunately no code has been written so far to
support this.

> I was myself actually thinking more along the lines of adding a
> new mechanism to the kernel where the kernel can send messages
> to userspace (either with some special tag inside dmesg, or through
> a new mechanism) indication that the message should be shown
> as a notification (dialog/bubble/whatever) inside the UI.
>
> This could be useful for this adapter case, but e.g. also for
> pluging a thunderbolt device into a non thunderbolt capable
> Type-C port, a superspeed USB device into a USB-2 only USB
> port and probably other cases.
>=20
> Rather then inventing separate userspace APIs for all these
> cases having a general notification mechanism might be
> quite useful for this (as long as the kernel does not
> over use it).

I don't think this is a good idea. It brings all kind of
localization problems. Also the information is not machine
parsable. It looks more like a hack to get things working
quickly by avoiding using/designing proper APIs.

-- Sebastian

--asks2luctm5jqxfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s2ikACgkQ2O7X88g7
+pphDQ//U3O3wYfKysir/AJz9pc7ViJ82wmiKbe8bdYV8V4sQPlUQ4YCzUil/++R
BiwlvG1tcn90CEffDWsffJ5qe5FKsLisYSZamWPwvV7hbu+wzyjx1tvLR6LC3v/2
cbSzYJmhwzecEPoX3mnuODDk0sZXGijWghl1mwIlc+Z9JF83m1GoVsE14pJa3bF/
hf9Bb5P7ozdTaa+cS8m08duJkmKP1y2KDcbWkrilo8lXYcU3DMi5iv+SU/j3o3AN
jC405SUpNV8dzL0y3Bo1qa/BK3JPmPQaL2YbOlnw12AoQU8+wPStwaqd6S4jLFyh
jL3VD4trgKVD+f6lz7ivjfwo3/lo3TvE9dLCMx+7N3EcDQbEjNhWr45ns/EY10Sj
PVN9kIhmxVIjfuFfnXq9HXtIQ0I4fi7wA8YJewX2xI5UY+c5Mp2bq3C1hyMnFV1+
YMIkyK8WsrVgEq7yo+qVazhh7lZLoz7SlFNPVZkXi8Bo5fWDBKPgIwbms4XeZeLd
Br7qJXE8tuev1HCATpQszwYcHQqG96un6Zyq3mESJoOVi6+XdvdholMQxNj1bCwi
6OvuVrsGbh02Hpbo9YwP+D+SQAdNaf8FCFzhzs4jd43tkysNWVhr69yKDC1/HFOQ
KiBgpkmp51m/DCn7K9JYQQxOkEbMRGqYui+DS65JuRVNrzEWWLc=
=3JZ5
-----END PGP SIGNATURE-----

--asks2luctm5jqxfa--
