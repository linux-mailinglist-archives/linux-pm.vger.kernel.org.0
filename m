Return-Path: <linux-pm+bounces-12963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08921960A85
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E0F282B67
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44E1C4603;
	Tue, 27 Aug 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IcQnMc08"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F871C3F3A
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761977; cv=none; b=h6cePIBdBDQUbQ3BQdKFGNY/5HAE2HjONHLkIhxRUp4qDShPMtAqWlZggAkujx0qmNry5b826D94BnPjViQRZ3SLqFOzmpisTI0kF1+Diu8PhtXXNFhMyvc1QpRq3h9apwOt/Kh8ciqrrOPdPQQ6HTD9aaSuEFtD98HlxR+U514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761977; c=relaxed/simple;
	bh=LiQo0dIQMk7M3bHa0opvBkYq4ByVUwoYrG6oVZ/Bk8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMvYqc3XmmLF3F5hGJPrWtp0M+ptxVZqWkZrLZVfElyCgJipoF4sD2gAkmLXm1d+yoq2fS9y8YLQgAANawyNNqKgSgkhFZTus+puajppJfqey5uxU1u2MWN3mac9fiw8o590dzlb7+oT9Retan3Pk7eBokp6ZmK1I/Vo5cQomfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IcQnMc08; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1565676a12.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724761973; x=1725366773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+8zmpgoxrDLbCqZtH6gEBqxTqDF5Ns65h0U7300PsM=;
        b=IcQnMc08NA3XNXX2i1hA2fZN/ycQMaXttC83gkKvAH8jl7+IntgUnWXapNyr0eXSVK
         8WYE9bOxTtKcNmevPz5VZ/BCkyrKD1KFVsqoCHUZvyvJx2lb47D3mmPIJUi6EKafLlTJ
         N+aY97sZk9eBvfHpkLLxMUuSxGraBtIB+mV20stiXY2Jj7iMrl0vV/v7njcgEWz6qTkO
         sSPoC6Emds7gMuyKkoPUb74oEAx8GfIId48v+ophxkSvZIp5HO+E8heOhC7YV738JC/m
         VVOxyX39DudwvkoGJMO/ACdUnhYBDdXR8cD1Wd297T4VI6gg81ONmQ55onyFeud0C9/d
         XJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761973; x=1725366773;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+8zmpgoxrDLbCqZtH6gEBqxTqDF5Ns65h0U7300PsM=;
        b=kI4tmN/gCDsVrZMYgKWn3Lwmb3WPluLEWOtLr6rNntzOzv0Ch6pPt8vfP4pB0VxC7d
         oQxUV/8xZsvCbbwtaMFMoXSEriWiN6U8UU4igtVEY/PRW/pKUCcjMmN+usbOfa0OFHQA
         wXpqbwmOzdPAnb53YZl5CA0KO9oo+JlBFlU9MJZ7lnpbsuyqJNSQKjinZzKdDatt6Y4u
         foX+XNcyb0Av7Y7KsRAmXUNWFhXZuRXYv2ff1g24ziGtI9MCai39q2Td1ESFdQC163iS
         ecKGd2HtBq33wiY7wh0WEDosP5IhvnB+QwbDo1dhTX7GuuHztvE//l9BOTy1L+rOi+Gi
         cfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM5j3l5XSPI10OJNAvyFwC7298jvuMJ/nTTRww802VYeFXLjrGcwvbYTfrngzn00wNOOo3Gn35OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/1VZ0EPn/3h7N0pcU6+FtrxiFIgb6WvBdHSaA2r9xmLg5n9c
	J1MDcOdAUxb5f9SCILhflSPeyY16o9+S1YcRCwH9SjF+Ye2C6RbxB8h061UsW48=
X-Google-Smtp-Source: AGHT+IF0YQF/+Km2Nk6dAVkx3nFNSFyP0k8EfYjfWpB5kX5bCXbFaKsLnQfAOxMeQ48X0I85aPkxKg==
X-Received: by 2002:a05:6402:2683:b0:5c0:c6a7:1c58 with SMTP id 4fb4d7f45d1cf-5c0c6a71cafmr729455a12.15.1724761972930;
        Tue, 27 Aug 2024 05:32:52 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb481fb8sm961543a12.87.2024.08.27.05.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:32:52 -0700 (PDT)
Message-ID: <4823173e-b024-482f-83a3-560c7abd888c@tuxon.dev>
Date: Tue, 27 Aug 2024 15:32:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
 <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346A223DA7462799B9D103786942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY3PR01MB11346A223DA7462799B9D103786942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 27.08.2024 15:15, Biju Das wrote:
> Hi Claudiu,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Monday, August 26, 2024 4:25 PM
>> Subject: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In this case, the watchdog
>> device need to be powered on in struct watchdog_ops::restart API. This can be done though
>> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog device are marked as IRQ safe.
>> We mark the watchdog PM domain as IRQ safe with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is
>> registered and the watchdog device though pm_runtime_irq_safe().
>>
>> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") pm_runtime_get_sync() was used in watchdog restart handler (which is similar to
>> pm_runtime_resume_and_get() except the later one handles the runtime resume errors).
>>
>> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") dropped the pm_runtime_get_sync() and replaced it with
>> clk_prepare_enable() to avoid invalid wait context due to genpd_lock() in genpd_runtime_resume() being
>> called from atomic context. But
>> clk_prepare_enable() doesn't fit for this either (as reported by Ulf Hansson) as clk_prepare() can
>> also sleep (it just not throw invalid wait context warning as it is not written for this).
>>
>> Because the watchdog device is marked now as IRQ safe (though this patch) the
>> irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
>> 1 for devices not registering an IRQ safe PM domain for watchdog (as the watchdog device is IRQ safe,
>> PM domain is not and watchdog PM domain is always-on), this being the case of RZ/G2 devices that uses
> 
> RZ/G2L alike devices or be specific RZ/{G2L,G2LC,G2UL,V2L} as it is not applicable for
> RZ/G2{H,M,N,E}devices.

OK, but I said "RZ/G2 devices that uses this driver". Here are included
RZ/{G2L,G2LC,G2UL,V2L} AFAICT.

> 
> 
>> this driver, we can now drop also the clk_prepare_enable() calls in restart handler and rely on
>> pm_runtime_resume_and_get().
>>
>> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in watchdog restart handler.
> 
> Can this patch be fix for Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") on RZ/{G2L,G2LC,G2UL,V2L} SoC??

Not sure... I thought about it, too. I chose to have it like this thinking
that:

1/ that may not apply cleanly as it depends on other cleanups done on this
   driver, e.g. commit d8997ed79ed7 ("watchdog: rzg2l_wdt: Rely on the
   reset driver for doing proper reset") so it may be worthless for
   backport machinery
2/ There is actually no seen bug reported by lockdep (as the clk_prepare()
   doesn't handle it)

Don't know, I can reply here and add it. Applying this patch with b4 will
take care of it. But not sure about it.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/watchdog/rzg2l_wdt.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c index
>> 2a35f890a288..e9e0408c96f7 100644
>> --- a/drivers/watchdog/rzg2l_wdt.c
>> +++ b/drivers/watchdog/rzg2l_wdt.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/reset.h>
>>  #include <linux/units.h>
>> @@ -166,8 +167,23 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>  	int ret;
>>
>> -	clk_prepare_enable(priv->pclk);
>> -	clk_prepare_enable(priv->osc_clk);
>> +	/*
>> +	 * In case of RZ/G3S the watchdog device may be part of an IRQ safe power
>> +	 * domain that is currently powered off. In this case we need to power
>> +	 * it on before accessing registers. Along with this the clocks will be
>> +	 * enabled. We don't undo the pm_runtime_resume_and_get() as the device
>> +	 * need to be on for the reboot to happen.
>> +	 *
>> +	 * For the rest of RZ/G2 devices (and for RZ/G3S with old device trees
>> +	 * where PM domains are registered like on RZ/G2 devices) it is safe
>> +	 * to call pm_runtime_resume_and_get() as the
>> +	 * irq_safe_dev_in_sleep_domain() call in genpd_runtime_resume()
>> +	 * returns non zero value and the genpd_lock() is avoided, thus, there
>> +	 * will be no invalid wait context reported by lockdep.
>> +	 */
>> +	ret = pm_runtime_resume_and_get(wdev->parent);
>> +	if (ret)
>> +		return ret;
>>
>>  	if (priv->devtype == WDT_RZG2L) {
>>  		ret = reset_control_deassert(priv->rstc);
>> @@ -275,6 +291,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>>
>>  	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>>
>> +	pm_runtime_irq_safe(&pdev->dev);
>>  	pm_runtime_enable(&pdev->dev);
>>
>>  	priv->wdev.info = &rzg2l_wdt_ident;
>> --
>> 2.39.2
>>
> 

