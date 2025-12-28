Return-Path: <linux-pm+bounces-39998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AACE5644
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 20:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52E430056C1
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2353259C80;
	Sun, 28 Dec 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMWvp45C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226C21B9C5
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766949291; cv=none; b=In6aK5SwASt+0tu5nGbUScDP8KUA3chOxXaonVSMnetYzzhoePNCOF6qFkP2nLDlAtyGeSodXwANzJ+gnKXQu+4Tw9oY3ClMKhHanGcY9BqsvjaH2pi3Jt5MIXNZ9/i74Qv49atwo/AKyxBur0evD55/NZ4J/WdFZC94Zh2zwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766949291; c=relaxed/simple;
	bh=Teue05T2vtyfM6JbLM9Wx4ESn3eOITo3NXRewvGunxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNfvpgBETQOdmICoMvQvlQwVeuRuoAWw8mCgEyF4F9Xthby422X+VTy50Mvqyc9L/aVRZTNxSjDjCSIJPDg0vOpUsLIBOXSXe4JacE4FI7Gj2Qa4sg4ksLrXwPHahng9uZHYekbqP2DKjUstQpszVZeEG1BTljp3HkAV/64i3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMWvp45C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so9534305b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766949288; x=1767554088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/EDnVTKqc9Alw2a85WyLludgkhnt57ScPSQHXR/F+0=;
        b=gMWvp45C/g8JDsZwyJhN/5klNPtlBizoLI/gwPBaG3HekiJSXaXsscTbOcn+sYy8F8
         SktZZg3QA8AqxbKhWtIZruC5MfPRocHD0wYU0XPNwT1Gw7V7L7Tg3yybk2/gviiFz8mR
         Mkzt5yBVVwuykLX4wMJOcNFogwciE1PL4Wsqo5AjBpJN/pMStUPYmEUeYezzDroteu9Z
         de975pU+0suLKkt/z+JJJahk1OmeDiV7sFDOfcvHGLtINH4w+pWqbPAQ15bGG9QCiqmV
         9vQ8y8mptvamg2HdF/ZrLOmPkna/Pk2TJ3AeSn7SaEvtUBeIdgh1Wzhn9S6hi3XVXygL
         jrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766949288; x=1767554088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/EDnVTKqc9Alw2a85WyLludgkhnt57ScPSQHXR/F+0=;
        b=N/PGsMsqfqQ+OenNJ0c9dD2MgymRL+I+yYXeAkgYLEIMDFvVY0txHIh+VWHK7vVcHP
         +oXOcnT1HOUpTZeYSevTRPWwTl+PKLFvtGV0246FyKltij8TkqoRztEO+ul6Fc1k4oe2
         SO96K/PoW2GEQNhvH0EaNdKI/M2teivgaetBCulZSEaws4yrijj7N+dQDLE3bsVbHU7F
         rHhiVU/aQl51a78UoePI0kkMHnnUXhrcY+bHAURLSY/CfL4xqgqKyhu7te0VZysTQZsz
         KpioM/saldW2o7atYVVpPE01F2BscJ8x2D3IZ60kIYu73Kc+ryVW0DQmfGNuWGVJ3E2/
         fyeg==
X-Gm-Message-State: AOJu0YyoSYA4nve1K3FeyQrM1bCNEGjzdT8GoIbhq3EEYvs/6EU434B4
	UCDbtjacHyySUdnkMrIPVbdlkxOJ+XZEcSEr63seo6PM5rET6bvNvEIfRgqlmQ==
X-Gm-Gg: AY/fxX71cHJ2lccuMtUyRUBdZK36Is4e2qiFoMPTJci7c8M4ivaY5E6Izbw5/Xlu36o
	gmZlntR1ahJuGx4adOyhfRDMFGd+KuEoAOxBp0Ltus97l1VUZ+UceTbuvYmCYgEjpknWBEsQm/8
	kdOzMfTy3orYXXVsXGn6QySTWtPXllPTfKUXhgLvjxxMshmaYkDn17F4zpzDigBXlP1AdLd1cdY
	/GyZ3KN9kXMi+GTsAdtSfTPsCdIcs5C7p2iDFf7KNpkJ/x6QE8CaDEqH85zdrpiPOdoqKGyVIR4
	2NnEVFDtPaCG169z5KsIQbB6TZcSzbFUp3SYOIeJtdIybYY4L8pcYywh7gdcTmRuuJVCdoPrXsq
	jPxPguUP7Qor189Aw+8Iw1vzli1ZyGe5TmlkwhZwIudF2j9oXFH5XWEr4glZ+ZM6+wqeZyhrRCE
	D0L1Oif3p5tIhsk5b/OpO4CQ1W
X-Google-Smtp-Source: AGHT+IF25KeLOl7jzXHpJk6dyM7oMA5PYF/NEBQktiKPuJGfWtsQgLBOA+8b4PoMCuZ7U2cZUKzoug==
X-Received: by 2002:a05:7022:e98d:b0:11e:3e9:3e8b with SMTP id a92af1059eb24-12172312a4fmr27428339c88.50.1766949287821;
        Sun, 28 Dec 2025 11:14:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm109599250c88.5.2025.12.28.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 11:14:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Dec 2025 11:14:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 08/23] watchdog: rz: Discard pm_runtime_put() return
 values
Message-ID: <4a2fc1a6-343c-4fc3-ab5e-7c134216aa22@roeck-us.net>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <3340071.5fSG56mABF@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3340071.5fSG56mABF@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 09:07:46PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Failing a watchdog stop due to pm_runtime_put() returning a negative
> value is not particularly useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel is
> configured with CONFIG_PM unset.
> 
> Accordingly, update rzg2l_wdt_stop() and rzv2h_wdt_stop() to simply
> discard the return value of pm_runtime_put().
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
> 
> ---
>  drivers/watchdog/rzg2l_wdt.c |    4 +---
>  drivers/watchdog/rzv2h_wdt.c |    4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -132,9 +132,7 @@ static int rzg2l_wdt_stop(struct watchdo
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_put(wdev->parent);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_put(wdev->parent);
>  
>  	return 0;
>  }
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
> @@ -174,9 +174,7 @@ static int rzv2h_wdt_stop(struct watchdo
>  	if (priv->of_data->wdtdcr)
>  		rzt2h_wdt_wdtdcr_count_stop(priv);
>  
> -	ret = pm_runtime_put(wdev->parent);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_put(wdev->parent);
>  
>  	return 0;
>  }
> 
> 
> 

