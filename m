Return-Path: <linux-pm+bounces-22592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E4A3EA1B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5175D16D7A3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56314900B;
	Fri, 21 Feb 2025 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="itRXIxOG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7A8821;
	Fri, 21 Feb 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101608; cv=pass; b=npQieGnl6JFBH/UT+jQJ5vNRoGCZ8XC4G7tb89vTec75kMJgZjG8JOhh7Qbt8Ft2roWaqfRVspCDXFcQotT6xva77GKa1+PyVKIS0jYf6ELWkJx4O2sHnjWv2B/YfSQ1+fMCj18bR/fHrNqPqiDg7ltdJFVRvw9SaP3ZqNCoBA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101608; c=relaxed/simple;
	bh=o33pwbuH1evJu89J8hvR+bYQmhGcQ1T2m/aFyDanxJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU4hrPaAQJbbCiherqGNEMpErT7pQ1o6lvgS1Fw1Cff7pEVFGZuobPFBFepgF/h/9M3xTjD3wVZJoZMS+HDk29UrnJuihQNgRkfrQU/f5HlQf149HdVXGW7YYyjrK6uFCaUzqBKchcEHuQtrUxECm5MCxy/0sbMpDCcpl2W7FwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=itRXIxOG; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740101602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HAT1r6J54x35Ppm4BenlbUWdF6STRs6kuL9i5cbTAMlpYPLc0MPPXcHUoAj0iVWPrEA171rs/70SlE1h4J6k1rNXzm4CN1AuH/u6OxpRPeSlsWKLqZT4B+xrSZFqtZ96kXbJVndIbNADrc8fkXgSwCRO+q+kjdA79Q4OXKRKvwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101602; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tQht+34lIxJNSwc+ccvUdq1ZsW2OpX433gbl+UpStMk=; 
	b=FyUVZUnw+8iktKD67u7ikjjzAiAJKKSuNWvRHDwg8XBY3YeJGOkqnQ3SHrbpE30zDv9hXXELFNUBbxHh9Jr4ogew659/Nm2kGI+vOKJoVPGh9Bp8NAuYv2c5au8NUmIGJKSIoCU6PlsZzI3bZaU1d1hrDSyxLjwxr5YHKgB3mGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101602;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tQht+34lIxJNSwc+ccvUdq1ZsW2OpX433gbl+UpStMk=;
	b=itRXIxOGOaRSkEowr5JcF6ebEcUvqYvGT/k7qIH5zLMYbQG0ncXF4aM2wocjp7Hr
	call+ZnsmunkrfSZt4SNolnkWNimpXlg3ZcAkfXHzRhaX8azS6Zbbr2PRoSQuXsSxp/
	XV/RTYHHlWXkKDxQBQW7vdsJA5CkDKJ9G2XLDcI0=
Received: by mx.zohomail.com with SMTPS id 1740101598870914.1407595261836;
	Thu, 20 Feb 2025 17:33:18 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 68A741835E9; Fri, 21 Feb 2025 02:33:16 +0100 (CET)
Date: Fri, 21 Feb 2025 02:33:16 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Message-ID: <7la3x6f733ju4szqlzmtr277ah7c7lb4d4gcmjgu2rjj5uzpyd@43dmenbpczjs>
References: <gw2ciofohbyv6u6pt2iqmy64al2suk5vzaixoyofetsugmyep7@nmymx3vgllwe>
 <20250220064321.4641-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k6e73tnxdj52mklu"
Content-Disposition: inline
In-Reply-To: <20250220064321.4641-1-mitltlatltl@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/240.28.25
X-ZohoMailClient: External


--k6e73tnxdj52mklu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
MIME-Version: 1.0

Hi,

On Thu, Feb 20, 2025 at 02:43:20PM +0800, Pengyu Luo wrote:
> On Thu, Feb 20, 2025 at 8:24=E2=80=AFAM Sebastian Reichel <sebastian.reic=
hel@collabora.com> wrote:=20
> > On Tue, Jan 14, 2025 at 01:51:27AM +0800, Pengyu Luo wrote:
> > > On the Huawei Matebook E Go tablet the EC provides access to the adap=
ter
> > > and battery status. Add the driver to read power supply status on the
> > > tablet.
> > >
> > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > ---
> > >  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
> > >  drivers/power/supply/Kconfig                  |  10 +
> > >  drivers/power/supply/Makefile                 |   1 +
> > >  drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++++++=
++
> > >  4 files changed, 606 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
> > >  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Doc=
umentation/ABI/testing/sysfs-class-power-gaokun
> > > new file mode 100644
> > > index 000000000..b1eb9e8d7
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > > @@ -0,0 +1,47 @@
> > > +What:                /sys/class/power_supply/gaokun-ec-battery/smart=
_charge
> > > +Date:                January 2025
> > > +KernelVersion:       6.12
> > > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > > +Description:
> > > +             This entry allows configuration of smart charging behav=
ior with
> > > +             four parameters. The format is: <mode> <delay> <start> =
<stop>.
> > > +
> > > +             - mode: Defines the charging mode (1 or 4). Mode 4 enab=
les delay,
> > > +                     while mode 1 does not.
> > > +             - delay: Specifies the delay in hours (non-negative). T=
his is
> > > +                     only used when 'mode' is set to 4.
> > > +             - start: The battery percentage at which charging start=
s (0-100).
> > > +             - stop: The battery percentage at which charging stops =
(1-100).
> > > +
> > > +              When the laptop is connected to a power adapter, it st=
arts
> > > +              charging if the battery level is below the 'start' val=
ue. It
> > > +              continues charging until the battery reaches the 'stop=
' level.
> > > +              If the battery is already above the 'stop' level, char=
ging is
> > > +              paused.
> > > +
> > > +              When the power adapter is always connected, charging w=
ill
> > > +              begin if the battery level falls below 'start', and ch=
arging
> > > +              will stop once the battery reaches 'stop'.
> > > +
> > > +              If mode is set to 4, the above charging mode will only=
 occur
> > > +              after the specified delay in hours. If mode is 1, ther=
e is
> > > +              no delay.
> > > +
> > > +             Access: Read, Write
> > > +
> > > +             Valid values:
> > > +                     - mode: integer value (1 or 4)
> > > +                     - delay: integer value, delay in hours (non-neg=
ative)
> > > +                     - start: integer value, battery percentage (0-1=
00)
> > > +                     - stop: integer value, battery percentage (1-10=
0)
> >=20
> > There are common properties for start and stop charging percentage,
> > which should be used:
> >=20
> > * POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> > * POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
> >=20
>=20
> Agree, but at least, we should pass delay, start, end. EC only
> providedone interface to set mode and delay, that requires 4
> arguments, we can handle it with 3 arguments, as you suggested
> below. but if we treat start and end separated, then if we want
> to set smart charge, we set start, set end, set delay(read start
> read end, then set them again). It is a bit redundant.

Yes, if these are separate properties you won't get atomic updates.
But is that really a problem? Using the standard properties means
that you get UI support in the future. I know at least the GNOME
people are working on this.

> > For the charge mode it seems there is no need to expose anything.
> > You can have a single property for the charge delay in hours. If
> > '0' is written to it there is no delay, so you can use mode 1 and
> > otherwise you can use mode 4. There is no need for this multi-value
> > mess. The delay thing seems to be quite specific to this EC, so a
> > custom property for that is fine.
> >=20
>=20
> Agree, mentioned above

[...]

> > > +static void gaokun_psy_init(struct gaokun_psy *ecbat)
> > > +{
> > > +     gaokun_psy_get_bat_present(ecbat);
> >=20
> > why?
> >=20
>=20
> EC provided a way to check if battery is presented, if there is no
> battery, then we don't fetch battery info, but other info
> (i.e. adapter) is still available.

nevermind, I miss-read and wondered why gaokun_psy_bat_present is
being called twice.

> > > +     if (!gaokun_psy_bat_present(ecbat))
> > > +             return;
> >=20
> > You only call it in your probe function, so the following will
> > remain uninitialized if the battery was not present at boot time.
>=20
> mentioned above, keep them uninitialized is unharmful.

Does the battery not support hot-plug?

-- Sebastian

--k6e73tnxdj52mklu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme319EACgkQ2O7X88g7
+przSw/+MKN0ywjTzEEp3MskrerIkugE9sHneVb4hoAYEkrjFNzOl85WIpqxN/1L
TeEGKyRyzxk4Sv8QpG4nn8EV7dvoOZ08TocF5IO0jMDZrpxU9xU0H8tWXec2nkmX
ExsSkrd2l/CLsqN1XOPnDunvYzb/pnOEn53KfFBbOHvBWuBvmL+0ne5VyCjXp6Jh
B4p/GKmQC+q7Gi+dcb+Muf7heXtTDZ4CPHE5GEwQcGpzVbiqow4lMWWVc7S9xzFG
iVrdfKeDX/9D4jw5vJa7jivshVJdEiX7Q6/WDqMCO9AitBINcWT80KD+jhxktUIL
qPtLAhdxKaAGB/i8zILgfe1sCO2Y+ydfVhXmG6GcNmfmMe0bDssGiQ3lvQeyqckp
e5NxlKSRdYoTnHXdjxa+BK4/qUbJDksMEtZCTalqueHXTnAE1FmGBMCfK9wb5mNJ
nD6kmVDkMZskpBcISmGW9fERtHggp+FWYPAdyHvsyQbbesamNwCSLKLlmr7lB/nH
b04xfop7s74LLUpqU+CYbNqdQZxHdl5bzROr3Ev4rkpkuIrYJUPCFkLtHAACsxaw
jmQkjPZASMa+b808SE1MJ2rUzWbJ3Muw5y4w7S704S2ZLIE7pPDSLOCzgEhPhNde
bZ/UGzrhEbe7tUNbVptBjDgH+i5pLXMrq+AI2PC7fSJRwwAiDyE=
=U18h
-----END PGP SIGNATURE-----

--k6e73tnxdj52mklu--

