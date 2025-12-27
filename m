Return-Path: <linux-pm+bounces-39971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78BCE031B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 00:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB5F3011FB7
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60E1E3DF2;
	Sat, 27 Dec 2025 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="Y8qAHNaI";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="mU4wvbOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0493A1E66;
	Sat, 27 Dec 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766878652; cv=pass; b=lH/jUZpZlW2reg6s44Gc0S/+SEwSpgbg/skvFkhpxXzLWbK7Cig84JWpY7iTcU5T26i8AAC3d0sQiidZEgiY20f3uLv23FT6bYUSukS/X+IW0DMOJrYy6pDZo6NnfITDSM/XO+BtkHQgpSdioSR3y2zaUx7App5wCNLvzTHV67c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766878652; c=relaxed/simple;
	bh=PBIvImcUkq6rjqjuiUMwz1U5kl5X5IGHyaIB5CAehzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tczPV0dAdbjKB0v2bJXZ6QNfZ/E31hehaRhCoiGavA0TZ3LAOddM4WEZT1eSqdKzVTKh2BaMHpuSCnlK7ckMgm8y/pl1fnhLXTmB0G2bv/JxwwqhNdUSOvjgTifrbpZqFtEEJ7ZQIDfJh2vLsi6bGImTEP+8QDyNykvrhHeHYSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=Y8qAHNaI; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=mU4wvbOH; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1766878462; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jBJPSwsMYisrKcstp6UHoAMfj4ZNBGNA81/IGA+xA7zJox2+5tri8QfefLpqwxBXla
    jQbDrRm9brjbyyUQlI4f4VSPVZnk9tRatyaklteL9ZW0wXfy8pZfAuB68hDV0tEc6nQB
    griShjYlnYu8gJ5YKphBKw6bbUesTRFrzWiO/+EHIRWqdnfk7zEd8N+9i7OETDZdrCX0
    p2TSKrShyxFdPJMt+jzNSpQVCSXwWaBgiHgZ04/Vs1m3J55F7vZTW180uRlr95Ekol7I
    LejHRDPqpbUKAxCUoLlh73IISyQErvdf0CQ6bYn4HMtVj9IDbj1ce26VtesWajVXp8+l
    wfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766878462;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=r8ndoUydE7wCVollDThIleRkPMsRz9cY64b0IoVmCiw=;
    b=NsVsj3LjXXzqSE1YorMoVss7CsA3x6lV5qzsZMOSCEmnVlAb1l3FB7YUimu6FioprE
    DlYtW0JI9DWpmB4Deo7S6oiTOyG/Ux2AQmN16iE6T+Ff8oBJbn9adlJ2DcdLwy329HIY
    c/btn2UTsmhwYSKksyXCZLLFvMeooBF8mhUYxpFmlnyccaRILk7lItrjiXrb0NEBYq/v
    +5ishXyKWEOJ8se+GDrroWMaQkZeMWMsKc9VFGpmRwlWIbJ8XkmuCdycBg9PpzHx5ntA
    70Bc8UCXsRg0cJaABcNQyUZziyd7ItLgvVAXqKtW2hFPtR+BmIPTBL6b3iJDOfLiDmGu
    wkCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766878462;
    s=strato-dkim-0002; d=jm0.eu;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=r8ndoUydE7wCVollDThIleRkPMsRz9cY64b0IoVmCiw=;
    b=Y8qAHNaIFQ75mUPgBviSwdfj65C8FNc2p1u/ayMAunCimmHy4iUt4ahuO+Mnd2tRCG
    9A5k7u1uk/yIHChSBAngaachq2FSrgvD0QkfAlLXw6yVXG+mbTIo4mG9p7c+qB7FcuVq
    mPGMrSeRgLPQxcscsNX7KuuBaXGCiXR8/2ZtAc/UoPtxIqSMZ2HYMrVfyv6xtSBbLnqo
    OqBuD0B1Zl6kHdFOjZQeJDDzaHntV6qGPJcZh/jKe3Cvgzxfao5NyS7NHU642XlSqDSh
    WE5PowF0tq2Bfk7jMiDD/0DlpSZvzt3ZgOOM53E34szqTqsSLqrpnoPn2c4a6Np0/pMR
    8BHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766878462;
    s=strato-dkim-0003; d=jm0.eu;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=r8ndoUydE7wCVollDThIleRkPMsRz9cY64b0IoVmCiw=;
    b=mU4wvbOHiaDVLe4JfrQD/dYRzYEc25Y/Xc0uS1ntw0M/uaCrVgPBMVv5kVrDtu7Gq9
    dhYvUOXsgmm4/xJKU9CQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from [192.168.1.232]
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BRNYLubs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 28 Dec 2025 00:34:21 +0100 (CET)
Message-ID: <0087cd4f-4e85-4cd0-8732-cd5b175e9eaa@jm0.eu>
Date: Sun, 28 Dec 2025 00:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] power: supply: add battery driver for netronix ec
To: Andreas Kemnade <andreas@kemnade.info>
Cc: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
 <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
 <20251227223815.17dea51d@kemnade.info>
Content-Language: en-US
From: "Ing. Josua Mayer" <josua.mayer@jm0.eu>
Autocrypt: addr=josua.mayer@jm0.eu; keydata=
 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
In-Reply-To: <20251227223815.17dea51d@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.12.25 um 22:38 schrieb Andreas Kemnade:
> On Sat, 27 Dec 2025 17:28:13 +0100
> Josua Mayer <josua.mayer@jm0.eu> wrote:
> 
>> Implement a simple battery driver for monitoring voltage with the
>> netronix embedded controller found in certain ebook readers.
>>
>> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
> 
> This also produces a value somehow depending on battery voltage
> on the Tolino vision.
Good!

> [...]
>> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
>> index 08c68de0f01bc..d5059b8862aa8 100644
>> --- a/drivers/mfd/ntxec.c
>> +++ b/drivers/mfd/ntxec.c
>> @@ -139,6 +139,7 @@ static const struct regmap_config regmap_config = {
>> static const struct mfd_cell ntxec_subdev[] = {
>> 	{ .name = "ntxec-rtc" },
>> 	{ .name = "ntxec-pwm" },
>> +	{ .name = "ntxec-battery" },
>> };
>>
>> static const struct mfd_cell ntxec_subdev_pwm[] = {
> 
> I think that should be a separate patch for mfd.
Okay

> [...]
>> +	switch (psp) {
>> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +			ret = regmap_read(priv->ec->regmap, NTXEC_REG_READ_BATTERY, &value);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			/* ec value to microvolt conversion:
>> +			 * vendor kernel source suggests linear behaviour from 3V to 4.2V
>> +			 * with readings 767 to 1023; each increment represents 4687,5uV.
>> +			 * adjust 3V boundary slightly to report exactly 4.2V when full.
>> +			 */
>> +			val->intval = 2999872 + (value - 767) * 4688;
>> +			break;
> I find this code both in some kobo 2.6.35.3 code and on the tolino 3.0.35:
> 
>          const unsigned short battGasgauge[] = {
>          //      3.0V, 3.1V, 3.2V, 3.3V, 3.4V, 3.5V, 3.6V, 3.7V, 3.8V, 3.9V, 4.0V, 4.1V, 4.2V,
> //               743,  767,  791,  812,  835,  860,  885,  909,  935,  960,  985, 1010, 1023,
>                   767,  791,  812,  833,  852,  877,  903,  928,  950,  979,  993, 1019, 1023,
>          };
> 
> This does not look very linear... We have offsets
> 24
> 21
> 21
> 19
> 25
> 26
> 25
> 22
> 29
> 14
> 26
> 4
> 
> Do you have something looking more sane?
No, I based on the same but simplified it.
> No idea what should produce such flaky offsets besides of
> improper measurements. At least that should be commented.
> And why do these tables exist at all?
> 
> Hmm, the more weird thing is that these voltages are translated linearly
> inot capacity.
Indeed - this is why I decided on a linear relationship ...
matching minimal and maixmal voltage as close as possible.

> So maybe they are just adjusted to have the capacity look
> more sane. That would explain the 4 units step between 4.1V and 4.2V.
4.1 is the full voltage of the lion battery if charger was disconnected.
However 4.2 I think is the final voltage reached while charging.

> Having linear adc result -> voltage and nonlinear voltage-> capcity would
> make more sense.
Indeed.
But if it was intended as percentage, then why would he register not 
just read from 0-100 :(
So I still guess it is some adc result.

> 
> looking at such code snippet like this:
> case POWER_SUPPLY_PROP_CAPACITY:
>                  if (POWER_SUPPLY_STATUS_NOT_CHARGING == g_ntx_bat_di->battery_status) {
>                          val->intval = 100;
>                          return 0;
>                  }
>                  value = ntx_up_battery_vol();
> [...]
>                                  val->intval  = 100 - ((4100000 - value)/7000);
> 
> 
> I am wondering whether we should just return capacity that way without
> calculating voltage...
I suppose it depends on whether it is more likely that the ec provides 
voltage, or a charge estimation.

br
Josua

