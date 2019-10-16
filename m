Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D846D9904
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389331AbfJPSTo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 14:19:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbfJPSTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 14:19:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so25048057lja.1;
        Wed, 16 Oct 2019 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wPowFu6H3nOXwpA2SAGf8+Ty4xoSESLjQljnj6+VTvY=;
        b=PRiX8SNuyKlCxJxEtvTHgnt3YZN5FzALlfYjrf3LzguNTrX6Hx1Bc6k3/r7hM84h60
         swXGAi7Wefb/K+/7reCOQ313MhBK/vYVjvJjbVPWC4nVvcVu7/+E+KO5sbgSnI9hZvoN
         CxSYNmtOJ4b0zTRj9j0Cx/dM66UBF3O5+BhnwXNePiUk+Q77zSovIU8q2L+h+oJrI3hb
         rhj9lGNCpUYmfWXLPZXW/ppFQg4B/rIWR/hNU+C7+hwcDOcZfIHvzquehGGG2zKH7BDC
         CDxhmzjrZn86xruVmB5e9JAg3Poz1R4ukjgcZ4aAoWJcNTc0z+F2J5Ky2z14dyol0Koz
         ppbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wPowFu6H3nOXwpA2SAGf8+Ty4xoSESLjQljnj6+VTvY=;
        b=FUWvTUIJLC6RnnJCj74Furh0UozixeocIB3I1VstObuzs8oPQQfyda/74nLuctj46Q
         vepFQmQi46pPW4wi+owFmtXUwTfAQSvtoW8BRKYreoOvWsVi1gAPn9uisF5WS9YbnNSM
         yfE96u9z8O6ykyPFKDOqXpKKlyzOH67hMwYG9+rdi9YB54NbWXXkLQr1L2rY7cbIiImO
         Bjm8i3xDpgauGw6ntGiaAWWe4oI7UG+k7JMbgVuHZtSPWPmR7t3HPo9Ys6R5YkhTWwzp
         uPw+r+A8EQOqqExSMQ19vZmg/SA2ez+H0K2Ht9YqUxOI77sI5hqju4DHfVyJGSnKLeAf
         8uXQ==
X-Gm-Message-State: APjAAAWOqD6VX/JQmB9WPd9ZXs52AiS8RDgVpD7NA2xwS8Kfx1b7iHSU
        LaPcLAnQn5uXs+/2CkpPe7bL8tq4
X-Google-Smtp-Source: APXvYqxoJ/NW8A7QBs/GSZGE2wRbJU36T6N4cFKKZYlqR1WkN283xHFFSDChw09XU4/z7SP1mxVjfA==
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr23834443ljk.235.1571249980609;
        Wed, 16 Oct 2019 11:19:40 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id x25sm6846332ljb.60.2019.10.16.11.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:19:39 -0700 (PDT)
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b4eca03d-f86c-8e07-e04a-612e02820bd0@gmail.com>
Date:   Wed, 16 Oct 2019 21:19:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYoasuEobJLC4RLW_5WCNGnaKtTth0xKov0tUQuDhkX3EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 17:58, Peter Geis пишет:
> On Wed, Oct 16, 2019 at 9:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 16.10.2019 08:18, Viresh Kumar пишет:
>>> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>>>> Re-parenting to intermediate clock is supported now by the clock driver
>>>> and thus there is no need in a customized CPUFreq driver, all that code
>>>> is common for both Tegra20 and Tegra30. The available CPU freqs are now
>>>> specified in device-tree in a form of OPPs, all users should update their
>>>> device-trees.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/cpufreq/Kconfig.arm          |   4 +-
>>>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>>>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
>>>>  3 files changed, 55 insertions(+), 187 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>>> index a905796f7f85..2118c45d0acd 100644
>>>> --- a/drivers/cpufreq/Kconfig.arm
>>>> +++ b/drivers/cpufreq/Kconfig.arm
>>>> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
>>>>      default y
>>>>
>>>>  config ARM_TEGRA20_CPUFREQ
>>>> -    tristate "Tegra20 CPUFreq support"
>>>> -    depends on ARCH_TEGRA
>>>> +    bool "Tegra20 CPUFreq support"
>>>
>>> Google is currently working on the GKI (generic kernel image) project where they
>>> want to use a single kernel image with modules for all kind of android devices.
>>> And for that they need all such drivers to be built as module. Since this is
>>> already an module, I would ask you to keep it as is instead of moving it to bool
>>> here. Else some google guy will switch it back as module later on.
>>>
>>> LGTM otherwise. Nice work. Thanks.
>>>
>>
>> Okay, I'll keep the modularity in v2.
>>
>> Although, tegra20-cpufreq isn't a driver anymore because now it merely
>> prepares OPP table for the cpufreq-dt driver, which is really a one-shot
>> action that is enough to do during boot and thus modularity is a bit
>> redundant here.
> 
> I doubt Google will care much, since Android has moved on to aarch64.
> Do they even support arm32 any more?

Yes, I don't think there is a real need to care about Google. They won't
use pure upstream and won't care about older hardware any ways.
