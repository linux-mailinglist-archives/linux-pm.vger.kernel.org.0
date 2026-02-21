Return-Path: <linux-pm+bounces-42968-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KwyUEvDMmWlGWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42968-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:19:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924B16D245
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F6030097D3
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D511C5F1B;
	Sat, 21 Feb 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLEtjnW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153A10FD;
	Sat, 21 Feb 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771687149; cv=none; b=MJbcFbzsndOrqpJkO10cw/+Glts/TR0uZuOll78B+plu9jmpejdoxwJeedIzX74BfAb33Jb3Z2oJQp/N45aBgs8W0DO4HkHm9kUNqYAWNXOGjUPTqXgvhxaG9K2xhLG8Ih28fOSdoodY9q81kTbGBx68/f36UENPq15a4NpfXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771687149; c=relaxed/simple;
	bh=Zz0FS9nJYqkqWp4U8cbrwWyn0Ej+tU13HebAyh9+FLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MBZkhEih68pqrsd3onpqS9Az6Tabn5QcujYxf2emDq5MHk8FcLHLRjPAkEO4GN1B5RZ48f7N9Cw5oheUkGIrIdiTFh/XekLg7rjR+rIgF/JfRdboNXatNdGBK0/iq4/AziL5FEFrT9a2wpYWvrTFsEgvXXdOMGP7PshIZQV0clQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLEtjnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8FBC4CEF7;
	Sat, 21 Feb 2026 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771687148;
	bh=Zz0FS9nJYqkqWp4U8cbrwWyn0Ej+tU13HebAyh9+FLk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JsLEtjnWGe228IDio0Vp41Nfci2/B/cOTqdxm7NoWj1uz2+NWOBcmdiHxCHh7BpG3
	 1N+NaPfdPQECKQ3jAFRA3U9Nk+nZsYq2P6SdBypiudDa9GtnaUL5HJhQ38kA5eF8Gl
	 qRRTuAfQjGr4NFSJLwrqxxAMi0Xn76eg5IIfcoyQtM3a7MtdE+nkgJbHa1co6cS6db
	 DLFSBGG+1FNeH/vtDxM8tofJwqPRG3e24lNwAmOg11+DEt9P9Nwl6sAW0J7EVm5uNK
	 IJJg88KusDvU1u//8HYExhvnA47EtV2RvxE0qzF3DV5cLK5J8KcxoyId0zl5tg5dVN
	 2BfiiHmNyW9aA==
Message-ID: <51efbb45-496d-4c60-81b3-85af265d8f81@kernel.org>
Date: Sat, 21 Feb 2026 16:19:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] power: supply: axp288_charger: Simplify returns of
 dev_err_probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
 <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42968-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9924B16D245
X-Rspamd-Action: no action

Hi,

On 20-Feb-26 18:49, Krzysztof Kozlowski wrote:
> One of benefits of dev_err_probe() is that it returns the error value
> greatly simplifying the error paths (e.g. three lines -> one line).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> 
> ---
> 
> Context depends on previous patch
> ---
>  drivers/power/supply/axp288_charger.c | 52 ++++++++++++---------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index ca52c2c82b2c..ea0f5caee8f0 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -859,12 +859,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (IS_ERR(info->cable.edev)) {
> -		dev_err_probe(dev, PTR_ERR(info->cable.edev),
> -			      "extcon_get_extcon_dev(%s) failed\n",
> -			      AXP288_EXTCON_DEV_NAME);
> -		return PTR_ERR(info->cable.edev);
> -	}
> +	if (IS_ERR(info->cable.edev))
> +		return dev_err_probe(dev, PTR_ERR(info->cable.edev),
> +				     "extcon_get_extcon_dev(%s) failed\n",
> +				     AXP288_EXTCON_DEV_NAME);
>  
>  	/*
>  	 * On devices with broken ACPI GPIO event handlers there also is no ACPI
> @@ -878,12 +876,11 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  
>  	if (extcon_name) {
>  		info->otg.cable = extcon_get_extcon_dev(extcon_name);
> -		if (IS_ERR(info->otg.cable)) {
> -			dev_err_probe(dev, PTR_ERR(info->otg.cable),
> -				      "extcon_get_extcon_dev(%s) failed\n",
> -				      USB_HOST_EXTCON_NAME);
> -			return PTR_ERR(info->otg.cable);
> -		}
> +		if (IS_ERR(info->otg.cable))
> +			return dev_err_probe(dev, PTR_ERR(info->otg.cable),
> +					     "extcon_get_extcon_dev(%s) failed\n",
> +					     USB_HOST_EXTCON_NAME);
> +
>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
>  
> @@ -897,11 +894,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	charger_cfg.drv_data = info;
>  	info->psy_usb = devm_power_supply_register(dev, &axp288_charger_desc,
>  						   &charger_cfg);
> -	if (IS_ERR(info->psy_usb)) {
> -		ret = PTR_ERR(info->psy_usb);
> -		dev_err(dev, "failed to register power supply: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(info->psy_usb))
> +		return dev_err_probe(dev, PTR_ERR(info->psy_usb),
> +				     "failed to register power supply: %d\n", ret);
>  
>  	/* Cancel our work on cleanup, register this before the notifiers */
>  	ret = devm_work_autocancel(dev, &info->cable.work,
> @@ -913,10 +908,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
>  	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
>  						&info->cable.nb);
> -	if (ret) {
> -		dev_err(dev, "failed to register cable extcon notifier\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register cable extcon notifier\n");
> +
>  	schedule_work(&info->cable.work);
>  
>  	ret = devm_work_autocancel(dev, &info->otg.work,
> @@ -929,10 +923,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	if (info->otg.cable) {
>  		ret = devm_extcon_register_notifier(dev, info->otg.cable,
>  					EXTCON_USB_HOST, &info->otg.id_nb);
> -		if (ret) {
> -			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to register EXTCON_USB_HOST notifier\n");
> +
>  		schedule_work(&info->otg.work);
>  	}
>  
> @@ -951,11 +945,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  		ret = devm_request_threaded_irq(&info->pdev->dev, info->irq[i],
>  					NULL, axp288_charger_irq_thread_handler,
>  					IRQF_ONESHOT, info->pdev->name, info);
> -		if (ret) {
> -			dev_err(dev, "failed to request interrupt=%d\n",
> -								info->irq[i]);
> -			return ret;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to request interrupt=%d\n",
> +					     info->irq[i]);
>  	}
>  
>  	return 0;


