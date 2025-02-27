Return-Path: <linux-pm+bounces-23123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753C3A48664
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6415E3B0138
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12031B424E;
	Thu, 27 Feb 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="XlznAC86";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HGQSJ62M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BE14BF8F;
	Thu, 27 Feb 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676674; cv=pass; b=jm0y9PgXC5oDP5lk1oEt2+eOMkjyMtZsj46fZyo3x7YvS7gKcarUOOisZJa4dLNIDqTLMv6r95Z6i8sCHMcJuPZFo2JVfSf4/SUvVr3sYgNMRya+38jo2W/eky7u6oawU0YkJ376tvRXlz6O6iuAjtfQGNcU0z2MaVbdqImDH+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676674; c=relaxed/simple;
	bh=y06iA5I1qeM8oIEPp7j7kmLLFB0pB/hsmxWdQNVQQrM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l08hJ3Lcf9D5g29Xx8SaQMgfGRhi/bLq8QhcYNX2MZ9mPkE09sOyKztXV7ZM5LjGkdCkefGG46UmNqHzSw5MWuIGqP0DRU56cLaBGsLmmsNfdunC+g1NpkQ3W/wBD6viQjQmCvkox7kxtEUm09v0MuKYtXjBYDSxUdYZ7gw9RcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=XlznAC86; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=HGQSJ62M; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1740676489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jjhRG79KFF0KrbRPxTFDxskqy1LCWHLDaQ0wDkp1qSoqwwSoyC5A3QmCPIbcpPZbzi
    ZsF06w+JvQnVgZNCjfa3GxurDPUpXXYfhSoS0g08Ai66sQ57gfyQE7Wq9r9IUu4KzY8p
    7QXkA73o6EzckO59uooMUdtO8a91pLcsmRoI1s4t194DhNfKUjTXYEt7DYzPcZ3BaDP6
    NRKz6YJDgL4bW9TZAtk/XuXE1i6TKmaJKMegXETpVWyH48jMUUlro+37tiq9fjAXmgPV
    XDvyJtcd2s6iocl29CyU5JFClMcsT9Et8uw5bqonicvMjXU7vWd2Y0HYywKOUz/WtH2K
    N2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740676489;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=S4ewhDrV2yuQ36rg57uhXQoD3xo+cspYXzqE3QUuqLQ=;
    b=TVU0jeJ7Pu8emAWkhvgIuTzWvwKPOH3R4+ifV1cMP5hPepHhvRXYB00m3yWC0UdrZQ
    KGeKG7Q94tK3uo3AzmoNcSzV1oM0g/mQ0u0GPj4XCNIWyom8xe6DVnCmrtVpTEvdssp4
    oow42ZKGGoxknu4PpPNojPjPJUXJUd5zQbD5iNTz88R9vcO0VRj947R1BJlcGkvfeNez
    RxeF6UITHoW3g/V8AvbE2YTRRJuRQZfLCsZzpge4VfS4DryVmkB0dv42PjA2HnFEV3Hj
    VOWNvzVr6EOHjYSugcRO04KpRKqzSakvRJ82LH43AhB1MbmMuI3XRY35nzUzR5iUpw1U
    GUfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740676489;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=S4ewhDrV2yuQ36rg57uhXQoD3xo+cspYXzqE3QUuqLQ=;
    b=XlznAC86Rc8P8EXtHeUeNmUoN+au7QqoWkZu7vnXKont3ub1k3Crt8qpZKYSqPGsLk
    AhDfLNVCbteQT0xzHgKDwkmbnLQk6kWJv7fxMCOQwSd00BmlaEveMNhGkxSl5+GOS+xU
    bKX70sL0j3gVVKQgPY42Xq8djAkjPyz1rMam4jAVcvKZbOROv6FwJbpaiOedcX+gOBWQ
    jVHRCozDrEvHj52/l9qJDMdTdpiFgcmEVlKtLN8ksvsDu3qogR6YitjSb3NZJvt+5I8D
    cIFwmlEB1TMjvViyLBdNYlDekcUPnInNz8/9PwvvZvw3ff+wsoxQy3DE4IkMaecRibFQ
    loOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740676489;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=S4ewhDrV2yuQ36rg57uhXQoD3xo+cspYXzqE3QUuqLQ=;
    b=HGQSJ62M999yRwTnUbcRGzPFZNOktSm3b8sY0nBWIgZSJHRBF7qK0W3RKMTxhbH7HW
    AW5IBfsWAnGsFHi2BUDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzkZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc11RHEm3CG
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 27 Feb 2025 18:14:48 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20250207220605.106768-1-absicsz@gmail.com>
Date: Thu, 27 Feb 2025 18:14:37 +0100
Cc: pali@kernel.org,
 Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi,


> Am 07.02.2025 um 22:51 schrieb Sicelo A. Mhlongo <absicsz@gmail.com>:
>=20
> On the bq27x00 and bq27x10 variants, a number of conditions may reset =
the value
> stored in the NAC register. This will cause capacity, energy, and =
charge to
> report the value 0, even when the battery is full. On the other hand, =
the chip
> also provides a flag, EDVF, which accurately detects the true battery =
empty
> condition, when capacity, charge, and energy are really 0.  Therefore, =
discard
> readings for these properties if their value is 0 while EDVF is unset.
>=20
> Tested on the Nokia N900 with bq27200.

I finally found time to test this patch on the GTA04 which uses an =
OpenMoko HF08
battery which comes with a built-in bq27000.

The result is that I can't read the =
/sys/class/power_supply/bq27000-battery/charge_now
at all and always get EINVAL. Independently of the charge level reported =
without
your patch.

If I remove this patch again, the values are reasonable as in all the =
years before.

What I don't know is how and to which values the EEPROM of the bq27000 =
has been
factory programmed so that the HF08 battery maybehave differently from =
yours.

Finally, I am not aware of reports from GTA04 users that the value =
stored in the NAC
register is being reset as you describe and capacity, energy and charge =
to be falsely
reported as 0.

So please restrict this patch to the N900.

BR and thanks,
Nikolaus

> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
> drivers/power/supply/bq27xxx_battery.c | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
> index 90a5bccfc6b9..df92f55c63f6 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2115,6 +2115,10 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> break;
> case POWER_SUPPLY_PROP_CAPACITY:
> ret =3D bq27xxx_simple_value(di->cache.capacity, val);
> + /* If 0 is reported, it is expected that EDVF is also set */
> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
> + return -EINVAL;
> break;
> case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
> ret =3D bq27xxx_battery_capacity_level(di, val);
> @@ -2138,10 +2142,15 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> break;
> case POWER_SUPPLY_PROP_CHARGE_NOW:
> - if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR)
> + if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR) {
> ret =3D bq27xxx_battery_read_nac(di, val);
> - else
> + /* If 0 is reported, it is expected that EDVF is also set */
> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
> + return -EINVAL;
> + } else {
> ret =3D bq27xxx_battery_read_rc(di, val);
> + }
> break;
> case POWER_SUPPLY_PROP_CHARGE_FULL:
> ret =3D bq27xxx_battery_read_fcc(di, val);
> @@ -2163,6 +2172,10 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> break;
> case POWER_SUPPLY_PROP_ENERGY_NOW:
> ret =3D bq27xxx_battery_read_energy(di, val);
> + /* If 0 is reported, it is expected that EDVF is also set */
> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
> + return -EINVAL;
> break;
> case POWER_SUPPLY_PROP_POWER_AVG:
> ret =3D bq27xxx_battery_pwr_avg(di, val);
> --=20
> 2.47.2
>=20
>=20


