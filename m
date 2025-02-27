Return-Path: <linux-pm+bounces-23127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56462A486F7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC38B1882429
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF141DE4DD;
	Thu, 27 Feb 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="o4P3lPX5";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="jIAGy4yI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A451B424D;
	Thu, 27 Feb 2025 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678555; cv=pass; b=oqzAcJcnrJWLe7MKQhSylQ9I/YRu3A7QXkBP2AWOH1Xp8DdoJxPhLvX3nQGu8oTFR1hny1u7rPxRGucERQwQLvbBuFHnh76+rEtrZ7fKOhfZxF7msowRnhYlKneKCNKsMrswZG51eDFKwfk1zVuQyh0bHFYt6tg2h9skR9h4ojI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678555; c=relaxed/simple;
	bh=a07aBB5BVHzu4pk7z8KJ25Vh0V81wgacjDB85D8RGqs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BMLK79ubz3iv81Vv+IqoGoq0QYZNstSh8Q+DJ8mRn1xsw7fVYIBTUX+hxHIzRlg29hhoDYOqRCjPSPZthYrO6LvGZsLi4jx+XZf9iRLCBMt9tP5Kd7OUyTRXYPOnatWpIlraCqGtUTwnIAF1hnCg/TfQeduOMaE63+FHbvXgd2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=o4P3lPX5; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=jIAGy4yI; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1740678540; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L2kK8m3k3ORpg39xMYShHWl5g+EPslQ88S4S23FAbiZZvdp+QFFUX7y5rF7130/FHo
    dm7Se7DTwNkBH6qVczBUiKP6fFVYmbVwzaK9UfCTMjXhgOjgThAOnAYBkTKZtQ1MM6kc
    2kagJCbBgzoRuGkEmDUfgr7+2t4U7asSIa6d2BlvO4DlzQsmWSzk2Mcl0JtpOSpSBNPK
    U0VHFQkIh/jqksP/hg8649qUx8ILIrmrk9ohn8IcxarGD6SPQVIe/geG2XDrcmq/7qKz
    9GfCb0DO2u3F74gKyhbWRSs/WU5isnSb12HeVuwzTfAVaRMUof10hEsJJqIA5vGR3vvU
    E08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740678540;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Er8wMxQeYRtvhXWCzM8blE2eJisfYDbpN56pzXEzcJ4=;
    b=slMT8QM1+6T6v+I6uyvh7RG85IQWy24SDY+sWxyBfxRDBc34EefzAAK7zHnMlh8WRR
    l+eUoZoQaVNCFoov6QbJbPeVPzHKZ2yBzNhfgZ7GNloWEeC99WK503tTpna5fdSUtWtb
    xMxpt3H/CyhQn38nZU6z4CHkNFJevEFV943QVbzW0/TOryIqnolxnQ6U+rwb7ca06g0r
    y6fmqXTUJdzJtRhMTOOsYnBzDhCQe8xcF2KE4DAapVzE2uQe+p59TNjLH8W2vG6TW7Zi
    6AyRncAykUmNrCo01/0+1ihouBZjVQ0zMnscLMbCZIhqS2TvDb9aA4pzFXcNK+mNWNvt
    4vaQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740678540;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Er8wMxQeYRtvhXWCzM8blE2eJisfYDbpN56pzXEzcJ4=;
    b=o4P3lPX5i5/SJQQe3ruwF3rBN3BhsYlS0I7vsBneRDFD5s/NdYl8asloTLc+NEhJhg
    fOssKn0QVXdt5R6QavWVC5vha9XbaHbefvIqRUSlwK0ytVzJmIC19/0/MhlpxmJPdEDr
    wtFDjDITZJMqDmHYVe50FQsLEN4uNP2qwZZr8sldjwlQPraKu8yQSdJAp++8Is0ptAkK
    Yq9k6PEpgcXtAt9knF3cdLE1mkDrfGPFtuRmMhgPc7/kS6OZsj9IOjd/hXnsMEfeqOiL
    fJpYk9tRo2u1yvtNciKjn8ncQ+Hch+8thoUIyTIfQCx/BITP1/5ADYwWMI11U1qmEVqG
    AFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740678540;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Er8wMxQeYRtvhXWCzM8blE2eJisfYDbpN56pzXEzcJ4=;
    b=jIAGy4yIJz1G4/qGcIzzDNe62ZyUxpX/pPVXQHdHfGfoPhtt4xNWMPdUIlWIEQFE34
    zghT3aLiDSald+NvEMBw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzkZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc11RHmx3eN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 27 Feb 2025 18:48:59 +0100 (CET)
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
In-Reply-To: <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
Date: Thu, 27 Feb 2025 18:48:49 +0100
Cc: pali@kernel.org,
 Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Another comment (in code section)

> Am 27.02.2025 um 18:14 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi,
>=20
>=20
>> Am 07.02.2025 um 22:51 schrieb Sicelo A. Mhlongo <absicsz@gmail.com>:
>>=20
>> On the bq27x00 and bq27x10 variants, a number of conditions may reset =
the value
>> stored in the NAC register. This will cause capacity, energy, and =
charge to
>> report the value 0, even when the battery is full. On the other hand, =
the chip
>> also provides a flag, EDVF, which accurately detects the true battery =
empty
>> condition, when capacity, charge, and energy are really 0.  =
Therefore, discard
>> readings for these properties if their value is 0 while EDVF is =
unset.
>>=20
>> Tested on the Nokia N900 with bq27200.
>=20
> I finally found time to test this patch on the GTA04 which uses an =
OpenMoko HF08
> battery which comes with a built-in bq27000.
>=20
> The result is that I can't read the =
/sys/class/power_supply/bq27000-battery/charge_now
> at all and always get EINVAL. Independently of the charge level =
reported without
> your patch.
>=20
> If I remove this patch again, the values are reasonable as in all the =
years before.
>=20
> What I don't know is how and to which values the EEPROM of the bq27000 =
has been
> factory programmed so that the HF08 battery maybehave differently from =
yours.
>=20
> Finally, I am not aware of reports from GTA04 users that the value =
stored in the NAC
> register is being reset as you describe and capacity, energy and =
charge to be falsely
> reported as 0.
>=20
> So please restrict this patch to the N900.
>=20
> BR and thanks,
> Nikolaus
>=20
>> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
>> ---
>> drivers/power/supply/bq27xxx_battery.c | 17 +++++++++++++++--
>> 1 file changed, 15 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
>> index 90a5bccfc6b9..df92f55c63f6 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -2115,6 +2115,10 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
>> break;
>> case POWER_SUPPLY_PROP_CAPACITY:
>> ret =3D bq27xxx_simple_value(di->cache.capacity, val);
>> + /* If 0 is reported, it is expected that EDVF is also set */
>> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
>> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
>> + return -EINVAL;

You write:

  Therefore, discard readings for these properties if their value is 0 =
while EDVF is unset.

but the 'val' is not checked at all. Only the error return value
'ret' of bq27xxx_simple_value() which is 0 if reading was ok.

So shouldn't that be:

+ if (!val->intval && di->opts & BQ27XXX_O_ZERO &&
+   !(di->cache.flags & BQ27000_FLAG_EDVF))
+ return -EINVAL;

This could explain why I always get an -EINVAL here since =
BQ27000_FLAG_EDVF is likely not set.

>> break;
>> case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>> ret =3D bq27xxx_battery_capacity_level(di, val);
>> @@ -2138,10 +2142,15 @@ static int =
bq27xxx_battery_get_property(struct power_supply *psy,
>> val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
>> break;
>> case POWER_SUPPLY_PROP_CHARGE_NOW:
>> - if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR)
>> + if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR) {
>> ret =3D bq27xxx_battery_read_nac(di, val);
>> - else
>> + /* If 0 is reported, it is expected that EDVF is also set */
>> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
>> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
>> + return -EINVAL;
>> + } else {
>> ret =3D bq27xxx_battery_read_rc(di, val);
>> + }
>> break;
>> case POWER_SUPPLY_PROP_CHARGE_FULL:
>> ret =3D bq27xxx_battery_read_fcc(di, val);
>> @@ -2163,6 +2172,10 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
>> break;
>> case POWER_SUPPLY_PROP_ENERGY_NOW:
>> ret =3D bq27xxx_battery_read_energy(di, val);
>> + /* If 0 is reported, it is expected that EDVF is also set */
>> + if (!ret && di->opts & BQ27XXX_O_ZERO &&
>> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
>> + return -EINVAL;
>> break;
>> case POWER_SUPPLY_PROP_POWER_AVG:
>> ret =3D bq27xxx_battery_pwr_avg(di, val);
>> --=20
>> 2.47.2
>>=20
>>=20
>=20
>=20


