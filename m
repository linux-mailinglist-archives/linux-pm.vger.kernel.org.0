Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAC3686F0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhDVTJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVTJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 15:09:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A7C061756
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 12:09:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so42153544wrt.5
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2cU5mPNKDtlteNBbk3anMbRMaIXJe5GUHs1/Fqkj1KQ=;
        b=VJ96Aa08ttSQWQvuzjTA9BlAW0s7jMiF7k6HgXg9hU3VLafoR3wMcWr7+xDBVsB87A
         uMX+TSFmyrGofHKGh3V08TbN19vwK5PQ3xJsCSr7k+LeNRMR2NdAuPnQ9UCD+z5Hc9vR
         5L6KJaqBswI+jtkHKtfMZ6N/OqxrvpK2USK9igGWAxJ5wFYpDc8rzF0fzm88FCK6U+Zy
         srbVT2gRDuUb+CF2ogVkCQ16ntBoqqCZsrLmb6kwatTHRRvDd3EER8Zd+3yfJusRPKfW
         ckwJFH3EHrSqUXD7uAr2OCs4dz8jkgOIFOiWItCOKAEqXG+UzBRjNujxYhV5+SS9+ilp
         Zeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2cU5mPNKDtlteNBbk3anMbRMaIXJe5GUHs1/Fqkj1KQ=;
        b=FCUtyInWLubBl6Z1zLdBIAo7kM4fwzikisdeABBagll2BiieExf+fHGgthdoYEf74N
         +ToLk5bwOEItWHbzqOX1whLTWCG+bvJ0qSABJ/oJS+7hLIfUFTI+F1qCuK9S8A6gnsTv
         5ZtuHqXaJPPowl+8izOp8ylRVkAUThwikrdopVsI+0oWVCEikYT2cWon+5yJdiI3/7pJ
         BePgihvrQeh4bTp68UXLWgs/X/II8gzC3lkYo1L9erPgsf0liOGXmzdCpFn1VZxt9VIG
         DL/ofDj177HcNzJVDMlStoRPkKNwoA076zpTtra/yqzy+CrVl61I19uWzwyxwF/vXyx3
         tchg==
X-Gm-Message-State: AOAM532qgSzkjmaL+R5h+BnildFBzUdSkIwueAZsxyt1bzX0t7DNX8FD
        jKxWchlNT1e+xR7XyaqNN4+HGw==
X-Google-Smtp-Source: ABdhPJx4jRPrEEhqBCLz27LfBVbenxY1/FQ/KIusG0Xm1b6Y8CKEdtdLDoS68KlAng9fcQ0HNMLB7A==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr5959048wrn.20.1619118547875;
        Thu, 22 Apr 2021 12:09:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9? ([2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9])
        by smtp.googlemail.com with ESMTPSA id i15sm5265426wrr.73.2021.04.22.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 12:09:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568 SoC
 compatible
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20210421200445.32977-1-ezequiel@collabora.com>
 <bf0771cec69e11bf4622421a3aa8f2092da42429.camel@collabora.com>
 <31c2e531-96d0-a1c1-644c-28c60eb40cf4@gmail.com> <4689477.1oUyQt6lIG@diego>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <573a45cc-5821-8731-e9c2-6b817482ac62@linaro.org>
Date:   Thu, 22 Apr 2021 21:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4689477.1oUyQt6lIG@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2021 20:20, Heiko Stübner wrote:
> Hi,
> 
> Am Donnerstag, 22. April 2021, 00:12:45 CEST schrieb Johan Jonker:
>> On 4/21/21 11:56 PM, Ezequiel Garcia wrote:
>>> On Wed, 2021-04-21 at 23:25 +0200, Johan Jonker wrote:
>>>> On 4/21/21 11:06 PM, Ezequiel Garcia wrote:
>>>>> On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
>>>>>> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
>>>>>>> Add a new compatible for the thermal sensor device on RK3568 SoCs.
>>>>>>>
>>>>>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>>>> index 7f94669e9ebe..346e466c2006 100644
>>>>>>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>>>> @@ -9,6 +9,7 @@ Required properties:
>>>>>>>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
>>>>>>>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
>>>>>>>     "rockchip,rk3399-tsadc": found on RK3399 SoCs
>>>>>>
>>>>>>> +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
>>>>>>
>>>>>> This is still a text document.
>>>>>> rob+dt has now scripts that check for undocumented compatibility
>>>>>> strings, so first convert rockchip-thermal.txt to YAML and then add this
>>>>>> in a separated patch.
>>>>>>
>>>>>
>>>>> Is it a showstopper to convert devicetree bindings to YAML for driver submission?
>>>>
>>>> You now that hardware best, so try to fix the documents as well.
>>>
>>> Well, not really. I'm just forward porting the driver from downstream kernels,
>>> so we can support this new SoC. Not really a hardware _expert_ for all the
>>> devices I plan to be pushing.
>>>
>>>> The new norm is YAML, so aim for that.
>>>
>>> I am aware of that. In fact, at Collabora we encourage all the kernel
>>> developers to convert to YAML, if/when possible.
>>>
>>>> Try to submit a complete package of YAML, driver (and dts nodes) for review.
>>>
>>> The devicetree for RK3566 and RK3568 is under discussion, in fact it was submitted today.
>>> Rockhip is leading that, and doing a great job already :)
>>>
>>> Meanwhile, I'd like to merge the small drivers (thermal, pmic, dwmac, io-domains and so on),
>>> so they are ready when the devicetree lands.
>>>
>>
>>> Most if not all of these devices just need a new compatible string. It would really delay
>>> things if I aim to convert all those bindings docs to YAML first, so let's please avoid that...
>>> ... unless it's a new hard-rule that DT maintainers have agreed on.
>>
>> Every driver group has it's own delay time, so better do it right in one
>> run.
>> Mostly people tend to 'forget' documentation and then someone else has
>> to clean up the mess. So I propose that the person that submits a new
>> driver also fixes the documentation. The norm is now YAML, so this serie
>> has more work then other, so be it. Others can help you with it if you ask.
> 
> personally I feel this approach being a bit too strict.
> 
> While it is definitly cool to convert everything to a yaml base in a
> hopefully short time, being overly strict can also stiffle participation.

+1


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
