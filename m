Return-Path: <linux-pm+bounces-32827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB655B30194
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB582AA8888
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2DB341671;
	Thu, 21 Aug 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="YFn8MLF1";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DXMPcf8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794D342CA7;
	Thu, 21 Aug 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799152; cv=pass; b=KcX8BylJ6AKOJrZoj07GT3nT542Ljd3DNlgsfGxPyfHZywQOoI0UUvPLyqxI2ah0S+R+XQYcDrMOhrQ8HITmeHfrYmgLEQ1TphoXhFGVg9gQrAs5FsGw+UjJ6YdbVBQbCOSQgHHtBEeI0CyZyyAe9S3N1AAaPzlNhBlS4s/45l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799152; c=relaxed/simple;
	bh=x1BAOfGwvt5Cwj/1K5BSTnfTTvXR68XhwB9KIfdqD+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uMYoujmuxkv8vKwa8JTS4HhqjdXmq0uerTZ3oO1Ma6j1MmWwTvktqqdYbis1QE7bTJ2bngJIb6cbwa76wdly63A2NfwoV67fvTpFGR7h7q7VQgkaamvftu40KPCnnfvDFfh3CMfY0a67HDs47W91dpb4+u6p15qRdVdK5H/vaPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=YFn8MLF1; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=DXMPcf8l; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755798960; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cXc/7HHXhcfkCrUY9uL6VvJWzAIEhGvET9ggCsALka6Eqx1MAhT9YWaAZXt1Nmuons
    df2kXZT9ahTuUdXE+oDgReu04yQZ8yTfu+eUafo73dxekewYc17803kR/jV7fuV24gnb
    vad8aVpTLo3/+CHlzzmIbo51/Bxm/PRu8WZPEJiTBwSLBnQlVee8KFOq99yZWodmTMI2
    QQBvrPrimAe8ltbPtfv2phyKGFuF5B/728WK0jis/OTLTgrrB4HiRTJ/jL2KEDlDq20s
    GiMe4JotRRH5AExcOijKeXc+ylErqqFKABTyVPDuly9kU39aJdLAJQrY/2g78SVVynns
    SEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755798960;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RtUrKuksj38WcsdR8YHSkPl7koERjRitgmJthhnbl0g=;
    b=mhW+f+0tzIMLaBe/phDQQE7PzeWAf7IgggPgKd42MlIwCSb40U1epbLVpxQEqaibji
    uSUBPyBpTH+YUbIcjy9F0qfRJqeupfQhHAPcVizFXUgP1Ek0HQmtoHDKR95kvsRMJHxc
    AECiZcco+7+mRZ2ILnmsxGApxNI39jc4gRQxPwbkHHABD7DmUHYghj369QKPtk7iN3GI
    uW6C+NvjpTG3KKRBEHGtGc3nydQ1Gwst1L1mc+cEKPVZE0XMWqDyB9sf/i0jagDn7bjh
    8GtbIGLzKehpQ9QdmS0knIS+lMhDpZCYJYSKiGYA+3O4C68gJku822vmPisEjj1V1rrp
    gOrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755798960;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RtUrKuksj38WcsdR8YHSkPl7koERjRitgmJthhnbl0g=;
    b=YFn8MLF1p64sqveQPq39y1aFlt6BLhMPKzkRBw24PtwSRpuvrDHjc4WmmdQ7TCQNmq
    9cgRzIDLCXkjdkdGtU/OyJfTmQBxLYoFnzMzrbxXNsXM0c2+irqxyjqNDvW+pcJLACnY
    7IftvWLNYpaUEhfMT/ntEl/2KzhDLFZ0pep4Og1lefIO5ShkAL0Srx9FYrOyPj11A7xp
    0fc+6iHxu3ePG+Y3k9UdpQv2lZxAOUSs+Har5R6QFRS1xd7MiY1eaeusl4YlyhC/EagW
    hAS4/q73tzmCpAzrsYtiaeNbDgPf1C30sLhAEDmP5/M0s6KkEYAs814leQN5ihqAEW7m
    KOyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755798960;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=RtUrKuksj38WcsdR8YHSkPl7koERjRitgmJthhnbl0g=;
    b=DXMPcf8l2C8N10Aei3ql/OvBiPNrAv+rlIr1Qeaf0mMUALD9nNTCu0N805YWGeNZj9
    Q72r7h9A/4LyeAKv2DDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzAZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id Q307a417LHtxvFM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 21 Aug 2025 19:55:59 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1aec872a-f1fb-4302-b346-08992ab19276@axis.com>
Date: Thu, 21 Aug 2025 19:55:49 +0200
Cc: Jerry Lv <Jerry.Lv@axis.com>,
 "andreas@kemnade.info" <andreas@kemnade.info>,
 Sebastian Reichel <sre@kernel.org>,
 =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B67C69A7-C8C8-4CE0-977F-94E986573C07@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <2437B077-0F51-4724-8861-7E0BEE9DB5F0@goldelico.com>
 <1aec872a-f1fb-4302-b346-08992ab19276@axis.com>
To: Jerry Lv <jerrylv@axis.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi Jerry,
sorry it appears that I have missed your mail.

> Am 08.08.2025 um 11:13 schrieb Jerry Lv <jerrylv@axis.com>:
>=20
> Hello Nikolaus,
>=20
> On 8/5/2025 5:28 PM, H. Nikolaus Schaller wrote:
>> Hi Jerry,
>>=20
>>> Am 05.08.2025 um 10:53 schrieb Jerry Lv <Jerry.Lv@axis.com>:
>>>=20
>>>=20
>>>=20
>>>=20
>>> ________________________________________
>>> From: H. Nikolaus Schaller <hns@goldelico.com>
>>> Sent: Monday, July 21, 2025 8:46 PM
>>> To: Sebastian Reichel; Jerry Lv
>>> Cc: Pali Roh=C3=A1r; linux-pm@vger.kernel.org; =
linux-kernel@vger.kernel.org; letux-kernel@openphoenux.org; =
stable@vger.kernel.org; kernel@pyra-handheld.com; andreas@kemnade.info; =
H. Nikolaus Schaller
>>> Subject: [PATCH] power: supply: bq27xxx: fix error return in case of =
no bq27000 hdq battery
>>>=20
>>> [You don't often get email from hns@goldelico.com. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
>>>=20
>>> Since commit
>>>=20
>>> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>>>=20
>>> the console log of some devices with hdq but no bq27000 battery
>>> (like the Pandaboard) is flooded with messages like:
>>>=20
>>> [   34.247833] power_supply bq27000-battery: driver failed to report =
'status' property: -1
>>>=20
>>> as soon as user-space is finding a /sys entry and trying to read the
>>> "status" property.
>>>=20
>>> It turns out that the offending commit changes the logic to now =
return the
>>> value of cache.flags if it is <0. This is likely under the =
assumption that
>>> it is an error number. In normal errors from bq27xxx_read() this is =
indeed
>>> the case.
>>>=20
>>> But there is special code to detect if no bq27000 is installed or =
accessible
>>> through hdq/1wire and wants to report this. In that case, the =
cache.flags
>>> are set (historically) to constant -1 which did make reading =
properties
>>> return -ENODEV. So everything appeared to be fine before the return =
value was
>>> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, =
triggering the
>>> error condition in power_supply_format_property() which then floods =
the
>>> console log.
>>>=20
>>> So we change the detection of missing bq27000 battery to simply set
>>>=20
>>>        cache.flags =3D -ENODEV
>>>=20
>>> instead of -1.
>>>=20
>>> Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when =
busy")
>>> Cc: Jerry Lv <Jerry.Lv@axis.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
>>> index 93dcebbe11417..efe02ad695a62 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -1920,7 +1920,7 @@ static void =
bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>>>=20
>>>        cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, =
has_singe_flag);
>>>        if ((cache.flags & 0xff) =3D=3D 0xff)
>>> -               cache.flags =3D -1; /* read error */
>>> +               cache.flags =3D -ENODEV; /* read error */
>>>        if (cache.flags >=3D 0) {
>>>                cache.capacity =3D bq27xxx_battery_read_soc(di);
>>>=20
>>> --
>>> 2.50.0
>>>=20
>>>=20
>>>=20
>>> In our device, we use the I2C to get data from the gauge bq27z561.
>>> During our test, when try to get the status register by =
bq27xxx_read() in the bq27xxx_battery_update_unlocked(),
>>> we found sometimes the returned value is 0xFFFF, but it will update =
to some other value very quickly.
>> Strange. Do you have an idea if this is an I2C communication effect =
or really reported from the bq27z561 chip?
> It's the data returned by i2c_transfer(). I have reported this issue =
to TI, and wait for their further investigation.
> Not sure whether other gauges behave like this or not.
>>> So the returned 0xFFFF does not indicate "No such device", if we =
force to set the cache.flags to "-ENODEV" or "-1" manually in this case,
>>> the bq27xxx_battery_get_property() will just return the cache.flags =
until it is updated at lease 5 seconds later,
>>> it means we cannot get any property in these 5 seconds.
>> Ok I see. So there should be a different rule for the bq27z561.
> This is not only for bq27z561, it's the general mechanism in the =
driver bq27xxx_battery.c for all gauges:

But the "bug" is only for the bq27z561.

>=20
>       static int bq27xxx_battery_get_property() {
>=20
>      ...
>=20
>      if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
>=20
>            return di->cache.flags;
>=20
>      }
>=20
>>> In fact, for the I2C driver, if no bq27000 is installed or =
accessible,
>>> the bq27xxx_battery_i2c_read() will return "-ENODEV" directly when =
no device,
>>> or the i2c_transfer() will return the negative error according to =
real case.
>> Yes, that is what I2C can easily report. But for AFAIK for HDQ there =
is no -ENODEV
>> detection in the protocol. So the bq27000 has this special check.
> Since this is the special check only needed for bq27000,
>=20
> suggest to check the chip type before changing the cache.flags to =
-ENODEV manually, see my comments in later part.

>=20
>>=20
>>>        bq27xxx_battery_i2c_read() {
>>>                ...
>>>        if (!client->adapter)
>>>         return -ENODEV;
>>>                ...
>>>                ret =3D i2c_transfer(client->adapter, msg, =
ARRAY_SIZE(msg));
>>>                ...
>>>                if (ret < 0)
>>>        return ret;
>>>                ...
>>>        }
>>>=20
>>> But there is no similar check in the bq27xxx_battery_hdq_read() for =
the HDQ/1-wire driver.
>>>=20
>>> Could we do the same check in the bq27xxx_battery_hdq_read(),
>>> instead of changing the cache.flags manually when the last byte in =
the returned data is 0xFF?
>> So your suggestion is to modify bq27xxx_battery_hdq_read to check for =
BQ27XXX_REG_FLAGS and
>> value 0xff and convert to -ENODEV?
>>=20
>> Well, it depends on the data that has been successfully reported. So =
making bq27xxx_battery_hdq_read()
>> have some logic to evaluate the data seems to just move the problem =
to a different place.
>> Especially as this is a generic function that can read any register =
it is counter-intuitive to
>> analyse the data.
>>=20
>>> Or could we just force to set the returned value to "-ENODEV" only =
when the last byte get from bq27xxx_battery_hdq_read() is 0xFF?
>> In summary I am not sure if that improves anything. It just makes the =
existing code more difficult
>> to understand.
>>=20
>> What about checking bq27xxx_battery_update_unlocked() for
>>=20
>>        if (!(di->opts & BQ27Z561_O_BITS) && (cache.flags & 0xff) =3D=3D=
 0xff)
>>=20
>> to protect your driver from this logic?
>>=20
>> This would not touch or break the well tested bq27000 logic and =
prevent the new bq27z561
>> driver to trigger a false positive?
> This change works for my device, but just as you said, this change =
makes the existing code more difficult to understand.

It may be a matter of a better code comment (see below)...

>=20
> Since changing the cache.flags to -ENODEV manually is only needed for =
the bq27000 with the HDQ driver,
>=20
> suggest to check the chip type first like below:
>=20
>       if ((di->chip =3D=3D BQ27000) && (cache.flags & 0xff) =3D=3D =
0xff)
>=20
>             cache.flags =3D -ENODEV; /* read error */

Ok, this depends on what the gauges !=3D bq27000 and !=3D bq27Z561 would =
expect. This is something I
do not know, but maybe the community / maintainers.

And, there is a comment for the definition of BQ27000 that it is also =
meant for the bq27200, which has an i2c interface.
That one is obsolete but still may be used somewhere...

But if it does never return 0xff for the status register it would be =
fine for me.

>=20
>=20
> This will not break the well tested bq27000 logic, and also works fine =
with other gauges, and it's more easy to understand.
> What's your opinion?

I can't acccess the git repo at the moment, so here is what think this =
would mean:

@@ -1920,7 +1920,7 @@ static void bq27xxx_battery_update_unlocked(struct =
bq27xxx_device_info *di)

       cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, =
has_singe_flag);
-      if ((cache.flags & 0xff) =3D=3D 0xff)
+      if ((di->chip =3D=3D BQ27000) && (cache.flags & 0xff) =3D=3D =
0xff)
-               cache.flags =3D -1; /* read error */
+               cache.flags =3D -ENODEV; /* bq27000 hdq read error */
       if (cache.flags >=3D 0) {
               cache.capacity =3D bq27xxx_battery_read_soc(di);

With the changed comment it should be more clear what it is doing and =
why.

Maybe can you test this? As soon as I can test, I'll report and submit a =
v2.

BR and thanks,
Nikolaus


