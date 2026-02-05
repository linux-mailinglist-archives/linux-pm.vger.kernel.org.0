Return-Path: <linux-pm+bounces-42158-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP3WJzu4hGnG4wMAu9opvQ
	(envelope-from <linux-pm+bounces-42158-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 16:33:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61767F4A95
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAD3930233C9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17C421EE5;
	Thu,  5 Feb 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="brUCCggK"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496443E8C51;
	Thu,  5 Feb 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305589; cv=none; b=topdOd64QHXC6E9WJkRyPM+GgGXOROxadyxyc6laWdqJMEtKQbsXLdxKaxk5K+yCrKteYZYMGwUODIR+PgcvIvu7jTMr3PV6h8DP9TcWqf6YxW2WxC08AHiDYVJ0EcYGeYm7fUvM4TzDYzMZIVlmK64sijVHacGF/QHdQLEo7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305589; c=relaxed/simple;
	bh=d/ARjMgSP9G3NH4cyP+2JNA1MGSoHi33QTSADO5xKvU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g5AGMeT0jG1lPS/MOpBNzDcidLQ6+rX9Snxh7VSOYYPQOkUj5MaB63/EEOaDYjUmMjHO3tAs4vXQAHZ4BvVhjO9a7j+2vBxIlnyzBsPOzkJdtv5+0gYaf6mwbT78ZBXfsdX6XeAkHLsGfMMeUXqhGN1/FTrmqcVPgKnoRGtAWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=brUCCggK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AEE6D267E6;
	Thu,  5 Feb 2026 16:32:59 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SU4LjUO_09gW; Thu,  5 Feb 2026 16:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770305579; bh=d/ARjMgSP9G3NH4cyP+2JNA1MGSoHi33QTSADO5xKvU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=brUCCggKgzGG2eNnDc1T6EUWCHaax+pAh8pB1BwkFnmuIDMARX++5ODah3INRlgiR
	 f331TSaZ/H9w6Bt3+4K8CIsWFb/wSeIve10yAmp+vnucHfqHslmoLq8hs9tkyH5fUl
	 d1E7H0wUjrTujU2pZmCgVuDlTxKrV+BstniJrH/wr59Z6fdwokOyysn67W6oBBh9va
	 GrkD5/2tlC+Rca16Yq3YL/rI1sg20I2gn7kSJgPEK3Zqr2pGzwiqR+RyBw74vtUiye
	 3jGaaupHcjyMIvo86AlYcKN3v9XSHVP6+Tfg+ZxPyBBUUMLBLKU57KqYWj+GWk2kXQ
	 szIlacAlk2Lgg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 21:02:41 +0530
Message-Id: <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>, "Lee Jones" <lee@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "Sebastian Reichel" <sre@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
 <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
In-Reply-To: <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42158-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61767F4A95
X-Rspamd-Action: no action

On 2026-02-04 15:23 +00:00, Andr=C3=A9 Draszik wrote:
> Hi,
>
> On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
>> Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
>> USB Interface Controller), and flash and RGB LED controllers.
>>=20
>> S2MU005's interrupt registers can be properly divided into three regmap
>> IRQ chips, one each for the charger, flash LEDs, and the MUIC.
>>=20
>> Add initial support for S2MU005 in the PMIC driver, along with it's thre=
e
>> interrupt chips.
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> =C2=A0drivers/mfd/sec-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++
>> =C2=A0drivers/mfd/sec-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
>> =C2=A0drivers/mfd/sec-irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++++++++
>> =C2=A0include/linux/mfd/samsung/core.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1=
 +
>> =C2=A0include/linux/mfd/samsung/irq.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66=
 ++++++++
>> =C2=A0include/linux/mfd/samsung/s2mu005.h | 328 ++++++++++++++++++++++++=
++++++++++++
>> =C2=A06 files changed, 497 insertions(+)
>>=20

[...]

>> diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
>> index 3132b849b4bc4..3f1d70cc3292b 100644
>> --- a/drivers/mfd/sec-i2c.c
>> +++ b/drivers/mfd/sec-i2c.c
>> @@ -17,6 +17,7 @@
>> =C2=A0#include <linux/mfd/samsung/s2mps14.h>
>> =C2=A0#include <linux/mfd/samsung/s2mps15.h>
>> =C2=A0#include <linux/mfd/samsung/s2mpu02.h>
>> +#include <linux/mfd/samsung/s2mu005.h>
>> =C2=A0#include <linux/mfd/samsung/s5m8767.h>
>> =C2=A0#include <linux/mod_devicetable.h>
>> =C2=A0#include <linux/module.h>
>> @@ -130,6 +131,11 @@ static const struct regmap_config s2mpu05_regmap_co=
nfig =3D {
>> =C2=A0	.val_bits =3D 8,
>> =C2=A0};
>> =C2=A0
>> +static const struct regmap_config s2mu005_regmap_config =3D {
>> +	.reg_bits =3D 8,
>> +	.val_bits =3D 8,
>> +};
>
> No cache? And what is the .max_register value?
>

This was in the previous revision, but I ended up removing it because
(at least I thought at that time) interfered with interrupts firing in
some way. The actual issue was unrelated, so I will add it back.

However, there is also another thing I see in logs:

sec-pmic-i2c 2-003d: using zero-initialized flat cache, this may cause unex=
pected behavior

This is due to REGCACHE_FLAT, I am not sure if I should just ignore
this.

