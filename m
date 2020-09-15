Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF326AEFB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 22:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgIOU4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgIOU4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 16:56:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E64C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 13:55:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s12so4675663wrw.11
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zAm5FtYej3fN0qgFkVHOCUoqnYYlVIOwReqe/bnLjew=;
        b=ux1FtF1qW5zFw3PSOHPb7/BatW30OcPF30SSo6z63uGbGBF/WO7Db9YU6CIStlGma4
         ayLTovcaU2eCRI07GjxFAJ/V37h7Ru1hEsNo3LKt8+VKdIYKeSPF7EqrEKZyX/UxP+FT
         ObxoKTQgR4M+tlPSbzYXGI9TCwxXTYQGo0V/QtySDQMp375RmB0XV/Y4gTgvcgg0v9IQ
         jkNATqk7T/1LQyy/EP2jhlpvB6RuxUOPIXswXvEwsw5jX0yK3qcuqDNmSMsk2UU9WGRv
         Bp6iIcal6R8JzrbxWjjbcTw/JjQjngPP1+0v82zalsrUqxcctwI9e6TUipQc5xTmGQdg
         85Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAm5FtYej3fN0qgFkVHOCUoqnYYlVIOwReqe/bnLjew=;
        b=fkvCWVvMi0ob78WcyKooto2BODYHwwdceQRhqNEBHl1jFtlCM9e2Khc61qxwt9zVOJ
         g0GoN25SKvhvP3lIfIVNQ1lySNFINSeT6g0JA6dWT+ulxtZLjRUdT/RhCS4EcEh6IX/w
         /cbHfQ5Rhhk1/LfEdLJNHF0z2C+IPCTNsAgLUzkgU+ykCUjFiiMe0vo/I54aypwOgMgC
         /Bh4VzujgPkKNzwCMl71jCCRwzeTA3dW8BtZ/n6rNEWR+VgO69YZUwNbmR/raZxmuija
         93k1Pb/kpK/DKtqoiTn/u3P3SXBNcGhsdKqvlINJN4MPq6/zG9QQSeoGyAGXQyQgurFp
         PMfA==
X-Gm-Message-State: AOAM5307b61d8FiVLfvqxqDX1ed5T1R/nCmyjKd302VxREt1jIerzFVI
        VDjl6l1W2JOK/TtsSQjpwUaXxA==
X-Google-Smtp-Source: ABdhPJzHG0MoqMbY2qp9b7BVgr4wjyrUkoPxudbv82dLhZQ/6hff9NHcF9q5z3f70mj4bQZugzAPBQ==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr22275109wrw.281.1600203355264;
        Tue, 15 Sep 2020 13:55:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:75c3:cda5:890e:8e1b? ([2a01:e34:ed2f:f020:75c3:cda5:890e:8e1b])
        by smtp.googlemail.com with ESMTPSA id i83sm1322034wma.22.2020.09.15.13.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 13:55:54 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
Date:   Tue, 15 Sep 2020 22:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915175808.GB2771744@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2020 19:58, Matthias Kaehlcke wrote:
> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>> +Thermal folks
>>>
>>> Hi Rajendra,
>>>
>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>> Hi Rob,
>>>>
>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>> based on real power measurements?
>>>
>>> Relative values may work for scheduling decisions, but not for thermal
>>> management with the power allocator, at least not when CPU cooling devices
>>> are combined with others that specify their power consumption in absolute
>>> values. Such a configuration should be supported IMO.
>>
>> The energy model is used in the cpufreq cooling device and if the
>> sustainable power is consistent with the relative values then there is
>> no reason it shouldn't work.
> 
> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> GPU that specifies its power in mW?

Well, if a SoC vendor decides to mix the units, then there is nothing we
can do.

When specifying the power numbers available for the SoC, they could be
all scaled against the highest power number.

There are so many factors on the hardware, the firmware, the kernel and
the userspace sides having an impact on the energy efficiency, I don't
understand why SoC vendors are so shy to share the power numbers...



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
