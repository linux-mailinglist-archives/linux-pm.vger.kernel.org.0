Return-Path: <linux-pm+bounces-23164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC2A49376
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1895A7A40B9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B721214A8C;
	Fri, 28 Feb 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="f7zUREEt";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="oycVIqdz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0401DED4F;
	Fri, 28 Feb 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731285; cv=pass; b=tPgZ/2xDtMK8Qy/1eCvidmXIsL5DNHJJgwlRak3w8WnVTKnWDLhW6lncYxf5R0ZJJ8QCwrkZ8Ix4bC1Eoz3qV5//N2Ig7a/Wtrl8X0+KMc7u6azacyk3vyDjAmVLdUvscSYV6rsnknXU4154T6kPtqxvpOpn5Lrysf0GHtOsPjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731285; c=relaxed/simple;
	bh=05y216AD3XMu6MhUdWX5LUfDtkpl/IJH3gfTDCl89/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c740d2ebCIp4NdzYwjWJBHVAumyAFjqT+RiWrncVYEeS8jMiKfvLgRkzl8w8ff87DLfwO16eZ8hgGCno+2WB8iC5SKQ95lC1YzBEfjpE9TQtv8AcqwIq/lAZFTJ+9DOCVrNEKEtaBAgESaKSt4YDXzETTBeJmf+bkNQOi24eqNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=f7zUREEt; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=oycVIqdz; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1740731260; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fqVSTxRfE/mJIbomNdnmvya8wdSZ8NH9eHuvhNl8SV9YRYgMMNSU6anfxqX99L3RP0
    /jdUBHj3XDHPHdwko+KKtnA0/ARNx0kjyKQYYhAboSBIcTdX500lSILKfyL/R21Zu/FS
    /8Z/PCBKwFoUGngsao1HDsvQQFQXf/px93AvP49gajKw7nHHM+jdBNmlyfatkA15Ir2R
    jwuhlHM57NhSgxPM3rEJkQpWYHT1JomkB0Aj0EK8Kc95BMbN3xPbkTJblLc/gPNbOgLT
    irowhj4zFoHXY+5+zzKkVngw8yxmBH3n7z3osaSxB3J7BFUTVNaa5v+5Je1m+g+QqsUL
    7Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740731260;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=qbdxouGel+EwMaOYWfIFATwMXoEmmpMY6t2KEvspSM4=;
    b=RkQ6nh1hyOYUsRA2AOYm8s3D0y+Omyl8hYIjgehMMPT95wsiM4zlmk4uQ9MDbkQ5vi
    9MQ9Hgto7pv51BY+bbateGVyoajqbUn25P7SeGYCcpPD9z11UKy1OwJ6b9HayLh5ZowL
    24cclwuPGsI4fwElnM54lYTBj09XnjTvD2plJH3C5hBI5cTDCIbp8qkBkYFOO1fXaAeV
    d2lhPZWLhlPJxClLxr618KMB6oUgV6Lv6vx+JzMuG6zIop+ZYpdthweXAXfE3VVRDLqU
    IQ7KvTvIinn4b39iX3HU2yKGTsKYa7I9+cH/uytjtZsugOsH2zoGhz3o3F5nYxrH/QN2
    AtiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740731260;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=qbdxouGel+EwMaOYWfIFATwMXoEmmpMY6t2KEvspSM4=;
    b=f7zUREEtoE6DtHs6v+lNqJVT+E6YMyvTlz5V9ircF5zda6Wtg1973bmanClzBJlMyk
    Yub3ZqL1N6TV0zdcFOetKXnZrH9LW/Ll2RbPZdDmZnPpGsPCJE7Nt5xsUADSLCd30Q/O
    JHxfQScYYgyfXF/i3b701Qu+/m0NviFsegBpwNnvfjeenlhSJRNdt0dIdV3LNEbp3/Y6
    eafaFZ8pc3dHNm/H4pINUwwRh0dis934q7fUk8a1RmkWrHNOxA1qkzdpFg783Q0LGuJO
    HPFIvEsrXiNsFEEKRs8YMmdVpqX1xkms4lDH38peGMA5tk2WpWgRX6CuB8A7k2RjghmB
    z6Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740731260;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=qbdxouGel+EwMaOYWfIFATwMXoEmmpMY6t2KEvspSM4=;
    b=oycVIqdzdnwJwsq4lriyoDY3IPtqW/9NyNeiU1jPiG8gPsBIUmy5Fpubda/yT51Vwf
    6Ht9JAViwAcvjZNRn7BQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTkZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.3.0 DYNA|AUTH)
    with ESMTPSA id Q56adc11S8RdFXa
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 28 Feb 2025 09:27:39 +0100 (CET)
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
In-Reply-To: <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
Date: Fri, 28 Feb 2025 09:27:29 +0100
Cc: pali@kernel.org,
 Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org,
 maemo-leste@lists.dyne.org,
 phone-devel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 akemnade@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
To: Sicelo <absicsz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi,

> Am 28.02.2025 um 09:02 schrieb Sicelo <absicsz@gmail.com>:
>=20
> Hi
>=20
> On Thu, Feb 27, 2025 at 06:48:49PM +0100, H. Nikolaus Schaller wrote:
>>>=20
>>> I finally found time to test this patch on the GTA04 which uses an =
OpenMoko HF08
>>> battery which comes with a built-in bq27000.
>>>=20
>>> The result is that I can't read the =
/sys/class/power_supply/bq27000-battery/charge_now
>>> at all and always get EINVAL. Independently of the charge level =
reported without
>>> your patch.
>>>=20
>>> If I remove this patch again, the values are reasonable as in all =
the years before.
>>>=20
>>> What I don't know is how and to which values the EEPROM of the =
bq27000 has been
>>> factory programmed so that the HF08 battery maybehave differently =
from yours.
>>>=20
>>> Finally, I am not aware of reports from GTA04 users that the value =
stored in the NAC
>>> register is being reset as you describe and capacity, energy and =
charge to be falsely
>>> reported as 0.
>>>=20
>>> So please restrict this patch to the N900.
>=20
> In the case of the HF08, the value will not get reset since the chip =
is
> inside the battery as describe.

Ah, ok. Of course it obviously will be reset if the chip becomes =
disconnected from all power.

> However, the patch should be fine for
> HF08 and N900, etc., since the EINVAL should only be emitted when it =
has
> been reset. Unfortunately, I made the mistake below...
>=20
>>=20
>> You write:
>>=20
>>  Therefore, discard readings for these properties if their value is 0 =
while EDVF is unset.
>>=20
>> but the 'val' is not checked at all. Only the error return value
>> 'ret' of bq27xxx_simple_value() which is 0 if reading was ok.
>>=20
>> So shouldn't that be:
>>=20
>> + if (!val->intval && di->opts & BQ27XXX_O_ZERO &&
>> +   !(di->cache.flags & BQ27000_FLAG_EDVF))
>> + return -EINVAL;
>>=20
>> This could explain why I always get an -EINVAL here since =
BQ27000_FLAG_EDVF is likely not set.
>=20
> You are absolutely correct, Thank you. It seems I spent more time
> testing the non-working condition than the working condition. =
Apologies.

No worry. That is what review is good for.

>=20
> Will you submit the fix, or I should?

I think the patch has not yet been merged anywhere (but I am not sure), =
so
you better can send a v2 of the series.

And, I think I have found another potential issue.

The function bq27xxx_simple_value() returns the value passed as the =
first
parameter if it is negative (i.e. read error). And, then, it is not =
copies
to val->intval.

In that case val->intval may still be 0 and an -EINVAL may be returned
instead of the error return from what is passed as the first parameter =
to
bq27xxx_simple_value().

So I think it could be better to not check for=20

>> if (!val->intval &&=20

but

>> if (!di->cache.capacity &&=20

Alternatively if it should not rely on knowledge about the internaly of
bq27xxx_simple_value()

>> + if (!ret && !val->intval && di->opts & BQ27XXX_O_ZERO &&

Or even a third and maybe best alternative: do the check before calling
bq27xxx_simple_value(). Since setting val->intval and then returning an
error is not needed.


 case POWER_SUPPLY_PROP_CAPACITY:
	/* If 0 is reported, it is expected that EDVF is also set */
	if (!di->cache.capacity && di->opts & BQ27XXX_O_ZERO &&
		!(di->cache.flags & BQ27000_FLAG_EDVF))
		return -EINVAL;
 	ret =3D bq27xxx_simple_value(di->cache.capacity, val);
	break;

etc.

This should still report the ret error if di->cache.capacity < 0.

BR and thanks,
Nikolaus


