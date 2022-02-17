Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5354B9CB8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiBQKKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 05:10:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiBQKKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 05:10:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD362AAB01
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 02:10:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so5790597wml.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HZ3xx7nOObpTBizjK9Ap+q6jN7YiR6tkSPh0F4AEvbk=;
        b=B4LzfsYd6UtfWmB4hzFJeBBZNHrYCODNkBeV7muYuBP71kZZtn49U3I5zip102+u41
         oOv1IvlE26JcXr0+//taSTg+ag48U2kj0FyZt9/wnipEyez08m/0qVS2/zYo7wzofueZ
         EedbCJSrTHDwQnkSpEmWhG0QjryuO3sVaAAK/oiy/rTUhsz3/VatR/OgVbEGn2C8B9Z1
         ln5pX7Kjh5CyJgGRrmVm6x/xNCBNnydkE44w3dOptSP2SBsdxuqrE/WAUwqN+2dJSfFC
         +//fG4+fHFDSPsU5qe2gqses07Tkpcnne/A4E+Y6NLjCw7OYQtKGlWCMrq4E04RFv6vE
         AyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HZ3xx7nOObpTBizjK9Ap+q6jN7YiR6tkSPh0F4AEvbk=;
        b=I9NX9aiHh6H8O6sQYQv27osmed28rhQ6xWcsRHPh+SWrKQqm+8D/pPMZINJSQbto0W
         iUGU/6SOjAvuF7kqKJmST4pJltUJuuuqQSXwyKkm7lp529Waf2rlOhBp/6OruxG6ICEx
         5ONV1wspRjhvUa47G7lMTzrc1n7q4SI6gyX7OR1UwtZqDYDaL8FBnmxgL23iP3X2gvZS
         RLgux85wLXGnhAtLW2jD/yvlpCvJhYIJJ1FIhnUJkA01zguRqTmvkL4vIEGa0/H+fz/1
         zB3rrcWbVKjddWM8gTdt+ld4g+VJFy5wHCum+hMoRHB9r32Vo+sigTXIukNcReOHa/wb
         K0IQ==
X-Gm-Message-State: AOAM531RE1wbWtBibBFq9+5PL09m4A8QuzT/OC7lVJ0uObjtr6izHTbi
        KdNlxLSuHNW7tpqSq5m5nGkbvA==
X-Google-Smtp-Source: ABdhPJxiEWRtJUXJQNHQW2Rh2mFrrdYXAobg2tct8ua7KeWK3BcwdMClUGRaNlGrRuqQEbIfifzdBA==
X-Received: by 2002:a05:600c:3503:b0:345:858e:cbe8 with SMTP id h3-20020a05600c350300b00345858ecbe8mr5333733wmq.73.1645092618930;
        Thu, 17 Feb 2022 02:10:18 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id f14sm885951wmq.3.2022.02.17.02.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:10:18 -0800 (PST)
Message-ID: <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
Date:   Thu, 17 Feb 2022 11:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/02/2022 18:33, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Matthias,
>>
>> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
>>> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
>>>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>>>>>
>>>>>>
>>
>> [snip]
>>
>>>>>> Could you point me to those devices please?
>>>>>
>>>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
>>>>>
>>>>> Though as per above they shouldn't be impacted by your change, since the
>>>>> CPUs always pretend to use milli-Watts.
>>>>>
>>>>> [skipped some questions/answers since sc7180 isn't actually impacted by
>>>>>     the change]
>>>>
>>>> Thank you Matthias. I will investigate your setup to get better
>>>> understanding.
>>>
>>> Thanks!
>>>
>>
>> I've checked those DT files and related code.
>> As you already said, this patch is safe for them.
>> So we can apply it IMO.
>>
>>
>> -------------Off-topic------------------
>> Not in $subject comments:
>>
>> AFAICS based on two files which define thermal zones:
>> sc7180-trogdor-homestar.dtsi
>> sc7180-trogdor-coachz.dtsi
>>
>> only the 'big' cores are used as cooling devices in the
>> 'skin_temp_thermal' - the CPU6 and CPU7.
>>
>> I assume you don't want to model at all the power usage
>> from the Little cluster (which is quite big: 6 CPUs), do you?
>> I can see that the Little CPUs have small dyn-power-coeff
>> ~30% of the big and lower max freq, but still might be worth
>> to add them to IPA. You might give them more 'weight', to
>> make sure they receive more power during power split.
>>
>> You also don't have GPU cooling device in that thermal zone.
>> Based on my experience if your GPU is a power hungry one,
>> e.g. 2-4Watts, you might get better results when you model
>> this 'hot' device (which impacts your temp sensor reported value).
> 
> I think the two boards you point at (homestar and coachz) are just the
> two that override the default defined in the SoC dtsi file. If you
> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
> map. You can also see the cooling maps for the littles.
> 
> I guess we don't have a `dynamic-power-coefficient` for the GPU,
> though? Seems like we should, but I haven't dug through all the code
> here...

The dynamic-power-coefficient is available for OPPs which includes 
CPUfreq and devfreq. As the GPU is managed by devfreq, setting the 
dynamic-power-coefficient makes the energy model available for it.

However, the OPPs must define the frequency and the voltage. That is the 
case for most platforms except on QCom platform.

That may not be specified as it uses a frequency index and the hardware 
does the voltage change in our back. The QCom cpufreq backend get the 
voltage table from a register (or whatever) and completes the voltage 
values for the OPPs, thus adding the information which is missing in the 
device tree. The energy model can then initializes itself and allows the 
usage of the Energy Aware Scheduler.

However this piece of code is missing for the GPU part.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
