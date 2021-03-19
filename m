Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C18341B72
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCSL2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCSL1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 07:27:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65584C061760
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 04:27:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t9so8727339wrn.11
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2VJaPR0cL5VhiRl/G98uxV1YtiqmA8CybmYYke4TwKI=;
        b=KMjl+VBJcDtflimUBJBK78KSATLmG9uVLVByHXgpxmc6DOcX9hQU34JCY/ldwGshcT
         YJBpLs8zmTWOM0KVKtpHzdbqO0FkI8qUn8TIsGSN5/ClfRslx2Ic6TGVQOe/0PsmmPsM
         VjCvD5nXEu6Sn2LrS9gwfr5aeNv9o0m3WHl9xCnSYzZakFOMzpyh3F8V1IyC3/+8KsRt
         J0A/qQF9Dv1SC1AoTfBA2y2nG779nkBXrz8bYGAdON3kaBZwmE85ezhIO+sm0blEs5HT
         M8fg90yUHbLVwaEM0CShvJN6qIpYfmAgqeK4eJwZSrLhuo3BLXt0pWSVKxHOCVLpVJ0Q
         +5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VJaPR0cL5VhiRl/G98uxV1YtiqmA8CybmYYke4TwKI=;
        b=Kjo4IYoSOeoOfaBaoMnkhsxAHvR2cfzeQ1DVvO5hHC2AF2q2wIbfQoFjpD86qvseMN
         NW8r+5QNC/M1fvdGi0QLixjTcoOhMxhelHj/vsdwTbHU6toiWS9mUPSKRE2L5Vnra5x3
         ti+VGgJNqNf4Xxjxv1i9x3MkwctN55gfrfvuI396/X2xIyIv5xqWi0WkWJyGwbntiO/H
         Td5n+PiJSiGmmKV2skoGkHPM5XscatBVpXBlivh4dFlMt1GVtV0dLeEiYawvOWyfppSu
         DU3/2Mat95J0SMhtc4xToC1x6Lph8xdzpKVdb9paohxdyKjDIeyMG83I7QoqeCRlcZGL
         IpYQ==
X-Gm-Message-State: AOAM531GEVFiAo4oOEWNQSev68gb+vnJLe+ZTVSIAIWyPg8+DboguuN1
        rnuCUV1sp9TFdy49nLpxm9yI+A==
X-Google-Smtp-Source: ABdhPJwIXBunKgGFPhv+gFeiV3dd3BaZbnDn4LZu4azzEckiqCYMC/J3ClDH1Q1xkf1o5KRlOVpwBA==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr3961013wrn.226.1616153265918;
        Fri, 19 Mar 2021 04:27:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60ac:4ae1:fb5b:5813? ([2a01:e34:ed2f:f020:60ac:4ae1:fb5b:5813])
        by smtp.googlemail.com with ESMTPSA id a14sm7272722wrn.5.2021.03.19.04.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 04:27:45 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sm8350: Add thermal zones and
 throttling support
To:     Robert Foss <robert.foss@linaro.org>, amitk@kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rui.zhang@intel.com, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>
References: <20210319104855.85075-1-robert.foss@linaro.org>
 <20210319104855.85075-2-robert.foss@linaro.org>
 <CAG3jFytSoTP1UDWAYR=rAdHLBr9rU49ZF1=F9rfqZptCBuJFTQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5fdd232b-6392-8684-2be2-6ff4375b7a8c@linaro.org>
Date:   Fri, 19 Mar 2021 12:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG3jFytSoTP1UDWAYR=rAdHLBr9rU49ZF1=F9rfqZptCBuJFTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/03/2021 12:24, Robert Foss wrote:
> On Fri, 19 Mar 2021 at 11:49, Robert Foss <robert.foss@linaro.org> wrote:
>>
>> sm8350 has 29 thermal sensors split across two tsens controllers. Add
>> the thermal zones to expose them and wireup the cpus to throttle their
>> frequencies on crossing passive temperature thresholds.
>>
>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>> ---

[ ... ]

>> +               };
>> +
>> +               // TODO: What is the NSP subsystem?
> 
> This comment should not have been included, will remove in v2

Please trim when replying to a large patch file.

[ ... ]

>> +                       trips {
>> +                               nspss1_alert0: trip-point0 {
>> +                                       temperature = <90000>;
>> +                                       hysteresis = <1000>;
>> +                                       type = "hot";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               // TODO: What is the NSP subsystem?
> 
> This comment should not have been included, will remove in v2

[ ... ]

>> +                       trips {
>> +                               nspss2_alert0: trip-point0 {
>> +                                       temperature = <90000>;
>> +                                       hysteresis = <1000>;
>> +                                       type = "hot";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               // TODO: What is the NSP subsystem?
> 
> This comment should not have been included, will remove in v2
> 

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
