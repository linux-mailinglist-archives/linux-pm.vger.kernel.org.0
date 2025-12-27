Return-Path: <linux-pm+bounces-39970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD6CE0253
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 22:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1219E3001C11
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A12F23EA81;
	Sat, 27 Dec 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mXokZZdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B731D5ACE;
	Sat, 27 Dec 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766871509; cv=none; b=E0x/rlRfQ/BidrSXTM4uW0AkKTeohe0eIGiEjnlL45L2tfHT8JSpFF8tL3ld+tqbp8BsSog7MYFEWrKkStf1P9stGGil6AbRp265oTDc2Iin1DxnYjBNv6M+/yowZ03wavmRn8NbJJMKb7tn2t194fcwIGbxOUm1u5zzictSD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766871509; c=relaxed/simple;
	bh=DI0DJoKUTxqb2A4/47Obc9gSZwHv6pbX1wIH+ApG7Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD/hwWbiYLgN7k69LXNpbz4X3ll8z7qN94lNGP/X0lIYoyEzCXnVGaBDdySiUfXoz4N2hRj7hvtwOV0PP60NCEWLwug2Tpz8JpzYtMuBoqPCl0jF+3O3FI/mhFFltlY06WWkYcgzZN0Np4afHkkQdPRdKV/y1dNJvsCvtFuv8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mXokZZdZ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=F+zOPMJ/+XQOoQnBvgthrqy4sMQ6IWP6qjfRNJSiwKc=; b=mXokZZdZCUhEmvIIodt4+AKwvf
	qV+hn0iP51XPavx8HvYW5FR1ZNN2C6zl3xzZzGppGTUsMWgucwNEQi0xnQ4Uqzu3eMToE795u0r61
	f3viGkybinu7ceE/m/hqVhfLJnGXNWpJKe/t0TYIXqPoUI2Qy+OGGal/Zaf7ihnl+bcmXp3piO5Gk
	Phh9R1SCOk3+c4FrrgNjTnhv58qIl/RByk1yPM4/UkC7GzHGOxOU3i/1s1jfvljeREW83SfFYa8IR
	jTVFx6OZAi/8XSI5tpVrCuYeHC6DWcECq+LU8x1zERvRg5k06rX+xy/NcipPf2EVgnJTIq1xMv3x/
	srzCshwg==;
Date: Sat, 27 Dec 2025 22:38:15 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Josua Mayer <josua.mayer@jm0.eu>
Cc: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] power: supply: add battery driver for netronix ec
Message-ID: <20251227223815.17dea51d@kemnade.info>
In-Reply-To: <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
	<20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 17:28:13 +0100
Josua Mayer <josua.mayer@jm0.eu> wrote:

> Implement a simple battery driver for monitoring voltage with the
> netronix embedded controller found in certain ebook readers.
> 
> Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>

This also produces a value somehow depending on battery voltage
on the Tolino vision.
[...]
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 08c68de0f01bc..d5059b8862aa8 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -139,6 +139,7 @@ static const struct regmap_config regmap_config = {
> static const struct mfd_cell ntxec_subdev[] = {
> 	{ .name = "ntxec-rtc" },
> 	{ .name = "ntxec-pwm" },
> +	{ .name = "ntxec-battery" },
> };
> 
> static const struct mfd_cell ntxec_subdev_pwm[] = {

I think that should be a separate patch for mfd.

[...]
> +	switch (psp) {
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +			ret = regmap_read(priv->ec->regmap, NTXEC_REG_READ_BATTERY, &value);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* ec value to microvolt conversion:
> +			 * vendor kernel source suggests linear behaviour from 3V to 4.2V
> +			 * with readings 767 to 1023; each increment represents 4687,5uV.
> +			 * adjust 3V boundary slightly to report exactly 4.2V when full.
> +			 */
> +			val->intval = 2999872 + (value - 767) * 4688;
> +			break;
I find this code both in some kobo 2.6.35.3 code and on the tolino 3.0.35:

        const unsigned short battGasgauge[] = {
        //      3.0V, 3.1V, 3.2V, 3.3V, 3.4V, 3.5V, 3.6V, 3.7V, 3.8V, 3.9V, 4.0V, 4.1V, 4.2V,
//               743,  767,  791,  812,  835,  860,  885,  909,  935,  960,  985, 1010, 1023,
                 767,  791,  812,  833,  852,  877,  903,  928,  950,  979,  993, 1019, 1023,
        };

This does not look very linear... We have offsets
24
21
21
19
25
26
25
22
29
14
26
4

Do you have something looking more sane?
No idea what should produce such flaky offsets besides of
improper measurements. At least that should be commented.
And why do these tables exist at all?

Hmm, the more weird thing is that these voltages are translated linearly
inot capacity. So maybe they are just adjusted to have the capacity look
more sane. That would explain the 4 units step between 4.1V and 4.2V.
Having linear adc result -> voltage and nonlinear voltage-> capcity would
make more sense.

looking at such code snippet like this:
case POWER_SUPPLY_PROP_CAPACITY:
                if (POWER_SUPPLY_STATUS_NOT_CHARGING == g_ntx_bat_di->battery_status) {
                        val->intval = 100;
                        return 0;
                }
                value = ntx_up_battery_vol();
[...]
                                val->intval  = 100 - ((4100000 - value)/7000);


I am wondering whether we should just return capacity that way without
calculating voltage...

Regards,
Andreas

