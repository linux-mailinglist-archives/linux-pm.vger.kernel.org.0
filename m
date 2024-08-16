Return-Path: <linux-pm+bounces-12334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6FE954656
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D6B20DF0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3616516F8E7;
	Fri, 16 Aug 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndz1MSWZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011D1581E1;
	Fri, 16 Aug 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802408; cv=none; b=XW41KXY96t+Fz+dmc/6DTWnKa51WEGQ5yHPjwHpc+t7gpPeALRXqn9wfMjvblDImILiXppGVp6Hhz2dWiKWBH3ruKDfbV3ZstD0IM8qky8WflVh67EFnSI/f6pLG4FZaeXYV4fUYwPSwwXSbNucYK0nvEI/X2vUKBOmRg+i92vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802408; c=relaxed/simple;
	bh=iGD3NKOoj/2HsVzfmb91fDoaFzGl1gSpbffaUx8RW/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsxdT2wFmFcXR6AaddCXlaStxaQG4PwOTA6hCBT1LiL4PzPmMr2W3weyOJ6KEXbHtPbM4DH6qz3Fj02b1LErIeijz+GAXSTJzLCXX6bw/zSn8Uk12UoMK1nk3BM2Gvg3Bgh2XWAf8D+BQdKnJx2wkfvG8yix0wx3sy/d1xoVIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndz1MSWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A368C32782;
	Fri, 16 Aug 2024 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723802407;
	bh=iGD3NKOoj/2HsVzfmb91fDoaFzGl1gSpbffaUx8RW/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ndz1MSWZY4lYc5e00Ev45zKuoYRzqqDSmYciSb6lcWkpNjBLGBfk8U3KgpLPyWm7W
	 8rwa5i0D+/rmeeaTM2isvTMx1kijJf0/Wh1tCeWdArQ1U5WZ5KXX0aGBUhLkWH6ZRb
	 xS3s1DuTJgnMkLWhTQv/9GXPsknU9bSuOro6PkBCwM6iaYMZztMulyHD4jfUjhtY6a
	 ueBJ0QFVgS6htZaP1BMkSKHxSPZjBB7ugy01oraKQLbVTu4QCaGnyg6ZqrP8JG/tfj
	 MQXq7S+gOwDpMuWikMgPcgg1dz5NKp3e3uTcp1vO4FBhqokBcFV7tMOEPoJPzNkbRQ
	 qyMYfl3kpIkAw==
Message-ID: <bf5350ec-f722-4188-9e10-da5d5cb93e44@kernel.org>
Date: Fri, 16 Aug 2024 12:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] power: supply: max77693: Add USB extcon
 detection for enabling charging
To: Artur Weber <aweber.kernel@gmail.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>,
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-5-050a0a9bfea0@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240816-max77693-charger-extcon-v4-5-050a0a9bfea0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 10:19, Artur Weber wrote:
> 1. Add a function that allows for enabling/disabling charging.
> 
> 2. Add a device tree property, "maxim,usb-connector", that can be used to
> specify a USB connector to use to detect whether a charging cable has
> been plugged in/out, and enable/disable charging accordingly.
> 
> The extcon listener/worker implementation is inspired by the rt5033_charger
> driver.
> 
> Tested-by: Henrik Grimler <henrik@grimler.se>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v4:
> - Fix missing connector property causing probe deferrals
> 

Thank you for your patch. There is something to discuss/improve.


> +static void max77693_charger_extcon_work(struct work_struct *work)
> +{
> +	struct max77693_charger *chg = container_of(work, struct max77693_charger,
> +						  cable.work);
> +	struct extcon_dev *edev = chg->cable.edev;
> +	int connector, state;
> +	int ret;
> +
> +	for (connector = EXTCON_USB_HOST; connector <= EXTCON_CHG_USB_PD;
> +	     connector++) {
> +		state = extcon_get_state(edev, connector);
> +		if (state == 1)
> +			break;
> +	}
> +
> +	switch (connector) {
> +	case EXTCON_CHG_USB_SDP:
> +	case EXTCON_CHG_USB_DCP:
> +	case EXTCON_CHG_USB_CDP:
> +	case EXTCON_CHG_USB_ACA:
> +	case EXTCON_CHG_USB_FAST:
> +	case EXTCON_CHG_USB_SLOW:
> +	case EXTCON_CHG_USB_PD:
> +		ret = max77693_set_charging(chg, true);
> +		if (ret) {
> +			dev_err(chg->dev, "failed to enable charging\n");
> +			break;
> +		}
> +		dev_info(chg->dev, "charging. connector type: %d\n",
> +			 connector);

This and next one should be also dev_dbg. It is completely normal
condition, kind of expected thing to happen, so users do not need to be
bugged every time they plugs cable.

> +		break;
> +	default:
> +		ret = max77693_set_charging(chg, false);
> +		if (ret) {
> +			dev_err(chg->dev, "failed to disable charging\n");
> +			break;
> +		}
> +		dev_info(chg->dev, "not charging. connector type: %d\n",
> +			 connector);
> +		break;
> +	}
> +
> +	power_supply_changed(chg->charger);
> +}
> +
> +static int max77693_charger_extcon_notifier(struct notifier_block *nb,
> +					  unsigned long event, void *param)
> +{
> +	struct max77693_charger *chg = container_of(nb, struct max77693_charger,
> +						    cable.nb);
> +
> +	schedule_work(&chg->cable.work);
> +
> +	return NOTIFY_OK;
> +}
> +
>  /*
>   * Sets charger registers to proper and safe default values.
>   */
> @@ -734,12 +814,34 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
>  {
>  	struct device_node *np = dev->of_node;
>  	struct power_supply_battery_info *battery_info;
> +	struct device_node *np_conn, *np_edev;
>  
>  	if (!np) {
>  		dev_err(dev, "no charger OF node\n");
>  		return -EINVAL;
>  	}
>  
> +	np_conn = of_parse_phandle(np, "maxim,usb-connector", 0);

Where is the reference dropped?

> +	if (np_conn) {
> +		np_edev = of_get_parent(np_conn);

Same question

> +
> +		chg->cable.edev = extcon_find_edev_by_node(np_edev);

You probably need device_link_add() as well. I don't think above extcon
code cares about it.

> +		if (IS_ERR(chg->cable.edev)) {
> +			/*
> +			 * In case of deferred extcon probe, defer our probe as well
> +			 * until it appears.
> +			 */
> +			if (PTR_ERR(chg->cable.edev) == -EPROBE_DEFER)
> +				return PTR_ERR(chg->cable.edev);
> +			/*
> +			 * Otherwise, ignore errors (the charger can run without a
> +			 * connector provided).
> +			 */
> +			dev_warn(dev, "no extcon device found in device-tree (%ld)\n",
> +				 PTR_ERR(chg->cable.edev));
> +		}
> +	}


Best regards,
Krzysztof


