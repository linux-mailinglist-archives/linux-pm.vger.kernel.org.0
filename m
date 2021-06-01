Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB51D3979AD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhFASCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFASCh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 14:02:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4969C061574;
        Tue,  1 Jun 2021 11:00:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u22so529821ljh.7;
        Tue, 01 Jun 2021 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUZ6e3WukGa4/Dft64xoEcyXnfbX/2avn7g/0jYSyNY=;
        b=g6flVsONZnK/Fgt3JDdq2AZK3JeNsXCuPMV25DNHZA0YUIaskgYQy138/B3/JdIZFJ
         i51bwXd74rxyFMnSgLDVHakM0ZqX7140OMTfXoJE6mtP099QOH5krFGGBV3pTvUjUx8o
         OM3fgM1U8VqHdIiWjKJ2oInhHwMxxm4TWxZlA4A0iT9E0CYnH3UlwsvLFsX2VMWyvW5V
         gJsvEBtcUplpbooHcHCX4lM+WP8hdC867yhHBlzx6aer+VnbIz37k+bf2VnVPxHxmQgt
         tAwiBXGBzvszMsK/E4y4jEnNaN2SDUc4QuoS4mvRqF8YP8rluH0xiAWtYtCZQArQ1/H1
         NOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUZ6e3WukGa4/Dft64xoEcyXnfbX/2avn7g/0jYSyNY=;
        b=Z1a8Tr3U4VDcHwhNHTcydY6U/mWR+g+brOCi0ryuNWmYuP5j+RUwodgUcB7s+8f3Fq
         c+oRIg6YcPpbBW/r8AjKDvoW2eWu1tvsPmB2XEKDIvNLkb1A/Vxx1BimVCD1Lta5Gb2h
         yyAIB9V8Kw20i6husraINGxjTKDRgBuVxs4M6pYJZZ2Fq0JPrbBGmcYGgbk0jFIag8vK
         L8q9faJTsCEpBYRhUmvV22a7zqVIBkLsPv645RceNyjvy0Zyr4Jvo6Snk5RF5mz6H3ls
         PUV3i7Dlj/HXzQqlKPkzQWzWIQrkysPE42Iht3bqnJ0aKneNtvwH1qDJlfgqOeG4Hjx/
         h92Q==
X-Gm-Message-State: AOAM533NU+BpQUHmg9aaBvno26ZrmJnCbqI+rQdipjyxmu75D8h8ttWS
        fBWHY8jQ9hlO+ZsyWXv9RlH9NISsYY0=
X-Google-Smtp-Source: ABdhPJzJnUKk/j3J+WZluG6HjRJw1QmYgtAdoIqKhQsP3oETPDEz7h6vpaqZgO5ohDF6ln1AdVRlvA==
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr22299683ljk.123.1622570452138;
        Tue, 01 Jun 2021 11:00:52 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id a22sm1551718ljp.72.2021.06.01.11.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 11:00:51 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] NVIDIA Tegra memory and power management changes
 for 5.14
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210601023119.22044-1-digetx@gmail.com>
 <YLYZvFPyJFJgxI56@orome.fritz.box>
 <11206c96-9f56-ca6f-e5e3-658534356666@gmail.com>
 <YLZp8FlV4lcDnL23@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c624bc95-1369-b6ef-5c98-15988955937e@gmail.com>
Date:   Tue, 1 Jun 2021 21:00:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLZp8FlV4lcDnL23@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 20:10, Thierry Reding пишет:
> On Tue, Jun 01, 2021 at 06:51:33PM +0300, Dmitry Osipenko wrote:
>> 01.06.2021 14:27, Thierry Reding пишет:
>>> On Tue, Jun 01, 2021 at 05:31:05AM +0300, Dmitry Osipenko wrote:
>>>> This series:
>>>>
>>>>   1. Adds CPU/core voltage bump before system is rebooted.
>>>>   2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
>>>>      Tegra memory drivers to use it.
>>>>   3. Adds compile-testing support to the Tegra memory drivers.
>>>>   4. Adds Tegra SoC core power domain support.
>>>>
>>>> Changelog:
>>>>
>>>> v6: - Fixed another compile-test trouble reported for v5. I double checked
>>>>       the clk stubs this time and compiled them locally.
>>>
>>> Heh... I just fixed those locally on top of your v5. Let me see if I can
>>> roll back the changes and apply this new set instead.
>>
>> Thank you! You probably saw already that Ulf Hansson suggested to remove
>> the lockdep annotation for now from the core PD, I'll make a v7 with
>> this small change.
> 
> Can you perhaps post this change as a follow-up? That way I can just
> merge it into the corresponding branch, which may be easier than backing
> out all the changes spread over four branches and applying basically the
> same thing again.

Alright, I'll make a follow-up. Thank you.
