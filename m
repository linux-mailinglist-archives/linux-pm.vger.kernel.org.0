Return-Path: <linux-pm+bounces-31957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307DB1B141
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8184A7AE83E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE926C39F;
	Tue,  5 Aug 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GJ2ytIwv";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="aVVZmfBJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B8134AC;
	Tue,  5 Aug 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386510; cv=pass; b=XItjcH+YSs+O/EVMy3YJAR5BwbXTaAAHiOV35vPjEdIPDVxiUbz2kdnr64JsVYc2CTRkA1kYjppjSFVZi8I0+RoDQWE7uJi9LsSMbYrobWX75/X9EnDCcHtuLbRpVRMBkZeil/8HePABh3Wgx+3RWEuXRGx9sSPQAHiy+Sa7j1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386510; c=relaxed/simple;
	bh=9MfVy+lxDrD75Ox5ECCp+msLJBjzC81QBDPWn23C6JQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FfltaG73A5G/ljMZqC4t4lvolIphz9LaglCHfv4ygxyMba/IgFsc8Qyx2uaRfj55yb0p2C9olmjGZnsxB/+YxXah43FyBB2WULGnXq/VfHVdLLavkhUEuFCSPobzYWDoR2nYk8BPzIuNtf4XugpgUJ9XV5tdei+H5oCpJAzunkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=GJ2ytIwv; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=aVVZmfBJ; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1754386137; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l/w6KcKOuIS7LUdG4Ix/jF/a9zUEXzHZ92ukmnfKVNfuR3hxpFm5BarUNBkdxb6ta8
    YSBioEWKSRDg7cY7mhnDRo+GdXrzao8vX6OClB+d8I7MkCZOkji1lM2Qwyi2AY5XD99b
    pxl0zkk8jz8IOF/2UaY0qfKHI2Gc3vpfw+gDsR5MEC2NMi6Wo2UaK28WXC5QukBjqwHn
    TltYClzZnWNppw603e5mPopOxL1TEx/Cv66pUXamlhpcNvOuYXf8ETLz51Rx9d5Dr4+m
    hg1IZ3pTMPAZX7XsqnelQx6ES99UvTASqe/yTn7aoZMG5Zce2h3N8QsuZ84zcBSQ7jgu
    xuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1754386137;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8G8/k+nPGic7BC3JBra8A7ttqgGnR4V1hT1DFa/NooQ=;
    b=Zp2kUXyNc/4Tb4Je1p9zrxn/JqIwarui7zyNVPO10rTPAi2jdLZzRloUws4g0Whrfd
    xwdHQV09h2JbKD13uClEfH34B80DDwQu3qWGIjfImplEXTmfcCeUYPPxdCMWkjtniXJw
    Pkxm06rHK+9dnhWu1QUJpnedu1gXpBnTgJ//zQ5UuU+d9tgNhgdbH3xIF9AzY2nbmP9U
    TyLdpeiFgW2wPlzqBCVy2whG+75xrr1BQ1pLmlT6bobZMIcSkvFVlxbfyJ7lH35mjAaH
    Z5KiUVfg5csf/m13nyMrvvKmXH86hmOOJZSFn8x6JNb7O05uwmQKQAcq77uahmz6DMeD
    ScBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754386137;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8G8/k+nPGic7BC3JBra8A7ttqgGnR4V1hT1DFa/NooQ=;
    b=GJ2ytIwv2wtppNHHYkPqi8gJ8cz3f6xR4iQH6OlvNRL9+4v3Oun2ORtbMtYwEgCCY2
    KJMemsk6VMjkq5f4rzV6y7xTCVhVhwJmBdlNw5NtigJYCQUHl1Z0rkm6RZ5qdnKJ1mkb
    P5T0NyKPgxjvbxSghYnVdtrfx7w12USQ+cqceUEXT5j8A4uIEmtq6tIkus2taVkugisG
    9y7usO2m3BTYBG9fjdoHy9jav4Yw5jisna9Z2p9+xpIOc7yq/YtGDSMf9OPD2YgoABEC
    8wg2l2UnKyqlXY8O9YPF5sWyOU9t0U63OQlyEPAhcxOqfp5dNI45y1vUGnLY3i6U69oH
    kblA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754386137;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8G8/k+nPGic7BC3JBra8A7ttqgGnR4V1hT1DFa/NooQ=;
    b=aVVZmfBJYcCxals6j19JWh2TdATsM+QGnx3sH9asI8m0YdeytJJ2C5uYfMItOkLJFI
    fogqAp5X4Avngv4OlmDw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfjEZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a41759Sujl3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 5 Aug 2025 11:28:56 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
Date: Tue, 5 Aug 2025 11:28:46 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>,
 "andreas@kemnade.info" <andreas@kemnade.info>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2437B077-0F51-4724-8861-7E0BEE9DB5F0@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
To: Jerry Lv <Jerry.Lv@axis.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Jerry,

> Am 05.08.2025 um 10:53 schrieb Jerry Lv <Jerry.Lv@axis.com>:
>=20
>=20
>=20
>=20
> ________________________________________
> From: H. Nikolaus Schaller <hns@goldelico.com>
> Sent: Monday, July 21, 2025 8:46 PM
> To: Sebastian Reichel; Jerry Lv
> Cc: Pali Roh=C3=A1r; linux-pm@vger.kernel.org; =
linux-kernel@vger.kernel.org; letux-kernel@openphoenux.org; =
stable@vger.kernel.org; kernel@pyra-handheld.com; andreas@kemnade.info; =
H. Nikolaus Schaller
> Subject: [PATCH] power: supply: bq27xxx: fix error return in case of =
no bq27000 hdq battery
>=20
> [You don't often get email from hns@goldelico.com. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Since commit
>=20
> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>=20
> the console log of some devices with hdq but no bq27000 battery
> (like the Pandaboard) is flooded with messages like:
>=20
> [   34.247833] power_supply bq27000-battery: driver failed to report =
'status' property: -1
>=20
> as soon as user-space is finding a /sys entry and trying to read the
> "status" property.
>=20
> It turns out that the offending commit changes the logic to now return =
the
> value of cache.flags if it is <0. This is likely under the assumption =
that
> it is an error number. In normal errors from bq27xxx_read() this is =
indeed
> the case.
>=20
> But there is special code to detect if no bq27000 is installed or =
accessible
> through hdq/1wire and wants to report this. In that case, the =
cache.flags
> are set (historically) to constant -1 which did make reading =
properties
> return -ENODEV. So everything appeared to be fine before the return =
value was
> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, =
triggering the
> error condition in power_supply_format_property() which then floods =
the
> console log.
>=20
> So we change the detection of missing bq27000 battery to simply set
>=20
>        cache.flags =3D -ENODEV
>=20
> instead of -1.
>=20
> Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
> Cc: Jerry Lv <Jerry.Lv@axis.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> drivers/power/supply/bq27xxx_battery.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
> index 93dcebbe11417..efe02ad695a62 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1920,7 +1920,7 @@ static void =
bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>=20
>        cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, =
has_singe_flag);
>        if ((cache.flags & 0xff) =3D=3D 0xff)
> -               cache.flags =3D -1; /* read error */
> +               cache.flags =3D -ENODEV; /* read error */
>        if (cache.flags >=3D 0) {
>                cache.capacity =3D bq27xxx_battery_read_soc(di);
>=20
> --
> 2.50.0
>=20
>=20
>=20
> In our device, we use the I2C to get data from the gauge bq27z561.=20
> During our test, when try to get the status register by bq27xxx_read() =
in the bq27xxx_battery_update_unlocked(),=20
> we found sometimes the returned value is 0xFFFF, but it will update to =
some other value very quickly.

Strange. Do you have an idea if this is an I2C communication effect or =
really reported from the bq27z561 chip?

> So the returned 0xFFFF does not indicate "No such device", if we force =
to set the cache.flags to "-ENODEV" or "-1" manually in this case,=20
> the bq27xxx_battery_get_property() will just return the cache.flags =
until it is updated at lease 5 seconds later,
> it means we cannot get any property in these 5 seconds.

Ok I see. So there should be a different rule for the bq27z561.

>=20
> In fact, for the I2C driver, if no bq27000 is installed or accessible,=20=

> the bq27xxx_battery_i2c_read() will return "-ENODEV" directly when no =
device,
> or the i2c_transfer() will return the negative error according to real =
case.

Yes, that is what I2C can easily report. But for AFAIK for HDQ there is =
no -ENODEV
detection in the protocol. So the bq27000 has this special check.

>=20
>        bq27xxx_battery_i2c_read() {
>                ...
>        if (!client->adapter)
>         return -ENODEV;
>                ...
>                ret =3D i2c_transfer(client->adapter, msg, =
ARRAY_SIZE(msg));
>                ...
>                if (ret < 0)
>        return ret;
>                ...
>        }
>=20
> But there is no similar check in the bq27xxx_battery_hdq_read() for =
the HDQ/1-wire driver.
>=20
> Could we do the same check in the bq27xxx_battery_hdq_read(),
> instead of changing the cache.flags manually when the last byte in the =
returned data is 0xFF?

So your suggestion is to modify bq27xxx_battery_hdq_read to check for =
BQ27XXX_REG_FLAGS and
value 0xff and convert to -ENODEV?

Well, it depends on the data that has been successfully reported. So =
making bq27xxx_battery_hdq_read()
have some logic to evaluate the data seems to just move the problem to a =
different place.
Especially as this is a generic function that can read any register it =
is counter-intuitive to
analyse the data.

> Or could we just force to set the returned value to "-ENODEV" only =
when the last byte get from bq27xxx_battery_hdq_read() is 0xFF?

In summary I am not sure if that improves anything. It just makes the =
existing code more difficult=20
to understand.

What about checking bq27xxx_battery_update_unlocked() for

       if (!(di->opts & BQ27Z561_O_BITS) && (cache.flags & 0xff) =3D=3D =
0xff)

to protect your driver from this logic?

This would not touch or break the well tested bq27000 logic and prevent =
the new bq27z561
driver to trigger a false positive?

BR and thanks,
Nikolaus


