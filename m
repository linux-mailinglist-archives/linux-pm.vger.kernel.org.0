Return-Path: <linux-pm+bounces-39761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A0CD3C18
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 06:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB64530014CA
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 05:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E418A6DB;
	Sun, 21 Dec 2025 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="pXe3zv/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161EFBF0;
	Sun, 21 Dec 2025 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766295935; cv=none; b=kERPXaaocESKO+UBQiEUGMRpQ5nW5fdsl7TL893q8o4CGHEMQh5ZCtLWp+kO8vIcskVzDmx2SwvAiafs7u6FhetD2SFKb4QRSthSmYwQyNENjJL/KWO+ZmrIN2+s5AQT/z+xVLkGQul9NTDv9EANy7DLpvwoknphprPizdOLUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766295935; c=relaxed/simple;
	bh=m42c638gKCudDPO4OMD5pCq67RCmypWEvk8CDJFcDiQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aQ5din+v26Ksmj38H4bYgsj9YiUIhO1f7j5dKGsCVSN6nmGng2HvITyIjiL3FOyApGpxmHnKdp8BsDwT7dv8z8tpUXBiPNFV9FUvPUTU9m2Ib4cL0LMw6yDGZq4ilCrEQ/Ifx0FkjZNHSts0psGRRMdRfCqUKw4pyXUtQAX9ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=pXe3zv/h; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1766295924; bh=m42c638gKCudDPO4OMD5pCq67RCmypWEvk8CDJFcDiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXe3zv/hjaFQyv9rrsyOr6GHnA/xU6uwutBoHM1oeeXumSZufYUREYuanpsSwKBIj
	 6hR/hJNIb13NfOcG5veuY1m/z6mymBdCoUsX+cDAD+Q9tzd7M4QjCmOGZDOIVeEPC2
	 FkXncWY1Qo+WfLLWnf/Kxg9XFwmfoiCMG5E9o9x1hnAcQVj3SG3XIEwupOrqXfFJ2I
	 4QXL1kF+tV91TOYfyxaPq7hdVGWe+tq8I5f7TJlNtJTIbgOE6Kmn7gQL2hstSuO0RH
	 ijUQMtlSjGrHTF/5y2jFmrTSety8kxppyigLl5P+qqmYyGW56yQ5d1LLwUx5CjQByX
	 mvcXi0RRZl+ww==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id C2BD967AF9;
	Sun, 21 Dec 2025 10:45:24 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Dec 2025 10:45:24 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
 <64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
Message-ID: <5f3152f01420823ef8ae2932ed781cf4@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Waqar Hameed писал(а) 21.12.2025 03:36:
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
> the registration of the `power_supply` handle.
> 
> Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  drivers/power/supply/pm8916_lbc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
> index c74b75b1b2676..3ca717d84aade 100644
> --- a/drivers/power/supply/pm8916_lbc.c
> +++ b/drivers/power/supply/pm8916_lbc.c
> @@ -274,15 +274,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Wrong amount of reg values: %d (4 expected)\n", len);
>  
> -	irq = platform_get_irq_byname(pdev, "usb_vbus");
> -	if (irq < 0)
> -		return irq;
> -
> -	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> -					IRQF_ONESHOT, "pm8916_lbc", chg);
> -	if (ret)
> -		return ret;
> -
>  	ret = device_property_read_u32_array(dev, "reg", chg->reg, len);
>  	if (ret)
>  		return ret;
> @@ -332,6 +323,15 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Unable to get battery info\n");
>  
> +	irq = platform_get_irq_byname(pdev, "usb_vbus");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> +					IRQF_ONESHOT, "pm8916_lbc", chg);
> +	if (ret)
> +		return ret;
> +

Thank you for looking at those drivers and fixing this!

As a small note, the interrupt handler also has a call to
extcon_set_state_sync(chg->edev,...) which is allocated right below.
I don't think this is actually a problem since it has a null check for
edev (unlike psy core) so I think this patch is fine as-is. However if
for some reason you'd have to respin this series, perhaps it would be
nice to move irq registration slightly lower, after extcon registration.

In any case,

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Nikita

>  	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
>  	if (IS_ERR(chg->edev))
>  		return PTR_ERR(chg->edev);

