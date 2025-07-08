Return-Path: <linux-pm+bounces-30393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B6AFD6A6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B8427E40
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2021D018;
	Tue,  8 Jul 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Do33M+Zs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BE215075;
	Tue,  8 Jul 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000422; cv=none; b=rmqtzgswenDBMjMM4xt5tjGmxpIUi0OVwOiZTEfpWcB7QS1shn5OzkxaLeZgtKmXO9LoR+JB3WAvXrfphy0IWS+D6G0mxup5BFYhh/NPmpT8xOCSYRw+7VDnH3KN7trGP3tUmfNvkpg87F4fmRHrWea82MkLQ4QnZWEU/n9iCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000422; c=relaxed/simple;
	bh=6Gn+yRNl1JrOAlZoap5OkCRx3E5efJLTHxU979QWAl4=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=mDUB2HABWqqUnh5/VsAZdPr9+wrnxbfVXsxVaI/OGlVIaaV9FvZe8+EF9mIu7Vxx8Ssw6vWARXQLtEcX3Ro4xEIo+Q8ro3bMk5UDNkvLkypzRLVseuAoN2eDAYz6USciW5XyerNsnBt/8OPPzC0fXENnbsXhK/DH4NZ26tJaRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Do33M+Zs; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ZDL6uHsjEt5czZDL7uZYyq; Tue, 08 Jul 2025 20:46:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752000410;
	bh=1KMq9z5swwEqfJUujLxgmIpabvJfx13yCUzkaCHJsSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Do33M+ZskTXvpQmj5Ot7c3HkmJooV8IxNLxtavB3Soz8wkUWEkxkKc2D+2h8k621h
	 iqouVHpcMleRuXDEVdruV73DATz+EaTk3MLbTmsri+6r8hxvn31OXheuVqnU3mfG3M
	 OeZw/r7bU2X7yFDkLwDY8uiDgJG6U9lmIFHeu962ITaJ7nAG4VpjuENbgNFjwdf04t
	 ukZxHDhK9oSPgIbGFD7mn4DIOt8Ip/GpwVwJoWC3YCl1vTdEF4xerpeXHZtkQc1Wuk
	 wTe/GoiQpfZ34APi/VWCV+dUxRnYeXna9qb076SObnrTkm77krCb2ZJ2OmD0SpaRRY
	 DMjYmOu7G4dAw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 08 Jul 2025 20:46:50 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <0406698c-6534-4aca-8994-e8a69ecee2b2@wanadoo.fr>
Date: Tue, 8 Jul 2025 20:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] mfd: pf1550: add core driver
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: devnull+samuel.kayode.savoirfairelinux.com@kernel.org
Cc: Frank.li@nxp.com, abelvesa@kernel.org, abelvesa@linux.com,
 b38343@freescale.com, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, eballetbo@gmail.com,
 imx@lists.linux.dev, krzk+dt@kernel.org, lee@kernel.org,
 lgirdwood@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh@kernel.org,
 samuel.kayode@savoirfairelinux.com, sre@kernel.org, yibin.gong@nxp.com
In-Reply-To: <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/07/2025 à 23:37, Samuel Kayode via B4 Relay a écrit :
> From: Samuel Kayode <samuel.kayode-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
> 
> Add the core driver for pf1550 PMIC. There are 3 subdevices for which the
> drivers will be added in subsequent patches.
> 
> Reviewed-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Samuel Kayode <samuel.kayode-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>

Hi,

some nitpicks and a few real questions.

CJ

...

> +	/* Add top level interrupts */
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING,
> +				       0, &pf1550_irq_chip,
> +				       &pf1550->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	/* Add regulator */
> +	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_REGULATOR);

Same as above.

> +	if (irq < 0)
> +		return dev_err_probe(pf1550->dev, irq,
> +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> +				     PF1550_IRQ_REGULATOR, pf1550_irq_chip.name);
> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0,
> +				       &pf1550_regulator_irq_chip,
> +				       &pf1550->irq_data_regulator);
> +	if (ret)
> +		return dev_err_probe(pf1550->dev, ret,
> +				     "Failed to add %s IRQ chip\n",
> +				     pf1550_regulator_irq_chip.name);
> +
> +	domain = regmap_irq_get_domain(pf1550->irq_data_regulator);
> +
> +	ret =  devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, regulator,

2 spaces after =

> +				    1, NULL, 0, domain);
> +	if (ret)
> +		return ret;
> +
> +	/* Add onkey */
> +	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_ONKEY);

Same

> +	if (irq < 0)
> +		return dev_err_probe(pf1550->dev, irq,
> +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> +				     PF1550_IRQ_ONKEY, pf1550_irq_chip.name);
> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0,
> +				       &pf1550_onkey_irq_chip,
> +				       &pf1550->irq_data_onkey);
> +	if (ret)
> +		return dev_err_probe(pf1550->dev, ret,
> +				     "Failed to add %s IRQ chip\n",
> +				     pf1550_onkey_irq_chip.name);
> +
> +	domain = regmap_irq_get_domain(pf1550->irq_data_onkey);
> +
> +	ret =  devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, onkey, 1,

2 spaces after =

> +				    NULL, 0, domain);
> +	if (ret)
> +		return ret;
> +
> +	/* Add battery charger */
> +	irq = regmap_irq_get_virq(pf1550->irq_data, PF1550_IRQ_CHG);

This calls irq_create_mapping().
Should irq_dispose_mapping() or another helper be called in the error 
handling path and in the remove function, or is it already handled by a 
devm_ function?

> +	if (irq < 0)
> +		return dev_err_probe(pf1550->dev, irq,
> +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> +				     PF1550_IRQ_CHG, pf1550_irq_chip.name);
> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING, 0,
> +				       &pf1550_charger_irq_chip,
> +				       &pf1550->irq_data_charger);
> +	if (ret)
> +		return dev_err_probe(pf1550->dev, ret,
> +				     "Failed to add %s IRQ chip\n",
> +				     pf1550_charger_irq_chip.name);
> +
> +	domain = regmap_irq_get_domain(pf1550->irq_data_charger);
> +
> +	return devm_mfd_add_devices(pf1550->dev, PLATFORM_DEVID_NONE, charger,
> +				    1, NULL, 0, domain);
> +}
> +
> +static int pf1550_suspend(struct device *dev)
> +{
> +	struct pf1550_ddata *pf1550 = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(pf1550->irq);
> +		disable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_resume(struct device *dev)
> +{
> +	struct pf1550_ddata *pf1550 = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(pf1550->irq);
> +		enable_irq(pf1550->irq);

Should this 2 lines be inverted?

> +	}
> +
> +	return 0;
> +}

...

> +#define PF1550_CHG_LINEAR_ONLY		12
> +#define PF1550_CHG_SNS_MASK		0xf
> +#define PF1550_CHG_INT_MASK             0x51

Space vs tab

> +
> +#define PF1550_BAT_NO_VBUS		0
> +#define PF1550_BAT_LOW_THAN_PRECHARG	1

...

CJ

