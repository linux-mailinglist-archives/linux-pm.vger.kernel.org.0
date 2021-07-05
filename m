Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7823BB541
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 04:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGECrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGECrs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 22:47:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB50C061574;
        Sun,  4 Jul 2021 19:45:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q18so29715970lfc.7;
        Sun, 04 Jul 2021 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1b03iNYtUO3lJGPzD9QJTiNDfhsMFcW/FQJnlPPMKtE=;
        b=BAJCMo9KkElTDLKwfqkwczKwTAeLLmnPWcfqm0c2ndKV7vzMg1T8PCWc3WywvCMH2i
         7NrFRlBbwEnqP0k1NfR8Gspqx0AQFouRA+2fQzZS7BgvnYakDisdHW5Q78oR4o60ZAul
         huwd4hlFFyluAs0vwl41e8nQIbaMTlSP96K+97iWKejGEKbkQLI/coLAaa7cJofbFtiL
         xj/RzD+Ljouvr4QtPk162DxRK0IIpKFNQpdt91JIL4KGUmoEwkJUL+CxcUD6Lt61B5Do
         jaHBQuXB8Ti2L3xQV/VOU+Kek6KlptgfIvmkuOd77UMmF2tsJ69O7CQ7fX6uNwr163ap
         NxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1b03iNYtUO3lJGPzD9QJTiNDfhsMFcW/FQJnlPPMKtE=;
        b=RvpOtAm/lj3BgvSz9/dlJm76AIUYR9xV00yQ8ktLrEmHw2XmlwRtvbWGl9IfI/lFFF
         se3zzvDtbh7LH0BzUjMbZGSViVZqGwGR65AXjzMnn8z/kx810Z32AN+YVWoNe/BnAWzX
         ZwRht37RDK7FMOtvq4RnG3bo2TTGxzNeOiLoPbdPwxfb02kg2vLnO8w/JAU4eZLByRm2
         br485iy4gbTqhZTyL4vNRHgUS1sE9JIHVODCBNLcTWYtEBYMuaXxvJj4/KXg173sOmaf
         htiESrbG/pxjSqZZkHeBJ53TIshgguqH7sNIqIVQUJEI3l30T3BIdKoHWkzguMfxu+Vj
         K9Iw==
X-Gm-Message-State: AOAM533/9JYPtlsRWyyFJeCq610lo/T9Z3JDk5ruE84jZTb1oGecbVEe
        URMOaNDJBuPhFByKrxlDHfBE0fQp6iI=
X-Google-Smtp-Source: ABdhPJznltVQBz3Am5K8cFOaC3l2uEAicQxyQfDc6gCCBIj5u/A/0/YKIHLYWbdN0lAuYYWPCtQIrw==
X-Received: by 2002:ac2:55a7:: with SMTP id y7mr8909626lfg.179.1625453109638;
        Sun, 04 Jul 2021 19:45:09 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id d12sm341293lfv.204.2021.07.04.19.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 19:45:09 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] usb: otg-fsm: Fix hrtimer list corruption
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210701234317.26393-1-digetx@gmail.com>
 <20210701234317.26393-6-digetx@gmail.com> <20210703110809.GA4289@Peter>
 <29476aa3-c34e-8bf0-5eab-f7def493f329@gmail.com>
 <20210705022151.GA12125@nchen>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2ce3feb7-eff8-867c-da7e-c3e44424cccb@gmail.com>
Date:   Mon, 5 Jul 2021 05:45:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705022151.GA12125@nchen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.07.2021 05:21, Peter Chen пишет:
> On 21-07-03 20:22:38, Dmitry Osipenko wrote:
>> 03.07.2021 14:08, Peter Chen пишет:
>>> On 21-07-02 02:43:10, Dmitry Osipenko wrote:
>>>> The HNP work can be re-scheduled while it's still in-fly. This results in
>>>> re-initialization of the busy work, resetting the hrtimer's list node of
>>>> the work and crashing kernel with null dereference within kernel/timer
>>>> once work's timer is expired. It's very easy to trigger this problem by
>>>> re-plugging USB cable quickly. Initialize HNP work only once to fix this
>>>> trouble.
>>>
>>> Fully OTG compliance support has not maintained for years, what's the use case you
>>> still want to use?
>>
>> I don't have any use case for it, but I had CONFIG_USB_OTG_FSM=y and it
>> was crashing kernel badly. The OTG works perfectly fine without the FSM.
> 
> You could add below at your dts to disable OTG FSM:
> hnp-disable
> srp-disable
> adp-disable
> 
> Since there are no users for OTG FSM, it hasn't maintained for years,
> I am not sure if it still works OK. If I remember correctly, the VBUS
> will be off if you enable HNP, and the device at the host port will be
> disconnected, that's may not your expectation.
> 

Since OTG FSM is known to be in a bad shape, could you please make a
patch to remove it? I hope it's not enabled by default in a distro
kernels.. oh no, CONFIG_USB_OTG_FSM=y at least in ArchLinux [1].

[1] https://archlinuxarm.org/packages/armv7h/linux-armv7/files/config

I think we should fix that hrtimer bug, beackport the fix into stable
kernels and then remove OTG FSM. Does this sound good to you?
