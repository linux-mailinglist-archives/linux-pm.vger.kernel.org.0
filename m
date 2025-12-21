Return-Path: <linux-pm+bounces-39762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A50BFCD3C22
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 06:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7024F300BBAF
	for <lists+linux-pm@lfdr.de>; Sun, 21 Dec 2025 05:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7A224249;
	Sun, 21 Dec 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="e9Z7lScb"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33072236F7;
	Sun, 21 Dec 2025 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766296031; cv=none; b=Cd5hLNchLdVNoG5VNZC75p/vKsCiWvJif8i7MgnBfqLYCcsXyLy2pgOze2juDusR9ZVzc8GJeSO5iIgwLqwjMS3o+ujkd1eYgnzZt23CitVJyDTRk9PBQELo4xX1B3odGWq5Wn+wnP8PQZ/vXfMgDRsXN46emCscDS1fodLB+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766296031; c=relaxed/simple;
	bh=YbNUNytmgvo9UG3wfHZftckw3QI6t+OcVkSmdvmRurg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MljQialV76mCDk4yYppIr8U+zo1Do0ee9bgVI1EGpKQTlhkoNI1ZOBdz35H1r6LnLJcdjV9vdwjDBobTarcMcrsy6wl7CTrPc2sDPibrGHy5lZOfWI0vSNJVcDzMNWm0IRVYKt580bVYhpEikYCSbY1IfTEqiJ6OAOBCbZz3DJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=e9Z7lScb; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1766296025; bh=YbNUNytmgvo9UG3wfHZftckw3QI6t+OcVkSmdvmRurg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e9Z7lScbcCG8zcogdLIFGU6IFROO+2b04NKjGOcp/Dk8YFwBw2tY75IsV+YNyX34w
	 WJPVJsq9nsk5qBmFI6JyY+sJAKqg81yu/ZPvPkXeD23FF1uz3YxdKqzLumKA6GPrPq
	 Wg0rx1K65H1iEJbLeanh0eNhDr31xZCbQM/m2Q09+YVFMQqQ5sPKTjItwOBorcteTO
	 rASPQaWhHzCcrsuVeyiXXvEFCvm5I7Cp8aSBSPRZ2uMdt5d/5fnmDl3ooXy743AZVM
	 f6T4pALhaNDxX/B+EMwX8XMC/hwkv8aX5KcOQwQan9mN4Ju8VMV/oX8z9ERJTK9Y9i
	 XwQNMT/LuajCw==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id A9CFB67522;
	Sun, 21 Dec 2025 10:47:05 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Dec 2025 10:47:05 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] power: supply: pm8916_bms_vm: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <2749c09ff81fcac87ae48147e216135450d8c067.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
 <2749c09ff81fcac87ae48147e216135450d8c067.1766268280.git.waqar.hameed@axis.com>
Message-ID: <8661da6b765ce3d27502dfbbb56aeb33@trvn.ru>
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
> Fixes: 098bce1838e0 ("power: supply: Add pm8916 VM-BMS support")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Thanks for fixing this!
Nikita

> ---
>  drivers/power/supply/pm8916_bms_vm.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
> index 5120be086e6ff..de5d571c03e21 100644
> --- a/drivers/power/supply/pm8916_bms_vm.c
> +++ b/drivers/power/supply/pm8916_bms_vm.c
> @@ -167,15 +167,6 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	irq = platform_get_irq_byname(pdev, "fifo");
> -	if (irq < 0)
> -		return irq;
> -
> -	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
> -					IRQF_ONESHOT, "pm8916_vm_bms", bat);
> -	if (ret)
> -		return ret;
> -
>  	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tmp, 2);
>  	if (ret)
>  		goto comm_error;
> @@ -220,6 +211,15 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Unable to get battery info\n");
>  
> +	irq = platform_get_irq_byname(pdev, "fifo");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
> +					IRQF_ONESHOT, "pm8916_vm_bms", bat);
> +	if (ret)
> +		return ret;
> +
>  	platform_set_drvdata(pdev, bat);
>  
>  	return 0;

