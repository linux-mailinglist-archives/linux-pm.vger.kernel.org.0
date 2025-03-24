Return-Path: <linux-pm+bounces-24459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE03A6DE10
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8AB170161
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C952261582;
	Mon, 24 Mar 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="PN1thBNn";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="M2MjGxNs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA933261575;
	Mon, 24 Mar 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829330; cv=pass; b=LgTaDb+qZ+3GVycoDmZpdVnB38xWQI+GEgDxf+jIdvgR/eG2+HkKGZ2H2YgY/nt3F23o+CAUl3WSpgOAIcWSiDMj9sabqKj9FP0JsPHtTT96WLF7PH8ktwBdhySrgRU2twJ1u8sM266xFHHx2QRDdjo8FUcnNgBdb3npFGct+rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829330; c=relaxed/simple;
	bh=qRLDppWR5LoVnYVUmF6CDiqI605Y1BJ9C0a6P+AYzVw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NTF7uLCAsKXv8Qo/zSQVzhtoVL5hNKXZu+Fm7gKuZ4osMcgaC5/ZJKwlk2+sVQfg45qTl68Y0LKj/u48VAgaVnU4OShHW0WgYANZzaJxIreLSN9iCqdHzhWQhq2veLvZwZepnX7ZAfCH0JJc3QzgiK1j5KJ5RJaPdkkkBWNG1Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=PN1thBNn; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=M2MjGxNs; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1742829138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LwKPPtVaQbMn7g3swvfDPjL4Dk+BjB6dvzSPxCG87nKmQXvi21/CxZxuvz7VHhl9Et
    rMR02P2/8DbTy2ce+InE+EznG/es8jpztV1xblxxuQXlS43dRqDXRrt1Wm0H/zfJWafU
    Gsj9xzjnOD//sX0CVfrAi2ZjRweTD6Ka72gI7RxMSt/s8UTo/ziGiAXKUSDyYKGBv8Bw
    pL9lsIlTNPDurm2kJTdrM/oqmbIQYg66ottvS/WiqiHOso+C4HX6xpjGz5IxQfNQcmf/
    TC5S6/bZPYIVL09DJJQBxFDdVrbV8V1cgRopjx/8iUZoUVH1aU7XcFD5X4NhQg3mRHU9
    t3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742829138;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n5gVZ0trSyVTDwSeZDvbGSX/kVBa3zM48mak76QzcCs=;
    b=CnNSe+QagkNdf6spdA43LkY0Xj8gnts4esjzjYbiXCGLKaQk/mOnhUiP9wVtIcr2fv
    pPdMnRgE88wvfvGoB5Jh1Hd6PmkYPmFXg+KtG2DjlTzC221Pvw3hoq2AUE+cXDsmSJPM
    E7BGC266ifrDeBymC7JuxraAWLgcGIWRG8WE1ZLpYagxwBWAjBLcYSUJli4RkYgAWT+y
    AbDdvmuepT3QzvExXorwN+cKNkZO0/HsILbIVGR4VLhMAD7zSXyDFUe0bcPXd/zb08tj
    FBAYydBjlGS2isOcRL8VcUgd5LKufv0BCNP0RcPbe7JMoVmcbUlsKCodsUNO6z8RReCW
    CfRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742829138;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n5gVZ0trSyVTDwSeZDvbGSX/kVBa3zM48mak76QzcCs=;
    b=PN1thBNn89AaUQ2u7qY9/N3Uq2BMKV/l1wGEaXtwSMy4KI/Z9Bq+Iu04yQ4sx65wSK
    t5nx3xda5Z3BDmr7mFYP4FbYwteuR7ko4BVse093NIaUzBV3QGTohGq54N/kwD+HeXCc
    LJ2UI9TyqZ17i9ZxAr3LJMAhaN9WKYz6m034b/RawL0gByn0YP4lmpldbGcGXnja4+wD
    Csf+L3mpvpsmhsskKj8AxNZRO01dbwoOFsWESIyPdG2ZUCPehPlXH091Gd+5L+F+SwHh
    THgSO4dEi1nRoIF67NB4X5wHe0n0vphfn2aZAlwG3tPEfYChOM6e/UgwzOOnd9T/MzLw
    c7qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742829138;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=n5gVZ0trSyVTDwSeZDvbGSX/kVBa3zM48mak76QzcCs=;
    b=M2MjGxNsYfyQQv6Zsxxl7uh9pAs+4KsWnsCr3TrhNIR5SXjsK5YT5pOFm/R6whqgK0
    VL0f+ugqxwU1T+wY/NCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeDsZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc12OFCHcFK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 24 Mar 2025 16:12:17 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] power: supply: bq27xxx: do not report incorrect zero
 values
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20250322161718.253093-1-absicsz@gmail.com>
Date: Mon, 24 Mar 2025 16:12:06 +0100
Cc: Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 pali@kernel.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A77FAC9F-3CA2-4E53-9A36-8ADB5E16D17C@goldelico.com>
References: <20250322161718.253093-1-absicsz@gmail.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi Sicelo,

> Am 22.03.2025 um 16:43 schrieb Sicelo A. Mhlongo <absicsz@gmail.com>:
>=20
> On the bq27x00 and bq27x10 variants, a number of conditions can reset =
the
> value stored in the NAC register. This will cause capacity, =
time-to-empty,
> energy, and charge to report the value 0, even when the battery is =
full.
> On the other hand, the chips provide a flag, EDVF, which reliably =
reports
> the true battery empty condition, when these properties are really =
zero.
> Therefore, discard readings for these properties if their value is 0 =
while
> EDVF is unset.
>=20
> Tested on the Nokia N900 with bq27200.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
> drivers/power/supply/bq27xxx_battery.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
> index 2f31d750a4c1..8e5795c5754e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2107,6 +2107,15 @@ static int =
bq27xxx_battery_read_dmin_volt(struct bq27xxx_device_info *di,
> return 0;
> }
>=20
> +static bool bq27xxx_value_is_valid(struct bq27xxx_device_info *di, =
int value)
> +{
> + /*
> + * On bq27xxx_0_zero, consider zero values invalid if EDVF is not set
> + */
> + return value || !(di->opts & BQ27XXX_O_ZERO) ||
> +       (di->cache.flags & BQ27000_FLAG_EDVF);

Hm. This still can return -EINVAL for a valid and successful readout of =
value =3D=3D 0 which
could happen for a fully drained HF08 in the GTA04 with bq27000.

Here is an excerpt from running a battery until depletion:

root@letux:~# echo off >/sys/class/power_supply/twl4030_usb/mode
root@letux:~# while true; do echo $(date) $(cat =
/sys/class/power_supply/bq27000-battery/capacity)%; sleep 1; done

Mon Mar 24 14:37:11 UTC 2025 1%
Mon Mar 24 14:37:12 UTC 2025 1%
Mon Mar 24 14:37:13 UTC 2025 1%
...

Mon Mar 24 14:38:24 UTC 2025 1%
Mon Mar 24 14:38:25 UTC 2025 1%
Mon Mar 24 14:38:26 UTC 2025 1%
Mon Mar 24 14:38:27 UTC 2025 1%
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:38:28 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:38:29 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:38:30 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:38:32 UTC 2025 %
...
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:53:39 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:53:40 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:53:41 UTC 2025 %
cat: /sys/class/power_supply/bq27000-battery/capacity: Invalid argument
Mon Mar 24 14:53:42 UTC 2025 %
Mon Mar 24 14:53:43 UTC 2025 0%
Mon Mar 24 14:53:44 UTC 2025 0%
Mon Mar 24 14:53:45 UTC 2025 0%
Mon Mar 24 14:53:46 UTC 2025 0%
Mon Mar 24 14:53:47 UTC 2025 0%
Mon Mar 24 14:53:48 UTC 2025 0%
Mon Mar 24 14:53:49 UTC 2025 0%
Mon Mar 24 14:53:50 UTC 2025 0%
Mon Mar 24 14:53:51 UTC 2025 0%
Mon Mar 24 14:53:53 UTC 2025 0%

...

Mon Mar 24 15:10:12 UTC 2025 0%
Mon Mar 24 15:10:14 UTC 2025 0%
Mon Mar 24 15:10:15 UTC 2025 0%
--- here device did shut down ---

This means that the capacity can go to 0% for approx. 15 minutes before
the BQ27000_FLAG_EDVF becomes set and 0% is reported. I would prefer not
to see the EINVAL in between.

This all may end that we have to add another DT property to tell the =
driver
if the bq27xxx is inside a battery or the battery is removeable and only =
check
for value=3D0 in the latter case?

Or can you limit this logic to the bq27200 because it is unlikely that =
the
i2c variant is used inside a battery pack and the HF08 battery uses the =
hdq
variant?

BR,
Nikolaus

> +}
> +
> static int bq27xxx_simple_value(int value,
> union power_supply_propval *val)
> {
> @@ -2147,6 +2156,8 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> ret =3D bq27xxx_battery_current_and_status(di, val, NULL, NULL);
> break;
> case POWER_SUPPLY_PROP_CAPACITY:
> + if (!bq27xxx_value_is_valid(di, di->cache.capacity))
> + return -EINVAL;
> ret =3D bq27xxx_simple_value(di->cache.capacity, val);
> break;

> case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> @@ -2157,9 +2168,13 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> break;
> case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE, val);
> + if (!ret && !bq27xxx_value_is_valid(di, val->intval))
> + return -EINVAL;
> break;
> case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP, val);
> + if (!ret && !bq27xxx_value_is_valid(di, val->intval))
> + return -EINVAL;
> break;
> case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> ret =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF, val);
> @@ -2171,10 +2186,13 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> break;
> case POWER_SUPPLY_PROP_CHARGE_NOW:
> - if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR)
> + if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR) {
> ret =3D bq27xxx_battery_read_nac(di, val);
> - else
> + if (!ret && !bq27xxx_value_is_valid(di, val->intval))
> + return -EINVAL;
> + } else {
> ret =3D bq27xxx_battery_read_rc(di, val);
> + }
> break;
> case POWER_SUPPLY_PROP_CHARGE_FULL:
> ret =3D bq27xxx_battery_read_fcc(di, val);
> @@ -2199,6 +2217,8 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> break;
> case POWER_SUPPLY_PROP_ENERGY_NOW:
> ret =3D bq27xxx_battery_read_energy(di, val);
> + if (!ret && !bq27xxx_value_is_valid(di, val->intval))
> + return -EINVAL;
> break;
> case POWER_SUPPLY_PROP_POWER_AVG:
> ret =3D bq27xxx_battery_pwr_avg(di, val);
> --=20
> 2.49.0
>=20


