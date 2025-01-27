Return-Path: <linux-pm+bounces-20957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516EA1D267
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FE3A3E13
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDF1FCCEC;
	Mon, 27 Jan 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e0uwDPoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB48C11
	for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966787; cv=none; b=KNhi3uNDMJxMZHS0M9RVmfC4NxUpJMMfJGCdXr4varJ9pC4RMI84IbY/8K5/Z15G6BF6gufjBjMoyaH3wg+/adfRa6IEucwKyaGYTFbxdJGam4wB5kK5qYUY+UrVj/zCPqAzP2KrZ8EDIKk1MdUqgmakX4jl0P1bf8swQ1EMSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966787; c=relaxed/simple;
	bh=Kg3ShiX3X+9p/kE2BPKyqJFla4aCm2pLOyyJ75gY4Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haFqUHa2IgT/2t3YZN2NHu+gyw5vuazjvxzYc5qKc4meQ5nu3olXijH9Ydc1bsp3XpIgkZ7al6xI0UEiu+8yZJwJWH3Tdc59AI531ALuTKuCXS87gLhVSOcN1oTZdn3ApVx8NkF2Xhat6YWw7kEfQK+i/Ql1xKuqTOQFaWs6SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e0uwDPoj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e3621518so2076544f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737966782; x=1738571582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ji82GDu0qEHZkiYbmz0Eb1XpkbUWFD9sNNEsdWqqg=;
        b=e0uwDPojzRdVbGxQdkqshbkiInloS78/mC1Nf+SBeEphF2iv+W7D+D/L/EOKIUUMHI
         io6Rzqem6/0W9Y9Sq+SQqmkUbjM7fZnbuzwedPEcRAmgx4mc8eLn7SdKCwkyG1VdC3Wg
         Yezf0aGLUQ3KYOX9aCNBqNGwVKoP2ZJ1W9AoSwdAmqrxEP/PGDFdM8EJWyPTxyli1kf4
         Q2TtjqNGe2ecjjTLoo9hSmbToHyIAQfgAnGTkAT/hNcfDeJMpH70MgjWg+8I+k+tzzOj
         BVxWvM0EZ1N5/CClVd9c5Uqhav8zhdkgSZ7sXEsJq/FgmGWEyD7xrXVT1lxTcOjm2LTg
         b9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737966782; x=1738571582;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2Ji82GDu0qEHZkiYbmz0Eb1XpkbUWFD9sNNEsdWqqg=;
        b=RGkL+mtt4nmG1/m3d833+h2QWfAWKp79czmfVx9dmtnLGIk45I2vxaEZAuU1IF2zen
         Ox6nAiLh9bJkwmsHMKS2TlktFy9+HPLiVDnHvUs+6IF9FLekGT4CQF1MJ1aMOUr6z2l9
         M2imYS0+Q2h5ZYDqARoEJGy/q+jwnZ1+Ii+604NhdW0+/B2zHLZiZIRiGlHEkWJetmJx
         YwEEy74b5bArc2JIfZ+RYRZQnRIzc9vdfa7OraULwFmk+FwaR1iIoMR1mWOQAuQx/u6C
         lyy+OtdGHcEdiSto3GNKWBGFKW/V8Glbh2WNdTYK0TfdASgW4zAwl0wMBg/6nQjtSlJU
         eeFA==
X-Forwarded-Encrypted: i=1; AJvYcCVQk9cDbuVqgSxFoM4xkLXBBvQzOfYvGoO0SvX9hSC7/gz++Ol76RZ/iqRQf4LrVusJu3AM9MVURQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtf5qspIniQvtsH8+aSr2G2ms4I7LVCQzX5cGTGKlPyQ60ZO7C
	L5gAywo5+fj53dC14MHUaQHcEPEdVeyC3zy2Y6F7bP5iAoydUwuylmCQau+XFpKQ62Gep6w3gn+
	Q
X-Gm-Gg: ASbGnctraMuGGv1GCr/zRTdAXlykhS8j3dKejiuBDUwGhasY3Z4z9gbwREGvl0PXSk3
	lboxFoyca0TP0wq8T9vOoUUhbLoxRVoorJ0POnYDy9DaFpGjaGzJO196o3HKGx52VimYtJA0Pzf
	3vBJdiRZNU9/nz0cA7JSPoi6XOwdXxr9n3Uv1zAtKK4ofA3rY/q4OKD/tXVgbc1vSl8f5irATc1
	Q6oAkjZXsYRXVTpjtifv2Yw23N4SXJMK2C+Gm6ITRekDErlCssRXLF+SEejspJ8VEo9YYd6KqKo
	t5NyIj085DaG
X-Google-Smtp-Source: AGHT+IHpMIbXH/ROA6dm+Hnrzv+rG9utZdsejuvQ4p2UjcOm0impQgdG4YV+X768DL8GecEbw47bEA==
X-Received: by 2002:a5d:588e:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38bf57bd65bmr42270165f8f.51.1737966782251;
        Mon, 27 Jan 2025 00:33:02 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb062sm10322276f8f.71.2025.01.27.00.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:33:01 -0800 (PST)
Message-ID: <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
Date: Mon, 27 Jan 2025 10:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
To: Jonathan Cameron <jic23@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, ulf.hansson@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
 <20250125121826.6abbe7de@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250125121826.6abbe7de@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25.01.2025 14:18, Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 11:29:19 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Claudiu,
>>
>> CC iio
>>
>> On Fri, Jan 3, 2025 at 5:38 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
>>> the junction temperature. The temperature is reported through a dedicated
>>> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
>>
>> Thanks for your patch!
>>
>>> --- /dev/null
>>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c  
>>
>>> +static int rzg3s_thermal_probe(struct platform_device *pdev)
>>> +{
>>> +       struct rzg3s_thermal_priv *priv;
>>> +       struct device *dev = &pdev->dev;
>>> +       int ret;
>>> +
>>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +       if (!priv)
>>> +               return -ENOMEM;
>>> +
>>> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>>> +       if (IS_ERR(priv->base))
>>> +               return PTR_ERR(priv->base);
>>> +
>>> +       priv->channel = devm_iio_channel_get(dev, "tsu");  
>>
>> Given there's only a single IIO channel, you could pass NULL instead
>> of the name, and drop "io-channel-names" from the DT bindings.
>> I don't know what's the IIO policy w.r.t. unnamed channels, though.
> 
> It's supported, so fine as long as no future additional names show up.
> Will just fallback to index 0 I think.

If everyone agrees, I would keep the name, too, to avoid complications in
case this IP variant will be extended on future SoCs.

Thank you,
Claudiu

> 
> Jonathan
> 
>>
>>> +       if (IS_ERR(priv->channel))
>>> +               return dev_err_probe(dev, PTR_ERR(priv->channel), "Failed to get IIO channel!\n");
>>> +
>>> +       priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
>>> +       if (IS_ERR(priv->rstc))
>>> +               return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset!\n");
>>> +
>>> +       priv->dev = dev;
>>> +       priv->mode = THERMAL_DEVICE_DISABLED;
>>> +       platform_set_drvdata(pdev, priv);
>>> +
>>> +       pm_runtime_set_autosuspend_delay(dev, 300);
>>> +       pm_runtime_use_autosuspend(dev);
>>> +       pm_runtime_enable(dev);
>>> +
>>> +       ret = rzg3s_thermal_read_calib(priv);
>>> +       if (ret) {
>>> +               dev_err_probe(dev, ret, "Failed to read calibration data!\n");
>>> +               goto rpm_disable;
>>> +       }
>>> +
>>> +       priv->tz = thermal_of_zone_register(dev->of_node, 0, priv, &rzg3s_tz_of_ops);
>>> +       if (IS_ERR(priv->tz)) {
>>> +               dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
>>> +               goto rpm_disable;
>>> +       }
>>> +
>>> +       ret = thermal_add_hwmon_sysfs(priv->tz);
>>> +       if (ret) {
>>> +               dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
>>> +               goto tz_unregister;
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +tz_unregister:
>>> +       thermal_of_zone_unregister(priv->tz);
>>> +rpm_disable:
>>> +       pm_runtime_disable(dev);
>>> +       pm_runtime_dont_use_autosuspend(dev);
>>> +       return ret;
>>> +}  
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                 -- Linus Torvalds
>>
> 


