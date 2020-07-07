Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6856121680E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGGINu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGGINu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 04:13:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7506C08C5DF
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 01:13:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so42307753wmg.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=05xI6wJb+pvE4wHQ2qdDsXdX+BPzXeWRcihwoqOjd6U=;
        b=n+PP/J3kqkRrr/c7+eNimD9rRpfjE7IfpEMRiSGV9YCwHelXn8b/BUiPC0odXPJ9Lj
         Pk35HpivQKzprFoKVnlhMtQZ/GDkd8aQ2PStjrZ1X0Y8ZoWPLy1kVYKyoaIKMsrgAs0e
         uH9Wk/Q2I7r1qYRQIr9/RC2bKU8JqDbJkxJ2bapjEp6s7RwmUNBw7c8dF7rJ/uk8BADc
         lSOeTTNRTPrPMqchjvdNy3sQEIcRUaYxvGEhvnAGm4aoCl/Nus1MGTw7140hSpOVEoOb
         5Ilm9oHGJ/KAT0yE73lpzAOE0wbO2KlVK9VVnMbdb4ankQFT+e/b/nRaxEwbXYwN6Qrt
         GjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05xI6wJb+pvE4wHQ2qdDsXdX+BPzXeWRcihwoqOjd6U=;
        b=hWKXxCyOBkYzPRzLyfJttoG6Ej7BiXqfGjtLNpQgvu+sH6YC1UI0PY/YHGuoXCJ8JM
         Aw0hjeqVRe09i1l4C1v4C3Lur6Wy9esa/a40k9e/yjTPRrTaG/BIUacbeOckVEFvtuR1
         u26fEBBMftoT6ZvcDdKHDtUvrX6snasl70B9RYOxyBGU0OPJcl4TQAqsQkkezpofkCLY
         HLvp9nKBLcuBlPfiDvIDzGI4QLRAp8daPYdf0pKrG4HB88Ds969JwJjDntEmf+Z8hT6c
         owPZkzxsStswlpnfLrGRQq5vfggqrbtuY01WeyfD575oaEVkJc1P7Y+IMQYbiRn+kDQe
         k6JQ==
X-Gm-Message-State: AOAM531c3AzHLqA2xOw2pRaBAxin3xbzRxc0uoHddu3S1QexPAL0ba/k
        4nYwnDJLRgtq6eQfX+MG7RXnLQ==
X-Google-Smtp-Source: ABdhPJymOd3pRu1aeygaJdWogJ2lVl28ew4bcNoyZooPVWuB6BUsMYd/al2WZYRoxJG2w6KApZ9B9g==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr2747323wmh.166.1594109627674;
        Tue, 07 Jul 2020 01:13:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b4ff:29eb:619e:318? ([2a01:e34:ed2f:f020:b4ff:29eb:619e:318])
        by smtp.googlemail.com with ESMTPSA id g3sm18887963wrb.59.2020.07.07.01.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:13:47 -0700 (PDT)
Subject: Re: [v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-8-michael.kao@mediatek.com>
 <1afbf412-fbeb-8abe-66d8-bd7ac4e9dd83@linaro.org>
 <1591329023.12739.0.camel@mtksdccf07>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4c9e9abf-1f87-ae68-3827-22df52adfd19@linaro.org>
Date:   Tue, 7 Jul 2020 10:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591329023.12739.0.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/06/2020 05:50, Michael Kao wrote:
> On Fri, 2020-05-22 at 17:36 +0200, Daniel Lezcano wrote:
>> On 23/03/2020 13:15, Michael Kao wrote:
>>> From: "michael.kao" <michael.kao@mediatek.com>
>>>
>>> The driver of thermal and svs will use the
>>> same register for the project which should select
>>> bank before reading sensor value.
>>
>> Here there is a design problem AFAICT. The sensor should not be using
>> external locks.
>>
> The PTPCORESEL is a common register used by svs and thermal.
> The thermal need to ensure PTPCORESEL register will not be changed by
> svs when thermal switch bank to read raw data of temperature.
> So we use svs_lock to make sure there is no conflict between the two
> drivers.

Why not use regmap ?

>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>>> ---
>>>  drivers/thermal/mtk_thermal.c | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>>> index 9eaca432920e..594ad4f0f8cd 100644
>>> --- a/drivers/thermal/mtk_thermal.c
>>> +++ b/drivers/thermal/mtk_thermal.c
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/thermal.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/types.h>
>>> +#include <linux/power/mtk_svs.h>
>>>  
>>>  /* AUXADC Registers */
>>>  #define AUXADC_CON1_SET_V	0x008
>>> @@ -262,7 +263,7 @@ struct mtk_thermal {
>>>  	struct clk *clk_peri_therm;
>>>  	struct clk *clk_auxadc;
>>>  	/* lock: for getting and putting banks */
>>> -	struct mutex lock;
>>> +	unsigned long flags;
>>>  
>>>  	/* Calibration values */
>>>  	s32 adc_ge;
>>> @@ -561,7 +562,7 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
>>>  	u32 val;
>>>  
>>>  	if (mt->conf->need_switch_bank) {
>>> -		mutex_lock(&mt->lock);
>>> +		mt->flags = claim_mtk_svs_lock();
>>>  
>>>  		val = readl(mt->thermal_base + PTPCORESEL);
>>>  		val &= ~0xf;
>>> @@ -581,7 +582,7 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>>>  	struct mtk_thermal *mt = bank->mt;
>>>  
>>>  	if (mt->conf->need_switch_bank)
>>> -		mutex_unlock(&mt->lock);
>>> +		release_mtk_svs_lock(mt->flags);
>>>  }
>>>  
>>>  /**
>>> @@ -938,8 +939,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	mutex_init(&mt->lock);
>>> -
>>>  	mt->dev = &pdev->dev;
>>>  
>>>  	auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
>>>
>>
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
