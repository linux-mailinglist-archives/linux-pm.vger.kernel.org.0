Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04422352F9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 01:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDXJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 19:09:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFDXJd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 19:09:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so6136725ljh.7;
        Tue, 04 Jun 2019 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1IVLJHW+wse8iHPWZib5MduTyZalBml9Mx3YwjCNVs=;
        b=KGy78BX24O/XMl+lMRP9JBqMnq6XmuiNrRDHkmEvA2xCzdDsBfnIWOyBJQZDflqa6i
         +ZU8PD2saF2XEWqc8ZbbBG8Hd1uZhveYSWEaEA6EsyGyqT4rpjYjz6J5Us/PsmlzZF1B
         vgVDhmOCfUTO7OFKBe7k6lEysbAX/pkDWHaC03ZhiVeuzLQWF4LAEI6WQ/kh00gPtjT4
         xwwp8HN0u5/42fbp+4XldJwxRenD/JZxA1wBGkq5AINxnaKQNlpovOLchPQweijxYUW6
         bHBglUbeG4nnTYGUd0jqLUDiK2zBOkhynk4rvzsKJJGQFLp00jF2gv3xLydKKngAAEx/
         Bcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1IVLJHW+wse8iHPWZib5MduTyZalBml9Mx3YwjCNVs=;
        b=e/CfKvTJu5bGwGSPhy57UfEHW03KrZLXv3HYX4w0GD1ugVGH88JmRqm75vqy/zs9A6
         i0q3OUXAhmkqgJK/iwAhuDz0CISljcdgihbGFpxnL6V02wXtEThb0Y40xPJo0NKNIV8D
         7Ld3WeJuZFsPOjBDNavrah5JXtK93rdLX9yDCtcYi0KAhZ5pi1E6GDFE5dggiGHW2hAn
         NQTtYOVvkZFG4v+J9gejG5PU9FbZpMeAV6++y1gZPAr3YmJ0d1e+qXy2pC94BWocH/kX
         YyNbcVo2pXXC7w74n5Dn+jvi2cQqSAmN+XLkNlOu7gm9hTvpnr1ld11GF0fNAaqIr4eW
         E8tA==
X-Gm-Message-State: APjAAAX8NVy1XJaDe2RJFLRCylwOnaDbEH9lbhWlRuBVddn5OvGetBTo
        fNNYYR710tTpv0KBy38AWQMRrTH4
X-Google-Smtp-Source: APXvYqz8xeZOwD8lYb+7xMSDkOdRhGqp8EELx75Pgj+nLNKQ+tpKPZLbRcJ/8VXbhrpTTPQbAdRjdQ==
X-Received: by 2002:a2e:9a19:: with SMTP id o25mr6021245lji.63.1559689770661;
        Tue, 04 Jun 2019 16:09:30 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id o184sm3984501lfo.37.2019.06.04.16.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 16:09:29 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30
 support
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
 <20190501233815.32643-1-digetx@gmail.com>
 <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
 <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
 <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
 <683b343a-e64f-8345-ac44-10f5c00521bd@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5c2a7c32-a98c-3930-14ae-beb0241908d0@gmail.com>
Date:   Wed, 5 Jun 2019 02:09:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <683b343a-e64f-8345-ac44-10f5c00521bd@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 3:49, Chanwoo Choi пишет:
> On 19. 6. 4. 오전 1:52, Dmitry Osipenko wrote:
>> 03.05.2019 3:52, Dmitry Osipenko пишет:
>>> 03.05.2019 3:31, Chanwoo Choi пишет:
>>>> Hi Dmitry,
>>>>
>>>> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>>>>> Changelog:
>>>>>
>>>>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>>>>
>>>>>     - changed the driver removal order to match the probe exactly
>>>>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>>>>
>>>>>     Chanwoo, please also note that the clk patch that should fix
>>>>>     compilation problem that was reported the kbuild-test-robot is already
>>>>>     applied and available in the recent linux-next.
>>>>
>>>> I knew that Stephen picked up your path about clock.
>>>
>>> Hi Chanwoo,
>>>
>>> Okay, good. Thank you very much for reviewing this series! I assume it's
>>> too late now for v5.2, but it should be good to go for v5.3.
>>>
>>
>> Hello Chanwoo,
>>
>> Will be nice to see the patches in the linux-next before they'll hit mainline. We have tested that
>> everything works fine on a selective devices, but won't hurt to get some extra testing beforehand.
>> AFAIK, at least NVIDIA people are regularly testing -next on theirs dev boards. Please note that
>> this not very important, so don't bother if there is some hurdle with pushing to the tracking branch
>> for now. Also please let me know if you're expecting to see some ACK's on the patches, I'm sure
>> we'll be able to work out that with Thierry and Jon if necessary.
>>
>>
> 
> Hi Dmitry,
> I think that it is enough for applying to mainline branch.
> The devfreq.git is maintained by Myungjoo. He will be merged or
> reviewed if there are th remained review point.

Thank you very much!

> 
> Hi Myungjoo,
> I reviewed the Dmitry's patches from v1 to v4 patches.
> And then I tested them on my testing branch[1] for catching
> the build warning and error. In result, it is clean.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
> 
> Please review or apply these patches for v5.3.
> 

Hello Myungjoo,

I think this patchset should be completed now. Thierry has some extra
comments to the patches, but seems nothing critical so far and all the
concerns could be addressed in a follow-up series. Please let me know if
you're fine with this, I can re-spin v5 as well if necessary.
