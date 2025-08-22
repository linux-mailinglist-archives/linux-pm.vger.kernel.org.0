Return-Path: <linux-pm+bounces-32887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA92B30F9B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A35B1CE2D8E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A442E229D;
	Fri, 22 Aug 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HvBWOyFk";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Hi7MfI0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF28219A8D;
	Fri, 22 Aug 2025 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845524; cv=pass; b=iftDOhJ2fXeXKFLm7uvN/jHcfROgRg7SmJOzsF93tAwFUiX8+QAatWQyesIGK6MRrNyvMmo6zUcc2D6gr+FVak+7TBZpFsBSrLKTF2UgH+7hBxa0c2VS/OWn2DJYE6zVIoiYzi+991ej/mF897mHKnuk+esy6+giZl1VahYQ2+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845524; c=relaxed/simple;
	bh=yPo2tU5IBHFymeiD9YN1F94DEx3t+ri+FIkcWa6RTjI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Etwr6z36ErABsBdIf27gV7n7ycqkFRXl9OVt4mv9SeqW+dondpiuxRw/nFlzQFy5zfm+YJ7MwCvtmkd7DYbF6mqkcOYL3XI39lhrcLEoi+didnqa+TMt9GrHLsjoe9dQqodJ7PYITDHCoiKqqNdmCLMgcxyqZqPrJ9c3dhEMxa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=HvBWOyFk; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Hi7MfI0p; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755845501; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZqRUgziFs0M0R385SWt8qUg2Pz6rbgSkht2Q0z1E/t9CHUKIYKxwlep1ger25MNllQ
    gI0iVQeA/QegYXVb8Lh2hoyHU1sMq+p2+1NzDglqBytLcB8V7jpF5dBF0D+8icEH/lNU
    FNE5KDd6Q9Gn8+uO7p7Jh2RcnikVEi1i0KSbiQ1ynM4I2GM5zkLpnWL2OLzXH+dg8KJH
    27cEMA36fLSW/bfDNzDYpl2YQb8Yd87fkVwil2Zet8RqyvPsEDi+rIOwAWwEAqa5LZq4
    FRxNgwwYyfZwwbrSrhC7Ten5F4+QHaJ+VmGtukooDtqDueQOJUWdUlBJgN9q215wTV20
    oGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755845501;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=BS4EX3FnN5XwFScpK/VeLAyxwk8YGCvuUK5IxFz7KT4=;
    b=gGNkMGypDTPq9oQo7A+IKVqtUTahmMdwmSoMAfbTb8o5mwvNDcpBxtvo9P/68b4Ovb
    GAAV+hzA5mElG1fpOeBaEkPeVLlDntegec1YC+Q46dLHEzEv4Mz6IzV6GXvAQOpCiVtJ
    Bu3SrFyJVE+jt8B3Tr1XVQXG9/AEmq3QDP1BuWswtpJjxO39u1BchB6lUWL/kPq03Lhh
    MWlZXKRWGDmFGPToViD8JqHJBR+Pkri9V8uji8UfE+OFAwric3lJknhab45VysxVIA43
    d9qF5tKprpjqW7OqGA/P4LW1AJKMQScRw5VFXxf98SG71HEU5flKVy5gn1F910QX4tHe
    mGsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755845501;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=BS4EX3FnN5XwFScpK/VeLAyxwk8YGCvuUK5IxFz7KT4=;
    b=HvBWOyFk7wdgJgrPIg0FcWU14LZFUMVoAf4Z2MrvG3JFVW7UICfLxMjfSkY9etkzf9
    n7+vwzUMWyZ0TGSLvMcmOf7UvrJfAD1DR7QtPRBSZfn5r3uk4DoadwalTlMPxATYMW0i
    rnKmCdmUvic0p807DnO/rijBf/YFc5/yrNA/iEufxLwYtGtCGdN6mkKj4r72e5Wlp6YJ
    R1MreXG77G+8upfYq3AF/sCYwt6AcIdb8CjYGj86P/BniPRL8ZEVs+KaO6gpffiTWWzV
    ESSaP7j0TpxfJAaYKgGLDcJJlBU56LKmjvGPeY2qr4d04VF5XPSC1qRMXZzgbZawaBFU
    F8FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755845501;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=BS4EX3FnN5XwFScpK/VeLAyxwk8YGCvuUK5IxFz7KT4=;
    b=Hi7MfI0peHYz/iPNSVidYfl0/8D0IPxf7F3rbF2hUxJ8mvHnv6S11CUoYATeMzFABP
    R5Z3T/vPLbaHJzOTEaCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfz0Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a417M6pezjE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 22 Aug 2025 08:51:40 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20250821220552.2cb701f9@akair>
Date: Fri, 22 Aug 2025 08:51:29 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
 Jerry Lv <Jerry.Lv@axis.com>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 stable@vger.kernel.org,
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9E0EBBA-094D-4940-8A15-409696E6B405@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <20250821201544.047e54e9@akair>
 <10174C85-591A-4DCB-A44E-95F2ACE75E99@goldelico.com>
 <20250821220552.2cb701f9@akair>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi,

> Am 21.08.2025 um 22:05 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Am Thu, 21 Aug 2025 20:54:41 +0200
> schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:
>=20
>>> Am 21.08.2025 um 20:15 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>=20
>>> Hi,
>>>=20
>>> Am Mon, 21 Jul 2025 14:46:09 +0200
>>> schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:
>>>=20
>>>> Since commit
>>>>=20
>>>> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>>>>=20
>>>> the console log of some devices with hdq but no bq27000 battery
>>>> (like the Pandaboard) is flooded with messages like:
>>>>=20
>>>> [   34.247833] power_supply bq27000-battery: driver failed to =
report 'status' property: -1
>>>>=20
>>>> as soon as user-space is finding a /sys entry and trying to read =
the
>>>> "status" property.
>>>>=20
>>>> It turns out that the offending commit changes the logic to now =
return the
>>>> value of cache.flags if it is <0. This is likely under the =
assumption that
>>>> it is an error number. In normal errors from bq27xxx_read() this is =
indeed
>>>> the case.
>>>>=20
>>>> But there is special code to detect if no bq27000 is installed or =
accessible
>>>> through hdq/1wire and wants to report this. In that case, the =
cache.flags
>>>> are set (historically) to constant -1 which did make reading =
properties
>>>> return -ENODEV. So everything appeared to be fine before the return =
value was
>>>> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, =
triggering the
>>>> error condition in power_supply_format_property() which then floods =
the
>>>> console log.
>>>>=20
>>>> So we change the detection of missing bq27000 battery to simply set
>>>>=20
>>>> cache.flags =3D -ENODEV
>>>>=20
>>>> instead of -1.
>>>>=20
>>> This all is a bit inconsistent, the offending commit makes it worse.=20=

>>> Normally devices appear only in /sys if they exist. Regarding stuff =
in
>>> /sys/class/power_supply, input power supplies might be there or not,
>>> but there you can argument that the entry in /sys/class/power_supply
>>> only means that there is a connector for connecting a supply. =20
>>=20
>> Indeed. If there is an optional bq27000 hdq battery the entry exists.
>>=20
> Which is the condition that there is an optional bq27000 battery?

If there is no bq27000 battery, hdq reads 8 bits of 0xff (no client on =
the
1 bit serial bus with pull-up) as the "value" of the battery status =
register.
If there is a battery connected, the value is defined and not 0xff.

See 3dd843e1c26a023dc8d776e5d984c635c642785f

> w1 might be enabled for other reasons. The bq27000 is not the only w1
> chip in the world.

In these cases the bq27xxx driver does not need to be present and does
not interfere.

BTW: the bq27000 is unconditionally added to the hdq subsystem as soon =
as
CONFIG_BATTERY_BQ27XXX_HDQ is configured. On every system. So the =
alternative
to disabling hdq on the processor and enabling in the board specific DTB =
is
to unconfigure CONFIG_BATTERY_BQ27XXX_HDQ if hdq is used for something =
else.

> BTW: I have removed the battery from my macbook and
> there is no battery entry in /sys/class/power_supply. Same with =
another
> laptop.

Does the entry disappear if you remove the battery while powered from AC =
and
come back on re-insertion of the battery?

Do they use hdq at all? With i2c it is easier to detect a "no response" =
during
probe or operation. But still i2c assumes that a chip responds at boot
or never (or user-space must run a timer to reprobe every now and then).

IMHO they are not prepared to handle the use case we have for the =
bq27000
and should therefore not be the role model.

>=20
>>> But having the battery entry everywhere looks like waste. If would
>>> expect the existence of a battery bay in the device where the common
>>> battery is one with a bq27xxx. =20
>>=20
>> I think the flaw you are mentioning is a completely diffent one. It =
comes from that
>> the 1-wire or hdq interface of some omap processors is enabled in the =
.dtsi by default
>> instead of disabling it like other interfaces (e.g. mcbsp1). E.g. for =
omap3 hdqw1w:
>>=20
>> =
https://elixir.bootlin.com/linux/v6.16.1/source/arch/arm/boot/dts/ti/omap/=
omap3.dtsi#L502
>>=20
>> And we should have the dts for the boards enable it only if the hdq =
interface is really
>> in use and there is a chance that a bq27000 can be connected. In that =
case the full
>> /sys entry is prepared but returns -ENODEV if the battery is missing, =
which is then
>> exactly the right error return (instead of -EPERM triggering the =
console message).
>>=20
>=20
> And why do you think bq27000 should behave different than
> max1721x_battery or ds2780_battery or ds2781_battery?

I have looked into the ds2780 code but do not understand how they handle =
the case
that the battery is removed or swapped or inserted during operation =
(while on external
power supply).

The max1721x is different. At least from looking into code it behaves =
exactly the same
as the bq27000. There is a POWER_SUPPLY_PROP_PRESENT. Which can always =
be read. It does
this by reading the MAX172XX_REG_STATUS and detecting that some bit =
(MAX172XX_BAT_PRESENT)
is not set. This can either mean no battery connected to the chip or the =
chip (built into
the battery case) is not connected to the hdq bus.

I can not test but would therefore assume the same for the max1721. As =
soon as you configure
it for a hdq capable device/kernel there should be a /sys entry for it =
with present =3D=3D 0.

BTW: all bq27xxx gauges have this property, not only the bq27000.

> If I enable the
> drivers there is no additional battery in /sys/class/power_supply!

Which is surprising because then the max1721x can never report "no =
battery present".
Unless it is always sitting on the main board and the battery is =
connected or not.

Or there is some special logic in the max1721x probe which can detect =
during boot that
the chip is really connected. But then you can not remove a battery with =
built-in
max1721x because it must be installed on first boot and can not be =
inserted later.

> Why
> should everyone have a bq27000 in /sys/class/power_supply if the =
driver
> is enabled and w1 is used for something? I wonder if the -ENODEV =
should
> be catched earlier.

What do you mean with "catched earlier"? What is your proposal?

Well, as proposed by Jerry earlier, it appears as if it can also be =
handled in bq27xxx_battery_hdq_read()
by detecting the register BQ27XXX_REG_FLAGS and the read value 0xff and =
return -ENODEV.

Then it would be constrained to the bq27000 - but still not solve your =
issue that boards
may not have a bq27000 option on their hdq bus...

Anyways this discussion now goes far beyond fixing the regression =
introduced by

f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")

So I'd suggest to fix the regression first and then add new functions or =
changes (for handling
removable chips and removable batteries reasonably) in a separate patch =
or series. Having separate
patches improves bisectability and is easier to track what has been =
changed (for different reasons).

BR,
Nikolaus



