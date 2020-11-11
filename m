Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6432AF315
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 15:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKKOIO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 09:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgKKOIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 09:08:11 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE4EC0613D1;
        Wed, 11 Nov 2020 06:08:11 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so2311518lfh.2;
        Wed, 11 Nov 2020 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LHvXV2kmqfCvFfKCOYzmtXPEAteV60xqIVKGiujdMpY=;
        b=U9cD5jlnZqzk6ZCMmI2ELj+L2+qxFbClK/3/2fRC5UhG+8kSOaSIhEDeImnrtZ442B
         4ehc0ZUi0WycwJd6FABCVOSUmCQIQJvaTRz3nTFEKZzMEy/GQVxE/teL37gy2EmbsnDY
         TLoaD4KbOM1SvFQdmTdpPhb1AJF21ZfAHLLQdLQmDZGXKVdKIqYkPN8kdsy0/rt0DCqi
         Ttv7PT+23g5FO7QLZPv8e8B5p/I38/sTTEFmOI9MddGrCIUJDDtc4x36pJ3XzktySr5F
         TSj8SkePimEGsCznB1AcTSHmkxBEabttgzce3OGZsGXN/v7vcmZTcyDNTmGVbnFaWRG1
         hIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHvXV2kmqfCvFfKCOYzmtXPEAteV60xqIVKGiujdMpY=;
        b=PKZd6GC1N/RAgnlmGVLiQnv6nPUNL7d2bptOm8gCUIHpumFA4384WcZ1GmbK+OHl9M
         5b+NXXkGPSSwCaGrusdyHDU/wWV0OjS3blzABHNbxP7VAVXjgr0n5vDekulU5aTdM1Ld
         mD/345TuY2G78oU0EcGu+4q8Eug3AmJ3Zmhm8EkeynSuUSqqr9VCmzQ7KhExbZc3PKJG
         K5c5sEVcUajDCvafgGLuUiiOyQ4kUjb16GR3ywFVWTzItSt3Pq/wtPXESoRIZWKZwCMN
         /RYWvoFpnFoChGxifqs9ZG+ZZYYcT04xMNBHYR/QMXXVdoTpk8FY4oPr4xvysBiB0Xj6
         ueow==
X-Gm-Message-State: AOAM532cce6rr6CIMYXAd3MsN6PASIgmlDGuTFMkYhEr3FJhQK9hMQz/
        DWkEFWCu7UzyVrHMcSQrRxA=
X-Google-Smtp-Source: ABdhPJyJuXZQ+wqXZ67sRla82+eaC3FA04CxCwIzaymyQabbK1aGONYj5LMmAEiiozxq/aRiBW7laA==
X-Received: by 2002:a19:6551:: with SMTP id c17mr5471726lfj.46.1605103689744;
        Wed, 11 Nov 2020 06:08:09 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id 136sm232266lfb.62.2020.11.11.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:08:08 -0800 (PST)
Subject: Re: [PATCH v8 09/26] memory: tegra30: Support interconnect framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-10-digetx@gmail.com>
 <20201111055313.tefidnmc7f4yb3jk@vireshk-i7>
 <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
 <20201111061855.2azilyhfoxwzpoir@vireshk-i7>
 <7f5c15c6-44d2-c997-442c-8f6670794f0e@gmail.com>
 <20201111075402.y52c2zwcw74eeyko@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <406ecffe-6df5-0fbf-b608-606372ed95dc@gmail.com>
Date:   Wed, 11 Nov 2020 17:08:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111075402.y52c2zwcw74eeyko@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 10:54, Viresh Kumar пишет:
> On 11-11-20, 10:32, Dmitry Osipenko wrote:
>> 11.11.2020 09:18, Viresh Kumar пишет:
>>> On 11-11-20, 09:14, Dmitry Osipenko wrote:
>>>> The dev_pm_opp_of_add_table() will produce a error message which doesn't
>>>> give a clue about what's wrong, i.e. that device-tree needs to be updated.
>>>
>>> If you think that you need to print something more, then you can do
>>> that in the error message you print when dev_pm_opp_of_add_table()
>>> fails. I would suggest to drop this redundant check here.
>>>
>>
>> Please give the rationale.
> 
> The rationale is that the check is already performed by
> dev_pm_opp_of_add_table() and it isn't going to add *any* benefit to
> check it again here. Such a check for matching compatible platforms is
> normally fine, but not for this. This is like open coding part of
> dev_pm_opp_of_add_table(), and so is redundant. The
> dev_pm_opp_of_add_table() helper also checks for OPPv1 bindings in the
> DT (yes you won't be using them on your platform) and so relying on
> that API is a better thing to do.
> 
> As you already said, you just wanted a better print message and so you
> have added this check. If you really care only about the print
> message, then you can add a print of your choice in the driver but
> otherwise this check is not going to benefit you much I am afraid.
> 
> Having said that, this isn't the code I maintain. I need to guarantee
> that the OPP core APIs are used properly and are not misused and so I
> have a higher say there. But in this case all I can do is _suggest_
> and not enforce. And as I said earlier, I suggest to drop this
> redundant check in order to make your code better and faster.
> 
> Thanks.
> 

I took a closer look and turned out that devm_pm_opp_of_add_table()
silently returns -ENODEV if OPP is missing in a DT. Hence indeed it
should be good to drop the property-check. I'll improve it in the next
revision, thank you.
