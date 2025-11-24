Return-Path: <linux-pm+bounces-38428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA31C7F079
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 07:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBE624E2466
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EB2D0C72;
	Mon, 24 Nov 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTx2fQ4Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61A256C88
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965253; cv=none; b=cMANQKtsOyUXq3RpUZ8IQnW7wqxyDlTqaQDyGmw2h64x4rKkr+uLHcBP/W5IVIN4ZU0RsMWcOs1wlZRXzYIE+8vO3udaPhsxAhkrt1MYYhNjgInrPH/rIOc+h98gEX67jshmETZgOQpZh+w/wjRrpQ2r755JBQBN+flvyCp0H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965253; c=relaxed/simple;
	bh=yknGv046L7yMedwEjSmM6+EdFvU3S2cf1Pirgu5kUDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvFpM0z5sRLUXqXNm7WkRMT7tgdWG4/bkOXiAkPDJyt8x7PV6E2KqLryHx/wft/OUh56xhjtYMIDhqz3jxiLBFWWyNsyVahXbh7Vxg8LwNWZBr5Hfub1YMcPzUyuK21ZlunHNlMMb4qKJu9k5T0T+rexfaVheZq/EkCO03rozZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTx2fQ4Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779a637712so23076295e9.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Nov 2025 22:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763965249; x=1764570049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=REZ04im9FdK76DRTIwu+Cc/Q2WxCSUPnF2cnra53O5Y=;
        b=rTx2fQ4Qk8jEIihvh86EgMDzgo6/L1tTd/B3a7eqIVhrkIZlZPWGE+r6rjJ3D1OeS9
         7Bu/WZot5WHBeTL6PYG3wVXOTvqqTp3HQ2bH0E66J+Oab8OC+2imVrQcRnnB0iIUq11H
         F9XUfcN7Bf1dNOR42M2RxYWtwslAWeYfGJgvQUfptX8McOnHvPQMbYefbNadDsT/xqhw
         +rXJ7X5jE4CgHfa4MeOT1KK1l3Rxbo1t+Wwr5WwYL/eYkg1pImmAI7RVYSxSiiF5xlQH
         htDFq5WFQugeSe9pcdv2XFmUBlkcmbcfdNeTIO9Ud+OEZd2AcEV4Ap1HM97Dca5Im0zR
         Mpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763965249; x=1764570049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REZ04im9FdK76DRTIwu+Cc/Q2WxCSUPnF2cnra53O5Y=;
        b=WjQjWDY5Qqp2IRxOgoAC+VMpsfI+ipDDospKm/aLM2MKmAbxhAxoj2h2YS+glyBmiq
         +RJLw6ZIGj11RzWP5vQTHfgZWi/S2Xqz4Fx52zJFIZHS3eCqB9W4Wgpx8Bhwe6HVIJSw
         8y6AFYGJtwC5HbBn0EwBLO4u/xpGBb4o1D5BJbH/a+0GtCM4P84qSkCZhZDQ4cV09Bmj
         LTS+oAMIwJ1hYX9GjuZLg0bTma7ksmqwcQ2Qlec7onorcFFTWDHFQMUpOWd55YOqEhX1
         wEYMFApzDA4eOhPLt6VDnfKV3n81g/bsRBL8B1uKm3NfFqv49r/5J8Z9A0oML5o8GHHN
         N9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWXlM4zbfDu5/zzjF2cH7pp2x1ZuofuCff6ACg9QTNOB8GWccAxkJN5D9nqwZVyeHSixMeA4I8Hlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZou/o+AhymgF6iqe0NASJtyTzJv5Tw6HE/VuzSHwxzGPI8GWR
	8aMMb0tYurU+0A11KBLEt6JpPO5kmoJRa7p6qhPAaAB3sBXGSBNUSo9TlW6tKkmidw4=
X-Gm-Gg: ASbGncsqaePFhF8ofm8yxCmo5b+aLnZKwzlWMvC9DDcxCU2snb4Hxslgt1nRN/nN5ll
	vCPxEW4PuOsqnZbjL6c5pmynqzhE8tpEZ1WqV7C4Tk01vc5iVG0WvFZPZaA5tZzmKBP+jXWa1jW
	he0xo2glo2u9Nnftkr7ath0ZSZTVbMHKX0VBNG1n9s4Fwn0+Y7TjoIoKcOg+VEJHhM2BHdl6a3E
	Nui36euhso/nRSDkxQ/yJQ7fR39rGPWsMJvF+id96M7HPRjZGbLZYJUmQMHkKsBgJ7e6myFo2zp
	4vLOu9QojVCN2Tvm6lic8n2DPY8O6iGexQbzT2wwCe4GrxB2gFzaSiF+wPyAnggMHCDgaJ9RgOq
	YfWno3RKhq3soWFxsIfeLy1YcobsTezGhE7+J7BsZ57AN9O80EfVPY6YLpe7Z5uIzHO34Fzv4/f
	Bo2HbKoIIpcBYZf4/jIBbianhBRshi
X-Google-Smtp-Source: AGHT+IEkAHuQrVSean0CMnJmgdroQFGEXS2JnDMuJL0ECBf4DUqCtzz0alMdPUQuLJolnNwjmMRrhw==
X-Received: by 2002:a05:600c:3110:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-477c01b4b2amr122845505e9.16.1763965249310;
        Sun, 23 Nov 2025 22:20:49 -0800 (PST)
Received: from draszik.lan ([212.129.72.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e454sm26304551f8f.2.2025.11.23.22.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 22:20:48 -0800 (PST)
Message-ID: <5c901a6c831775a04924880cc9f783814f75b6aa.camel@linaro.org>
Subject: Re: [PATCH 4/6] mfd: max77759: modify irq configs
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Mon, 24 Nov 2025 06:21:00 +0000
In-Reply-To: <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
	 <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Amit,

Thanks for your patches to enable the charger!

> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Define specific bit-level masks for charger's registers and modify the
> irq mask for charger irq_chip. Also, configure the max77759 interrupt
> lines as active low to all interrupt registrations to ensure the
> interrupt controllers are configured with the correct trigger type.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0drivers/mfd/max77759.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +++=
++++++++++++++-------
> =C2=A0include/linux/mfd/max77759.h |=C2=A0 9 +++++++++
> =C2=A02 files changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
> index 6cf6306c4a3b..5fe22884f362 100644
> --- a/drivers/mfd/max77759.c
> +++ b/drivers/mfd/max77759.c
> @@ -256,8 +256,17 @@ static const struct regmap_irq max77759_topsys_irqs[=
] =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct regmap_irq max77759_chgr_irqs[] =3D {
> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
> -	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
> +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_AICL |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_CHGIN |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_CHG |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT_INLIM),
> +	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_BAT_OI=
LO |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_CHG_ST=
A_CC |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_CHG_ST=
A_CV |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_CHG_ST=
A_TO |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX77759_CHGR_REG_CHG_INT2_CHG_ST=
A_DONE),
> =C2=A0};
> =C2=A0
> =C2=A0static const struct regmap_irq_chip max77759_pmic_irq_chip =3D {
> @@ -486,8 +495,8 @@ static int max77759_add_chained_irq_chip(struct devic=
e *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get parent vIRQ(%d) for chi=
p %s\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 pirq, chip->name);
> =C2=A0
> -	ret =3D devm_regmap_add_irq_chip(dev, regmap, irq,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHOT | IRQF_SHARED, 0, =
chip,
> +	ret =3D devm_regmap_add_irq_chip(dev, regmap, irq, IRQF_ONESHOT |
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_SHARED | IRQF_TRIGGER_LOW,=
 0, chip,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data);

Please correct me if I'm wrong, but I don't think this makes sense for a
chained IRQ in this case. What problem does this change fix?

> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "failed to add %s IRQ chip\n",
> @@ -519,8 +528,9 @@ static int max77759_add_chained_maxq(struct i2c_clien=
t *client,
> =C2=A0
> =C2=A0	ret =3D devm_request_threaded_irq(&client->dev, apcmdres_irq,
> =C2=A0					NULL, apcmdres_irq_handler,
> -					IRQF_ONESHOT | IRQF_SHARED,
> -					dev_name(&client->dev), max77759);
> +					IRQF_ONESHOT | IRQF_SHARED |
> +					IRQF_TRIGGER_LOW, dev_name(&client->dev),
> +					max77759);

dito.

> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(&client->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "MAX77759_MAXQ_INT_APCMDRESI failed\n"=
);
> @@ -633,7 +643,7 @@ static int max77759_probe(struct i2c_client *client)
> =C2=A0		return dev_err_probe(&client->dev, -EINVAL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "invalid IRQ: %d\n", client->irq);
> =C2=A0
> -	irq_flags =3D IRQF_ONESHOT | IRQF_SHARED;
> +	irq_flags =3D IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW;

I don't believe IRQF_TRIGGER_LOW should be added here, as this is board-spe=
cific.
The polarity is meant to be set via DT (and the only current user of this d=
river
does so).

> =C2=A0	irq_flags |=3D irqd_get_trigger_type(irq_data);

That's what gets us the config from DT.

> =C2=A0
> =C2=A0	ret =3D devm_regmap_add_irq_chip(&client->dev, max77759->regmap_to=
p,
> diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
> index c6face34e385..0ef29a48deec 100644
> --- a/include/linux/mfd/max77759.h
> +++ b/include/linux/mfd/max77759.h
> @@ -62,7 +62,16 @@
> =C2=A0#define MAX77759_CHGR_REG_CHG_INT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xb0
> =C2=A0#define MAX77759_CHGR_REG_CHG_INT2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xb1
> =C2=A0#define MAX77759_CHGR_REG_CHG_INT_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xb2
> +#define MAX77759_CHGR_REG_CHG_INT_AICL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(7)
> +#define MAX77759_CHGR_REG_CHG_INT_CHGIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(6)
> +#define MAX77759_CHGR_REG_CHG_INT_CHG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4)
> +#define MAX77759_CHGR_REG_CHG_INT_INLIM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(2)
> =C2=A0#define MAX77759_CHGR_REG_CHG_INT2_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0xb3
> +#define MAX77759_CHGR_REG_CHG_INT2_BAT_OILO=C2=A0=C2=A0=C2=A0=C2=A0 BIT(=
4)
> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC=C2=A0=C2=A0 BIT(3)
> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV=C2=A0=C2=A0 BIT(2)
> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO=C2=A0=C2=A0 BIT(1)
> +#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE BIT(0)

Even if wireless out of scope, it'd still be nice to add macros for
the remaining bits to make this complete and avoid having to update
these again in case wireless support gets added in the future.

Also, would be nice to keep existing style and indent the bits from
the registers (see existing bit definitions in this file a few lines
further up).

Finally, can you add the bits below the respective register (0xb0 / 0xb1)
please, to keep suffix meaningful, and to follow existing style for cases
like this (see MAX77759_MAXQ_REG_UIC_INT1).


Cheers,
Andre'

