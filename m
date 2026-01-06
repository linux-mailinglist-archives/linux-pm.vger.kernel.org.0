Return-Path: <linux-pm+bounces-40252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E922CF6899
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B22303868D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657E241686;
	Tue,  6 Jan 2026 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoAGSmKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DD54723
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668376; cv=none; b=OU0csujYNBxgxQUJmEv7VA0AZVQmjaaOQ0VbqDzLc5lElVhfXLIP2LoaKXZWtYs4SAw+k4aPdn2CImHmTTdmt/P5wFSWEb7k7C3kt8DHU2ZvADaTUCn6E8K0xQNxPyPFwW7OLq6bbbSgmTEMWe9AyL3IwmXhwAtgAtwkgA0RxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668376; c=relaxed/simple;
	bh=KRw2b4R9PFIlO/drnHXKLMuOyIF5ZUeIW9noWvMfoPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY6jhrxCnaIW1XQfukl+X2+CYIyVJlJuJ9+T6HD0XIuCdmIrmyzpKJL+tlB0n3/ouKvSZ0qEmBYdIhcZkUnM1Sux/o6rE7j8LTAjvMcviNjh0PdEhSAIANPCl6Ir42ecFakaa5QbEykJXa/UHdc9S2haClgzP3fwT+5D/qwKZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoAGSmKt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda6a8cc12so5901441cf.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 18:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767668373; x=1768273173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx/qAej5N4kP3ROX4pofW6IJjT74Jh+ftw/LnFdFGx0=;
        b=YoAGSmKtx1o7TwLvfUZyYU02zfNyPr2/b4vkSW4EiHJHKC9QQzqT7YoJZR5+rd7J2n
         JxPTfJF5eZWasLAZbgvL+4YyhlF5ryCx2R0vjkDD/p6kk/ZX+Bi5uxiJrRAd12/e2LYX
         qlRXK6kkOpWrTfkbvnX2GzhWeLzI8VolC/Gj2XDZSDIPlSAr+T1kZydWOc2WkJXY3jVO
         BUygul1Tv3MyqrLkGkzYLoh7cLbE3qVYiJqF58lEQoO70A5q/8aoDPmbb5OuZiE6KGj+
         mdSYFE5yTltucBzA4XR5s8QVPH0o/G663RByJ21AvkIHAppathMT9MUucmvx+BiWKeVQ
         EbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767668373; x=1768273173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx/qAej5N4kP3ROX4pofW6IJjT74Jh+ftw/LnFdFGx0=;
        b=YVGZ4hIgXRuZezDrgf0pIiI5aKtcHhmaGsqBM8FlqWebdTzlK+wBeUjPLngwCvxUx8
         b5zL8iHQjB1yNvRHq7USK9BrCdnwaJlIIv5rsuF9YThLOMBXKeNPdnO/BrZUu8pkCI+F
         TemPY1Dk9dYCAFc5hit0reykVG071dVi2Xp1TitrnhX0V8jPNWNG2x60WuMJG8I8ibDa
         fYB1QiCsAlZwE8vxoxr0/Brug9iq0PHkqcreK/A/8mBHN7AiJ5QEYhIi9eoYRPNDQ6a7
         7AyuRNs69gm4uL0Any/4IxI4YfYMqyz+LZKzgtxEK553RXSV+iN9r90Ek5XQC5MGuAx3
         EQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjUmOJfDYlAC/504Rrb2FL4/beU6n7X9bMUVv7JUqQo4OICXyAPIzcpH28Qln7pB10q7Bwffuyfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCOVjm6VM/pBoYK/2jpuc5vOwCkax7oqAtroestN4KUUJThcb
	yUwjf610+YQf0LfF6BmTIg96ZblZYGGuykXEe/EJBUkE1WW0S2y39vVlIYfNUQ==
X-Gm-Gg: AY/fxX4We9vNZhlAzNLl1VICuF24SKbCmKkJY5eOJ3qW5stm/nQKWVRyYMHeP8Dk5Ar
	BRipi96lrz+5AWzHCVKzyTOQHxo7A5yvX13isFIyR+cjXvvX/eioV1q+6ywWuNCPz+RasfUfr2y
	h4zF8vHbgGUjNVMEO3BaKyHTfwOhoAlnFaNoW7kBALmUFczOnvbyUeDGHjcElGh4jE3LomcDQol
	zGrHDBwHEFxNr4FD8nb+aIW0zy39jfSD+KFDMgYN0TRtIxysxW3WpHb6YgthOoExyD1E5PiLTA6
	kEIopV9XgCdvnbwzqjq124YtoqUIUAfSBgJas4piykofUP6SAk4eDvwLxiEAZS34I6sbH9MHLLL
	GezTbIsSk57GW+z9TXGnxf5zvG9ilsVgBmlpgoipJqyVLwdUHvTvPvIZ1OqUoxMoVUwwjU0kBCY
	MXP7MGGNuB9w==
X-Google-Smtp-Source: AGHT+IGfzpRNHPBFd6mQg2Ynna6tB59sqYBTdeaJw7TnW20z6C7vEd+2oXqE4VOqORArcYacVQCHxQ==
X-Received: by 2002:a05:622a:1e1a:b0:4ed:b978:91db with SMTP id d75a77b69052e-4ffa781bd49mr22824561cf.77.1767668372780;
        Mon, 05 Jan 2026 18:59:32 -0800 (PST)
Received: from sam-fedora ([2605:b100:549:78f5:d4cd:470:c405:d573])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e363b7sm4984501cf.20.2026.01.05.18.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 18:59:32 -0800 (PST)
Date: Mon, 5 Jan 2026 21:59:29 -0500
From: Samuel Kayode <samkay014@gmail.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>, kernel@axis.com, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] power: supply: pf1550: Fix use-after-free in
 power_supply_changed()
Message-ID: <aVx6kVc34fpBPJ0J@sam-fedora>
References: <cover.1766268280.git.waqar.hameed@axis.com>
 <ae5a71b7e4dd2967d8fdcc531065cc71b17c86f5.1766268280.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5a71b7e4dd2967d8fdcc531065cc71b17c86f5.1766268280.git.waqar.hameed@axis.com>

On Sat, Dec 20, 2025 at 11:36:01PM +0100, Waqar Hameed wrote:
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
> Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Reviewed-by: Samuel Kayode <samkay014@gmail.com>

Thank you!
Sam

> ---
>  drivers/power/supply/pf1550-charger.c | 32 +++++++++++++--------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
> index 98f1ee8eca3bc..a457862ef4610 100644
> --- a/drivers/power/supply/pf1550-charger.c
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -584,22 +584,6 @@ static int pf1550_charger_probe(struct platform_device *pdev)
>  		return dev_err_probe(chg->dev, ret,
>  				     "failed to add battery sense work\n");
>  
> -	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> -		irq = platform_get_irq(pdev, i);
> -		if (irq < 0)
> -			return irq;
> -
> -		chg->virqs[i] = irq;
> -
> -		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -						pf1550_charger_irq_handler,
> -						IRQF_NO_SUSPEND,
> -						"pf1550-charger", chg);
> -		if (ret)
> -			return dev_err_probe(&pdev->dev, ret,
> -					     "failed irq request\n");
> -	}
> -
>  	psy_cfg.drv_data = chg;
>  
>  	chg->charger = devm_power_supply_register(&pdev->dev,
> @@ -616,6 +600,22 @@ static int pf1550_charger_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
>  				     "failed: power supply register\n");
>  
> +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		chg->virqs[i] = irq;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_charger_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-charger", chg);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed irq request\n");
> +	}
> +
>  	pf1550_dt_parse_dev_info(chg);
>  
>  	return pf1550_reg_init(chg);

