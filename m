Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0445CA3D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbhKXQot (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbhKXQos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 11:44:48 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22BFC06173E
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 08:41:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so5331355wrb.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GlIs+0Fl00MrHx12eQnM8ThlIZDB4DAAFY0KgD/6Kgc=;
        b=T3WJ+TQj23IEThTVCJC2Bb41QzXIsQxUhJCk/pOLGO73x/2OE/b2IaDOA+PTTLR//u
         AsKG20PGqT8f35ykndMIthtiMr8NjSuGkiVoUzTdGPpyUYmhiAwPnYIaoFu56rjz9dIt
         RFScGtYiNhDovNsG62L1JjR7Oun2K/rqznRmYeHrY8yFHQZhNxwMYJZJUJSU5aREueyn
         YKJ6samEJzhXDVsTR1uzuhUA0M5trPocDe1MD9ivjJkDP7pf418cKtdVB4rq76GIR42n
         v0g74ObzkscrKZk2tsFh54mRLN4NLTUhscek6kMjkDUlGKOtpanAPAw+vm7CwVxiXq8J
         xT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GlIs+0Fl00MrHx12eQnM8ThlIZDB4DAAFY0KgD/6Kgc=;
        b=JyucD7taEV/G94w9viq5f3mGYIKcmXoml9EnpCLfjvHzdBrgzArx19rQ0DsgbpAzSm
         hZRTUGYPY6PeChtY+mp+nQdLOVYr8t+XLvBqKBHrUBQGC8vOSnXmK85b+txqW7VOugi3
         GRZGOtfYLCxcc4iBuYDDELPyoZSDp8yPKK7aLuZvbNedLmvGNUZw5hbNKoDPUGnHhskq
         LHebxwDyPf5+A10F+BLKh/+vd0EkE0kmpxuPCddDFYjTGWh6ZVEw+eNKoxo6LSeUGvyx
         t1cku80uaWrl58QrC6YZJWV9qVZc2//RNOMoWj4B0jI7KkGEflUUjFamQpAeY0wZOrh6
         OxMA==
X-Gm-Message-State: AOAM531b2tnItZCzq+030hBMvvQKmWzDfMXVzSetNTV64jAMS2CcqsuV
        LRSYKbytJk2PDsF/HP4VaXZgLA==
X-Google-Smtp-Source: ABdhPJzJXmbREFsk0CW1REfVF5yqexRPGDtOPeHjmhBrc65DyykD6IBk29gmn1v12rRTswTXEVOJZA==
X-Received: by 2002:adf:f907:: with SMTP id b7mr21189353wrr.5.1637772097021;
        Wed, 24 Nov 2021 08:41:37 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4839:bd64:93f4:614f? ([2a01:e34:ed2f:f020:4839:bd64:93f4:614f])
        by smtp.googlemail.com with ESMTPSA id d1sm252782wrz.92.2021.11.24.08.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:41:36 -0800 (PST)
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add powerzones definition for
 rock960
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
 <20211124125506.2971069-2-daniel.lezcano@linaro.org>
 <bf994aa8-df18-22d0-e718-2c8b406a5cc8@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f2609d56-f014-3713-8f73-c7ca9c7cba60@linaro.org>
Date:   Wed, 24 Nov 2021 17:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bf994aa8-df18-22d0-e718-2c8b406a5cc8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/11/2021 14:49, Robin Murphy wrote:
> On 2021-11-24 12:55, Daniel Lezcano wrote:
>> Add the powerzones description. This first step introduces the big,
>> the little and the gpu as a powerzone place.
> 
> These look more like SoC-level properties than board-level ones - should
> they be in rk3399.dtsi?

Yes, it makes sense

If Heiko is fine with that I can add this description in the rk3399.dtsi
file

>> ---
>>   .../boot/dts/rockchip/rk3399-rock960.dts      | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
>> b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
>> index 1a23e8f3cdf6..83540bdb64cd 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
>> @@ -61,6 +61,51 @@ bt_active_led: led-6 {
>>           };
>>       };
>>   +    powerzones {
>> +
>> +        PKG_PZ: pkg {
>> +            #powerzone-cells = <0>;
>> +                        powerzone = <&SOC_PZ>;
>> +        };
>> +
>> +        SOC_PZ: soc {
>> +        };
>> +    };
>> +};
>> +
>> +&cpu_b0 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&cpu_b1 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&cpu_l0 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&cpu_l1 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&cpu_l2 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&cpu_l3 {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>> +};
>> +
>> +&gpu {
>> +    #powerzone-cells = <0>;
>> +    powerzone = <&PKG_PZ>;
>>   };
>>     &cpu_alert0 {
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
