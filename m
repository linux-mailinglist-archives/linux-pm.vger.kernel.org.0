Return-Path: <linux-pm+bounces-22701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD7A40293
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D889817E2F1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A6208960;
	Fri, 21 Feb 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kqX2T3Cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038A2045B7;
	Fri, 21 Feb 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176579; cv=pass; b=fKWXrRqzrjOdCmYytBRWoT+KP2menNLX9FvaA0iH3k5bzpgA71C2KRAour3BBHw9mA/LOghAlzK1hquCzQDs7oxVzCIYUHxEJFSlixOVKpGILdNf9skLkD7+/gN/4IIuDQfSpOH0sXTNgLZHBMs4+HoxKn6vZ5ff4MVa9pb3ZQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176579; c=relaxed/simple;
	bh=UkUk11Z5IECX8Fz1o9waJqLoqxFcLwUCWg9KJcwHGI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfSHRzvA3FudiT0Ne3xKhlZ9L3BmNa0zkPMqJvWH/xXcFbopts45RO1wWOird/miqEA3x40Fum79a1zZ2VQbWZ5nBcOto9aFRJzMl3lAzjY3K8pNG66SohKg6bavuuN0R0dZtJhaZStPG+wry5tSMl1jtetijHC+Z53IBe0GANU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kqX2T3Cr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740176572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fZVDL4ph2wLOl8psuziwk2rSnQQUHx1eXv/EEowywozInilRxj7d45TcuoKB4NNYUNJDr74EO/ZozJWvUoyJ95b1YqB9BVvqydYGNDxDp0XRWBVLxx8jNGWhLpZZKziJKTMbhlzClM9IrZ8B1YwFGZhvudK3KZQpbJAGMD8oucs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740176572; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3i4MKh+nn1kmA4h6mEkb0x/RtfEzHkjmxmO0stUEMyA=; 
	b=YfwzWVm5SsjQNC6ipPjXL3+1EUcoKneLbbxzuk/GRAw5S7+NBeXjzaw6zUKWtWiq+foNspR3Gm3irMOzznrq3FegyLe96K4upCGzQLRWnZY6miCwmpP8/pjf1b7F1rUnXQ/6IXvYkIwedI04m8G4RFvS7ysJpzxQr/oqhROy5Sg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740176572;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=3i4MKh+nn1kmA4h6mEkb0x/RtfEzHkjmxmO0stUEMyA=;
	b=kqX2T3CrueWajUvlPVDQZTG0cOFweqskawbsENpSzBdYxdYVqqt//jP1uwaVjVMq
	Brz3jBi99XYqOnlSpHxN54HPwdxAbLG6SjPId/TSuutwEEdc220cfhTVd3KRKHHSB00
	7MqO2oY8PxqRCrkg5xLwKM6qFF0AyfycyX10Zm3I=
Received: by mx.zohomail.com with SMTPS id 1740176570350965.6434158101416;
	Fri, 21 Feb 2025 14:22:50 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 40FED180413; Fri, 21 Feb 2025 23:22:47 +0100 (CET)
Date: Fri, 21 Feb 2025 23:22:47 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Message-ID: <m2dy2vhvw7rhexvzkkloelgkcdcq6ci2ot54mdffpvosvagf64@usdxy2cnjeua>
References: <7la3x6f733ju4szqlzmtr277ah7c7lb4d4gcmjgu2rjj5uzpyd@43dmenbpczjs>
 <20250221060143.201963-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvvupexgqzcpf6zr"
Content-Disposition: inline
In-Reply-To: <20250221060143.201963-1-mitltlatltl@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.10.19
X-ZohoMailClient: External


--lvvupexgqzcpf6zr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
MIME-Version: 1.0

Hi,

On Fri, Feb 21, 2025 at 02:01:04PM +0800, Pengyu Luo wrote:
> On Fri, Feb 21, 2025 at 9:33=E2=80=AFAM Sebastian Reichel <sebastian.reic=
hel@collabora.com> wrote:
> > On Thu, Feb 20, 2025 at 02:43:20PM +0800, Pengyu Luo wrote:
> > > On Thu, Feb 20, 2025 at 8:24=E2=80=AFAM Sebastian Reichel <sebastian.=
reichel@collabora.com> wrote:
> > > > On Tue, Jan 14, 2025 at 01:51:27AM +0800, Pengyu Luo wrote:
> > > > > On the Huawei Matebook E Go tablet the EC provides access to the =
adapter
> > > > > and battery status. Add the driver to read power supply status on=
 the
> > > > > tablet.
> > > > >
> > > > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > > > ---
> > > > >  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
> > > > >  drivers/power/supply/Kconfig                  |  10 +
> > > > >  drivers/power/supply/Makefile                 |   1 +
> > > > >  drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++=
++++++
> > > > >  4 files changed, 606 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-g=
aokun
> > > > >  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b=
/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > > new file mode 100644
> > > > > index 000000000..b1eb9e8d7
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > > > @@ -0,0 +1,47 @@
> > > > > +What:                /sys/class/power_supply/gaokun-ec-battery/s=
mart_charge
> > > > > +Date:                January 2025
> > > > > +KernelVersion:       6.12
> > > > > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > > > > +Description:
> > > > > +             This entry allows configuration of smart charging b=
ehavior with
> > > > > +             four parameters. The format is: <mode> <delay> <sta=
rt> <stop>.
> > > > > +
> > > > > +             - mode: Defines the charging mode (1 or 4). Mode 4 =
enables delay,
> > > > > +                     while mode 1 does not.
> > > > > +             - delay: Specifies the delay in hours (non-negative=
). This is
> > > > > +                     only used when 'mode' is set to 4.
> > > > > +             - start: The battery percentage at which charging s=
tarts (0-100).
> > > > > +             - stop: The battery percentage at which charging st=
ops (1-100).
> > > > > +
> > > > > +              When the laptop is connected to a power adapter, i=
t starts
> > > > > +              charging if the battery level is below the 'start'=
 value. It
> > > > > +              continues charging until the battery reaches the '=
stop' level.
> > > > > +              If the battery is already above the 'stop' level, =
charging is
> > > > > +              paused.
> > > > > +
> > > > > +              When the power adapter is always connected, chargi=
ng will
> > > > > +              begin if the battery level falls below 'start', an=
d charging
> > > > > +              will stop once the battery reaches 'stop'.
> > > > > +
> > > > > +              If mode is set to 4, the above charging mode will =
only occur
> > > > > +              after the specified delay in hours. If mode is 1, =
there is
> > > > > +              no delay.
> > > > > +
> > > > > +             Access: Read, Write
> > > > > +
> > > > > +             Valid values:
> > > > > +                     - mode: integer value (1 or 4)
> > > > > +                     - delay: integer value, delay in hours (non=
-negative)
> > > > > +                     - start: integer value, battery percentage =
(0-100)
> > > > > +                     - stop: integer value, battery percentage (=
1-100)
> > > >
> > > > There are common properties for start and stop charging percentage,
> > > > which should be used:
> > > >
> > > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> > > > * POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
> > > >
> > >
> > > Agree, but at least, we should pass delay, start, end. EC only
> > > providedone interface to set mode and delay, that requires 4
> > > arguments, we can handle it with 3 arguments, as you suggested
> > > below. but if we treat start and end separated, then if we want
> > > to set smart charge, we set start, set end, set delay(read start
> > > read end, then set them again). It is a bit redundant.
> >
> > Yes, if these are separate properties you won't get atomic updates.
> > But is that really a problem? Using the standard properties means
> > that you get UI support in the future. I know at least the GNOME
> > people are working on this.
> >
>=20
> On my another x86_64 device with end threshold supported, KDE Plasma
> supports showing this as
>=20
> > Battery is configured to charge up to aproximately <value>%
>=20
> it doesn't support setting things. So, can I keep passing delay, start,
> end when setting, but also setting start and end as battery properties?

No? Why should we create a custom sysfs ABI (which also breaks the
one value per file rule), if we already have a standard ABI?

> > Does the battery not support hot-plug?
>=20
> I am not sure, this is a tablet shipped with a qualcomm chip, we can
> take it as an embedded device. I just took normal usage and using
> without battery into account.

I see. Let's keep it that way for now then.

-- Sebastian

--lvvupexgqzcpf6zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme4/LMACgkQ2O7X88g7
+po8/w//USE1SvL8VDfI7pF4l7synEjvmNt65EeWbrGVCgq13Zd3O+jInXEwwCyd
LOf62z9JES3OW4lxcOiZkerb6P51Rp58Z3repeNMD7q0sjD203+GqkTwxMBNLcoK
KnCy/raWlnclG6HGgy3FEsvSlRMD7g2IFR48oFTtnCHH0sbifp3JJkwd6c4NYZi6
oDMBF1CFLwE/WP3nDiSaCLO+4ak3nySEPFoT73iefkbHlIGzmMnt66BqGbXF1+c2
Xb1INIfFcxaCNLsTQ6CrhxeC/p531iGS4ghLYgR5PUf1OK+TRMHv9NSdU+sBCrY2
iczz7wNwgbTTmuf0wyhMoDBIxJgARgnXZ4wIlA01f5DgUzUHLTRn/JHz5FRzvla3
vsGamzOm00h0JLt+VmXt7tpBvGtdL1de7E5VPBZfj8O5NOgFyyu3GlJ53bWpHT2y
HdGUFMMRJ0gPv0cAkgjgtTcGbpXj2c+WeYEPWgDD4cvXx9osLjpaaulISwBHMjun
lzIoqzLGA1t1DWUlXEudCp1MbnG2XFqmeIGpXZ5xnwNbNMWHI/4df2ATHP0AfvSD
PsleOJTykU7KTheKoMH0NOcSvAz+TyHxr9je7PcDgdXon1RbNkxvkHKaeHLUmLzu
VZ1GgN8FLG2PPEllpSSvn0CfWM/OXakT0+Cesvu1v4EJyvf2ecg=
=B/+S
-----END PGP SIGNATURE-----

--lvvupexgqzcpf6zr--

