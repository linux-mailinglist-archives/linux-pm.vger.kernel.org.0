Return-Path: <linux-pm+bounces-18971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F059EBDA1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 23:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F2D16756F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ABB1F1917;
	Tue, 10 Dec 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IdjbnnJt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8501EE7A3;
	Tue, 10 Dec 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868471; cv=none; b=qatQ/HizhtO0hNPTBWJknbP2N6pb08zBwKddp0sYkpCR38tWaZlZFUMcGWf/JHn3DM3DQ1O/bCKnej727bObyQNW9Ap2mkXtuiBVzbR2Nqca0vKKlxx0uSRzXczmWCOpUcZUq6U7tQb+0rmFXcN5dc0ZvBuNVwIVqwcugLoC5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868471; c=relaxed/simple;
	bh=30fQ1JSKA6ogu9UhDW11Yk/kOdFzk+xKJiQatxUQACw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUjYPt96/5l8EOZzsln9zVJNsNSl3/kZYUgeKpEFjAL5RalUA8Z8bjLbJP843s09Ka9sVe466CmllPpk6LA93oLEG85KSv187HldQXmfogB8m3WNDvuDOordDv/5N0wLjMbdWuLtNicRLvZiFr4uM9wHxWk+cJElGbReonfeBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IdjbnnJt; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id L8ONtY3Roj2I6L8ONtt4eo; Tue, 10 Dec 2024 23:07:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733868466;
	bh=uz6gxdciznG8CDr0h0Zdpu/ElUf4Mfu7nz7WNv1xPc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IdjbnnJtEDs9JyhaObaTU97UEO4KsHA+8+moigv5gvUjRi5+4LEGSuoDeJSwbhyxL
	 1YU9zQrU2eZc0C9TWHaimmWeLsoVdGA+m3HDXIy5adJal6ap+Hyw6aascW6eQLGD5n
	 77qJ0gMHIdAOl9+LqyWzyMgJULuMF1iAZ5J5hBl1CRvc9ytryIC7sBXI69jefO2e65
	 ozVTd6HAnnpv1oQxCKwFkszga0AeC/DdXl0W6RkybJAZlzSgO8UIt9x7QisY2ak64P
	 bWNqGIyo4fd/9egBD+81Y38b+fNe9BEYjypEADby3nRXuQ1BRZ+8YDO3/QUqHhmTvp
	 qvi6PiUT+p3bQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 10 Dec 2024 23:07:46 +0100
X-ME-IP: 90.11.132.44
Message-ID: <27f4fda0-a00b-4278-a5a1-1cea4a3be97c@wanadoo.fr>
Date: Tue, 10 Dec 2024 23:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] power: supply: max77705: Add charger driver for
 Maxim 77705
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-8-dc0598828e01@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-8-dc0598828e01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/12/2024 à 12:26, Dzmitry Sankouski a écrit :
> Add driver for Maxim 77705 switch-mode charger (part of max77705
> MFD driver) providing power supply class information to userspace.
> 
> The driver is configured through DTS (battery and system related
> settings).
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 

...

> +static void max77705_chgin_isr_work(struct work_struct *work)
> +{
> +	struct max77705_charger_data *charger =
> +		container_of(work, struct max77705_charger_data, chgin_work);

Missing new line.

> +	power_supply_changed(charger->psy_chg);
> +}

...

> +static int max77705_charger_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config pscfg = {};
> +	struct i2c_client *i2c_chg;
> +	struct max77693_dev *max77705;
> +	struct max77705_charger_data *chg;
> +	struct device *dev, *parent;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	max77705 = dev_get_drvdata(parent);
> +
> +	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	i2c_chg = devm_i2c_new_dummy_device(dev, max77705->i2c->adapter, I2C_ADDR_CHG);
> +	if (IS_ERR(i2c_chg))
> +		return PTR_ERR(i2c_chg);
> +
> +	chg->regmap = devm_regmap_init_i2c(i2c_chg, &max77705_chg_regmap_config);
> +	if (IS_ERR(chg->regmap))
> +		return PTR_ERR(chg->regmap);
> +
> +	chg->dev = dev;
> +
> +	ret = regmap_update_bits(chg->regmap,
> +				MAX77705_CHG_REG_INT_MASK,
> +				MAX77705_CHGIN_IM, 0);
> +	if (ret)
> +		return ret;
> +
> +	pscfg.of_node = dev->of_node;
> +	pscfg.drv_data = chg;
> +
> +	chg->psy_chg = devm_power_supply_register(dev, &max77705_charger_psy_desc, &pscfg);
> +	if (IS_ERR(chg->psy_chg))
> +		return PTR_ERR(chg->psy_chg);
> +
> +	max77705_charger_irq_chip.irq_drv_data = chg;
> +	ret = devm_regmap_add_irq_chip(chg->dev, chg->regmap, max77705->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					&max77705_charger_irq_chip,
> +					&irq_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add irq chip\n");
> +
> +	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
> +	if (IS_ERR(chg->wqueue))
> +		return dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create workqueue\n");
> +
> +	INIT_WORK(&chg->chgin_work, max77705_chgin_isr_work);
> +
> +	max77705_charger_initialize(chg);
> +
> +	ret = devm_add_action_or_reset(dev, max77705_charger_disable, chg);

*Based on naming only*, it is strange to add an action to disable 
something that seems to be enabled a few lines below.

Should this be after a successfulmax77705_charger_enable()?

> +	if (ret)
> +		return ret;
> +
> +	return max77705_charger_enable(chg);
> +}

...

CJ

