Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B7419713
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhI0PFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 11:05:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbhI0PE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 11:04:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 019D51F42794
Received: by earth.universe (Postfix, from userid 1000)
        id 08C923C0CA8; Mon, 27 Sep 2021 17:03:13 +0200 (CEST)
Date:   Mon, 27 Sep 2021 17:03:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas Marangoni <thomas.marangoni@mec.at>
Cc:     linux-pm@vger.kernel.org
Subject: Re: Communication between kernel and user-space
Message-ID: <20210927150312.viikmnyvfgc7ogcu@earth.universe>
References: <93abc004-eed6-d78b-9311-a6626e7a0ff6@mec.at>
 <CAJZ5v0ijNPY+33yYPZR03ZEQbCXLog32aqjU0LMTPkcvDwvNYA@mail.gmail.com>
 <1a26c976-81da-c29d-948f-fb879ecc1aaa@mec.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhq7k2sx7td36zji"
Content-Disposition: inline
In-Reply-To: <1a26c976-81da-c29d-948f-fb879ecc1aaa@mec.at>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uhq7k2sx7td36zji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 31, 2021 at 08:49:04AM +0200, Thomas Marangoni wrote:
> > What kind of devices is it going to handle, specifically?
> The AXP209 is a power management chip for e.g. Allwinner A20 (ARM
> architecture), I want to focus on the axp20x-battery driver.
>=20
> > > The device has multiple
> > > warnings like: temperature too high or low,
> > You should be able to use the existing thermal framework for this.
> >=20
> > > over-voltage, under-voltage
> > But there's no generic way to communicate those AFAICS.
> >=20
> > The question here is what user space is going to do about them, though.
>=20
> Events I like to communicate to the user-space:
>=20
> - Battery Temperature to high (as already mentioned, possible with thermal
> framework)
> - Battery Temperature to low (as already mentioned, possible with thermal
> framework)
> - AXP209Internal over-temperature (should also be possible with thermal
> framework)
> - Low Voltage Level 2 (shuts down the device)
>=20
> - Low Voltage Level 1
> - Over Voltage
> - Under Voltage
> - Chargingcurrent shortage
>=20
> In my case the application would prepare for a shutdown if the low voltage
> warning level 1 event is received. For the other events the user would ge=
t a
> warning with instruction how to handle them from the application.
>=20
> > > etc. What is the recommended way to communicate such warnings to the
> > > user-space, besides dmesg, so programs can handle them? Or should I j=
ust
> > > create my own attribute for each warning and set it to a specific val=
ue
> > > from the kernel and let user-space applications reset them to
> > > acknowledge them? And if there is a recommended way can you name me a
> > > driver that is using it?
> > >=20
> > > Thanks for your help!

power-supply drivers can expose the health property, which exposes
status like overvoltage or overheat (just one at a time though.
Drivers should report the most critical one).

In general userspace gets a uevent notification with all properties incl.
health when power_supply_changed() is called for the device. It
definetly should be called when health status changes.

You can find more information in Documentation/ABI/testing/sysfs-class-power
(look for "/health") and by searching the kernel tree for
POWER_SUPPLY_PROP_HEALTH.

-- Sebastian

--uhq7k2sx7td36zji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFR3SwACgkQ2O7X88g7
+ppWoQ/+IfN0PAbUT0aOZiqYIfjanUwqAWXSQNsJPe6rrWSfoyDMZ8B3lXSMkE7r
xEmjfjcULD/FeLlh+pWbTGOsZc1NX5/TxJYApMdHKAS2FVRVp0GMyf4GEz/Byg3f
Gxjgk6bcSdC2olDX/i2nscnWsb1TI4Rj/FW5x94gIHby7CN3Ru0V/QBFLc76xN2d
l9Adkjdu3U1eQ30qjtDNPMtrHhOvlUxWnnBTAELOisK4m1/+VK4FMN+FhIeFkrYK
r/NuCdaF48ikVkQhBOR00nnZ9T+dVw3g5NDfaXuToNlBJ+RQ8zKVNvqp6P86nWu5
l0idvfdzkDPgewyFMk1XX9KUGeAn/VPNUbUr6i3/GfOm93hkIF7DNHVgRuRRbjwe
uwGZc6KnhNyBVIwuibBC8JBZgGp1d6jiysAkDoGuFNGhUEh8+qcIPtxsk26WO1Tg
DFSoBop7w2LzDy42t8oVOJ7Tph81tax2Cssx4Ft9dzVOosVMQysQmr1VYv7i5bYB
1EGlQt91FekUXZb7D2u96ams1mFl5Lk94/gLQuDICA3IiKH7FZjuMh4mOsFvYC3W
6NXEztjV3VsRiK1RIhnEeU2J0A/qN/578v8DO+iQUTTWP/cTxq1i9zmwZfm3gX52
9BJw/5b8xVuuZkl+nd0V6h6IvhjWltqCgYtmphMqq9AD/iR+e7I=
=obgt
-----END PGP SIGNATURE-----

--uhq7k2sx7td36zji--
