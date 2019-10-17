Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34FDB8CF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437323AbfJQVJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 17:09:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44430 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbfJQVJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 17:09:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id q12so2981606lfc.11;
        Thu, 17 Oct 2019 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HOFkrgxD7hQMpORsHMPA1Bb0bytoS+eIDnRxl+dcGGk=;
        b=gEiSFnKkyv/kMZ8TrHPhHZnc/XrKI9vUmKfvTV9OWGEXXypvWYaLn5jBKlpzI08eqB
         R9RAJ+Yti5Egc8KxNcdaE6eNsOO4UumKxV/q4h8Mvs0x4aFeRVb9+CjOEzCX8pXNUh2T
         e/ThPX+i2DDzSfUDtnj/nNdH6s/RSbDc1hKw7grbhAGPk3tkHQPPgTs+QIFPnVklDwbL
         9RqoY7SXBaxLwVqFgN6s1kXluVn1brwvYl4qjSkIwfvj0/sTmRUrKFEyGfiwGU5/Gh6X
         SIl75AdQYUsXycefrN8D96kbQzfOs7zePICnYnkhyOmkVfate+Hg/f4vO2ZuTwfCeJwK
         /C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOFkrgxD7hQMpORsHMPA1Bb0bytoS+eIDnRxl+dcGGk=;
        b=Lwbu+WE0Fv2/VY1/g0quQG3GMmPgVLQI/Bm3AlpIXLJGpQCCSTbDY9gwSGAMAu1YUU
         zqUj3s3vvlnW+N9mrShSEQtZHqx5t0lu/rzS2EH7eN3IDd18M/QVhg3tPhfqyOYpNXp1
         fzxqz3IzrKjIdgNRiPpVE1k26/aEx8ZNHxLS2b4RGBKmquwYXQ1tJG1CUlSxpBTjLynC
         h7YODdyw735uo39Jy634zzpP3rjqNo1YZ6aE9EXXtQKpFWYYmeYlLJPWqgvcilRBTSj+
         6RF+8eH4cq0YsIxy+MDGXo85/RD5FRaNOl9OwtzxQ+SXe5nJ3MfubNEZRIsDw511wxhf
         GVZQ==
X-Gm-Message-State: APjAAAXK9B8M/08PPiOeiJz8teiBbFZqc2F30IPth9W5D6sr+N1ZQVJO
        4CNUWQxpB7tVxRu+rob/742jidgO
X-Google-Smtp-Source: APXvYqxHDXj6BpIX2gyGyIEnQLfJIrn7KaQ8V30SlJHDxzeh4kjvcoPZ4eJOQW3brVFR/iDnJPB2Xw==
X-Received: by 2002:a19:148:: with SMTP id 69mr3893055lfb.76.1571346577994;
        Thu, 17 Oct 2019 14:09:37 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id 25sm1872338lje.58.2019.10.17.14.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 14:09:37 -0700 (PDT)
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-8-digetx@gmail.com>
 <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7>
 <13a9ebd6-8dce-0217-d306-defb8eb6fb96@gmail.com>
 <CAMdYzYoasuEobJLC4RLW_5WCNGnaKtTth0xKov0tUQuDhkX3EA@mail.gmail.com>
 <b4eca03d-f86c-8e07-e04a-612e02820bd0@gmail.com>
 <20191017023210.x5vavl542hdkrivw@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4d6ba51-c2ac-4ddb-5acc-c4825aa6a793@gmail.com>
Date:   Fri, 18 Oct 2019 00:09:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017023210.x5vavl542hdkrivw@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.10.2019 05:32, Viresh Kumar пишет:
> On 16-10-19, 21:19, Dmitry Osipenko wrote:
>> 16.10.2019 17:58, Peter Geis пишет:
>>> On Wed, Oct 16, 2019 at 9:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 16.10.2019 08:18, Viresh Kumar пишет:
>>>>> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>>>>>> Re-parenting to intermediate clock is supported now by the clock driver
>>>>>> and thus there is no need in a customized CPUFreq driver, all that code
>>>>>> is common for both Tegra20 and Tegra30. The available CPU freqs are now
>>>>>> specified in device-tree in a form of OPPs, all users should update their
>>>>>> device-trees.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  drivers/cpufreq/Kconfig.arm          |   4 +-
>>>>>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>>>>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
>>>>>>  3 files changed, 55 insertions(+), 187 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>>>>> index a905796f7f85..2118c45d0acd 100644
>>>>>> --- a/drivers/cpufreq/Kconfig.arm
>>>>>> +++ b/drivers/cpufreq/Kconfig.arm
>>>>>> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
>>>>>>      default y
>>>>>>
>>>>>>  config ARM_TEGRA20_CPUFREQ
>>>>>> -    tristate "Tegra20 CPUFreq support"
>>>>>> -    depends on ARCH_TEGRA
>>>>>> +    bool "Tegra20 CPUFreq support"
>>>>>
>>>>> Google is currently working on the GKI (generic kernel image) project where they
>>>>> want to use a single kernel image with modules for all kind of android devices.
>>>>> And for that they need all such drivers to be built as module. Since this is
>>>>> already an module, I would ask you to keep it as is instead of moving it to bool
>>>>> here. Else some google guy will switch it back as module later on.
>>>>>
>>>>> LGTM otherwise. Nice work. Thanks.
>>>>>
>>>>
>>>> Okay, I'll keep the modularity in v2.
>>>>
>>>> Although, tegra20-cpufreq isn't a driver anymore because now it merely
>>>> prepares OPP table for the cpufreq-dt driver, which is really a one-shot
>>>> action that is enough to do during boot and thus modularity is a bit
>>>> redundant here.
>>>
>>> I doubt Google will care much, since Android has moved on to aarch64.
>>> Do they even support arm32 any more?
>>
>> Yes, I don't think there is a real need to care about Google. They won't
>> use pure upstream and won't care about older hardware any ways.
> 
> Well, using (almost) pure upstream is the idea I believe. And the thing is they
> want to use a single multi-platform image which should be as small as possible
> in size. So it won't have any drivers or platform stuff (if possible) and
> everything is module.
> 
> I am not sure about arm32/64 thing though. And it is okay if you don't want to
> care about Google right now. That was just some side knowledge I had :)
> 

I'll leave the module part as-is for now.
