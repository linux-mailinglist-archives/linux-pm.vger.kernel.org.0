Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E22423ABD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhJFJoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJFJoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 05:44:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E6C061753
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 02:42:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m22so7010282wrb.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZN2MGTKW8HS5ful8I8NJEsDZCFiU186A9rqdS7aIXn0=;
        b=aX4LKQ2mCR9pIs+VsiyRlRqklx+TafioQgirniEBfBI/JSeubXTaWEh4DKZetKSphI
         PRv4GV/N0oIuCsV06yFwB4BcQlv//CjyNMn2wqwEiyyFxQtyKN/GO6Ngv8zcxAQjwUxz
         hyE4pg1lpwPaM+e8IbsMXcP/xow0jHffxg+NhPZI/oO4fY62UfM2m8Iog0Alb3wwGh1s
         SJlSfSQQMysu72ZMxJCIuMsKsmwWY63sS4HH1/LlQ7bFC1QiOtT0lmuR4SUHBtRNkdLQ
         EbTb1jB8Tn8QLuUmnQiWC9y9pTnCeD/rL0e7ml+lEbIsQEWuyL2QnzyLWk+swY8D9vOc
         3moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZN2MGTKW8HS5ful8I8NJEsDZCFiU186A9rqdS7aIXn0=;
        b=s0kbQ7H8wQR5x4XrUBHIsip4hbMkJ7EJEQM5DMjamqYzkqVcPHSIwJdk2LCVH5ROG4
         DBtcqhM6h4wgUApyZXahdiTmB6VkrvBNYUvF6ztjf2w2ozXZ4AozaxtVOUdpNCM5SDVz
         o+OYRZcoGiWZ434/bMV09/gHO7mtZF+fki7JUKag305n7NZyAz83I22neO9gPajb5MfX
         PxIJ9DlvwQh6pJwJODZH4OU4K+tUo3PojXytLMD47mn7fpaoHF8gv+UxSyQiIq2Q7giU
         0k8kilgnflfDGPJwd/yeT3CYYGoG8p5Z2UlNzU28Q1yxixrhOwwW9wV6UFn/n95EcHc1
         vYCw==
X-Gm-Message-State: AOAM5316q2DxYilruY37MfHgl8S6RpWivG2WtiFnng1zQkXA8Z/ZF3Ik
        +CpIJdXVGxN1roUDpxPY06tbyVYnR2i6Ww==
X-Google-Smtp-Source: ABdhPJxXQJc1Bdq+Nu4tptxWSt8BkN3eyd1QmAMdLyZZu5Vl+ysI5y6ywWn3umjR7VmLyXBdmGXHvA==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr8656025wmq.97.1633513332280;
        Wed, 06 Oct 2021 02:42:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:278:1f59:2992:87fe? ([2a01:e34:ed2f:f020:278:1f59:2992:87fe])
        by smtp.googlemail.com with ESMTPSA id r205sm967005wma.3.2021.10.06.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 02:42:11 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
To:     Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20211004112550.27546-1-j-keerthy@ti.com>
 <20211004112550.27546-2-j-keerthy@ti.com>
 <1633436798.497006.3226792.nullmailer@robh.at.kernel.org>
 <CAL_JsqKLuE+RhH+T4UKecMhRjbm69rwA1a2+FjrnMPKUf13J6A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <edb3e75a-1092-7e90-40d0-225dd4d4764c@linaro.org>
Date:   Wed, 6 Oct 2021 11:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKLuE+RhH+T4UKecMhRjbm69rwA1a2+FjrnMPKUf13J6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Keerthy,

did you receive this answer ?


On 05/10/2021 15:05, Rob Herring wrote:
> On Tue, Oct 5, 2021 at 7:26 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, 04 Oct 2021 16:55:47 +0530, Keerthy wrote:
>>> Add VTM bindings documentation. In the Voltage Thermal
>>> Management Module(VTM), K3 J72XX supplies a voltage
>>> reference and a temperature sensor feature that are gathered in the band
>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>> gap provides current and voltage reference for its internal
>>> circuits and other analog IP blocks. The analog-to-digital
>>> converter (ADC) produces an output value that is proportional
>>> to the silicon temperature.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 58 +++++++++++++++++++
>>>  1 file changed, 58 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Woot, TI has blacklisted me:
> 
> The response from the remote server was:
> 553 Sorry, your email address has been blacklisted. Please contact
> Texas Instruments Inc to have yourself removed.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
