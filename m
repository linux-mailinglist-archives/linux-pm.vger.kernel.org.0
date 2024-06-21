Return-Path: <linux-pm+bounces-9732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578C911B56
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B659283B1F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F3155CAC;
	Fri, 21 Jun 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dz96bK2r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73912EBE7
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950595; cv=none; b=UPvn5LmVt6vYVrxLrRi6gZsJwlY/0JZqk2rqvF72TF8/EKjNc4LkazhgzYudNyoBEdtFmbTawzn6keHq4JSdQ2lCp2MgAb8dvXdEhBXAu2BAcDv1Z1LyxxFLTtWv9VhqTYQOBv+bna2pglDWOLInrlTeUrGN3y+WesaQOMtS/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950595; c=relaxed/simple;
	bh=Cq/UPH00Rc+EV+zEnuZTT1juz30n/517vwf08ycuRi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHF++7mwgTnIsYTUCkRuqohHJeJ+V9dTW01OqpT0T6qoRwnKRdcb8fgmwPQaUERHehcz03ziTxd+tYUPKLAAtc59f4AgaDzN+kgI3FWA7ZzmeXmSN1yS01agXU0iZD7iYu539sNEh+zOE1QVdznTIeODd2QXjfQHvVos+RAN7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dz96bK2r; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f85f82ffeso191735866b.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718950591; x=1719555391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnZ7fy5EjAsmRc3C7nshYtXKIZAoTD46hBI3kMrPlkE=;
        b=dz96bK2rLAZdlD18eTvZV2GoXFoPMFHIt0Hop6K0BG18qDiB3NqN+Ebix2iPrmejrQ
         f7JXI4cBEhyGeVNp+VmVl9ffMWiVdFP5ra08dRo81Sr/2+aO5ChMROpxuo1TypJXIh4e
         qoGVSyHwMfXB6atZQwpyVPn6VhMh0ZIy8R0tzryNmgCh7qA2+N0rzZ3tpREajs1mdnqk
         fbiJa+scDeecteqznz9xQdr22HQbeb40dh/3lCXMnv22qfFTvebOsr7tlAN9/jbk2S01
         WqMK+zmgOAS55PXrEdR35vxkbni1Xa+5HnPMghfM3Uov95OeeKrMkaBkwWK3/3G0TQQy
         gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950591; x=1719555391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnZ7fy5EjAsmRc3C7nshYtXKIZAoTD46hBI3kMrPlkE=;
        b=EQkr9XXMHFwsVGhqKMJ4RIkEAvBpxARPMze7kPebUBPvt1Q73hd26U0fMgi4XOm2cn
         CYQm4zGmJpddb6ZctXQYU62cCoeYznyns3SiskawHsZYqmQp0w8Qsa44um/+iFLAYP5a
         MndeUc6AD4dabL9UT7dJCRtlUnfTd49tg2PMEOjsycDkmSIrdFHH+NcYUcUKjngKbxJY
         EW+Bf+UGMkAmyJo3jXGegPVw+VkFxoiYEcJCuffinn36R/vYyxFE4PRpxu667gayDVQy
         JwXj4Uy8EcrFy4aE7wq4gP0uLsfoP4VolxZxxXTSthrzGeV7WkPM7N+j4hRNXVmfsj6r
         ZN9w==
X-Forwarded-Encrypted: i=1; AJvYcCVuU0D77gmhWHS7e6VybCVNw/jAOgSX+8ZFpxVQProbyXaBVIVwS+TvkWG4DZm9ITlBlj09bCCwgFDUkE4OYcVpTS7+v84anKI=
X-Gm-Message-State: AOJu0YzUEnUN+ammwtm25B+U0b4tHcsg5Ji5HSCdcKlUgo2deFmj5+i1
	A396cb8Zpn2WGj0wjt+ePxMQlqxY8J3TBLA1/HVzI9V2M5JvZGq3MjnlNE6Uz+U=
X-Google-Smtp-Source: AGHT+IFTFPJK35HIe1HrAGcCFLN/Hy20XkeKNFw3qyFwpGwn1f2DcRTFwd102/VZFLJOiyCPaJs9Mw==
X-Received: by 2002:a17:906:f289:b0:a6f:1839:ed40 with SMTP id a640c23a62f3a-a6fab7d6bb1mr383374766b.73.1718950590331;
        Thu, 20 Jun 2024 23:16:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48a220sm46097066b.60.2024.06.20.23.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:16:29 -0700 (PDT)
Message-ID: <ea1d16bc-832f-4401-baa6-d4dd10f53612@tuxon.dev>
Date: Fri, 21 Jun 2024 09:16:28 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] watchdog: rzg2l_wdt: Keep the clocks prepared
Content-Language: en-US
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: ulf.hansson@linaro.org, wim@linux-watchdog.org, linux@roeck-us.net,
 rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, geert+renesas@glider.be,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
 <20240619120920.2703605-3-claudiu.beznea.uj@bp.renesas.com>
 <CA+V-a8v7hxhhiT4X28kKJ5yTuMahCuCUWX_nFKd4cWL9GAWxug@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CA+V-a8v7hxhhiT4X28kKJ5yTuMahCuCUWX_nFKd4cWL9GAWxug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Prabhakar,

On 20.06.2024 18:31, Lad, Prabhakar wrote:
> Hi Claudiu,
> 
> Thank you for the patch.
> 
> On Thu, Jun 20, 2024 at 9:29 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The watchdog restart handler is called with interrupts disabled. In
>> rzg2l_wdt_restart() we call clk_prepare_enable() to enable the watchdog
>> clocks. The prepare part of clk_prepare_enable() may sleep. Sleep in
>> atomic context should not happen. The clock drivers for all the
>> micro-architectures where the RZ/G2L watchdog driver is used are not
>> implementing struct clk_ops::prepare(). Even so, to be sure we are
>> not hitted by this at some point, keep the watchdog clocks prepared
>> and only enable them in restart handler. It is guaranteed that
>> clk_enable() can be called in atomic context.
>>
>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Closes: https://lore.kernel.org/all/CAPDyKFq1+cL1M9qGY0P58ETHUZHGymxQL0w92emUJPMe7a_GxA@mail.gmail.com
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/watchdog/rzg2l_wdt.c | 31 ++++++++++++++++++++++++++-----
>>  1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>> index 2a35f890a288..6e3d7512f38c 100644
>> --- a/drivers/watchdog/rzg2l_wdt.c
>> +++ b/drivers/watchdog/rzg2l_wdt.c
>> @@ -166,8 +166,8 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>>         struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>>         int ret;
>>
>> -       clk_prepare_enable(priv->pclk);
>> -       clk_prepare_enable(priv->osc_clk);
>> +       clk_enable(priv->pclk);
>> +       clk_enable(priv->osc_clk);
>>
> I think we need to add a check before enabling the clocks:
> 
> if (!watchdog_active(wdev)) {

Agree, this should be better.

>          clk_enable(priv->pclk);
>          clk_enable(priv->osc_clk);
> }
> 
>>         if (priv->devtype == WDT_RZG2L) {
>>                 ret = reset_control_deassert(priv->rstc);
>> @@ -226,11 +226,28 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
>>         .restart = rzg2l_wdt_restart,
>>  };
>>
>> +static int rzg2l_clks_prepare(struct rzg2l_wdt_priv *priv)
>> +{
>> +       int ret;
>> +
>> +       ret = clk_prepare(priv->pclk);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_prepare(priv->osc_clk);
>> +       if (ret)
>> +               clk_unprepare(priv->pclk);
>> +
>> +       return ret;
>> +}
>> +
>>  static void rzg2l_wdt_pm_disable(void *data)
>>  {
>> -       struct watchdog_device *wdev = data;
>> +       struct rzg2l_wdt_priv *priv = data;
>>
>> -       pm_runtime_disable(wdev->parent);
>> +       pm_runtime_disable(priv->wdev.parent);
>> +       clk_unprepare(priv->osc_clk);
>> +       clk_unprepare(priv->pclk);
>>  }
>>
> All the above chunk can go away if we use devm_clk_get_prepared()
> while requesting the clocks in the probe.

Indeed, I missed devm_clk_get_prepared().

Thank you for your review,
Claudiu Beznea

> 
> Cheers,
> Prabhakar
> 
>>  static int rzg2l_wdt_probe(struct platform_device *pdev)
>> @@ -275,6 +292,10 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>>
>>         priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>>
>> +       ret = rzg2l_clks_prepare(priv);
>> +       if (ret)
>> +               return ret;
>> +
>>         pm_runtime_enable(&pdev->dev);
>>
>>         priv->wdev.info = &rzg2l_wdt_ident;
>> @@ -287,7 +308,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>>
>>         watchdog_set_drvdata(&priv->wdev, priv);
>>         dev_set_drvdata(dev, priv);
>> -       ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
>> +       ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv);
>>         if (ret)
>>                 return ret;
>>
>> --
>> 2.39.2
>>
>>

