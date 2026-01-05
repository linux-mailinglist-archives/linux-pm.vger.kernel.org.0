Return-Path: <linux-pm+bounces-40172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A183ECF1BB6
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 04:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A645F30053D0
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 03:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDE3168F7;
	Mon,  5 Jan 2026 03:23:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C327456
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.30.46.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767583382; cv=none; b=eE9HfjxSz9HsY74swKQJrS0IjjeB5qvnviXZzPaLYv/hG4f8QCh7CTvFOP7sXYkaBWK+PQXPZ+hgRpErXWOshHHsvF2qb6rHjA1P2V2jJBN2iNsL0q0N8LG27BITLZAQnvelVR569aF4TBYOYpx19QRJVDUdKconVGodgRbhPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767583382; c=relaxed/simple;
	bh=ufyJieSUsLESwOajeXGawMBzXNciCeUezzG/vwlBdlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiS5E1JW+KmDfmYf+tIZhFCwMM7CzyrGCeCK9zYmmL6FknPZULPT9p/DMi8IOat4RRjzYn5uWq8CrXxmXTUtpVpDad145pMlz4dorMbqj4Oyn35By7tnKC/9z3C4rH1PS8dmwcZjXR7ZpGW7KayDaeKxnphLdA2WxSGW/B/p1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au; spf=pass smtp.mailfrom=electromag.com.au; arc=none smtp.client-ip=203.30.46.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electromag.com.au
Received: (qmail 9196 invoked by uid 5089); 5 Jan 2026 03:16:13 -0000
Received: by simscan 1.2.0 ppid: 9066, pid: 9067, t: 0.6210s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.144?) (preid@electromag.com.au@144.6.137.188)
  by anchovy3.45ru.net.au with ESMTPA; 5 Jan 2026 03:16:12 -0000
Message-ID: <fde484b7-5e02-4999-a564-6e6072a8a4d5@electromag.com.au>
Date: Mon, 5 Jan 2026 11:16:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] power: supply: sbs-battery: Fix use-after-free in
 power_supply_changed()
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1766268280.git.waqar.hameed@axis.com>
 <0ef896e002495e615157b482d18a437af19ddcd0.1766268280.git.waqar.hameed@axis.com>
Content-Language: en-AU
From: Phil Reid <preid@electromag.com.au>
In-Reply-To: <0ef896e002495e615157b482d18a437af19ddcd0.1766268280.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/12/2025 06:36, Waqar Hameed wrote:
> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `power_supply` handle, means that
> the `power_supply` handle will be deallocated/unregistered _before_ the
> interrupt handler (since `devm_` naturally deallocates in reverse
> allocation order). This means that during removal, there is a race
> condition where an interrupt can fire just _after_ the `power_supply`
> handle has been freed, *but* just _before_ the corresponding
> unregistration of the IRQ handler has run.
> 
> This will lead to the IRQ handler calling `power_supply_changed()` with
> a freed `power_supply` handle. Which usually crashes the system or
> otherwise silently corrupts the memory...
> 
> Note that there is a similar situation which can also happen during
> `probe()`; the possibility of an interrupt firing _before_ registering
> the `power_supply` handle. This would then lead to the nasty situation
> of using the `power_supply` handle *uninitialized* in
> `power_supply_changed()`.
> 
> Fix this racy use-after-free by making sure the IRQ is requested _after_
> the registration of the `power_supply` handle. Keep the old behavior of
> just printing a warning in case of any failures during the IRQ request
> and finishing the probe successfully.
> 
> Fixes: d2cec82c2880 ("power: sbs-battery: Request threaded irq and fix dev callback cookie")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Reviewed-by: Phil Reid <preid@electromag.com.au>


> ---
>   drivers/power/supply/sbs-battery.c | 36 +++++++++++++++---------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 943c82ee978f4..43c48196c1674 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -1174,24 +1174,6 @@ static int sbs_probe(struct i2c_client *client)
>   
>   	i2c_set_clientdata(client, chip);
>   
> -	if (!chip->gpio_detect)
> -		goto skip_gpio;
> -
> -	irq = gpiod_to_irq(chip->gpio_detect);
> -	if (irq <= 0) {
> -		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
> -		goto skip_gpio;
> -	}
> -
> -	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
> -		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -		dev_name(&client->dev), chip);
> -	if (rc) {
> -		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
> -		goto skip_gpio;
> -	}
> -
> -skip_gpio:
>   	/*
>   	 * Before we register, we might need to make sure we can actually talk
>   	 * to the battery.
> @@ -1217,6 +1199,24 @@ static int sbs_probe(struct i2c_client *client)
>   		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
>   				     "Failed to register power supply\n");
>   
> +	if (!chip->gpio_detect)
> +		goto out;
> +
> +	irq = gpiod_to_irq(chip->gpio_detect);
> +	if (irq <= 0) {
> +		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
> +		goto out;
> +	}
> +
> +	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
> +		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +		dev_name(&client->dev), chip);
> +	if (rc) {
> +		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
> +		goto out;
> +	}
> +
> +out:
>   	dev_info(&client->dev,
>   		"%s: battery gas gauge device registered\n", client->name);
>   


-- 
Regards
Phil Reid
  
ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au
  
23 Junction Parade, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100

Email: preid@electromag.com.au

