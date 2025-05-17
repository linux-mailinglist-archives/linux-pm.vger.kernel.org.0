Return-Path: <linux-pm+bounces-27264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD03ABA9A7
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791793BE09F
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FFA1DDA09;
	Sat, 17 May 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFl8Myr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A71B6CE9;
	Sat, 17 May 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747480733; cv=none; b=PJvXki1A0xfLWFcfKn8K4cTLNvskKC9CLdF8tVO2rJxQmzpPNmya3aQAZXlqFBKYJlIxDWJ1S4AIXQdNbyzAJO+gRZmJ1hlVH8HEkyAOWc/SgB/UPUbU7fDEw/aw8q2Ho1d7rUfiREDjKKgdQyozsBbqTxZsVdatSkMpoqhZ1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747480733; c=relaxed/simple;
	bh=MPdzYIq7/J3CmyoD/GlHukOWsSzehm0XQFEIdnZvlCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiZieNcCnWhBqpBXgkEn4t6DLksruEuANvX+IA3KA1y/z4efY8UwBDmNABohw7ZzI9UVcnBj3wvvNnTP45YJew9s8BTtbX9lTgYv6ibCwgA9Mr4SSJ7SmC8YZV1EWB6tQfRFF0NBsl1oBRMjlCj8t6kT279SYCG7wOEfo3VM/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFl8Myr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653CC4CEE3;
	Sat, 17 May 2025 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747480732;
	bh=MPdzYIq7/J3CmyoD/GlHukOWsSzehm0XQFEIdnZvlCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WFl8Myr9Is9JMCocSMXcQVMQv2khtHkTcCwImEBO8HGet90csh+b3k+OUGl39o0Ex
	 6O6RzIoP00/ZJrSYD96NxEXliYtTQp7BLljRaQ4ye57AoKCEiRLRpmpUnu64GDRpHZ
	 PGR1YNE3Db1lzec9HZH45keMNY+4zAUq1AVtL2GwcjfUlY6G1yq2SHJVhLMJKpiTAx
	 ThVuikUlFhi+KdKofYwJCM/kF34trg+aBNv3dNEIFpjD8B9DQjCmZaAPQgH7rKxuOk
	 +4Y2PaIfPQbMVNcruC+7toUPj2h/JWr6dH58855T52tkbWmElAP2bg6g7qMoxwLd16
	 nOns3kwO68JUA==
Message-ID: <0c84a24a-2dbe-4c8f-80b1-2e1531fd4ec1@kernel.org>
Date: Sat, 17 May 2025 13:18:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] mfd: pf1550: add core mfd driver
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
 Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-imx@nxp.com, linux-input@vger.kernel.org,
 Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
 Robin Gong <b38343@freescale.com>, Enric Balletbo Serra <eballetbo@gmail.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:54, Samuel Kayode wrote:
> +
> +static int pf1550_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pf1550_dev *pf1550;
> +	unsigned int reg_data = 0;
> +	int ret = 0;
> +
> +	pf1550 = devm_kzalloc(&i2c->dev,
> +			      sizeof(struct pf1550_dev), GFP_KERNEL);

sizeof(*)

> +	if (!pf1550)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, pf1550);
> +	pf1550->dev = &i2c->dev;
> +	pf1550->i2c = i2c;
> +	pf1550->irq = i2c->irq;
> +
> +	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
> +	if (IS_ERR(pf1550->regmap)) {
> +		ret = PTR_ERR(pf1550->regmap);
> +		dev_err(pf1550->dev, "failed to allocate register map: %d\n",
> +			ret);


Syntax is always: return dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> +	if (ret < 0 || reg_data != PF1550_DEVICE_ID) {
> +		dev_err(pf1550->dev, "device not found!\n");
> +		return ret;

Syntax is always: return dev_err_probe

> +	}
> +
> +	pf1550->type = PF1550;
> +	dev_info(pf1550->dev, "pf1550 found.\n");

Drop. Drivers should be silent. This is really useless and just pollutes
log. See also coding style.

> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
> +				       pf1550->irq,
> +				IRQF_ONESHOT | IRQF_SHARED |
> +				IRQF_TRIGGER_FALLING, 0,
> +				&pf1550_regulator_irq_chip,
> +				&pf1550->irq_data_regulator);
> +	if (ret) {
> +		dev_err(pf1550->dev, "failed to add irq1 chip: %d\n", ret);
> +		return ret;

Syntax is always: return dev_err_probe

> +	}
> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
> +				       pf1550->irq,
> +				IRQF_ONESHOT | IRQF_SHARED |
> +				IRQF_TRIGGER_FALLING, 0,
> +				&pf1550_onkey_irq_chip,
> +				&pf1550->irq_data_onkey);
> +	if (ret) {
> +		dev_err(pf1550->dev, "failed to add irq3 chip: %d\n", ret);
> +		return ret;

Syntax is always: return dev_err_probe

> +	}
> +
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
> +				       pf1550->irq,
> +				IRQF_ONESHOT | IRQF_SHARED |
> +				IRQF_TRIGGER_FALLING, 0,
> +				&pf1550_charger_irq_chip,
> +				&pf1550->irq_data_charger);
> +	if (ret) {
> +		dev_err(pf1550->dev, "failed to add irq4 chip: %d\n", ret);
> +		return ret;

Syntax is always: return dev_err_probe

> +	}
> +
> +	return devm_mfd_add_devices(pf1550->dev, -1, pf1550_devs,
> +			      ARRAY_SIZE(pf1550_devs), NULL, 0, NULL);
> +}
> +
> +static const struct i2c_device_id pf1550_i2c_id[] = {
> +	{ "pf1550", PF1550 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);

Table IDs are next to each other.

> +
> +static int pf1550_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
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
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(pf1550->irq);
> +		enable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
> +
> +static const struct of_device_id pf1550_dt_match[] = {
> +	{ .compatible = "fsl,pf1550" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pf1550_dt_match);
> +
> +static struct i2c_driver pf1550_i2c_driver = {
> +	.driver = {
> +		   .name = "pf1550",
> +		   .pm = pm_sleep_ptr(&pf1550_pm),
> +		   .of_match_table = of_match_ptr(pf1550_dt_match),


Drop of_match_ptr, you have warnings here.

> +	},
> +	.probe = pf1550_i2c_probe,
> +	.id_table = pf1550_i2c_id,
> +};
> +
> +module_i2c_driver(pf1550_i2c_driver);
> +
> +MODULE_DESCRIPTION("Freescale PF1550 multi-function core driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL v2");
Best regards,
Krzysztof

