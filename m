Return-Path: <linux-pm+bounces-14884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0898892E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66A2281FF0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD018BB90;
	Fri, 27 Sep 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOaOpdkA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3532B9B5;
	Fri, 27 Sep 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455023; cv=none; b=pOGUHT9eM4GAoTGGj2FNuPD2/YfMfr4TF/1oEYW2mN1z50rXTtfC5KuhCOSQ2BRmylyOxnIC9B26wP0RZ+dGrqMdtev+zcKe4s4ohi1xvSpW4DHdjFk2MmHMa0X8+1iAjYeHZyD0cEn4v4SlbOubKjr9BehB3y5V+5n3icMQHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455023; c=relaxed/simple;
	bh=cE8uc4ERdsDeAe0swAxQQjjpJ7tIrnHlCwPdCs8T6xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm3RpFJiiA1UiWRkm/x7pmWadSCpOWnH2bw+iYxRSU1fSZe1wIGqacz8IE+CswE79uVYbdqhRXGrAkY+AWTIfAmA/P6Be1K5dFdl3o2P1yf13338lKKBjLk09v9NRZQ4kKX0qQ5UUawNdrZt4euRXeoByNWhJggYBBasSaNGn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOaOpdkA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-719b17b2da1so1810902b3a.0;
        Fri, 27 Sep 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727455021; x=1728059821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hX7TXSm7HZD9cV3ml+iTrVb9NoOlNFaOVSppEddhipY=;
        b=WOaOpdkAR761rtNmm6UjUAdURKcLdzM5CZPOQWwrfQR5XG63cO9eMvifDGizuhxCc6
         4WIFzPCVW9K1T6zFlQZ618tgt+glnkwPNByLJTnpbFzzsMptdcwKepH/NE1SuDKMpJvx
         fwb5sRxxTTrRug45M3wXwpq6ZY9+EuRoFbvdYBrd2wcasIGEbQZueTZlr8lKN5GQnyOm
         EawwxtW4XLXHWVv+HcbcukKPrevKu37gmPplNM696KAgwSI/2doMci95MPXRSMBOnduG
         wchFOsk8KrYGiWTan5k56mCMoAA8Y6hIgXqy0S2nCT5i5KQqd8KmzbauSgghwGeZWm1v
         FAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455021; x=1728059821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX7TXSm7HZD9cV3ml+iTrVb9NoOlNFaOVSppEddhipY=;
        b=St4ljMwBwWG0Qmn6FwQRYooeLn2Phmn3Pd6CgNJaMId3oRArYLuxO9SRO3dniOta5M
         iAciDvEuF3jKSdN3AffAcD7KpxD8AU9J2ua535s5bWLWEL7sBOMsdN/LRaIUEUTpxk0F
         ISJ9MCRnKg7PBFzbQlpUXCIzk1AgqQ45hJg6LwSxk7Frv1XHAG0SYAjI5PuHDfeOMrt8
         LfMzYF3gIamXXwpFnZ6cJWAPEvOxXR/NKPPS1cDiTx+Da0Dj+WHy5lm6PJdsmlzxKSrE
         2kRqrlRnF1vWBikMrQ5TWXFmfULc+kHRalJvPfSnS7YVWDefKFFtg951C/p97/kiliLU
         FoLg==
X-Forwarded-Encrypted: i=1; AJvYcCUC5B5ITAT6bay27IVIrIivOx84LzZx8YHg57fm2VGaRjU462T5YlNEQdaCBSPv8B8WsNQPnxEJIvzuCFIg@vger.kernel.org, AJvYcCVyLQb1ThB+LnhxGLKu9I+Ak6z79DxJCA3sqk1iGDViJxI6sAEdW/+yOZoqyvVVOs2UDcQaZjghBKVvVQ==@vger.kernel.org, AJvYcCWKmAAdp8loo3Tc9zWIv6u9Xlqcq7fi0DfCbCf34sFuH4S+Py69yB8YrJjxiC35UKck+jwYW6lvN7Q=@vger.kernel.org, AJvYcCWjsMzKLp6YQlwS6jwEJTuflWIrqUrmNSfXbD+tjJ3imaN4iLC4slGOq9e0O7aN90cuJ88v8G7m4aV8@vger.kernel.org, AJvYcCX/+GJf6cCfjPwr6rxjadY5O5W0HlyNRiMcmpaQ0+59FCM/ub8XgMjPHijJLhJKsxU6oVe6w8g0qgV5HfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo6SnEeq+gTXdFpTMQXXeEy7LTxlAKYKNY7pHgOVAO9g07iV+
	XSG775yWd5R8SwLk1/Bm2Ev+Oe+yEiuBQvwdHwyIcj+R+gsOtwNM
X-Google-Smtp-Source: AGHT+IEeARVPhOy+ZJtNDQUG53/4F2XBj3wGbkkU+quIvtrYPGMk2XQVoJuGGTyDFU4zckOCztmghA==
X-Received: by 2002:a05:6a00:4612:b0:713:e3f9:b58e with SMTP id d2e1a72fcca58-71b26044023mr7221845b3a.17.1727455019211;
        Fri, 27 Sep 2024 09:36:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:dbce:5230:fa9a:bfd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b7db0sm1791133b3a.49.2024.09.27.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:36:58 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:36:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 4/7] input: max77693: add max77705 haptic support
Message-ID: <ZvbfJxGJdTV965r6@google.com>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
 <20240617-starqltechn_integration_upstream-v5-4-e0033f141d17@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-4-e0033f141d17@gmail.com>

On Thu, Sep 26, 2024 at 01:20:21PM +0300, Dzmitry Sankouski wrote:
> Add support for haptic controller on MAX77705 Multifunction
> device.
> 
> This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
> User can control the haptic device via force feedback framework.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> ---
> Changes in v4:
> - add max77705 haptic support to max77693 driver
> - delete max77705-haptic
> ---
>  drivers/input/misc/Kconfig           |  4 ++--
>  drivers/input/misc/Makefile          |  1 +
>  drivers/input/misc/max77693-haptic.c | 15 ++++++++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6a852c76331b..b4515c4e5cf6 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -241,11 +241,11 @@ config INPUT_MAX77650_ONKEY
>  
>  config INPUT_MAX77693_HAPTIC
>  	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
> -	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
> +	depends on (MFD_MAX77693 || MFD_MAX77705 || MFD_MAX77843) && PWM
>  	select INPUT_FF_MEMLESS
>  	help
>  	  This option enables support for the haptic controller on
> -	  MAXIM MAX77693 and MAX77843 chips.
> +	  MAXIM MAX77693, MAX77705 and MAX77843 chips.
>  
>  	  To compile this driver as module, choose M here: the
>  	  module will be called max77693-haptic.
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 4f7f736831ba..3e3532b27990 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
>  obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
>  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
> +obj-$(CONFIG_INPUT_MAX77705_HAPTIC)	+= max77705-haptic.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
>  obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> index 0e646f1b257b..c3b9d33608d7 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-common.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77705-private.h>
>  #include <linux/mfd/max77843-private.h>
>  
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
>  	{ .compatible = "maxim,max77843-haptic", },
>  	{ /* sentinel */ },
>  };
> @@ -432,5 +445,5 @@ module_platform_driver(max77693_haptic_driver);
>  
>  MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
>  MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
> -MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
> +MODULE_DESCRIPTION("MAXIM 77693/77705/77843 Haptic driver");
>  MODULE_LICENSE("GPL");
> 
> -- 
> 2.39.2
> 

-- 
Dmitry

