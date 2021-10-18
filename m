Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C45432370
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhJRQGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJRQF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 12:05:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2AC06161C
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 09:03:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so42489418wrg.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U+OIiOCMy27mbGAVIQWKPL+EskS0hM/mO2G0dhzOV/w=;
        b=jvI5XDF/reW/lpq7AGNTSHhH/RptkMOZEnZr0m2g7jEJB8NC/GMARXVIORxhGwt1Mw
         +o0kFqxpPGJ6aS5C8AAq4g03pNPwx9Mw7IyGBjuwyG4RoLlPfxTygaPaTqEC39VraXYa
         M36mwhnX5wGM+lFGhylCkNeZY+2CCj3D6P8teKBcjRGsVU0mTU3J4y/ZpJ24FJHFo8dh
         XekrGaczuX1zRfdUFw+6xqz8FPi7d4pb2dpy6kCWQLDFQ7Pri0itsDw6zcjn/pCADJ26
         A8UmzJ/2cb2s4gZXMgAYWS25NAPkfaHhaQ2Ilcr4L+b58QdXl3n/C+z31kwYfjJzR5o9
         kSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+OIiOCMy27mbGAVIQWKPL+EskS0hM/mO2G0dhzOV/w=;
        b=rqqPjJQVRwCP4Skbz8NzvkAGjyWv869K5mqGvv8mzW+/TomeFa53BbqIGJso+i0LcP
         UCApYZATgzYqB/5Abw2zFp9zEi+LR/wVNWqjnvVuBMDTrlm4/t3dKkNA4eqnuSOBMZNT
         P+YQbod5XQ/xNcyMJB0GEsRYsh3EybEvk8A3eqvuQtuwycyXUVL+s+y8vFbTKszYSUP/
         9akTg5fvb4HdLPcO6xF9mMkR6fYiFbGc7hgyvlq8OXh/fSt7FhO2qkL+RdkA7w7cOdGu
         Vwa2S7fvSbPqEOtgVz0D2S16TSWHP8qV5XpBEqoSL71vz0vtsOup704INPGPT9na9idJ
         +93w==
X-Gm-Message-State: AOAM530xm6ve1RnFBVWC5yQ/0eCZ05eKZ/5MxDDKPZgyVzDuF2/CnOYQ
        1HvuCMCRFWWLtbra4AHEpYNF2Q==
X-Google-Smtp-Source: ABdhPJyQuCKOS0zcwDTms53/DFCPp1vNgudJJWPlT53tuVhpwDzWhLqnggucx92t2Vco/MSTf8WIXA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr36332036wrn.283.1634573026584;
        Mon, 18 Oct 2021 09:03:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id d3sm14437830wrb.36.2021.10.18.09.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 09:03:46 -0700 (PDT)
Subject: Re: [PATCH 3/3] thermal: mediatek: add MT8365 thermal driver support
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com
References: <20211014135636.3644166-1-msp@baylibre.com>
 <20211014135636.3644166-4-msp@baylibre.com>
 <33815817-0f64-836a-5417-c614e66e231e@linaro.org>
 <20211018154001.sj7nc575hln3jkel@blmsp>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1844fd1b-d3ff-55c1-a98e-54219c3838df@linaro.org>
Date:   Mon, 18 Oct 2021 18:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018154001.sj7nc575hln3jkel@blmsp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Markus,

On 18/10/2021 17:40, Markus Schneider-Pargmann wrote:

[ ... ]

>>
>>>  	}, {
>>>  	},
>>>  };
>>>  MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>>>  
>>> -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
>>> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
>>> +				       void __iomem *apmixed_base)
>>>  {
>>>  	int tmp;
>>>  
>>> -	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
>>> -	tmp &= ~(0x37);
>>> -	tmp |= 0x1;
>>> -	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
>>> +	if (!mt->conf->apmixed_buffer_ctl_reg)
>>> +		return;
>>> +
>>> +	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>>> +	tmp &= mt->conf->apmixed_buffer_ctl_mask;
>>> +	tmp |= mt->conf->apmixed_buffer_ctl_set;
>>
>> What is the goal of these two bits operations ?
> 
> mt7622 needs to unset a few bits and set one bit in this register.
> mt8365 only unsets bits. For this purpose I created a _mask field to
> unset bits and a _set field to set bits.
> 
> Would you suggest a different way?

No, I understand what you wanted to do. I was just unsure if there was a
trick because of the tmp |= 0;




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
