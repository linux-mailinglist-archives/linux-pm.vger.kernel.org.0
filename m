Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFF187BB7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgCQJHa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 05:07:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQJH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 05:07:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id f11so7787797wrp.8
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIJbe3VOI+YQZJwZiFXPwevtg4vAxc/0WgUiTwpV41w=;
        b=LryOrPxdPI84+oAPEWcpNcqf4PSI13TViv5l7GLtSZzMHa9ulQbRtpL+A0uV75T0P1
         xAM4KaiBM6C3YTgM1uqt0rKQakX+l8LYa6ltF8zvYb1Pk234lFvbVbO7834aRgwm9dPI
         ngEC44H3jVPEJ8MIYbeZHGmn2i+bnscMzBSNEVYQsunbG1UzeIPxh/YxTRvoQHEjAXu3
         hCvD+Aj1WXeg3ngQ+/GOo86ITnvMFy+22iU+ZeubM3lgxSh/4mBr8SClNTjtaMnL7bZN
         nYuOM1UcSc8MxS2VhIjI+IJUKqImIbGN2KsqxueNeYx7LabL7DEJooLUCpVTf6R8/I4a
         M8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UIJbe3VOI+YQZJwZiFXPwevtg4vAxc/0WgUiTwpV41w=;
        b=PTyUuriUmo6EIHokNpYIZnkX/8rK1N+o0foV0LIWl1zDRb0++1e/kjZ7NbH2dLfv17
         O+nQHzAZz4tuGorMBARAO+2CJKs1Vp9RVHl5pabHuisqh5RZv4k03gE9ZeqI0A+p5FGO
         PkhEreGS+yjZ/lAQFju6hRJfESqbNmL5iXa7LivJrQSGo/rB9H/8ELJ187qXBp61RgG6
         o2XCEJYWtcch6ciS8un4651sM7j3GCcmBeWSghIpvWYMNTCpklRKgZ6y7C5e4f1xKXca
         B8XiPMCNpM1m/4wq+b3WEnHSWlKHSFqo8uthCZgL7KZ4UIoQhsg+HwwgCkKaTzEAT+8O
         Z/4Q==
X-Gm-Message-State: ANhLgQ3trPWiQQiNS3CGBjt3Pi0xWuMsJpUEKb9Qpp5J4g0kvKDkSksO
        maa+dUD+ri8+CRrtsZN2nXx14w==
X-Google-Smtp-Source: ADFU+vugneKcH4CUtkaqKr5aL1BopgRtxDC8V3daLFW3XwNTS1KBL+ijZZMZWF021+0ZeynNcjnfFA==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr4653423wrs.4.1584436046333;
        Tue, 17 Mar 2020 02:07:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:817f:1d16:730:fbfb? ([2a01:e34:ed2f:f020:817f:1d16:730:fbfb])
        by smtp.googlemail.com with ESMTPSA id i6sm3638735wru.40.2020.03.17.02.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 02:07:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
 <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
 <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <831cd71d-04dc-834f-fa28-6091a186dce3@linaro.org>
 <DB3PR0402MB39169041ED7CDA2C4DBD4833F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39168E9B3397BB0E7339802EF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a2b5e9e6-7564-f2c9-67ac-54e0d76f542e@linaro.org>
Date:   Tue, 17 Mar 2020 10:07:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39168E9B3397BB0E7339802EF5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/03/2020 02:14, Anson Huang wrote:
> Hi, Daniel
> 
>> Subject: RE: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
>> handle all cleanups
>>

[ ... ]

>>>>> Is this change compatible with the tristate?
>>>>
>>>> I think so, any concern need me to double confirm?
>>>
>>> TBH, I discovered the function with your patch. My concern is if the
>>> callback is called when unloading the module.
>>
>> I think so as per my memory, see similar patches as below:
>>
>>
>> commit 19ec11a2233d24a7811836fa735203aaccf95a23
>> Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Date:   Thu Jul 11 10:29:35 2019 +0200
>>
>>     gpio: em: remove the gpiochip before removing the irq domain
>>
>>     In commit 8764c4ca5049 ("gpio: em: use the managed version of
>>     gpiochip_add_data()") we implicitly altered the ordering of resource
>>     freeing: since gpiochip_remove() calls gpiochip_irqchip_remove()
>>     internally, we now can potentially use the irq_domain after it was
>>     destroyed in the remove() callback (as devm resources are freed after
>>     remove() has returned).
>>
>>     Use devm_add_action_or_reset() to keep the ordering right and entirely
>>     kill the remove() callback in the driver.
>>
>>
>> commit d9aa5ca429ad30dde96e5966173d18004f16f312
>> Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Date:   Fri Apr 19 10:25:01 2019 +0200
>>
>>     rtc: ds2404: simplify .probe and remove .remove
>>
>>     Use devm_add_action_or_reset to simplify .probe and remove .remove
>>
>>     Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>> drivers/rtc/rtc-ds2404.c
> 
> Any further concern?

No more concerns, I've applied the patches.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

