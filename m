Return-Path: <linux-pm+bounces-20602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5DA14A94
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 09:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E93AA37F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A11F8692;
	Fri, 17 Jan 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDYSftch"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A41F8688;
	Fri, 17 Jan 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100890; cv=none; b=tQSGLjjEKVAIXEbPzydnbFNZEekItkKmTbBXKPsUIwN001A27lWQ2XkPOmnic5WYhAYGyT4XTnzlZ9/DgZYsl+AwHY7XdVnEuct54Pd247mlgKmEtVi9U6SpX2uRN8iNqAcMn9aLMUA1POUWhCdAv+A8Fig2vauvjfvGBn9pZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100890; c=relaxed/simple;
	bh=NnRavfB9uItYINf/1q7rCdHTRpSp3d5UiU5//BDE1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFi/kLmNT9nECnybA0+c604JFhhRJz6YnlPx3cvOvOBP6/Qvlejx5wkGwF08m1W1OcMBBiRv2qPOW4KZtyidNRQvo+n+YrVrZ3QU4mmEtl0/QXJNzO9D5FFP8Fdv+K+Q3914O8YuKS9/fpd7RspJvSqobZJSezt3XrBj1L2feBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDYSftch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CBC4CEE3;
	Fri, 17 Jan 2025 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737100890;
	bh=NnRavfB9uItYINf/1q7rCdHTRpSp3d5UiU5//BDE1Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDYSftchvdrrCizB5Qe4SUTMbXp7vhR9MFixMqqR+ZgMtR8S8vNb7ScGwtQvEcPiP
	 BIMHiAPMATBs4Pyjn3hI2oOYovzisMmzEOCUgDxUW8rXC5p6b3huHMVTsVtZTBVEKx
	 dC9GB0XbQd20JpoQDsEXW/mqrZuiXgdUUxk5DnpkO/ksISctcO7eUmba/5kGPtBkkw
	 N8Uij+/w9PAgxM3kXEkeJl52sy671xQ2J+T7JeCPnd2SSkeqqz72dKWxiDDpPsGPft
	 VPMbhTvJHS6nbmMKk3KKTHP6UFcoLctWYdSxx1HZH8GkbKlP0R+rJY+c/fcEqho6tQ
	 1GaoslmOxxwUg==
Date: Fri, 17 Jan 2025 09:01:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v15 6/7] input: max77693: add max77705 haptic support
Message-ID: <20250117-chubby-convivial-axolotl-29e2df@krzk-bin>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
 <20250116-starqltechn_integration_upstream-v15-6-cf229de9f758@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-6-cf229de9f758@gmail.com>

On Thu, Jan 16, 2025 at 07:26:08PM +0300, Dzmitry Sankouski wrote:
>  #define MAX_MAGNITUDE_SHIFT	16
> @@ -115,6 +116,13 @@ static int max77693_haptic_configure(struct max77693_haptic *haptic,
>  			MAX77693_HAPTIC_PWM_DIVISOR_128);
>  		config_reg = MAX77693_HAPTIC_REG_CONFIG2;
>  		break;
> +	case TYPE_MAX77705:
> +		value = ((haptic->type << MAX77693_CONFIG2_MODE) |
> +			(enable << MAX77693_CONFIG2_MEN) |
> +			(haptic->mode << MAX77693_CONFIG2_HTYP) |
> +			MAX77693_HAPTIC_PWM_DIVISOR_128);

That's the same as previous one, why duplicating?

> +		config_reg = MAX77705_PMIC_REG_MCONFIG;
> +		break;
>  	case TYPE_MAX77843:
>  		value = (haptic->type << MCONFIG_MODE_SHIFT) |
>  			(enable << MCONFIG_MEN_SHIFT) |
> @@ -312,6 +320,9 @@ static int max77693_haptic_probe(struct platform_device *pdev)
>  	case TYPE_MAX77693:
>  		haptic->regmap_haptic = max77693->regmap_haptic;
>  		break;
> +	case TYPE_MAX77705:
> +		haptic->regmap_haptic = max77693->regmap;
> +		break;

Drop these two above.

>  	case TYPE_MAX77843:
>  		haptic->regmap_haptic = max77693->regmap;
>  		break;
> @@ -407,6 +418,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
>  
>  static const struct platform_device_id max77693_haptic_id[] = {
>  	{ "max77693-haptic", },
> +	{ "max77705-haptic", },
>  	{ "max77843-haptic", },
>  	{},
>  };
> @@ -414,6 +426,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
>  
>  static const struct of_device_id of_max77693_haptic_dt_match[] = {
>  	{ .compatible = "maxim,max77693-haptic", },
> +	{ .compatible = "maxim,max77705-haptic", },

So the device looks fully compatible with max77693. Drop this change and
express compatibility with fallback.

Best regards,
Krzysztof


